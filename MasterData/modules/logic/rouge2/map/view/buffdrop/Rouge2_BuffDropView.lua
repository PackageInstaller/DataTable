-- chunkname: @modules/logic/rouge2/map/view/buffdrop/Rouge2_BuffDropView.lua

module("modules.logic.rouge2.map.view.buffdrop.Rouge2_BuffDropView", package.seeall)

local Rouge2_BuffDropView = class("Rouge2_BuffDropView", BaseView)

Rouge2_BuffDropView.ScrollPos = {
	[Rouge2_MapEnum.ItemDropViewEnum.Select] = Vector2(216.4, 0),
	[Rouge2_MapEnum.ItemDropViewEnum.Drop] = Vector2(0, 4.7),
	[Rouge2_MapEnum.ItemDropViewEnum.Loss] = Vector2(0, 4.7)
}

function Rouge2_BuffDropView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goSelectBG = gohelper.findChild(self.viewGO, "#go_SelectBG")
	self._goDropBG = gohelper.findChild(self.viewGO, "#go_DropBG")
	self._goLossBG = gohelper.findChild(self.viewGO, "#go_LossBG")
	self._goSelect = gohelper.findChild(self.viewGO, "Title/#go_Select")
	self._goDrop = gohelper.findChild(self.viewGO, "Title/#go_Drop")
	self._goLoss = gohelper.findChild(self.viewGO, "Title/#go_Loss")
	self._scrollView = gohelper.findChildScrollRect(self.viewGO, "scroll_view")
	self._goContent = gohelper.findChild(self.viewGO, "scroll_view/Viewport/Content")
	self._goToolbar = gohelper.findChild(self.viewGO, "#go_Toolbar")
	self._goTopLeft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goMode = gohelper.findChild(self.viewGO, "#go_Mode")
	self._goRefresh = gohelper.findChild(self.viewGO, "#go_Refresh")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BuffDropView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_BuffDropView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_BuffDropView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_BuffDropView:_editableInitView()
	self._refreshLoader = Rouge2_ItemRefreshCompLoader.Get(self._goRefresh)

	self._refreshLoader:initRefreshCallback(self._onRefreshItemCallback, self)
	Rouge2_CommonItemDescModeSwitcher.Load(self._goMode, Rouge2_Enum.ItemDescModeDataKey.BuffDrop)
	Rouge2_AttributeToolBar.Load(self._goToolbar, Rouge2_Enum.AttributeToolType.Enter)

	self._goBuffItem = self:getResInst(Rouge2_Enum.ResPath.BuffDropItem, self._goContent)
	self._tranScrollView = self._scrollView.transform
end

function Rouge2_BuffDropView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.DropBuff)
	self:initViewParam()
	self:refreshUI()
end

function Rouge2_BuffDropView:onUpdateParam()
	self:initViewParam()
	self:refreshUI()
end

function Rouge2_BuffDropView:initViewParam()
	self._viewEnum = self.viewParam and self.viewParam.viewEnum
	self._dataType = self.viewParam and self.viewParam.dataType

	if self.viewParam then
		self._buffList = self.viewParam.itemList or {}
	end

	NavigateMgr.instance:removeEscape(self.viewName)

	if self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select then
		NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)
	end

	gohelper.setActive(self._goToolbar, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select)
	self._refreshLoader:show(self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select)
end

function Rouge2_BuffDropView:refreshUI()
	self:refreshTitle()
	self:refreshButton()
	self:refreshBuffList()
	self:refreshScrollPos()
end

function Rouge2_BuffDropView:refreshTitle()
	gohelper.setActive(self._goSelect, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._goDrop, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Drop)
	gohelper.setActive(self._goLoss, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Loss)
	gohelper.setActive(self._goSelectBG, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._goDropBG, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Drop)
	gohelper.setActive(self._goLossBG, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Loss)
end

function Rouge2_BuffDropView:refreshButton()
	gohelper.setActive(self._btnClose.gameObject, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._goTopLeft, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select)
end

function Rouge2_BuffDropView:refreshBuffList()
	gohelper.CreateObjList(self, self._refreshBuffItem, self._buffList, self._goContent, self._goBuffItem, Rouge2_BuffDropItem)
end

function Rouge2_BuffDropView:_refreshBuffItem(buffItem, buffId, index)
	buffItem:onUpdateMO(index, self._viewEnum, self._dataType, buffId, self)
end

function Rouge2_BuffDropView:refreshScrollPos()
	if self._viewEnum then
		local scrollPos = Rouge2_BuffDropView.ScrollPos[self._viewEnum]

		scrollPos = self._viewEnum or Vector2(0, 0)

		recthelper.setAnchor(self._tranScrollView, self._viewEnum.x, self._viewEnum.y)
	end
end

function Rouge2_BuffDropView:_onRefreshItemCallback(dropList)
	self._buffList = dropList or {}

	self:refreshBuffList()
end

return Rouge2_BuffDropView
