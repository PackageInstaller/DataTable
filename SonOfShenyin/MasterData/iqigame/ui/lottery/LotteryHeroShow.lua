-- chunkname: @IQIGame\\UI\\Lottery\\LotteryHeroShow.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.heroStarCom = self.heroStar:GetComponent("SimpleStarComponent")

	self:InitMembers()
	self:InitDelegate()
	self:AddListeners()
end

function m:InitMembers()
	self.ReplaceItemList = {}
end

function m:InitDelegate()
	function self.DelegateCloseBtn()
		self:NextStep()
	end

	function self.DelegateSkipBtn()
		self:Hide()

		if self.OnCloseDelegate then
			self.OnCloseDelegate(self.resultList)
		end
	end
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	self.SkipButton:GetComponent("Button").onClick:AddListener(self.DelegateSkipBtn)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	self.SkipButton:GetComponent("Button").onClick:RemoveListener(self.DelegateSkipBtn)
end

function m:SetData(resultList, OnCloseDelegate)
	self.resultList = resultList.drawResults
	self.isTenOrder = #self.resultList == 10

	self.SkipButton.gameObject:SetActive(self.isTenOrder)

	self.showIndex = 1
	self.OnCloseDelegate = OnCloseDelegate

	self:Show()
	self:NextStep()
end

function m:NextStep()
	self.fxHeiMu.gameObject:SetActive(false)
	self.fxJin.gameObject:SetActive(false)
	self.fxZi.gameObject:SetActive(false)
	self.fxLan.gameObject:SetActive(false)
	LuaUtility.SetGameObjectShow(self.showEffect, false)

	if self.isShowLast then
		return
	end

	if self.resultList == nil then
		self:Hide()

		if self.OnCloseDelegate then
			self.OnCloseDelegate(self.resultList)
		end

		return
	end

	if self.showIndex > #self.resultList then
		self.showIndex = 1

		self:Hide()

		if self.OnCloseDelegate then
			self.OnCloseDelegate(self.resultList)
		end

		return
	end

	self:ShowItem()

	self.showIndex = self.showIndex + 1
end

function m:ResetStatus()
	LuaUtility.SetGameObjectShow(self.effectNewHero, false)
end

function m:ShowItem()
	self.itemData = self.resultList[self.showIndex]
	self.isShowLast = true

	self.fxHeiMu.gameObject:SetActive(true)
	LuaUtility.SetGameObjectShow(self.effectNewHero, false)

	local isFirstGet = LotteryModule.IsHaveItem(self.itemData)

	LuaUtility.SetGameObjectShow(self.effectNewHero, true)
	LuaUtility.RePlayAnimation(self.View)

	if not isFirstGet then
		coroutine.start(function()
			coroutine.wait(4)

			self.isShowLast = false
		end)
	else
		self.isShowLast = false
	end

	LuaUtility.SetGameObjectShow(self.showEffect, true)

	local cid = 0

	if self.itemData.srcId == 0 then
		cid = self.itemData.itemShowPODs[1].cid
	else
		cid = self.itemData.srcId
	end

	local isHero = LotteryModule.IsHeroItem(cid)

	self.ItemCfg = LotteryModule.ItemCfg(cid)

	self.GetHeroParent:SetActive(isHero)
	self.GetItemParent:SetActive(not isHero)
	self:ShowReplaceItem()

	if isHero then
		self:ShowHeroEffect()
	else
		self:ShowItemEffect()
	end
end

function m:ShowHeroEffectByHeroCid(heroCid)
	LuaUtility.SetGameObjectShow(self.showEffect, true)
	self.GetHeroParent:SetActive(true)

	local heroCfg = CfgHeroTable[heroCid]

	LuaUtility.RePlayAnimation(self.View)
	self:SetHeroInfo(heroCid, heroCfg)
	self:Show()
end

