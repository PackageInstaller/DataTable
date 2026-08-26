-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9CelebrityCardGetScrollItem.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9CelebrityCardGetScrollItem", package.seeall)

local Season123_1_9CelebrityCardGetScrollItem = class("Season123_1_9CelebrityCardGetScrollItem", Season123_1_9CelebrityCardGetItem)

function Season123_1_9CelebrityCardGetScrollItem:onOpen()
	return
end

function Season123_1_9CelebrityCardGetScrollItem:onScrollItemRefreshData(data)
	self:refreshData(data)
end

return Season123_1_9CelebrityCardGetScrollItem
