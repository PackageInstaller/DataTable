-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1CelebrityCardGetScrollItem.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1CelebrityCardGetScrollItem", package.seeall)

local Season123_2_1CelebrityCardGetScrollItem = class("Season123_2_1CelebrityCardGetScrollItem", Season123_2_1CelebrityCardGetItem)

function Season123_2_1CelebrityCardGetScrollItem:onOpen()
	return
end

function Season123_2_1CelebrityCardGetScrollItem:onScrollItemRefreshData(data)
	self:refreshData(data)
end

return Season123_2_1CelebrityCardGetScrollItem
