-- chunkname: @modules/logic/rouge/dlc/102/view/RougeCollectionComp_1_102.lua

module("modules.logic.rouge.dlc.102.view.RougeCollectionComp_1_102", package.seeall)

local RougeCollectionComp_1_102 = class("RougeCollectionComp_1_102", LuaCompBase)

RougeCollectionComp_1_102.ParentObjPath = "Root"
RougeCollectionComp_1_102.AssetUrl = "ui/viewres/rouge/dlc/102/rougeequiptipsview.prefab"

local BtnPositionX, BtnPositionY = 76.8, 50.2
local TipPositionX, TipPositionY = 470.3, 436.3
local FullTipPositionX, FullTipPositionY = 263.5, -3.9
local MinScrollHeight, MaxScrollHeight = 0, 800

function RougeCollectionComp_1_102:init(go)
	RougeCollectionComp_1_102.super.init(self, go)

	self._btntips = gohelper.findChildButtonWithAudio(go, "#btn_tips")
	self._gotips = gohelper.findChild(go, "#go_tips")
	self._scrolloverview = gohelper.findChildScrollRect(go, "#go_tips/#scroll_overview")
	self._gocontent = gohelper.findChild(go, "#go_tips/#scroll_overview/Viewport/Content")
	self._gocollectionitem = gohelper.findChild(go, "#go_tips/#scroll_overview/Viewport/Content/#go_collectionitem")
	self._btnclose = gohelper.findChildButtonWithAudio(go, "#go_tips/#btn_close")
	self._collectionItemTab = self:getUserDataTb_()

	recthelper.setAnchor(self._gotips.transform, TipPositionX, TipPositionY)
	recthelper.setAnchor(self._btntips.transform, BtnPositionX, BtnPositionY)
	gohelper.setActive(self._btntips, true)
	gohelper.setActive(self._gotips, false)
	self:_checkIsTipBtnVisible()
end

function RougeCollectionComp_1_102:addEventListeners()
	self._btntips:AddClickListener(self._btntipOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.UpdateSlotCollectionEffect, self._checkIsTipBtnVisible, self)
end

function RougeCollectionComp_1_102:removeEventListeners()
	self._btntips:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function RougeCollectionComp_1_102:_btntipOnClick()
	self:refreshUI()
end

function RougeCollectionComp_1_102:_btncloseOnClick()
	gohelper.setActive(self._gotips, false)
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function RougeCollectionComp_1_102:onUpdateDLC()
	return
end

function RougeCollectionComp_1_102:_checkIsTipBtnVisible()
	local spCollections = RougeDLCModel102.instance:getCanLevelUpSpCollectionsInSlotArea()

	if spCollections then
		if not #spCollections then
			local spCollectionCount = 0

			gohelper.setActive(self._btntips.gameObject, spCollectionCount > 0)
		end
	end
end

function RougeCollectionComp_1_102:refreshUI()
	local useMap = {}

	self._spCollections = RougeDLCModel102.instance:getCanLevelUpSpCollectionsInSlotArea()

	for index, collectionMo in ipairs(self._spCollections) do
		local collectionItem = self:_getOrCreateCollectionItem(index)

		self:_refreshCollectionItem(collectionItem, collectionMo)

		useMap[collectionItem] = true
	end

	for _, collectionItem in pairs(self._collectionItemTab) do
		if not useMap[collectionItem] then
			gohelper.setActive(collectionItem.viewGO, false)
		end
	end

	gohelper.setActive(self._gotips, true)
	ZProj.UGUIHelper.RebuildLayout(self._gocontent.transform)

	local contentHeight = recthelper.getHeight(self._gocontent.transform)
	local scrollHeight = Mathf.Clamp(contentHeight, MinScrollHeight, MaxScrollHeight)

	recthelper.setHeight(self._scrolloverview.transform, scrollHeight)
	self:_fitScrollScreenOffset()
end

function RougeCollectionComp_1_102:_fitScrollScreenOffset()
	gohelper.setActive(self._gocontent, false)
	gohelper.fitScreenOffset(self._scrolloverview.transform)
	gohelper.setActive(self._gocontent, true)
end

