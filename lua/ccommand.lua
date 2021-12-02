if SERVER then
	// SERVER HERE
	
	AddCSLuaFile( "config.lua" )
	include( "text.lua" )
	include( "rewards.lua" )
end

if CLIENT then
	// CLIENT HERE
	surface.CreateFont( "swapy_Christmas", {
		font = "Trebuchet24", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		size = 80,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
end

// SHARED HERE

CCommand = {}
CCommand.Config = {}
CCommand.SQL = {}

CCommand.Config.Easteregg = true

include( "config.lua" )

function ccommand_reset()
	include( "ccommand.lua" )
end
concommand.Add( "ccommand_reset", ccommand_reset )

if SERVER then

	// SERVER HERE

	util.AddNetworkString( "santa_menu" )
	util.AddNetworkString( "ccommand" )

	function runCCommand( ply, day_clicked, year, month, day )

		if CCommand.Config.Year == "-1" or year == CCommand.Config.Year then
			//print( "Year check passed!" )
			if CCommand.Config.Month == "-1" or month == CCommand.Config.Month then
				//print( "Month check passed!" )
				if day_clicked == day or CCommand.Config.Day == "-1" then
					//print( "Day check passed!" )
					if ccommand_checkday( ply, day ) == day  then // table.HasValue( table tbl, any value ) 
						//print( "data check passed!" )
						if day_clicked == "1" then
							day1( ply )
						elseif day_clicked == "2" then
							day2( ply )
						elseif day_clicked == "3" then
							day3( ply )
						elseif day_clicked == "4" then
							day4( ply )
						elseif day_clicked == "5" then
							day5( ply )
						elseif day_clicked == "6" then
							day6( ply )
						elseif day_clicked == "7" then
							day7( ply )
						elseif day_clicked == "8" then
							day8( ply )
						elseif day_clicked == "9" then
							day9( ply )
						elseif day_clicked == "10" then
							day10( ply )
						elseif day_clicked == "11" then
							day11( ply )
						elseif day_clicked == "12" then
							day12( ply )
						elseif day_clicked == "13" then
							day13( ply )
						elseif day_clicked == "14" then
							day14( ply )
						elseif day_clicked == "15" then
							day15( ply )
						elseif day_clicked == "16" then
							day16( ply )
						elseif day_clicked == "17" then
							day17( ply )
						elseif day_clicked == "18" then
							day18( ply )
						elseif day_clicked == "19" then
							day19( ply )
						elseif day_clicked == "20" then
							day20( ply )
						elseif day_clicked == "21" then
							day21( ply )
						elseif day_clicked == "22" then
							day22( ply )
						elseif day_clicked == "23" then
							day23( ply )
							if CCommand.Config.Easteregg then
								Msg( "Heute hat Swapy97 Geburtstag! Wenn du ihm gratulierst, gibt er dir vielleicht ein Geschenk :)")
							end
						elseif day_clicked == "24" then
							day24( ply )
						end
						
						ccommand_writedays( ply, day )
						ply:ChatPrint( "Du hast dir das Geschenk für den "..day..". Dezember abgeholt. Viel Spaß!" )
					else
						//print( "failed on data check" )
						if ccommand_checkday( ply, 1337 ) == 1337 then
							ply:ChatPrint( "Du hast deinen Treuebonus eingelöst. Viel Spaß!" )
							treuebonus( ply )
						else
							ply:ChatPrint( "Du hast dir das Geschenk für den "..day..". Dezember schon abgeholt." )
						end
						
					end
				else
					//print( "Heute ist der ".. day ..". ".. month ..". ".. year .."! Komm nachher wieder." )
					//print( "failed on day check." )
					if day > "24" then
						ply:ChatPrint( "Du kommst zu spät! Alle Geschenke sind schon weg!" )
					else
						ply:ChatPrint( "Dieses Geschenk kriegst du erst am ".. day_clicked ..". !" )
						ply:ChatPrint( "Heute haben wir erst den ".. day ..". !" )
					end
				end
			else
				//print( "Heute ist der ".. day ..". ".. month ..". ".. year .."! Komm nachher wieder." )
				//print( "failed on month check." )
				ply:ChatPrint( "Ich geb dir nur im Dezember Geschenke!" )
			end
		else
			//print( "Heute ist der ".. day ..". ".. month ..". ".. year .."! Komm nachher wieder." )
			//print( "failed on year check." )
			ply:ChatPrint( "Der Adventskalender ist dieses Jahr nicht aktiviert!" )
		end

	end
end