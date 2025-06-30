-- chunkname: @IQIGame\\UI\\Lottery\\LotteryResultDisplayItemCell.lua

local LotteryResultDisplayItemCell = {}

function LotteryResultDisplayItemCell.New(view)
	local obj = Clone(LotteryResultDisplayItemCell)

	obj:__Init(view)

	return obj
end

function LotteryResultDisplayItemCell:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)

	if self.goldLight ~= nil then
		self.goldLight.gameObject:SetActive(false)
	end

	self:__InitDelegate()
	self:__AddListeners()
end

function LotteryResultDisplayItemCell:__InitDelegate()
	function self.delegateOnShowTips()
		self:__ShowTips()
	end

	function self.delegateOnOpenResultDetailsPanel()
		self:__OpenResultDetailsPanel()
	end
end

function LotteryResultDisplayItemCell:__ShowTips()
	if self.itemCfg.ItemTypes == Constant.ItemType.Skill then
		ItemModule.OpenTipByCid(self.itemCfg.Id, true, true, nil)
	elseif self.itemCfg.ItemTypes == Constant.ItemType.Equip then
		ItemModule.OpenTipByCid(self.itemCfg.Id, true, true, nil)
	elseif self.itemCfg.ItemTypes == Constant.ItemType.Item then
		ItemModule.OpenTipByCid(self.itemCfg.Id, true, true, nil)
	end
end

function LotteryResultDisplayItemCell:__OpenResultDetailsPanel()
	UIModule.Open(Constant.UIControllerName.DetailsPreviewUI, Constant.UILayer.UI, {
		type = self.detailsType,
		cid = self.itemCfg.LikeId
	})
end

function LotteryResultDisplayItemCell:__AddListeners()
	self.view:GetComponent("Button").onClick:AddListener(self.delegateOnOpenResultDetailsPanel)
end

function LotteryResultDisplayItemCell:__RemoveListeners()
	self.view:GetComponent("Button").onClick:RemoveListener(self.delegateOnOpenResultDetailsPanel)
end

function LotteryResultDisplayItemCell:Show(drawResultData)
	self:HideGoldLightEffect()
	self.view.gameObject:SetActive(true)

	self.drawResultData = drawResultData
	self.itemCfg = CfgItemTable[self.drawResultData.srcId]
	self.isHeroType = self.itemCfg.ItemTypes == Constant.ItemType.Hero
	self.isSkillType = self.itemCfg.ItemTypes == Constant.ItemType.Skill
	self.isDebrisType = self.itemCfg.ItemTypes == Constant.ItemType.HeroDebris
	self.isDestinyseatType = self.itemCfg.ItemTypes == Constant.ItemType.Item and self.itemCfg.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.Item].LifeCore

	if self.itemCfg.ItemTypes == Constant.ItemType.Skill then
		self.detailsType = Constant.ItemType.Skill
	else
		self.detailsType = Constant.ItemType.Hero
	end

	self:__RefreshShow()
end

function LotteryResultDisplayItemCell:__RefreshShow()
	LuaCodeInterface.SetGameObjectShow(self.CommonItem, true)
	LuaCodeInterface.SetGameObjectShow(self.DebrisItem, false)
	LuaCodeInterface.SetGameObjectShow(self.RepeatItem, false)
	LuaCodeInterface.SetGameObjectShow(self.heroRepeatItem, false)
	LuaCodeInterface.SetGameObjectShow(self.heroDebrisItem, false)
	LuaCodeInterface.SetGameObjectShow(self.skillMask, self.isSkillType)
	LuaCodeInterface.SetGameObjectShow(self.Tag, self.drawResultData.itemShowPODs[1].tag == 1)
	LuaCodeInterface.SetGameObjectShow(self.HeroImg, self.isHeroType)
	LuaCodeInterface.SetGameObjectShow(self.SkillImg, not self.isHeroType)
	LuaCodeInterface.SetGameObjectShow(self.HeroElement, self.isHeroType)
	LuaCodeInterface.SetGameObjectShow(self.HeroPerofession, self.isHeroType)
	LuaCodeInterface.SetGameObjectShow(self.HeroPerofession, self.isHeroType)
	LuaCodeInterface.SetGameObjectShow(self.TotalCount, false)

	if self.isHeroType then
		self:__RefreshHeroData()
	elseif self.isSkillType then
		self:__RefreshItemData()
	else
		self:__RefreshDebrisData()
	end

	if self.itemCfg.Quality >= 5 then
		coroutine.start(function()
			coroutine.wait(CfgUtil.publicParametersData.lotteryResultGlodBoxTime)
			self:__PlaySSREffect()
		end)
	end
