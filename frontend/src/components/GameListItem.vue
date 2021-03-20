<template>
  <card style="color: hsla(0,0%,100%,.7)!important;">
    <div class="title-container">
      <h4 slot="header" class="title">{{ item.title }}</h4>
      <span class="view-game-details"
        ><i
          ><base-button type="default" @click="modalVisible = true"
            >view details</base-button
          ></i
        ></span
      >
    </div>
    
    <div class="game-list-item">
      <span class="game-text-item">
        {{ item.owner }}
      </span>
      <span class="game-text-item">
        {{ item.sport }}
      </span>
      <span class="game-text-item">
        {{ item.level }}
      </span>
      <span class="game-text-item">
        {{ item.datetime | convertToStandardTime }}
      </span>
      <span class="game-text-item">
        {{ item.address }}
      </span>
      <span class="game-text-item">
        {{ item.playersjoined }}
        /{{ item.playersrequired }} players
      </span>
      <span class="game-text-item">
        <base-button
          :loading="loading"
          :disabled="loading"
          type="primary"
          @click="toggleJoin"
        >
          {{ isJoined | getJoinButtonText }}
        </base-button>
      </span>
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
          <div>
            <b>{{ item.title }}</b>
          </div>
          <div class="game-list-item">
            <span class="game-text-item">
              {{ item.owner }}
            </span>
            <span class="game-text-item">
              {{ item.sport }}
            </span>
            <span class="game-text-item">
              {{ item.level }}
            </span>
            <span class="game-text-item">
              {{ item.datetime | convertToStandardTime }}
            </span>
            <span class="game-text-item">
              {{ item.address }}
            </span>
            <span class="game-text-item">
              {{ item.playersjoined }}
              /{{ item.playersrequired }} players
            </span>
            <span class="game-text-item">
              {{ item.description }}
            </span>
          </div>
          <div><b>Attendees:</b></div>
          <div class="attendee-list">
            <li v-for="attendee in item.attendees" :key="attendee">
              {{ attendee }}
            </li>
          </div>
        </div>

        <div class="modal-footer">
          <base-button type="default" @click="modalVisible = false"
            >Close</base-button
          >
		  <base-button v-if="isOwned()" type="danger" @click="deleteGame"
            >Delete</base-button
          >
          <base-button
            :loading="loading"
            :disabled="loading"
            type="primary"
            @click="toggleJoin"
          >
            {{ isJoined | getJoinButtonText }}
          </base-button>
          <!--TODO if user owns game show delete button -->
        </div>
      </card>
    </modal>
  </card>
  
</template>
<script>
import BaseButton from "./BaseButton.vue";
import Modal from "@/components/Modal";
import Card from "./Cards/Card.vue";
import { getusername } from '../auth';
import api from '../api';
export default {
  components: {
    BaseButton,
    Modal,
    Card
  },
  name: "game-list-item",
  data() {
    return {
      loading: false,
      //TODO actually set accurately (could be an attribute on item instead so leaving filter above)
      isJoined: false,
	  modalVisible: false,
	
    };
  },
  props: {
    item: Object
  },
  filters: {
    convertToStandardTime: function(value) {
      return new Date(value).toLocaleString();
    },
    getJoinButtonText: function(value) {
      return value ? "Unjoin" : "Join";
    }
  },
  methods: {
    toggleJoin() {
      console.log("Toggling join on " + this.item.gameid);
	  //TODO implement join call
	  this.isJoined = !this.isJoined;
	},
	isOwned() {
		return this.item.owner === getusername() ? true : false;
	},
	deleteGame() {
		api.deleteGame(this.item.gameid).then((res) => {
			//TODO remove game from the list somehow, and notify user
			console.log("Successfully deleted game")
		}).catch((error) => {
			console.log(error);
			console.log(error.response.data)
		})
	}
  }
};
</script>
<style scoped>
.title-container {
  display: flex;
  justify-content: space-between;
}
.title {
  padding-top: 0px;
  margin: 0px;
}
.game-list-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-left: 15px;
  flex-wrap: wrap;
}
.game-text-item {
  text-align: center;
  padding: 5px 5px 5px 5px;
}
.view-game-details button {
  font-size: 12px;
  padding: 5px;
}
</style>
