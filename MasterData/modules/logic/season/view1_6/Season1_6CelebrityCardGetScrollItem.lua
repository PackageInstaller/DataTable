-- chunkname: @modules/logic/season/view1_6/Season1_6CelebrityCardGetScrollItem.lua

module("modules.logic.season.view1_6.Season1_6CelebrityCardGetScrollItem", package.seeall)

local Season1_6CelebrityCardGetScrollItem = class("Season1_6CelebrityCardGetScrollItem", Season1_6CelebrityCardGetItem)

function Season1_6CelebrityCardGetScrollItem:onOpen()
	return
end

function Season1_6CelebrityCardGetScrollItem:onScrollItemRefreshData(data)
	self:refreshData(data)
end

return Season1_6CelebrityCardGetScrollItem
