-- chunkname: @projbooter/hotupdate/HotUpdateVoiceMgr.lua

module("projbooter.hotupdate.HotUpdateVoiceMgr", package.seeall)

local HotUpdateVoiceMgr = class("HotUpdateVoiceMgr")

HotUpdateVoiceMgr.EnableEditorDebug = false

local GuoFuGameId = 50001

HotUpdateVoiceMgr.IsGuoFu = false
HotUpdateVoiceMgr.LangEn = "en"
HotUpdateVoiceMgr.LangZh = "zh"
HotUpdateVoiceMgr.HD = "res-HD"
HotUpdateVoiceMgr.LangSortOrderDefault = {
	jp = 3,
	kr = 4,
	zh = 2,
	en = 1
}
HotUpdateVoiceMgr.LangSortOrderDict = {
	en = {
		jp = 2,
		kr = 4,
		zh = 3,
		en = 1
	},
	tw = {
		jp = 2,
		kr = 4,
		zh = 3,
		en = 1
	},
	jp = {
		jp = 1,
		kr = 4,
		zh = 3,
		en = 2
	},
	kr = {
		kr = 1,
		jp = 4,
		zh = 3,
		en = 2
	}
}
HotUpdateVoiceMgr.ForceSelect = {
	[HotUpdateVoiceMgr.LangEn] = true,
	[HotUpdateVoiceMgr.LangZh] = true
}

function HotUpdateVoiceMgr:init()
	self._optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance

	self._optionalUpdateInst:Init()

	self._httpGetter = VoiceHttpGetter.New()
	self._downloader = VoiceDownloader.New()
	HotUpdateVoiceMgr.IsGuoFu = tonumber(SDKMgr.instance:getGameId()) == GuoFuGameId

	if not HotUpdateVoiceMgr.IsGuoFu then
		HotUpdateVoiceMgr.ForceSelect = {}
	end

	if BootNativeUtil.isWindows() or BootNativeUtil.isMuMu() then
		HotUpdateVoiceMgr.ForceSelect[HotUpdateVoiceMgr.HD] = true
	end
end

local defaultVoice, orderDict
local sameOrderSortOrder = {}

function HotUpdateVoiceMgr:getSupportVoiceLangs()
	local cSharpArr = GameConfig:GetSupportedVoiceShortcuts()
	local length = cSharpArr.Length
	local list = {}
	local defaultLang = GameConfig:GetDefaultLangShortcut()

	defaultVoice = GameConfig:GetDefaultVoiceShortcut()
	orderDict = HotUpdateVoiceMgr.LangSortOrderDict[defaultLang] or HotUpdateVoiceMgr.LangSortOrderDefault

	for i = 0, length - 1 do
		local lang = cSharpArr[i]

		table.insert(list, lang)

		sameOrderSortOrder[lang] = i + 1
	end

	table.sort(list, HotUpdateVoiceMgr._sortLang)

	cSharpArr = nil

	return list
end

function HotUpdateVoiceMgr._sortLang(lang1, lang2)
	if lang1 == defaultVoice then
		return true
	elseif lang2 == defaultVoice then
		return false
	elseif not orderDict[lang1] then
		local order1 = 999

		if not orderDict[lang2] then
			local order2 = 999

			if order1 ~= order2 then
				return order1 < order2
			end

			order1 = sameOrderSortOrder[lang1]
			order2 = sameOrderSortOrder[lang2]

			return sameOrderSortOrder[lang1] < sameOrderSortOrder[lang2]
		end
	end
end

function HotUpdateVoiceMgr:showDownload(onFinish, finishObj)
	if VersionValidator.instance:isInReviewing() then
		onFinish(finishObj)
	elseif GameResMgr.IsFromEditorDir and not HotUpdateVoiceMgr.EnableEditorDebug then
		onFinish(finishObj)
	else
		self._httpGetter:start(onFinish, finishObj)
	end
end

function HotUpdateVoiceMgr:startDownload(onFinish, finishObj)
	if VersionValidator.instance:isInReviewing() then
		onFinish(finishObj)
	elseif GameResMgr.IsFromEditorDir and not HotUpdateVoiceMgr.EnableEditorDebug then
		onFinish(finishObj)
	elseif BootNativeUtil.isIOS() and HotUpdateMgr.instance:hasHotUpdate() then
		logNormal("热更新紧接着语音更新，延迟开始")

		local timer = Timer.New(function()
			logNormal("语音更新开始")
			self._downloader:start(onFinish, finishObj)
		end, 1.5)

		timer:Start()
	else
		self._downloader:start(onFinish, finishObj)
	end
end

