<cfset actiontodo = "showform">
<cfset messagetoshow = "">
<cfset defaultfirstname = "">
<cfset defaultlastname = "">
<cfset defaultaddress1 = "">
<cfset defaultaddress2 = "">
<cfset defaultcity = "">
<cfset defaultstate = "">
<cfset defaultcountry = "">
<cfset defaultzip = "">

<cfif isdefined("form.submit")>
	<cfif form.firstname eq ""><cfset messagetoshow = messagetoshow & "<br><strong>First name</strong> must not be blank."></cfif>
	<cfif form.lastname eq ""><cfset messagetoshow = messagetoshow & "<br><strong>Last name</strong> must not be blank."></cfif>
	<cfif form.address1 eq ""><cfset messagetoshow = messagetoshow & "<br><strong>Address line 1</strong> must not be blank."></cfif>
	<cfif form.city eq ""><cfset messagetoshow = messagetoshow & "<br><strong>City</strong> must not be blank."></cfif>
	<cfif form.state eq ""><cfset messagetoshow = messagetoshow & "<br><strong>State</strong> must not be blank."></cfif>
	<cfif form.country neq "US"><cfset messagetoshow = messagetoshow & "<br><strong>Country</strong> must be selected."></cfif>
	<cfset form.zip = trim(form.zip)>
	<cfset form.zip = replace("#form.zip#"," ","-","all")>
	<cfset ziptest = replace("#form.zip#","-","","all")>
	<cfif (len(ziptest) neq 5) and (len(ziptest) neq 9)>
		<cfset messagetoshow = messagetoshow & "<br><strong>Zipcode</strong> must have a length of 5 digits or 9 digits (separated by a dash).">
	</cfif>
	<cfif NOT iSValid("integer",ziptest)>
		<cfset messagetoshow = messagetoshow & "<br><strong>Zipcode</strong> must only consist of digits.">
	</cfif>
	<cfset nowtime = dateformat(now(),"yyyy-mm-dd") & " " & timeformat(now(),"HH:mm:ss")>
	<cfif messagetoshow eq "">
		<cfquery datasource="hwcftest" name= "add_to_db">
			insert into users
			set firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.firstname#" maxlength="200">
			,lastname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lastname#" maxlength="200">
			,address1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.address1#" maxlength="200">
			,address2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.address2#" maxlength="200">
			,city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.city#" maxlength="200">
			,state = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.state#" maxlength="2">
			,country = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.country#" maxlength="10">
			,zip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.zip#" maxlength="10">
			,datesubmitted = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#nowtime#">
		</cfquery>

		<cflocation url="confirmation.cfm" addtoken="false">
	<cfelse>
		<cfset defaultfirstname = "#form.firstname#">
		<cfset defaultlastname = "#form.lastname#">
		<cfset defaultaddress1 = "#form.address1#">
		<cfset defaultaddress2 = "#form.address2#">
		<cfset defaultcity = "#form.city#">
		<cfset defaultstate = "#form.state#">
		<cfset defaultcountry = "#form.country#">
		<cfset defaultzip = "#form.zip#">
		<cfset actiontodo = "correctform">
	</cfif>
</cfif>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>User Registration</title>
	<link rel="stylesheet" href="js/jquery-ui.css">
	<link rel="stylesheet" href="js/jquery-ui.structure.css">
	<link rel="stylesheet" href="js/jquery-ui.theme.css">
	<script src="js/external/jquery/jquery.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/external/jquery.validate.js"></script>
	<script src="js/external/additional-methods.js"></script>

  <style>
	.mastercontainer {
		width:75%;
		margin: 0 auto;
	}
	font-size: 1em;
	fieldset div {
	  margin-bottom: 2em;
	}
	fieldset .help {
	  display: inline-block;
	}
	.ui-tooltip {
	  width: 400px;
	}
	.ui-widget {
		font-size: .9em;
	}
	fieldset div {
		line-height:2em;
	}
	fieldset div label {
	  display: inline-block; width: 8em;
	}
	#Buttondiv {
		display:inline-block;
		height:50px;
	}
   .formcontainer {
		display:inline-block;
		width:60%;
	}
   .messagecontainer{
		display:inline-block;
		width:38%;
		vertical-align:top;
		padding-left:5px;
		font-size: .9em;
	}
  </style>
