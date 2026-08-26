-- chunkname: @modules/logic/handbook/model/HandbookStoryListModel.lua

module("modules.logic.handbook.model.HandbookStoryListModel", package.seeall)

local HandbookStoryListModel = class("HandbookStoryListModel", ListScrollModel)

function HandbookStoryListModel:setStoryList(storyGroupList, storyChapterId)
	self.moList = {}

	local count = 0

	for i, config in ipairs(storyGroupList) do
		if config.storyChapterId == storyChapterId and HandbookModel.instance:isStoryGroupUnlock(config.id) then
			count = count + 1

			local handbookStoryMO = HandbookStoryMO.New()

			handbookStoryMO:init(config.id, count)
			table.insert(self.moList, handbookStoryMO)
		end
	end

	self:setList(self.moList)
end

function HandbookStoryListModel:getStoryList()
	if GameUtil.getTabLen(self.moList) > 0 then
		return self.moList
	end

	return nil
end

function HandbookStoryListModel:clearStoryList()
	self:setList({})
end

HandbookStoryListModel.instance = HandbookStoryListModel.New()

return HandbookStoryListModel
