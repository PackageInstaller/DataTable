-- chunkname: @modules/logic/rouge/map/view/collectionabandon/RougeMapCollectionExchangeView.lua

module("modules.logic.rouge.map.view.collectionabandon.RougeMapCollectionExchangeView", package.seeall)

local RougeMapCollectionExchangeView = class("RougeMapCollectionExchangeView", BaseView)

function RougeMapCollectionExchangeView:onInitView()
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

function RougeMapCollectionExchangeView:addEvents()
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function RougeMapCollectionExchangeView:removeEvents()
	self._btnfilter:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
end

function RougeMapCollectionExchangeView:_btnfilterOnClick()
	self.param = self.param or {
		confirmCallback = self.onConfirmCallback,
		confirmCallbackObj = self,
		baseSelectMap = self.baseFilterTagDict,
		extraSelectMap = self.extraFilterTagDict
	}

	RougeController.instance:openRougeCollectionFilterView(self.param)
end

function RougeMapCollectionExchangeView:onConfirmCallback(baseSelectMap, extraSelectMap)
	RougeCollectionHelper.removeInValidItem(baseSelectMap)
	RougeCollectionHelper.removeInValidItem(extraSelectMap)
	RougeLossCollectionListModel.instance:filterCollection()
	self:refreshLeft()
end

function RougeMapCollectionExchangeView:_btnconfirmOnClick()
	if RougeLossCollectionListModel.instance:getSelectCount() < self.lossCount then
		return
	end

	local mo = RougeLossCollectionListModel.instance:getSelectMoList()[1]

	self.callbackId = RougeRpc.instance:sendRougeDisplaceRequest(mo.uid, self.onReceiveMsg, self)
end

function RougeMapCollectionExchangeView:onReceiveMsg(cmd, resultCode, msg)
	self.callbackId = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onRefreshPieceChoiceEvent)
	self:closeThis()
end

function RougeMapCollectionExchangeView:_editableInitView()
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
	self.rightItem = self.viewContainer:getResInst(RougeMapEnum.CollectionRightItemRes, self.goRightItemContainer)

	gohelper.setActive(self.rightItem, false)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onSelectLossCollectionChange, self.onSelectLossCollectionChange, self)
end

function RougeMapCollectionExchangeView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.LossCollectionViewOpen)
	self.collectionComp:onOpen()

	self.lossCount = 1
	self.collections = self.viewParam and self.viewParam.collections
	self.collections = self.collections or RougeCollectionModel.instance:getAllCollections()

	RougeLossCollectionListModel.instance:setLossType(RougeMapEnum.LossType.Exchange)
	RougeLossCollectionListModel.instance:initList(self.lossCount, self.collections, self.baseFilterTagDict, self.extraFilterTagDict)
	self:refreshTitle()
	self:refreshLeft()
	self:refreshRight()
	self:refreshBtn()
end

function RougeMapCollectionExchangeView:refreshTitle()
	self._txtdec.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge_exchange_title"), self.lossCount)
end

function RougeMapCollectionExchangeView:refreshLeft()
	RougeLossCollectionListModel.instance:refresh()
	self:refreshFilterBtn()
end

function RougeMapCollectionExchangeView:refreshFilterBtn()
	local isFiltering = RougeLossCollectionListModel.instance:isFiltering()

	gohelper.setActive(self._gofilterselect, isFiltering)
	gohelper.setActive(self._gofilterunselect, not isFiltering)
end

function RougeMapCollectionExchangeView:refreshRight()
	local selectCount = RougeLossCollectionListModel.instance:getSelectCount()

	self._txtnum.text = string.format("（<#C69620>%s</color>/%s）", selectCount, self.lossCount)

	local isEmpty = selectCount < 1

	gohelper.setActive(self._gorightempty, isEmpty)

	local collectionMoList = RougeLossCollectionListModel.instance:getSelectMoList()

	RougeMapHelper.loadItem(self.rightItem, RougeMapCollectionLossRightItem, collectionMoList, self.rightCollectionItemList)
end

function RougeMapCollectionExchangeView:onClickRightItem(index, mo)
	RougeLossCollectionListModel.instance:deselectMo(mo)
end

function RougeMapCollectionExchangeView:refreshBtn()
	gohelper.setActive(self._btnconfirm.gameObject, RougeLossCollectionListModel.instance:getSelectCount() >= self.lossCount)
end

function RougeMapCollectionExchangeView:onSelectLossCollectionChange()
	self:refreshLeft()
	self:refreshRight()
	self:refreshBtn()
end

function RougeMapCollectionExchangeView:onClose()
	self.collectionComp:onClose()
	RougeLossCollectionListModel.instance:clear()

	if self.callbackId then
		RougeRpc.instance:removeCallbackById(self.callbackId)
	end
end

function RougeMapCollectionExchangeView:onDestroyView()
	self.collectionComp:destroy()
	RougeMapHelper.destroyItemList(self.leftCollectionItemList)
	RougeMapHelper.destroyItemList(self.rightCollectionItemList)
	self._simagefullbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	self._simagetopbg1:UnLoadImage()
	self._simagetopbg2:UnLoadImage()
end

return RougeMapCollectionExchangeView