</head>
<body>
<div class = "mastercontainer">
	<div class="formcontainer">
		<form action = "test.cfm" method = "post"  id="signupForm">
		  <cfoutput>
		  <fieldset>
		    <div>
		      <label for="firstname">Firstname</label>
		      <input id="firstname" name="firstname" title="Please provide your firstname." value = "#defaultfirstname#" maxlength="200">
		    </div>
		    <div>
		      <label for="lastname">Lastname</label>
		      <input id="lastname" name="lastname" title="Please provide also your lastname." value = "#defaultlastname#" maxlength="200">
		    </div>
		    <div>
		      <label for="address1">Address Line 1</label>
		      <input id="address1" name="address1" title="Your home or work address, first line." value = "#defaultaddress1#" maxlength="200">
		    </div>
		    <div>
		      <label for="address2">Address Line 2</label>
		      <input id="address2" name="address2" title="Your home or work address, second line." value = "#defaultaddress2#" maxlength="200">
		    </div>
		     <div>
		      <label for="city">City</label>
		      <input id="city" name="city" title="Your home or work city." value = "#defaultcity#" maxlength="200">
		    </div>
		     <div>
		      <label for="state">State</label>
				<select  id="state" name="state" title="Your home or work state.">
					<option value="" <cfif defaultstate eq ""> selected </cfif>>-- Choose state --</option>
					<option value="AL" <cfif defaultstate eq "AL"> selected </cfif> >Alabama</option>
					<option value="AK" <cfif defaultstate eq "AK"> selected </cfif> >Alaska</option>
					<option value="AZ" <cfif defaultstate eq "AZ"> selected </cfif> >Arizona</option>
					<option value="AR" <cfif defaultstate eq "AR"> selected </cfif> >Arkansas</option>
					<option value="CA" <cfif defaultstate eq "CA"> selected </cfif> >California</option>
					<option value="CO" <cfif defaultstate eq "CO"> selected </cfif> >Colorado</option>
					<option value="CT" <cfif defaultstate eq "CT"> selected </cfif> >Connecticut</option>
					<option value="DE" <cfif defaultstate eq "DE"> selected </cfif> >Delaware</option>
					<option value="DC" <cfif defaultstate eq "DC"> selected </cfif> >District Of Columbia</option>
					<option value="FL" <cfif defaultstate eq "FL"> selected </cfif> >Florida</option>
					<option value="GA" <cfif defaultstate eq "GA"> selected </cfif> >Georgia</option>
					<option value="HI" <cfif defaultstate eq "HI"> selected </cfif> >Hawaii</option>
					<option value="ID" <cfif defaultstate eq "ID"> selected </cfif> >Idaho</option>
					<option value="IL" <cfif defaultstate eq "IL"> selected </cfif> >Illinois</option>
					<option value="IN" <cfif defaultstate eq "IN"> selected </cfif> >Indiana</option>
					<option value="IA" <cfif defaultstate eq "IA"> selected </cfif> >Iowa</option>
					<option value="KS" <cfif defaultstate eq "KS"> selected </cfif> >Kansas</option>
					<option value="KY" <cfif defaultstate eq "KY"> selected </cfif> >Kentucky</option>
					<option value="LA" <cfif defaultstate eq "LA"> selected </cfif> >Louisiana</option>
					<option value="ME" <cfif defaultstate eq "ME"> selected </cfif> >Maine</option>
					<option value="MD" <cfif defaultstate eq "MD"> selected </cfif> >Maryland</option>
					<option value="MA" <cfif defaultstate eq "MA"> selected </cfif> >Massachusetts</option>
					<option value="MI" <cfif defaultstate eq "MI"> selected </cfif> >Michigan</option>
					<option value="MN" <cfif defaultstate eq "MN"> selected </cfif> >Minnesota</option>
					<option value="MS" <cfif defaultstate eq "MS"> selected </cfif> >Mississippi</option>
					<option value="MO" <cfif defaultstate eq "MO"> selected </cfif> >Missouri</option>
					<option value="MT" <cfif defaultstate eq "MT"> selected </cfif> >Montana</option>
					<option value="NE" <cfif defaultstate eq "NE"> selected </cfif> >Nebraska</option>
					<option value="NV" <cfif defaultstate eq "NV"> selected </cfif> >Nevada</option>
					<option value="NH" <cfif defaultstate eq "NH"> selected </cfif> >New Hampshire</option>
					<option value="NJ" <cfif defaultstate eq "NJ"> selected </cfif> >New Jersey</option>
					<option value="NM" <cfif defaultstate eq "NM"> selected </cfif> >New Mexico</option>
					<option value="NY" <cfif defaultstate eq "NY"> selected </cfif> >New York</option>
					<option value="NC" <cfif defaultstate eq "NC"> selected </cfif> >North Carolina</option>
					<option value="ND" <cfif defaultstate eq "ND"> selected </cfif> >North Dakota</option>
					<option value="OH" <cfif defaultstate eq "OH"> selected </cfif> >Ohio</option>
					<option value="OK" <cfif defaultstate eq "OK"> selected </cfif> >Oklahoma</option>
					<option value="OR" <cfif defaultstate eq "OR"> selected </cfif> >Oregon</option>
					<option value="PA" <cfif defaultstate eq "PA"> selected </cfif> >Pennsylvania</option>
					<option value="RI" <cfif defaultstate eq "RI"> selected </cfif> >Rhode Island</option>
					<option value="SC" <cfif defaultstate eq "SC"> selected </cfif> >South Carolina</option>
					<option value="SD" <cfif defaultstate eq "SD"> selected </cfif> >South Dakota</option>
					<option value="TN" <cfif defaultstate eq "TN"> selected </cfif> >Tennessee</option>
					<option value="TX" <cfif defaultstate eq "TX"> selected </cfif> >Texas</option>
					<option value="UT" <cfif defaultstate eq "UT"> selected </cfif> >Utah</option>
					<option value="VT" <cfif defaultstate eq "VT"> selected </cfif> >Vermont</option>
					<option value="VA" <cfif defaultstate eq "VA"> selected </cfif> >Virginia</option>
					<option value="WA" <cfif defaultstate eq "WA"> selected </cfif> >Washington</option>
					<option value="WV" <cfif defaultstate eq "WV"> selected </cfif> >West Virginia</option>
					<option value="WI" <cfif defaultstate eq "WI"> selected </cfif> >Wisconsin</option>
					<option value="WY" <cfif defaultstate eq "WY"> selected </cfif> >Wyoming</option>
				</select>
		    </div>
		     <div>
		      <label for="country">Country</label>
		      <select id = "country" name = "country" title="Your home or work country.">
					<option value="" <cfif defaultcountry eq ""> selected </cfif>>-- Choose Country --</option>
					<option value="US" <cfif defaultcountry eq "US"> selected </cfif> >US</option>
					<option value="other" <cfif defaultcountry eq "other"> selected </cfif> >Other</option>
				</select>
		    </div>
		     <div>
		      <label for="zip">Zipcode</label>
		      <input id="zip" name="zip" title="Your home or work zipcode." value = "#defaultzip#" maxlength="10">
		    </div>
		    <div id = "buttondiv">
			<button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only submit" type="submit" name = "submit" id = "submit">Submit</button>
		    </div>
		  </fieldset>
		  </cfoutput>
		</form>
	</div>
	<div class = "messagecontainer">
		<cfif actiontodo eq 'correctform'>
			<p>Please correct the following issues: <br>
				<cfoutput>#messagetoshow#</cfoutput>
			</p>
		</cfif>
	</div>
