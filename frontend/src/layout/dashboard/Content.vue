<template>
  <div v-if=isLoggedIn class="content">
    <fade-transition :duration="100" mode="out-in">
      <!-- your content here -->
      <router-view></router-view>
    </fade-transition>
  </div>
  <div v-else class="content no-auth">
    <fade-transition :duration="100" mode="out-in">
      <!-- your content here -->
      <router-view></router-view>
    </fade-transition>
  </div>
</template>
<script>
  import {FadeTransition} from 'vue2-transitions';
  export default {
    components: {
      FadeTransition
    },
    computed: {
    isLoggedIn() {
      return window.localStorage.getItem("username");
    }
    }
  };
</script>
