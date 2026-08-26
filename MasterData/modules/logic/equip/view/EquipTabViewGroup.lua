-- chunkname: @modules/logic/equip/view/EquipTabViewGroup.lua

module("modules.logic.equip.view.EquipTabViewGroup", package.seeall)

local EquipTabViewGroup = class("EquipTabViewGroup", TabViewGroup)

function EquipTabViewGroup:onUpdateParam()
	self:onOpen()
end

function EquipTabViewGroup:playCloseAnimation()
	if self:_hasLoaded(self._curTabId) then
		local tabview = self._tabViews[self._curTabId]

		if isTypeOf(tabview, MultiView) then
			tabview:callChildrenFunc("playCloseAnimation")
		else
			tabview:playCloseAnimation()
		end
	end
end

return EquipTabViewGroup
