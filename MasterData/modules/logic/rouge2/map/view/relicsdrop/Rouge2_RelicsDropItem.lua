-- chunkname: @modules/logic/rouge2/map/view/relicsdrop/Rouge2_RelicsDropItem.lua

module("modules.logic.rouge2.map.view.relicsdrop.Rouge2_RelicsDropItem", package.seeall)

local Rouge2_RelicsDropItem = class("Rouge2_RelicsDropItem", LuaCompBase)

function Rouge2_RelicsDropItem:init(go)
	self.go = go
	self._goSelect = gohelper.findChild(self.go, "go_Select")
	self._btnSelect = gohelper.findChildButtonWithAudio(self.go, "go_Select/btn_Select", AudioEnum.Rouge2.SelectDropItem)

	gohelper.setActive(self._goSelect, false)

	self._goSelect2 = gohelper.findChild(self.go, "go_Select2")
	self._btnSelect2 = gohelper.findChildButtonWithAudio(self.go, "go_Select2/btn_Select2", AudioEnum.Rouge2.StrengthenRelics)

	gohelper.setActive(self._goSelect2, false)

	self._goRoot = gohelper.findChild(self.go, "go_Root")

	local viewContainer = ViewMgr.instance:getContainer(ViewName.Rouge2_RelicsDropView)
	local goCollection = viewContainer:getResInst(Rouge2_Enum.ResPath.ComRelicsItem, self._goRoot)

	self._comRelicsItem = Rouge2_CommonCollectionItem.Get(goCollection)

	self._comRelicsItem:initClickCallback(self.onClickSelf, self)
	self._comRelicsItem:initDescModeFlag(Rouge2_Enum.ItemDescModeDataKey.RelicsDrop)
end

function Rouge2_RelicsDropItem:addEventListeners()
	self._btnSelect:AddClickListener(self._btnSelectOnClick, self)
	self._btnSelect2:AddClickListener(self._btnSelect2OnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onConfirmSelectDrop, self.onConfirmSelectDrop, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectDropChange, self.onSelectDropChange, self)
end

function Rouge2_RelicsDropItem:removeEventListeners()
	self._btnSelect:RemoveClickListener()
	self._btnSelect2:RemoveClickListener()
end

function Rouge2_RelicsDropItem:onClickSelf()
	if self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.Select and self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.LevelUp then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectDropChange, self._index)
end

function Rouge2_RelicsDropItem:_btnSelectOnClick()
	if not self._isSelect then
		return
	end

	GameUtil.setActiveUIBlock("Rouge2_RelicsDropItem", true, false)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onConfirmSelectDrop, self._index)
	self._comRelicsItem:playAnim("light", self._onSelectAnimDone, self)
end

function Rouge2_RelicsDropItem:_btnSelect2OnClick()
	if not self._isSelect then
		return
	end

	GameUtil.setActiveUIBlock("Rouge2_RelicsDropItem", true, false)
	self._comRelicsItem:playAnim("light", self._onSelect2AnimDone, self)
end

function Rouge2_RelicsDropItem:_onSelectAnimDone()
	GameUtil.setActiveUIBlock("Rouge2_RelicsDropItem", false, true)
	self:_tryStatDrop()

	self._rpcCallback = Rouge2_Rpc.instance:sendRouge2SelectDropRequest({
		self._index
	}, self._receiveRpcCallback, self)
end

function Rouge2_RelicsDropItem:_onSelect2AnimDone()
	GameUtil.setActiveUIBlock("Rouge2_RelicsDropItem", false, true)

	if self._relicsMo then
		local uid = self._relicsMo:getUid()

		if not self._relicsMo then
			return
		end

		self._rpcCallback = Rouge2_Rpc.instance:sendRouge2SelectUpdateCollectionRequest(self._relicsMo, self._receiveRpcCallback2, self)
	end
end

function Rouge2_RelicsDropItem:_receiveRpcCallback(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	self._rpcCallback = nil

	ViewMgr.instance:closeView(ViewName.Rouge2_RelicsDropView)
end

function Rouge2_RelicsDropItem:_receiveRpcCallback2(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	self._rpcCallback = nil

	ViewMgr.instance:closeView(ViewName.Rouge2_RelicsDropView)
end

function Rouge2_RelicsDropItem:_tryStatDrop()
	if self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.Select then
		return
	end

	local itemNameList = Rouge2_BackpackHelper.getItemNameList(self._dataType, self._parentView._relicsList)

	Rouge2_StatController.instance:statSelectDrop(Rouge2_MapEnum.DropType.Relics, self._relicsId, self._relicsCo.name, itemNameList)
end

function Rouge2_RelicsDropItem:onSelectDropChange(index)
	self:onSelect(self._index == index)
end

function Rouge2_RelicsDropItem:onConfirmSelectDrop(index)
	if index == self._index then
		return
	end

	self._isClsoe = true

	self._comRelicsItem:playAnim("close")
end

function Rouge2_RelicsDropItem:setParentScroll(parentScroll)
	self._comRelicsItem:setParentScroll(parentScroll)
end

function Rouge2_RelicsDropItem:onUpdateMO(index, viewType, dataType, dataId, parentView)
	self._parentView = parentView
	self._viewType = viewType
	self._index = index
	self._dataType = dataType
	self._relicsCo, self._relicsMo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, dataId)
	self._relicsId = self._relicsCo and self._relicsCo.id

	self:onSelect(false)
	self._comRelicsItem:onUpdateMO(dataType, dataId)
	self._comRelicsItem:playAnim("open")

	self._isClsoe = false

	gohelper.setActive(self._goSelect, false)
	gohelper.setActive(self._goSelect2, false)
end

function Rouge2_RelicsDropItem:onSelect(isSelect)
	if self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.Select and self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.LevelUp then
		isSelect = false
	end

	if self._isSelect == isSelect then
		return
	end

	self._isSelect = isSelect

	self._comRelicsItem:onSelect(isSelect)
	gohelper.setActive(self._goSelect, isSelect and self._viewType == Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._goSelect2, isSelect and self._viewType == Rouge2_MapEnum.ItemDropViewEnum.LevelUp)
end

function Rouge2_RelicsDropItem:_onCloseView(viewName)
	if viewName ~= ViewName.Rouge2_RelicsDropView or self._isClsoe then
		return
	end

	self._comRelicsItem:playAnim("close")
end

function Rouge2_RelicsDropItem:onDestroy()
	GameUtil.setActiveUIBlock("Rouge2_RelicsDropItem", false, true)

	if self._rpcCallback then
		Rouge2_Rpc.instance:removeCallbackById(self._rpcCallback)

		self._rpcCallback = nil
	end
end

return Rouge2_RelicsDropItem
