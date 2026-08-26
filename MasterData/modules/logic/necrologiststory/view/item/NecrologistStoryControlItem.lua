-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryControlItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryControlItem", package.seeall)

local NecrologistStoryControlItem = class("NecrologistStoryControlItem", NecrologistStoryBaseItem)

function NecrologistStoryControlItem:playControl(controlParam, ...)
	self._controlParam = controlParam

	self:setCallback(...)
	self:onPlayStory()
	self:refreshHeight()
end

function NecrologistStoryControlItem:getItemType()
	return nil
end

function NecrologistStoryControlItem:setStoryId(storyId)
	self._storyId = storyId
end

function NecrologistStoryControlItem:getStoryId(storyId)
	return self._storyId
end

return NecrologistStoryControlItem