function m:ShowHeroEffect()
	local heroCID = self.ItemCfg.ActionParams[1]
	local heroCfg = CfgHeroTable[heroCID]

	self:SetHeroInfo(heroCID, heroCfg)

	if not LotteryModule.IsHaveItem(self.itemData) then
		CVModule.PlayCV(Constant.CVActionType.RoleFirstGet, heroCID)
	end
end

function m:SetHeroInfo(heroCID, heroCfg)
	if self.heroNewTag ~= nil then
		self.heroNewTag.gameObject:SetActive(false)
	end

	local path = SkinModule.GetHeroDefaultSkinImgPath(heroCID, Constant.SkinImageType.HeroResourcesVerticalDraw)
	local imageHeroBlackCom = self.imageHeroBlack:GetComponent("Image")

	LuaUtility.LoadImage(self, path, imageHeroBlackCom, function()
		imageHeroBlackCom:SetNativeSize()
		LuaUtility.SetImageRectTransformPivot(imageHeroBlackCom:GetComponent(typeof(UnityEngine.RectTransform)), imageHeroBlackCom)
	end)
	LuaUtility.SetGameObjectShow(self.imageHeroDoTween, false)
	LuaUtility.SetGameObjectShow(self.imageHero, true)
	LuaUtility.LoadImage(self, path, self.imageHero:GetComponent("Image"), function()
		LuaUtility.SetImageNativeSizeWithGameObject(self.imageHero)
		LuaUtility.SetImageRectTransformPivot(self.imageHero:GetComponent("RectTransform"), self.imageHero:GetComponent("Image"))
	end)
	LuaUtility.LoadImage(self, string.format(CfgUtil.GetCfgResourceUrl(Constant.Resource.RoleElement), heroCfg.Elements), self.PropertyImg:GetComponent("Image"), function()
		LuaUtility.SetImageNativeSizeWithGameObject(self.PropertyImg)
	end)

	path = LotteryUIApi:GetHeroProfessionImg(1, heroCfg.Profession)

	self:LoadImg(path, self.ProfessionImg:GetComponent("Image"))

	path = WarlockApi:GetForceImgPath(heroCfg.Forces)

	self:LoadImg(path, self.forceImg:GetComponent("Image"))
	self.heroStarCom:UpdateView(heroCfg.Quality, 0)

	local itemCfg = CfgItemTable[heroCfg.LinkItem]

	UGUIUtil.SetText(self.goHeroDesc, itemCfg.ItemTips)
	UGUIUtil.SetText(self.goHeroName, heroCfg.Name)
	self:ShowEffect(heroCfg.Quality)
end

function m:ShowItemEffect()
	if self.skillNewTag ~= nil then
		self.skillNewTag.gameObject:SetActive(false)
	end

	if self.ItemCfg.ItemTypes == Constant.ItemType.Skill then
		local skillDetailCfg = CfgUtil.GetCfgSkillDetailDataWithID(self.ItemCfg.LikeId)
		local skillCfg = CfgUtil.GetCfgSkillDataWithID(self.ItemCfg.LikeId)

		if skillDetailCfg and skillDetailCfg.Element and skillDetailCfg.Element ~= 0 then
			LuaUtility.LoadImage(self, string.format(CfgUtil.GetCfgResourceUrl(17001), skillDetailCfg.Element), self.elementImg:GetComponent("Image"))
			LuaUtility.SetGameObjectShow(self.elementImg, true)
		else
			LuaUtility.SetGameObjectShow(self.elementImg, false)
		end

		self.BreachStar:GetComponent("SimpleStarComponent"):UpdateView(5, self.ItemCfg.Quality)
	end

	LuaUtility.SetText(self.Text_Name, self.ItemCfg.Name)
	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(self.ItemCfg.BigIcon), self.goImgSkill:GetComponent("Image"))
	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(self.ItemCfg.BigIcon), self.goImgSkillBack:GetComponent("Image"))
	UGUIUtil.SetText(self.ItemDesc, self.ItemCfg.ItemTips)
	self:ShowEffect(self.ItemCfg.Quality)

	if self.ItemCfg.DepotType == Constant.DepotType.Hero then
		local heroCfg = CfgHeroTable[self.ItemCfg.LikeId]

		if heroCfg ~= nil then
			LuaUtility.LoadImage(self, string.format(CfgUtil.GetCfgResourceUrl(Constant.Resource.RoleElement), heroCfg.Elements), self.elementImg:GetComponent("Image"), function()
				LuaUtility.SetImageNativeSizeWithGameObject(self.elementImg)
			end)
			self.BreachStar:GetComponent("SimpleStarComponent"):UpdateView(5, heroCfg.Quality)
		end
	end
