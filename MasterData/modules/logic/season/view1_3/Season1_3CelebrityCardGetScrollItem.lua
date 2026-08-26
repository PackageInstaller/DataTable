-- chunkname: @modules/logic/season/view1_3/Season1_3CelebrityCardGetScrollItem.lua

module("modules.logic.season.view1_3.Season1_3CelebrityCardGetScrollItem", package.seeall)

local Season1_3CelebrityCardGetScrollItem = class("Season1_3CelebrityCardGetScrollItem", Season1_3CelebrityCardGetItem)

function Season1_3CelebrityCardGetScrollItem:onOpen()
	return
end

function Season1_3CelebrityCardGetScrollItem:onScrollItemRefreshData(data)
	self:refreshData(data)
end

return Season1_3CelebrityCardGetScrollItem
