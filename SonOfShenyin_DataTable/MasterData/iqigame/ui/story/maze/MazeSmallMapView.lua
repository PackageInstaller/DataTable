-- chunkname: @IQIGame\\UI\\Story\\Maze\\MazeSmallMapView.lua

local MazeSmallMapView = {}
local scaling = 0.5
local MazeSmallMapItemViewClass = require("IQIGame.UI.Story.Maze.MazeSmallMapItemView")

function MazeSmallMapView.New(go, mainView)
	local o = Clone(MazeSmallMapView)

	o:Initialize(go, mainView)

	return o
end

function MazeSmallMapView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.lastInRoomID = 0

	self:InitMember()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
	self:LoadMap()
end

function MazeSmallMapView:InitMember()
	self.mapObjectList = {}
	self.mapViewList = {}
	self.smallMapItemViewList = {}
end

function MazeSmallMapView:InitComponent()
	return
end

function MazeSmallMapView:InitDelegate()
	function self.OnMapContentClickDelegate()
		self:OnMapContentClick()
	end

	function self.GoNextRoomEvent()
		self:Refresh()
	end

	function self.RefreshExploreEvent()
		self:RefreshExplore()
	end
end

function MazeSmallMapView:AddListener()
	EventDispatcher.AddEventListener(EventID.MazeStageGoNextRoomEvent, self.GoNextRoomEvent)
	EventDispatcher.AddEventListener(EventID.MazeRefreshExploreEvent, self.RefreshExploreEvent)
end

function MazeSmallMapView:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.MazeStageGoNextRoomEvent, self.GoNextRoomEvent)
	EventDispatcher.RemoveEventListener(EventID.MazeRefreshExploreEvent, self.RefreshExploreEvent)
end

function MazeSmallMapView:OnDestroy()
	self:RemoveListener()

	for i, v in pairs(self.smallMapItemViewList) do
		v:OnDestroy()
	end

	self.smallMapItemViewList = {}

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function MazeSmallMapView:OnMapContentClick()
	self.mainView:ShowBigMap()
end

function MazeSmallMapView:Refresh()
	for _, v in pairs(self.smallMapItemViewList) do
		v:Refresh()
	end

	self:SetPlayerPos()
end

function MazeSmallMapView:SetPlayerPos()
	local currentRoomID = MazeStageModule.GetCurrentRoomID()

	if self.lastInRoomID == currentRoomID then
		return
	end

	local view = self.smallMapItemViewList[currentRoomID]

	if not view then
		return
	end

	if self.currentPlayerInMap then
		self.currentPlayerInMap:SetPlayerOut()
	end

	view:SetPlayerIn()

	self.currentPlayerInMap = view

	LuaUtility.SetToTargetUICenter(self.currentPlayerInMap:GetPosition(), self.mapContentRect)

	self.lastInRoomID = currentRoomID
end

function MazeSmallMapView:LoadMap()
	if self.mapPrefab then
		GameObject.Destroy(self.mapPrefab)

		self.mapPrefab = nil
	end

	local cfgMazeStage = CfgUtil.GetCfgMazeStageDataWithID(MazeStageModule.GetMazeStageID())

	AssetUtil.LoadAsset(self, cfgMazeStage.StageMapPath, self._OnLoadMapSuccess)
end

function MazeSmallMapView:_OnLoadMapSuccess(_, asset, _, _)
	self.mapPrefab = GameObject.Instantiate(asset, self.mapRoot.transform)

	LuaUtility.SetScaleWithTransform(self.mapPrefab.transform, scaling, scaling, scaling)

	self.mapContentTrans = self.mapPrefab.transform:Find("Viewport/mapContent")
	self.buttonClick = self.mapPrefab.transform:Find("buttonClick")
	self.mapContentRect = self.mapContentTrans:GetComponent("RectTransform")

	self.buttonClick:GetComponent("Button").onClick:AddListener(self.OnMapContentClickDelegate)

	self.mapPrefab:GetComponent("ScrollRect").enabled = false
	self.mapPrefabRect = self.mapPrefab:GetComponent("RectTransform")
	self.mapPrefabRectSizeDeltaX = self.mapPrefabRect.sizeDelta.x
	self.mapPrefabRectSizeDeltaY = self.mapPrefabRect.sizeDelta.y

	local len = LuaUtility.GetChildCount(self.mapContentTrans)

	for i = 1, len do
		local o = LuaUtility.GetChild(self.mapContentTrans, i - 1).gameObject
		local roomID = tonumber(o.name)

		if not roomID then
			logError(string.format("【迷宫】地图预制中的房间物体 name = %s的物体不是房间命名", o.name))

			break
		end

		local view = self:_GetItem(roomID)

		view:Initialize(o, roomID)
	end

	self:Refresh()
end

function MazeSmallMapView:_GetItem(roomID)
	if not self.smallMapItemViewList[roomID] then
		self.smallMapItemViewList[roomID] = MazeSmallMapItemViewClass.New(self)
	end

	return self.smallMapItemViewList[roomID]
end

function MazeSmallMapView:GetLastInRoomID()
	return self.lastInRoomID
end

return MazeSmallMapView
