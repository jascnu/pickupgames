<template>
  <div>

    <div class="row">
      <div class="col-12">
        <card type="chart">
          <template slot="header">
            <div class="row">
              <div class="col-sm-6" :class="isRTL ? 'text-right' : 'text-left'">
                <h2 class="card-title">Games</h2>
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
  import LineChart from '@/components/Charts/LineChart';
  import BarChart from '@/components/Charts/BarChart';
  import * as chartConfigs from '@/components/Charts/config';
  import TaskList from './Dashboard/TaskList';
  import UserTable from './Dashboard/UserTable';
  import config from '@/config';
  import Api from '../api';
  import Card from '../components/Cards/Card.vue';
  import GameListItem from '../components/GameListItem.vue';
  import { getJwtToken, getUserIdFromToken, getusername } from "../auth";

  export default {
    components: {
      LineChart,
      BarChart,
      TaskList,
      UserTable,
      Card
    },
    data() {
        GameListItem
      return {
        gamesListPage: {
          games: [],
          createdGames: [],
          activeIndex: 0
        },
        purpleLineChart: {
          extraOptions: chartConfigs.purpleChartOptions,
          chartData: {
            labels: ['JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'],
            datasets: [{
              label: "Data",
              fill: true,
              borderColor: config.colors.primary,
              borderWidth: 2,
              borderDash: [],
              borderDashOffset: 0.0,
              pointBackgroundColor: config.colors.primary,
              pointBorderColor: 'rgba(255,255,255,0)',
              pointHoverBackgroundColor: config.colors.primary,
              pointBorderWidth: 20,
              pointHoverRadius: 4,
              pointHoverBorderWidth: 15,
              pointRadius: 4,
              data: [80, 100, 70, 80, 120, 80],
            }]
          },
          gradientColors: config.colors.primaryGradient,
          gradientStops: [1, 0.2, 0],
        },
        greenLineChart: {
          extraOptions: chartConfigs.greenChartOptions,
          chartData: {
            labels: ['JUL', 'AUG', 'SEP', 'OCT', 'NOV'],
            datasets: [{
              label: "My First dataset",
              fill: true,
              borderColor: config.colors.danger,
              borderWidth: 2,
              borderDash: [],
              borderDashOffset: 0.0,
              pointBackgroundColor: config.colors.danger,
              pointBorderColor: 'rgba(255,255,255,0)',
              pointHoverBackgroundColor: config.colors.danger,
              pointBorderWidth: 20,
              pointHoverRadius: 4,
              pointHoverBorderWidth: 15,
              pointRadius: 4,
              data: [90, 27, 60, 12, 80],
            }]
          },
          gradientColors: ['rgba(66,134,121,0.15)', 'rgba(66,134,121,0.0)', 'rgba(66,134,121,0)'],
          gradientStops: [1, 0.4, 0],
        },
        blueBarChart: {
          extraOptions: chartConfigs.barChartOptions,
          chartData: {
            labels: ['USA', 'GER', 'AUS', 'UK', 'RO', 'BR'],
            datasets: [{
              label: "Countries",
              fill: true,
              borderColor: config.colors.info,
              borderWidth: 2,
              borderDash: [],
              borderDashOffset: 0.0,
              data: [53, 20, 10, 80, 100, 45],
            }]
          },
          gradientColors: config.colors.primaryGradient,
          gradientStops: [1, 0.4, 0],
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
		removeItem(index) {
			//Not the best
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
        let vm = this;
       if (index === 0) {
         Api.getGameListDetailed()
          .then((res) => {
            console.log(res.data[0]);
           res.data.forEach(element => {
             if (!vm.gamesListPage.games.find(obj => obj.gameid === element.gameid)) {
               vm.gamesListPage.games.push(element);
             }
           });
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
           res.data.forEach(element => {
             if (!vm.gamesListPage.createdGames.find(obj => obj.gameid === element.gameid)) {
               vm.gamesListPage.createdGames.push(element);
             }
           });
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
