-- chunkname: @modules/logic/rouge/view/RougeCollectionHandBookView.lua

module("modules.logic.rouge.view.RougeCollectionHandBookView", package.seeall)

local RougeCollectionHandBookView = class("RougeCollectionHandBookView", BaseView)

function RougeCollectionHandBookView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_fullbg")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_filter")
	self._scrollcollection = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_collection")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "Left/#scroll_collection/Viewport/Content/item/smalltitle/txt_Title/#txt_TitleEn")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "Left/#scroll_collection/Viewport/Content/#go_collectionitem")
	self._imagebg = gohelper.findChildImage(self.viewGO, "Left/#scroll_collection/Viewport/Content/item/#go_collectionitem/normal/#image_bg")
	self._txtnum = gohelper.findChildText(self.viewGO, "Left/#scroll_collection/Viewport/Content/item/#go_collectionitem/normal/#txt_num")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "Left/#scroll_collection/Viewport/Content/item/#go_collectionitem/normal/#simage_collection")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "Right/top/#simage_icon")
	self._txtcollectionname = gohelper.findChildText(self.viewGO, "Right/top/#txt_collectionname")
	self._gobasetags = gohelper.findChild(self.viewGO, "Right/top/tags/#go_basetags")
	self._gobasetagitem = gohelper.findChild(self.viewGO, "Right/top/tags/#go_basetags/#go_basetagitem")
	self._goextratags = gohelper.findChild(self.viewGO, "Right/top/tags/#go_extratags")
	self._goextratagitem = gohelper.findChild(self.viewGO, "Right/top/tags/#go_extratags/#go_extratagitem")
	self._goshapecell = gohelper.findChild(self.viewGO, "Right/top/layout/shape/#go_shapecell")
	self._scrollcollectiondesc = gohelper.findChildScrollRect(self.viewGO, "Right/top/#scroll_collectiondesc")
	self._godescContent = gohelper.findChild(self.viewGO, "Right/top/#scroll_collectiondesc/Viewport/#go_descContent")
	self._godescitem = gohelper.findChild(self.viewGO, "Right/top/#scroll_collectiondesc/Viewport/#go_descContent/#go_descitem")
	self._btnhandbook = gohelper.findChildButtonWithAudio(self.viewGO, "Bottom/#btn_handbook")
	self._goholecontainer = gohelper.findChild(self.viewGO, "Right/top/layout/#go_holecontainer")
	self._goholeitem = gohelper.findChild(self.viewGO, "Right/top/layout/#go_holecontainer/#go_holeitem")
	self._gocompositelayout = gohelper.findChild(self.viewGO, "Right/top/need/#go_compositelayout")
	self._gocompositeitem = gohelper.findChild(self.viewGO, "Right/top/need/#go_compositelayout/#go_compositeitem")
	self._gocancomposite = gohelper.findChild(self.viewGO, "Right/top/layout/#go_cancomposite")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionHandBookView:addEvents()
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
end

function RougeCollectionHandBookView:removeEvents()
	self._btnfilter:RemoveClickListener()
end

function RougeCollectionHandBookView:_btnfilterOnClick()
	local params = {
		confirmCallback = self.onConfirmTagFilterCallback,
		confirmCallbackObj = self,
		baseSelectMap = self._baseTagSelectMap,
		extraSelectMap = self._extraTagSelectMap
	}

	RougeController.instance:openRougeCollectionFilterView(params)
end

function RougeCollectionHandBookView:onConfirmTagFilterCallback(baseTagMap, extraTagMap)
	self:filterCompositeList(baseTagMap, extraTagMap)
	self:refreshFilterButtonUI()
end

function RougeCollectionHandBookView:_editableInitView()
	self.addEventCb(self, RougeController.instance, RougeEvent.OnSelectCollectionHandBookItem, self._onSelectHandBookItem, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)

	self._compositeItemTab = self:getUserDataTb_()
	self._collectionCellTab = self:getUserDataTb_()
	self._itemInstTab = self:getUserDataTb_()
	self._baseTagSelectMap = {}
	self._extraTagSelectMap = {}
	self._goshapecontainer = gohelper.findChild(self.viewGO, "Right/top/layout/shape")
	self._aniamtor = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._goright = gohelper.findChild(self.viewGO, "Right")
	self._rightAnimator = gohelper.onceAddComponent(self._goright, gohelper.Type_Animator)
end

function RougeCollectionHandBookView:onOpen()
	RougeCollectionHandBookListModel.instance:onInit()
	self:refreshSelectCollectionInfo()
	self._aniamtor:Play("open", 0, 0)
end

function RougeCollectionHandBookView:refreshSelectCollectionInfo()
	local synethesisId = RougeCollectionHandBookListModel.instance:getCurSelectCellId()
	local synthesisCfg = RougeCollectionHandBookListModel.instance:getById(synethesisId)

	gohelper.setActive(self._goright, synthesisCfg ~= nil)
	gohelper.setActive(self._goempty, synthesisCfg == nil)

	if not synthesisCfg then
		return
	end

	local productId = synthesisCfg.product
	local productCfg = RougeCollectionConfig.instance:getCollectionCfg(productId)

	if not productCfg then
		return
	end

	self._productId = productId

	self._simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(productId))

	self._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(productId)

	self:refrehsCollectionDesc()
	gohelper.CreateObjList(self, self.refreshCollectionTagIcon, productCfg.tags, self._gobasetags, self._gobasetagitem)
	gohelper.CreateNumObjList(self._goholecontainer, self._goholeitem, productCfg.holeNum)
	gohelper.setActive(self._goholecontainer, productCfg.holeNum > 0)

	local compositeIds = RougeCollectionConfig.instance:getCollectionCompositeIds(synethesisId) or {}

	gohelper.CreateObjList(self, self.refreshCompositeItem, compositeIds, self._gocompositelayout, self._gocompositeitem)
	RougeCollectionHelper.loadShapeGrid(productId, self._goshapecontainer, self._goshapecell, self._collectionCellTab, false)

	local canComposite = RougeCollectionModel.instance:checkIsCanCompositeCollection(synethesisId)

	gohelper.setActive(self._gocancomposite, canComposite)