function HotUpdateVoiceMgr:getHttpResult()
	return self._httpGetter:getHttpResult()
end

function HotUpdateVoiceMgr:getLangSize(lang)
	local result = self:getHttpResult()

	if not result then
		return 0
	end

	local langTb = result[lang]

	if not langTb or not langTb.res then
		return 0
	end

	local size = 0

	for _, oneRes in ipairs(langTb.res) do
		size = size + oneRes.length
	end

	return size
end

function HotUpdateVoiceMgr:getTotalSize()
	local result = self:getHttpResult()

	if not result then
		return 0
	end

	local isFirstDownloadDone = BootVoiceView.instance:isFirstDownloadDone()
	local size = 0
	local choices = BootVoiceView.instance:getDownloadChoices()

	for lang, langTb in pairs(result) do
		local needDownload = false

		if isFirstDownloadDone then
			local localVersion = self._optionalUpdateInst:GetLocalVersion(lang)

			needDownload = not string.nilorempty(localVersion)
		else
			needDownload = tabletool.indexOf(choices, lang)
		end

		if langTb.res and needDownload then
			for _, oneRes in ipairs(langTb.res) do
				size = size + oneRes.length
			end
		end
	end

	return size
end

function HotUpdateVoiceMgr:getNeedDownloadSize()
	local result = self:getHttpResult()

	if not result then
		return 0
	end

	local size = self:getTotalSize()

	for lang, langTb in pairs(result) do
		local downloadList = self:getDownloadList(lang)

		if downloadList then
			local names = {}
			local hashs = {}
			local orders = {}
			local lengths = {}

			for _, one in ipairs(downloadList) do
				table.insert(names, one.name)
				table.insert(hashs, one.hash)
				table.insert(orders, one.order)
				table.insert(lengths, one.length)
			end

			self._optionalUpdateInst:InitBreakPointInfo(names, hashs, orders, lengths)

			local recvSize = self._optionalUpdateInst:GetRecvSize()

			recvSize = tonumber(recvSize)
			size = size - recvSize
		end
	end

	return size
end

function HotUpdateVoiceMgr:getDownloadUrl(lang)
	local result = self:getHttpResult()

	if not result then
		return
	end

	local langInfo = result[lang]

	if langInfo then
		return langInfo.download_url, langInfo.download_url_bak
	end
end

function HotUpdateVoiceMgr:getDownloadList(lang)
	local result = self:getHttpResult()

	if not result then
		return
	end

	local langInfo = result[lang]

	if #langInfo.res > 0 then
		local langDownloadList = {}

		for _, oneRes in ipairs(langInfo.res) do
			local downloadInfo = {}

			downloadInfo.latest_ver = langInfo.latest_ver
			downloadInfo.name = oneRes.name
			downloadInfo.hash = oneRes.hash
			downloadInfo.order = oneRes.order
			downloadInfo.length = oneRes.length

			table.insert(langDownloadList, downloadInfo)
		end

		table.sort(langDownloadList, HotUpdateVoiceMgr._sortByOrder)

		return langDownloadList
	end
end

function HotUpdateVoiceMgr:stop()
	self._downloader:cancelDownload()
end

function HotUpdateVoiceMgr:getAllLangDownloadList()
	local isFirstDownloadDone = BootVoiceView.instance:isFirstDownloadDone()
	local choices = BootVoiceView.instance:getDownloadChoices()
	local result = self:getHttpResult()

	if not result then
		return {}
	end

	local ret = {}

	for lang, langInfo in pairs(result) do
		local needDownload = false

		if isFirstDownloadDone then
			local localVersion = self._optionalUpdateInst:GetLocalVersion(lang)

			needDownload = not string.nilorempty(localVersion)
		else
			needDownload = tabletool.indexOf(choices, lang)
		end

		if #langInfo.res > 0 and needDownload then
			local langDownloadList = {}

			for _, oneRes in ipairs(langInfo.res) do
				local downloadInfo = {}

				downloadInfo.latest_ver = langInfo.latest_ver
				downloadInfo.name = oneRes.name
				downloadInfo.hash = oneRes.hash
				downloadInfo.order = oneRes.order
				downloadInfo.length = oneRes.length

				table.insert(langDownloadList, downloadInfo)
			end

			table.sort(langDownloadList, HotUpdateVoiceMgr._sortByOrder)

			ret[lang] = langDownloadList
		end
	end

	return ret
end

function HotUpdateVoiceMgr._sortByOrder(info1, info2)
	return info1.order < info2.order
end

HotUpdateVoiceMgr.instance = HotUpdateVoiceMgr.New()

return HotUpdateVoiceMgr
