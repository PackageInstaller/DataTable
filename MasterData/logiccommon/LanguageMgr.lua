-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/lang/LanguageMgr.lua

module("logiccommon.common.lang.LanguageMgr", package.seeall)

local LanguageMgr = class("LanguageMgr")
local USER_LANG_TYPE_SETTING = "user_lang_type_setting"

function LanguageMgr:ctor()
	self._langTipsCfg = nil
	self._languageCfg = nil
	self._languageCfg_1 = nil
	self._curLang = nil
	self._langLoadedCallback = nil
	self._langLoadedCallbackSelf = nil
	self._isInit = false
	self._lang_cfg_map = {}
end

function LanguageMgr:init(langLoadedCallback, langLoadedCallbackSelf)
	Framework.LocalStorage.Instance:SetString(USER_LANG_TYPE_SETTING, LanguageType.ZH)

	local lang = Framework.LocalStorage.Instance:GetString(USER_LANG_TYPE_SETTING, "")

	if lang == "" then
		local systemLang = UnityEngine.Application.systemLanguage
		local systemLangEnum = UnityEngine.SystemLanguage

		lang = (systemLang == systemLangEnum.Chinese or systemLang == systemLangEnum.ChineseSimplified) and LanguageType.ZH or systemLang == systemLangEnum.ChineseTraditional and LanguageType.TW or systemLang == systemLangEnum.Japanese and LanguageType.JP or systemLang == systemLangEnum.Korean and LanguageType.KO or LanguageType.EN
	end

	local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if versionCode == 1144 then
		lang = LanguageType.EN
	end

	self:switchLanguage(lang, langLoadedCallback, langLoadedCallbackSelf)
end

function LanguageMgr:getLanguageType()
	return self._curLang
end

function LanguageMgr:_getExLanguageConfigList()
	local list = {}

	for i = 1, math.huge do
		local path = "language_" .. i
		local ok = pcall(require, ConfigMgr.instance._pathPrefix .. path)

		if ok then
			table.insert(list, path)
		else
			break
		end
	end

	return list
end

function LanguageMgr:switchLanguage(langType, langLoadedCallback, langLoadedCallbackSelf)
	self._curLang = langType
	self._curkey = "content" .. self._curLang
	self._langLoadedCallback = langLoadedCallback
	self._langLoadedCallbackSelf = langLoadedCallbackSelf

	local rcdTime = os.clock()

	if not self._isInit then
		self._tipCfg = {}

		ConfigMgr.instance:requestConfig("lang_tip", self)
		ConfigMgr.instance:requestConfig("language", self)

		local list = self:_getExLanguageConfigList()

		for i, lang_path in ipairs(list) do
			ConfigMgr.instance:requestConfig(lang_path, self)
		end

		self._isInit = true
	end

	printInfo(LogTag.BOOTSTRAP, "LanguageMgr switchLanguage requestConfig lang_tip----------OK-----UseTime:" .. os.clock() - rcdTime)

	local languageManifestPath = string.format("lang/%s/lang_manifest.txt", langType)

	getres(languageManifestPath, self._onLoadedLanguageManifest, self)
end

function LanguageMgr:_onLoadedLanguageManifest(res)
	local rcdTime = os.clock()

	printInfo(LogTag.BOOTSTRAP, "LanguageMgr _onLoadedLanguageManifest--------------")

	local content = res:GetAsset().text
	local langPath = string.format("lang/%s/", self._curLang)
	local langManifest = loadstring(content)()

	setlanguage(langPath, langManifest)
	Framework.LocalStorage.Instance:SetString(USER_LANG_TYPE_SETTING, self._curLang)
	printInfo(LogTag.BOOTSTRAP, "LanguageMgr _onLoadedLanguageManifest----------OK-----UseTime:" .. os.clock() - rcdTime)

	if self._langLoadedCallback then
		if self._langLoadedCallbackSelf then
			self._langLoadedCallback(self._langLoadedCallbackSelf)
		else
			self._langLoadedCallback()
		end
	end
end

function LanguageMgr:handleConfig(name, content)
	self._lang_cfg_map[name] = content
end

function LanguageMgr:getCfgByKey(key)
	for k, content in pairs(self._lang_cfg_map) do
		local cfg = content[key]

		if cfg then
			return cfg
		end
	end

	return nil
end

function langOrNil(key)
	local cfg = LanguageMgr.instance:getCfgByKey(key)

	if cfg then
		return cfg[LanguageMgr.instance._curkey]
	end

	return nil
end

function lang(key)
	if key == 0 then
		return ""
	end

	local cfg = LanguageMgr.instance:getCfgByKey(key)

	if cfg then
		return cfg[LanguageMgr.instance._curkey]
	end

	return key
end

function langPara(key, ...)
	return (___format(lang(key), ...))
end

local reg = "%{%d+%}"
local regMap = {}
local origin_format = string.format

function ___format(str, ...)
	str = origin_format(str, ...)

	local args = {
		...
	}

	return string.gsub(str, reg, function(s)
		local v = regMap[s]

		if v == nil then
			v = tonumber(string.sub(s, 2, string.len(s) - 1))
			regMap[s] = v
		end

		local res

		return (v and v >= 0 or nil) and (args[v + 1] or "")
	end)
end

local languagePath, languageManifest
local hasLanguage = false

function langpath(resPath)
	if string.nilorempty(resPath) then
		return resPath
	end

	if hasLanguage and languageManifest[resPath] then
		return languagePath .. resPath
	end

	return resPath
end

function setlanguage(path, manifest)
	if path and manifest then
		hasLanguage = true
		languagePath = path
		languageManifest = manifest
	else
		hasLanguage = false
		languagePath = nil
		languageManifest = nil
	end
end

setglobal("lang", lang)
setglobal("langPara", langPara)
setglobal("langOrNil", langOrNil)
setglobal("langpath", langpath)
setglobal("MultiResLoader", LangMultiResLoader)
setglobal("PrefabLoader", LangPrefabLoader)

LanguageMgr.instance = LanguageMgr.New()

return LanguageMgr
