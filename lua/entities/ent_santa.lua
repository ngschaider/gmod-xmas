ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Weihnachtsmann"
ENT.Author			= "Swapy97"
ENT.Information		= "Adventskalender"
ENT.Category		= "DB Christmas"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

if SERVER then

	AddCSLuaFile()

	
	function ENT:Initialize()
	
		self:SetModel( "models/player/slow/santa_claus/slow_fix.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
		self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
		self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
 
        local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
		
	end

	function ENT:Think()
	end
	
	function ENT:Use( ply )
		if not ply:IsValid() then return end
		if ply.santa_debounce == 1 then return end
		
		ply.santa_debounce = 1
		timer.Simple( 1, function()
			ply.santa_debounce = 0
		end )
		
		// print( ply:Nick() .. " opened Santa Menu!" )
		
		local date = util.DateStamp()
		//print( "serverside DateStamp: ".. date )
		
		local date = string.Explode( " ", date )
		local date = string.Explode( "-", date[1] )
		
		
		/*
		for k, v in pairs( date ) do
			print( "k: ".. k .."  v: ".. v )  // Debugging
		end
		*/
			
			/*
				date[1] --> Year
				date[2] --> Month
				date[3] --> Day
			*/
		
		/*
		if date[2] == "11" then
			print( "Momentan haben wir den ".. date[2]..". Monat des Jahres!" )  // Debugging
		end
		*/
		
		net.Receive( "ccommand", function()
		
			local day_clicked = net.ReadString()
			runCCommand( ply, day_clicked, date[1], date[2], date[3] );  // Send data, for handling the request in an extra function
		
		end )
		
		net.Start( "santa_menu" ) // No data to send here..
		net.Send( ply );	
	end
end

if CLIENT then
	function ENT:Draw()
		self.Entity:DrawModel()
	end
	
	local ply = LocalPlayer()
	
	function santa_assi(w, h, col)
		
			--BackGround
			surface.SetDrawColor(col)
			surface.DrawRect(0, 0 , w, h)
			--BackGround

			--Bottom BAR
			surface.SetDrawColor(255,128,0,255)
			--surface.DrawRect(0, h-5 , w, 5)
			--BOTTOM BAR

			--TOP BAR
			surface.SetDrawColor(255,128,0,255)
			--surface.DrawRect(0, 0 , w, 5)
			--TOP BAR

			--Left BAR
			surface.SetDrawColor(255,128,0,255)
			surface.DrawRect(0, 0 , 3, h)


			--right BAR
			surface.SetDrawColor(255,128,0,255)
			surface.DrawRect(w-3, 0 , w-3, h)

	end

	
	function santa_menu()	
				
				// Screen resoulution:  1600 x 900
				
				
		local w = ScrW()
		local h = ScrH()
		
		CCommand.Config.ImageSize = w * 0.08
		//print( w, h )
		
		local frame = vgui.Create("DFrame")
		frame:SetSize(w - w*0.094, h - h*0.167)
		frame:Center()
		frame:MakePopup()
		frame:ShowCloseButton(false)

		local fw = frame:GetWide()
		local fh = frame:GetTall()

		frame:SetTitle( "" )

		frame.Paint = function ()
			santa_assi(fw, fh, Color(30,30,30,255))
		end
			
		local lbl = vgui.Create( "DLabel", frame )
		lbl:SetSize( w*0.75, h*0.028 )
		lbl:SetText("")
		lbl:SetPos( w*0.038, h*0.022 )
		lbl.Paint = function()
			draw.DrawText( CCommand.Config.GreetingText, "Trebuchet24", 0, 0, Color(255, 255, 255) )
		end
		
		
		
		/*
		local launcher = vgui.Create( "DModelPanel", frame )
		launcher:SetModel( "models/weapons/w_rocket_launcher.mdl" )
		launcher:SetPos( 125, 100 )
		launcher:SetAnimated( false )
		local launchersize = 250
		launcher:SetSize( launchersize, launchersize )
		launcher:SetCamPos( Vector( 50, 50, 50 ) )
		launcher:SetLookAt( Vector( 0, 0, 20 ) )
		
		local launcherlbl = vgui.Create( "DLabel", frame )
		launcherlbl:SetSize( 1000, 100 )
		launcherlbl:SetText("")
		launcherlbl:SetPos( 360, 220 )
		launcherlbl.Paint = function()
			draw.DrawText( "Die Weihnachstgrüße", "Trebuchet24", 0, 0, Color(255, 255, 255) )
			draw.DrawText( "Weihnachten ist das Fest der Liebe! Beschenke deine schlimmsten Feinde!", "Trebuchet18", 0, 40, Color(255, 255, 255) )
		end
		
		local snow = vgui.Create( "DModelPanel", frame )
		snow:SetModel( "models/weapons/w_snowball.mdl" )
		snow:SetPos( 125, 200 )
		snow:SetAnimated( false )
		local snowsize = 250
		snow:SetSize( snowsize, snowsize )
		snow:SetCamPos( Vector( 25, 25, 25 ) )
		snow:SetLookAt( Vector( 0, 0, 20 ) )
 
		local snowlbl = vgui.Create( "DLabel", frame )
		snowlbl:SetSize( 1000, 150 )
		snowlbl:SetText("")
		snowlbl:SetPos( 360, 400 )
		snowlbl.Paint = function()
			draw.DrawText( "Die Weihnachstgrüße", "Trebuchet24", 0, 0, Color(255, 255, 255) )
			draw.DrawText( "Weihnachten ist das Fest der Liebe! Beschenke deine schlimmsten Feinde!", "Trebuchet18", 0, 40, Color(255, 255, 255) )
		end
		
		*/
		
		local closebtn = vgui.Create( "DButton", frame )
		closebtn:SetSize( w*0.022 , h*0.039 )
		closebtn:SetText("")
		closebtn:SetPos( fw - w*0.038, h*0.022 )
		closebtn.DoClick = function()
			frame:Close()
		end
		closebtn.Paint = function()
			santa_assi(closebtn:GetWide(), closebtn:GetTall(), Color(30,30,30,255))
			draw.DrawText("X", "Trebuchet24", closebtn:GetWide()*.5, closebtn:GetTall()*.15, Color(255, 0, 0), TEXT_ALIGN_CENTER)
		end

		/*
		local websitebtn = vgui.Create("DButton", frame)
		websitebtn:SetSize(250,75)
		websitebtn:SetPos(50, 640)
		websitebtn:SetText("")
		websitebtn.DoClick = function()
			gui.OpenURL("http://www.google.at/")
		end
		websitebtn.Paint = function()
			santa_assi(websitebtn:GetWide(), websitebtn:GetTall(), Color(50, 150, 150,255))
			draw.DrawText("Platzhalter", "Trebuchet24", websitebtn:GetWide()*.5, websitebtn:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end

		local tutsitebtn = vgui.Create("DButton", frame)
		tutsitebtn:SetSize(250,75)
		tutsitebtn:SetPos(330, 640)
		tutsitebtn:SetText("")
		tutsitebtn.DoClick = function()
			gui.OpenURL("http://www.google.at/")
		end
		tutsitebtn.Paint = function()
			santa_assi(tutsitebtn:GetWide(), tutsitebtn:GetTall(), Color(150, 150, 50,255))
			draw.DrawText("Platzhalter", "Trebuchet24", tutsitebtn:GetWide()*.5, tutsitebtn:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end

		local hofbtn = vgui.Create("DButton", frame)
		hofbtn:SetSize(250,75)
		hofbtn:SetPos(610, 640)
		hofbtn:SetText("")
		hofbtn.DoClick = function()
			gui.OpenURL("http://www.google.at/")
		end
		hofbtn.Paint = function()
			santa_assi(hofbtn:GetWide(), hofbtn:GetTall(), Color(150, 50, 150,255))
			draw.DrawText("Platzhalter", "Trebuchet24", hofbtn:GetWide()*.5, hofbtn:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end

		local creditsbtn = vgui.Create("DButton", frame)
		creditsbtn:SetSize(250,75)
		creditsbtn:SetPos(890, 640)
		creditsbtn:SetText("")
		creditsbtn.DoClick = function()
			frame:Close()
			net.Start("ccommand")
			net.SendToServer()
		end
		creditsbtn.Paint = function()
			santa_assi(creditsbtn:GetWide(), creditsbtn:GetTall(), Color(150, 150, 150,255))
			draw.DrawText("Tür öffnen", "Trebuchet24", creditsbtn:GetWide()*.5, creditsbtn:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
	
		*/
		
		local model = vgui.Create( "DModelPanel", frame )
		model:SetAnimated( false )
		model:SetPos( w*0.438, h*0.111 )
		model:SetModel( "models/player/slow/santa_claus/slow_fix.mdl" )
		model:SetSize( w*0.625, h*1.111 )
		model:SetCamPos( Vector( 0, -100, 80 ) )
		model:SetLookAt( Vector( 0, 10, 0 ) )
		model:SetLookAng( Angle( 30, 90, 0 ) )
		function model:LayoutEntity() return end

		local dlbl = vgui.Create( "DLabel", frame )
		dlbl:SetText("")
		dlbl:SetPos( w*0.094, h*0.75 )
		dlbl:SetSize( w*0.625, h*0.056 )
		dlbl.Paint = function()
			draw.DrawText( CCommand.Config.BottomText, "Trebuchet24", 0, 0, Color(255, 255, 255) )
		end
		
		dimage1 = vgui.Create( "DImageButton", frame )
		dimage1:SetPos( w*0.063, h*0.056 )
		dimage1:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage1:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage1.PaintOver = function()
			draw.DrawText("1", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage1.DoClick = function()
			frame:Close()
			presentClick( 1 )
		end
		
		dimage2 = vgui.Create( "DImageButton", frame )
		dimage2:SetPos( w*0.156, h*0.056 )
		dimage2:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage2:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage2.PaintOver = function()
			draw.DrawText("2", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage2.DoClick = function()
			frame:Close()
			presentClick( 2 )
		end
		
		dimage3 = vgui.Create( "DImageButton", frame )
		dimage3:SetPos( w*0.25, h*0.056 )
		dimage3:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage3:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage3.PaintOver = function()
			draw.DrawText("3", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage3.DoClick = function()
			frame:Close()
			presentClick( 3 )
		end
		
		dimage4 = vgui.Create( "DImageButton", frame )
		dimage4:SetPos( w*0.344, h*0.056 )
		dimage4:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage4:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage4.PaintOver = function()
			draw.DrawText("4", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage4.DoClick = function()
			frame:Close()
			presentClick( 4 )
		end
		
		dimage5 = vgui.Create( "DImageButton", frame )
		dimage5:SetPos( w*0.438, h*0.056 )
		dimage5:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage5:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage5.PaintOver = function()
			draw.DrawText("5", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage5.DoClick = function()
			frame:Close()
			presentClick( 5 )
		end
		
		dimage6 = vgui.Create( "DImageButton", frame )
		dimage6:SetPos( w*0.531, h*0.056 )
		dimage6:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage6:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage6.PaintOver = function()
			draw.DrawText("6", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage6.DoClick = function()
			frame:Close()
			presentClick( 6 )
		end
		
		
		dimage7 = vgui.Create( "DImageButton", frame )
		dimage7:SetPos( w*0.063, h*0.222 )
		dimage7:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage7:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage7.PaintOver = function()
			draw.DrawText("7", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage7.DoClick = function()
			frame:Close()
			presentClick( 7 )
		end
		
		dimage8 = vgui.Create( "DImageButton", frame )
		dimage8:SetPos( w*0.156, h*0.222 )
		dimage8:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage8:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage8.PaintOver = function()
			draw.DrawText("8", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage8.DoClick = function()
			frame:Close()
			presentClick( 8 )
		end
		
		dimage9 = vgui.Create( "DImageButton", frame )
		dimage9:SetPos( w*0.25, h*0.222 )
		dimage9:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage9:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage9.PaintOver = function()
			draw.DrawText("9", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage9.DoClick = function()
			frame:Close()
			presentClick( 9 )
		end
		
		dimage10 = vgui.Create( "DImageButton", frame )
		dimage10:SetPos( w*0.344, h*0.222 )
		dimage10:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage10:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage10.PaintOver = function()
			draw.DrawText("10", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage10.DoClick = function()
			frame:Close()
			presentClick( 10 )
		end
		
		dimage11 = vgui.Create( "DImageButton", frame )
		dimage11:SetPos( w*0.438, h*0.222 )
		dimage11:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage11:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage11.PaintOver = function()
			draw.DrawText("11", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage11.DoClick = function()
			frame:Close()
			presentClick( 11 )
		end
		
		dimage12 = vgui.Create( "DImageButton", frame )
		dimage12:SetPos( w*0.531, h*0.222 )
		dimage12:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage12:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage12.PaintOver = function()
			draw.DrawText("12", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage12.DoClick = function()
			frame:Close()
			presentClick( 12 )
		end
		
		
		dimage13 = vgui.Create( "DImageButton", frame )
		dimage13:SetPos( w*0.063, h*0.389 )
		dimage13:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage13:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage13.PaintOver = function()
			draw.DrawText("13", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage13.DoClick = function()
			frame:Close()
			presentClick( 13 )
		end
		
		dimage14 = vgui.Create( "DImageButton", frame )
		dimage14:SetPos( w*0.156, h*0.389 )
		dimage14:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage14:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage14.PaintOver = function()
			draw.DrawText("14", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage14.DoClick = function()
			frame:Close()
			presentClick( 14 )
		end
		
		dimage15 = vgui.Create( "DImageButton", frame )
		dimage15:SetPos( w*0.25, h*0.389 )
		dimage15:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage15:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage15.PaintOver = function()
			draw.DrawText("15", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage15.DoClick = function()
			frame:Close()
			presentClick( 15 )
		end
		
		dimage16 = vgui.Create( "DImageButton", frame )
		dimage16:SetPos( w*0.344, h*0.389 )
		dimage16:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage16:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage16.PaintOver = function()
			draw.DrawText("16", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage16.DoClick = function()
			frame:Close()
			presentClick( 16 )
		end
		
		dimage17 = vgui.Create( "DImageButton", frame )
		dimage17:SetPos( w*0.438, h*0.389 )
		dimage17:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage17:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage17.PaintOver = function()
			draw.DrawText("17", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage17.DoClick = function()
			frame:Close()
			presentClick( 17 )
		end
		
		dimage18 = vgui.Create( "DImageButton", frame )
		dimage18:SetPos( w*0.531, h*0.389 )
		dimage18:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage18:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage18.PaintOver = function()
			draw.DrawText("18", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage18.DoClick = function()
			frame:Close()
			presentClick( 18 )
		end
		
		
		dimage19 = vgui.Create( "DImageButton", frame )
		dimage19:SetPos( w*0.063, h*0.555 )
		dimage19:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage19:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage19.PaintOver = function()
			draw.DrawText("19", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage19.DoClick = function()
			frame:Close()
			presentClick( 19 )
		end
		
		dimage20 = vgui.Create( "DImageButton", frame )
		dimage20:SetPos( w*0.156, h*0.555 )
		dimage20:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage20:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage20.PaintOver = function()
			draw.DrawText("20", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage20.DoClick = function()
			frame:Close()
			presentClick( 20 )
		end
		
		dimage21 = vgui.Create( "DImageButton", frame )
		dimage21:SetPos( w*0.25, h*0.555 )
		dimage21:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage21:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage21.PaintOver = function()
			draw.DrawText("21", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage21.DoClick = function()
			frame:Close()
			presentClick( 21 )
		end
		
		dimage22 = vgui.Create( "DImageButton", frame )
		dimage22:SetPos( w*0.344, h*0.555 )
		dimage22:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage22:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage22.PaintOver = function()
			draw.DrawText("22", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage22.DoClick = function()
			frame:Close()
			presentClick( 22 )
		end
		
		dimage23 = vgui.Create( "DImageButton", frame )
		dimage23:SetPos( w*0.438, h*0.555 )
		dimage23:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage23:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage23.PaintOver = function()
			draw.DrawText("23", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage23.DoClick = function()
			frame:Close()
			presentClick( 23 )
		end
		
		
		dimage24 = vgui.Create( "DImageButton", frame )
		dimage24:SetPos( w*0.531, h*0.555 )
		dimage24:SetImage( "ccommands/present" ) -- Set your .vtf image
		dimage24:SetSize( CCommand.Config.ImageSize, CCommand.Config.ImageSize )
		dimage24.PaintOver = function()
			draw.DrawText("24", "swapy_Christmas", dimage1:GetWide()*.5, dimage1:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		dimage24.DoClick = function()
			frame:Close()
			presentClick( 24 )
		end
		
	end
	
	function presentClick( day_clicked )
		net.Start( "ccommand" )
			net.WriteString( day_clicked )
		net.SendToServer()
	end
	
	net.Receive( "santa_menu", function()
		santa_menu()
	end )
	
end