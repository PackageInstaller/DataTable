-- chunkname: @modules/logic/language/LangConfig.lua

module("modules.logic.language.LangConfig", package.seeall)

local LangConfig = class("LangConfig", BaseConfig)

function LangConfig:ctor()
	addGlobalModule("modules.logic.language.lua_language", "lua_language")
end

function LangConfig:reqConfigNames()
	return {
		"language_coder",
		"language_prefab",
		"video_lang"
	}
end

function LangConfig:onConfigLoaded(configName, configTable)
	return
end

function LangConfig:updateLanguage(configText)
	lua_language.onLoad(configText)
end

function LangConfig:updateServerLanguage(configText)
	lua_language_server.onLoad(configText)
end

function LangConfig:getLangTxt(shortcut, id)
	local cfg = lua_language.configDict[id]
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

	return id
end

function LangConfig:getServerLangTxt(shortcut, id)
	local cfg = lua_language_server.configDict[id]

	if cfg then
		return cfg.content
	end

	return id
end

function LangConfig:getLangTxtFromeKey(shortcut, key)
	local langIdCfg = lua_language_coder.configDict[key]

	langIdCfg = langIdCfg or lua_language_prefab.configDict[key]

	if not langIdCfg then
		logError("语言表key[language_coder.xlsx/language_prefab.xlsx]中找不到key = " .. key .. " 请检查！")

		return key
	end

	local ret = self:getLangTxt(shortcut, langIdCfg.lang)

	if LuaUtil.isEmptyStr(ret) then
		return langIdCfg.lang
	end

	return ret
end

LangConfig.instance = LangConfig.New()

return LangConfig
