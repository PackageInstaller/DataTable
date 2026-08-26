-- chunkname: @modules/logic/settings/model/SettingsRoleVoiceModel.lua

module("modules.logic.settings.model.SettingsRoleVoiceModel", package.seeall)

local SettingsRoleVoiceModel = class("SettingsRoleVoiceModel", BaseModel)

function SettingsRoleVoiceModel:onInit()
	return
end

function SettingsRoleVoiceModel:setCharVoiceLangPrefValue(langValue, heroId)
	if type(langValue) == "number" then
		if not LangSettings.shortcutTab[langValue] then
			local langStr = langValue

			if not self:isHeroSp01(heroId) and (langStr == LangSettings.shortcutTab[LangSettings.jp] or langStr == LangSettings.shortcutTab[LangSettings.kr]) then
				return
			end

			self:statCharVoiceData(StatEnum.EventName.ChangeCharVoiceLang, heroId, langStr)

			local key = PlayerModel.instance:getPlayerPrefsKey(SettingsEnum.CharVoiceLangPrefsKey .. heroId .. "_")

			PlayerPrefsHelper.setString(key, langStr)
		end
	end
end

function SettingsRoleVoiceModel:getCharVoiceLangPrefValue(heroId)
	local key = PlayerModel.instance:getPlayerPrefsKey(SettingsEnum.CharVoiceLangPrefsKey .. heroId .. "_")
	local langStr = PlayerPrefsHelper.getString(key)
	local usingDefaultLang = false

	if type(langStr) ~= "string" or string.nilorempty(langStr) then
		langStr = GameConfig:GetCurVoiceShortcut()

		if not self:isHeroSp01(heroId) and (langStr == LangSettings.shortcutTab[LangSettings.jp] or langStr == LangSettings.shortcutTab[LangSettings.kr]) then
			langStr = LangSettings.shortcutTab[LangSettings.en]
		end
	end

	local langId = LangSettings.shortCut2LangIdxTab[langStr]

	return langId, langStr, usingDefaultLang
end

function SettingsRoleVoiceModel:isHeroSp01(heroId)
	local roles = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.S01SpRole), "#")

	return (LuaUtil.tableContains(roles, heroId))
end

function SettingsRoleVoiceModel:statCharVoiceData(eventName, heroId, targetLangStr)
	local heroCfg = HeroConfig.instance:getHeroCO(heroId)

	if not heroCfg then
		return
	end

	local properties = {}

	properties[StatEnum.EventProperties.HeroId] = tonumber(heroId)
	properties[StatEnum.EventProperties.HeroName] = heroCfg.name

	if eventName == StatEnum.EventName.ChangeCharVoiceLang then
		local langId, langStr, usingDefaultLang = self:getCharVoiceLangPrefValue(heroId)
		local globalVoiceLang = GameConfig:GetCurVoiceShortcut()

		properties[StatEnum.EventProperties.CharVoiceLang] = targetLangStr
		properties[StatEnum.EventProperties.GlobalVoiceLang] = globalVoiceLang
		properties[StatEnum.EventProperties.CharVoiceLangBefore] = usingDefaultLang and globalVoiceLang or langStr
	end

	StatController.instance:track(eventName, properties)
end

SettingsRoleVoiceModel.instance = SettingsRoleVoiceModel.New()

return SettingsRoleVoiceModel
