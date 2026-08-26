-- chunkname: @modules/logic/rouge2/map/view/collectionabandon/Rouge2_MapRelicsLossItem.lua

module("modules.logic.rouge2.map.view.collectionabandon.Rouge2_MapRelicsLossItem", package.seeall)

local Rouge2_MapRelicsLossItem = class("Rouge2_MapRelicsLossItem", ListScrollCell)

function Rouge2_MapRelicsLossItem:init(go)
	self.go = go
	self._goSelect = gohelper.findChild(self.go, "go_Select")
	self._btnClick = gohelper.getClickWithDefaultAudio(self.go)
end

function Rouge2_MapRelicsLossItem:initInternal(go, view)
	Rouge2_MapRelicsLossItem.super.initInternal(self, go, view)

	self._goRoot = gohelper.findChild(go, "go_Root")

	local goScroll = gohelper.findChild(view.viewGO, view._param.scrollGOPath)
	local goRelics = view:getResInst(Rouge2_Enum.ResPath.ComRelicsItem, self._goRoot)

	self._relicsItem = Rouge2_CommonCollectionItem.Get(goRelics)

	self._relicsItem:initDescModeFlag(Rouge2_Enum.ItemDescModeDataKey.RelicsAbandon)
	self._relicsItem:setParentScroll(goScroll)
	self._relicsItem:initClickCallback(self._btnClickOnClick, self)
end

function Rouge2_MapRelicsLossItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectLossItemChange, self._onSelectLossRelicsChange, self)
end

function Rouge2_MapRelicsLossItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_MapRelicsLossItem:_btnClickOnClick()
	if Rouge2_LossRelicsListModel.instance:isSelect(self.mo) then
		Rouge2_LossRelicsListModel.instance:deselectMo(self.mo)
	elseif Rouge2_LossRelicsListModel.instance:checkCanSelect() then
		Rouge2_LossRelicsListModel.instance:selectMo(self.mo)
	else
		local maxSelectCount = Rouge2_LossRelicsListModel.instance:getMaxSelectCount()

		GameFacade.showToast(ToastEnum.Rouge2LossItemMaxNum, maxSelectCount)
	end
end

function Rouge2_MapRelicsLossItem:onUpdateMO(mo)
	self.mo = mo

	self._relicsItem:onUpdateMO(Rouge2_Enum.ItemDataType.Server, mo:getUid())
	self:onSelect()
end

function Rouge2_MapRelicsLossItem:_onSelectLossRelicsChange()
	self:onSelect()
end

function Rouge2_MapRelicsLossItem:onSelect()
	local isSelect = Rouge2_LossRelicsListModel.instance:isSelect(self.mo)

	self._relicsItem:onSelect(isSelect)
	gohelper.setActive(self._goSelect, isSelect)
end

function Rouge2_MapRelicsLossItem:onDestroy()
	return
end

return Rouge2_MapRelicsLossItem
