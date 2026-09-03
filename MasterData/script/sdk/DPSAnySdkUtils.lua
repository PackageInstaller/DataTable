-- chunkname: @/tmp/or_script/lua_compile/sdk/DPSAnySdkUtils.lua

DPSAnySdkUtils = DPSAnySdkUtils or {}
DPSAnySdkUtils.sdkSourceTable = {
	android = "dpstorm_android",
	mac = "dpstorm_ios",
	ios = "dpstorm_ios"
}

function DPSAnySdkUtils.getDefaultGlobalData(openId)
	return {
		sdk_source = DPSAnySdkUtils.sdkSourceTable[tostring(device.platform)],
		sdk_params = {
			openid = string.urlencode(tostring(openId))
		}
	}
end

function DPSAnySdkUtils.getGamePass()
	local deviceInfo = app.getDevice():getDeviceInfo()
	local pass = ""

	if deviceInfo and deviceInfo.deviceId then
		pass = deviceInfo.deviceId
	end

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

function DPSAnySdkUtils.getStatisticsBaseInfo(openId, sdkSource)
	local deviceInfo = app.getDevice():getDeviceInfo()

	if app.pkgConfig then
		local version = app:getAssetsManager():getCurrentVersion()

		if sdkSource == "" then
			sdkSource = DPSAnySdkUtils.sdkSourceTable[tostring(device.platform)]
		end

		local xingeToken = ""

		if dpsPush and dpsPush.getToken then
			xingeToken = dpsPush.getToken()

			dump(xingeToken, "xg push token:")
		end

		if app and app.getXGPushServiceToken then
			xingeToken = app.getXGPushServiceToken()

			dump(xingeToken, "xg push token:")
		end

		return {
			baseVersion = app.pkgConfig,
			version = version,
			platform = device.platform,
			os = deviceInfo.systemName .. " " .. deviceInfo.systemVersion,
			source = sdkSource,
			dtype = deviceInfo.deviceName,
			did = deviceInfo.deviceId,
			pass = DPSAnySdkUtils.getGamePass(),
			ip = (app and app.getDevice and app.getDevice().getIPAddress or nil) and app.getDevice():getIPAddress(),
			idfa = (app and app.getDevice and app.getDevice().getIDFA or nil) and app.getDevice():getIDFA(),
			idfv = (app and app.getDevice and app.getDevice().getIDFV or nil) and app.getDevice():getIDFV(),
			mac = (app and app.getDevice and app.getDevice().getMacAddress or nil) and app.getDevice():getMacAddress(),
			imei = (app and app.getDevice and app.getDevice().getIMEI or nil) and app.getDevice():getIMEI(),
			openid = openId,
			xingeToken = xingeToken
		}
	end
end
