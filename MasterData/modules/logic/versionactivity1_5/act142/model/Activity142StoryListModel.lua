-- chunkname: @modules/logic/versionactivity1_5/act142/model/Activity142StoryListModel.lua

module("modules.logic.versionactivity1_5.act142.model.Activity142StoryListModel", package.seeall)

local Activity142StoryListModel = class("Activity142StoryListModel", ListScrollModel)

function Activity142StoryListModel:init(actId, episodeId)
	local list = {}
	local episodeStoryList = Activity142Config.instance:getEpisodeStoryList(actId, episodeId)

	for index, storyCo in ipairs(episodeStoryList) do
		local storyMo = {
			index = index,
			storyId = storyCo.id
		}

		table.insert(list, storyMo)
	end

	self:setList(list)
end

Activity142StoryListModel.instance = Activity142StoryListModel.New()

return Activity142StoryListModel
