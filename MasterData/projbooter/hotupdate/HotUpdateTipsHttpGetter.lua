-- chunkname: @projbooter/hotupdate/HotUpdateTipsHttpGetter.lua

module("projbooter.hotupdate.HotUpdateTipsHttpGetter", package.seeall)

local HotUpdateTipsHttpGetter = class("HotUpdateTipsHttpGetter")
local Timeout = 5
local RetryCount = 2
local LangAihelpKey = {
	"zh-CN",
	"zh-TW",
	nil,
	"en",
	nil,
	nil,
	nil,
	"ko-KR",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"ja-JP",
	[32] = "de",
	[128] = "th",
	[64] = "fr"
}

local function func_json_decode(jsonStr)
	return cjson.decode(jsonStr)
end

function HotUpdateTipsHttpGetter:ctor()
	return
end

function HotUpdateTipsHttpGetter:start(onFinish, finishObj)
	self._onGetFinish = onFinish
	self._onGetFinishObj = finishObj
	self._retryCount = 0
	self._useBackupUrl = false

	self:_httpGet()
end

function HotUpdateTipsHttpGetter:stop()
	if self._requestId then
		SLFramework.SLWebRequest.Instance:Stop(self._requestId)

		self._requestId = nil
	end

	self:_stopRetryTimer()
end

function HotUpdateTipsHttpGetter:_httpGet()
	local url = self:_getUrl()

	logNormal(url)

	local webRequest = UnityEngine.Networking.UnityWebRequest.Get(url)
	local slInfoBase64 = SLFramework.GameUpdate.HotUpdateInfoMgr.SLInfoBase64

	webRequest:SetRequestHeader("x-sl-info", slInfoBase64)

	self._requestId = SLFramework.SLWebRequest.Instance:SendRequest(webRequest, self._onWebResponse, self, Timeout)

	self:_stopRetryTimer()
end

function HotUpdateTipsHttpGetter:_onWebResponse(isSuccess, msg, errorMsg)
	if isSuccess then
		if msg and msg ~= "" then
			logNormal("获取更新提示语返回:" .. msg)

			local isOk, result = xpcall(func_json_decode, __G__TRACKBACK__, msg)

			self._result = nil

			if isOk then
				self._result = result
			end
		else
			logNormal("获取更新提示语返回")
		end

		self:_runCallblck(true)
		self:_stopRetryTimer()
	else
		self:_stopRetryTimer()

		self._retryTimer = Timer.New(function()
			self._retryTimer = nil

			if self._retryCount >= RetryCount and not self._useBackupUrl then
				self._useBackupUrl = true
				self._retryCount = 0
			end

			if self._retryCount >= RetryCount then
				self:_runCallblck(false)
			else
				self._retryCount = self._retryCount + 1

				self:_httpGet()
			end
		end, 1)

		self._retryTimer:Start()
	end
end

function HotUpdateTipsHttpGetter:_stopRetryTimer()
	if self._retryTimer then
		local timer = self._retryTimer

		self._retryTimer = nil

		timer:Stop()
	end
end

function HotUpdateTipsHttpGetter:_runCallblck(isSuccess)
	if self._onGetFinish == nil then
		return
	end
end

function HotUpdateTipsHttpGetter:getHttpResult()
	return self._result
end

function HotUpdateTipsHttpGetter:getTipsStr()
	local result = self._result

	if result and result.code == 200 and result.data and result.data.prompt then
		return result.data.prompt
	end

	return nil
end

function HotUpdateTipsHttpGetter:_getUrl()
	local param = {}
	local url1, url2 = GameUrlConfig.getHotUpdateUrl()
	local url = self._useBackupUrl and url2 or url1
	local osType = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		osType = 0
	end

	local defaultLang = GameConfig:GetDefaultLangType()
	local serverType = GameChannelConfig.getServerType()
	local versionName = UnityEngine.Application.version

	table.insert(param, string.format("gameId=%s", SDKMgr.instance:getGameId()))
	table.insert(param, string.format("osType=%s", (GameConfig.Instance.IsMuMu or nil) and 5))
	table.insert(param, string.format("currentVersion=%s", versionName))
	table.insert(param, string.format("channelId=%s", SDKMgr.instance:getChannelId()))
	table.insert(param, string.format("subChannelId=%s", SDKMgr.instance:getSubChannelId()))
	table.insert(param, string.format("serverType=%s", serverType))
	table.insert(param, string.format("lang=%s", LangAihelpKey[defaultLang]))

	return url .. "/prompt/get?" .. table.concat(param, "&")
end

return HotUpdateTipsHttpGetter
