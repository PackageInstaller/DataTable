-- chunkname: @/tmp/or_script/lua_compile/dm/gameupdate/GameUpdaterConfig.lua

NetStatus = {
	kNoNet = 0,
	kWWAN = 2,
	kWifi = 1
}
NetDelayStatus = {
	kLow = 1,
	kMiddle = 2,
	kHight = 3
}
GameUpdaterConfig = {
	Debug = 1
}
GameUpdaterDebuger = GameUpdaterDebuger or {}

function GameUpdaterDebuger:print(fmt, ...)
	if GameUpdaterConfig.Debug == 1 then
		_G.print("GameUpdaterDebug:" .. fmt, ...)
	end
end
