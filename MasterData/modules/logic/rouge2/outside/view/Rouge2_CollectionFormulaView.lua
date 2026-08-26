-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CollectionFormulaView.lua

module("modules.logic.rouge2.outside.view.Rouge2_CollectionFormulaView", package.seeall)

local Rouge2_CollectionFormulaView = class("Rouge2_CollectionFormulaView", BaseView)

function Rouge2_CollectionFormulaView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_fullbg")
	self._scrollcollection = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_collection")
	self._gocontent = gohelper.findChild(self.viewGO, "Left/#scroll_collection/Viewport/#go_content")
	self._gotitle = gohelper.findChild(self.viewGO, "Left/#scroll_collection/#go_title")
	self._imageicon = gohelper.findChildImage(self.viewGO, "Left/#scroll_collection/#go_title/#image_icon")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Left/#scroll_collection/#go_title/#txt_Title")
	self._gosmalltitle = gohelper.findChild(self.viewGO, "Left/#go_smalltitle")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "Left/filter/#btn_filter")
	self._golayout = gohelper.findChild(self.viewGO, "Left/filter/#go_layout")
	self._gonormal = gohelper.findChild(self.viewGO, "Right/#go_normal")
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "Right/#go_normal/#image_icon1")
	self._txtcollectionname1 = gohelper.findChildText(self.viewGO, "Right/#go_normal/#txt_collectionname1")
	self._scrollcollectiondesc = gohelper.findChildScrollRect(self.viewGO, "Right/#go_normal/#scroll_collectiondesc")
	self._godescContent = gohelper.findChild(self.viewGO, "Right/#go_normal/#scroll_collectiondesc/Viewport/#go_descContent")
	self._btnblock = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_normal/#btn_block")
	self._golocked = gohelper.findChild(self.viewGO, "Right/#go_locked")
	self._txtlocked = gohelper.findChildText(self.viewGO, "Right/#go_locked/locked/#txt_locked")
	self._gounget = gohelper.findChild(self.viewGO, "Right/#go_unget")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "Right/#go_unget/#simage_icon2")
	self._gobasetags2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_basetags2")
	self._gobasetagitem2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_basetags2/#go_basetagitem2")
	self._goextratags2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_extratags2")
	self._goextratagitem2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_extratags2/#go_extratagitem2")
	self._gotips2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_tips2")
	self._txttagitem2 = gohelper.findChildText(self.viewGO, "Right/#go_unget/tags/#go_tips2/#txt_tagitem2")
	self._goshapecell2 = gohelper.findChild(self.viewGO, "Right/#go_unget/shape/#go_shapecell2")
	self._txtcollectionname2 = gohelper.findChildText(self.viewGO, "Right/#go_unget/#txt_collectionname2")
	self._btnshow = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_show")
	self._scrollneed = gohelper.findChildScrollRect(self.viewGO, "Right/need/#scroll_need")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "Right/need/#scroll_need/Viewport/Content/#go_collectionitem")
	self._goitemdescmodeswitcher = gohelper.findChild(self.viewGO, "Right/#go_itemdescmodeswitcher")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CollectionFormulaView:addEvents()
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btnblock:AddClickListener(self._btnblockOnClick, self)
	self._btnshow:AddClickListener(self._btnshowOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectCollectionFormulaItem, self._onSelectFormulaItem, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
end

function Rouge2_CollectionFormulaView:removeEvents()
	self._btnfilter:RemoveClickListener()
	self._btnblock:RemoveClickListener()
	self._btnshow:RemoveClickListener()
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectCollectionFormulaItem, self._onSelectFormulaItem, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
end

function Rouge2_CollectionFormulaView:_btnblockOnClick()
	return
end

function Rouge2_CollectionFormulaView:_btnshowOnClick()
	return
end

function Rouge2_CollectionFormulaView:_btnfilterOnClick()
	local params = {
		confirmCallback = self.onConfirmTagFilterCallback,
		confirmCallbackObj = self,
		baseSelectMap = self._baseTagSelectMap,
		extraSelectMap = self._extraTagSelectMap
	}

	Rouge2_OutsideController.instance:openRougeCollectionFilterView(params)
end

function Rouge2_CollectionFormulaView:onConfirmTagFilterCallback(baseTagMap, extraTagMap)
	self:filterCompositeList(baseTagMap, extraTagMap)
	self:refreshFilterButtonUI()
end

function Rouge2_CollectionFormulaView:_editableInitView()
	self._compositeItemTab = self:getUserDataTb_()
	self._collectionCellTab = self:getUserDataTb_()
	self._baseTagSelectMap = {}
	self._extraTagSelectMap = {}
	self._aniamtor = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._goright = gohelper.findChild(self.viewGO, "Right")
	self._goneed = gohelper.findChild(self.viewGO, "Right/need")
	self._rightAnimator = gohelper.onceAddComponent(self._goright, gohelper.Type_Animator)

	gohelper.setActive(self._gocollectionitem, false)
	gohelper.setActive(self._btnshow, false)

	self._txtFormulaDesc = gohelper.findChildTextMesh(self._godescContent, "txt_desc")
end

function Rouge2_CollectionFormulaView:onUpdateParam(param)
	return
end

function Rouge2_CollectionFormulaView:onOpen()
	if self.viewParam then
		Rouge2_CollectionFormulaListModel.instance:onInit(nil, nil, self.viewParam)
		self:refreshSelectCollectionInfo()
		self._aniamtor:Play("open", 0, 0)
	end
end

function Rouge2_CollectionFormulaView:refreshSelectCollectionInfo()
	local selectId = Rouge2_CollectionFormulaListModel.instance:getCurSelectCellId()
	local formulaMo = Rouge2_CollectionFormulaListModel.instance:getById(selectId)

	gohelper.setActive(self._goright, formulaMo ~= nil)
	gohelper.setActive(self._goempty, formulaMo == nil)

	if not formulaMo then
		return
	end

	local formulaId = formulaMo.itemId
	local formulaConfig = Rouge2_OutSideConfig.instance:getFormulaConfig(formulaId)

	if not formulaConfig then
		return
	end

	self._formulaConfig = formulaConfig
	self._formulaId = formulaId

	local isUnlock = Rouge2_AlchemyModel.instance:isFormulaUnlock(formulaId)

	gohelper.setActive(self._golocked, not isUnlock)
	gohelper.setActive(self._gonormal, isUnlock)
	gohelper.setActive(self._goneed, isUnlock)

	if not isUnlock then
		self:refreshUnlockInfo()

		return
	end

	Rouge2_IconHelper.setFormulaIcon(formulaId, self._simageicon1)

	self._txtcollectionname1.text = formulaConfig.name

	self:refrehsCollectionDesc()
	self:refreshNeedItem()
end

function Rouge2_CollectionFormulaView:refreshUnlockInfo()
	self._txtlocked.text = Rouge2_MapUnlockHelper.getLockTips(self._formulaConfig.condition)
end

function Rouge2_CollectionFormulaView:refreshNeedItem()
	local formulaConfig = self._formulaConfig

	Rouge2_CollectionFormulaNeedListModel.instance:initData(formulaConfig.mainIdNum)
end

function Rouge2_CollectionFormulaView:refrehsCollectionDesc()
	local formulaConfig = self._formulaConfig

	Rouge2_ItemDescHelper.buildAndSetDesc(self._txtFormulaDesc, formulaConfig.details, Rouge2_OutsideEnum.DescPercentColor, Rouge2_OutsideEnum.DescBracketColor)

	self._txtFormulaDesc.text = Rouge2_ItemDescHelper.replaceColor(self._txtFormulaDesc.text, Rouge2_OutsideEnum.DescReplaceColor, Rouge2_OutsideEnum.DescPercentColor)
end

function Rouge2_CollectionFormulaView:refreshCollectionTagIcon(tagObj, tagId, index)
	local tagicon = gohelper.findChildImage(tagObj, "image_tagicon")
	local frameImg = gohelper.findChildImage(tagObj, "image_tagframe")
	local tagCo = lua_rouge_tag.configDict[tagId]

	UISpriteSetMgr.instance:setRougeSprite(tagicon, tagCo.iconUrl)
	UISpriteSetMgr.instance:setRougeSprite(frameImg, "rouge_collection_tagframe_1")
end

function Rouge2_CollectionFormulaView:_onSelectFormulaItem(itemId)
	local readySelectId = Rouge2_CollectionFormulaListModel.instance:getCellIndexByItemId(itemId)
	local curSelectCellId = Rouge2_CollectionFormulaListModel.instance:getCurSelectCellId()

	if readySelectId == curSelectCellId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_choose_4)

	local readySelectMO = Rouge2_CollectionFormulaListModel.instance:getById(readySelectId)

	if readySelectMO == nil then
		return
	end

	local readySelectIndex = Rouge2_CollectionFormulaListModel.instance:getIndex(readySelectMO)

	if readySelectIndex == nil then
		return
	end

	Rouge2_CollectionFormulaListModel.instance:selectCell(readySelectIndex, true)
	self:delay2SwitchHandBookItem(Rouge2_CollectionFormulaView.DelayTime2SwitchCollection)
	self._rightAnimator:Play("switch", 0, 0)
