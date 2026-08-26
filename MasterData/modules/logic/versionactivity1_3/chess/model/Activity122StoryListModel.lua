-- chunkname: @modules/logic/versionactivity1_3/chess/model/Activity122StoryListModel.lua

module("modules.logic.versionactivity1_3.chess.model.Activity122StoryListModel", package.seeall)

local Activity122StoryListModel = class("Activity122StoryListModel", ListScrollModel)

function Activity122StoryListModel:init(actId, episodeId)
	local storyCos = Activity122Config.instance:getEpisodeStoryList(actId, episodeId)
	local dataList = {}

	if storyCos then
		for index, storyCo in ipairs(storyCos) do
			local stroyMO = Activity122StoryMO.New()

			stroyMO:init(index, storyCo)
			table.insert(dataList, stroyMO)
		end
	end

	self:setList(dataList)
end

Activity122StoryListModel.instance = Activity122StoryListModel.New()

return Activity122StoryListModel
