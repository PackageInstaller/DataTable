-- chunkname: @modules/logic/battlepass/view/BpBuyBonusItem.lua

module("modules.logic.battlepass.view.BpBuyBonusItem", package.seeall)

local BpBuyBonusItem = class("BpBuyBonusItem", ListScrollCell)

function BpBuyBonusItem:init(go)
	self.go = go
	self._itemIcon = IconMgr.instance:getCommonPropItemIcon(self.go)
end

function BpBuyBonusItem:onUpdateMO(mo)
	self.mo = mo

	self._itemIcon:setMOValue(self.mo[1], self.mo[2], self.mo[3], nil, true)
	self._itemIcon:isShowCount(self.mo[1] ~= MaterialEnum.MaterialType.Hero)
	self._itemIcon:setCountFontSize(40)
	self._itemIcon:setScale(0.8)
	self._itemIcon:showStackableNum2()
	self._itemIcon:setHideLvAndBreakFlag(true)
	self._itemIcon:hideEquipLvAndBreak(true)
end

function BpBuyBonusItem:onDestroyView()
	if self._itemIcon then
		self._itemIcon:onDestroy()
	end

	self._itemIcon = nil
end

return BpBuyBonusItem
