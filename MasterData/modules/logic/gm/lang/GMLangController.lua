-- chunkname: @modules/logic/gm/lang/GMLangController.lua

module("modules.logic.gm.lang.GMLangController", package.seeall)

local GMLangController = class("GMLangController", BaseController)

GameUtil.getEventId()

local _getSubPlaceholderLuaLang = GameUtil.getSubPlaceholderLuaLang

function GMLangController.getSubPlaceholderLuaLang(text, fillParams)
	local langDic = GMLangController.instance:cur2AllLang(text)

	if fillParams and #fillParams > 0 then
		text = _getSubPlaceholderLuaLang(text, fillParams)

		if not GMLangController.instance:checkHasCache(text) then
			GMLangController.instance._inUseDic[text] = {}

			for shortcut, str in pairs(langDic or {}) do
				GMLangController.instance._inUseDic[text][shortcut] = _getSubPlaceholderLuaLang(str, fillParams)
			end

			GMLangController.instance:dispatchInUseUpdate(text)
		end
	end

	return text
end

function GMLangController.lang(id)
	local cur = LangSettings.instance:_lang(id)

	GMLangController.instance:updateInUseId(cur, id)

	return cur
end

function GMLangController.luaLang(key)
	local cur = LangSettings.instance:_luaLang(key)

	GMLangController.instance:updateInUse(cur, key)

	return cur
end

function GMLangController.formatLuaLang(...)
	local cur = LangSettings.instance:_formatLuaLang(...)

	GMLangController.instance:updateFormatInUse(cur, ...)

	return cur
end

function GMLangController:updateInUseId(cur, id)
	if self:checkHasCache(cur) then
		return
	end

	self._inUseDic[cur] = {}

	for shortcuts, v in pairs(self._langDic) do
		self._inUseDic[cur][shortcuts] = self:getLangTxt(shortcuts, id)
	end

	GMLangController.instance:dispatchInUseUpdate(cur)
end

function GMLangController:updateInUse(cur, key)
	if self:checkHasCache(cur) then
		return
	end

	self._inUseDic[cur] = {}

	for shortcuts, v in pairs(self._langDic) do
		self._inUseDic[cur][shortcuts] = self:getLangTxtFromeKey(shortcuts, key)
	end

	GMLangController.instance:dispatchInUseUpdate(cur)
end

function GMLangController:updateFormatInUse(cur, ...)
	if self:checkHasCache(cur) then
		return
	end

	self._inUseDic[cur] = {}

	for shortcuts, v in pairs(self._langDic) do
		self._inUseDic[cur][shortcuts] = self:_formatLuaLang(shortcuts, ...)
	end

	GMLangController.instance:dispatchInUseUpdate(cur)
end

function GMLangController:checkHasCache(cur)
	return self._inUseDic[cur] ~= nil
end

function GMLangController:cur2AllLang(cur)
	return self._inUseDic[cur] or {}
end

if GameResMgr.IsFromEditorDir then
	require("tolua.reflection")
	tolua.loadassembly("ZProj.Editor")
	tolua.loadassembly("System.Core")

	local Type_String = tolua.findtype("System.String")
	local t = tolua.findtype("ZProjEditor.LangTextSearchWindows")

	GMLangController.AddMsg = tolua.getmethod(t, "AddMsg", Type_String)
end

function GMLangController:dispatchInUseUpdate(cur)
	if GameResMgr.IsFromEditorDir then
		GMLangController.AddMsg:Call(cur)
	end

	GMLangTxtModel.instance:addLangTxt(cur)
end

function GMLangController:print()
	for i, v in pairs(self._inUseDic) do
		logNormal(i, "===================================")

		for shortcuts, n in pairs(v) do
			logNormal(shortcuts, ":", n)
		end
	end
end

function GMLangController:getInUseDic()
	return self._inUseDic
end

function GMLangController:clearInUse()
	tabletool.clear(self._inUseDic)
	GMLangTxtModel.instance:clearAll()
end

function GMLangController:hasInit()
	return self._hasInit
end

