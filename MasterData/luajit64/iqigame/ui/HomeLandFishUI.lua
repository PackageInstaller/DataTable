-- chunkname: @IQIGame\\UI\\HomeLandFishUI.lua

local HomeLandFishUI = {
	startTime = 0,
	FishEffectPlayId = 0,
	SoundPackageId = 0
}

HomeLandFishUI = Base:Extend("HomeLandFishUI", "IQIGame.Onigao.UI.HomeLandFishUI", HomeLandFishUI)

local WeatherTimeUI = require("IQIGame.UI.Common.WeatherTimeUI")
local GoFishingView = require("IQIGame.UI.Fishing.GoFishingView")

function HomeLandFishUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, HomeLandFishUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.BtnBookLabel, HomeLandFishUIApi:GetString("BtnBookLabel"))
	UGUIUtil.SetText(self.BtnShopLabel, HomeLandFishUIApi:GetString("BtnShopLabel"))
	UGUIUtil.SetText(self.BtnBagLabel, HomeLandFishUIApi:GetString("BtnBagLabel"))
	UGUIUtil.SetText(self.BtnAngleLabel, HomeLandFishUIApi:GetString("BtnAngleLabel"))
	UGUIUtil.SetText(self.BtnFishLabel, HomeLandFishUIApi:GetString("BtnFishLabel"))

	self.tweenLeftButtons = self.LeftButton:GetComponent("TweenPosition")
	self.tweenRightButtons = self.RightButton:GetComponent("TweenPosition")
	self.weatherTimeUI = WeatherTimeUI.New(self.WeatherMould)
	self.goFishingView = GoFishingView.New(self.GoFishingView, self)

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnGuide()
		self:OnBtnGuide()
	end

	function self.delegateBtnBook()
		self:OnBtnBook()
	end

	function self.delegateBtnShop()
		self:OnBtnShop()
	end

	function self.delegateBtnBag()
		self:OnBtnBag()
	end

	function self.delegateBtnAngle()
		self:OnBtnAngle()
	end

	function self.delegateBtnFish()
		self:OnBtnFish()
	end

	function self.delegateBtnAutoFish()
		self:OnBtnAutoFish()
	end

	function self.delegateUpDateWeather()
		self:OnUpdateWeather()
	end

	function self.delegateStartGoFishEvent(cfgRod, cfgBait, fishId)
		self:OnStartGoFishEvent(cfgRod, cfgBait, fishId)
	end

	function self.delegatePlayFishEffectEvent(cid, num)
		self:OnPlayFishEffect(cid, num)
	end

	function self.delegateAutoFishState()
		self:OnAutoFishState()
	end
end

function HomeLandFishUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandFishUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandFishUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandFishUI:GetBGM(userData)
	return nil
end

function HomeLandFishUI:OnOpen(userData)
	self.openType = userData.openType
	self.startTime = PlayerModule.GetServerTime()

	self:HideAllBuoyEffect()
	self:UpDateView()
end

function HomeLandFishUI:OnClose(userData)
	if self.SoundPackageId and self.SoundPackageId ~= 0 then
		SoundPackagePlayer.Remove(self.SoundPackageId)
	end

	self.SoundPackageId = 0

	self.goFishingView:Close()
	self:StopFishEffect()
end

function HomeLandFishUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.delegateBtnGuide)
	self.BtnBook:GetComponent("Button").onClick:AddListener(self.delegateBtnBook)
	self.BtnShop:GetComponent("Button").onClick:AddListener(self.delegateBtnShop)
	self.BtnBag:GetComponent("Button").onClick:AddListener(self.delegateBtnBag)
	self.BtnAngle:GetComponent("Button").onClick:AddListener(self.delegateBtnAngle)
	self.BtnFish:GetComponent("Button").onClick:AddListener(self.delegateBtnFish)
	self.BtnAutoFish:GetComponent("Button").onClick:AddListener(self.delegateBtnAutoFish)
	EventDispatcher.AddEventListener(EventID.UpdateWeather, self.delegateUpDateWeather)
	EventDispatcher.AddEventListener(EventID.StartGoFishEvent, self.delegateStartGoFishEvent)
	EventDispatcher.AddEventListener(EventID.PlayFishEffectEvent, self.delegatePlayFishEffectEvent)
	EventDispatcher.AddEventListener(EventID.UpdateAutoFishStateEvent, self.delegateAutoFishState)
