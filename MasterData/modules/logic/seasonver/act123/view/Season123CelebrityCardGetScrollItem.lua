-- chunkname: @modules/logic/seasonver/act123/view/Season123CelebrityCardGetScrollItem.lua

module("modules.logic.seasonver.act123.view.Season123CelebrityCardGetScrollItem", package.seeall)

local Season123CelebrityCardGetScrollItem = class("Season123CelebrityCardGetScrollItem", Season123CelebrityCardGetItem)

function Season123CelebrityCardGetScrollItem:onOpen()
	return
end

function Season123CelebrityCardGetScrollItem:onScrollItemRefreshData(data)
	self:refreshData(data)
end

return Season123CelebrityCardGetScrollItem
