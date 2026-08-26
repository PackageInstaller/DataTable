-- chunkname: @modules/logic/herogroup/model/HeroGroupRecommendGroupListModel.lua

module("modules.logic.herogroup.model.HeroGroupRecommendGroupListModel", package.seeall)

local HeroGroupRecommendGroupListModel = class("HeroGroupRecommendGroupListModel", ListScrollModel)

function HeroGroupRecommendGroupListModel:setGroupList(heroGroupRecommendGroupMo)
	self:setCurrentShowRecommendGroupMoId(heroGroupRecommendGroupMo)

	local infos = heroGroupRecommendGroupMo.heroRecommendInfos
	local moList = {}

	for i, group in ipairs(infos) do
		local groupMO = HeroGroupRecommendGroupMO.New()

		groupMO:init(group)
		table.insert(moList, groupMO)
	end

	table.sort(moList, function(x, y)
		return x.rate > y.rate
	end)

	for i = #infos + 1, 5 do
		local groupMO = HeroGroupRecommendGroupMO.New()

		groupMO:init()
		table.insert(moList, groupMO)
	end

	self:setList(moList)
end

function HeroGroupRecommendGroupListModel:setCurrentShowRecommendGroupMoId(heroGroupRecommendGroupMo)
	self.showGroupId = heroGroupRecommendGroupMo.id
end

function HeroGroupRecommendGroupListModel:isShowSampleMo(heroGroupRecommendGroupMo)
	return self.showGroupId == heroGroupRecommendGroupMo.id
end

function HeroGroupRecommendGroupListModel:setCurEpisodeId(episodeId)
	self._curEpisodeId = episodeId
end

function HeroGroupRecommendGroupListModel:getCurEpisodeId()
	return self._curEpisodeId
end

HeroGroupRecommendGroupListModel.instance = HeroGroupRecommendGroupListModel.New()

return HeroGroupRecommendGroupListModel
