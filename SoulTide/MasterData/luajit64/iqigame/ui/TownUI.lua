-- chunkname: @IQIGame\\UI\\TownUI.lua

local TownUI = Base:Extend("TownUI", "IQIGame.Onigao.UI.TownUI", {})
local TownAreaCell = require("IQIGame.UI.Town.TownAreaCell")
local WeatherTimeUI = require("IQIGame.UI.Common.WeatherTimeUI")

function TownUI:OnInit()
	self:Init()
end

function TownUI:GetPreloadAssetPaths()
	return nil
end

function TownUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function TownUI:OnOpen(userData)
	self.moneyCell:RefreshView({
		Constant.ItemID.MONEY,
		Constant.ItemID.TREASURE,
		Constant.ItemID.VACATION_TIME
	})
	self:UpdateView()
	self:OnUpdateWeather()
	self:CheckAndSetSlotPos()
	self:OnUnlockNotify()
	self:OnRedPoint(Constant.RedType.TYPE_LIBRARY)
end

function TownUI:OnClose(userData)
	for i, v in pairs(self.areaCellDic) do
		v:Close()
	end
end

function TownUI:OnPause()
	return
end

function TownUI:OnResume()
	return
end

function TownUI:OnCover()
	return
end

function TownUI:OnReveal()
	return
end

function TownUI:OnRefocus(userData)
	return
end

function TownUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TownUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TownUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TownUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TownUI:OnDestroy()
	self.weatherTimeUI:Dispose()
	self.moneyCell:Dispose()

	self.moneyCell = nil

	for i, v in pairs(self.areaCellDic) do
		v:OnDestroy()
	end

	AssetUtil.UnloadAsset(self)
end

function TownUI:Init()
	self.BtnLibraryText1:GetComponent("Text").text = MainUIApi:GetString("HankBookBtnText", 1)
	self.BtnLibraryText2:GetComponent("Text").text = MainUIApi:GetString("HankBookBtnText", 2)

	UGUIUtil.SetText(self.TextTitle, TownUIApi:GetString("TextTitleName"))

	self.btnBackComponent = self.BtnBack:GetComponent("Button")
	self.weatherTimeUI = WeatherTimeUI.New(self.WeatherTime.transform:GetChild(0).gameObject)

	function self.delegateClickBtnBack()
		self:OnBtnBack()
	end

	function self.delegateSelectedArea(cell)
		self:OnSelectedArea(cell)
	end

	function self.delegateUpdateTownPanel()
		self:UpdateView()
	end

	function self.delegateUpDateWeather()
		self:OnUpdateWeather()
	end

	function self.delegateUpdateTownAreaEvent()
		self:OnUpdateTownAreaEvent()
	end

	function self.delegateOnFinishedAchievement()
		self:OnFinishedAchievement()
	end

	function self.delegateBtnLibrary()
		self:OnBtnLibrary()
	end

	function self.delegateOnUnlockNotify()
		self:OnUnlockNotify()
	end

	function self.delegateOnServerRedPoint(type, server)
		self:OnRedPoint(type, server)
	end

	self.moneyCell = MoneyCellsBuilder.New(self.CurrencyContainer)
end

function TownUI:OnAddListeners()
	self.btnBackComponent.onClick:AddListener(self.delegateClickBtnBack)
	self.BtnLibrary:GetComponent("Button").onClick:AddListener(self.delegateBtnLibrary)
	EventDispatcher.AddEventListener(EventID.UpdateTownPanel, self.delegateUpdateTownPanel)
	EventDispatcher.AddEventListener(EventID.UpdateWeather, self.delegateUpDateWeather)
	EventDispatcher.AddEventListener(EventID.UpdateTownAreaEvent, self.delegateUpdateTownAreaEvent)
	EventDispatcher.AddEventListener(EventID.FinishedAchievement, self.delegateOnFinishedAchievement)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.delegateOnUnlockNotify)
	EventDispatcher.AddEventListener(EventID.RedServerNotice, self.delegateOnServerRedPoint)
end

function TownUI:OnRemoveListeners()
	self.btnBackComponent.onClick:RemoveListener(self.delegateClickBtnBack)
	self.BtnLibrary:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLibrary)
	EventDispatcher.RemoveEventListener(EventID.UpdateTownPanel, self.delegateUpdateTownPanel)
	EventDispatcher.RemoveEventListener(EventID.UpdateWeather, self.delegateUpDateWeather)
	EventDispatcher.RemoveEventListener(EventID.UpdateTownAreaEvent, self.delegateUpdateTownAreaEvent)
	EventDispatcher.RemoveEventListener(EventID.FinishedAchievement, self.delegateOnFinishedAchievement)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.delegateOnUnlockNotify)
	EventDispatcher.RemoveEventListener(EventID.RedServerNotice, self.delegateOnServerRedPoint)
end

