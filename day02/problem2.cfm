<!---

<cfsavecontent variable = "var.myDirections">
DUURRDRRURUUUDLRUDDLLLURULRRLDULDRDUULULLUUUDRDUDDURRULDRDDDUDDURLDLLDDRRURRUUUDDRUDDLLDDDURLRDDDULRDUDDRDRLRDUULDLDRDLUDDDLRDRLDLUUUDLRDLRUUUDDLUURRLLLUUUUDDLDRRDRDRLDRLUUDUDLDRUDDUDLLUUURUUDLULRDRULURURDLDLLDLLDUDLDRDULLDUDDURRDDLLRLLLLDLDRLDDUULRDRURUDRRRDDDUULRULDDLRLLLLRLLLLRLURRRLRLRDLULRRLDRULDRRLRURDDLDDRLRDLDRLULLRRUDUURRULLLRLRLRRUDLRDDLLRRUDUDUURRRDRDLDRUDLDRDLUUULDLRLLDRULRULLRLRDRRLRLULLRURUULRLLRRRDRLULUDDUUULDULDUDDDUDLRLLRDRDLUDLRLRRDDDURUUUDULDLDDLDRDDDLURLDRLDURUDRURDDDDDDULLDLDLU
LURLRUURDDLDDDLDDLULRLUUUDRDUUDDUDLDLDDLLUDURDRDRULULLRLDDUDRRDRUDLRLDDDURDUURLUURRLLDRURDRLDURUDLRLLDDLLRDRRLURLRRUULLLDRLULURULRRDLLLDLDLRDRRURUUUDUDRUULDLUDLURLRDRRLDRUDRUDURLDLDDRUULDURDUURLLUDRUUUUUURRLRULUDRDUDRLLDUDUDUULURUURURULLUUURDRLDDRLUURDLRULDRRRRLRULRDLURRUULURDRRLDLRUURUDRRRDRURRLDDURLUDLDRRLDRLLLLRDUDLULUDRLLLDULUDUULLULLRLURURURDRRDRUURDULRDDLRULLLLLLDLLURLRLLRDLLRLUDLRUDDRLLLDDUDRLDLRLDUDU
RRDDLDLRRUULRDLLURLRURDLUURLLLUUDDULLDRURDUDRLRDRDDUUUULDLUDDLRDULDDRDDDDDLRRDDDRUULDLUDUDRRLUUDDRUDLUUDUDLUDURDURDLLLLDUUUUURUUURDURUUUUDDURULLDDLDLDLULUDRULULULLLDRLRRLLDLURULRDLULRLDRRLDDLULDDRDDRURLDLUULULRDRDRDRRLLLURLLDUUUDRRUUURDLLLRUUDDDULRDRRUUDDUUUDLRRURUDDLUDDDUDLRUDRRDLLLURRRURDRLLULDUULLURRULDLURRUURURRLRDULRLULUDUULRRULLLDDDDURLRRRDUDULLRRDURUURUUULUDLDULLUURDRDRRDURDLUDLULRULRLLURULDRUURRRRDUDULLLLLRRLRUDDUDLLURLRDDLLDLLLDDUDDDDRDURRL
LLRURUDUULRURRUDURRDLUUUDDDDURUUDLLDLRULRUUDUURRLRRUDLLUDLDURURRDDLLRUDDUDLDUUDDLUUULUUURRURDDLUDDLULRRRUURLDLURDULULRULRLDUDLLLLDLLLLRLDLRLDLUULLDDLDRRRURDDRRDURUURLRLRDUDLLURRLDUULDRURDRRURDDDDUUUDDRDLLDDUDURDLUUDRLRDUDLLDDDDDRRDRDUULDDLLDLRUDULLRRLLDUDRRLRURRRRLRDUDDRRDDUUUDLULLRRRDDRUUUDUUURUULUDURUDLDRDRLDLRLLRLRDRDRULRURLDDULRURLRLDUURLDDLUDRLRUDDURLUDLLULDLDDULDUDDDUDRLRDRUUURDUULLDULUUULLLDLRULDULUDLRRURDLULUDUDLDDRDRUUULDLRURLRUURDLULUDLULLRD
UURUDRRDDLRRRLULLDDDRRLDUDLRRULUUDULLDUDURRDLDRRRDLRDUUUDRDRRLLDULRLUDUUULRULULRUDURDRDDLDRULULULLDURULDRUDDDURLLDUDUUUULRUULURDDDUUUURDLDUUURUDDLDRDLLUDDDDULRDLRUDRLRUDDURDLDRLLLLRLULRDDUDLLDRURDDUDRRLRRDLDDUDRRLDLUURLRLLRRRDRLRLLLLLLURULUURRDDRRLRLRUURDLULRUUDRRRLRLRULLLLUDRULLRDDRDDLDLDRRRURLURDDURRLUDDULRRDULRURRRURLUURDDDUDLDUURRRLUDUULULURLRDDRULDLRLLUULRLLRLUUURUUDUURULRRRUULUULRULDDURLDRRULLRDURRDDDLLUDLDRRRRUULDDD
</cfsavecontent>
--->

