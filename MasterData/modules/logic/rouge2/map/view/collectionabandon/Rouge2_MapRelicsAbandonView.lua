-- chunkname: @modules/logic/rouge2/map/view/collectionabandon/Rouge2_MapRelicsAbandonView.lua

module("modules.logic.rouge2.map.view.collectionabandon.Rouge2_MapRelicsAbandonView", package.seeall)

local Rouge2_MapRelicsAbandonView = class("Rouge2_MapRelicsAbandonView", BaseView)

function Rouge2_MapRelicsAbandonView:onInitView()
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title/#txt_Title")
	self._goEmpty = gohelper.findChild(self.viewGO, "Container/#go_Empty")
	self._btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "Container/#btn_Confirm")
	self._goActive = gohelper.findChild(self.viewGO, "Container/#btn_Confirm/#go_Active")
	self._txtSelectNum1 = gohelper.findChildText(self.viewGO, "Container/#btn_Confirm/#go_Active/#txt_SelectNum1")
	self._goDisactive = gohelper.findChild(self.viewGO, "Container/#btn_Confirm/#go_Disactive")
	self._txtSelectNum2 = gohelper.findChildText(self.viewGO, "Container/#btn_Confirm/#go_Disactive/#txt_SelectNum2")
	self._goTab = gohelper.findChild(self.viewGO, "#go_Tab")
	self._goMode = gohelper.findChild(self.viewGO, "Container/#go_Mode")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapRelicsAbandonView:addEvents()
	self._btnConfirm:AddClickListener(self._btnConfirmOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectLossItemChange, self._onSelectLossRelicsChange, self)
end

function Rouge2_MapRelicsAbandonView:removeEvents()
	self._btnConfirm:RemoveClickListener()
end

function Rouge2_MapRelicsAbandonView:_btnConfirmOnClick()
	if Rouge2_LossRelicsListModel.instance:getSelectCount() < self.lossNum then
		GameFacade.showToast(ToastEnum.Rouge2LossItemNum, self.lossNum)

		return
	end

	local selectUidList = {}
	local selectItemList = Rouge2_LossRelicsListModel.instance:getSelectItemList()

	if selectItemList then
		for _, selectMo in ipairs(selectItemList) do
			table.insert(selectUidList, selectMo:getUid())
		end
	end

	self.callbackId = Rouge2_Rpc.instance:sendRouge2SelectLostCollectionRequest(selectUidList, self.onReceiveMsg, self)
end

function Rouge2_MapRelicsAbandonView:onReceiveMsg(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	self.callbackId = nil

	self:closeThis()
end

function Rouge2_MapRelicsAbandonView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)
	Rouge2_CommonItemDescModeSwitcher.Load(self._goMode, Rouge2_Enum.ItemDescModeDataKey.RelicsAbandon)
end

function Rouge2_MapRelicsAbandonView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.LossCollectionViewOpen)

	self.lossType = self.viewParam and self.viewParam.lossType
	self.lossNum = self.viewParam and self.viewParam.lostNum
	self.itemList = self.viewParam and self.viewParam.itemList

	Rouge2_LossRelicsListModel.instance:setLossType(self.lossType)
	Rouge2_LossRelicsListModel.instance:initList(self.lossNum, self.itemList, Rouge2_Enum.BagItemTabId_All)
	self:initToolBar()
	self:refreshUI()
end

function Rouge2_MapRelicsAbandonView:refreshUI()
	self:refreshTitle()
	self:refreshBtn()
	self:refreshEmpty()
end

function Rouge2_MapRelicsAbandonView:initToolBar()
	local goAttrSplitToolbar = self:getResInst(Rouge2_Enum.ResPath.AttrSplitToolbar, self._goTab)

	self._attrSplitToolbar = Rouge2_AttrSplitToolBar.Load(goAttrSplitToolbar, Rouge2_Enum.AttrSplitToolbarEventFlag.AbandonRelics)

	self._attrSplitToolbar:initSwitchCallback(self._btnClickTagOnClick, self)
	self._attrSplitToolbar:initRefreshNumFlagFunc(self._refrshNumFlagFunc, self)
	self:refreshToolbar()
end

function Rouge2_MapRelicsAbandonView:refreshToolbar()
	local tabIdList = Rouge2_LossRelicsListModel.instance:getTabIdList()
	local curTabId = Rouge2_LossRelicsListModel.instance:getCurTabId()

	self._attrSplitToolbar:onUpdateMO(tabIdList, curTabId)
end

function Rouge2_MapRelicsAbandonView:refreshBtn()
	local selectCount = Rouge2_LossRelicsListModel.instance:getSelectCount()
	local txt = string.format("%s/%s", selectCount, self.lossNum)
	local isActive = selectCount >= self.lossNum

	gohelper.setActive(self._goActive, isActive)
	gohelper.setActive(self._goDisactive, not isActive)

	self._txtSelectNum1.text = txt
	self._txtSelectNum2.text = txt
end

function Rouge2_MapRelicsAbandonView:refreshEmpty()
	local relicsNum = Rouge2_LossRelicsListModel.instance:getCount()

	gohelper.setActive(self._goEmpty, relicsNum <= 0)
end

function Rouge2_MapRelicsAbandonView:refreshTitle()
	self._txtTitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_maprelicsabandonview_title"), self.lossNum)
end

function Rouge2_MapRelicsAbandonView:_onSelectLossRelicsChange()
	self:refreshBtn()
	self:refreshToolbar()
end

function Rouge2_MapRelicsAbandonView:_btnClickTagOnClick(attrId)
	Rouge2_LossRelicsListModel.instance:switch(attrId)
	self:refreshUI()
end

function Rouge2_MapRelicsAbandonView:_refrshNumFlagFunc(attrId)
	local selectCount = Rouge2_LossRelicsListModel.instance:getSelectCountByAttr(attrId)

	return selectCount and selectCount > 0, selectCount
end

function Rouge2_MapRelicsAbandonView:onDestroyView()
	return
end

return Rouge2_MapRelicsAbandonView
