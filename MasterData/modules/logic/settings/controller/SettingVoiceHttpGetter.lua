-- chunkname: @modules/logic/settings/controller/SettingVoiceHttpGetter.lua

module("modules.logic.settings.controller.SettingVoiceHttpGetter", package.seeall)

local SettingVoiceHttpGetter = class("SettingVoiceHttpGetter")
local Timeout = 5

function SettingVoiceHttpGetter:start(onFinish, finishObj)
	self._langShortcuts, self._langVersions = self:_getLangVersions()

	if #self._langShortcuts == 0 then
		self._result = {}

		onFinish(finishObj)

		return
	end

	self._onGetFinish = onFinish
	self._onGetFinishObj = finishObj

	self:_httpGet()
end

function SettingVoiceHttpGetter:stop()
	if self._requestId then
		SLFramework.SLWebRequest.Instance:Stop(self._requestId)

		self._requestId = nil

		UIBlockMgr.instance:endBlock(UIBlockKey.VoiceHttpGetter)
	end
end

function SettingVoiceHttpGetter:_httpGet()
	UIBlockMgr.instance:startBlock(UIBlockKey.VoiceHttpGetter)

	local url = self:_getUrl()

	logNormal("SettingVoiceHttpGetter url: " .. url)

	self._requestId = SLFramework.SLWebRequest.Instance:Get(url, self._onWebResponse, self, Timeout)
end

function SettingVoiceHttpGetter:_onWebResponse(isSuccess, msg, errorMsg)
	if isSuccess then
		LoginModel.instance:resetFailCount()
		UIBlockMgr.instance:endBlock(UIBlockKey.VoiceHttpGetter)

		if msg and msg ~= "" then
			logNormal("获取语音包返回:" .. msg)

			self._result = cjson.decode(msg)
		else
			logNormal("获取语音包返回空串")
		end
	else
		LoginModel.instance:inverseUseBackup()
		LoginModel.instance:incFailCount()

		if LoginModel.instance:isFailNeedAlert() then
			LoginModel.instance:resetFailAlertCount()
			UIBlockMgr.instance:endBlock(UIBlockKey.VoiceHttpGetter)

			self._useBackupUrl = not self._useBackupUrl

			local id = MessageBoxIdDefine.CheckVersionFail
			local t = MsgBoxEnum.BoxType.Yes_No

			MessageBoxController.instance:showMsgBoxAndSetBtn(id, t, booterLang("retry"), "retry", nil, nil, self._httpGet, nil, nil, self, nil, nil, errorMsg)
		else
			self:_httpGet()
		end
	end
end

function SettingVoiceHttpGetter:getHttpResult()
	return self._result
end

function SettingVoiceHttpGetter:getLangSize(lang)
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

function SettingVoiceHttpGetter:_getUrl()
	local langShortcut = table.concat(self._langShortcuts, ",")
	local langVersion = table.concat(self._langVersions, ",")
	local param = {}
	local url1, url2 = GameUrlConfig.getOptionalUpdateUrl()
	local url = LoginModel.instance:getUseBackup() and url2 or url1
	local serverType = GameChannelConfig.getServerType()

	table.insert(param, string.format("os_type=%s", (SLFramework.FrameworkSettings.IsEditor or nil) and 0))
	table.insert(param, string.format("lang=%s", langShortcut))
	table.insert(param, string.format("version=%s", langVersion))
	table.insert(param, string.format("env_type=%s", serverType))
	table.insert(param, string.format("channel_id=%s", SDKMgr.instance:getChannelId()))

	local gameId = SDKMgr.instance:getGameId()
	local suffix = string.format("/resource/%d/check", gameId)

	return url .. suffix .. "?" .. table.concat(param, "&")
end

function SettingVoiceHttpGetter:_getLangVersions()
	local optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance
	local langShortcuts = {}
	local langVersions = {}
	local supportLangList = SettingsVoicePackageModel.instance:getSupportVoiceLangs()

	table.insert(supportLangList, "res-HD")

	local defaultLang = GameConfig:GetDefaultVoiceShortcut()

	for i = 1, #supportLangList do
		local lang = supportLangList[i]
		local notDefault = lang ~= defaultLang
		local localVersion = optionalUpdateInst:GetLocalVersion(lang)
		local noLocalVersion = string.nilorempty(localVersion)

		if notDefault and noLocalVersion then
			table.insert(langShortcuts, lang)

			local voiceBranch = optionalUpdateInst.VoiceBranch

			if string.nilorempty(voiceBranch) or not tonumber(voiceBranch) then
				voiceBranch = 1

				logError("随包的语音分支错误：" .. optionalUpdateInst.VoiceBranch)
			end

			local version = voiceBranch .. ".0"

			table.insert(langVersions, version)
		end
	end

	return langShortcuts, langVersions
end

return SettingVoiceHttpGetter
