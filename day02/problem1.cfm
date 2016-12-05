<cfsavecontent variable = "var.myDirections">
DUURRDRRURUUUDLRUDDLLLURULRRLDULDRDUULULLUUUDRDUDDURRULDRDDDUDDURLDLLDDRRURRUUUDDRUDDLLDDDURLRDDDULRDUDDRDRLRDUULDLDRDLUDDDLRDRLDLUUUDLRDLRUUUDDLUURRLLLUUUUDDLDRRDRDRLDRLUUDUDLDRUDDUDLLUUURUUDLULRDRULURURDLDLLDLLDUDLDRDULLDUDDURRDDLLRLLLLDLDRLDDUULRDRURUDRRRDDDUULRULDDLRLLLLRLLLLRLURRRLRLRDLULRRLDRULDRRLRURDDLDDRLRDLDRLULLRRUDUURRULLLRLRLRRUDLRDDLLRRUDUDUURRRDRDLDRUDLDRDLUUULDLRLLDRULRULLRLRDRRLRLULLRURUULRLLRRRDRLULUDDUUULDULDUDDDUDLRLLRDRDLUDLRLRRDDDURUUUDULDLDDLDRDDDLURLDRLDURUDRURDDDDDDULLDLDLU
LURLRUURDDLDDDLDDLULRLUUUDRDUUDDUDLDLDDLLUDURDRDRULULLRLDDUDRRDRUDLRLDDDURDUURLUURRLLDRURDRLDURUDLRLLDDLLRDRRLURLRRUULLLDRLULURULRRDLLLDLDLRDRRURUUUDUDRUULDLUDLURLRDRRLDRUDRUDURLDLDDRUULDURDUURLLUDRUUUUUURRLRULUDRDUDRLLDUDUDUULURUURURULLUUURDRLDDRLUURDLRULDRRRRLRULRDLURRUULURDRRLDLRUURUDRRRDRURRLDDURLUDLDRRLDRLLLLRDUDLULUDRLLLDULUDUULLULLRLURURURDRRDRUURDULRDDLRULLLLLLDLLURLRLLRDLLRLUDLRUDDRLLLDDUDRLDLRLDUDU
RRDDLDLRRUULRDLLURLRURDLUURLLLUUDDULLDRURDUDRLRDRDDUUUULDLUDDLRDULDDRDDDDDLRRDDDRUULDLUDUDRRLUUDDRUDLUUDUDLUDURDURDLLLLDUUUUURUUURDURUUUUDDURULLDDLDLDLULUDRULULULLLDRLRRLLDLURULRDLULRLDRRLDDLULDDRDDRURLDLUULULRDRDRDRRLLLURLLDUUUDRRUUURDLLLRUUDDDULRDRRUUDDUUUDLRRURUDDLUDDDUDLRUDRRDLLLURRRURDRLLULDUULLURRULDLURRUURURRLRDULRLULUDUULRRULLLDDDDURLRRRDUDULLRRDURUURUUULUDLDULLUURDRDRRDURDLUDLULRULRLLURULDRUURRRRDUDULLLLLRRLRUDDUDLLURLRDDLLDLLLDDUDDDDRDURRL
LLRURUDUULRURRUDURRDLUUUDDDDURUUDLLDLRULRUUDUURRLRRUDLLUDLDURURRDDLLRUDDUDLDUUDDLUUULUUURRURDDLUDDLULRRRUURLDLURDULULRULRLDUDLLLLDLLLLRLDLRLDLUULLDDLDRRRURDDRRDURUURLRLRDUDLLURRLDUULDRURDRRURDDDDUUUDDRDLLDDUDURDLUUDRLRDUDLLDDDDDRRDRDUULDDLLDLRUDULLRRLLDUDRRLRURRRRLRDUDDRRDDUUUDLULLRRRDDRUUUDUUURUULUDURUDLDRDRLDLRLLRLRDRDRULRURLDDULRURLRLDUURLDDLUDRLRUDDURLUDLLULDLDDULDUDDDUDRLRDRUUURDUULLDULUUULLLDLRULDULUDLRRURDLULUDUDLDDRDRUUULDLRURLRUURDLULUDLULLRD
UURUDRRDDLRRRLULLDDDRRLDUDLRRULUUDULLDUDURRDLDRRRDLRDUUUDRDRRLLDULRLUDUUULRULULRUDURDRDDLDRULULULLDURULDRUDDDURLLDUDUUUULRUULURDDDUUUURDLDUUURUDDLDRDLLUDDDDULRDLRUDRLRUDDURDLDRLLLLRLULRDDUDLLDRURDDUDRRLRRDLDDUDRRLDLUURLRLLRRRDRLRLLLLLLURULUURRDDRRLRLRUURDLULRUUDRRRLRLRULLLLUDRULLRDDRDDLDLDRRRURLURDDURRLUDDULRRDULRURRRURLUURDDDUDLDUURRRLUDUULULURLRDDRULDLRLLUULRLLRLUUURUUDUURULRRRUULUULRULDDURLDRRULLRDURRDDDLLUDLDRRRRUULDDD
</cfsavecontent>
<cfset var.lineBreaks = chr(10)&chr(13)>
<!---
<cfsavecontent variable = "var.myDirections">
ULL
RRDDD
LURDL
UUUUD
</cfsavecontent>
--->

