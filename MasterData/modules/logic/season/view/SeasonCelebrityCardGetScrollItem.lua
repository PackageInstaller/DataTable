-- chunkname: @modules/logic/season/view/SeasonCelebrityCardGetScrollItem.lua

module("modules.logic.season.view.SeasonCelebrityCardGetScrollItem", package.seeall)

local SeasonCelebrityCardGetScrollItem = class("SeasonCelebrityCardGetScrollItem", SeasonCelebrityCardGetItem)

function SeasonCelebrityCardGetScrollItem:onOpen()
	return
end

function SeasonCelebrityCardGetScrollItem:onScrollItemRefreshData(data)
	self:refreshData(data)
end

return SeasonCelebrityCardGetScrollItem
