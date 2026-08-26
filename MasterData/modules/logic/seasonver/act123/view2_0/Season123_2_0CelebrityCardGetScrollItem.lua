-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0CelebrityCardGetScrollItem.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0CelebrityCardGetScrollItem", package.seeall)

local Season123_2_0CelebrityCardGetScrollItem = class("Season123_2_0CelebrityCardGetScrollItem", Season123_2_0CelebrityCardGetItem)

function Season123_2_0CelebrityCardGetScrollItem:onOpen()
	return
end

function Season123_2_0CelebrityCardGetScrollItem:onScrollItemRefreshData(data)
	self:refreshData(data)
end

return Season123_2_0CelebrityCardGetScrollItem
