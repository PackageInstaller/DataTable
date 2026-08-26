-- chunkname: @modules/logic/rouge/map/view/collectionabandon/RougeMapCollectionAbandonView.lua

module("modules.logic.rouge.map.view.collectionabandon.RougeMapCollectionAbandonView", package.seeall)

local RougeMapCollectionAbandonView = class("RougeMapCollectionAbandonView", BaseView)

function RougeMapCollectionAbandonView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_fullbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_rightbg")
	self._simagetopbg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_topbg1")
	self._simagetopbg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_topbg2")
	self._txttitle = gohelper.findChildText(self.viewGO, "Title/txt_Title")
	self._txtdec = gohelper.findChildText(self.viewGO, "Title/#txt_dec")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_filter")
	self._gofilterselect = gohelper.findChild(self.viewGO, "Left/#btn_filter/#go_select")
	self._gofilterunselect = gohelper.findChild(self.viewGO, "Left/#btn_filter/#go_unselect")
	self._txtnum = gohelper.findChildText(self.viewGO, "Right/#txt_num")
	self._gorightempty = gohelper.findChild(self.viewGO, "Right/#go_rightempty")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._goCollectionContainer = gohelper.findChild(self.viewGO, "#go_collectioncontainer")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapCollectionAbandonView:addEvents()
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function RougeMapCollectionAbandonView:removeEvents()
	self._btnfilter:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
end

function RougeMapCollectionAbandonView:_btnfilterOnClick()
	self.param = self.param or {
		confirmCallback = self.onConfirmCallback,
		confirmCallbackObj = self,
		baseSelectMap = self.baseFilterTagDict,
		extraSelectMap = self.extraFilterTagDict
	}

	RougeController.instance:openRougeCollectionFilterView(self.param)
end

function RougeMapCollectionAbandonView:onConfirmCallback(baseSelectMap, extraSelectMap)
	RougeCollectionHelper.removeInValidItem(baseSelectMap)
	RougeCollectionHelper.removeInValidItem(extraSelectMap)
	RougeLossCollectionListModel.instance:filterCollection()
	self:refreshLeft()
end

function RougeMapCollectionAbandonView:_btnconfirmOnClick()
	if RougeLossCollectionListModel.instance:getSelectCount() < self.lossCount then
		return
	end

	self.callbackId = RougeRpc.instance:sendRougeSelectLostCollectionRequest(RougeLossCollectionListModel.instance:getSelectMoList(), self.onReceiveMsg, self)
end

function RougeMapCollectionAbandonView:onReceiveMsg()
	self.callbackId = nil

	self:closeThis()
end

function RougeMapCollectionAbandonView:_editableInitView()
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
	NavigateMgr.instance:addEscape(self.viewName, RougeMapHelper.blockEsc)
end

function RougeMapCollectionAbandonView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.LossCollectionViewOpen)
	self.collectionComp:onOpen()

	self.lossType = self.viewParam.lossType
	self.lossCount = self.viewParam.lostNum
	self.filterUnique = self.viewParam.filterUnique
	self.collections = self.viewParam.collections or RougeCollectionModel.instance:getAllCollections()

	RougeLossCollectionListModel.instance:setLossType(self.lossType)
	RougeLossCollectionListModel.instance:initList(self.lossCount, self.collections, self.baseFilterTagDict, self.extraFilterTagDict, self.filterUnique)
	self:refreshTitle()
	self:refreshLeft()
	self:refreshRight()
	self:refreshBtn()
end

function RougeMapCollectionAbandonView:refreshTitle()
	if self.lossType == RougeMapEnum.LossType.Copy then
		self._txttitle.text = luaLang("p_rougecollectionabandonview_txt_copy")
		self._txtdec.text = luaLang("p_rougecollectionabandonview_txt_copy1")
	elseif self.lossType == RougeMapEnum.LossType.AbandonSp then
		self._txttitle.text = luaLang("p_rougecollectionabandonview_txt_losssp")
		self._txtdec.text = luaLang("p_rougecollectionabandonview_txt_losssp1")
	else
		self._txttitle.text = luaLang("p_rougecollectionabandonview_txt_dec1")
		self._txtdec.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge_loss_title"), self.lossCount)
	end
end

function RougeMapCollectionAbandonView:refreshLeft()
	RougeLossCollectionListModel.instance:refresh()
	self:refreshFilterBtn()
end

function RougeMapCollectionAbandonView:refreshFilterBtn()
	local isFiltering = RougeLossCollectionListModel.instance:isFiltering()

	gohelper.setActive(self._gofilterselect, isFiltering)
	gohelper.setActive(self._gofilterunselect, not isFiltering)
end

function RougeMapCollectionAbandonView:refreshRight()
	local selectCount = RougeLossCollectionListModel.instance:getSelectCount()

	self._txtnum.text = string.format("（<#C69620>%s</color>/%s）", selectCount, self.lossCount)

	local isEmpty = selectCount < 1

	gohelper.setActive(self._gorightempty, isEmpty)

	local collectionMoList = RougeLossCollectionListModel.instance:getSelectMoList()

	RougeMapHelper.loadItem(self.rightItem, RougeMapCollectionLossRightItem, collectionMoList, self.rightCollectionItemList)
end

function RougeMapCollectionAbandonView:onClickRightItem(index, mo)
	RougeLossCollectionListModel.instance:deselectMo(mo)
end

function RougeMapCollectionAbandonView:refreshBtn()
	gohelper.setActive(self._btnconfirm.gameObject, RougeLossCollectionListModel.instance:getSelectCount() >= self.lossCount)
end

function RougeMapCollectionAbandonView:onSelectLossCollectionChange()
	self:refreshLeft()
	self:refreshRight()
	self:refreshBtn()
end

function RougeMapCollectionAbandonView:onClose()
	self.collectionComp:onClose()
	RougeLossCollectionListModel.instance:clear()

	if self.callbackId then
		RougeRpc.instance:removeCallbackById(self.callbackId)
	end
end

function RougeMapCollectionAbandonView:onDestroyView()
	self.collectionComp:destroy()
	RougeMapHelper.destroyItemList(self.leftCollectionItemList)
	RougeMapHelper.destroyItemList(self.rightCollectionItemList)
	self._simagefullbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	self._simagetopbg1:UnLoadImage()
	self._simagetopbg2:UnLoadImage()
end

return RougeMapCollectionAbandonView
