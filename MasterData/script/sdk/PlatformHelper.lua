-- chunkname: @/tmp/or_script/lua_compile/sdk/PlatformHelper.lua

local cjson = require("cjson.safe")
local isPlatformIOS = false
local isPlatformAndroid = false
local luaoc, luaj
local PlatformClassPath = ""
local application = cc.Application:getInstance()
local target = application:getTargetPlatform()
local gameDid

if target == 4 or target == 5 then
	isPlatformIOS = true
	luaoc = require("cocos.cocos2d.luaoc")
	PlatformClassPath = "DPSLuaHelper"
elseif target == 3 then
	isPlatformAndroid = true
	luaj = require("cocos.cocos2d.luaj")
	PlatformClassPath = "org/dpstrom/anysdk/DPSLuaHelper"
end

local PlatformHelper = {}

function PlatformHelper:isIOS()
	return isPlatformIOS
end

function PlatformHelper:isAndroid()
	return isPlatformAndroid
end

function PlatformHelper:getChannelID()
	if self:isAndroid() then
		local success, channel = luaj.callStaticMethod(PlatformClassPath, "getChannelID", {}, "()Ljava/lang/String;")

		return (not success or nil) and "test"
	elseif self:isIOS() then
		return "wanmeiGlobal_ios"
	end

	return nil
end

function PlatformHelper:thirdUpdate()
	local channelID = self:getChannelID()
	local channel2url = {
		wanmeiGlobal_android = "https://play.google.com/store/apps/details?id=com.superprism.illusion",
		wanmeiGlobal_ios = "https://itunes.apple.com/app/id1514571062"
	}

	if channel2url[channelID] then
		cc.Application:getInstance():openURL(channel2url[channelID])

		return
	end

	if channelID == "dpstorm_android" then
		self:callSDKFunction("thirdUpdate", {})
	end
end

function PlatformHelper:callSDKFunction(cmd, params)
	if not cmd then
		return
	end

	local args = {}

	args[1] = cmd
	args[2] = params and table.nums(params) > 0 and cjson.encode(params) or ""

	if self:isIOS() then
		-- block empty
	elseif self:isAndroid() then
		luaj.callStaticMethod(PlatformClassPath, "commandFunction", args, "(Ljava/lang/String;Ljava/lang/String;)V")
	end
end

function PlatformHelper:isInstallApp(packageName)
	local success = false
	local isInstall = false

	if self:isIOS() then
		isInstall = false
	elseif self:isAndroid() then
		success, isInstall = luaj.callStaticMethod(PlatformClassPath, "isInstallApp", {
			packageName
		}, "(Ljava/lang/String;)Z")
	end

	return isInstall
end

function PlatformHelper:getSdkDid()
	if device.platform == "mac" or device.platform == "windows" then
		return ""
	end

	if gameDid and gameDid ~= "" then
		return gameDid
	end

	if self:isAndroid() then
		local success, did = luaj.callStaticMethod(PlatformClassPath, "getDeviceID", {}, "()Ljava/lang/String;")

		if not success then
			gameDid = app.getDevice():getDeviceInfo().deviceId or ""
		end
	else
		local var_7_0 = app.getDevice():getDeviceInfo().deviceId

		var_7_0 = var_7_0 or ""
		gameDid = var_7_0
	end

	return gameDid
end

function PlatformHelper:reportByUpdate(event, url)
	self:callSDKFunction("wanmeiGameUpdateAssetEvent", {
		state = event,
		url = url
	})
end

return PlatformHelper
