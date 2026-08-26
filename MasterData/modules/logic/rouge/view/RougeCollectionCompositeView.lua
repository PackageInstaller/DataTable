-- chunkname: @modules/logic/rouge/view/RougeCollectionCompositeView.lua

module("modules.logic.rouge.view.RougeCollectionCompositeView", package.seeall)

local RougeCollectionCompositeView = class("RougeCollectionCompositeView", BaseView)

function RougeCollectionCompositeView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._txtcollectionname = gohelper.findChildText(self.viewGO, "right/collection/#txt_collectionname")
	self._godescContent = gohelper.findChild(self.viewGO, "right/collection/#scroll_desc/Viewport/#go_descContent")
	self._godescitem = gohelper.findChild(self.viewGO, "right/collection/#scroll_desc/Viewport/#go_descContent/#go_descitem")
	self._goenchantlist = gohelper.findChild(self.viewGO, "right/collection/#go_enchantlist")
	self._gohole = gohelper.findChild(self.viewGO, "right/collection/#go_enchantlist/#go_hole")
	self._gocollectionicon = gohelper.findChild(self.viewGO, "right/collection/#go_collectionicon")
	self._gotags = gohelper.findChild(self.viewGO, "right/collection/#go_tags")
	self._gotagitem = gohelper.findChild(self.viewGO, "right/collection/#go_tags/#go_tagitem")
	self._goframe = gohelper.findChild(self.viewGO, "right/composite/#go_frame")
	self._goline = gohelper.findChild(self.viewGO, "right/composite/#go_frame/#go_line")
	self._gocompositecontainer = gohelper.findChild(self.viewGO, "right/composite/#go_frame/#go_compositecontainer")
	self._gocompositeitem = gohelper.findChild(self.viewGO, "right/composite/#go_frame/#go_compositecontainer/#go_compositeitem")
	self._btncomposite = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_composite")
	self._golist = gohelper.findChild(self.viewGO, "left/#go_list")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "left/#go_list/#btn_filter")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gocompositeeffect = gohelper.findChild(self.viewGO, "right/collection/#go_compositeeffect")
	self._gorougefunctionitem2 = gohelper.findChild(self.viewGO, "#go_rougefunctionitem2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionCompositeView:addEvents()
	self._btncomposite:AddClickListener(self._btncompositeOnClick, self)
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
end

function RougeCollectionCompositeView:removeEvents()
	self._btncomposite:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
end

function RougeCollectionCompositeView:_btncompositeOnClick()
	local composeId = RougeCollectionCompositeListModel.instance:getCurSelectCellId()
	local isCanComposite = RougeCollectionModel.instance:checkIsCanCompositeCollection(composeId)

	if not isCanComposite then
		GameFacade.showToast(ToastEnum.RougeCompositeFailed)

		return
	end

	self._consumeIds, self._placeSlotCollections = self:getNeedCostConsumeIds(composeId)

	if self._placeSlotCollections and #self._placeSlotCollections > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RougeCollectionCompositeConfirm, MsgBoxEnum.BoxType.Yes_No, self.confirm2CompositeCollection, self.cancel2CompositeCollection, nil, self, self)

		return
	end

	self:confirm2CompositeCollection()
end

function RougeCollectionCompositeView:confirm2CompositeCollection()
	self:playCompositeEffect()

	local composeId = RougeCollectionCompositeListModel.instance:getCurSelectCellId()
	local season = RougeModel.instance:getSeason()

	RougeRpc.instance:sendRougeComposeRequest(season, composeId, self._consumeIds)
end

function RougeCollectionCompositeView:cancel2CompositeCollection()
	return
end

function RougeCollectionCompositeView:_btnfilterOnClick()
	local params = {
		confirmCallback = self.onConfirmTagFilterCallback,
		confirmCallbackObj = self,
		baseSelectMap = self._baseTagSelectMap,
		extraSelectMap = self._extraTagSelectMap
	}

	RougeController.instance:openRougeCollectionFilterView(params)
end

function RougeCollectionCompositeView:onConfirmTagFilterCallback(baseTagMap, extraTagMap)
	self:filterCompositeList(baseTagMap, extraTagMap)
	self:refreshFilterButtonUI()
end

RougeCollectionCompositeView.CompositeEffectDuration = 1.2

function RougeCollectionCompositeView:playCompositeEffect()
	gohelper.setActive(self._gocompositeeffect, true)
	TaskDispatcher.cancelTask(self._hideCompositeEffect, self)
	TaskDispatcher.runDelay(self._hideCompositeEffect, self, RougeCollectionCompositeView.CompositeEffectDuration)
end

function RougeCollectionCompositeView:_hideCompositeEffect()
	gohelper.setActive(self._gocompositeeffect, false)
end

function RougeCollectionCompositeView:_editableInitView()
	self.addEventCb(self, RougeController.instance, RougeEvent.OnSelectCollectionCompositeItem, self._onSelectCompositeItem, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.CompositeCollectionSucc, self._compositeCollectionSucc, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)

	self._compositeItemTab = self:getUserDataTb_()
	self._baseTagSelectMap = {}
	self._extraTagSelectMap = {}
	self._itemInstTab = self:getUserDataTb_()
	self._descParams = {
		isAllActive = true
	}
	self.goCollection = self.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, self._gorougefunctionitem2)
	self.collectionComp = RougeCollectionComp.Get(self.goCollection)