</div>
<script>
$(document).ready(function () {


	$("#country").change(function(){
		if ( $("#country").val() == "other") {
			$("#submit").remove();
			$("#buttondiv").text("Sorry, registration is only for individuals living in the United States.")
		}
	});

  $(function() {
    var tooltips = $( "[title]" ).tooltip({
      position: {
        my: "left top",
        at: "right+5 top-5"
      }
    });
  });

});

$.validator.setDefaults({
	submitHandler: function() {
		return true;
	},
	showErrors: function(map, list) {
		// there's probably a way to simplify this
		var focussed = document.activeElement;
		if (focussed && $(focussed).is("input, textarea")) {
			$(this.currentForm).tooltip("close", {
				currentTarget: focussed
			}, true)
		}
		this.currentElements.removeAttr("title").removeClass("ui-state-highlight");
		$.each(list, function(index, error) {
			$(error.element).attr("title", error.message).addClass("ui-state-highlight");
		});
		if (focussed && $(focussed).is("input, textarea")) {
			$(this.currentForm).tooltip("open", {
				target: focussed
			});
		}
	}
});

(function() {
	// validate signup form on keyup and submit
	$("#signupForm").validate({
		rules: {
			firstname: "required",
			lastname: "required",
			address1: "required",
			city: "required",
			state: "required",
			country: "required",
			zip: {
				required: true,
				minlength: 5,
				maxlength:10
				}
		},
		messages: {
			firstname: "Please enter your firstname",
			lastname: "Please enter your lastname",
			address1: "Please enter your address",
			city: "Please enter your city",
			state: "Please select your state",
			country: "Please enter your country",
			zip: {
				required: "Please provide a zipcode",
				minlength: "Your zipcode must be at least 5 digits long"
			}
		}
	});

	$(":submit").button();
})();
</script>

</body>
</html>