end

function RougeCollectionHandBookView:refrehsCollectionDesc()
	RougeCollectionDescHelper.setCollectionDescInfos2(self._productId, nil, self._godescContent, self._itemInstTab)
end

function RougeCollectionHandBookView:refreshCollectionTagIcon(tagObj, tagId, index)
	local tagicon = gohelper.findChildImage(tagObj, "image_tagicon")
	local frameImg = gohelper.findChildImage(tagObj, "image_tagframe")
	local tagCo = lua_rouge_tag.configDict[tagId]

	UISpriteSetMgr.instance:setRougeSprite(tagicon, tagCo.iconUrl)
	UISpriteSetMgr.instance:setRougeSprite(frameImg, "rouge_collection_tagframe_1")
end

function RougeCollectionHandBookView:refreshCompositeItem(obj, compositeId, index)
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(compositeId)

	if not collectionCfg then
		return
	end

	local simageCollectionIcon = gohelper.findChildSingleImage(obj, "normal/#simage_collection")

	simageCollectionIcon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(compositeId))

	local txtNum = gohelper.findChildText(obj, "normal/#txt_num")

	txtNum.text = tostring(RougeEnum.CompositeCollectionCostCount)

	local imageBg = gohelper.findChildImage(obj, "normal/#image_bg")

	UISpriteSetMgr.instance:setRougeSprite(imageBg, "rouge_episode_collectionbg_" .. tostring(collectionCfg.showRare))

	self._compositeItemTab[index] = self._compositeItemTab[index] or self:getUserDataTb_()
	self._compositeItemTab[index].icon = simageCollectionIcon

	local click = gohelper.findChildButtonWithAudio(obj, "normal/#btn_click")

	click:RemoveClickListener()
	click:AddClickListener(self.clickCompositeItemCallBack, self, compositeId)

	self._compositeItemTab[index].btnClick = click
end

function RougeCollectionHandBookView:clickCompositeItemCallBack(compositeId)
	local params = {
		interactable = false,
		collectionCfgId = compositeId,
		viewPosition = RougeEnum.CollectionTipPos.HandBook
	}

	RougeController.instance:openRougeCollectionTipView(params)
end

function RougeCollectionHandBookView:releaseCompositeIconSingleImages()
	if self._compositeItemTab then
		for _, compositeItem in pairs(self._compositeItemTab) do
			if compositeItem and compositeItem.icon then
				compositeItem.icon:UnLoadImage()
			end

			if compositeItem and compositeItem.btnClick then
				compositeItem.btnClick:RemoveClickListener()
			end
		end
	end
end

function RougeCollectionHandBookView:_onSelectHandBookItem(readySelectId)
	local curSelectCellId = RougeCollectionHandBookListModel.instance:getCurSelectCellId()

	if readySelectId == curSelectCellId then
		return
	end

	local readySelectMO = RougeCollectionHandBookListModel.instance:getById(readySelectId)
	local readySelectIndex = RougeCollectionHandBookListModel.instance:getIndex(readySelectMO)

	RougeCollectionHandBookListModel.instance:selectCell(readySelectIndex, true)
	self:delay2SwitchHandBookItem(RougeCollectionHandBookView.DelayTime2SwitchCollection)
	self._rightAnimator:Play("switch", 0, 0)
end

RougeCollectionHandBookView.DelayTime2SwitchCollection = 0.3

function RougeCollectionHandBookView:delay2SwitchHandBookItem(delayTime)
	delayTime = delayTime or 0

	TaskDispatcher.cancelTask(self.refreshSelectCollectionInfo, self)
	TaskDispatcher.runDelay(self.refreshSelectCollectionInfo, self, delayTime)
end

function RougeCollectionHandBookView:filterCompositeList(baseTagMap, extraTagMap)
	local lastSelectCellId = RougeCollectionHandBookListModel.instance:getCurSelectCellId()

	RougeCollectionHandBookListModel.instance:updateFilterMap(baseTagMap, extraTagMap)

	local curSelectCellId = RougeCollectionHandBookListModel.instance:getCurSelectCellId()

	if lastSelectCellId ~= curSelectCellId then
		self:refreshSelectCollectionInfo()
	end
end

function RougeCollectionHandBookView:refreshFilterButtonUI()
	local isFiltering = RougeCollectionHandBookListModel.instance:isFiltering()

	self:_setFilterSelected(isFiltering)
end

function RougeCollectionHandBookView:_setFilterSelected(isFiltering)
	local goUnselect = gohelper.findChild(self._btnfilter.gameObject, "unselect")
	local goSelect = gohelper.findChild(self._btnfilter.gameObject, "select")

	gohelper.setActive(goSelect, isFiltering)
	gohelper.setActive(goUnselect, not isFiltering)
end

function RougeCollectionHandBookView:_onSwitchCollectionInfoType()
	self:refrehsCollectionDesc()
end

function RougeCollectionHandBookView:onClose()
	return
end

function RougeCollectionHandBookView:onDestroyView()
	self._simageicon:UnLoadImage()
	self:releaseCompositeIconSingleImages()
	TaskDispatcher.cancelTask(self.refreshSelectCollectionInfo, self)
end

return RougeCollectionHandBookView
