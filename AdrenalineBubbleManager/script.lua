--[[ 
	Adrenaline Bubble Manager VPK.
	Create and organize your direct adrenaline bubbles.
	
	Licensed by GNU General Public License v3.0
	
	Designed By:
	- Gdljjrod (https://twitter.com/gdljjrod).
	- DevDavisNunez (https://twitter.com/DevDavisNunez).
]]

day = tonumber(os.date("%d"))
month = tonumber(os.date("%m"))
snow = false
if (month == 12 and (day >= 20 and day <= 25)) then snow = true end

--Show splash ...
local splash = image.load("resources/splash.png")
if splash then splash:blit(0,0) end
screen.flip()
splash=nil

dofile("crc.lua")
dofile("system/scroll.lua")
dofile("system/lang.lua")
dofile("system/commons.lua")
dofile("system/callbacks.lua")
if os.access() == 0 then
	if back2 then back2:blit(0,0) end
	screen.flip()
	custom_msg(UNSAFE_MODE,0)
	os.exit()
end

__ITLS = os.lmodule("itlsKernel")

dofile("git/shared.lua")
if __UPDATE == 1 then
	dofile("git/updater.lua")
end

ADRENALINE = "ux0:app/PSPEMUCFW"
MODULES = {
  { fullpath = ADRENALINE.."/sce_module/adrbubblebooter.suprx",   path = "sce_module/adrbubblebooter.suprx",   crc = __CRCADRBOOTER },
  { fullpath = ADRENALINE.."/sce_module/adrenaline_kernel.skprx", path = "sce_module/adrenaline_kernel.skprx", crc = __CRCKERNEL  },
  { fullpath = ADRENALINE.."/sce_module/adrenaline_user.suprx",   path = "sce_module/adrenaline_user.suprx",   crc = __CRCUSER  },
  { fullpath = ADRENALINE.."/sce_module/adrenaline_vsh.suprx",    path = "sce_module/adrenaline_vsh.suprx",    crc = __CRCVSH  },
  { fullpath = ADRENALINE.."/sce_module/bootconv.suprx",          path = "sce_module/bootconv.suprx",          crc = __CRCBOOTCONV }
}
oncopy = false

if game.exists("PSPEMUCFW") and files.exists(ADRENALINE) and
	files.exists(ADRENALINE.."/eboot.bin") and files.exists(ADRENALINE.."/eboot.pbp") then

	if not files.exists(ADRENALINE.."/adrenaline.bin") then
		oncopy = true
		files.copy("bubbles/adrenaline.bin", ADRENALINE)
		oncopy = false
	end

	if not files.exists(ADRENALINE.."/menucolor.bin") then
		files.copy("bubbles/menucolor.bin", ADRENALINE)
	end

	if __CHECKADR == 1 then
		if not files.exists(ADRENALINE.."/sce_module/adrbubblebooter.suprx") then
			oncopy = true
			files.copy("sce_module/", ADRENALINE)
		else

			for i=1,#MODULES do
				if not files.exists(MODULES[i].fullpath) then
					oncopy = true
					files.copy(MODULES[i].path, ADRENALINE.."/sce_module/")
				else
					if os.crc32(files.read(MODULES[i].fullpath) ) != MODULES[i].crc then
						oncopy = true
						files.copy(MODULES[i].path, ADRENALINE.."/sce_module/")
					end
				end
			end
		end

		if oncopy then
			if back2 then back2:blit(0,0) end
			screen.flip()
			os.dialog(ADRBBOTER_INSTALLED)
			os.delay(500)
		end

	end--__CHECKADR

	if oncopy then

		--Make Bubbles compatible with new boot.bin
		local list = game.list(__GAME_LIST_APP)
		table.sort(list ,function (a,b) return string.lower(a.id)<string.lower(b.id) end)

		oncopy = false
		for i=1, #list do
			
			if files.exists(list[i].path.."/data/boot.inf") then
				if not files.exists(list[i].path.."/data/boot.bin") then
				
					if back2 then back2:blit(0,0) end
					message_wait(UPDATE_BUBBLES..list[i].id)
					os.delay(50)

					AutoMakeBootBin(list[i])

				end
			end

		end--for
		custom_msg(ADRENALINE_LAUNCH_FIRST,0)
		os.delay(1000)
		power.restart()
	end

	dofile("system/stars.lua")
	dofile("system/scan.lua")
	dofile("system/bubbles.lua")
	dofile("system/resources.lua")

	bubbles.scan()
	scan.games()
	scan.show()

else
	custom_msg(ADRENALINE_NOT_INSTALLED,0)
end