function RougeCollectionComp_1_102:_getOrCreateCollectionItem(index)
	local collectionItem = self._collectionItemTab[index]

	if not collectionItem then
		collectionItem = self:getUserDataTb_()
		collectionItem.viewGO = gohelper.cloneInPlace(self._gocollectionitem, "item_" .. index)
		collectionItem.desccontent = gohelper.findChild(collectionItem.viewGO, "go_desccontent")
		collectionItem.descList = self:getUserDataTb_()
		collectionItem.txtname = gohelper.findChildText(collectionItem.viewGO, "name/txt_name")
		collectionItem.txtDec = gohelper.findChild(collectionItem.viewGO, "#txt_dec")
		collectionItem.simageicon = gohelper.findChildSingleImage(collectionItem.viewGO, "image_collection")
		collectionItem.btnclick = gohelper.findChildButtonWithAudio(collectionItem.viewGO, "btn_click")

		collectionItem.btnclick:AddClickListener(self._btnclickCollectionItem, self, index)

		self._collectionItemTab[index] = collectionItem
	end

	return collectionItem
end

function RougeCollectionComp_1_102:_btnclickCollectionItem(index)
	if self._spCollections then
		local spCollection = self._spCollections[index]

		if not spCollection then
			return
		end

		local collectionId = spCollection:getCollectionId()
		local viewPosition = Vector2.New(FullTipPositionX, FullTipPositionY)
		local params = {
			interactable = false,
			useCloseBtn = false,
			collectionId = collectionId,
			viewPosition = viewPosition
		}

		RougeController.instance:openRougeCollectionTipView(params)
	end
end

function RougeCollectionComp_1_102:_refreshCollectionItem(collectionItem, collectionMo)
	local collectionId = collectionMo:getCollectionId()
	local collectionCfgId = collectionMo:getCollectionCfgId()

	collectionItem.txtname.text = RougeCollectionConfig.instance:getCollectionName(collectionCfgId)

	local iconUrl = RougeCollectionHelper.getCollectionIconUrl(collectionCfgId)

	collectionItem.simageicon:LoadImage(iconUrl)

	local showTypes = self:_getOrCreateShowDescTypes()
	local extraParams = self:_getOrCreateExtraParams()

	RougeCollectionDescHelper.setCollectionDescInfos(collectionId, collectionItem.desccontent, collectionItem.descList, showTypes, extraParams)
	gohelper.setActive(collectionItem.viewGO, true)
end

function RougeCollectionComp_1_102:_getOrCreateShowDescTypes()
	self._showTypes = self._showTypes or {
		RougeEnum.CollectionDescType.SpecialText
	}

	return self._showTypes
end

function RougeCollectionComp_1_102:_getOrCreateExtraParams()
	self._extraParams = self._extraParams or {
		showDescFuncMap = {
			[RougeEnum.CollectionDescType.SpecialText] = self._showSpCollectionLevelUp
		}
	}

	return self._extraParams
end

local ActiveEffectColor = "#A08156"
local DisactiveEffectColor = "#616161"
local ActiveEffectAlpha = 1
local DisactiveEffectAlpha = 0.6

function RougeCollectionComp_1_102._showSpCollectionLevelUp(goItem, contentInfo)
	local txtDesc = goItem:GetComponent(gohelper.Type_TextMesh)
	local gofinishpoint = gohelper.findChild(goItem, "finish")
	local gounfinishpoint = gohelper.findChild(goItem, "unfinish")

	txtDesc.text = contentInfo.condition

	gohelper.setActive(gofinishpoint, contentInfo.isActive)
	gohelper.setActive(gounfinishpoint, not contentInfo.isActive)
	SLFramework.UGUI.GuiHelper:SetColor((contentInfo.isActive or nil) and (ActiveEffectColor or DisactiveEffectColor))
	ZProj.UGUIHelper:SetColorAlpha((contentInfo.isActive or nil) and (ActiveEffectAlpha or DisactiveEffectAlpha))
end

function RougeCollectionComp_1_102:unloadCollectionItems()
	if self._collectionItemTab then
		for _, collectionItem in pairs(self._collectionItemTab) do
			collectionItem.simageicon:UnLoadImage()
			collectionItem.btnclick:RemoveClickListener()
		end
	end
end

function RougeCollectionComp_1_102:onDestroy()
	self:unloadCollectionItems()
end

return RougeCollectionComp_1_102
