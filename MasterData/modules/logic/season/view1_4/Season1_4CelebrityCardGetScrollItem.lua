-- chunkname: @modules/logic/season/view1_4/Season1_4CelebrityCardGetScrollItem.lua

module("modules.logic.season.view1_4.Season1_4CelebrityCardGetScrollItem", package.seeall)

local Season1_4CelebrityCardGetScrollItem = class("Season1_4CelebrityCardGetScrollItem", Season1_4CelebrityCardGetItem)

function Season1_4CelebrityCardGetScrollItem:onOpen()
	return
end

function Season1_4CelebrityCardGetScrollItem:onScrollItemRefreshData(data)
	self:refreshData(data)
end

return Season1_4CelebrityCardGetScrollItem
