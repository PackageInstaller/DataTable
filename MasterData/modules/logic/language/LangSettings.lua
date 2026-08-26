-- chunkname: @modules/logic/language/LangSettings.lua

module("modules.logic.language.LangSettings", package.seeall)

local LangSettings = class("LangSettings", BaseConfig)

LangSettings.zh = 1
LangSettings.tw = 2
LangSettings.en = 4
LangSettings.kr = 8
LangSettings.jp = 16
LangSettings.de = 32
LangSettings.fr = 64
LangSettings.thai = 128
LangSettings.shortcutTab = {
	[LangSettings.zh] = "zh",
	[LangSettings.tw] = "tw",
	[LangSettings.en] = "en",
	[LangSettings.kr] = "kr",
	[LangSettings.jp] = "jp",
	[LangSettings.de] = "de",
	[LangSettings.fr] = "fr",
	[LangSettings.thai] = "thai"
}
LangSettings.shortCut2LangIdxTab = {
	zh = LangSettings.zh,
	tw = LangSettings.tw,
	en = LangSettings.en,
	kr = LangSettings.kr,
	jp = LangSettings.jp,
	de = LangSettings.de,
	fr = LangSettings.fr,
	thai = LangSettings.thai
}
LangSettings.aihelpKey = {
	[LangSettings.zh] = "zh-CN",
	[LangSettings.tw] = "zh-TW",
	[LangSettings.en] = "en",
	[LangSettings.kr] = "ko",
	[LangSettings.jp] = "ja",
	[LangSettings.de] = "de",
	[LangSettings.fr] = "fr",
	[LangSettings.thai] = "th"
}
LangSettings._captionsSetting = {
	[LangSettings.zh] = true,
	[LangSettings.tw] = true,
	[LangSettings.en] = false,
	[LangSettings.kr] = false,
	[LangSettings.jp] = false
}
LangSettings.pcWindowsTitle = {
	[LangSettings.zh] = "重返未来：1999",
	[LangSettings.tw] = "重返未來：1999",
	[LangSettings.en] = "Reverse: 1999",
	[LangSettings.kr] = "리버스: 1999",
	[LangSettings.jp] = "リバース：1999",
	[LangSettings.de] = "reverse:1999",
	[LangSettings.fr] = "reverse:1999",
	[LangSettings.thai] = "reverse:1999"
}

function LangSettings:ctor()
	self._curLang = GameConfig:GetCurLangType()
	self._defaultLang = GameConfig:GetDefaultLangType()
	self._curLangShortcut = LangSettings.shortcutTab[self._curLang]
	self._captionsActive = LangSettings._captionsSetting[self._curLang] ~= false
	self._supportedLangs = {}

	local cSharpArr = GameConfig:GetSupportedLangs()
	local length = cSharpArr.Length

	for i = 0, length - 1 do
		self._supportedLangs[cSharpArr[i]] = true
	end

	cSharpArr = nil
end

function LangSettings:loadLangConfig(callback, callbackObj)
	self._onLoadedCallback = callback
	self._onLoadedCallbackObj = callbackObj

	if GameResMgr.IsFromEditorDir then
		local configPath = "configs/language/json_language_" .. self._curLangShortcut .. ".json"

		loadNonAbAsset(configPath, SLFramework.AssetType.TEXT, self._onConfigAbCallback, self)

		configPath = "configs/language/json_language_server_" .. self._curLangShortcut .. ".json"

		loadNonAbAsset("configs/language/json_language_server_" .. self._curLangShortcut .. ".json", SLFramework.AssetType.TEXT, self._onServerConfigAbCallback, self)
	else
		local abPath = "configs/language/json_language_" .. self._curLangShortcut .. ".json.dat"

		loadNonAbAsset(abPath, SLFramework.AssetType.DATA, self._onConfigAbCallback, self)

		abPath = "configs/language/json_language_server_" .. self._curLangShortcut .. ".json.dat"

		loadNonAbAsset("configs/language/json_language_server_" .. self._curLangShortcut .. ".json.dat", SLFramework.AssetType.DATA, self._onServerConfigAbCallback, self)
	end
end

function LangSettings:_onServerConfigAbCallback(assetItem)
	local jsonString
	local json = cjson.decode(GameResMgr.IsFromEditorDir and assetItem.TextAsset or assetItem:GetNonAbTextAsset(true))
	local configText = json[2]

	LangConfig.instance:updateServerLanguage(configText)
end

function LangSettings:_onConfigAbCallback(assetItem)
	local jsonString
	local json = cjson.decode(GameResMgr.IsFromEditorDir and assetItem.TextAsset or assetItem:GetNonAbTextAsset(true))
	local configText = json[2]

	LangConfig.instance:updateLanguage(configText)

	if self._onLoadedCallback then
		if self._onLoadedCallbackObj then
			self._onLoadedCallback(self._onLoadedCallbackObj)
		else
			self._onLoadedCallback()
		end
	end

	ZProj.MaterialPropsTMPCtrl.useSubMesh = self._curLang == LangSettings.jp
	self._onLoadedCallback = nil
	self._onLoadedCallbackObj = nil
end

function LangSettings:init()
	GameLanguageMgr.instance:setStoryIndexByShortCut(self._curLangShortcut)

	if BootNativeUtil.isWindows() then
		local preTitle = PlayerPrefsHelper.getString(PlayerPrefsKey.WindowsTitle, nil)

		if not string.nilorempty(preTitle) then
			return
		end

		local curTitle = LangSettings.pcWindowsTitle[self._curLang]

		if not curTitle then
			logError("can not get windows title for cur lang = " .. self._curLangShortcut)

			return
		end

		ZProj.WindowsHelper.Instance:SetWindowsTitle(curTitle)
		PlayerPrefsHelper.setString(PlayerPrefsKey.WindowsTitle, curTitle)
	end
