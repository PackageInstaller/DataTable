-- chunkname: @modules/logic/rouge2/map/view/attrbuffdrop/Rouge2_AttrBuffDropView.lua

module("modules.logic.rouge2.map.view.attrbuffdrop.Rouge2_AttrBuffDropView", package.seeall)

local Rouge2_AttrBuffDropView = class("Rouge2_AttrBuffDropView", BaseView)

function Rouge2_AttrBuffDropView:onInitView()
	self._goSelectBg = gohelper.findChild(self.viewGO, "#go_Info/#go_SelectBG")
	self._goDropBG = gohelper.findChild(self.viewGO, "#go_Info/#go_DropBG")
	self._goLossBG = gohelper.findChild(self.viewGO, "#go_Info/#go_LossBG")
	self._goTipsBG = gohelper.findChild(self.viewGO, "#go_Info/#go_TipsBG")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Info/#btn_Close")
	self._goSelect = gohelper.findChild(self.viewGO, "#go_Info/Title/#go_Select")
	self._goDrop = gohelper.findChild(self.viewGO, "#go_Info/Title/#go_Drop")
	self._scrollView = gohelper.findChildScrollRect(self.viewGO, "#go_Info/Layout/scroll_view")
	self._goContent = gohelper.findChild(self.viewGO, "#go_Info/Layout/scroll_view/Viewport/Content")
	self._goBuffItem = gohelper.findChild(self.viewGO, "#go_Info/Layout/scroll_view/Viewport/Content/#go_BuffItem")
	self._goBottomLeft = gohelper.findChild(self.viewGO, "#go_Info/#go_bottomleft")
	self._goTopLeft = gohelper.findChild(self.viewGO, "#go_Info/#go_topleft")
	self._goTopRight = gohelper.findChild(self.viewGO, "#go_Info/#go_topright")
	self._imageTitleBG = gohelper.findChild(self.viewGO, "#go_Info/Title/image_TitleBG")
	self._goTips = gohelper.findChild(self.viewGO, "#go_Info/Layout/#go_AttrReason/#go_tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "#go_Info/Layout/#go_AttrReason/#go_tips/#txt_tips")
	self._goRefresh = gohelper.findChild(self.viewGO, "#go_Info/#go_Refresh")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AttrBuffDropView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_AttrBuffDropView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_AttrBuffDropView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_AttrBuffDropView:_editableInitView()
	self._goScroll = self._scrollView.gameObject
	self._refreshLoader = Rouge2_ItemRefreshCompLoader.Get(self._goRefresh)

	self._refreshLoader:initRefreshCallback(self._onRefreshItemCallback, self)
	Rouge2_AttributeToolBar.Load(self._goBottomLeft, Rouge2_Enum.AttributeToolType.Enter)
	Rouge2_CommonItemDescModeSwitcher.Load(self._goTopRight, Rouge2_Enum.ItemDescModeDataKey.AttrBuffDrop)
end

function Rouge2_AttrBuffDropView:onOpen()
	self:initViewParam()
	self:refreshUI()
end

function Rouge2_AttrBuffDropView:onOpenFinish()
	return
end

function Rouge2_AttrBuffDropView:onUpdateParam()
	self:initViewParam()
	self:refreshUI()
end

function Rouge2_AttrBuffDropView:initViewParam()
	self._viewEnum = self.viewParam and self.viewParam.viewEnum
	self._dataType = self.viewParam and self.viewParam.dataType

	if self.viewParam then
		self._itemList = self.viewParam.itemList or {}
	end

	self._reason = self.viewParam and self.viewParam.reason

	NavigateMgr.instance:removeEscape(self.viewName)

	local canSelect = self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select or self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.LevelUp

	if canSelect then
		NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)
	end

	self._refreshLoader:show(canSelect)
end

function Rouge2_AttrBuffDropView:refreshUI()
	self:refreshTips()
	self:refreshTitle()
	self:refreshButton()
	self:refreshBuffList()
end

function Rouge2_AttrBuffDropView:refreshTitle()
	gohelper.setActive(self._goSelect, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._goDrop, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Drop)
	gohelper.setActive(self._imageTitleBG.gameObject, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Tips)

	local showSelectBg = self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select or self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.LevelUp

	gohelper.setActive(self._goSelectBg, showSelectBg)
	gohelper.setActive(self._goDropBG, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Drop)
	gohelper.setActive(self._goTipsBG, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Tips)
end

function Rouge2_AttrBuffDropView:refreshButton()
	gohelper.setActive(self._btnClose.gameObject, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select and self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.LevelUp)
end

function Rouge2_AttrBuffDropView:refreshBuffList()
	gohelper.CreateObjList(self, self._refreshBuffItem, self._itemList, self._goContent, self._goBuffItem, Rouge2_AttrBuffDropItem)

	self._scrollView.horizontalNormalizedPosition = 0
end

function Rouge2_AttrBuffDropView:_refreshBuffItem(relicsItem, relicsId, index)
	relicsItem:setParentScroll(self._goScroll)
	relicsItem:onUpdateMO(index, self._viewEnum, self._dataType, relicsId, self)
end

function Rouge2_AttrBuffDropView:refreshTips()
	local remainStep = Rouge2_AttrDropController.instance:getRemainStep2GetBigAttrDrop()
	local hasRemainStep = remainStep and remainStep > 0
	local show = hasRemainStep and self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select

	gohelper.setActive(self._goTips, show)

	if not show then
		return
	end

	self._txtTips.text = remainStep == 1 and luaLang("rouge2_attrbuffdropview_nextreward2") or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_attrbuffdropview_nextreward"), remainStep)
end

function Rouge2_AttrBuffDropView:_onRefreshItemCallback(dropList)
	self._itemList = dropList or {}

	self:refreshBuffList()
end

return Rouge2_AttrBuffDropView
