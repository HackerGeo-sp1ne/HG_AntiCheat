--[[
    FiveM Scripts
	The Official HackerGeo Script 
	Credits - HackerGeo
	Website - www.HackerGeo.com
	GitHub - GITHUB.com/HackerGeo-sp1ne
	Steam - SteamCommunity.com/id/HackerGeo1
	Copyright 2019 ©HackerGeo. All rights served
]]

------------------------------------------------------WARNING-----------------------------------------------------
---------------------Do not reupload/re release any part of this script without my permission---------------------
------------------------------------------------------------------------------------------------------------------


local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","HG_AntiCheat")
MySQL = module("vrp_mysql", "MySQL")

MySQL.createCommand("vRP/HG_Ban", "UPDATE vrp_users SET banned='1' WHERE id = @id")

RegisterServerEvent("HG_AntiCheat:Cars")
AddEventHandler("HG_AntiCheat:Cars", function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local name = GetPlayerName(source)
	print("[HG_AntiCheat] | " ..name.. "["..user_id.. "] A PRIMIT BAN (CARS BLACKLISTED)!")
	TriggerClientEvent('chatMessage', -1, '^3[HG_AntiCheat]', {255, 0, 0}, "^1" ..name.. "^3[ID:" ..user_id.. "]^1 A PRIMIT BAN ^3(reason: CARS BLACKLISTED)!" )
	DropPlayer(source, "[HG_AntiCheat] | AI FOST DETECTAT CU HACK! (CARS BLACKLISTED)")
	MySQL.query("vRP/HG_Ban", {id = user_id})
end)

RegisterServerEvent("HG_AntiCheat:Jump")
AddEventHandler("HG_AntiCheat:Jump", function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local name = GetPlayerName(source)
	print("[HG_AntiCheat] | " ..name.. "["..user_id.. "] A PRIMIT BAN (SUPER JUMP)!")
	TriggerClientEvent('chatMessage', -1, '^3[HG_AntiCheat]', {255, 0, 0}, "^1" ..name.. "^3[ID:" ..user_id.. "]^1 A PRIMIT BAN ^3(reason: SUPER JUMP)!" )
	DropPlayer(source, "[HG_AntiCheat] | AI FOST DETECTAT CU HACK! (SUPER JUMP)")
	MySQL.query("vRP/HG_Ban", {id = user_id})
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	local resourceName = ""..GetCurrentResourceName()..""
	vRPclient.notifyPicture(source,{"CHAR_LESTER",1,"AntiCheat",false,"~y~Server protejat de ~g~".. resourceName .."!"})
end)

RegisterCommand("ac", function(thePlayer, args, rawCommand)
	TriggerClientEvent("HG_AntiCheat:Toggle", -1, 1)
end)

_vHG_AntiCheat = '1.5.0'
PerformHttpRequest( "https://www.hackergeo.com/anticheat.txt", function( err, text, headers )
	Citizen.Wait( 1000 )
	local resourceName = "("..GetCurrentResourceName()..")"
	RconPrint( "\nYour AntiCheat Version: " .. _vHG_AntiCheat)
	RconPrint( "\nNew AntiCheat Version: " .. text)
	
	if ( text ~= _vHG_AntiCheat ) then
		RconPrint( "\n\n\t|||||||||||||||||||||||||||||||||\n\t|| ".. resourceName .." is Outdated! ||\n\t|| Download the latest version ||\n\t||    From the HackerGeo.com   ||\n\t|||||||||||||||||||||||||||||||||\n\n" )
	else
		RconPrint( "\n\n\t|||||||||||||||||||||||||||||||||\n\t||                             ||\n\t||".. resourceName .." is up to date!||\n\t||                             ||\n\t|||||||||||||||||||||||||||||||||\n\n" )
	end
end, "GET", "", { what = 'this' } )
