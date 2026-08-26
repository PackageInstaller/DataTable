-- chunkname: @modules/logic/season/view1_5/Season1_5CelebrityCardGetScrollItem.lua

module("modules.logic.season.view1_5.Season1_5CelebrityCardGetScrollItem", package.seeall)

local Season1_5CelebrityCardGetScrollItem = class("Season1_5CelebrityCardGetScrollItem", Season1_5CelebrityCardGetItem)

function Season1_5CelebrityCardGetScrollItem:onOpen()
	return
end

function Season1_5CelebrityCardGetScrollItem:onScrollItemRefreshData(data)
	self:refreshData(data)
end

return Season1_5CelebrityCardGetScrollItem