end

function m:ShowEffect(quality)
	local soundCid = 50002005

	if quality == 5 then
		self.fxJin.gameObject:SetActive(true)

		soundCid = 50002006
	elseif quality == 4 then
		self.fxZi.gameObject:SetActive(true)
	elseif quality == 3 then
		self.fxLan.gameObject:SetActive(true)
	end

	LuaUtility.PlaySoundWithID(soundCid)
end

function m:ShowReplaceItem()
	for i = 1, #self.ReplaceItemList do
		self.ReplaceItemList[i]:SetActive(false)
	end

	self.ReplaceParent:SetActive(true)

	local itemIndex = 0
	local obj

	if #self.itemData.itemShowPODs > 0 and self.itemData.itemShowPODs[1].cid ~= self.itemData.srcId then
		itemIndex = itemIndex + 1
		obj = self.ReplaceItemList[itemIndex]

		if obj == nil then
			obj = UnityEngine.Object.Instantiate(self.ReplaceItemPrefab)

			obj.transform:SetParent(self.ReplaceParent.transform, false)

			self.ReplaceItemList[itemIndex] = obj
		end

		obj:SetActive(true)
		self:SetReplaceItemData(obj, self.itemData.itemShowPODs[1])
	end

	ForArray(self.itemData.tokens, function(_index, _tokenData)
		itemIndex = itemIndex + _index

		local itemView = self.ReplaceItemList[itemIndex]

		if itemView == nil then
			itemView = UnityEngine.Object.Instantiate(self.ReplaceItemPrefab)

			itemView.transform:SetParent(self.ReplaceParent.transform, false)

			self.ReplaceItemList[itemIndex] = itemView
		end

		itemView:SetActive(true)
		self:SetTokenItemData(itemView, _tokenData)
	end)
end

function m:SetTokenItemData(obj, tokenData)
	local titleText = obj.transform:Find("TitleText").gameObject
	local countText = obj.transform:Find("CountText").gameObject

	UGUIUtil.SetText(titleText, LotteryUIApi:GetTokenItemText())
	UGUIUtil.SetText(countText, LotteryUIApi:GetRepeatText(2, tokenData.num))
	self:LoadImg(UIGlobalApi.GetIconPath(CfgItemTable[tokenData.cid].Icon), obj.transform:Find("Icon"):GetComponent("Image"))
end

function m:SetReplaceItemData(obj, data)
	local titletext = obj.transform:Find("TitleText").gameObject
	local counttext = obj.transform:Find("CountText").gameObject

	UGUIUtil.SetText(titletext, LotteryUIApi:GetRepeatText(1))
	UGUIUtil.SetText(counttext, LotteryUIApi:GetRepeatText(2, data.num))
	self:LoadImg(UIGlobalApi.GetIconPath(CfgItemTable[data.cid].Icon), obj.transform:Find("Icon"):GetComponent("Image"))
end

function m:LoadImg(path, imgcom)
	AssetUtil.LoadImage(self, path, imgcom, self.LoadImageSucessCallBack, nil, imgcom)
end

function m:LoadImageSucessCallBack(assetName, asset, duration, userData)
	userData:SetNativeSize()
end

function m:Show()
	self:ResetStatus()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.showEffect, false)
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:SetCloseDelegate(closeDelegate)
	self.OnCloseDelegate = closeDelegate
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
