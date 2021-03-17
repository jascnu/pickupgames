<template>
	<card style="color: hsla(0,0%,100%,.7)!important;">
		<h4 slot="header" class="title">{{item.title}}</h4>
		<div class="game-list-item">
			<span>
				{{item.owner}}
			</span>
			<span>

				{{item.sport}}
			</span>
			<span>
				{{item.level}}
				
			</span>
			<span>
				{{item.datetime | convertToStandardTime}}
				
			</span>
			<span>
				{{item.address}}
				
			</span>
			<span>
				{{item.playersjoined}}
				/{{item.playersrequired}} players
					
			</span> 
			<span>
				<base-button :loading="loading" :disabled="loading" type="primary"  @click="toggleJoin">
					{{isJoined | getJoinButtonText}}
				</base-button>
			</span>
		</div>
	</card>	
</template>
<script>
import BaseButton from './BaseButton.vue';
export default {
  components: { BaseButton },
	name: "game-list-item",
	data() {
		return {

			loading: false,
			//TODO actually set accurately (could be an attribute on item instead so leaving filter above)
			isJoined: false
		}
	},
	props: {
		item: Object
	},
	filters: {
		convertToStandardTime: function (value) {
			return new Date(value).toLocaleString();			
		},
		getJoinButtonText: function (value) {
			return value ? "Unjoin" : "Join";
		}
	},
	methods: {
		toggleJoin() {
			console.log("Toggling join on " + this.item.gameid);
			//TODO implement join call
		}
	}
}

</script>
<style scoped>
	.title {
		padding-top: 0px;
		margin: 0px;
	}
	.game-list-item {
		display: flex; 
		justify-content: space-between;
		align-items: center; 
		padding-left: 15px;
	}
</style>