function GMLangController:init()
	if self._hasInit then
		return self._hasInit
	end

	self._hasInit = true

	setGlobal("lang", GMLangController.lang)
	setGlobal("luaLang", GMLangController.luaLang)
	setGlobal("formatLuaLang", GMLangController.formatLuaLang)

	GameUtil.getSubPlaceholderLuaLang = GMLangController.getSubPlaceholderLuaLang
	self._langDic = {}
	self._inUseDic = {}

	local curLang = GameConfig:GetCurLangShortcut()
	local _supportedLangShortcuts = GameConfig:GetSupportedLangShortcuts()

	self._supportedLangCount = _supportedLangShortcuts.Length

	for i = 0, self._supportedLangCount - 1 do
		local shortcut = _supportedLangShortcuts[i]

		if GameResMgr.IsFromEditorDir then
			local configPath = "configs/language/json_language_" .. shortcut .. ".json"

			loadNonAbAsset(configPath, SLFramework.AssetType.TEXT, self._onConfigAbCallback, self)
		else
			local abPath = "configs/language/json_language_" .. shortcut .. ".json.dat"

			loadNonAbAsset(abPath, SLFramework.AssetType.DATA, self._onConfigAbCallback, self)
		end
	end

	return self._hasInit
end

function GMLangController:changeLang(langeKey)
	LangSettings.instance:SetCurLangType(langeKey, self._onChangeLangTxtType2, self)
	GameGlobalMgr.instance:getLangFont():changeFontAsset()
	GameGlobalMgr.instance:getLangFont():ControlDoubleEn()

	local newDic = {}

	for i, v in pairs(self._inUseDic) do
		local newKey = v[langeKey]

		newDic[newKey] = v
	end

	self._inUseDic = newDic
end

function GMLangController:_onChangeLangTxtType2()
	local curLang = GameConfig:GetCurLangShortcut()
	local lanIndex = GameLanguageMgr.instance:getStoryIndexByShortCut(curLang)

	GameLanguageMgr.instance:setLanguageTypeByStoryIndex(lanIndex)
	PlayerPrefsHelper.setNumber("StoryTxtLanType", lanIndex - 1)
end

function GMLangController:_onConfigAbCallback(assetItem)
	local json = cjson.decode(GameResMgr.IsFromEditorDir and assetItem.TextAsset or assetItem:GetNonAbTextAsset(true))
	local configName = json[1]
	local configText = json[2]
	local lua_language = {}
	local fields = {
		content = 2,
		key = 1
	}
	local primaryKey = {
		"key"
	}
	local mlStringKey = {}
	local shortcuts = configName:gsub("language_", "")

	lua_language.configList, lua_language.configDict = JsonToLuaParser.parse(configText, fields, primaryKey, mlStringKey)
	self._langDic[shortcuts] = lua_language
end

function GMLangController:getLangTxtFromeKey(shortcut, key)
	local langIdCfg = lua_language_coder.configDict[key]

	langIdCfg = langIdCfg or lua_language_prefab.configDict[key]

	if not langIdCfg then
		logError("语言表key[language_coder.xlsx/language_prefab.xlsx]中找不到key = " .. key .. " 请检查！")

		return key
	end

	local lang = rawget(langIdCfg, 2)
	local ret = self:getLangTxt(shortcut, lang)

	if LuaUtil.isEmptyStr(ret) then
		return langIdCfg.lang
	end

	return ret
end

function GMLangController:getLangTxt(shortcut, id)
	local langConfig = self._langDic[shortcut]
	local cfg = langConfig.configDict[id]
	local content = cfg and cfg.content

	if not string.nilorempty(content) then
		return content
	end

	local state = string.find(id, "language_")

	if state then
		id = string.getLastNum(id)

		if id then
			return tostring(id)
		end
	end

	return ""
end

function GMLangController:_formatLuaLang(shortcut, ...)
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

	local moudle = self:getLangTxtFromeKey(shortcut, key)

	return string.format(moudle, unpack(args, 2))
end

GMLangController.instance = GMLangController.New()

return GMLangController
