-- chunkname: @IQIGame\\UI\\HomeLandChooseCastleUI.lua

local HomeLandChooseCastleUI = Base:Extend("HomeLandChooseCastleUI", "IQIGame.Onigao.UI.HomeLandChooseCastleUI", {
	isCreate = false,
	isHideUI = false,
	isMoveEnterRoom = false,
	roomBubbles = {},
	buildBubbles = {},
	visitHelpBubbles = {}
})
local WeatherTimeUI = require("IQIGame.UI.Common.WeatherTimeUI")
local HomeLandChooseRoomView = require("IQIGame.UI.HomeLand.HomeLandChooseRoomView")
local HomeLandFunView = require("IQIGame.UI.HomeLand.HomeLandFunView")
local HomeLandVisitCastleView = require("IQIGame.UI.HomeLand.HomeLandVisitCastleView")
local HomeLandRoomBubbleCell = require("IQIGame.UI.HomeLand.HomeLandRoomBubbleCell")
local HomeLandBuildBubbleCell = require("IQIGame.UI.HomeLand.HomeLandBuildBubbleCell")
local HomeLandChooseGuideView = require("IQIGame.UI.HomeLand.HomeLandChooseGuideView")
local HomeLandHelpBtnCell = require("IQIGame.UI.HomeLandVisit.HomeLandHelpBtnCell")
local HomeLandPlantTipView = require("IQIGame.UI.HomeLand.HomeLandPlantTipView")

function HomeLandChooseCastleUI:OnInit()
	self.canvas = self.UIController:GetComponent("Canvas")

	UGUIUtil.SetText(self.TextTitle, HomeLandChooseCastleApi:GetString("TextTitle"))

	self.btnBackComponent = self.BtnBack:GetComponent("Button")
	self.btnHideUIComponent = self.BtnHideUI:GetComponent("Button")

	function self.delegateOnBtnBack()
		self:OnClickBackBtn()
	end

	function self.delegateUpDateWeather()
		self:OnUpdateWeather()
	end

	function self.delegateUpdateBaseInfo()
		self:UpDataView()
	end

	function self.delegateMoveCameraEndEventArgs(sender, args)
		self:OnMoveCameraEnd(sender, args)
	end

	function self.delegateHomelandEnterRoomEventArgs(sender, args)
		self:OnStartEnterRoom(sender, args)
	end

	function self.delegateHomeLandQuickHarvestEvent()
		self:OnQuickHarvest()
	end

	function self.delegateOnFinishedAchievement()
		self:OnFinishedAchievement()
	end

	function self.delegateOnBtnHideUI()
		self:OnBtnHideUI()
	end

	function self.delegateHomeLandVisitEvent()
		self:OnHomeLandVisitEvent()
	end

	function self.delegateBtnGuide()
		self:OnBtnGuide()
	end

	function self.delegateOnUpdateItem()
		self:OnUpdateItem()
	end

	function self.delegateUpdateTownAreaEvent()
		self:OnUpdateTownAreaEvent()
	end

	self.weatherTimeUI = WeatherTimeUI.New(self.WeatherMould)
	self.homelandChooseRoomView = HomeLandChooseRoomView.__New(self.ChooseRoom, self.RootUI)
	self.homeLandFunView = HomeLandFunView.__New(self.FunList, self.RootUI)
	self.visitCastleView = HomeLandVisitCastleView.__New(self.VisitCastleView)
	self.guideView = HomeLandChooseGuideView.__New(self.GuideUIView, self.RootUI)
	self.plantTipView = HomeLandPlantTipView.New(self.PlantTimeTipView, self)
end

function HomeLandChooseCastleUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandChooseCastleUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandChooseCastleUI:OnOpen(userData)
	self.isOpenFunctionUI = false
	self.isCreate = false

	self:UpDataView()
	self.homelandChooseRoomView:Open()
	self.homeLandFunView:Open()

	self.timer = Timer.New(function()
		self.isTimeOut = true

		self:ResetBubble()
	end, 5)
	self.isTimeOut = false
	self.isHideUI = false

	self:OnBtnHideUI()
	self.plantTipView:Open()
end

function HomeLandChooseCastleUI:OnClose(userData)
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.homelandChooseRoomView:Close()
	self.homeLandFunView:Close()
	self.visitCastleView:Close()
	self.guideView:Close()
	self.plantTipView:Close()
end

