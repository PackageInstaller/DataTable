-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackRelicsListItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackRelicsListItem", package.seeall)

local Rouge2_BackpackRelicsListItem = class("Rouge2_BackpackRelicsListItem", ListScrollCellExtend)

function Rouge2_BackpackRelicsListItem:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "go_Root")
	self._goCheck = gohelper.findChild(self.viewGO, "go_Check")
end

function Rouge2_BackpackRelicsListItem:initInternal(go, view)
	Rouge2_BackpackRelicsListItem.super.initInternal(self, go, view)

	local goScroll = gohelper.findChild(view.viewGO, view._param.scrollGOPath)
	local goCollection = view:getResInst(Rouge2_Enum.ResPath.ComRelicsItem, self._goRoot)

	self._comRelicsItem = Rouge2_CommonCollectionItem.Get(goCollection)

	self._comRelicsItem:setParentScroll(goScroll)
	self._comRelicsItem:initDescModeFlag(Rouge2_Enum.ItemDescModeDataKey.BackpackRelics)

	local goReddot = self._comRelicsItem:getReddotGo()

	self._reddotComp = Rouge2_BackpackItemReddotComp.Get(goReddot, self._goCheck, goScroll)
end

function Rouge2_BackpackRelicsListItem:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnScrollRelicsBag, self._onScrollRelicsBag, self)
end

function Rouge2_BackpackRelicsListItem:removeEvents()
	return
end

function Rouge2_BackpackRelicsListItem:onUpdateMO(relicsMo)
	local relicsUid = relicsMo:getUid()

	self._comRelicsItem:onUpdateMO(Rouge2_Enum.ItemDataType.Server, relicsUid)

	local reddotId = Rouge2_Enum.BagTabType2Reddot[Rouge2_Enum.BagTabType.Relics]

	self._reddotComp:intReddotInfo(reddotId, relicsUid)
	self:showOpenAnim()
end

function Rouge2_BackpackRelicsListItem:showOpenAnim()
	self._canPlayOpenAnim = Rouge2_BackpackRelicsListModel.instance:canPlayAinm(self._index)

	local animName = self._canPlayOpenAnim and "open" or "normal"

	self._comRelicsItem:playAnim(animName)
end

function Rouge2_BackpackRelicsListItem:_onScrollRelicsBag()
	self._reddotComp:refresh()
end

function Rouge2_BackpackRelicsListItem:_onCloseView(viewName)
	if viewName ~= ViewName.Rouge2_BackpackTabView then
		return
	end

	self._comRelicsItem:playAnim("close")
end

function Rouge2_BackpackRelicsListItem:onDestroyView()
	return
end

return Rouge2_BackpackRelicsListItem
