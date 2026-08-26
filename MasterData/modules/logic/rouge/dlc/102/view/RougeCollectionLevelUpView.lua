-- chunkname: @modules/logic/rouge/dlc/102/view/RougeCollectionLevelUpView.lua

module("modules.logic.rouge.dlc.102.view.RougeCollectionLevelUpView", package.seeall)

local RougeCollectionLevelUpView = class("RougeCollectionLevelUpView", BaseView)

function RougeCollectionLevelUpView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_fullbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_rightbg")
	self._simagetopbg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_topbg1")
	self._simagetopbg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_topbg2")
	self._txtdec = gohelper.findChildText(self.viewGO, "Title/#txt_dec")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_filter")
	self._gounselect = gohelper.findChild(self.viewGO, "Left/#btn_filter/#go_unselect")
	self._goselect = gohelper.findChild(self.viewGO, "Left/#btn_filter/#go_select")
	self._txtnum = gohelper.findChildText(self.viewGO, "Right/#txt_num")
	self._gorightempty = gohelper.findChild(self.viewGO, "Right/#go_empty")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._goCollectionContainer = gohelper.findChild(self.viewGO, "#go_collectioncontainer")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionLevelUpView:addEvents()
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function RougeCollectionLevelUpView:removeEvents()
	self._btnfilter:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
end

function RougeCollectionLevelUpView:_btnfilterOnClick()
	self.param = self.param or {
		confirmCallback = self.onConfirmCallback,
		confirmCallbackObj = self,
		baseSelectMap = self.baseFilterTagDict,
		extraSelectMap = self.extraFilterTagDict
	}

	RougeController.instance:openRougeCollectionFilterView(self.param)
end

function RougeCollectionLevelUpView:onConfirmCallback(baseSelectMap, extraSelectMap)
	RougeCollectionHelper.removeInValidItem(baseSelectMap)
	RougeCollectionHelper.removeInValidItem(extraSelectMap)
	RougeCollectionLevelUpListModel.instance:filterCollection()
	self:refreshLeft()
end

function RougeCollectionLevelUpView:_btnconfirmOnClick()
	if RougeCollectionLevelUpListModel.instance:getSelectCount() > self.maxLevelUpNum then
		return
	end

	local mos = RougeCollectionLevelUpListModel.instance:getSelectMoList()
	local collectionUids = {}

	for _, mo in ipairs(mos) do
		table.insert(collectionUids, mo.uid)
	end

	self:sendSelectCollectionLevelUp(collectionUids)
end

function RougeCollectionLevelUpView:sendSelectCollectionLevelUp(collectionUids)
	local season = RougeModel.instance:getSeason()

	self.callbackId = RougeRpc.instance:sendRougeSelectCollectionLevelUpRequest(season, collectionUids or {}, self.onReceiveMsg, self)
end

function RougeCollectionLevelUpView:onReceiveMsg(cmd, resultCode, msg)
	self.callbackId = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onRefreshPieceChoiceEvent)
	self:closeThis()
end

function RougeCollectionLevelUpView:_editableInitView()
	self.goCollection = self.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, self._goCollectionContainer)
	self.collectionComp = RougeCollectionComp.Get(self.goCollection)

	self.collectionComp:_editableInitView()
	self._simagefullbg:LoadImage("singlebg/rouge/collection/rouge_collection_fullbg.png")
	self._simagerightbg:LoadImage("singlebg/rouge/collection/rouge_collection_storebg.png")
	self._simagetopbg1:LoadImage("singlebg/rouge/collection/rouge_collection_topmask_01.png")
	self._simagetopbg2:LoadImage("singlebg/rouge/collection/rouge_collection_topmask_02.png")

	self.leftCollectionItemList = {}
	self.rightCollectionItemList = {}
	self.selectedUidList = {}
	self.baseFilterTagDict = {}
	self.extraFilterTagDict = {}
	self.goRightItemContainer = gohelper.findChild(self.viewGO, "Right/#scroll_view/Viewport/Content")
	self.rightItem = self.viewContainer:getResInst(RougeEnum.ResPath.CollectionLevelUpRightItem, self.goRightItemContainer)

	gohelper.setActive(self.rightItem, false)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onSelectLossCollectionChange, self.onSelectLossCollectionChange, self)
