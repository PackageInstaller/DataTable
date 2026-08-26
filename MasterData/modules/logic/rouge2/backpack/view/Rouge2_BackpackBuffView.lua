-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackBuffView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackBuffView", package.seeall)

local Rouge2_BackpackBuffView = class("Rouge2_BackpackBuffView", BaseView)

function Rouge2_BackpackBuffView:onInitView()
	self._goTab = gohelper.findChild(self.viewGO, "#go_Tab")
	self._goEmpty = gohelper.findChild(self.viewGO, "#go_Prop/#go_Empty")
	self._scrollProp = gohelper.findChildScrollRect(self.viewGO, "#go_Prop/#scroll_Prop")
	self._goPropItem = gohelper.findChild(self.viewGO, "#go_Prop/#scroll_Prop/Viewport/Content/#go_PropItem")
	self._goPropContent = gohelper.findChild(self.viewGO, "#go_Prop/#scroll_Prop/Viewport/Content")
	self._goTeamTips = gohelper.findChild(self.viewGO, "#go_TeamTips")
	self._goMode = gohelper.findChild(self.viewGO, "#go_Mode")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackBuffView:addEvents()
	self._scrollProp:AddOnValueChanged(self._scrollPropChanged, self)
end

function Rouge2_BackpackBuffView:removeEvents()
	self._scrollProp:RemoveOnValueChanged()
end

function Rouge2_BackpackBuffView:_scrollPropChanged()
	if self.isClose then
		return
	end

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnScrollBuffBag)
end

function Rouge2_BackpackBuffView:_editableInitView()
	self._goScroll = self._scrollProp.gameObject

	gohelper.setActive(self._goPropItem, false)

	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	local relicsList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.Buff)

	Rouge2_BackpackBuffListModel.instance:initList(relicsList, 0)
	Rouge2_CommonItemDescModeSwitcher.Load(self._goMode, Rouge2_Enum.ItemDescModeDataKey.BackpackBuff)
	Rouge2_TeamRecommendTipsLoader.LoadWithParams(self._goTeamTips, Rouge2_Enum.TeamRecommendTipType.Single)
	self:initScrollView()
	self:initToolbar()
end

function Rouge2_BackpackBuffView:initToolbar()
	local goAttrSplitToolbar = self:getResInst(Rouge2_Enum.ResPath.AttrSplitToolbar, self._goTab)

	self._attrSplitToolbar = Rouge2_AttrSplitToolBar.Load(goAttrSplitToolbar, Rouge2_Enum.AttrSplitToolbarEventFlag.Buff)

	self._attrSplitToolbar:initSwitchCallback(self._btnClickTagOnClick, self)

	local tabIdList = Rouge2_BackpackBuffListModel.instance:getTabIdList()
	local curTabId = Rouge2_BackpackBuffListModel.instance:getCurTabId()

	self._attrSplitToolbar:onUpdateMO(tabIdList, curTabId)
end

function Rouge2_BackpackBuffView:_btnClickTagOnClick(attrId)
	Rouge2_BackpackBuffListModel.instance:switch(attrId)
	self:refreshUI()
end

function Rouge2_BackpackBuffView:onOpen()
	self.isClose = false

	self:refreshUI()
	self._animator:Play("open", 0, 0)
end

function Rouge2_BackpackBuffView:refreshUI()
	gohelper.setActive(self._goEmpty, Rouge2_BackpackBuffListModel.instance:getCount() <= 0)
	self:initScrollView()
end

function Rouge2_BackpackBuffView:initScrollView()
	local buffItemList = Rouge2_BackpackBuffListModel.instance:getList()

	gohelper.CreateObjList(self, self._refreshBuffItem, buffItemList, self._goPropContent, self._goPropItem, Rouge2_BackpackBuffListItem)
	ZProj.UGUIHelper.RebuildLayout(self._scrollProp.transform)

	self._scrollProp.verticalNormalizedPosition = 1
end

function Rouge2_BackpackBuffView:_refreshBuffItem(buffListItem, buffMo, index)
	buffListItem:initParent(self, self._goScroll)
	buffListItem:onUpdateMO(index, buffMo)
end

function Rouge2_BackpackBuffView:onClose()
	self.isClose = true
end

function Rouge2_BackpackBuffView:onDestroyView()
	return
end

return Rouge2_BackpackBuffView