end

function RougeCollectionCompositeView:onUpdateParam()
	return
end

function RougeCollectionCompositeView:onOpen()
	RougeCollectionCompositeListModel.instance:onInitData()
	RougeCollectionCompositeListModel.instance:selectFirstOrDefault()
	self:updateSelectCollectionInfo()
	self.collectionComp:onOpen()
end

function RougeCollectionCompositeView:updateSelectCollectionInfo()
	local curSelectCellId = RougeCollectionCompositeListModel.instance:getCurSelectCellId()
	local synthesisCfg = RougeCollectionCompositeListModel.instance:getById(curSelectCellId)

	if not synthesisCfg then
		return
	end

	local productId = synthesisCfg.product
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(productId)

	if not collectionCfg then
		return
	end

	self._productId = productId
	self._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(productId)

	self:refreshCollectionDesc()
	self:refreshSelectProductIcon(productId)

	local compositeIds = RougeCollectionConfig.instance:getCollectionCompositeIds(curSelectCellId)

	gohelper.setActive(self._goline, compositeIds and #compositeIds > 1)
	self:buildCollectionCountMap(compositeIds)
	gohelper.CreateObjList(self, self.refreshCompositeCollectionItem, compositeIds, self._gocompositecontainer, self._gocompositeitem)
	gohelper.CreateObjList(self, self.refreshCollectionBaseTag, collectionCfg.tags, self._gotags, self._gotagitem)
	gohelper.CreateNumObjList(self._goenchantlist, self._gohole, collectionCfg.holeNum)
end

function RougeCollectionCompositeView:refreshCollectionDesc()
	local showTypes = RougeCollectionDescHelper.getShowDescTypesWithoutText()

	RougeCollectionDescHelper.setCollectionDescInfos2(self._productId, nil, self._godescContent, self._itemInstTab, showTypes, self._descParams)
end

function RougeCollectionCompositeView:buildCollectionCountMap(compositeIds)
	self._collectionCountMap = {}

	if compositeIds then
		local compositeIdMap = {}

		for index, compositeId in ipairs(compositeIds) do
			local remainCollectionCount = compositeIdMap[compositeId]

			if not compositeIdMap[compositeId] then
				remainCollectionCount = RougeCollectionModel.instance:getCollectionCountById(compositeId)
				compositeIdMap[compositeId] = remainCollectionCount or 0
			end

			self._collectionCountMap[index] = remainCollectionCount > 0 and 1 or 0
			compositeIdMap[compositeId] = compositeIdMap[compositeId] - 1
		end
	end
end

local collectionIconWidth, collectionIconHeight = 160, 160

function RougeCollectionCompositeView:refreshSelectProductIcon(productId)
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(productId)

	if not collectionCfg then
		return
	end

	if not self._productIconItem then
		local setting = self.viewContainer:getSetting()
		local iconGO = self:getResInst(setting.otherRes[1], self._gocollectionicon, "productItemIcon")

		self._productIconItem = RougeCollectionIconItem.New(iconGO)

		self._productIconItem:setHolesVisible(false)
		self._productIconItem:setCollectionIconSize(collectionIconWidth, collectionIconHeight)
	end

	self._productIconItem:onUpdateMO(productId)
end

function RougeCollectionCompositeView:refreshCollectionBaseTag(tagObj, baseTagId, index)
	local tagicon = gohelper.findChildImage(tagObj, "image_tagicon")
	local frameImg = gohelper.findChildImage(tagObj, "image_tagframe")
	local tagCo = lua_rouge_tag.configDict[baseTagId]

	UISpriteSetMgr.instance:setRougeSprite(tagicon, tagCo.iconUrl)
	UISpriteSetMgr.instance:setRougeSprite(frameImg, "rouge_collection_tagframe_1")
end

local passConditionColor = "#A36431"
local unpassConditionColor = "#9A3C27"
local compositeIconWidth, compositeIconHeight = 160, 160

function RougeCollectionCompositeView:refreshCompositeCollectionItem(obj, compositeCfgId, index)
	compositeCfgId = tonumber(compositeCfgId)

	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(compositeCfgId)

	if not collectionCfg then
		logError("找不到合成基底造物配置, 合成基底造物id = " .. tostring(compositeCfgId))

		return
	end

	if not self._collectionCountMap[index] then
		local collectionCount = 0
		local isMuchThan = collectionCount > 0
		local txtNum = gohelper.findChildText(obj, "txt_num")

		if isMuchThan then
			if not passConditionColor then
				local txtColor = unpassConditionColor

				txtNum.text = string.format("<%s>%s</color>/%s", txtColor, collectionCount, RougeEnum.CompositeCollectionCostCount)
				self._compositeItemTab[index] = self._compositeItemTab[index] or self:getUserDataTb_()

				local collectionIcon = self._compositeItemTab[index].item

				if not collectionIcon then
					local setting = self.viewContainer:getSetting()
					local parentGO = gohelper.findChild(obj, "go_icon")
					local iconGO = self:getResInst(setting.otherRes[1], parentGO, "itemicon")

					collectionIcon = RougeCollectionIconItem.New(iconGO)

					collectionIcon:setHolesVisible(false)
					collectionIcon:setCollectionIconSize(compositeIconWidth, compositeIconHeight)

					self._compositeItemTab[index].item = collectionIcon
				end

				local btnclick = gohelper.findChildButtonWithAudio(obj, "btn_click")

				btnclick:RemoveClickListener()
				btnclick:AddClickListener(self.clickCompositeItem, self, compositeCfgId)

				self._compositeItemTab[index].btnclick = btnclick

				collectionIcon:onUpdateMO(compositeCfgId)
			end
		end
	end
end

function RougeCollectionCompositeView:clickCompositeItem(compositeCfgId)
	local params = {
		collectionCfgId = compositeCfgId,
		viewPosition = RougeEnum.CollectionTipPos.CompositeBaseCollection
	}

	RougeController.instance:openRougeCollectionTipView(params)
end

function RougeCollectionCompositeView:_onSelectCompositeItem(readySelectId)
	local curSelectCellId = RougeCollectionCompositeListModel.instance:getCurSelectCellId()

	if readySelectId == curSelectCellId then
		return
	end

	local readySelectMO = RougeCollectionCompositeListModel.instance:getById(readySelectId)
	local readySelectIndex = RougeCollectionCompositeListModel.instance:getIndex(readySelectMO)

	RougeCollectionCompositeListModel.instance:selectCell(readySelectIndex, true)
	self:updateSelectCollectionInfo()
	gohelper.setActive(self._gocompositeeffect, false)
	TaskDispatcher.cancelTask(self._hideCompositeEffect, self)
end

function RougeCollectionCompositeView:filterCompositeList(baseTagMap, extraTagMap)
	RougeCollectionCompositeListModel.instance:onInitData(baseTagMap, extraTagMap)

	local curSelectCellId = RougeCollectionCompositeListModel.instance:getCurSelectCellId()

	if not RougeCollectionCompositeListModel.instance:getById(curSelectCellId) then
		RougeCollectionCompositeListModel.instance:selectFirstOrDefault()
		self:updateSelectCollectionInfo()
	end
end

function RougeCollectionCompositeView:getNeedCostConsumeIds(composeId)
	local compositeIds = RougeCollectionConfig.instance:getCollectionCompositeIds(composeId)
	local needCostIds = {}
	local needCostIdMap = {}
	local placeInSlotIds = {}

	if compositeIds then
		for _, compositeId in ipairs(compositeIds) do
			self:selectNeedCostConsumeIds(compositeId, needCostIds, needCostIdMap, placeInSlotIds)
		end
	end

	return needCostIds, placeInSlotIds
end

function RougeCollectionCompositeView:selectNeedCostConsumeIds(compositeId, needCostIds, needCostIdMap, placeInSlotIds)
	local collectionMOs = RougeCollectionModel.instance:getCollectionByCfgId(compositeId)

	if collectionMOs then
		local hasSelectCount = 0

		for i = 1, #collectionMOs do
			if collectionMOs[i] then
				local collectionId = collectionMOs[i].id

				if collectionId and not needCostIdMap[collectionId] then
					table.insert(needCostIds, collectionId)

					needCostIdMap[collectionId] = true
					hasSelectCount = hasSelectCount + 1

					local isPlaceInSlotArea = RougeCollectionModel.instance:isCollectionPlaceInSlotArea(collectionId)

					if isPlaceInSlotArea then
						table.insert(placeInSlotIds, collectionId)
					end
				end

				if hasSelectCount >= RougeEnum.CompositeCollectionCostCount then
					break
				end
			end
		end
	end
end

function RougeCollectionCompositeView:_compositeCollectionSucc()
	RougeCollectionCompositeListModel.instance:onModelUpdate()
	self:updateSelectCollectionInfo()
end

function RougeCollectionCompositeView:refreshFilterButtonUI()
	local isFiltering = RougeCollectionCompositeListModel.instance:isFiltering()
	local goUnselect = gohelper.findChild(self._btnfilter.gameObject, "unselect")
	local goSelect = gohelper.findChild(self._btnfilter.gameObject, "select")

	gohelper.setActive(goSelect, isFiltering)
	gohelper.setActive(goUnselect, not isFiltering)
end

function RougeCollectionCompositeView:_onSwitchCollectionInfoType()
	self:refreshCollectionDesc()
end

function RougeCollectionCompositeView:onClose()
	self.collectionComp:onClose()
end

function RougeCollectionCompositeView:onDestroyView()
	if self._compositeItemTab then
		for _, collectionIcon in pairs(self._compositeItemTab) do
			if collectionIcon.item then
				collectionIcon.item:destroy()
			end

			if collectionIcon.btnclick then
				collectionIcon.btnclick:RemoveClickListener()
			end
		end
	end

	if self._productIconItem then
		self._productIconItem:destroy()

		self._productIconItem = nil
	end

	TaskDispatcher.cancelTask(self._hideCompositeEffect, self)
	self.collectionComp:destroy()
end

return RougeCollectionCompositeView
