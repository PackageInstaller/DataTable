-- chunkname: @modules/logic/rouge/view/RougeCollectionListView.lua

module("modules.logic.rouge.view.RougeCollectionListView", package.seeall)

local RougeCollectionListView = class("RougeCollectionListView", BaseView)

function RougeCollectionListView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_fullbg")
	self._scrollcollection = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_collection")
	self._gocontent = gohelper.findChild(self.viewGO, "Left/#scroll_collection/Viewport/#go_content")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_filter")
	self._golayout = gohelper.findChild(self.viewGO, "Left/#go_layout")
	self._gosmalltitle = gohelper.findChild(self.viewGO, "Left/#go_smalltitle")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Left/#go_smalltitle/#txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "Left/#go_smalltitle/#txt_Title/#txt_TitleEn")
	self._imageicon = gohelper.findChildImage(self.viewGO, "Left/#go_smalltitle/#image_icon")
	self._gonormal = gohelper.findChild(self.viewGO, "Right/#go_normal")
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "Right/#go_normal/#simage_icon1")
	self._txtcollectionname1 = gohelper.findChildText(self.viewGO, "Right/#go_normal/#txt_collectionname1")
	self._gobasetags1 = gohelper.findChild(self.viewGO, "Right/#go_normal/tags/#go_basetags1")
	self._gobasetagitem1 = gohelper.findChild(self.viewGO, "Right/#go_normal/tags/#go_basetags1/#go_basetagitem1")
	self._goextratags1 = gohelper.findChild(self.viewGO, "Right/#go_normal/tags/#go_extratags1")
	self._goextratagitem1 = gohelper.findChild(self.viewGO, "Right/#go_normal/tags/#go_extratags1/#go_extratagitem1")
	self._goshapecell1 = gohelper.findChild(self.viewGO, "Right/#go_normal/shape/#go_shapecell1")
	self._scrollcollectiondesc = gohelper.findChildScrollRect(self.viewGO, "Right/#go_normal/#scroll_collectiondesc")
	self._godescContent = gohelper.findChild(self.viewGO, "Right/#go_normal/#scroll_collectiondesc/Viewport/#go_descContent")
	self._godescitem = gohelper.findChild(self.viewGO, "Right/#go_normal/#scroll_collectiondesc/Viewport/#go_descContent/#go_descitem")
	self._golocked = gohelper.findChild(self.viewGO, "Right/#go_locked")
	self._txtlocked = gohelper.findChildText(self.viewGO, "Right/#go_locked/locked/#txt_locked")
	self._txtlockedName = gohelper.findChildText(self.viewGO, "Right/#go_locked/txt_locked")
	self._gounget = gohelper.findChild(self.viewGO, "Right/#go_unget")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "Right/#go_unget/#simage_icon2")
	self._txtcollectionname2 = gohelper.findChildText(self.viewGO, "Right/#go_unget/#txt_collectionname2")
	self._gobasetags2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_basetags2")
	self._gobasetagitem2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_basetags2/#go_basetagitem2")
	self._goextratags2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_extratags2")
	self._goextratagitem2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_extratags2/#go_extratagitem2")
	self._goshapecell2 = gohelper.findChild(self.viewGO, "Right/#go_unget/shape/#go_shapecell2")
	self._gotips1 = gohelper.findChild(self.viewGO, "Right/#go_normal/tags/#go_tips1")
	self._txttagitem1 = gohelper.findChildText(self.viewGO, "Right/#go_normal/tags/#go_tips1/#txt_tagitem1")
	self._gotips2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_tips2")
	self._txttagitem2 = gohelper.findChildText(self.viewGO, "Right/#go_unget/tags/#go_tips2/#txt_tagitem2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionListView:addEvents()
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
end

function RougeCollectionListView:removeEvents()
	self._btnfilter:RemoveClickListener()
end

function RougeCollectionListView:_btnfilterOnClick()
	local params = {
		confirmCallback = self.onConfirmTagFilterCallback,
		confirmCallbackObj = self,
		baseSelectMap = self._baseTagSelectMap,
		extraSelectMap = self._extraTagSelectMap
	}

	RougeController.instance:openRougeCollectionFilterView(params)
end

function RougeCollectionListView:onConfirmTagFilterCallback(baseTagMap, extraTagMap)
	self:filterCompositeList(baseTagMap, extraTagMap)
	self:refreshFilterButtonUI()
end

function RougeCollectionListView:filterCompositeList(baseTagMap, extraTagMap)
	RougeCollectionListModel.instance:onInitData(baseTagMap, extraTagMap, self._selectIndex)
end

function RougeCollectionListView:refreshFilterButtonUI()
	local isFiltering = RougeCollectionListModel.instance:isFiltering()

	self:_setFilterSelected(isFiltering)
end

function RougeCollectionListView:_btnlistOnClick()
	return
end

function RougeCollectionListView:_btnhandbookOnClick()
	return
end

function RougeCollectionListView:_editableInitView()
	gohelper.setActive(self._txtTitleEn, false)

	self._gonormalcancomposit = gohelper.findChild(self.viewGO, "Right/#go_normal/go_cancomposit")
	self._goungetcancomposit = gohelper.findChild(self.viewGO, "Right/#go_unget/go_cancomposit")
	self._goUnselectLayout = gohelper.findChild(self._golayout.gameObject, "unselected")
	self._goSelectLayout = gohelper.findChild(self._golayout.gameObject, "selected")
	self._goUnselectFilter = gohelper.findChild(self._btnfilter.gameObject, "unselect")
	self._goSelectFilter = gohelper.findChild(self._btnfilter.gameObject, "select")
	self._goshapecell1Icon = gohelper.findChild(self._goshapecell1, "icon")
	self._goshapecell2Icon = gohelper.findChild(self._goshapecell2, "icon")
	self._cellModelTab = self:getUserDataTb_()
	self._baseTagSelectMap = {}
	self._extraTagSelectMap = {}

	self:_setFilterSelected(false)
	self:_setAllSelected(true)

	self._enchantList = {}
	self._itemInstTab = self:getUserDataTb_()
	self._gocontenttransform = self._gocontent.transform

	self._scrollcollection:AddOnValueChanged(self._onScrollChange, self)

	self._dropherogroup = gohelper.findChildDropdown(self.viewGO, "Left/#go_layout")

	self._dropherogroup:AddOnValueChanged(self._onDropValueChanged, self)

	self._dropherogrouparrow = gohelper.findChild(self.viewGO, "Left/#go_layout/selected/Label/go_arrow").transform
	self._dropgroupchildcount = self._goSelectLayout.transform.childCount
	self._selectIndex = 1

	local list = {
		luaLang("p_all"),
		luaLang("p_handbookequipviewfilterview_haveget"),
		luaLang("p_handbookequipviewfilterview_notget")
	}

	self._dropherogroup:ClearOptions()
	self._dropherogroup:AddOptions(list)
	self._dropherogroup:SetValue(self._selectIndex - 1)
	TaskDispatcher.runRepeat(self._checkDropArrow, self, 0)

	local goRight = gohelper.findChild(self.viewGO, "Right")

	self._rightAnimator = gohelper.onceAddComponent(goRight, gohelper.Type_Animator)
	self._aniamtor = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._baseTagSelectMap = {}
	self._extraTagSelectMap = {}

	RougeCollectionListModel.instance:onInitData(self._baseTagSelectMap, self._extraTagSelectMap, self._selectIndex, true)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnClickCollectionListItem, self._onClickCollectionListItem, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
	self:_refreshSelectCollectionInfo()
end

function RougeCollectionListView:_onDropValueChanged(value)
	self._selectIndex = value + 1

	RougeCollectionListModel.instance:onInitData(self._baseTagSelectMap, self._extraTagSelectMap, self._selectIndex)
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio7)
end

