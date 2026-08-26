-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5CelebrityCardGetScrollItem.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5CelebrityCardGetScrollItem", package.seeall)

local Season123_3_5CelebrityCardGetScrollItem = class("Season123_3_5CelebrityCardGetScrollItem", Season123_3_5CelebrityCardGetItem)

function Season123_3_5CelebrityCardGetScrollItem:onOpen()
	return
end

function Season123_3_5CelebrityCardGetScrollItem:onScrollItemRefreshData(data)
	self:refreshData(data)
end

return Season123_3_5CelebrityCardGetScrollItem
