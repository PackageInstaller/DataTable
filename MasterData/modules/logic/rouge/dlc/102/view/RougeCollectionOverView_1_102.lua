-- chunkname: @modules/logic/rouge/dlc/102/view/RougeCollectionOverView_1_102.lua

module("modules.logic.rouge.dlc.102.view.RougeCollectionOverView_1_102", package.seeall)

local RougeCollectionOverView_1_102 = class("RougeCollectionOverView_1_102", BaseViewExtended)

RougeCollectionOverView_1_102.ParentObjPath = "#go_rougemapdetailcontainer"
RougeCollectionOverView_1_102.AssetUrl = "ui/viewres/rouge/dlc/102/rougeequiptipsview.prefab"

local BtnPositionX, BtnPositionY = -62, -18.6
local TipPositionX, TipPositionY = -38.06, 25.5
local FullTipPositionX, FullTipPositionY = -78, 0
local MinScrollHeight, MaxScrollHeight = 0, 800

function RougeCollectionOverView_1_102:onInitView()
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_tips")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._scrolloverview = gohelper.findChildScrollRect(self.viewGO, "#go_tips/#scroll_overview")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_tips/#scroll_overview/Viewport/Content")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "#go_tips/#scroll_overview/Viewport/Content/#go_collectionitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tips/#btn_close")
	self._collectionItemTab = self:getUserDataTb_()

	recthelper.setAnchor(self._gotips.transform, TipPositionX, TipPositionY)
	recthelper.setAnchor(self._btntips.transform, BtnPositionX, BtnPositionY)
	gohelper.setActive(self._btntips, true)
	gohelper.setActive(self._gotips, false)
end

function RougeCollectionOverView_1_102:addEvents()
	self._btntips:AddClickListener(self._btntipOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RougeCollectionOverView_1_102:removeEvents()
	self._btntips:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function RougeCollectionOverView_1_102:_btntipOnClick()
	gohelper.setActive(self._gotips, true)
	self:refreshUI()
end

function RougeCollectionOverView_1_102:_btncloseOnClick()
	gohelper.setActive(self._gotips, false)
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function RougeCollectionOverView_1_102:onUpdateDLC()
	return
end

function RougeCollectionOverView_1_102:onOpen()
	self._spCollections = RougeDLCModel102.instance:getCanLevelUpSpCollectionsInSlotArea()

	if self._spCollections then
		if not #self._spCollections then
			local spCollectionCount = 0

			gohelper.setActive(self._btntips.gameObject, spCollectionCount > 0)
		end
	end
end

function RougeCollectionOverView_1_102:refreshUI()
	local useMap = {}

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

	ZProj.UGUIHelper.RebuildLayout(self._gocontent.transform)

	local contentHeight = recthelper.getHeight(self._gocontent.transform)
	local scrollHeight = Mathf.Clamp(contentHeight, MinScrollHeight, MaxScrollHeight)

	recthelper.setHeight(self._scrolloverview.transform, scrollHeight)
end

function RougeCollectionOverView_1_102:_getOrCreateCollectionItem(index)
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

function RougeCollectionOverView_1_102:_btnclickCollectionItem(index)
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

function RougeCollectionOverView_1_102:_refreshCollectionItem(collectionItem, collectionMo)
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

function RougeCollectionOverView_1_102:_getOrCreateShowDescTypes()
	self._showTypes = self._showTypes or {
		RougeEnum.CollectionDescType.SpecialText
	}

	return self._showTypes
end

function RougeCollectionOverView_1_102:_getOrCreateExtraParams()
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

function RougeCollectionOverView_1_102._showSpCollectionLevelUp(goItem, contentInfo)
	local txtDesc = goItem:GetComponent(gohelper.Type_TextMesh)
	local gofinishpoint = gohelper.findChild(goItem, "finish")
	local gounfinishpoint = gohelper.findChild(goItem, "unfinish")

	txtDesc.text = contentInfo.condition

	gohelper.setActive(gofinishpoint, contentInfo.isActive)
	gohelper.setActive(gounfinishpoint, not contentInfo.isActive)
	SLFramework.UGUI.GuiHelper:SetColor((contentInfo.isActive or nil) and (ActiveEffectColor or DisactiveEffectColor))
	ZProj.UGUIHelper:SetColorAlpha((contentInfo.isActive or nil) and (ActiveEffectAlpha or DisactiveEffectAlpha))
end

function RougeCollectionOverView_1_102:unloadCollectionItems()
	if self._collectionItemTab then
		for _, collectionItem in pairs(self._collectionItemTab) do
			collectionItem.simageicon:UnLoadImage()
			collectionItem.btnclick:RemoveClickListener()
		end
	end
end

function RougeCollectionOverView_1_102:onDestroyView()
	self:unloadCollectionItems()
end

return RougeCollectionOverView_1_102
