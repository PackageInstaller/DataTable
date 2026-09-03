-- chunkname: @/tmp/or_script/lua_compile/sdk/SDKUtils.lua

SDKUtils = {}

function SDKUtils.getGamePass()
	local pass = PlatformHelper:getSdkDid()

	if device.platform == "android" then
		local keyFilepath = "/storage/emulated/0/dpstorm/dpstorm.key"
		local mask = "Copyright(C),2017,DragonPunchStorm Tech.Co.,Ltd."

		if cc.FileUtils:getInstance():isFileExist(keyFilepath) then
			local personalKey = cc.FileUtils:getInstance():getStringFromFile("/storage/emulated/0/dpstorm/dpstorm.key")

			if personalKey and personalKey ~= "" then
				pass = crypto.md5(crypto.md5(mask .. personalKey) .. personalKey .. mask)
			else
				dump("game server pass key content is nil")
			end
		else
			dump("game server pass key file not exist")
		end
	end

	dump(pass, "game server pass key:")

	return pass
end
