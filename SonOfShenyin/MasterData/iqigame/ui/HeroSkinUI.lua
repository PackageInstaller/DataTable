-- chunkname: @IQIGame\\UI\\HeroSkinUI.lua

local buySkinTipsView = require("IQIGame.UI.Skin.BuySkinTipsView")
local CommonRoleDisplayView = require("IQIGame/UI/Common/CommonRoleDisplayView")
local RolePreview = {
	isAmplify = true,
	power = Vector3.New(0.2, 0.2, 0)
}

function RolePreview.New(view)
	local obj = Clone(RolePreview)

	obj:__Init(view)

	return obj
end

function RolePreview:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnCloseBtnClick()
		self.gameObject.gameObject:SetActive(false)
	end

	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseBtnClick)

	function self.__delegateOnScaleBtnClick()
		self:__OnScaleBtnClick()
	end

	self.scaleBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnScaleBtnClick)
end

function RolePreview:__OnScaleBtnClick()
	local scale = self.img.transform.localScale

	if self.isAmplify then
		scale = Vector3.__add(scale, self.power)

		if scale.x >= 2 then
			scale = Vector3.New(2, 2, 0)
			self.isAmplify = false
		end
	else
		scale = Vector3.__sub(scale, self.power)

		if scale.x <= 1 then
			scale = Vector3.New(1, 1, 0)
			self.isAmplify = true
		end
	end

	self.img.transform.localScale = scale
end

function RolePreview:Show()
	self.gameObject:SetActive(true)

	self.img.transform.localScale = Vector3.one
end

function RolePreview:Hide()
	self.gameObject:SetActive(false)
end

function RolePreview:Dispose()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseBtnClick)
	self.scaleBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnScaleBtnClick)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local SkinItemCell = {}

function SkinItemCell.New(view)
	local obj = Clone(SkinItemCell)

	obj:__Init(view)

	return obj
end

function SkinItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function SkinItemCell:Show(skinCid)
	self.gameObject:SetActive(true)

	local heroSkinData = CfgHeroSkinTable[skinCid]
	local path = SkinModule.GetHeroSkinImgPathByType(heroSkinData, Constant.SkinImageType.HeroResourcesShowImg)

	AssetUtil.LoadImage(self, path, self.skinIcon:GetComponent("Image"))
end

function SkinItemCell:Hide()
	self.gameObject:SetActive(false)
end

function SkinItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local HeroSkinUI = {
	skinCid = 0,
	uniqueEntityID = 0,
	heroCid = 0,
	skinCidList = {},
	skinAreaList = {},
	skinItemList = {},
	skinDescItems = {}
}

HeroSkinUI = Base:Extend("HeroSkinUI", "IQIGame.Onigao.UI.HeroSkinUI", HeroSkinUI)

function HeroSkinUI:OnInit()
	self:__OnInitEventDelegateFunc()
	self:__OnInit()
end

function HeroSkinUI:GetPreloadAssetPaths()
	return nil
end

function HeroSkinUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HeroSkinUI:IsManualShowOnOpen(userData)
	return false
end

function HeroSkinUI:GetBGM(userData)
	return nil
end

function HeroSkinUI:OnOpen(userData)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.HeroSkinUI)
	self.rolePreview:Hide()
	self.buySkinTipsPanel:Hide()

	self.openType = userData.type

	local showSkinCid

	if self.openType == Constant.SkinUIOpenType.HeroDetailsUI then
		self.heroCid = userData.args.heroCid
		showSkinCid = userData.args.showSkinCid

		if showSkinCid == nil then
			local warlockData = WarlockModule.GetHeroData(self.heroCid)

			showSkinCid = warlockData:GetCurrentSkinCid()
		end

		self.skinCidList = SkinModule.GetHeroSkinList(self.heroCid)
	elseif self.openType == Constant.SkinUIOpenType.ShopDetailsUI then
		self.commodityDatas = userData.args.commodityDataList
		showSkinCid = userData.args.showSkinCid
		self.skinCidList = {}

		for _, v in ipairs(self.commodityDatas) do
			table.insert(self.skinCidList, CfgItemTable[v.config.ItemId].LikeId)
		end
	end

	self:__OnShow(showSkinCid)
end

function HeroSkinUI:OnClose(userData)
	self:__ReleaseUISpine()
	self.roleDisplayView:Hide()
	AssetUtil.UnloadAsset(self)