end

function LotteryResultDisplayItemCell:__RefreshHeroData()
	self.showTipsItemCid = nil

	local herocid = self.itemCfg.ActionParams[1]
	local herocfg = CfgHeroTable[herocid]
	local path = SkinModule.GetHeroDefaultSkinImgPath(herocid, Constant.SkinImageType.HeroLotteryResources)
	local rectTrans = self.HeroImg:GetComponent("RectTransform")

	rectTrans.anchoredPosition = Vector2.New(0.4, -178.4)

	self:__LoadImgWithSetNativeSize(path, self.HeroImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, string.format(CfgUtil.GetCfgResourceUrl(Constant.Resource.RoleElement), herocfg.Elements), self.HeroElement:GetComponent("Image"))
	AssetUtil.LoadImage(self, string.format(CfgUtil.GetCfgResourceUrl(Constant.Resource.LotteryQuality), herocfg.Quality), self.HeroFrame:GetComponent("Image"))

	path = LotteryUIApi:GetHeroProfessionImg(2, herocfg.Profession)

	self:__LoadImgWithSetNativeSize(path, self.HeroPerofession:GetComponent("Image"))
	UGUIUtil.SetText(self.HeroName, herocfg.Name)
	self.HeroStar:GetComponent("SimpleStarComponent"):UpdateView(herocfg.Quality, 0)

	local itemData = GetArrayValue(self.drawResultData.itemShowPODs, 1, nil)
	local token = GetArrayValue(self.drawResultData.tokens, 1, nil)

	if itemData ~= nil and token ~= nil and itemData.cid == token.cid then
		self:__RefreshRepeatItem(token, itemData.num)

		return
	end

	if itemData ~= nil then
		self:__RefreshRepeatItem(itemData, 0)
	end

	if token ~= nil then
		self:__RefreshDebrisItem(token, 0)
	end
end

function LotteryResultDisplayItemCell:__RefreshRepeatItem(itemPOD, addNum)
	LuaCodeInterface.SetGameObjectShow(self.heroRepeatItem, true)

	local itemCfg = CfgItemTable[itemPOD.cid]

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(itemCfg.Icon), self.heroRepeatImg:GetComponent("Image"))

	local totalNum = itemPOD.num + addNum

	UGUIUtil.SetText(self.heroRepeatNumText, "+" .. totalNum)
end

function LotteryResultDisplayItemCell:__RefreshDebrisItem(itemPOD, addNum)
	LuaCodeInterface.SetGameObjectShow(self.heroDebrisItem, true)

	local itemCfg = CfgItemTable[itemPOD.cid]

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(itemCfg.Icon), self.heroDebrisImg:GetComponent("Image"))

	local totalNum = itemPOD.num + addNum

	UGUIUtil.SetText(self.heroDebrisNumText, "+" .. totalNum)
end

function LotteryResultDisplayItemCell:__RefreshItemData()
	LuaUtility.SetText(self.HeroName, self.itemCfg.Name)
	AssetUtil.LoadImage(self, string.format(CfgUtil.GetCfgResourceUrl(Constant.Resource.LotteryQuality), self.itemCfg.Quality), self.HeroFrame:GetComponent("Image"))
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.itemCfg.BigIcon), self.SkillImg:GetComponent("Image"), function()
		LuaUtility.SetImageNativeSizeWithGameObject(self.SkillImg)
	end)
	self.HeroStar:GetComponent("SimpleStarComponent"):UpdateView(self.itemCfg.Quality, 0)

	local token = GetArrayValue(self.drawResultData.tokens, 1, nil)

	if token ~= nil then
		self:__RefreshRepeatItem(token, 0)
	end
