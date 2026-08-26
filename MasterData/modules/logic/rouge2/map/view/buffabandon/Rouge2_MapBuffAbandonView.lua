-- chunkname: @modules/logic/rouge2/map/view/buffabandon/Rouge2_MapBuffAbandonView.lua

module("modules.logic.rouge2.map.view.buffabandon.Rouge2_MapBuffAbandonView", package.seeall)

local Rouge2_MapBuffAbandonView = class("Rouge2_MapBuffAbandonView", BaseView)

function Rouge2_MapBuffAbandonView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_fullbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_rightbg")
	self._simagetopbg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_topbg1")
	self._simagetopbg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_topbg2")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title/#txt_Title")
	self._goTab = gohelper.findChild(self.viewGO, "#go_Tab")
	self._goBuffContent = gohelper.findChild(self.viewGO, "Container/#scroll_Buff/Viewport/Content")
	self._goBuffItem = gohelper.findChild(self.viewGO, "Container/#scroll_Buff/Viewport/Content/#go_BuffItem")
	self._btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "Container/#btn_Confirm")
	self._goActive = gohelper.findChild(self.viewGO, "Container/#btn_Confirm/#go_Active")
	self._txtSelectNum1 = gohelper.findChildText(self.viewGO, "Container/#btn_Confirm/#go_Active/#txt_SelectNum1")
	self._goDisactive = gohelper.findChild(self.viewGO, "Container/#btn_Confirm/#go_Disactive")
	self._txtSelectNum2 = gohelper.findChildText(self.viewGO, "Container/#btn_Confirm/#go_Disactive/#txt_SelectNum2")
	self._goEmpty = gohelper.findChild(self.viewGO, "Container/#go_Empty")
	self._goTeamTips = gohelper.findChild(self.viewGO, "#go_TeamTips")
	self._goMode = gohelper.findChild(self.viewGO, "Container/#go_Mode")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapBuffAbandonView:addEvents()
	self._btnConfirm:AddClickListener(self._btnConfirmOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectLossItemChange, self._onSelectLossBuffChange, self)
end

function Rouge2_MapBuffAbandonView:removeEvents()
	self._btnConfirm:RemoveClickListener()
end

function Rouge2_MapBuffAbandonView:_btnConfirmOnClick()
	if Rouge2_LossBuffListModel.instance:getSelectCount() < self.lossNum then
		GameFacade.showToast(ToastEnum.Rouge2LossItemNum, self.lossNum)

		return
	end

	local selectUidList = {}
	local selectItemList = Rouge2_LossBuffListModel.instance:getSelectItemList()

	if selectItemList then
		for _, selectMo in ipairs(selectItemList) do
			table.insert(selectUidList, selectMo:getUid())
		end
	end

	self.callbackId = Rouge2_Rpc.instance:sendRouge2SelectLostCollectionRequest(selectUidList, self.onReceiveMsg, self)
end

function Rouge2_MapBuffAbandonView:onReceiveMsg(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	self.callbackId = nil

	self:closeThis()
end

function Rouge2_MapBuffAbandonView:_editableInitView()
	gohelper.setActive(self._goBuffItem, false)
	Rouge2_CommonItemDescModeSwitcher.Load(self._goMode, Rouge2_Enum.ItemDescModeDataKey.BuffAbandon)
	Rouge2_TeamRecommendTipsLoader.LoadWithParams(self._goTeamTips, Rouge2_Enum.TeamRecommendTipType.Default)
	NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)
end

function Rouge2_MapBuffAbandonView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.LossCollectionViewOpen)

	self.lossType = self.viewParam and self.viewParam.lossType
	self.lossNum = self.viewParam and self.viewParam.lostNum
	self.itemList = self.viewParam and self.viewParam.itemList

	Rouge2_LossBuffListModel.instance:setLossType(self.lossType)
	Rouge2_LossBuffListModel.instance:initList(self.lossNum, self.itemList, Rouge2_Enum.BagItemTabId_All)
	self:initToolBar()
	self:refreshUI()
end

function Rouge2_MapBuffAbandonView:refreshUI()
	self:refreshTitle()
	self:refreshBtn()
	self:refreshBuffList()
end

function Rouge2_MapBuffAbandonView:refreshBuffList()
	local buffList = Rouge2_LossBuffListModel.instance:getList()

	if buffList then
		if not #buffList then
			local buffNum = 0

			gohelper.setActive(self._goEmpty, buffNum <= 0)
			gohelper.CreateObjList(self, self._refreshBuffItem, buffList, self._goBuffContent, self._goBuffItem, Rouge2_MapBuffLossItem)
		end
	end
end

function Rouge2_MapBuffAbandonView:_refreshBuffItem(buffItem, buffMo, index)
	buffItem:initParent(self)
	buffItem:onUpdateMO(index, buffMo)
end

function Rouge2_MapBuffAbandonView:initToolBar()
	local goAttrSplitToolbar = self:getResInst(Rouge2_Enum.ResPath.AttrSplitToolbar, self._goTab)

	self._attrSplitToolbar = Rouge2_AttrSplitToolBar.Load(goAttrSplitToolbar, Rouge2_Enum.AttrSplitToolbarEventFlag.AbandonBuff)

	self._attrSplitToolbar:initSwitchCallback(self._btnClickTagOnClick, self)
	self._attrSplitToolbar:initRefreshNumFlagFunc(self._refrshNumFlagFunc, self)
	self:refreshToolbar()
end

function Rouge2_MapBuffAbandonView:refreshToolbar()
	local tabIdList = Rouge2_LossBuffListModel.instance:getTabIdList()
	local curTabId = Rouge2_LossBuffListModel.instance:getCurTabId()

	self._attrSplitToolbar:onUpdateMO(tabIdList, curTabId)
end

function Rouge2_MapBuffAbandonView:refreshBtn()
	local selectCount = Rouge2_LossBuffListModel.instance:getSelectCount()
	local txt = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rouge2_maprelicsabandonview_select"), selectCount, self.lossNum)
	local isActive = selectCount >= self.lossNum

	gohelper.setActive(self._goActive, isActive)
	gohelper.setActive(self._goDisactive, not isActive)

	self._txtSelectNum1.text = txt
	self._txtSelectNum2.text = txt
end

function Rouge2_MapBuffAbandonView:refreshTitle()
	self._txtTitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_mapbuffabandonview_title"), self.lossNum)
end

function Rouge2_MapBuffAbandonView:_onSelectLossBuffChange()
	self:refreshBtn()
	self:refreshToolbar()
end

function Rouge2_MapBuffAbandonView:_btnClickTagOnClick(attrId)
	Rouge2_LossBuffListModel.instance:switch(attrId)
	self:refreshUI()
end

function Rouge2_MapBuffAbandonView:_refrshNumFlagFunc(attrId)
	local selectCount = Rouge2_LossBuffListModel.instance:getSelectCountByAttr(attrId)

	return selectCount and selectCount > 0, selectCount
end

function Rouge2_MapBuffAbandonView:onDestroyView()
	return
end

return Rouge2_MapBuffAbandonView