end

function HeroSkinUI:__OnInitEventDelegateFunc()
	function self.__delegateOnPreviousPage()
		self.skinAreaList:TurnToBackward()
	end

	function self.__delegateOnNextPage()
		self.skinAreaList:TurnToForward()
	end

	function self.__delegateOnUseSkin()
		self:__OnUseSkin()
	end

	function self.__delegateOnChangeSkinResult()
		self:__OnChangeSkinResult()
	end

	function self.__delegateOnBuySkin()
		self:__OnBuySkin()
	end

	function self.__delegateOnPreviewBtnClick()
		self.rolePreview:Show()
	end

	function self.__delegateOnSkinTipsBtnClick()
		self:__OnSkinTipsBtnClick()
	end

	function self.__delegateOnSkinTipsCloseBtnClick()
		self:__OnSkinTipsCloseBtnClick()
	end

	function self.DelegateOnBuyShopResultEvent()
		self:OnBuyShopResultEvent()
	end
end

function HeroSkinUI:OnAddListeners()
	self.LeftButtonObj:GetComponent("Button").onClick:AddListener(self.__delegateOnPreviousPage)
	self.RightButtonObj:GetComponent("Button").onClick:AddListener(self.__delegateOnNextPage)
	self.equipSkinBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnUseSkin)
	self.buyButton:GetComponent("Button").onClick:AddListener(self.__delegateOnBuySkin)
	self.previewBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnPreviewBtnClick)
	EventDispatcher.AddEventListener(EventID.ChangeSkinResult, self.__delegateOnChangeSkinResult)
	self.skinTipsCloseBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnSkinTipsCloseBtnClick)
	self.skinTipsBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnSkinTipsBtnClick)
	EventDispatcher.AddEventListener(EventID.NotifyChangeShopItems, self.DelegateOnBuyShopResultEvent)
end

function HeroSkinUI:OnRemoveListeners()
	self.LeftButtonObj:GetComponent("Button").onClick:RemoveListener(self.__delegateOnPreviousPage)
	self.RightButtonObj:GetComponent("Button").onClick:RemoveListener(self.__delegateOnNextPage)
	self.equipSkinBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnUseSkin)
	self.buyButton:GetComponent("Button").onClick:RemoveListener(self.__delegateOnBuySkin)
	self.previewBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnPreviewBtnClick)
	EventDispatcher.RemoveEventListener(EventID.ChangeSkinResult, self.__delegateOnChangeSkinResult)
	self.skinTipsCloseBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnSkinTipsCloseBtnClick)
	self.skinTipsBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnSkinTipsBtnClick)
	EventDispatcher.RemoveEventListener(EventID.NotifyChangeShopItems, self.DelegateOnBuyShopResultEvent)
end

function HeroSkinUI:OnPause()
	return
end

function HeroSkinUI:OnResume()
	return
end

function HeroSkinUI:OnCover()
	return
end

function HeroSkinUI:OnReveal()
	return
end

function HeroSkinUI:OnRefocus(userData)
	return
end

function HeroSkinUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HeroSkinUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HeroSkinUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HeroSkinUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HeroSkinUI:OnDestroy()
	self.roleDisplayView:Dispose()
	self:__ReleaseUISpine()
	ForPairs(self.skinItemList, function(k, _item)
		_item:Dispose()
	end)

	self.skinAreaList = nil

	self.buySkinTipsPanel:Dispose()
	self.moneyCell:Dispose()
	AssetUtil.UnloadAsset(self)
end

function HeroSkinUI:__OnInit()
	self.commonReturnBtn = CommonReturnBtn.New(self.commonReturnBtnRoot, self)
	self.roleDisplayView = CommonRoleDisplayView.New(self.RoleDisplayViewRoot, Constant.DynamicSkinShowPosition.SkinPanel)
	self.skinAreaList = self.skinScrollViewRoot:GetComponent("ScrollAreaListPage")

	function self.skinAreaList.onRenderCell(cell)
		self:__OnRenderSkinListItem(cell)
	end

	function self.skinAreaList.onPageReachedMainPos(page)
		self:__OnPageReachedMainPos(page)
	end

	self.rolePreview = RolePreview.New(self.previewRoot)
	self.buySkinTipsPanel = buySkinTipsView.New(self.BuySkinTips, self)
	self.moneyCell = CurrencyCell.New(self.MoneyTopRoot)

	for i = 0, self.tipsContentRoot.transform.childCount - 1 do
		local childTrans = self.tipsContentRoot.transform:GetChild(i)

		table.insert(self.skinDescItems, childTrans)
	end
