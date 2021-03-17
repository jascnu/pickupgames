<template>
	<card>
		<h5 slot="header" class="title">Login</h5>
		<base-input label="Email"
				v-model="email"
				placeholder="Email">
		</base-input>
		<base-input label="Password"
				v-model="password"
				placeholder="Password">
		</base-input>
	<base-button :loading="loading" :disabled="loading" slot="footer" type="primary" @click="login" fill>Login</base-button>
	</card>
</template>

<script>

import Api from "../api";
import { setJwtToken } from "../auth";
export default {
	data() {
		return {
			email: "",
			password: "",
			loading: false
		};
	},
	methods: {
      login() {
	   this.loading = true;
		Api.login(this.email, this.password)
        .then((res) => {
          setJwtToken(res.data[0].token);
          if (this.$route.params.nextUrl != null) {
            this.$router.push(this.$route.params.nextUrl);
          } else {
            this.$router.push("/profile");
          }
        })
        .catch((error) => {
          console.log(error);
          if (error.response && error.response.status === 403) {
            //this.message = error.response.data.message;
			console.log("Failed to Login");
          }
          this.loading = false;
        });
      }
    }
}
</script>
<style scoped>
	.sidebar {
		display: none;
	}
</style>