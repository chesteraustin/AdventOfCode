<cfsavecontent variable = "var.myDirections">
L1, L3, L5, L3, R1, L4, L5, R1, R3, L5, R1, L3, L2, L3, R2, R2, L3, L3, R1, L2, R1, L3, L2, R4, R2, L5, R4, L5, R4, L2, R3, L2, R4, R1, L5, L4, R1, L2, R3, R1, R2, L4, R1, L2, R3, L2, L3, R5, L192, R4, L5, R4, L1, R4, L4, R2, L5, R45, L2, L5, R4, R5, L3, R5, R77, R2, R5, L5, R1, R4, L4, L4, R2, L4, L1, R191, R1, L1, L2, L2, L4, L3, R1, L3, R1, R5, R3, L1, L4, L2, L3, L1, L1, R5, L4, R1, L3, R1, L2, R1, R4, R5, L4, L2, R4, R5, L1, L2, R3, L4, R2, R2, R3, L2, L3, L5, R3, R1, L4, L3, R4, R2, R2, R2, R1, L4, R4, R1, R2, R1, L2, L2, R4, L1, L2, R3, L3, L5, L4, R4, L3, L1, L5, L3, L5, R5, L5, L4, L2, R1, L2, L4, L2, L4, L1, R4, R4, R5, R1, L4, R2, L4, L2, L4, R2, L4, L1, L2, R1, R4, R3, R2, R2, R5, L1, L2	
</cfsavecontent>
<!---
<cfsavecontent variable = "var.myDirections">
L1, L3, L5, L3, R1, L4, L5, R1, R3
</cfsavecontent>
--->
<style>
table, th, td {
    border: 1px solid black;
}
#coord_0_0 {
	background-color: red;
}
.colorMe {
	background-color: green;
}
.endPosition {
	background-color: blue;
}
</style>
<cfoutput>
<table>
	<cfset width = 75>
	<cfloop from="1" to="#width*2#" index="rows">
	<cfif rows lte width>
		<cfset position["y"] = width - rows>
	<cfelse>
		<cfset position["y"] = -(rows - width)>
	</cfif>
	<tr>
		<cfloop from="1" to="#width*2#" index="columns">
		<cfif columns lte width>
			<cfset position["x"] = columns - width>
		<cfelse>
			<cfset position["x"] = -(width - columns)>
		</cfif>
		<cfif position["x"] lt 0>
			<cfset position["x"] = "neg"&abs(position["x"])>
		</cfif>
		<cfif position["y"] lt 0>
			<cfset position["y"] = "neg"&abs(position["y"])>
		</cfif>
		<cfset thisCoord = "coord_"&position["x"]&"_"&position["y"]>
		<td id="#thisCoord#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</cfloop>
	</tr>
	</cfloop>
</table>
</cfoutput>
<cfflush>

<cfset var.myDirections_array = listToArray(var.myDirections, ", ")>

<cfset var.currentPosition["x"] = "0">
<cfset var.currentPosition["y"] = "0">
<cfset var.currentPosition["Direction"] = "North">
<cfset var.counter = 1>

<cfoutput>
<ol>
	<cfloop array="#var.myDirections_array#" index="direction">
		<cfif var.counter mod 2 eq 1>
			<!---If directions are ODD, the you're facing either NORTH or SOUTH --->
			<cfif var.currentPosition["Direction"] eq "North">
				<!---We're going WEST --->
				<cfif left(trim(direction), 1) eq "L">
					<cfset var.currentPosition["x"] = var.currentPosition["x"] - right(trim(direction), 1)>
					<cfset var.currentPosition["Direction"] = "West">
				<cfelse>
					<cfset var.currentPosition["x"] = var.currentPosition["x"] + right(trim(direction), 1)>
					<cfset var.currentPosition["Direction"] = "East">
				</cfif>
			<cfelseif var.currentPosition["Direction"] eq "South">
				<!---We're going EAST --->
				<cfif left(trim(direction), 1) eq "L">
					<cfset var.currentPosition["x"] = var.currentPosition["x"] + right(trim(direction), 1)>
					<cfset var.currentPosition["Direction"] = "East">
				<cfelse>
					<cfset var.currentPosition["x"] = var.currentPosition["x"] - right(trim(direction), 1)>
					<cfset var.currentPosition["Direction"] = "West">
				</cfif>
			</cfif>
		<li>#direction# - ODD - [#var.currentPosition["x"]#,#var.currentPosition["y"]#] - Facing #var.currentPosition["Direction"]#</li>
		<cfelse>
			<!---If directions are EVEN, the you're facing either EAST or WEST --->
			<cfif var.currentPosition["Direction"] eq "East">
				<cfif left(trim(direction), 1) eq "L">
				<!---We're going NORTH --->
					<cfset var.currentPosition["y"] = var.currentPosition["y"] + right(trim(direction), 1)>
					<cfset var.currentPosition["Direction"] = "North">
				<cfelse>
					<cfset var.currentPosition["y"] = var.currentPosition["y"] - right(trim(direction), 1)>
					<cfset var.currentPosition["Direction"] = "South">
				</cfif>
			<cfelseif var.currentPosition["Direction"] eq "West">
				<!---We're going SOUTH --->
				<cfif left(trim(direction), 1) eq "L">
					<cfset var.currentPosition["y"] = var.currentPosition["y"] - right(trim(direction), 1)>
					<cfset var.currentPosition["Direction"] = "South">
				<cfelseif var.currentPosition["Direction"] eq "West">
					<cfset var.currentPosition["y"] = var.currentPosition["y"] + right(trim(direction), 1)>
					<cfset var.currentPosition["Direction"] = "North">
				</cfif>
			</cfif>
		<li>#direction# - EVEN - [#var.currentPosition["x"]#,#var.currentPosition["y"]#] - Facing #var.currentPosition["Direction"]#</li>
		</cfif>
		<cfif var.currentPosition["x"] lt 0>
			<cfset var.writePosition["x"] = "neg"&abs(var.currentPosition["x"])>
		<cfelse>
			<cfset var.writePosition["x"] = var.currentPosition["x"]>
		</cfif>
		<cfif var.currentPosition["y"] lt 0>
			<cfset var.writePosition["y"] = "neg"&abs(var.currentPosition["y"])>
		<cfelse>
			<cfset var.writePosition["y"] = var.currentPosition["y"]>
		</cfif>
		<script language="Javascript"> 
			coord_#var.writePosition["x"]#_#var.writePosition["y"]#.innerHTML='#var.counter#';
			coord_#var.writePosition["x"]#_#var.writePosition["y"]#.className='colorMe';
		</script>
		<cfset var.counter++>
	</cfloop>
</ol>
<script language="Javascript"> 
	coord_#var.writePosition["x"]#_#var.writePosition["y"]#.className='endPosition';
</script>

</cfoutput>