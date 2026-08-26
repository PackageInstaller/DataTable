-- chunkname: @modules/logic/character/model/CharacterVoiceModel.lua

module("modules.logic.character.model.CharacterVoiceModel", package.seeall)

local CharacterVoiceModel = class("CharacterVoiceModel", ListScrollModel)

function CharacterVoiceModel:setVoiceList(infos)
	self._moList = {}

	if infos then
		self._moList = infos

		table.sort(self._moList, function(a, b)
			local alock = CharacterDataModel.instance:isCurHeroAudioLocked(a.id) and 1 or 0
			local block = CharacterDataModel.instance:isCurHeroAudioLocked(b.id) and 1 or 0

			if alock ~= block then
				return alock < block
			elseif a.score ~= b.score and alock == 1 and block == 1 then
				return a.score < b.score
			elseif a.sortId ~= b.sortId then
				return a.sortId < b.sortId
			else
				return a.id < b.id
			end
		end)
	end

	self:setList(self._moList)
end

function CharacterVoiceModel:setNeedItemAni(need)
	self._needItemAni = need
end

function CharacterVoiceModel:isNeedItemAni()
	return self._needItemAni
end

CharacterVoiceModel.instance = CharacterVoiceModel.New()

return CharacterVoiceModel
