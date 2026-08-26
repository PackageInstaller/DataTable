-- chunkname: @modules/logic/character/model/CharacterLevelListModel.lua

module("modules.logic.character.model.CharacterLevelListModel", package.seeall)

local CharacterLevelListModel = class("CharacterLevelListModel", ListScrollModel)

function CharacterLevelListModel:setCharacterLevelList(heroMo, argsHeroLevel)
	local moList = {}
	local heroId = heroMo.heroId
	local rank = heroMo.rank
	local rankMaxLv = CharacterModel.instance:getrankEffects(heroId, rank)[1]
	local level = argsHeroLevel or heroMo.level

	for lv = level, rankMaxLv do
		moList[#moList + 1] = {
			heroId = heroId,
			level = lv
		}
	end

	self:setList(moList)
end

CharacterLevelListModel.instance = CharacterLevelListModel.New()

return CharacterLevelListModel
