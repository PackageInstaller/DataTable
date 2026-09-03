-- chunkname: @/tmp/or_script/lua_compile/dm/gameupdate/VersionChecker.lua

trycall(require, "cocos.network.NetworkConstants")

local cjson = require("cjson.safe")

VersionChecker = VersionChecker or {}

function VersionChecker:new()
	local result = setmetatable({}, {
		__index = VersionChecker
	})

	result:initialize()

	return result
end

function VersionChecker:initialize()
	self:initVersionChecker()
end

function VersionChecker:initVersionChecker()
	self._assetsManager = app:getAssetsManager()
	self._delegate = nil
end

function VersionChecker:setDelegate(delegate)
	self._delegate = delegate
end

function VersionChecker:getCurrentVersion()
	if self._assetsManager and self._assetsManager.getCurrentVersion then
		return self._assetsManager:getCurrentVersion()
	end

	return -1
end

function VersionChecker:vmsRequest(captainUrl, version, targetV, callBack)
	assert(captainUrl ~= nil, "invalid parameter: captainUrl")

	if self._delegate and self._delegate.vmsReuqestState then
		self._delegate:vmsReuqestState(kVMSState.kVmsStart)
	end

	local xhr = cc.XMLHttpRequest:new()

	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING or 0

	local channel = ""
	local versionPara = ""

	if not targetV and version then
		versionPara = cjson.encode({
			channel = channel,
			version = version,
			did = PlatformHelper:getSdkDid(),
			pass = SDKUtils.getGamePass()
		})
	end

	if app and app.pkgConfig and app.pkgConfig.vmsTargetVersion then
		targetV = app.pkgConfig.vmsTargetVersion
	end

	if version and targetV then
		versionPara = cjson.encode({
			channel = channel,
			version = version,
			targetV = targetV,
			did = PlatformHelper:getSdkDid(),
			pass = SDKUtils.getGamePass()
		})
	end

	xhr:open("POST", captainUrl)

	local function onResponse()
		if self._delegate and self._delegate.vmsReuqestState then
			self._delegate:vmsReuqestState(kVMSState.kVmsEnded)
		end

		local data

		if xhr.status and xhr.status == 200 then
			GameUpdaterDebuger:print("VersionChecker: response of vmsRequest:%s", xhr.response)

			data = self:parseResponse(xhr.response)
		elseif self._delegate and self._delegate.vmsRequestError then
			self._delegate:vmsRequestError(xhr.status, xhr.statusText, xhr.response)
		end

		if callBack then
			callBack(xhr.status, data)
		end

		xhr:unregisterScriptHandler()
	end

	xhr:registerScriptHandler(onResponse)
	xhr:send("opCode=100101&params=" .. versionPara)
end

function VersionChecker:parseResponse(response)
	local cjson = require("cjson.safe")
	local jsonData = cjson.decode(response)
	local retData = jsonData and jsonData.data

	if retData then
		return retData
	else
		GameUpdaterDebuger:print("VersionChecker: response of vmsRequest 'data' field is nil")
	end

	return nil
end
