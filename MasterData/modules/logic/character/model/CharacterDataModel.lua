-- chunkname: @modules/logic/character/model/CharacterDataModel.lua

module("modules.logic.character.model.CharacterDataModel", package.seeall)

local CharacterDataModel = class("CharacterDataModel", BaseModel)

function CharacterDataModel:onInit()
	self._playingList = {}
end

function CharacterDataModel:getCurHeroVoices()
	local showVoices = {}
	local voiceCo = CharacterDataConfig.instance:getCharacterVoicesCo(self._heroId)

	if voiceCo then
		for _, v in pairs(voiceCo) do
			local o = {}

			if self:_checkShow(self._heroId, v) then
				o.id = v.audio
				o.sortId = v.sortId
				o.name = v.name
				o.content = v.content
				o.englishContent = v.encontent
				o.unlockCondition = v.unlockCondition
				o.type = v.type
				o.param = v.param
				o.heroId = v.heroId

				local score = 0

				if not string.nilorempty(v.unlockCondition) then
					local unlockParams = string.split(v.unlockCondition, "#")

					if tonumber(unlockParams[1]) == 1 then
						score = tonumber(unlockParams[2])
					end
				end

				o.score = score

				table.insert(showVoices, o)
			end
		end
	end

	return showVoices
end

local skipShowTypes = {
	[CharacterEnum.VoiceType.GreetingInThumbnail] = true,
	[CharacterEnum.VoiceType.LimitedEntrance] = true,
	[CharacterEnum.VoiceType.MainViewSpecialInteraction] = true,
	[CharacterEnum.VoiceType.MainViewSpecialRespond] = true,
	[CharacterEnum.VoiceType.MainViewDragSpecialRespond] = true
}

function CharacterDataModel:_checkShow(heroId, v)
	if v.show == 2 or skipShowTypes[v.type] then
		return false
	end

	if self:_checkSpecialType(v) then
		return false
	end

	if v.stateCondition ~= 0 then
		local defaultValue = CharacterVoiceController.instance:getDefaultValue(heroId)
		local state = PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, heroId, defaultValue)

		if v.stateCondition ~= state then
			return false
		end
	end

	if string.nilorempty(v.skins) then
		return true
	end

	local heroMo = HeroModel.instance:getByHeroId(heroId)
	local skinId = heroMo.skin

	return string.find(v.skins, skinId)
end

function CharacterDataModel:_checkSpecialType(config)
	if config.type == CharacterEnum.VoiceType.MultiVoice then
		return true
	end

	return config.type >= CharacterEnum.VoiceType.SpecialIdle1 and config.type <= CharacterEnum.VoiceType.SpecialIdle2
end

function CharacterDataModel:isCurHeroAudioLocked(audioId)
	local voices = HeroModel.instance:getHeroAllVoice(self._heroId)

	return voices[audioId] == nil
end

function CharacterDataModel:isCurHeroAudioPlaying(audioId)
	for _, v in pairs(self._playingList) do
		if v == audioId then
			return true
		end
	end

	return false
end

function CharacterDataModel:setPlayingInfo(curAudioId, defaultAudioId)
	self._curAudioId = curAudioId
	self._defaultAudioId = defaultAudioId
end

function CharacterDataModel:getPlayingAudioId(defaultAudioId)
	if self._defaultAudioId ~= defaultAudioId then
		return
	end

	if self:isCurHeroAudioPlaying(self._curAudioId) then
		return self._curAudioId
	end
end

function CharacterDataModel:setCurHeroAudioPlaying(audioId)
	self._playingList = {}

	table.insert(self._playingList, audioId)
end

function CharacterDataModel:setCurHeroAudioFinished(audioId)
	for i = #self._playingList, 1, -1 do
		if self._playingList[i] == audioId then
			table.remove(self._playingList, i)

			break
		end
	end
end

function CharacterDataModel:getCurHeroId()
	return self._heroId
end

function CharacterDataModel:setCurHeroId(id)
	if self._heroId ~= id then
		self._playingList = {}
		self._heroId = id
	end
end

CharacterDataModel.instance = CharacterDataModel.New()

return CharacterDataModel
