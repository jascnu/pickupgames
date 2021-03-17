<template>
	<card>
		<h5 slot="header" class="title">Sign Up</h5>
		<base-input label="Email"
				v-model="email"
				placeholder="Email">
		</base-input>
		<base-input label="Username"
				v-model="username"
				placeholder="Username">
		</base-input>
		<base-input type="password" label="Password"
				v-model="password"
				placeholder="Password">
		</base-input>
		<base-input label="First Name"
				v-model="firstname"
				placeholder="First Name">
		</base-input>
		<base-input label="Middle Name (Optional)"
				v-model="middlename"
				placeholder="Middle Name">
		</base-input>
		<base-input label="Last Name"
				v-model="lastname"
				placeholder="Last Name">
		</base-input>
		<base-input label="Zip (Optional)"
				v-model="zipcode"
				placeholder="Zip">
		</base-input>
	<base-button :loading="loading" :disabled="loading"  slot="footer" type="primary" @click="signup" fill> Signup </base-button>
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
			firstname: "",
			lastname: "",
			middlename: null,
			username: "",
			zipcode: null,
			loading: false
		};
	},
	methods: {
      signup() {

		this.loading = true;
		Api.signup(this.email, this.password, this.firstname, this.lastname, this.middlename, this.zipcode, this.username)
			.then(() => {
			this.$router.push("/login");
			})
			.catch((error) => {
			console.log(error);
			if (error.response) {
				//TODO display error
				console.log(error.response.data.message);
			}
			this.loading = false;
			});
	  }
        
    }
}
</script>
