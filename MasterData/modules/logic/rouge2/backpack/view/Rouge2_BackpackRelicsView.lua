-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackRelicsView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackRelicsView", package.seeall)

local Rouge2_BackpackRelicsView = class("Rouge2_BackpackRelicsView", BaseView)

function Rouge2_BackpackRelicsView:onInitView()
	self._goTab = gohelper.findChild(self.viewGO, "#go_Tab")
	self._goEmpty = gohelper.findChild(self.viewGO, "#go_Relics/#go_Empty")
	self._scrollRelics = gohelper.findChildScrollRect(self.viewGO, "#go_Relics/#scroll_Relics")
	self._goMode = gohelper.findChild(self.viewGO, "#go_Mode")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackRelicsView:addEvents()
	self._scrollRelics:AddOnValueChanged(self._scrollRelicsChanged, self)
end

function Rouge2_BackpackRelicsView:removeEvents()
	self._scrollRelics:RemoveOnValueChanged()
end

function Rouge2_BackpackRelicsView:_scrollRelicsChanged()
	if self.isClose then
		return
	end

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnScrollRelicsBag)
end

function Rouge2_BackpackRelicsView:_editableInitView()
	Rouge2_CommonItemDescModeSwitcher.Load(self._goMode, Rouge2_Enum.ItemDescModeDataKey.BackpackRelics)

	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	self:initScrollView()
	self:initToolbar()
end

function Rouge2_BackpackRelicsView:initToolbar()
	local goAttrSplitToolbar = self:getResInst(Rouge2_Enum.ResPath.AttrSplitToolbar, self._goTab)

	self._attrSplitToolbar = Rouge2_AttrSplitToolBar.Load(goAttrSplitToolbar, Rouge2_Enum.AttrSplitToolbarEventFlag.Relics)

	self._attrSplitToolbar:initSwitchCallback(self._btnClickTagOnClick, self)
end

function Rouge2_BackpackRelicsView:refreshToolbar()
	local tabIdList = Rouge2_BackpackRelicsListModel.instance:getTabIdList()
	local curTabId = Rouge2_BackpackRelicsListModel.instance:getCurTabId()

	self._attrSplitToolbar:onUpdateMO(tabIdList, curTabId)
end

function Rouge2_BackpackRelicsView:_btnClickTagOnClick(attrId)
	Rouge2_BackpackRelicsListModel.instance:switch(attrId)
	self:refreshUI()
end

function Rouge2_BackpackRelicsView:onOpen()
	self.isClose = false
	self._scrollRelics.horizontalNormalizedPosition = 0

	local relicsList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.Relics)

	Rouge2_BackpackRelicsListModel.instance:initList(relicsList, Rouge2_Enum.BagItemTabId_All)
	self:refreshToolbar()
	self:refreshUI()
	self._animatorPlayer:Play("open", self._onOpenAnimDone, self)
end

function Rouge2_BackpackRelicsView:_onOpenAnimDone()
	Rouge2_BackpackRelicsListModel.instance:markPlayAnim()
end

function Rouge2_BackpackRelicsView:refreshUI()
	gohelper.setActive(self._goEmpty, Rouge2_BackpackRelicsListModel.instance:getCount() <= 0)
end

function Rouge2_BackpackRelicsView:initScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_Relics/#scroll_Relics"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_Relics/#scroll_Relics/Viewport/Content/#go_Item"
	scrollParam.cellClass = Rouge2_BackpackRelicsListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellHeight = 760
	scrollParam.cellSpaceV = -5

	Rouge2_BackpackRelicsListModel.instance:clear()

	local scrollView = LuaMixScrollView.New(Rouge2_BackpackRelicsListModel.instance, scrollParam)

	scrollView:setDynamicGetItem(self._dynamicGetItem, self)
	self:addChildView(scrollView)
end

function Rouge2_BackpackRelicsView:_dynamicGetItem(mo)
	if not mo then
		return
	end

	if mo:getUid() <= 0 then
		return "formulaItem", Rouge2_BackpackFormulaListItem, "#go_Relics/#scroll_Relics/Viewport/Content/#go_FormulaItem"
	else
		return "relicsItem", Rouge2_BackpackRelicsListItem, "#go_Relics/#scroll_Relics/Viewport/Content/#go_Item"
	end
end

function Rouge2_BackpackRelicsView:onClose()
	self.isClose = true
end

function Rouge2_BackpackRelicsView:onDestroyView()
	return
end

return Rouge2_BackpackRelicsView