end

function LangSettings:getCostumerServiceName()
	if SettingsModel.instance:isZhRegion() then
		return "深蓝互动"
	end

	local curTitle = LangSettings.pcWindowsTitle[self._curLang]

	if not curTitle then
		logError("can not get windows title for cur lang = " .. self._curLangShortcut)

		return ""
	end

	return curTitle
end

function LangSettings:supportLang(lang)
	return self._supportedLangs[lang] ~= nil
end

function LangSettings:langCaptionsActive()
	return self._captionsActive
end

function LangSettings:getCurLang()
	return self._curLang
end

function LangSettings:getDefaultLang()
	return self._defaultLang
end

function LangSettings:getCurLangShortcut()
	return LangSettings.shortcutTab[self._curLang]
end

function LangSettings:getDefaultLangShortcut()
	return LangSettings.shortcutTab[self._defaultLang]
end

function LangSettings:getCurLangKeyByShortCut(ignoreChannel)
	local curLang = self:getCurLangShortcut()

	if not ignoreChannel and GameChannelConfig.isEfun() then
		return LanguageEnum.Lang2KeyEFun[curLang] or curLang
	end

	return LanguageEnum.Lang2KeyGlobal[curLang] or curLang
end

function LangSettings:SetCurLangType(curLang, callback, callbackObj)
	for langType, shortcut in pairs(LangSettings.shortcutTab) do
		if shortcut == curLang then
			self._curLang = langType

			break
		end
	end

	self._curLangShortcut = curLang
	self._captionsActive = LangSettings._captionsSetting[self._curLang] ~= false

	SLFramework.LanguageMgr.Instance:SetCurLangType(curLang)
	GameLanguageMgr.instance:setStoryIndexByShortCut(curLang)
	self:loadLangConfig(callback, callbackObj)
end

function LangSettings:_lang(id)
	return LangConfig.instance:getLangTxt(self._curLangShortcut, id)
end

function LangSettings:_serverLang(id)
	return LangConfig.instance:getServerLangTxt(self._curLangShortcut, id)
end

function LangSettings:_luaLang(key)
	return LangConfig.instance:getLangTxtFromeKey(self._curLangShortcut, key)
end

LangSettings.empty = ""

function LangSettings:_formatLuaLang(...)
	local args = ...

	if args == nil then
		logError("LangSettings._formatLuaLang args can not be nil!")

		return LangSettings.empty
	end

	args = {
		...
	}

	local key = args[1]

	if key == nil then
		logError("LangSettings._formatLuaLang key can not be nil!")

		return LangSettings.empty
	end

	local moudle = self:_luaLang(key)

	return string.format(moudle, unpack(args, 2))
end

function LangSettings:_langVideoUrl(videoName)
	local info = video_lang.configDict[videoName]
	local curLang = GameConfig:GetCurVoiceShortcut()
	local defaultLang = GameConfig:GetDefaultVoiceShortcut()

	if info then
		if tabletool.indexOf(info.supportLang, curLang) then
			local langVideoName = string.format("%s/%s", curLang, videoName)

			return ResUrl.getVideo(langVideoName)
		elseif tabletool.indexOf(info.supportLang, defaultLang) then
			local langVideoName = string.format("%s/%s", defaultLang, videoName)

			return ResUrl.getVideo(langVideoName)
		end
	end

	return ResUrl.getVideo(videoName)
end

LangSettings.instance = LangSettings.New()

function lang(id)
	return LangSettings.instance:_lang(id)
end

function serverLang(id)
	return LangSettings.instance:_serverLang(id)
end

function luaLang(key)
	return LangSettings.instance:_luaLang(key)
end

function formatLuaLang(...)
	return LangSettings.instance:_formatLuaLang(...)
end

function luaLangUTC(key)
	local str = luaLang(key)

	if LangSettings.instance:isOverseas() then
		str = ServerTime.ReplaceUTCStr(str)
	else
		str = string.gsub(str, "%(UTC%+8%)", "")
		str = string.gsub(str, "（UTC%+8）", "")
	end

	return str
end

function LangSettings:isOverseas()
	if self.__isOverseas == nil then
		local gameId = SDKMgr.instance:getGameId()

		self.__isOverseas = tostring(gameId) ~= "50001"
	end

	return self.__isOverseas
end

function LangSettings:isZh()
	return self:getCurLang() == LangSettings.zh
end

function LangSettings:isTw()
	return self:getCurLang() == LangSettings.tw
end

function LangSettings:isEn()
	return self:getCurLang() == LangSettings.en
end

function LangSettings:isKr()
	return self:getCurLang() == LangSettings.kr
end

function LangSettings:isJp()
	return self:getCurLang() == LangSettings.jp
end

function LangSettings:isDe()
	return self:getCurLang() == LangSettings.de
end

function LangSettings:isFr()
	return self:getCurLang() == LangSettings.fr
end

function LangSettings:isThai()
	return self:getCurLang() == LangSettings.thai
end

function langVideoUrl(videoName)
	return LangSettings.instance:_langVideoUrl(videoName)
end

setGlobal("lang", lang)
setGlobal("serverLang", serverLang)
setGlobal("luaLang", luaLang)
setGlobal("formatLuaLang", formatLuaLang)
setGlobal("langVideoUrl", langVideoUrl)
setGlobal("luaLangUTC", luaLangUTC)

return LangSettings