end

function LotteryResultDisplayItemCell:__RefreshDebrisData()
	LuaUtility.SetText(self.HeroName, self.itemCfg.Name)
	AssetUtil.LoadImage(self, string.format(CfgUtil.GetCfgResourceUrl(Constant.Resource.LotteryQuality), self.itemCfg.Quality), self.HeroFrame:GetComponent("Image"))
	LuaCodeInterface.SetGameObjectShow(self.HeroImg, true)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.itemCfg.Icon), self.HeroImg:GetComponent("Image"), function()
		local imageComponent = self.HeroImg:GetComponent("Image")

		imageComponent:SetNativeSize()

		local rectTrans = self.HeroImg:GetComponent("RectTransform")

		rectTrans.anchoredPosition = Vector2.New(7, -110)
	end)
	self.HeroStar:GetComponent("SimpleStarComponent"):UpdateView(self.itemCfg.Quality, 0)

	local cnt = self.drawResultData.itemShowPODs[1].num

	if cnt > 1 then
		LuaCodeInterface.SetGameObjectShow(self.TotalCount, true)

		self.TotalCount:GetComponent("Text").text = "+" .. self.drawResultData.itemShowPODs[1].num
	end
end

function LotteryResultDisplayItemCell:__RefreshDebrisInfo()
	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(self.itemCfg.Icon), self.DebrisImg:GetComponent("Image"))
	LuaUtility.SetText(self.DebrisHeroNameText, self.itemCfg.Name)
	LuaUtility.SetText(self.numText, self.drawResultData.itemShowPODs[1].num)
end

function LotteryResultDisplayItemCell:__LoadImgWithSetNativeSize(path, imgcom)
	AssetUtil.LoadImage(self, path, imgcom, self.__LoadImageSucessCallBack, nil, imgcom)
end

function LotteryResultDisplayItemCell:__LoadImageSucessCallBack(assetName, asset, duration, userData)
	userData:SetNativeSize()
end

function LotteryResultDisplayItemCell:__PlaySSREffect()
	if not self.effectSSR then
		local effectObject = GameObject.Instantiate(self.effectSSRResult, self.view.transform)

		LuaUtility.SetAnchoredPositionWithRectTransform(effectObject.transform:GetComponent("RectTransform"), 0, 0)
		LuaUtility.SetGameObjectShow(effectObject, false)
		LuaUtility.SetGameObjectShow(effectObject, true)

		self.effectSSR = effectObject
	else
		LuaUtility.SetGameObjectShow(self.effectSSR, true)
	end

	self:ShowGoldLightEffect()
end

function LotteryResultDisplayItemCell:Hide()
	self.view.gameObject:SetActive(false)
	self:HideGoldLightEffect()
end

function LotteryResultDisplayItemCell:IsFree()
	return not self.view.gameObject.activeSelf
end

function LotteryResultDisplayItemCell:Dispose()
	if self.effectSSR ~= nil then
		GameObject.Destroy(self.effectSSR)

		self.effectSSR = nil
	end

	self:__RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

function LotteryResultDisplayItemCell:HideGoldLightEffect()
	if self.goldLight ~= nil then
		self.goldLight.gameObject:SetActive(false)
	end

	if self.effectSSR ~= nil then
		LuaCodeInterface.SetGameObjectShow(self.effectSSR, false)
	end
end

function LotteryResultDisplayItemCell:ShowGoldLightEffect()
	if self.goldLight == nil then
		return
	end

	self.goldLight.gameObject:SetActive(true)
end

return LotteryResultDisplayItemCell