end

Rouge2_CollectionFormulaView.DelayTime2SwitchCollection = 0.167

function Rouge2_CollectionFormulaView:delay2SwitchHandBookItem(delayTime)
	delayTime = delayTime or 0

	TaskDispatcher.cancelTask(self.refreshSelectCollectionInfo, self)
	TaskDispatcher.runDelay(self.refreshSelectCollectionInfo, self, delayTime)
end

function Rouge2_CollectionFormulaView:filterCompositeList(baseTagMap, extraTagMap)
	local lastSelectCellId = Rouge2_CollectionFormulaListModel.instance:getCurSelectCellId()

	Rouge2_CollectionFormulaListModel.instance:updateFilterMap(baseTagMap, extraTagMap)

	local curSelectCellId = Rouge2_CollectionFormulaListModel.instance:getCurSelectCellId()

	if lastSelectCellId ~= curSelectCellId then
		self:refreshSelectCollectionInfo()
	end
end

function Rouge2_CollectionFormulaView:refreshFilterButtonUI()
	local isFiltering = RougeCollectionHandBookListModel.instance:isFiltering()

	self:_setFilterSelected(isFiltering)
end

function Rouge2_CollectionFormulaView:_setFilterSelected(isFiltering)
	local goUnselect = gohelper.findChild(self._btnfilter.gameObject, "unselect")
	local goSelect = gohelper.findChild(self._btnfilter.gameObject, "select")

	gohelper.setActive(goSelect, isFiltering)
	gohelper.setActive(goUnselect, not isFiltering)
end

function Rouge2_CollectionFormulaView:_onSwitchCollectionInfoType()
	self:refrehsCollectionDesc()
end

function Rouge2_CollectionFormulaView:onClose()
	return
end

function Rouge2_CollectionFormulaView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshSelectCollectionInfo, self)
end

return Rouge2_CollectionFormulaView