end

function HeroSkinUI:__OnShow(showSkinCid)
	self.skinTipsRoot.gameObject:SetActive(false)

	local curShowIndex = 1

	ForArray(self.skinCidList, function(_index, _skinCid)
		if _skinCid ~= showSkinCid then
			return
		end

		curShowIndex = _index

		return true
	end)

	self.skinAreaList.startIndex = curShowIndex - 1

	self.skinAreaList:Refresh(#self.skinCidList)
end

function HeroSkinUI:__OnRenderSkinListItem(page)
	local insID = page.gameObject:GetInstanceID()
	local skinItem = self.skinItemList[insID]

	if skinItem == nil then
		skinItem = SkinItemCell.New(page.gameObject)
		self.skinItemList[insID] = skinItem
	end

	local skinCid = self.skinCidList[page.index + 1]

	skinItem:Show(skinCid)
end

function HeroSkinUI:__OnPageReachedMainPos(page)
	local selectIndex = page.index + 1
	local totalCount = #self.skinCidList

	if selectIndex == 1 then
		self.LeftButtonObj.gameObject:SetActive(false)

		if selectIndex == totalCount then
			self.RightButtonObj.gameObject:SetActive(false)
		else
			self.RightButtonObj.gameObject:SetActive(true)
		end
	elseif selectIndex == totalCount then
		self.RightButtonObj.gameObject:SetActive(false)

		if totalCount > 1 then
			self.LeftButtonObj.gameObject:SetActive(true)
		else
			self.LeftButtonObj.gameObject:SetActive(false)
		end
	else
		self.LeftButtonObj.gameObject:SetActive(true)
		self.RightButtonObj.gameObject:SetActive(true)
	end

	local skinCid = self.skinCidList[selectIndex]

	self:__RefreshHeroSkinData(skinCid)
end

function HeroSkinUI:__RefreshHeroSkinData(skinCid)
	self.skinCid = skinCid

	local heroSkinData = CfgHeroSkinTable[self.skinCid]
	local resourcesVerticalDrawPath = SkinModule.GetHeroSkinImgPathByType(heroSkinData, Constant.SkinImageType.HeroResourcesVerticalDraw)
	local img = self.rolePreview.img

	AssetUtil.LoadImage(self, resourcesVerticalDrawPath, img:GetComponent("Image"), self.__OnLoadImageSucess, nil, img)

	local resourcesHeadPath = SkinModule.GetHeroSkinImgPathByType(heroSkinData, Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage(self, resourcesHeadPath, self.headIconImageObj:GetComponent("Image"))

	if not LuaUtility.StrIsNullOrEmpty(heroSkinData.SkinDesc) then
		self.skinDescTextObj.gameObject:SetActive(true)
		UGUIUtil.SetText(self.skinDescTextObj, heroSkinData.SkinDesc)
	else
		self.skinDescTextObj.gameObject:SetActive(false)
	end

	self:__ReleaseUISpine()

	self.uniqueEntityID = EntityUtility.GetHeroUIEntityByUIEntityCid(heroSkinData.UIEntityID, self.spineRoot.transform, Vector3.zero, function(_entityComponent)
		if _entityComponent.Id ~= self.uniqueEntityID then
			EntityUtility.HideEntity(_entityComponent)

			return
		end

		local previewSpine = _entityComponent.gameObject
		local skeletonGraphic = previewSpine:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic), true)

		skeletonGraphic:Initialize(true)
		skeletonGraphic.AnimationState:SetAnimation(0, "idle", true)
	end)

	self.roleDisplayView:Show(self.skinCid)
	self:__RefreshButtonState()

	if #heroSkinData.SkinTips == 0 then
		self.skinTipsBtn.gameObject:SetActive(false)
	else
		self.skinTipsBtn.gameObject:SetActive(true)
		ForArray(self.skinDescItems, function(_index, _trans)
			if heroSkinData.SkinTips == nil then
				_trans.gameObject:SetActive(false)

				return
			end

			local tips = heroSkinData.SkinTips[_index]

			if LuaUtility.StrIsNullOrEmpty(tips) then
				_trans.gameObject:SetActive(false)

				return
			end

			_trans.gameObject:SetActive(true)

			_trans:Find("Text").gameObject:GetComponent("Text").text = tips
		end)
	end
