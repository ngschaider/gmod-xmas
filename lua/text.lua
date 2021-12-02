// file.Read( string fileName, string path="DATA" )
// file.Append( string name, string content )
// file.Exists( string name, string path )
// file.Write( string fileName, string content )

// file.CreateDir( string name )

function ccommand_createdir()
	if not file.IsDir( "ccommand", "DATA" ) then 
		file.CreateDir( "ccommand" )
		file.Write( "ccommand/default.txt", "default" )
		print( "[CCOMMAND] Created Data Storage at /data/ccommand/" )
	else
		//print( "[CCOMMAND] Data Storage at /data/ccommand is already created" )
	end
end
ccommand_createdir()

function ccommand_newply( ply, cmd, args )
	
	local steamid = ply:SteamID()
	local plyfile = "ccommand/".. string.gsub( steamid, ":", "_" )..".txt"
	
	if not file.Exists( plyfile, "DATA" ) then
		file.Write( plyfile, steamid )
		print( "[CCOMMAND] Created storage file of "..ply:SteamID() )
	else
		//print( "[CCOMMAND] "..ply:Nick().."'s storage file is already created" )
	end
	
end
hook.Add( "PlayerInitialSpawn", "ccommand_newply", ccommand_newply )

function ccommand_checkday( ply, day )

	local steamid = ply:SteamID()
	local plyfile = "ccommand/".. string.gsub( steamid, ":", "_" )..".txt"
	
	local text = file.Read( plyfile, "DATA" )
	//print( text )
	// string.find( string haystack, string needle, number startPos=1, boolean noPatterns=false )
	if day == 1337 then
		//print( "checking treuebonus" )
		if string.find( text , steamid..",1,,2,,3,,4,,5,,6,,7,,8,,9,,10,,11,,12,,13,,14,,15,,16,,17,,18,,19,,20,,21,,22,,23,,24," ) then
			//print( "returning treue" )
			return 1337
		else
			//print( "returning false" )
			return false
		end
	else
		//print( "checking normal day" )
		if not string.find( text , day.."," ) then
			//print( "returning day" )
			return day
		else
			//print( "returning false" )
			return false
		end
	end
	
end

function ccommand_writedays( ply, day )
	
	local steamid = ply:SteamID()
	local plyfile = "ccommand/".. string.gsub( steamid, ":", "_" ) ..".txt"
	
	file.Append( plyfile, day.."," )
	
end