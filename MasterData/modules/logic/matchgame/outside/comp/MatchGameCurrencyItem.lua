-- chunkname: @modules/logic/matchgame/outside/comp/MatchGameCurrencyItem.lua

module("modules.logic.matchgame.outside.comp.MatchGameCurrencyItem", package.seeall)

local MatchGameCurrencyItem = class("MatchGameCurrencyItem", LuaCompBase)

function MatchGameCurrencyItem:init(go)
	self.go = go
	self._txtValue = gohelper.findChildText(self.go, "txt_Value")
	self._imageIcon = gohelper.findChildImage(self.go, "image_Icon")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_Click")
end

function MatchGameCurrencyItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function MatchGameCurrencyItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function MatchGameCurrencyItem:_btnClickOnClick()
	MatchGameController.instance:openItemTipView(self._itemId)
end

function MatchGameCurrencyItem:onUpdateMO(itemId)
	self._itemId = itemId
	self._txtValue.text = MatchGameModel.instance:getItemCount(self._itemId)

	MatchGameHelper.setItemIcon(self._itemId, self._imageIcon)
end

return MatchGameCurrencyItem