end

function HomeLandFishUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGuide)
	self.BtnBook:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBook)
	self.BtnShop:GetComponent("Button").onClick:RemoveListener(self.delegateBtnShop)
	self.BtnBag:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBag)
	self.BtnAngle:GetComponent("Button").onClick:RemoveListener(self.delegateBtnAngle)
	self.BtnFish:GetComponent("Button").onClick:RemoveListener(self.delegateBtnFish)
	self.BtnAutoFish:GetComponent("Button").onClick:RemoveListener(self.delegateBtnAutoFish)
	EventDispatcher.RemoveEventListener(EventID.UpdateWeather, self.delegateUpDateWeather)
	EventDispatcher.RemoveEventListener(EventID.StartGoFishEvent, self.delegateStartGoFishEvent)
	EventDispatcher.RemoveEventListener(EventID.PlayFishEffectEvent, self.delegatePlayFishEffectEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateAutoFishStateEvent, self.delegateAutoFishState)
end

function HomeLandFishUI:OnPause()
	return
end

function HomeLandFishUI:OnResume()
	return
end

function HomeLandFishUI:OnCover()
	return
end

function HomeLandFishUI:OnReveal()
	return
end

function HomeLandFishUI:OnRefocus(userData)
	return
end

function HomeLandFishUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if FishingModule.isAutoFish then
		local passTime = PlayerModule.GetServerTime()

		if passTime - self.startTime > 1 then
			self.startTime = passTime

			self:RefreshAutoFishCD()
		end
	end
end

function HomeLandFishUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandFishUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandFishUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandFishUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.weatherTimeUI:Dispose()
	self.goFishingView:Dispose()
end

function HomeLandFishUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandFishUI)
end

function HomeLandFishUI:OnAutoFishState()
	self:RefreshAutoFish()
end

function HomeLandFishUI:UpDateView()
	self:OnUpdateWeather()

	if self.openType == 1 then
		self.goFishingView:Close()
	elseif self.openType == 2 then
		local cfgRod, cfgBait

		for i, v in pairsCfg(CfgFishingGearListTable) do
			if v.ItemID == FishingModule.fishingData.rodId then
				cfgRod = v
			elseif v.ItemID == FishingModule.fishingData.baitId then
				cfgBait = v
			end
		end

		self:OnStartGoFishEvent(cfgRod, cfgBait, FishingModule.fishingData.fishId)
	end

	self:RefreshAutoFish()
end

function HomeLandFishUI:RefreshAutoFish()
	local isRed = FishingModule.CheckAutoFishRed()

	self.AutoFishRedPoint:SetActive(isRed)
	self:RefreshAutoFishCD()
end

function HomeLandFishUI:RefreshAutoFishCD()
	local cd = FishingModule.fishingData.countdown / 1000 - PlayerModule.GetServerTime()

	self.AutoFishNode:SetActive(cd > 0)
	UGUIUtil.SetText(self.TextAutoFishTime, GetFormatTime(cd))
end

function HomeLandFishUI:OnUpdateWeather()
	self.weatherTimeUI:SetData(WeatherModule.currentWeatherCid, PlayerModule.GetServerTime())
	self:LoadWeatherBG()
end

function HomeLandFishUI:OnStartGoFishEvent(cfgRod, cfgBait, fishId)
	self.goFishingView:Open(cfgRod, cfgBait, fishId)
end

function HomeLandFishUI:LoadWeatherBG()
	local cfgWeather = CfgMainCityWeatherTable[WeatherModule.currentWeatherCid]
	local weatherIndex = WeatherModule.periodOfTime
	local performanceID = cfgWeather.Performance[weatherIndex]
	local cfgPerformance = CfgMainCityWeatherPerformanceTable[performanceID]
	local prefabPath = UIGlobalApi.GetPrefabRoot(cfgPerformance.FishUiPrefab)

	AssetUtil.LoadAsset(self, prefabPath, self.OnLoadWeatherSucceed, nil, self)

	local package = WeatherBGMModule.GetFishBgmPackage()

	if package then
		if self.SoundPackageId and self.SoundPackageId ~= 0 then
			SoundPackagePlayer.Replace(self.SoundPackageId, package)
		else
			self.SoundPackageId = SoundPackagePlayer.Add(package)
		end
	end
