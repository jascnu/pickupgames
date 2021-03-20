<template>
  <div class="row">
    <div class="col-md-8">
      <edit-profile-form :model="model">
      </edit-profile-form>
    </div>
    <div class="col-md-4">
      <user-card :user="user"></user-card>
    </div>
  </div>
</template>
<script>
  import EditProfileForm from './Profile/EditProfileForm';
  import UserCard from './Profile/UserCard';
  import Api from '../api';
  import { getJwtToken, getUserIdFromToken } from "../auth";
  export default {
    components: {
      EditProfileForm,
      UserCard
    },
    data() {
      return {
        returnedUserArray: [],
        model: {
          attendancescore: 'Not Set',
          email: 'Not Set',
          username: 'Not Set',
          firstname: 'Not Set',
          lastname: 'Not Set',
          zipcode: 'Not Set',
          description: 'Not Set'
        },
        user: {
          fullName: 'Not Set',
          title: 'Not Set',
          description: 'Not Set'
        }
      }
    },
    created() {
      Api.getProfileInfo(getUserIdFromToken(getJwtToken()))
        .then((res) => {
          console.log(res.data[0]);
          this.returnedUserArray.push(...res.data);
          this.model.attendancescore = this.returnedUserArray[0].attendancescore;
          this.model.description = this.returnedUserArray[0].description;
          this.model.firstname = this.returnedUserArray[0].firstname;
          this.model.lastname = this.returnedUserArray[0].lastname;
          this.model.username = this.returnedUserArray[0].username;
          this.model.email = this.returnedUserArray[0].email;
          //this.model.address = this.returnedUserArray[0].address;
          this.model.zipcode = this.returnedUserArray[0].zipcode;
          this.user.fullName = this.returnedUserArray[0].firstname + ' ' + this.returnedUserArray[0].lastname;
          this.user.title = this.returnedUserArray[0].rolename;
          this.user.description = this.returnedUserArray[0].description;
        })
        .catch((error) => {
          console.log(error);
          if (error.response && error.response.status === 403) {
            //this.message = error.response.data.message;
			      console.log("Failed to get user profile");
          }
          //this.loading = false;
        });
    }
  }
</script>
<style>
</style>