function RougeCollectionListView:_checkDropArrow()
	local childCount = self._goSelectLayout.transform.childCount

	if childCount ~= self._dropDownChildCount then
		self._dropDownChildCount = childCount

		local isOpen = self._dropgroupchildcount ~= childCount

		transformhelper.setLocalScale(self._dropherogrouparrow, 1, isOpen and -1 or 1, 1)
	end
end

function RougeCollectionListView:_onScrollChange()
	local y = recthelper.getAnchorY(self._gocontenttransform)
	local model = RougeCollectionListModel.instance
	local typeMap = model:getTypeHeightMap()
	local typeList = model:getTypeList()
	local curType

	for i, v in ipairs(typeList) do
		local type = v.type
		local height = (typeMap[type] or 0) + 48

		if height < y then
			curType = type
		else
			break
		end
	end

	if not curType then
		if typeList[1] then
			do
				local firstType = typeList[1].type

				curType = model:getFirstType() or firstType
			end

			local showTitle = curType ~= nil and #RougeCollectionListModel.instance:getList() > 0

			gohelper.setActive(self._gosmalltitle, showTitle)

			if showTitle then
				local tagConfig = RougeCollectionConfig.instance:getTagConfig(curType)

				if not tagConfig then
					return
				end

				self._txtTitle.text = tagConfig.name

				UISpriteSetMgr.instance:setRougeSprite(self._imageicon, tagConfig.iconUrl)
			end
		end
	end
end