end

function RougeCollectionLevelUpView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.LossCollectionViewOpen)
	self.collectionComp:onOpen()

	self.maxLevelUpNum = self.viewParam and self.viewParam.maxLevelUpNum

	RougeCollectionLevelUpListModel.instance:initList(self.maxLevelUpNum, self.baseFilterTagDict, self.extraFilterTagDict)
	self:refreshTitle()
	self:refreshLeft()
	self:refreshRight()
	self:refreshBtn()
	self:checkCanLevelUpSpCollectionNum()
end

function RougeCollectionLevelUpView:checkCanLevelUpSpCollectionNum()
	local canLevelUpSpCount = RougeCollectionLevelUpListModel.instance:getAllMoCount()
	local canLevelUpSpEmpty = not canLevelUpSpCount or canLevelUpSpCount <= 0

	if canLevelUpSpEmpty then
		local navigateView = self.viewContainer:getNavigateView()

		navigateView:setParam({
			true,
			false,
			false
		})
		navigateView:setOverrideClose(self.sendSelectCollectionLevelUp, self)
	end
end

function RougeCollectionLevelUpView:refreshTitle()
	self._txtdec.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rougecollectionlevelupview_desc"), self.maxLevelUpNum)
end

function RougeCollectionLevelUpView:refreshLeft()
	RougeCollectionLevelUpListModel.instance:refresh()
	self:refreshFilterBtn()
end

function RougeCollectionLevelUpView:refreshFilterBtn()
	local isFiltering = RougeCollectionLevelUpListModel.instance:isFiltering()

	gohelper.setActive(self._gofilterselect, isFiltering)
	gohelper.setActive(self._gofilterunselect, not isFiltering)
end

function RougeCollectionLevelUpView:refreshRight()
	local selectCount = RougeCollectionLevelUpListModel.instance:getSelectCount()

	self._txtnum.text = string.format("（<#C69620>%s</color>/%s）", selectCount, self.maxLevelUpNum)

	local isEmpty = selectCount < 1

	gohelper.setActive(self._gorightempty, isEmpty)

	local collectionMoList = RougeCollectionLevelUpListModel.instance:getSelectMoList()

	RougeMapHelper.loadItem(self.rightItem, RougeCollectionLevelUpRightItem, collectionMoList, self.rightCollectionItemList)
end

function RougeCollectionLevelUpView:onClickRightItem(index, mo)
	RougeCollectionLevelUpListModel.instance:deselectMo(mo)
end

function RougeCollectionLevelUpView:refreshBtn()
	local selectCount = RougeCollectionLevelUpListModel.instance:getSelectCount()

	gohelper.setActive(self._btnconfirm.gameObject, selectCount > 0 and selectCount <= self.maxLevelUpNum)
end

function RougeCollectionLevelUpView:onSelectLossCollectionChange()
	self:refreshLeft()
	self:refreshRight()
	self:refreshBtn()
end

function RougeCollectionLevelUpView:onClose()
	self.collectionComp:onClose()
	RougeCollectionLevelUpListModel.instance:clear()

	if self.callbackId then
		RougeRpc.instance:removeCallbackById(self.callbackId)
	end
end

function RougeCollectionLevelUpView:onDestroyView()
	self.collectionComp:destroy()
	RougeMapHelper.destroyItemList(self.leftCollectionItemList)
	RougeMapHelper.destroyItemList(self.rightCollectionItemList)
	self._simagefullbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	self._simagetopbg1:UnLoadImage()
	self._simagetopbg2:UnLoadImage()
end

return RougeCollectionLevelUpView
