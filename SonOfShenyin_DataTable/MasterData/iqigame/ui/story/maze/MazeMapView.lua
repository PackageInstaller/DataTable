-- chunkname: @IQIGame\\UI\\Story\\Maze\\MazeMapView.lua

local MazeMapView = {}
local MazeSmallMapItemViewClass = require("IQIGame.UI.Story.Maze.MazeSmallMapItemView")

function MazeMapView.New(go, mainView)
	local o = Clone(MazeMapView)

	o:Initialize(go, mainView)

	return o
end

function MazeMapView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.isZoom = false

	self:InitMember()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
	self:LoadMap()
end

function MazeMapView:InitMember()
	self.smallMapItemViewList = {}
end

function MazeMapView:InitComponent()
	self.imageHead = self.playerHead:GetComponent("Image")
end

function MazeMapView:InitDelegate()
	function self.delegateOnClickButtonClose()
		self:OnClickButtonClose()
	end

	function self.delegateOnClickButtonZoom()
		self:OnClickButtonZoom()
	end
end

function MazeMapView:AddListener()
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
	self.buttonZoom:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonZoom)
end

function MazeMapView:RemoveListener()
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
	self.buttonZoom:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonZoom)
end

function MazeMapView:OnClickButtonZoom()
	self.isZoom = not self.isZoom

	if self.isZoom then
		LuaUtility.SetScaleWithTransform(self.mapContentTrans, 0.5, 0.5, 0.5)
		self:SetPlayerPos()
	else
		LuaUtility.SetScaleWithTransform(self.mapContentTrans, 1, 1, 1)
		self:SetPlayerPos()
	end
end

function MazeMapView:OnDestroy()
	self:RemoveListener()

	for _, v in pairs(self.smallMapItemViewList) do
		v:OnDestroy()
	end

	self.smallMapItemViewList = {}

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function MazeMapView:Open()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function MazeMapView:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function MazeMapView:OnClickButtonClose()
	self:Close()
end

function MazeMapView:Refresh()
	for _, v in pairs(self.smallMapItemViewList) do
		v:Refresh()
	end

	self:SetPlayerPos()
	self:RefreshExplore()
	LuaUtility.LoadImage(self, ChapterStageMapUIApi:GetPlayerHeroImagePath(PlayerModule.GetSex()), self.imageHead)
end

function MazeMapView:RefreshExplore()
	local value = StoryModule.GetExtensionParam(Constant.MazeExploreProgress).value

	if value == -1 then
		value = 0
	end

	LuaUtility.SetText(self.textExploration, value .. "%")
end

function MazeMapView:SetPlayerPos()
	local currentRoomID = MazeStageModule.GetCurrentRoomID()
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

	local currentPosMap = self.currentPlayerInMap.transform.position

	LuaUtility.SetPositionWithGameObject(self.playerHead, currentPosMap.x, currentPosMap.y, currentPosMap.z)

	local localPos = self.playerHead.transform.localPosition

	LuaUtility.SetLocalPositionWithGameObject(self.playerHead, localPos.x - 40, localPos.y, localPos.z)
end

function MazeMapView:LoadMap()
	if self.mapPrefab then
		GameObject.Destroy(self.mapPrefab)

		self.mapPrefab = nil
	end

	local cfgMazeStage = CfgUtil.GetCfgMazeStageDataWithID(MazeStageModule.GetMazeStageID())

	AssetUtil.LoadAsset(self, cfgMazeStage.StageMapPath, self._OnLoadMapSuccess)
end

function MazeMapView:_OnLoadMapSuccess(_, asset, _, _)
	self.mapPrefab = GameObject.Instantiate(asset, self.mapRoot.transform)

	self.mapPrefab.transform:SetSiblingIndex(0)

	self.mapContentTrans = self.mapPrefab.transform:Find("Viewport/mapContent")
	self.mapContentRect = self.mapContentTrans:GetComponent("RectTransform")

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

	self.playerHead.transform:SetParent(self.mapContentTrans)
end

function MazeMapView:_GetItem(roomID)
	if not self.smallMapItemViewList[roomID] then
		self.smallMapItemViewList[roomID] = MazeSmallMapItemViewClass.New(self)
	end

	return self.smallMapItemViewList[roomID]
end

function MazeMapView:GetLastInRoomID()
	return 0
end

return MazeMapView