function RougeCollectionListView:_setFilterSelected(value)
	self._isFilterSelected = value

	gohelper.setActive(self._goSelectFilter, value)
	gohelper.setActive(self._goUnselectFilter, not value)
end

function RougeCollectionListView:_setAllSelected(value)
	self._isAllSelected = value

	gohelper.setActive(self._goSelectLayout, value)
	gohelper.setActive(self._goUnselectLayout, not value)
end

function RougeCollectionListView:_onClickCollectionListItem()
	self._rightAnimator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self._refreshSelectCollectionInfo, self)
	TaskDispatcher.runDelay(self._refreshSelectCollectionInfo, self, RougeEnum.CollectionListViewDelayTime)
end

function RougeCollectionListView:_refreshSelectCollectionInfo()
	local selectedConfig = RougeCollectionListModel.instance:getSelectedConfig()

	if not selectedConfig then
		return
	end

	local productId = selectedConfig.id
	local productCfg = RougeCollectionConfig.instance:getCollectionCfg(productId)

	if not productCfg then
		return
	end

	local isUnlock = RougeFavoriteModel.instance:collectionIsUnlock(productCfg.id)
	local isPass = RougeOutsideModel.instance:collectionIsPass(productCfg.id)
	local showNormal = isUnlock and isPass
	local showLocked = not isUnlock
	local showUnget = isUnlock and not isPass

	gohelper.setActive(self._gonormal, showNormal)
	gohelper.setActive(self._golocked, showLocked)
	gohelper.setActive(self._gounget, showUnget)

	local dropDownView = self.viewContainer:getDropDownView()
	local holeList = dropDownView:getHoleMoList()

	tabletool.clear(self._enchantList)

	for k, v in pairs(holeList) do
		table.insert(self._enchantList, v.id)
	end

	if showNormal then
		gohelper.setActive(self._gonormalcancomposit, RougeCollectionConfig.instance:canSynthesized(productCfg.id))

		self._txtcollectionname1.text = RougeCollectionConfig.instance:getCollectionName(productId, self._enchantList)

		self._simageicon1:LoadImage(RougeCollectionHelper.getCollectionIconUrl(productId))
		RougeCollectionHelper.loadCollectionAndEnchantTags(productId, self._enchantList, self._gobasetags1, self._gobasetagitem1)
		RougeCollectionHelper.loadCollectionAndEnchantTagNames(productId, self._enchantList, self._gotips1, self._txttagitem1.gameObject, RougeCollectionHelper._loadCollectionTagNameCallBack)
	end

	if showLocked then
		self._txtlockedName.text = luaLang("p_rougecollectionchessview_txt_locked")

		local unLockConfig = lua_rouge_collection_unlock.configDict[productId]

		if unLockConfig then
			self._txtlocked.text = RougeMapUnlockHelper.getLockTips(unLockConfig.unlockType, unLockConfig.unlockParam)
		else
			logError("缺少造物解锁条件配置:" .. tostring(productId))
		end
	end

	if showUnget then
		gohelper.setActive(self._goungetcancomposit, RougeCollectionConfig.instance:canSynthesized(productCfg.id))

		self._txtcollectionname2.text = RougeCollectionConfig.instance:getCollectionName(productId, self._enchantList)

		self._simageicon2:LoadImage(RougeCollectionHelper.getCollectionIconUrl(productId))
		RougeCollectionHelper.loadCollectionAndEnchantTags(productId, self._enchantList, self._gobasetags2, self._gobasetagitem2)
		RougeCollectionHelper.loadCollectionAndEnchantTagNames(productId, self._enchantList, self._gotips2, self._txttagitem2.gameObject, RougeCollectionHelper._loadCollectionTagNameCallBack)
	end

	self._productId = productId

	RougeCollectionDescHelper.setCollectionDescInfos2(productId, self._enchantList, self._godescContent, self._itemInstTab)
	RougeCollectionHelper.loadShapeGrid(productId, self._goshapecell1, self._goshapecell1Icon, self._cellModelTab, false)
end

function RougeCollectionListView:_onSwitchCollectionInfoType()
	RougeCollectionDescHelper.setCollectionDescInfos2(self._productId, self._enchantList, self._godescContent, self._itemInstTab)
end

function RougeCollectionListView:onOpen()
	self._aniamtor:Play("open", 0, 0)
end

function RougeCollectionListView:onClose()
	return
end

function RougeCollectionListView:onDestroyView()
	self._scrollcollection:RemoveOnValueChanged()
	self._dropherogroup:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(self._checkDropArrow, self)
	TaskDispatcher.cancelTask(self._refreshSelectCollectionInfo, self)
end

return RougeCollectionListView