<cfset var.lineBreaks = chr(10)&chr(13)>
<cfsavecontent variable = "var.myDirections">
ULL
RRDDD
LURDL
UUUUD
</cfsavecontent>

<cfset var.directions_array = listToArray(var.myDirections, var.lineBreaks)>
<cfset var.currentPosition["x"] = 0>
<cfset var.currentPosition["y"] = 0>
<cfset var.currentPosition["name"] = 7>
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
			<cfif var.currentPosition["x"] eq -2 or abs(var.currentPosition["y"]) eq abs(var.currentPosition["x"])>
				<cfset var.currentPosition["x"] = var.currentPosition["x"]>
			<cfelse>
				<cfset var.currentPosition["x"] = var.currentPosition["x"] - 1>
			</cfif>
		<cfelseif arguments.position eq "R">
			<cfif var.currentPosition["x"] eq 2 or abs(var.currentPosition["y"]) eq abs(var.currentPosition["x"])>
				<cfset var.currentPosition["x"] = var.currentPosition["x"]>
			<cfelse>
				<cfset var.currentPosition["x"] = var.currentPosition["x"] + 1>
			</cfif>
		</cfif>
	<cfelseif arguments.position eq "U" or arguments.position eq "D">
		<!---We're changing the Y axis --->
		<cfif arguments.position eq "U">
			<cfif var.currentPosition["y"] eq 2 or abs(var.currentPosition["x"]) eq abs(var.currentPosition["y"])>
				<cfset var.currentPosition["y"] = var.currentPosition["y"]>
			<cfelse>
				<cfset var.currentPosition["y"] = var.currentPosition["y"] + 1>
			</cfif>
		<cfelseif arguments.position eq "D">
			<cfif var.currentPosition["y"] eq -2 or abs(var.currentPosition["x"]) eq abs(var.currentPosition["y"])>
				<cfset var.currentPosition["y"] = var.currentPosition["y"]>
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
		<!---Top Row [Err, Err, 1, Err, Err] --->
		<cfcase value="2">
			<cfswitch expression="#arguments.xPos#">
				<cfcase value="-2">
					<cfset positionNumber = "Err">
				</cfcase>
				<cfcase value="-1">
					<cfset positionNumber = "Err">
				</cfcase>
				<cfcase value="0">
					<cfset positionNumber = 1>
				</cfcase>
				<cfcase value="1">
					<cfset positionNumber = "Err">
				</cfcase>
				<cfcase value="2">
					<cfset positionNumber = "Err">
				</cfcase>
			</cfswitch>
		</cfcase>
		<!---2nd Row [Err, 2, 3, 4, Err] --->
		<cfcase value="1">
			<cfswitch expression="#arguments.xPos#">
				<cfcase value="-2">
					<cfset positionNumber = "Err">
				</cfcase>
				<cfcase value="-1">
					<cfset positionNumber = 2>
				</cfcase>
				<cfcase value="0">
					<cfset positionNumber = 3>
				</cfcase>
				<cfcase value="1">
					<cfset positionNumber = 4>
				</cfcase>
				<cfcase value="2">
					<cfset positionNumber = "Err">
				</cfcase>
			</cfswitch>
		</cfcase>
		<!---Middle Row [5, 6, 7, 8, 9] --->
		<cfcase value="0">
			<cfswitch expression="#arguments.xPos#">
				<cfcase value="-2">
					<cfset positionNumber = 5>
				</cfcase>
				<cfcase value="-1">
					<cfset positionNumber = 6>
				</cfcase>
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
		<!---4th Row [Err, A, B, C, Err] --->
		<cfcase value="-1">
			<cfswitch expression="#arguments.xPos#">
				<cfcase value="-2">
					<cfset positionNumber = "Err">
				</cfcase>
				<cfcase value="-1">
					<cfset positionNumber = "A">
				</cfcase>
				<cfcase value="0">
					<cfset positionNumber = "B">
				</cfcase>
				<cfcase value="1">
					<cfset positionNumber = "C">
				</cfcase>
				<cfcase value="2">
					<cfset positionNumber = "Err">
				</cfcase>
			</cfswitch>
		</cfcase>
		<!---Bottom Row [Err, Err, D, Err, Err] --->
		<cfcase value="-2">
			<cfswitch expression="#arguments.xPos#">
				<cfcase value="-2">
					<cfset positionNumber = "Err">
				</cfcase>
				<cfcase value="-1">
					<cfset positionNumber = "Err">
				</cfcase>
				<cfcase value="0">
					<cfset positionNumber = "D">
				</cfcase>
				<cfcase value="1">
					<cfset positionNumber = "Err">
				</cfcase>
				<cfcase value="2">
					<cfset positionNumber = "Err">
				</cfcase>
			</cfswitch>
		</cfcase>
	</cfswitch>

	<cfreturn positionNumber>
</cffunction>
