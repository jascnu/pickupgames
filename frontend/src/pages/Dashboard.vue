<template>
  <div>

    <div class="row">
      <div class="col-12">
        <card type="chart">
          <template slot="header">
            <div class="row">
              <div class="col-sm-2" :class="isRTL ? 'text-right' : 'text-left'">
                <h2 class="card-title">Games</h2>
              </div>
              <div class="col-sm-4">
                <div class="card-title">
                  <base-button type="default" @click="modalVisible = true">Filters</base-button>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="btn-group btn-group-toggle"
                     :class="isRTL ? 'float-left' : 'float-right'"
                     data-toggle="buttons">
                  <label v-for="(option, index) in bigLineChartCategories"
                         :key="option"
                         class="btn btn-sm btn-primary btn-simple"
                         :class="{active: gamesListPage.activeIndex === index}"
                         :id="index">
                    <input type="radio"
                           @click="showGames(index)"
                           name="options" autocomplete="off"
                           :checked="gamesListPage.activeIndex === index">
                    {{option}}
                  </label>
                </div>
              </div>
            </div>
          </template>
        </card>
      </div>
    </div>
    <modal
      :show.sync="modalVisible"
      class="modal-game-details"
      body-classes="p-0"
      modal-classes="modal-dialog modal-dialog-centered"
    >
      <card
        type="primary"
        header-classes="bg-white pb-5"
        body-classes="px-lg-5 py-lg-5"
        class="border-0 mb-0"
      >
        <div>
          <div v-for="sport in sports" :key=sport.sportid>
            <input type="checkbox"
            v-bind:id="sport.sportid"
            v-bind:value=" sport.name"
            v-model="chosenSports"/>
              <label for=sport.sportid>
                {{sport.name}}
              </label>
          </div>
        </div>
        <div>
          <base-button type="default" @click="filteredView">Apply</base-button>
        </div>
      </card>
    </modal>
    <div v-if="gamesListPage.activeIndex === 0">
		  <game-list-item v-for="(game, index) in gamesListPage.games" :item=game :key=game.gameid :index=index />
    </div>
    <div v-else-if="gamesListPage.activeIndex === 1 && gamesListPage.createdGames.length > 0" >
      <game-list-item v-for="(game, index) in gamesListPage.createdGames" :item=game :key=game.gameid :index=index />
    </div>
    <label v-else style="text-align: center; width: 100%;" class="control-label">It looks like you haven't created any games!</label>
  </div>
</template>
<script>
  import Api from '../api';
  import Card from '../components/Cards/Card.vue';
  import GameListItem from '../components/GameListItem.vue';
  import Modal from "@/components/Modal";
  import { getJwtToken, getUserIdFromToken, getusername } from "../auth";

  export default {
    components: {
      Modal,
      Card
    },
    data() {
        GameListItem
      return {
        filters: "",
        sports: [],
        chosenSports: [],
        modalVisible: false,
        gamesListPage: {
          games: [],
          createdGames: [],
          activeIndex: 0
        }
      }
    },
    computed: {
      enableRTL() {
        return this.$route.query.enableRTL;
      },
      isRTL() {
        return this.$rtl.isRTL;
      },
      bigLineChartCategories() {
        return this.$t('dashboard.chartCategories');
      },
    },
    methods: {
    filteredView() {
      this.filters = "?sport=in.("
      this.chosenSports.forEach(element=> this.filters += "\"" + element + "\"" + ",");
      this.filters = this.filters.substring(0, this.filters.length -1);
      this.filters += ")";
      this.showGames(0);
      /*
      Api.getGameListDetailed(filters)
      .then((res) => {
          //console.log(res.data[0]);
          this.gamesListPage.games = res.data;
          this.showGames(0);
        })
        .catch((error) => {
          console.log(error);
          if (error.response && error.response.status === 403) {
            //this.message = error.response.data.message;
			console.log("Failed to get filtered games list");
          }
          this.loading = false;
        }); */
    },
    getSportsList() {
      Api.getSports()
        .then((res) => {
          console.log(res.data[0]);
          this.sports = res.data;
        })
        .catch((error) => {
          console.log(error);
          if (error.response && error.response.status === 403) {
            //this.message = error.response.data.message;
			console.log("Failed to get sports list");
          }
          this.loading = false;
        });
    },
		removeItem(index) {
			//Not the best, doesn't update other tab
			console.log('Removing Item at: ' + index)
			if (this.gamesListPage.activeIndex === 0) {
				console.log("removing from gamelist")
				this.gamesListPage.games.splice(index, 1);
			} else {
				console.log("removing from created gamelist")
				this.gamesListPage.createdGames.splice(index, 1);	
			}
		},

      showGames(index) {
        console.log(this.filters);
        let vm = this;
       if (index === 0) {
         Api.getGameListDetailed(this.filters)
          .then((res) => {
            console.log(res.data[0]);
           //res.data.forEach(element => {
           //  if (!vm.gamesListPage.games.find(obj => obj.gameid === element.gameid)) {
           //    vm.gamesListPage.games.push(element);
           //  }
           //});
           vm.gamesListPage.games = res.data;
          })
          .catch((error) => {
            console.log(error);
            if (error.response && error.response.status === 403) {
              //this.message = error.response.data.message;
              console.log("Failed to get games");
            }
            //this.loading = false;
          });
       } else if (index === 1) {
         Api.getGameByOwner(getusername())
          .then((res) => {
            console.log(res.data[0]);
           //res.data.forEach(element => {
           //  if (!vm.gamesListPage.createdGames.find(obj => obj.gameid === element.gameid)) {
           //    vm.gamesListPage.createdGames.push(element);
           //  }
           //});
           vm.gamesListPage.createdGames = res.data;
          })
          .catch((error) => {
            console.log(error);
            if (error.response && error.response.status === 403) {
              //this.message = error.response.data.message;
              console.log("Failed to get games");
            }
            //this.loading = false;
          });
       }
        // this.$refs.bigChart.updateGradients(chartData);
        // this.bigLineChart.chartData = chartData;
        this.gamesListPage.activeIndex = index;
      }
    },
    created() {
      // Api.getGameList()
      //   .then((res) => {
      //     console.log(res.data[0]);
      //     this.gamesListPage.games.push(...res.data);
      //   })
      //   .catch((error) => {
      //     console.log(error);
      //     if (error.response && error.response.status === 403) {
      //       //this.message = error.response.data.message;
			//       console.log("Failed to get games");
      //     }
      //     //this.loading = false;
      //   });
    },
    mounted() {
      this.i18n = this.$i18n;
      if (this.enableRTL) {
        this.i18n.locale = 'ar';
        this.$rtl.enableRTL();
      }
      this.showGames(0);
      this.getSportsList();
    },
    beforeDestroy() {
      if (this.$rtl.isRTL) {
        this.i18n.locale = 'en';
        this.$rtl.disableRTL();
      }
    }
  };
</script>
<style>
</style>
