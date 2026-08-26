-- chunkname: @modules/logic/season/view3_0/Season3_0CelebrityCardGetScrollItem.lua

module("modules.logic.season.view3_0.Season3_0CelebrityCardGetScrollItem", package.seeall)

local Season3_0CelebrityCardGetScrollItem = class("Season3_0CelebrityCardGetScrollItem", Season3_0CelebrityCardGetItem)

function Season3_0CelebrityCardGetScrollItem:onOpen()
	return
end

function Season3_0CelebrityCardGetScrollItem:onScrollItemRefreshData(data)
	self:refreshData(data)
end

return Season3_0CelebrityCardGetScrollItem
