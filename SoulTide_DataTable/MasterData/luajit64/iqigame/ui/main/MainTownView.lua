-- chunkname: @IQIGame\\UI\\Main\\MainTownView.lua

local MainTownView = {
	branchLinePos = 0,
	mainLinePos = 0,
	areaCellDic = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local WeatherTimeUI = require("IQIGame.UI.Common.WeatherTimeUI")
local TownAreaCell = require("IQIGame.UI.Town.TownAreaCell")
local CameraCtrl = require("IQIGame.Scene.TownArea.CameraCtrl")

function MainTownView.__New(ui, parent)
	local o = Clone(MainTownView)

	o:InitView(ui, parent)

	return o
end

function MainTownView:InitView(ui, parent)
	self.rootUI = ui
	self.rootParent = parent

	LuaCodeInterface.BindOutlet(self.rootUI, self)
	self.EventMould:SetActive(false)

	self.areaCellPool = UIObjectPool.New(15, function()
		local areaCell = TownAreaCell.New(UnityEngine.Object.Instantiate(self.EventMould), self.rootParent.UIController:GetComponent("Canvas"))

		return areaCell
	end, function(cell)
		cell:OnDestroy()
	end)
	self.weatherTimeUI = WeatherTimeUI.New(self.WeatherTime.transform:GetChild(0).gameObject)

	function self.delegateUpDateWeather()
		self:OnUpdateWeather()
	end

	function self.delegateUpdateTownAreaEvent()
		self:OnUpdateTownAreaEvent()
	end

	function self.delegateOnTapTownAreaEventArgs(sender, args)
		self:OnTownAreaTapGesture(sender, args)
	end

	function self.delegateOnClickTip()
		self:OnClickTip()
	end

	function self.delegateOnClickMainNotice()
		self:OnClickMainNotice()
	end

	function self.delegateOnClickBranchNotice()
		self:OnClickBranchNotice()
	end

	self.cameraCtrl = CameraCtrl.New()
	self.cameraCtrl.speedAutoMove = MainUIApi:GetString("SpeedAutoMove")
	self.cameraCtrl.speedMove = MainUIApi:GetString("SpeedMove")
	self.cameraCtrl.speedAutoMoveToTarget = 3
end

function MainTownView:AddEventListener()
	self:RemoveEventListener()
	EventDispatcher.AddEventListener(EventID.UpdateWeather, self.delegateUpDateWeather)
	EventDispatcher.AddEventListener(EventID.UpdateTownAreaEvent, self.delegateUpdateTownAreaEvent)
	self.TimesView:GetComponent("Button").onClick:AddListener(self.delegateOnClickTip)
	self.LeftMainLine:GetComponent("Button").onClick:AddListener(self.delegateOnClickMainNotice)
	self.LeftBranchLine:GetComponent("Button").onClick:AddListener(self.delegateOnClickBranchNotice)
	self.RightMainLine:GetComponent("Button").onClick:AddListener(self.delegateOnClickMainNotice)
	self.RightBranchLine:GetComponent("Button").onClick:AddListener(self.delegateOnClickBranchNotice)
	GameEntry.LuaEvent:Subscribe(TownAreaTapGestureEventArgs.EventId, self.delegateOnTapTownAreaEventArgs)
end

function MainTownView:RemoveEventListener()
	EventDispatcher.RemoveEventListener(EventID.UpdateWeather, self.delegateUpDateWeather)
	EventDispatcher.RemoveEventListener(EventID.UpdateTownAreaEvent, self.delegateUpdateTownAreaEvent)
	self.TimesView:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickTip)
	self.LeftMainLine:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickMainNotice)
	self.LeftBranchLine:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickBranchNotice)
	self.RightMainLine:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickMainNotice)
	self.RightBranchLine:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickBranchNotice)
	GameEntry.LuaEvent:Unsubscribe(TownAreaTapGestureEventArgs.EventId, self.delegateOnTapTownAreaEventArgs)
end

function MainTownView:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.cameraCtrl ~= nil then
		self.cameraCtrl:OnUpdate()
	end
end

function MainTownView:Dispose()
	self:RemoveEventListener()
	self.weatherTimeUI:Dispose()

	if self.cameraCtrl then
		self.cameraCtrl:OnDestroy()
	end

	for i, v in pairs(self.areaCellDic) do
		self.areaCellPool:Release(v)
	end

	self.areaCellDic = {}

	self.areaCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function MainTownView:OnCameraChangePos()
	if self.areaCellDic ~= nil then
		self.mainLinePos = 0
		self.branchLinePos = 0
		self.mainLineCell = nil
		self.branchLineCell = nil

		for i, v in pairs(self.areaCellDic) do
			v:UpdatePos()

			if v.outScreenType ~= 0 then
				if v.townFunctionData1 then
					self.mainLinePos = v.outScreenType
					self.mainLineCell = v
				end

				if v.townFunctionData2 then
					self.branchLinePos = v.outScreenType
					self.branchLineCell = v
				end
			end
		end

		self:ChangeHideNotice()
	end
