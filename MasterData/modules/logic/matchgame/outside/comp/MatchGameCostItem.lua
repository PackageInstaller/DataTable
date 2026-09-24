-- chunkname: @modules/logic/matchgame/outside/comp/MatchGameCostItem.lua

module("modules.logic.matchgame.outside.comp.MatchGameCostItem", package.seeall)

local MatchGameCostItem = class("MatchGameCostItem", LuaCompBase)

function MatchGameCostItem:init(go)
	self.go = go
	self._imageCost = gohelper.findChildImage(self.go, "image_Cost")
	self._txtCost = gohelper.findChildText(self.go, "txt_Cost")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_Click")
end

function MatchGameCostItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function MatchGameCostItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function MatchGameCostItem:_btnClickOnClick()
	if not self._itemId then
		return
	end

	MatchGameController.instance:openItemTipView(self._itemId)
end

function MatchGameCostItem:onUpdateMO(costInfo, index)
	self._index = index
	self._itemId = costInfo and costInfo[1]
	self._costNum = costInfo and costInfo[2]

	MatchGameHelper.setItemIcon(self._itemId, self._imageCost)

	local curItemNum = MatchGameModel.instance:getItemCount(self._itemId)
	local isItemEnough = curItemNum >= self._costNum

	if isItemEnough then
		if not MatchGameEnum.ItemEnoughColor then
			local costColor = MatchGameEnum.ItemNotEnoughColor

			self._txtCost.text = string.format("<%s>%s</color>", costColor, self._costNum)
		end
	end
end

return MatchGameCostItem
