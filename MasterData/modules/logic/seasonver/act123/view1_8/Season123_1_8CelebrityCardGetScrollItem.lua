-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8CelebrityCardGetScrollItem.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8CelebrityCardGetScrollItem", package.seeall)

local Season123_1_8CelebrityCardGetScrollItem = class("Season123_1_8CelebrityCardGetScrollItem", Season123_1_8CelebrityCardGetItem)

function Season123_1_8CelebrityCardGetScrollItem:onOpen()
	return
end

function Season123_1_8CelebrityCardGetScrollItem:onScrollItemRefreshData(data)
	self:refreshData(data)
end

return Season123_1_8CelebrityCardGetScrollItem
