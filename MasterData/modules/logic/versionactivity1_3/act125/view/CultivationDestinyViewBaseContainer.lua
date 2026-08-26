-- chunkname: @modules/logic/versionactivity1_3/act125/view/CultivationDestinyViewBaseContainer.lua

module("modules.logic.versionactivity1_3.act125.view.CultivationDestinyViewBaseContainer", package.seeall)

local CultivationDestinyViewBaseContainer = class("CultivationDestinyViewBaseContainer", Activity125ViewBaseContainer)

function CultivationDestinyViewBaseContainer:actId()
	return (self.viewParam or nil) and (self.viewParam.actId or Activity125Config.instance:getCultivationDestinyActId())
end

function CultivationDestinyViewBaseContainer:getDestinyStoneById()
	return VersionActivity2_3NewCultivationDestinyModel.instance:getDestinyStoneById(self:actId())
end

function CultivationDestinyViewBaseContainer:episodeId()
	self.__episodeId = self.__episodeId or self:getFirstEpisodeId()

	return self.__episodeId
end

function CultivationDestinyViewBaseContainer:isClaimed()
	return self:isEpisodeFinished(self:episodeId())
end

function CultivationDestinyViewBaseContainer:sendFinishAct125EpisodeRequest()
	CultivationDestinyViewBaseContainer.super.sendFinishAct125EpisodeRequest(self)
end

function CultivationDestinyViewBaseContainer:onContainerDestroy()
	self:setCurSelectEpisodeIdSlient(nil)

	self.__episodeId = nil

	CultivationDestinyViewBaseContainer.super:onContainerDestroy()
end

function CultivationDestinyViewBaseContainer:getHeroDestiny(heroId)
	return CharacterDestinyConfig.instance:getHeroDestiny(heroId)
end

function CultivationDestinyViewBaseContainer:getDestinyFacetHeroId(destinyId)
	return CharacterDestinyConfig.instance:getDestinyFacetHeroId(destinyId) or 0
end

function CultivationDestinyViewBaseContainer:getSkillExlevelCos(destinyId)
	return CharacterDestinyConfig.instance:getSkillExlevelCos(destinyId)
end

function CultivationDestinyViewBaseContainer:isSpecialDestiny(destinyId)
	return not not self:getSkillExlevelCos(destinyId)
end

function CultivationDestinyViewBaseContainer:isHeroWithSpecialDestiny(heroId)
	local CO = self:getHeroDestiny(heroId)

	if not CO then
		return false
	end

	local facetsId = CO.facetsId
	local destinyIds = string.splitToNumber(facetsId, "#")

	for _, destinyId in ipairs(destinyIds) do
		if self:isSpecialDestiny(destinyId) then
			return true
		end
	end

	return false
end

return CultivationDestinyViewBaseContainer