<cfset var.directions_array = listToArray(var.myDirections, var.lineBreaks)>
<cfset var.currentPosition["x"] = 1>
<cfset var.currentPosition["y"] = -1>
<cfset var.currentPosition["name"] = 5>
<cfset i = 1>

<cfloop array="#var.directions_array#" index="var.thisRow">
	<cfset var.theDirection = listToArray(var.thisRow, "")>
	<cfloop array="#var.theDirection#" index="var.direction">
		<cfset var.newPosition = movePosition(var.direction)>
	</cfloop>
	<cfset var.finalPosition[i] = var.currentPosition["x"] & ", " & var.currentPosition["y"]>
	<cfset var.thisNumber[i] = getCoord(var.currentPosition["x"], var.currentPosition["y"])>
	<cfset i++>
</cfloop>
<cfoutput>
<p>The PIN is: <cfloop from="1" to="#structCount(var.thisNumber)#" index="thisNumber">#trim(var.thisNumber[thisNumber])#</cfloop></p>
</cfoutput>
<cffunction name="movePosition">
	<cfargument name="position">
	<cfif arguments.position eq "L" or arguments.position eq "R">
		<!---We're changing the X axis --->
		<cfif arguments.position eq "L">
			<cfif var.currentPosition["x"] eq 0>
				<cfset var.currentPosition["x"] = 0>
			<cfelse>
				<cfset var.currentPosition["x"] = var.currentPosition["x"] - 1>
			</cfif>
		<cfelseif arguments.position eq "R">
			<cfif var.currentPosition["x"] eq 2>
				<cfset var.currentPosition["x"] = 2>
			<cfelse>
				<cfset var.currentPosition["x"] = var.currentPosition["x"] + 1>
			</cfif>
		</cfif>
	<cfelseif arguments.position eq "U" or arguments.position eq "D">
		<!---We're changing the Y axis --->
		<cfif arguments.position eq "U">
			<cfif var.currentPosition["y"] eq 0>
				<cfset var.currentPosition["y"] = 0>
			<cfelse>
				<cfset var.currentPosition["y"] = var.currentPosition["y"] + 1>
			</cfif>
		<cfelseif arguments.position eq "D">
			<cfif var.currentPosition["y"] eq -2>
				<cfset var.currentPosition["y"] = -2>
			<cfelse>
				<cfset var.currentPosition["y"] = var.currentPosition["y"] - 1>
			</cfif>
		</cfif>
	</cfif>
</cffunction>

<cffunction name="getCoord">
	<cfargument name="xPos">
	<cfargument name="yPos">
	<cfdump var="#arguments#">
	<cfswitch expression="#arguments.yPos#">
		<!---First Row [1, 2, 3] --->
		<cfcase value="0">
			<cfswitch expression="#arguments.xPos#">
				<cfcase value="0">
					<cfset positionNumber = 1>
				</cfcase>
				<cfcase value="1">
					<cfset positionNumber = 2>
				</cfcase>
				<cfcase value="2">
					<cfset positionNumber = 3>
				</cfcase>
			</cfswitch>
		</cfcase>
		<cfcase value="-1">
		<!---Second Row [4, 5, 6] --->
			<cfswitch expression="#arguments.xPos#">
				<cfcase value="0">
					<cfset positionNumber = 4>
				</cfcase>
				<cfcase value="1">
					<cfset positionNumber = 5>
				</cfcase>
				<cfcase value="2">
					<cfset positionNumber = 6>
				</cfcase>
			</cfswitch>
		</cfcase>
		<cfcase value="-2">
		<!---Third Row [7, 8, 9] --->
			<cfswitch expression="#arguments.xPos#">
				<cfcase value="0">
					<cfset positionNumber = 7>
				</cfcase>
				<cfcase value="1">
					<cfset positionNumber = 8>
				</cfcase>
				<cfcase value="2">
					<cfset positionNumber = 9>
				</cfcase>
			</cfswitch>
		</cfcase>
	</cfswitch>

	<cfreturn positionNumber>
</cffunction>
