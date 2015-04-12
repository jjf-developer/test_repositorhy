
<cfquery name = "getinfo" datasource="hwcftest">
	select * from users order by datesubmitted desc
</cfquery>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>User Registration Report</title>
	<link rel="stylesheet" href="js/jquery-ui.css">
	<link rel="stylesheet" href="js/jquery-ui.structure.css">
	<link rel="stylesheet" href="js/jquery-ui.theme.css">
	<script src="js/external/jquery/jquery.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/external/jquery.validate.js"></script>
	<script src="js/external/additional-methods.js"></script>
</head>
<style>
	td, th {padding:4px;}
	tr:nth-child(even) {background-color:#FFF;}
	tr:nth-child(odd) {background-color:#B0E0E6;}
	#headcolor {
		background-color: cornflowerblue;
		color:#FFF;
		text-align:left;
	}
	#userinfo {
		width:90%;
		margin:0 auto;
		border: solid 1px #4169E1;
	}
	tr td {border-bottom: solid 1px #4169E1;}
</style>

<body>

<div class = "mastercontainer">
		<table cellpadding="0" cellspacing="0" border="0" class="display"  id="userinfo">
			<thead>
				<tr id = "headcolor">
					<th>First Name</th>
					<th>Last Name</th>
					<th>Address1</th>
					<th>Address2</th>
					<th>City</th>
					<th>State</th>
					<th>Zip</th>
					<th>Country</th>
					<th>Date</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="getinfo">
				<tr>
					<cfoutput>
					<td>#getinfo.firstname#</td>
					<td>#getinfo.lastname#</td>
					<td>#getinfo.address1#</td>
					<td>#getinfo.address2#</td>
					<td>#getinfo.city#</td>
					<td>#getinfo.state#</td>
					<td>#getinfo.zip#</td>
					<td>#getinfo.country#</td>
					<td>#dateformat(getinfo.datesubmitted,"YYYY-MM-DD")#<br>#timeformat(getinfo.datesubmitted,"HH:mm:ss")#</td>
					</cfoutput>
				</tr>
				</cfloop>
			</tbody>
			<!--- <tfoot>
				<tr>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Address1</th>
					<th>Address2</th>
					<th>City</th>
					<th>State</th>
					<th>Zip</th>
					<th>Country</th>
					<th>Date</th>
				</tr>
			</tfoot> --->
		</table>

</div>
</body>
</html>
