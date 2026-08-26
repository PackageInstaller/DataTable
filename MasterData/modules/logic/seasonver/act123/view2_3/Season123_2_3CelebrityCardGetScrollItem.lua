-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3CelebrityCardGetScrollItem.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3CelebrityCardGetScrollItem", package.seeall)

local Season123_2_3CelebrityCardGetScrollItem = class("Season123_2_3CelebrityCardGetScrollItem", Season123_2_3CelebrityCardGetItem)

function Season123_2_3CelebrityCardGetScrollItem:onOpen()
	return
end

function Season123_2_3CelebrityCardGetScrollItem:onScrollItemRefreshData(data)
	self:refreshData(data)
end

return Season123_2_3CelebrityCardGetScrollItem