function HomeLandChooseCastleUI:OnAddListeners()
	self.btnBackComponent.onClick:AddListener(self.delegateOnBtnBack)
	self.btnHideUIComponent.onClick:AddListener(self.delegateOnBtnHideUI)
	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.delegateBtnGuide)
	GameEntry.LuaEvent:Subscribe(HomelandMoveCameraEndEventArgs.EventId, self.delegateMoveCameraEndEventArgs)
	GameEntry.LuaEvent:Subscribe(HomelandEnterRoomEventArgs.EventId, self.delegateHomelandEnterRoomEventArgs)
	EventDispatcher.AddEventListener(EventID.HomeLandUpdateBaseInfo, self.delegateUpdateBaseInfo)
	EventDispatcher.AddEventListener(EventID.UpdateWeather, self.delegateUpDateWeather)
	EventDispatcher.AddEventListener(EventID.HomeLandQuickHarvestEvent, self.delegateHomeLandQuickHarvestEvent)
	EventDispatcher.AddEventListener(EventID.FinishedAchievement, self.delegateOnFinishedAchievement)
	EventDispatcher.AddEventListener(EventID.HomeLandVisitEvent, self.delegateHomeLandVisitEvent)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.delegateOnUpdateItem)
	EventDispatcher.AddEventListener(EventID.UpdateTownAreaEvent, self.delegateUpdateTownAreaEvent)
end

function HomeLandChooseCastleUI:OnRemoveListeners()
	self.btnBackComponent.onClick:RemoveListener(self.delegateOnBtnBack)
	self.btnHideUIComponent.onClick:RemoveListener(self.delegateOnBtnHideUI)
	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGuide)
	GameEntry.LuaEvent:Unsubscribe(HomelandMoveCameraEndEventArgs.EventId, self.delegateMoveCameraEndEventArgs)
	GameEntry.LuaEvent:Unsubscribe(HomelandEnterRoomEventArgs.EventId, self.delegateHomelandEnterRoomEventArgs)
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdateBaseInfo, self.delegateUpdateBaseInfo)
	EventDispatcher.RemoveEventListener(EventID.UpdateWeather, self.delegateUpDateWeather)
	EventDispatcher.RemoveEventListener(EventID.HomeLandQuickHarvestEvent, self.delegateHomeLandQuickHarvestEvent)
	EventDispatcher.RemoveEventListener(EventID.FinishedAchievement, self.delegateOnFinishedAchievement)
	EventDispatcher.RemoveEventListener(EventID.HomeLandVisitEvent, self.delegateHomeLandVisitEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.delegateOnUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.UpdateTownAreaEvent, self.delegateUpdateTownAreaEvent)
end

function HomeLandChooseCastleUI:OnPause()
	return
end

function HomeLandChooseCastleUI:OnResume()
	return
end

function HomeLandChooseCastleUI:OnCover()
	return
end

function HomeLandChooseCastleUI:OnReveal()
	return
end

function HomeLandChooseCastleUI:OnRefocus(userData)
	return
end

function HomeLandChooseCastleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.isCreate == false and HomeLandLuaModule.isCreate then
		self.isCreate = true

		self:CreateTipData()
		self.timer:Start()
	end

	self.guideView:OnUpdate(elapseSeconds, realElapseSeconds)
	self.homelandChooseRoomView:OnUpdate(elapseSeconds, realElapseSeconds)
	self.plantTipView:OnUpdate(elapseSeconds, realElapseSeconds)

	for i, v in pairs(self.roomBubbles) do
		v:UpdatePos()
	end

	for i, v in pairs(self.buildBubbles) do
		v:UpdatePos()
	end

	for i, v in pairs(self.visitHelpBubbles) do
		v:UpdatePos()
	end
end

function HomeLandChooseCastleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandChooseCastleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandChooseCastleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandChooseCastleUI:OnDestroy()
	self.weatherTimeUI:Dispose()
	self.homeLandFunView:Dispose()
	self.visitCastleView:Dispose()
	self.homelandChooseRoomView:Dispose()
	self.guideView:Dispose()
	self.plantTipView:Dispose()

	for i, v in pairs(self.roomBubbles) do
		v:Dispose()
	end

	self.roomBubbles = {}

	for i, v in pairs(self.buildBubbles) do
		v:Dispose()
	end

	self.buildBubbles = {}

	for i, v in pairs(self.visitHelpBubbles) do
		v:Dispose()
	end

	self.visitHelpBubbles = {}

	AssetUtil.UnloadAsset(self)
end

function HomeLandChooseCastleUI:OnUpdateWeather()
	self.weatherTimeUI:SetData(WeatherModule.currentWeatherCid, PlayerModule.GetServerTime())
end

