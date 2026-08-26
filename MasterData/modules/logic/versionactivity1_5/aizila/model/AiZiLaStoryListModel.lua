-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaStoryListModel.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaStoryListModel", package.seeall)

local AiZiLaStoryListModel = class("AiZiLaStoryListModel", ListScrollModel)

function AiZiLaStoryListModel:init(actId, episodeId)
	local storyCos = AiZiLaConfig.instance:getStoryList(actId)
	local dataList = {}

	self._episodeId = episodeId

	if storyCos then
		for index, storyCo in ipairs(storyCos) do
			if AiZiLaEnum.AllStoryEpisodeId == episodeId or storyCo.episodeId == episodeId then
				local stroyMO = AiZiLaStoryMO.New()

				stroyMO:init(index, storyCo)
				table.insert(dataList, stroyMO)
			end
		end
	end

	if #dataList > 1 then
		table.sort(dataList, AiZiLaStoryListModel.sortMO)
	end

	for i, stroyMO in ipairs(dataList) do
		stroyMO.index = i
	end

	self:setList(dataList)
end

function AiZiLaStoryListModel.sortMO(objA, objB)
	local orderA = objA.config.order
	local orderB = objB.config.order

	if orderA ~= orderB then
		return orderA < orderB
	end
end

function AiZiLaStoryListModel:getEpisodeId()
	return self._episodeId
end

AiZiLaStoryListModel.instance = AiZiLaStoryListModel.New()

return AiZiLaStoryListModel
