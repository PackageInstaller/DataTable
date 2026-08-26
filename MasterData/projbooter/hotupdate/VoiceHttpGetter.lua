-- chunkname: @projbooter/hotupdate/VoiceHttpGetter.lua

module("projbooter.hotupdate.VoiceHttpGetter", package.seeall)

local VoiceHttpGetter = class("VoiceHttpGetter")
local Timeout = 5

function VoiceHttpGetter:start(onFinish, finishObj)
	self._langShortcuts, self._langVersions = self:_getLangVersions()

	if #self._langShortcuts == 0 then
		onFinish(finishObj)

		return
	end

	self._onGetFinish = onFinish
	self._onGetFinishObj = finishObj

	self:_httpGet()
end

function VoiceHttpGetter:_httpGet()
	local url = self:_getUrl()

	logNormal("OptionalUpdate url: " .. url)

	local webRequest = UnityEngine.Networking.UnityWebRequest.Get(url)
	local slInfoBase64 = SLFramework.GameUpdate.HotUpdateInfoMgr.SLInfoBase64

	webRequest:SetRequestHeader("x-sl-info", slInfoBase64)
	SLFramework.SLWebRequest.Instance:SendRequest(webRequest, self._onWebResponse, self, Timeout)
end

function VoiceHttpGetter:_onWebResponse(isSuccess, msg, errorMsg)
	if isSuccess then
		if msg and msg ~= "" then
			logNormal("获取语音包返回:" .. msg)

			self._result = cjson.decode(msg)
		else
			logNormal("获取语音包返回空串")
		end

		BootLoadingView.instance:setProgressMsg("")
		HotUpdateMgr.instance:hideConnectTips()

		local url1, url2 = GameUrlConfig.getOptionalUpdateUrl()
		local domain = HotUpdateMgr.instance:getUseBackup() and url2 or url1

		SDKDataTrackMgr.instance:trackDomainFailCount("scene_voice_srcrequest", domain, HotUpdateMgr.instance:getFailCount())
		HotUpdateMgr.instance:resetFailCount()

		local cb = self._onGetFinish
		local cbObj = self._onGetFinishObj

		self._onGetFinish = nil
		self._onGetFinishObj = nil

		if BootVoiceView.instance:isNeverOpen() then
			BootVoiceView.instance:showChoose(cb, cbObj)
		else
			self._onGetFinish(cbObj)
		end
	else
		HotUpdateMgr.instance:inverseUseBackup()
		HotUpdateMgr.instance:incFailCount()

		if HotUpdateMgr.instance:isFailNeedAlert() then
			HotUpdateMgr.instance:resetFailAlertCount()

			local args = {}

			args.title = booterLang("version_validate")
			args.content = booterLang("version_validate_voice_fail") .. (errorMsg or "null")
			args.leftMsg = booterLang("exit")
			args.leftCb = self._quitGame
			args.leftCbObj = self
			args.rightMsg = booterLang("retry")
			args.rightCb = self._httpGet
			args.rightCbObj = self

			BootMsgBox.instance:show(args)
			BootLoadingView.instance:setProgressMsg("")
			HotUpdateMgr.instance:hideConnectTips()
		else
			self:_httpGet()
			HotUpdateMgr.instance:showConnectTips()
		end
	end
end

function VoiceHttpGetter:_quitGame()
	logNormal("可选语音重试超过了 " .. HotUpdateMgr.FailAlertCount .. " 次，点击了退出按钮！")
	ProjBooter.instance:quitGame()
end

function VoiceHttpGetter:getHttpResult()
	return self._result
end

function VoiceHttpGetter:_getUrl()
	local langShortcut = table.concat(self._langShortcuts, ",")
	local langVersion = table.concat(self._langVersions, ",")
	local param = {}
	local url1, url2 = GameUrlConfig.getOptionalUpdateUrl()
	local url = HotUpdateMgr.instance:getUseBackup() and url2 or url1
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

function VoiceHttpGetter:_getLangVersions()
	local optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance
	local langShortcuts = {}
	local langVersions = {}
	local supportLangList = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()

	if not tabletool.indexOf(supportLangList, "jp") then
		table.insert(supportLangList, "jp")
	end

	if not tabletool.indexOf(supportLangList, "kr") then
		table.insert(supportLangList, "kr")
	end

	table.insert(supportLangList, "res-HD")

	local defaultLang = GameConfig:GetDefaultVoiceShortcut()

	for i = 1, #supportLangList do
		local lang = supportLangList[i]
		local notDefault = lang ~= defaultLang
		local localVersion = optionalUpdateInst:GetLocalVersion(lang)
		local hasLocalVersion = not string.nilorempty(localVersion)
		local notDownloadDone = not BootVoiceView.instance:isFirstDownloadDone()

		if notDefault and (hasLocalVersion or notDownloadDone) then
			table.insert(langShortcuts, lang)

			local voiceBranch = optionalUpdateInst.VoiceBranch

			if string.nilorempty(voiceBranch) or not tonumber(voiceBranch) then
				voiceBranch = 1

				logError("随包的语音分支错误：" .. optionalUpdateInst.VoiceBranch)
			end

			local version = voiceBranch .. "." .. (string.nilorempty(localVersion) and "0" or localVersion)

			table.insert(langVersions, version)
		end
	end

	return langShortcuts, langVersions
end

return VoiceHttpGetter