function HomeLandChooseCastleUI:OnBtnHideUI()
	self.isHideUI = not self.isHideUI

	self.Weather:SetActive(self.isHideUI)
	self.TitlePanel:SetActive(self.isHideUI)
	self.ChooseRoom:SetActive(self.isHideUI)
	self.FunList:SetActive(self.isHideUI)
	self.VisitCastleView:SetActive(self.isHideUI and HomeLandLuaModule.isVisitHome)
	self.GuideUIView:SetActive(self.isHideUI and not HomeLandLuaModule.isVisitHome)
end

function HomeLandChooseCastleUI:UpDataView()
	if HomeLandLuaModule.isVisitHome then
		self.visitCastleView:Open()
		self.OBjName:SetActive(true)
		self.guideView:Close()
		UGUIUtil.SetText(self.TextVisitHomeLandName, HomeLandChooseCastleApi:GetString("TextVisitHomeLandName", HomeLandLuaModule.homeLandBaseInfo.pname))
	else
		self.OBjName:SetActive(false)
		self.visitCastleView:Close()
		self.guideView:Open()
	end

	self.weatherTimeUI:SetData(WeatherModule.currentWeatherCid, PlayerModule.GetServerTime())
end

function HomeLandChooseCastleUI:OnStartEnterRoom(sender, args)
	self.isMoveEnterRoom = true
end

function HomeLandChooseCastleUI:OnMoveCameraEnd(sender, args)
	self.isMoveEnterRoom = false

	if args.IsEnterRoom then
		HomeLandLuaModule.currentEnterRoomID = args.RoomID
	else
		HomeLandLuaModule.currentEnterRoomID = 0
	end

	HomeLandLuaModule.cameraPosition = args.Position
	HomeLandLuaModule.cameraSize = args.Size

	local isInRoom = args.IsEnterRoom
	local isCanShow = self:CheckIsShowUI()

	if isInRoom == true and args.RoomID > 0 then
		local cfgRoom = CfgHomeLandRoomTable[args.RoomID]

		if #cfgRoom.UnlockBuilding > 0 then
			local goRoom = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. cfgRoom.RoomIndex .. "/RoomUIObj").gameObject

			for i = 0, goRoom.transform.childCount - 1 do
				local o = goRoom.transform:GetChild(i).gameObject

				UnityEngine.GameObject.DestroyImmediate(o)
			end
		end

		if cfgRoom.CastleIndex == 2 then
			GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandChooseCastleUI, false)
			UIModule.Open(Constant.UIControllerName.HomeLandRoomUI, Constant.UILayer.UI)
		elseif cfgRoom.CastleIndex == 3 then
			GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandChooseCastleUI, false)
			UIModule.Open(Constant.UIControllerName.HomeLandWorkRoomUI, Constant.UILayer.UI)
		else
			GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandChooseCastleUI, isCanShow)
		end
	else
		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandChooseCastleUI, isCanShow)
		self.RootUI:SetActive(true)
		EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseRoomUI")

		if args.RoomID > 0 then
			local cfgRoom = CfgHomeLandRoomTable[args.RoomID]

			if cfgRoom and cfgRoom.CastleIndex == 3 then
				UIModule.Open(Constant.UIControllerName.HomeLandWorkListUI, Constant.UILayer.UI, {
					Constant.HomelandBuildType.BuildWork,
					HLWorkModule.decorate
				})
			end
		end
	end

	if not HomeLandLuaModule.isVisitHome then
		self.guideView:OnDragIng()
	end
end

function HomeLandChooseCastleUI:ResetBubble()
	self.timer:Stop()
	self:CreateTipData()
end

function HomeLandChooseCastleUI:CreateTipData()
	self.unLockRoomDic = TownModule.GetHomeLandUnLockRooms()
	self.buildFunDic = {}

	for i, v in pairs(Constant.HomelandRoomFunDecorates) do
		local cfgDecorate = CfgHomeLandDecorateTable[v]

		if cfgDecorate.FunctionBuilding > 0 then
			local belongRoom = CfgHomeLandBuildingTable[cfgDecorate.FunctionBuilding].BelongRoom
			local object = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. belongRoom .. "/Objects/decorate_" .. v)

			if object then
				local homeLandBuildingData = HomeLandLuaModule.GetBuildingDataByID(cfgDecorate.FunctionBuilding)
				local isGetReward = homeLandBuildingData:IsGetReward(v)
				local isEmptyQueue = homeLandBuildingData:IsEmptyQueue()

				if isGetReward or isEmptyQueue and not self.isTimeOut then
					if self.buildFunDic[belongRoom] == nil then
						self.buildFunDic[belongRoom] = {}
					end

					table.insert(self.buildFunDic[belongRoom], v)
				end
			end
		end
	end

	self.visitFunDic = {}

	self:ChangeTipView()
