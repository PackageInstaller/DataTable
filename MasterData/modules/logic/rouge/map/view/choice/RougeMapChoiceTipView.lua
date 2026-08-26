-- chunkname: @modules/logic/rouge/map/view/choice/RougeMapChoiceTipView.lua

module("modules.logic.rouge.map.view.choice.RougeMapChoiceTipView", package.seeall)

local RougeMapChoiceTipView = class("RougeMapChoiceTipView", BaseView)

function RougeMapChoiceTipView:onInitView()
	self._gochoicetips = gohelper.findChild(self.viewGO, "#go_choicetips")
	self._gocollectiontips = gohelper.findChild(self.viewGO, "#go_collectiontips")
	self._goclosetip = gohelper.findChild(self.viewGO, "#go_choicetips/#go_closetip")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_choicetips/Scroll View/Viewport/Content/title/#txt_title")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "#go_choicetips/Scroll View/Viewport/Content/#go_collectionitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapChoiceTipView:addEvents()
	return
end

function RougeMapChoiceTipView:removeEvents()
	return
end

function RougeMapChoiceTipView:_editableInitView()
	gohelper.setActive(self._gochoicetips, false)
	gohelper.setActive(self._gocollectionitem, false)

	local goViewPort = gohelper.findChild(self.viewGO, "#go_choicetips/Scroll View/Viewport")

	self.rectViewPort = goViewPort:GetComponent(gohelper.Type_RectTransform)
	self.rectCollectionTip = self._gocollectiontips:GetComponent(gohelper.Type_RectTransform)

	local goContent = gohelper.findChild(self.viewGO, "#go_choicetips/Scroll View/Viewport/Content")

	self.rectTrContent = goContent:GetComponent(gohelper.Type_RectTransform)
	self.click = gohelper.getClickWithDefaultAudio(self._goclosetip)

	self.click:AddClickListener(self.onClickThis, self)

	self.collectionItemList = {}

	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onClickChoiceDetail, self.onClickChoiceDetail, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onClickPieceStoreDetail, self.onClickPieceStoreDetail, self)
end

function RougeMapChoiceTipView:onClickThis()
	self:hideTip()
end

function RougeMapChoiceTipView:onClickChoiceDetail(collectionIdList)
	self.collectionIdList = collectionIdList

	self:showTip()
end

function RougeMapChoiceTipView:onClickPieceStoreDetail(collectionIdList)
	self.collectionIdList = collectionIdList

	self:showTip()
end

function RougeMapChoiceTipView:showTip()
	gohelper.setActive(self._gochoicetips, true)
	self:refreshUI()
end

function RougeMapChoiceTipView:hideTip()
	gohelper.setActive(self._gochoicetips, false)
end

function RougeMapChoiceTipView:refreshUI()
	self._txttitle.text = luaLang("rouge_may_get_collections")

	self:refreshCollectionList()
end

function RougeMapChoiceTipView:refreshCollectionList()
	local extraParams = self:_getOrCreateExtraParams()

	for index, collectionId in ipairs(self.collectionIdList) do
		local collectItem = self:getCollectionItem(index)

		gohelper.setActive(collectItem.go, true)
		RougeCollectionDescHelper.setCollectionDescInfos3(collectionId, nil, collectItem.txtDesc, nil, extraParams)

		collectItem.txtName.text = RougeCollectionConfig.instance:getCollectionName(collectionId)

		collectItem.sImageCollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(collectionId))

		local collectionCo = RougeCollectionConfig.instance:getCollectionCfg(collectionId)

		self:refreshHole(collectItem, collectionCo.holeNum)
	end

	for i = #self.collectionIdList + 1, #self.collectionItemList do
		local collectItem = self.collectionItemList[i]

		gohelper.setActive(collectItem.go, false)
	end

	ZProj.UGUIHelper.RebuildLayout(self.rectTrContent)

	local height = recthelper.getHeight(self.rectTrContent)

	height = math.min(height, RougeMapEnum.MaxTipHeight)

	recthelper.setHeight(self.rectViewPort, height)
end

function RougeMapChoiceTipView:_getOrCreateExtraParams()
	self._extraParams = self._extraParams or {
		isAllActive = true,
		showDescToListFunc = self._ShowDescToListFunc
	}

	return self._extraParams
end

local ActiveEffectColor = "#352E24"

function RougeMapChoiceTipView._ShowDescToListFunc(descTypes, descInfoMap, txtComp, extraParams)
	local descList = {}
	local isAllActive = extraParams and extraParams.isAllActive

	for _, descType in ipairs(descTypes) do
		local contentInfo = descInfoMap[descType]

		if contentInfo then
			for _, info in ipairs(contentInfo) do
				local isActive = isAllActive or info.isActive
				local desc = RougeCollectionDescHelper._decorateCollectionEffectStr(info.content, isActive, ActiveEffectColor)
				local condition = RougeCollectionDescHelper._decorateCollectionEffectStr(info.condition, isActive, ActiveEffectColor)

				table.insert(descList, desc)
				table.insert(descList, condition)
			end
		end
	end

	txtComp.text = table.concat(descList, "\n")
end

function RougeMapChoiceTipView:getCollectionItem(index)
	local collectionItem = self.collectionItemList[index]

	if collectionItem then
		return collectionItem
	end

	collectionItem = self:getUserDataTb_()
	collectionItem.go = gohelper.cloneInPlace(self._gocollectionitem)
	collectionItem.txtDesc = gohelper.findChildText(collectionItem.go, "#txt_desc")
	collectionItem.sImageCollection = gohelper.findChildSingleImage(collectionItem.go, "other/#simage_collection")
	collectionItem.txtName = gohelper.findChildText(collectionItem.go, "other/layout_name/#txt_name")
	collectionItem.goEnchant = gohelper.findChild(collectionItem.go, "other/layout/#go_enchant")
	collectionItem.goEnchantList = self:getUserDataTb_()
	collectionItem.click = gohelper.findChildClickWithDefaultAudio(collectionItem.go, "#btn_detail")

	collectionItem.click:AddClickListener(self.onClickCollection, self, index)
	table.insert(collectionItem.goEnchantList, collectionItem.goEnchant)
	table.insert(self.collectionItemList, collectionItem)

	return collectionItem
end

function RougeMapChoiceTipView:refreshHole(collectItem, holeNum)
	for i = 1, holeNum do
		local go = collectItem.goEnchantList[i]

		if not go then
			go = gohelper.cloneInPlace(collectItem.goEnchant)

			table.insert(collectItem.goEnchantList, go)
		end

		gohelper.setActive(go, true)
	end

	for i = holeNum + 1, #collectItem.goEnchantList do
		gohelper.setActive(collectItem.goEnchantList[i], false)
	end
end

function RougeMapChoiceTipView:onClickCollection(index)
	local collectionId = self.collectionIdList[index]
	local screenPos = recthelper.uiPosToScreenPos(self.rectCollectionTip)
	local params = {
		interactable = false,
		collectionCfgId = collectionId,
		viewPosition = screenPos,
		source = RougeEnum.OpenCollectionTipSource.ChoiceView
	}

	RougeController.instance:openRougeCollectionTipView(params)
end

function RougeMapChoiceTipView:onClose()
	return
end

function RougeMapChoiceTipView:onDestroyView()
	for _, collectionItem in ipairs(self.collectionItemList) do
		collectionItem.sImageCollection:UnLoadImage()
		collectionItem.click:RemoveClickListener()
	end

	self.click:RemoveClickListener()
end

return RougeMapChoiceTipView
