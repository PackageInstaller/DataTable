-- chunkname: @projbooter/hotupdate/optionpackage/OptionPackageHttpGetter.lua

module("projbooter.hotupdate.optionpackage.OptionPackageHttpGetter", package.seeall)

local OptionPackageHttpGetter = class("OptionPackageHttpGetter")
local Timeout = 5
local RetryCount = 3
local _ctor_count = 0
local Debug_Url = {}

function OptionPackageHttpGetter:ctor(sourceType, langPackList)
	_ctor_count = _ctor_count + 1
	self._httpId = _ctor_count
	self._sourceType = sourceType or 2
	self._langPackList = {}

	tabletool.addValues(self._langPackList, langPackList)
end

function OptionPackageHttpGetter:getHttpId()
	return self._httpId
end

function OptionPackageHttpGetter:getSourceType()
	return self._sourceType
end

function OptionPackageHttpGetter:getLangPackList()
	return self._langPackList
end

function OptionPackageHttpGetter:start(onFinish, finishObj)
	self._langShortcuts, self._langVersions = self:_getLangVersions()
	self._onGetFinish = onFinish
	self._onGetFinishObj = finishObj
	self._retryCount = 0
	self._useBackupUrl = false

	self:_httpGet()
end

function OptionPackageHttpGetter:stop()
	if self._requestId then
		SLFramework.SLWebRequest.Instance:Stop(self._requestId)

		self._requestId = nil
	end

	self:_stopRetryTimer()
end

function OptionPackageHttpGetter:_httpGet()
	local url = self:_getUrl()

	logNormal("OptionPackageHttpGetter url: " .. url)

	if Debug_Url and Debug_Url[self._sourceType] then
		url = Debug_Url[self._sourceType]

		logNormal("OptionPackageHttpGetter url: " .. Debug_Url[self._sourceType])
	end

	self._requestId = SLFramework.SLWebRequest.Instance:Get(url, self._onWebResponse, self, Timeout)

	self:_stopRetryTimer()
end

function OptionPackageHttpGetter:_onWebResponse(isSuccess, msg, errorMsg)
	if isSuccess then
		if msg and msg ~= "" then
			logNormal("获取可选资源返回:" .. msg)

			self._result = cjson.decode(msg)
		else
			logNormal("获取可选资源返回空串")
		end

		self:_runCallblck(true)
		self:_stopRetryTimer()
	else
		self:_stopRetryTimer()

		self._retryTimer = Timer.New(function()
			self._retryTimer = nil

			if self._retryCount >= RetryCount then
				self._useBackupUrl = not self._useBackupUrl
				self._retryCount = 0

				self:_runCallblck(false)
			else
				self._retryCount = self._retryCount + 1

				self:_httpGet()
			end
		end, 1)

		self._retryTimer:Start()
	end
end

function OptionPackageHttpGetter:_stopRetryTimer()
	if self._retryTimer then
		local timer = self._retryTimer

		self._retryTimer = nil

		timer:Stop()
	end
end

function OptionPackageHttpGetter:_runCallblck(isSuccess)
	if self._onGetFinish == nil then
		return
	end
end

function OptionPackageHttpGetter:getHttpResult()
	return self._result
end

function OptionPackageHttpGetter:getLangSize(lang)
	if not self._result then
		return 0
	end

	local langTb = self._result[lang]

	if not langTb or not langTb.res then
		return 0
	end

	local size = 0

	for _, oneRes in ipairs(langTb.res) do
		size = size + oneRes.length
	end

	return size
end

function OptionPackageHttpGetter:_getUrl()
	local langShortcut = table.concat(self._langShortcuts, ",")
	local langVersion = table.concat(self._langVersions, ",")
	local param = {}
	local url1, url2 = GameUrlConfig.getOptionalUpdateUrl()
	local url = self._useBackupUrl and url2 or url1
	local osType = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		osType = 0
	end

	local serverType = GameChannelConfig.getServerType()

	table.insert(param, string.format("os_type=%s", (GameConfig.Instance.IsMuMu or nil) and 5))
	table.insert(param, string.format("lang=%s", langShortcut))
	table.insert(param, string.format("version=%s", langVersion))
	table.insert(param, string.format("env_type=%s", serverType))
	table.insert(param, string.format("channel_id=%s", SDKMgr.instance:getChannelId()))

	local gameId = SDKMgr.instance:getGameId()
	local suffix = string.format("/resource/%d/check", gameId)

	return url .. suffix .. "?" .. table.concat(param, "&")
end

function OptionPackageHttpGetter:_getLangVersions()
	local optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance
	local langShortcuts = {}
	local langVersions = {}
	local langPackList = self._langPackList
	local branchVersion = self:_getBranchVersion()

	for i = 1, #langPackList do
		local langPackName = langPackList[i]
		local localVersion = optionalUpdateInst:GetLocalVersion(langPackName)
		local version = branchVersion .. "." .. (string.nilorempty(localVersion) and "0" or localVersion)

		table.insert(langShortcuts, langPackName)
		table.insert(langVersions, version)
	end

	return langShortcuts, langVersions
end

function OptionPackageHttpGetter:_getBranchVersion()
	local optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance
	local voiceBranch = optionalUpdateInst.VoiceBranch

	if string.nilorempty(voiceBranch) or not tonumber(voiceBranch) then
		voiceBranch = 1

		logError("随包的语音分支错误：" .. optionalUpdateInst.VoiceBranch)
	end

	return voiceBranch
end

return OptionPackageHttpGetter
