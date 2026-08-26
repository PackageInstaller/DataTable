-- chunkname: @modules/logic/season/view1_2/Season1_2CelebrityCardGetScrollItem.lua

module("modules.logic.season.view1_2.Season1_2CelebrityCardGetScrollItem", package.seeall)

local Season1_2CelebrityCardGetScrollItem = class("Season1_2CelebrityCardGetScrollItem", Season1_2CelebrityCardGetItem)

function Season1_2CelebrityCardGetScrollItem:onOpen()
	return
end

function Season1_2CelebrityCardGetScrollItem:onScrollItemRefreshData(data)
	self:refreshData(data)
end

return Season1_2CelebrityCardGetScrollItem