end

function HomeLandChooseCastleUI:OnUpdateTownAreaEvent()
	self:CreateTipData()
end

function HomeLandChooseCastleUI:OnQuickHarvest()
	self:CreateTipData()
end

function HomeLandChooseCastleUI:OnHomeLandVisitEvent()
	self:CreateTipData()
end

function HomeLandChooseCastleUI:OnUpdateItem()
	self:CreateTipData()
end

function HomeLandChooseCastleUI:ChangeTipView()
	if HomeLandLuaModule.isCreate == false then
		return
	end

	if UnityEngine.GameObject.Find("Root") == nil then
		return
	end

	for i, v in pairs(self.roomBubbles) do
		v:Dispose()
	end

	self.roomBubbles = {}

	for i, v in pairs(self.buildBubbles) do
		v:Dispose()
	end

	self.buildBubbles = {}

	for i, v in pairs(self.visitHelpBubbles) do
		v:Dispose()
	end

	self.visitHelpBubbles = {}

	self.TipView:SetActive(true)

	if HomeLandLuaModule.isVisitHome then
		for i, v in pairs(self.visitFunDic) do
			for k, v1 in pairs(v) do
				local obj = UnityEngine.Object.Instantiate(self.VisitBubbleMould)

				obj:SetActive(true)
				obj.transform:SetParent(self.TipView.transform, false)

				local visitBubble = HomeLandHelpBtnCell.__New(obj)

				visitBubble:SetData(i, v1, self.canvas)

				self.visitHelpBubbles[v1] = visitBubble
			end
		end
	else
		for i, v in pairs(self.unLockRoomDic) do
			local obj

			if v.threadType == 1 then
				obj = UnityEngine.Object.Instantiate(self.RoomBubbleMould2)
			elseif v.threadType == 2 then
				obj = UnityEngine.Object.Instantiate(self.RoomBubbleMould1)
			end

			if obj then
				obj:SetActive(true)
				obj.transform:SetParent(self.TipView.transform, false)

				local tipCell = HomeLandRoomBubbleCell.New(obj)

				tipCell:SetData(v, self.canvas)

				self.roomBubbles[v.cfgTownEvent.RoomId] = tipCell
			end
		end

		for i, v in pairs(self.buildFunDic) do
			for k, v1 in pairs(v) do
				local obj = UnityEngine.Object.Instantiate(self.BuildingBubbleMould)

				obj:SetActive(true)
				obj.transform:SetParent(self.TipView.transform, false)

				local tipCell = HomeLandBuildBubbleCell.New(obj)

				tipCell:SetData(i, v1, self.canvas)

				self.buildBubbles[v1] = tipCell
			end
		end

		self.plantTipView:ChangePlant()
	end
end

function HomeLandChooseCastleUI:OnClickBackBtn()
	if self.isMoveEnterRoom then
		return
	end

	local cameraSize = HomeLandLuaModule.cameraSize

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		cameraSize = UnityEngine.Camera.main.orthographicSize
	end

	if cameraSize == 34 then
		HomeLandLuaModule.ExitHome()
	elseif HomeLandLuaModule.currentEnterRoomID > 0 then
		GameEntry.LuaEvent:Fire(nil, HomelandQuitRoomEventArgs():Fill(HomeLandLuaModule.currentEnterRoomID))
	else
		GameEntry.LuaEvent:Fire(nil, HomelandLookObjEventArgs():Fill(HomeLandChooseCastleApi:GetString("QuitCameraPosition"), HomeLandChooseCastleApi:GetString("QuitCameraSize")))
	end
end

function HomeLandChooseCastleUI:OnFinishedAchievement()
	NoticeModule.CheckNeedShowQueueTip()
end

function HomeLandChooseCastleUI:OnBtnGuide()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 4000)
end

function HomeLandChooseCastleUI:CheckIsShowUI()
	local uiName = {
		Constant.UIControllerName.HomeLandCookingUI,
		Constant.UIControllerName.HomeLandAlchemyUI,
		Constant.UIControllerName.HomeLandMakeItemListUI,
		Constant.UIControllerName.HomeLandManufactureUI
	}

	for i, v in pairs(uiName) do
		if UIModule.HasUI(v) then
			return false
		end
	end

	return true
end

return HomeLandChooseCastleUI
