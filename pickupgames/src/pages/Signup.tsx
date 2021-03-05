import React from "react";
import { Create, Edit, SimpleForm, TextInput, DateInput, ReferenceManyField, Datagrid, TextField, DateField, EditButton } from 'react-admin';
const Signup = (props:any) => {
	return (
		<Create {...props}>
			{console.log("HERE")}
			<SimpleForm>
				<TextInput source="title" />
				{/* <TextInput source="teaser" options={{ multiLine: true }} /> */}
				<DateInput label="Publication date" source="published_at" defaultValue={new Date()} />
			</SimpleForm>
		</Create>
	);
}

export default Signup;