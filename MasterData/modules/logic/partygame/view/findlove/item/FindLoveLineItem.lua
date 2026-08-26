-- chunkname: @modules/logic/partygame/view/findlove/item/FindLoveLineItem.lua

module("modules.logic.partygame.view.findlove.item.FindLoveLineItem", package.seeall)

local FindLoveLineItem = class("FindLoveLineItem", SimpleListItem)

function FindLoveLineItem:onInit()
	self.line = gohelper.findChild(self.viewGO, "line")
	self.lineSelfRight = gohelper.findChild(self.viewGO, "lineSelfRight")
	self.lineSelfLeft = gohelper.findChild(self.viewGO, "lineSelfLeft")
end

function FindLoveLineItem:onAddListeners()
	return
end

function FindLoveLineItem:onItemShow(data)
	self.gamePartyPlayerMo = data.gamePartyPlayerMo
	self.selfIndex = data.selfIndex

	gohelper.setActive(self.lineSelfLeft, self.gamePartyPlayerMo:isMainPlayer() and not self.isFirstItem)
	gohelper.setActive(self.lineSelfRight, self.gamePartyPlayerMo:isMainPlayer() and not self.isLastItem)

	local isShowLine = self.itemIndex < self.selfIndex and self.itemIndex + 1 < self.selfIndex or self.itemIndex > self.selfIndex and not self.isLastItem

	gohelper.setActive(self.line, isShowLine)
end

return FindLoveLineItem
