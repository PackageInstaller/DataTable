-- chunkname: @modules/logic/versionactivity1_3/jialabona/model/JiaLaBoNaStoryListModel.lua

module("modules.logic.versionactivity1_3.jialabona.model.JiaLaBoNaStoryListModel", package.seeall)

local JiaLaBoNaStoryListModel = class("JiaLaBoNaStoryListModel", ListScrollModel)

function JiaLaBoNaStoryListModel:init(actId, episodeId)
	local storyCos = Activity120Config.instance:getEpisodeStoryList(actId, episodeId)
	local dataList = {}

	if storyCos then
		for index, storyCo in ipairs(storyCos) do
			local stroyMO = JiaLaBoNaStoryMO.New()

			stroyMO:init(index, storyCo)
			table.insert(dataList, stroyMO)
		end
	end

	self:setList(dataList)
end

JiaLaBoNaStoryListModel.instance = JiaLaBoNaStoryListModel.New()

return JiaLaBoNaStoryListModel