function TownUI:UpdateView()
	if self.areaCellDic ~= nil then
		for i, v in pairs(self.areaCellDic) do
			v:OnDestroy()
		end
	end

	self.areaCellDic = {}

	for i = 0, self.Events.transform.childCount - 1 do
		local obj = self.Events.transform:GetChild(0).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	local mould = self.EventMould

	mould:SetActive(false)

	for k, v in pairs(TownModule.townAreaDic) do
		local go = UnityEngine.Object.Instantiate(mould)

		go.name = tostring(v.cfgID)

		go:SetActive(true)
		go.transform:SetParent(self.Events.transform, false)

		local pos = v.cfgInfo.SiteIconPosition

		go.transform.localPosition = Vector3.New(pos[1], pos[2], pos[3])

		local areaCell = TownAreaCell.New(go)

		areaCell:SetItem(v)

		areaCell.clickCallBack = self.delegateSelectedArea

		table.insert(self.areaCellDic, areaCell)
	end

	self.weatherTimeUI:SetData(WeatherModule.currentWeatherCid, PlayerModule.GetServerTime())
end

function TownUI:OnUpdateTownAreaEvent()
	if self.areaCellDic ~= nil then
		for i, v in pairs(self.areaCellDic) do
			v:Refresh()
		end
	end
end

function TownUI:OnUpdateWeather()
	self.weatherTimeUI:SetData(WeatherModule.currentWeatherCid, PlayerModule.GetServerTime())
	self:LoadWeatherBG()
end

function TownUI:LoadWeatherBG()
	local cfgWeather = CfgMainCityWeatherTable[WeatherModule.currentWeatherCid]
	local weatherIndex = WeatherModule.periodOfTime
	local performanceID = cfgWeather.Performance[weatherIndex]
	local cfgPerformance = CfgMainCityWeatherPerformanceTable[performanceID]
	local url = cfgPerformance.TownPrefab
	local prefabPath = UIGlobalApi.UIPath .. url

	AssetUtil.LoadAsset(self, prefabPath, self.OnLoadWeatherSucceed, nil, self)
end

function TownUI:OnLoadWeatherSucceed(assetName, asset, duration, userData)
	local self = userData

	for i = 0, self.Weather.transform.childCount - 1 do
		local obj = self.Weather.transform:GetChild(0).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	local go = UnityEngine.Object.Instantiate(asset)

	go:SetActive(true)

	for i = 0, go.transform.childCount - 1 do
		local sortedCom = go.transform:GetChild(i).gameObject:GetComponent("SortedComponentOrder")

		if sortedCom ~= nil then
			sortedCom.UIRootCanvas = self.TownUI:GetComponent("Canvas")
		end
	end

	go.transform:SetParent(self.Weather.transform, false)
end

function TownUI:OnSelectedArea(cell)
	if cell.townAreaData and cell.townAreaData:IsUnlockFunction() == true then
		if cell.townAreaData.cfgInfo.Id == 10080 then
			UIModule.Open(Constant.UIControllerName.TownAreaUI, Constant.UILayer.UI, cell.townAreaData)
		else
			UIModule.Open(Constant.UIControllerName.TownAreaUI, Constant.UILayer.UI, cell.townAreaData)
		end
	else
		NoticeModule.ShowNoticeByType(1, TownUIApi:GetString("Error1"))
	end
end

function TownUI:OnBtnBack()
	net_town.exitTown()
	SceneManager.ChangeScene(SceneID.MainCity)
end

function TownUI:OnFinishedAchievement()
	NoticeModule.CheckNeedShowQueueTip()
end

function TownUI:CheckAndSetSlotPos()
	local townAreaData

	for k, v in pairs(TownModule.townAreaDic) do
		for k1, v1 in ipairs(v.townFunDic) do
			if v1.cfgTownEvent ~= nil then
				townAreaData = v

				break
			end
		end
	end

	if townAreaData == nil then
		for k, v in pairs(TownModule.townAreaDic) do
			if v.cfgID == 10050 then
				townAreaData = v

				break
			end
		end
	end

	if townAreaData then
		local pos = Vector2.New(townAreaData.cfgInfo.ShowLocation, 0)

		self.Grid.transform.anchoredPosition = pos
	end
end

function TownUI:OnUnlockNotify()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.LIBRARY)

	self.BtnLibrary:SetActive(false)
end

function TownUI:OnRedPoint(type, show)
	if type == Constant.RedType.TYPE_LIBRARY then
		local top = RedModule.IsServerRed(Constant.RedType.TYPE_LIBRARY)
		local libraryRedPoint = self.BtnLibrary.transform:Find("Image_RedPoint").gameObject

		libraryRedPoint:SetActive(false)
	end
end

function TownUI:OnBtnLibrary()
	TownLibraryModule.OpenLibrary(function()
		UIModule.Open(Constant.UIControllerName.LibraryUI, Constant.UILayer.UI)
	end)
end

return TownUI
