<template>
	<card>
		<h5 slot="header" class="title">{{item.title}}</h5>
		{{item.sport}}
		{{item.level}}
		{{item.datetime}}
		{{item.address}}
		{{item.owner}}
		{{item.playersjoined}}
		{{item.playersrequired}}
	</card>	
</template>
<script>
export default {
	name: "game-list-item",
	props: {
		item: Object
	}
}
</script>