end

function HeroSkinUI:__ReleaseUISpine()
	if self.uniqueEntityID == 0 then
		return
	end

	EntityUtility.HideEntityByEntityID(self.uniqueEntityID)

	self.uniqueEntityID = 0
end

function HeroSkinUI:__OnLoadImageSucess(assetName, asset, duration, userData)
	local img = userData:GetComponent("Image")

	img:SetNativeSize()
	LuaUtility.SetImageRectTransformPivot(userData:GetComponent("RectTransform"), img)
end

function HeroSkinUI:__RefreshButtonState()
	self:__OnReset()

	if self.openType == Constant.SkinUIOpenType.HeroDetailsUI then
		local warlockData = WarlockModule.GetHeroData(self.heroCid)
		local showSkinCid = warlockData:GetCurrentSkinCid()

		if self.skinCid == showSkinCid then
			self.curSkinTag.gameObject:SetActive(true)
			self.notHaveTag.gameObject:SetActive(false)
			self.equipSkinBtn.gameObject:SetActive(false)
		else
			local unlock = SkinModule.SkinIsUnlock(self.skinCid)

			self.curSkinTag.gameObject:SetActive(false)
			self.notHaveTag.gameObject:SetActive(not unlock)
			self.equipSkinBtn.gameObject:SetActive(unlock)
		end
	elseif self.openType == Constant.SkinUIOpenType.ShopDetailsUI then
		local index = table.indexOf(self.skinCidList, self.skinCid)

		self.buyCommodityData = self.commodityDatas[index]

		local itemData = WarehouseModule.FindItemForCid(self.buyCommodityData.config.ItemId)
		local isHave = itemData ~= nil

		LuaUtility.SetGameObjectShow(self.purchasedTag, isHave)
		LuaUtility.SetGameObjectShow(self.buyButton, not isHave)

		if not isHave then
			self:__RefreshCommodityInfo()
		end
	end
end

function HeroSkinUI:__RefreshCommodityInfo()
	LuaUtility.SetGameObjectShow(self.imageCurrencyIcon, true)
	AssetUtil.LoadImage(self, ShopUIApi:GetShopBuyIconPath(self.buyCommodityData:GetPriceIconId()), self.imageCurrencyIcon:GetComponent("Image"))

	if self.buyCommodityData.isDiscount then
		LuaUtility.SetText(self.textPriceNum, ShopUIApi:GetCommodityPriceText(1, self.buyCommodityData:GetDiscount()))
	else
		LuaUtility.SetText(self.textPriceNum, ShopUIApi:GetCommodityPriceText(1, self.buyCommodityData:GetPrice()))
	end
end

function HeroSkinUI:__OnReset()
	LuaUtility.SetGameObjectShow(self.curSkinTag, false)
	LuaUtility.SetGameObjectShow(self.notHaveTag, false)
	LuaUtility.SetGameObjectShow(self.equipSkinBtn, false)
	LuaUtility.SetGameObjectShow(self.buyButton, false)
	LuaUtility.SetGameObjectShow(self.purchasedTag, false)
end

function HeroSkinUI:__OnUseSkin()
	local itemCid = SkinModule.GetHeroSkinUnlockItemCid(self.skinCid)
	local itemData = WarehouseModule.GetItemDataByCfgID(itemCid)

	if itemData == nil then
		logError("角色背包数据错误")

		return
	end

	SkinModule.ChangeSkin(self.heroCid, itemData.id)
end

function HeroSkinUI:__OnBuySkin()
	UIModule.Open(Constant.UIControllerName.BuyResItemUI, Constant.UILayer.UI, {
		data = self.buyCommodityData
	})
end

function HeroSkinUI:OnBuyShopResultEvent()
	self:__RefreshButtonState()
end

function HeroSkinUI:CloseSelfUI()
	UIModule.Close(Constant.UIControllerName.HeroSkinUI)
end

function HeroSkinUI:__OnChangeSkinResult()
	self:__RefreshButtonState()
end

function HeroSkinUI:__OnSkinTipsBtnClick()
	self.skinTipsRoot.gameObject:SetActive(true)
end

function HeroSkinUI:__OnSkinTipsCloseBtnClick()
	self.skinTipsRoot.gameObject:SetActive(false)
end

return HeroSkinUI
