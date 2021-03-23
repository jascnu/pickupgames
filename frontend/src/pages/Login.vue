<template>
	<card>
		<h5 slot="header" class="title">Login</h5>
		<base-input label="Email"
				v-model="email"
				placeholder="Email">
		</base-input>
		<base-input type="password" label="Password"
				v-model="password"
				placeholder="Password">
		</base-input>
	<base-button :loading="loading" :disabled="loading" slot="footer" type="primary" @click="login" fill>Login</base-button>
	</card>
</template>

<script>

import Api from "../api";
import { setJwtToken, getUserIdFromToken } from "../auth";
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
			Api.getProfileInfo(getUserIdFromToken(res.data[0].token))
			.then(prof => {
				setJwtToken(res.data[0].token, prof.data[0].username);
				if (this.$route.params.nextUrl != null) {
					this.$router.push(this.$route.params.nextUrl);
				} else {
					this.$router.push("/dashboard");
          }
			})
        })
        .catch((error) => {
        //   console.log(error);
          if (error.response && error.response.status === 403) {
            //this.message = error.response.data.message;
			// console.log("Failed to Login");
          }
          this.loading = false;
        });
      }
    }
}
</script>
