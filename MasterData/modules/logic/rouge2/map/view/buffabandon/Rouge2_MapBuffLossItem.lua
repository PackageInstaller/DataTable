-- chunkname: @modules/logic/rouge2/map/view/buffabandon/Rouge2_MapBuffLossItem.lua

module("modules.logic.rouge2.map.view.buffabandon.Rouge2_MapBuffLossItem", package.seeall)

local Rouge2_MapBuffLossItem = class("Rouge2_MapBuffLossItem", LuaCompBase)

function Rouge2_MapBuffLossItem:init(go)
	self.go = go
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_Click")
	self._goSelect = gohelper.findChild(self.go, "go_Select")
	self._goRoot = gohelper.findChild(go, "go_Root")
end

function Rouge2_MapBuffLossItem:initParent(view)
	if not self._comBuffItem then
		local goBuff = view:getResInst(Rouge2_Enum.ResPath.ComBuffItem, self._goRoot)

		self._comBuffItem = Rouge2_CommonBuffItem.Get(goBuff)

		self._comBuffItem:initDescModeFlag(Rouge2_Enum.ItemDescModeDataKey.BuffAbandon)
	end
end

function Rouge2_MapBuffLossItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectLossItemChange, self._onSelectLossBuffChange, self)
end

function Rouge2_MapBuffLossItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_MapBuffLossItem:_btnClickOnClick()
	if Rouge2_LossBuffListModel.instance:isSelect(self._mo) then
		Rouge2_LossBuffListModel.instance:deselectMo(self._mo)
	elseif Rouge2_LossBuffListModel.instance:checkCanSelect() then
		Rouge2_LossBuffListModel.instance:selectMo(self._mo)
	else
		local maxSelectCount = Rouge2_LossBuffListModel.instance:getMaxSelectCount()

		GameFacade.showToast(ToastEnum.Rouge2LossItemMaxNum, maxSelectCount)
	end
end

function Rouge2_MapBuffLossItem:onUpdateMO(index, mo)
	self._index = index
	self._mo = mo
	self._buffUid = mo and mo:getUid()

	self._comBuffItem:onUpdateMO(Rouge2_Enum.ItemDataType.Server, self._buffUid)
	self:onSelect()
end

function Rouge2_MapBuffLossItem:_onSelectLossBuffChange()
	self:onSelect()
end

function Rouge2_MapBuffLossItem:onSelect()
	local isSelect = Rouge2_LossBuffListModel.instance:isSelect(self._mo)

	self._comBuffItem:onSelect(isSelect)
	gohelper.setActive(self._goSelect, isSelect)
end

function Rouge2_MapBuffLossItem:onDestroy()
	return
end

return Rouge2_MapBuffLossItem
