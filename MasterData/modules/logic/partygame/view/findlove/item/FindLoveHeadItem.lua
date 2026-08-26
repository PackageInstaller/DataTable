-- chunkname: @modules/logic/partygame/view/findlove/item/FindLoveHeadItem.lua

module("modules.logic.partygame.view.findlove.item.FindLoveHeadItem", package.seeall)

local FindLoveHeadItem = class("FindLoveHeadItem", SimpleListItem)

function FindLoveHeadItem:onInit()
	self.partygameplayerhead = gohelper.findChild(self.viewGO, "partygameplayerhead")
	self.partyGamePlayerHead = GameFacade.createLuaCompByGo(self.partygameplayerhead, PartyGamePlayerHead, nil, self.viewContainer)
end

function FindLoveHeadItem:onItemShow(data)
	self.partyGamePlayerHead:setData(data)
end

return FindLoveHeadItem