end

function HomeLandFishUI:OnLoadWeatherSucceed(assetName, asset, duration, userData)
	local self = userData

	for i = 0, self.WeatherBG.transform.childCount - 1 do
		local obj = self.WeatherBG.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local go = UnityEngine.Object.Instantiate(asset)

	go:SetActive(true)
	go.transform:SetParent(self.WeatherBG.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponentInParent(typeof(UnityEngine.Canvas)), go)
end

function HomeLandFishUI:ShowOrHideButtons(top)
	self.tweenLeftButtons:ResetToBeginning()
	self.tweenRightButtons:ResetToBeginning()

	self.tweenLeftButtons.enabled = top
	self.tweenRightButtons.enabled = top

	if top then
		self.tweenLeftButtons:PlayForward()
		self.tweenRightButtons:PlayForward()
	end
end

function HomeLandFishUI:HideAllBuoyEffect()
	self.EffectBuoy01:SetActive(false)
	self.EffectBuoy02:SetActive(false)
end

function HomeLandFishUI:ShowBuoyEffect(type)
	self:HideAllBuoyEffect()

	if type == 1 then
		self.EffectBuoy01:SetActive(true)
	elseif type == 2 then
		self.EffectBuoy02:SetActive(true)
	end
end

function HomeLandFishUI:OnPlayFishEffect(cid, num)
	self:StopFishEffect()

	local cfgData

	for i, v in pairsCfg(CfgFishingGearListTable) do
		if v.ItemID == cid then
			cfgData = v

			break
		end
	end

	if cfgData.FishingUIEffect > 0 then
		self.FishEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(cfgData.FishingUIEffect, 50000, 0, self.FishEffect, self.UIController:GetComponent("Canvas").sortingOrder + 10)

		local timer = Timer.New(function()
			self:StopFishEffect()
			FishingModule.IllegalFishing(cid, num)
			self:ShowOrHideButtons(false)
		end, 1.5)

		timer:Start()
		self:ShowOrHideButtons(true)
	else
		FishingModule.IllegalFishing(cid, num)
	end
end

function HomeLandFishUI:StopFishEffect()
	if self.FishEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.FishEffectPlayId)
	end

	self.FishEffectPlayId = 0
end

function HomeLandFishUI:OnBtnGuide()
	return
end

function HomeLandFishUI:OnBtnBook()
	UIModule.Open(Constant.UIControllerName.HomeLandFishCollectionUI, Constant.UILayer.UI)
end

function HomeLandFishUI:OnBtnShop()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.FishingShop)
end

function HomeLandFishUI:OnBtnBag()
	UIModule.Open(Constant.UIControllerName.HomeLandFishBagUI, Constant.UILayer.UI)
end

function HomeLandFishUI:OnBtnAngle()
	UIModule.Open(Constant.UIControllerName.HomeLandFishChooseUI, Constant.UILayer.UI, {
		OpenType = 1,
		AutoFishing = false
	})
end

function HomeLandFishUI:OnBtnAutoFish()
	if FishingModule.CheckAutoFishRed() then
		FishingModule.DrawRewards()
	else
		if FishingModule.isAutoFish then
			NoticeModule.ShowNotice(21042048)

			return
		end

		UIModule.Open(Constant.UIControllerName.HomeLandFishChooseUI, Constant.UILayer.UI, {
			OpenType = 1,
			AutoFishing = true
		})
	end
end

function HomeLandFishUI:OnBtnFish()
	if FishingModule.isFishing then
		return
	end

	UIModule.Open(Constant.UIControllerName.HomeLandFishChooseUI, Constant.UILayer.UI, {
		OpenType = 2,
		AutoFishing = false
	})
end

return HomeLandFishUI