end

function MainTownView:ChangeHideNotice()
	self.LeftMainLine:SetActive(self.mainLinePos == -1)
	self.LeftBranchLine:SetActive(self.branchLinePos == -1)
	self.RightMainLine:SetActive(self.mainLinePos == 1)
	self.RightBranchLine:SetActive(self.branchLinePos == 1)
end

function MainTownView:OnClickMainNotice()
	self:MovieToCell(self.mainLineCell)
end

function MainTownView:OnClickBranchNotice()
	self:MovieToCell(self.branchLineCell)
end

function MainTownView:MovieToCell(cell)
	if cell then
		local deltaX = 0

		if cell.v_v3.x < 0 then
			deltaX = -10
		elseif cell.v_v3.x > UnityEngine.Screen.width then
			deltaX = 10
		end

		local p = cell:ScreenToWorldPoint()
		local pos = Vector2.New(p.x + deltaX, 0)

		self.cameraCtrl:StartAutoMoveToTarget(pos, true)
	end
end

function MainTownView:UpDateView()
	for i, v in pairs(self.areaCellDic) do
		v.goView.transform:SetParent(self.rootUI.transform, false)
		v.goView:SetActive(false)
		self.areaCellPool:Release(v)
	end

	self.areaCellDic = {}

	for k, v in pairs(TownModule.townAreaDic) do
		local areaCell = self.areaCellPool:Obtain()

		areaCell.goView.transform:SetParent(self.Events.transform, false)
		areaCell.goView:SetActive(true)
		areaCell:SetItem(v)
		table.insert(self.areaCellDic, areaCell)
	end

	self:RefreshTimes()
	self.weatherTimeUI:SetData(WeatherModule.currentWeatherCid, PlayerModule.GetServerTime())
	self:UnlockNotify()
end

function MainTownView:RefreshGuildRed(top)
	for i, v in pairs(self.areaCellDic) do
		if v.townAreaData.cfgID == 10110 then
			v:SetGuildRedPoint(top)
		end
	end
end

function MainTownView:UnlockNotify()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.SHOPPING)

	self.TimesView:SetActive(result)
	TownModule.RefreshGuildState()
end

function MainTownView:OnUpdateTownAreaEvent()
	if self.areaCellDic ~= nil then
		for i, v in pairs(self.areaCellDic) do
			v:Refresh()
		end
	end

	self:RefreshTimes()
	self.rootParent:OnUpdatePoint()
	self:OnCameraChangePos()
end

function MainTownView:OnUpdateWeather()
	self.weatherTimeUI:SetData(WeatherModule.currentWeatherCid, PlayerModule.GetServerTime())
end

function MainTownView:OnTownAreaTapGesture(sender, args)
	local cid = args.Cid

	if cid == 10080 then
		HomeLandLuaModule.EnterHome()
	elseif cid == 10110 then
		GuildModule.OpenGuild()
	else
		local townAreaData = TownModule.GetTownAreaData(cid)

		TownAreaModule.EnterArea(townAreaData)
	end
end

function MainTownView:RefreshTimes()
	local totalTimes = CfgPlayerLevelTable[PlayerModule.PlayerInfo.baseInfo.pLv].RestTime
	local curTimes = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.VACATION_TIME)

	UGUIUtil.SetText(self.goTimes, TownAreaUIApi:GetString("times", curTimes, totalTimes))
end

function MainTownView:OnClickTip()
	UIModule.Open(Constant.UIControllerName.MoneyPanelInfoUI, Constant.UILayer.UI, {
		Constant.ItemID.VACATION_TIME,
		self.TimesView.transform
	})
end

function MainTownView:Open()
	self:AddEventListener()
	self.rootUI:SetActive(true)
	self:UpDateView()

	local minPos, maxPos = MainUIApi:GetString("CameraPos")
	local orthographicSize = MainUIApi:GetString("MainCityOrthographicSize")
	local pos = UnityEngine.Camera.main.transform.position

	self.cameraCtrl:Refresh(pos.x, minPos, maxPos, UnityEngine.Camera.main, orthographicSize)

	function self.cameraCtrl.cameraChangePosCallBack()
		self:OnCameraChangePos()
	end

	self:OnCameraChangePos()
end

function MainTownView:Close()
	self:RemoveEventListener()
	self.rootUI:SetActive(false)

	if self.cameraCtrl then
		self.cameraCtrl:OnDestroy()
	end
end

return MainTownView
