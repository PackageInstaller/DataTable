-- chunkname: @modules/logic/rouge2/map/view/relicsdrop/Rouge2_RelicsDropView.lua

module("modules.logic.rouge2.map.view.relicsdrop.Rouge2_RelicsDropView", package.seeall)

local Rouge2_RelicsDropView = class("Rouge2_RelicsDropView", BaseView)

function Rouge2_RelicsDropView:onInitView()
	self._goSelectBg = gohelper.findChild(self.viewGO, "#go_SelectBG")
	self._goDropBG = gohelper.findChild(self.viewGO, "#go_DropBG")
	self._goLossBG = gohelper.findChild(self.viewGO, "#go_LossBG")
	self._goTipsBG = gohelper.findChild(self.viewGO, "#go_TipsBG")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goSelect = gohelper.findChild(self.viewGO, "Title/#go_Select")
	self._goDrop = gohelper.findChild(self.viewGO, "Title/#go_Drop")
	self._goLoss = gohelper.findChild(self.viewGO, "Title/#go_Loss")
	self._goStrength = gohelper.findChild(self.viewGO, "Title/#go_Strength")
	self._scrollView = gohelper.findChildScrollRect(self.viewGO, "scroll_view")
	self._goContent = gohelper.findChild(self.viewGO, "scroll_view/Viewport/Content")
	self._goRelicsItem = gohelper.findChild(self.viewGO, "scroll_view/Viewport/Content/#go_RelicsItem")
	self._goBottomLeft = gohelper.findChild(self.viewGO, "#go_bottomleft")
	self._goTopLeft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goTopRight = gohelper.findChild(self.viewGO, "#go_topright")
	self._goLevelUpSuccEffect = gohelper.findChild(self.viewGO, "#go_successEffect")
	self._imageTitleBG = gohelper.findChild(self.viewGO, "Title/image_TitleBG")
	self._goRefresh = gohelper.findChild(self.viewGO, "#go_Refresh")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_RelicsDropView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_RelicsDropView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_RelicsDropView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_RelicsDropView:_editableInitView()
	self._goScroll = self._scrollView.gameObject
	self._refreshLoader = Rouge2_ItemRefreshCompLoader.Get(self._goRefresh)

	self._refreshLoader:initRefreshCallback(self._onRefreshItemCallback, self)
	Rouge2_AttributeToolBar.Load(self._goBottomLeft, Rouge2_Enum.AttributeToolType.Skill_Detail)
	Rouge2_CommonItemDescModeSwitcher.Load(self._goTopRight, Rouge2_Enum.ItemDescModeDataKey.RelicsDrop)
end

function Rouge2_RelicsDropView:onOpen()
	self:initViewParam()
	self:refreshUI()

	if self._isLevelUpSucc then
		AudioMgr.instance:trigger(AudioEnum.Rouge2.LevelUpRelics)
	else
		AudioMgr.instance:trigger(AudioEnum.Rouge2.DropRelics)
	end
end

function Rouge2_RelicsDropView:onOpenFinish()
	if self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select then
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideGetRelics)
	end
end

function Rouge2_RelicsDropView:onUpdateParam()
	self:initViewParam()
	self:refreshUI()
end

function Rouge2_RelicsDropView:initViewParam()
	self._viewEnum = self.viewParam and self.viewParam.viewEnum
	self._dataType = self.viewParam and self.viewParam.dataType

	if self.viewParam then
		self._relicsList = self.viewParam.itemList or {}
	end

	self._reason = self.viewParam and self.viewParam.reason

	NavigateMgr.instance:removeEscape(self.viewName)

	self._canSelect = self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select or self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.LevelUp

	if self._canSelect then
		NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)
	end

	self._refreshLoader:show(self._canSelect)
end

function Rouge2_RelicsDropView:refreshUI()
	self:refreshTitle()
	self:refreshButton()
	self:refreshRelicsList()
end

function Rouge2_RelicsDropView:refreshTitle()
	self._isLevelUpSucc = self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Drop and self._reason == Rouge2_MapEnum.ItemDropReason.LevelUpSucc

	gohelper.setActive(self._goSelect, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._goDrop, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Drop and not self._isLevelUpSucc)
	gohelper.setActive(self._goLoss, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Loss)
	gohelper.setActive(self._goStrength, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.LevelUp or self._isLevelUpSucc)
	gohelper.setActive(self._imageTitleBG.gameObject, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Tips)
	gohelper.setActive(self._goLevelUpSuccEffect, self._isLevelUpSucc)

	local showSelectBg = self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select or self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.LevelUp

	gohelper.setActive(self._goSelectBg, showSelectBg)
	gohelper.setActive(self._goDropBG, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Drop)
	gohelper.setActive(self._goLossBG, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Loss)
	gohelper.setActive(self._goTipsBG, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Tips)
	gohelper.setActive(self._goBottomLeft, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select)
end

function Rouge2_RelicsDropView:refreshButton()
	gohelper.setActive(self._btnClose.gameObject, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select and self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.LevelUp)
	gohelper.setActive(self._goTopLeft, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select and self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.LevelUp)
end

function Rouge2_RelicsDropView:refreshRelicsList()
	gohelper.CreateObjList(self, self._refreshRelicsItem, self._relicsList, self._goContent, self._goRelicsItem, Rouge2_RelicsDropItem)

	self._scrollView.horizontalNormalizedPosition = 0
end

function Rouge2_RelicsDropView:_refreshRelicsItem(relicsItem, relicsId, index)
	relicsItem:setParentScroll(self._goScroll)
	relicsItem:onUpdateMO(index, self._viewEnum, self._dataType, relicsId, self)
end

function Rouge2_RelicsDropView:_onRefreshItemCallback(dropList)
	self._relicsList = dropList or {}

	self:refreshRelicsList()
end

return Rouge2_RelicsDropView
