-- chunkname: @modules/logic/character/controller/CharacterVoiceController.lua

module("modules.logic.character.controller.CharacterVoiceController", package.seeall)

local CharacterVoiceController = class("CharacterVoiceController", BaseController)

function CharacterVoiceController:onInit()
	self._defaultValueMap = {
		[CharacterVoiceEnum.Hero.Luxi] = CharacterVoiceEnum.LuxiState.MetalFace
	}
	self._changeValueMap = {
		[CharacterVoiceEnum.Hero.Luxi] = self._getLuxiChangeValue
	}
end

function CharacterVoiceController:getDefaultValue(heroId)
	return self._defaultValueMap[heroId]
end

function CharacterVoiceController:getChangeValue(voiceConfig)
	local handler = self._changeValueMap[voiceConfig.heroId]

	return handler and handler(self, voiceConfig)
end

function CharacterVoiceController:_getLuxiChangeValue(voiceConfig)
	if voiceConfig.stateCondition == CharacterVoiceEnum.LuxiState.MetalFace then
		return CharacterVoiceEnum.LuxiState.HumanFace
	else
		return CharacterVoiceEnum.LuxiState.MetalFace
	end
end

function CharacterVoiceController:getIdle(heroId)
	if heroId == CharacterVoiceEnum.Hero.Luxi then
		local defaultValue = self:getDefaultValue(heroId)
		local state = PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, heroId, defaultValue)

		if state == CharacterVoiceEnum.LuxiState.HumanFace then
			return StoryAnimName.B_IDLE1
		else
			return StoryAnimName.B_IDLE
		end
	end

	return StoryAnimName.B_IDLE
end

function CharacterVoiceController:setSpecialInteractionPlayType(value)
	self._playType = value
end

function CharacterVoiceController:getSpecialInteractionPlayType()
	return self._playType
end

function CharacterVoiceController:trackSpecialInteraction(heroId, voiceId, playType)
	local heroCfg = HeroConfig.instance:getHeroCO(heroId)

	if not heroCfg then
		return
	end

	local trigger_type = playType == CharacterVoiceEnum.PlayType.Click and "主动触发" or "被动触发"
	local properties = {}

	properties[StatEnum.EventProperties.HeroId] = tonumber(heroId)
	properties[StatEnum.EventProperties.HeroName] = heroCfg.name
	properties[StatEnum.EventProperties.VoiceId] = tostring(voiceId)
	properties[StatEnum.EventProperties.trigger_type] = tostring(trigger_type)

	StatController.instance:track(StatEnum.EventName.Interactive_special_action, properties)
end

CharacterVoiceController.instance = CharacterVoiceController.New()

return CharacterVoiceController
