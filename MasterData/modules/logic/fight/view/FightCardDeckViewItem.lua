-- chunkname: @modules/logic/fight/view/FightCardDeckViewItem.lua

module("modules.logic.fight.view.FightCardDeckViewItem", package.seeall)

local FightCardDeckViewItem = class("FightCardDeckViewItem", BaseViewExtended)

function FightCardDeckViewItem:onInitView()
	self._cardObj = gohelper.findChild(self.viewGO, "card/card")
	self._select = gohelper.findChild(self.viewGO, "select")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightCardDeckViewItem:addEvents()
	return
end

function FightCardDeckViewItem:removeEvents()
	return
end

function FightCardDeckViewItem:_editableInitView()
	return
end

function FightCardDeckViewItem:onRefreshViewParam()
	return
end

function FightCardDeckViewItem:onOpen()
	self._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._cardObj, FightViewCardItem, FightEnum.CardShowType.Deck)
end

function FightCardDeckViewItem:refreshItem(data)
	self._data = data

	self._cardItem:updateItem(data.entityId, data.skillId, data)
end

function FightCardDeckViewItem:showCount(count)
	self._cardItem:showCountPart(count)
end

function FightCardDeckViewItem:setSelect(state)
	gohelper.setActive(self._select, state)
end

function FightCardDeckViewItem:onClose()
	return
end

function FightCardDeckViewItem:onDestroyView()
	return
end

return FightCardDeckViewItem
