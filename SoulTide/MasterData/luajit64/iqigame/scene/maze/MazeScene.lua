-- chunkname: @IQIGame\\Scene\\Maze\\MazeScene.lua

local m = {
	MoveToNodeIdAfterConfirm = 0,
	VisibleNodeMaxY = 0,
	TotalAssetNum = 0,
	IsActive = true,
	IsPlayingMoveCameraAnimation = false,
	VisibleNodeMinX = 0,
	RELEASE_RANGE_Y = 12,
	VisibleNodeMinY = 0,
	FIRST_ENTER_GUIDE_ID = 0,
	ScrollStageLoadComplete = false,
	LoadedAssetNum = 0,
	RELEASE_RANGE_X = 16,
	MoveArriveOrderNotConfirmed = false,
	LOAD_RANGE_Y = 8,
	DefaultUIOpened = false,
	LOAD_RANGE_X = 12,
	InitMaze = false,
	VisibleNodeMaxX = 0,
	MazePrepared = false,
	CameraFollowHero = false,
	BgLoadComplete = false,
	Elements = {},
	Nodes = {},
	NodeMap = {},
	Paths = {},
	GOInsIDControllerMap = {},
	WaitForLoadNodes = {},
	MoveCheckNodes = {}
}
local MazeNode = require("IQIGame.Scene.Maze.MazeNode")
local MazePath = require("IQIGame.Scene.Maze.MazePath")
local MazeElement = require("IQIGame.Scene.Maze.MazeElement")
local MazeHero = require("IQIGame.Scene.Maze.MazeHero")
local MazeInputManager = require("IQIGame.Scene.Maze.Input.MazeInputManager")
local MazeSceneAnimation = require("IQIGame.Scene.Maze.Animation.MazeSceneAnimation")
local ScrollMazeStage = require("IQIGame.Scene.Maze.ScrollMazeStage")

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	function self.DelegateOnLoadEntityComplete(controller, type)
		self:OnLoadEntityComplete(controller, type)
	end

	function self.DelegateOnAddElement(mazeElementPOD)
		self:OnAddElement(mazeElementPOD)
	end

	function self.DelegateOnNodeUpdate(nodeData, isNewActive)
		self:OnNodeUpdate(nodeData, isNewActive)
	end

	function self.DelegateOnGuideChangeState(id, step, type)
		self:OnGuideChangeState(id, step, type)
	end

	function self.DelegateOnElementNodeChange(elementId, fromNodeId, toNodeId)
		self:OnElementNodeChange(elementId, fromNodeId, toNodeId)
	end

	function self.DelegateOnUIBecameVisible(sender, args)
		self:OnUIBecameVisible(sender, args)
	end

	function self.DelegateOnMazeUpdateDoll(changedProps)
		self:OnMazeUpdateDoll(changedProps)
	end

	function self.DelegateOnTimerUpdate()
		self:OnTimerUpdate()
	end

	function self.DelegateOnNotifyMaskManually(gameObject, isRemove)
		self:OnNotifyMaskManually(gameObject, isRemove)
	end

	self:AddEventListeners()

	self.InputMgr = MazeInputManager.New()
	self.StateMachineMgr = StateMachineMgr.New()

	GameEntry.Timer:AddFrameRender(1, self.DelegateOnTimerUpdate, true)

	self.ModelRoot = UnityEngine.GameObject.Find("Root/Model").transform
	self.PathRoot = UnityEngine.GameObject.Find("Root/MaskedArea/Path").transform
	self.NodeRoot = UnityEngine.GameObject.Find("Root/MaskedArea/Node").transform
	self.ElementFootRoot = UnityEngine.GameObject.Find("Root/MaskedArea/ElementFoot").transform
	self.ElementRoot = UnityEngine.GameObject.Find("Root/MaskedArea/Element").transform

	local mainCameraGo = UnityEngine.GameObject.Find("Main Camera")

	self.MainCamera = mainCameraGo:GetComponent("Camera")

	local uiCamera = GameEntry.UICamera

	self.UIEffectCanvas = UnityEngine.GameObject.Find("MazeUIMountPointCanvas")
	self.UIEffectCanvas:GetComponent("Canvas").worldCamera = uiCamera
	self.ConstantMainUIEffectCanvasGo = UnityEngine.GameObject.Find("MazeUIMountPointCanvas")
	self.BgRollingDragDelta = Vector3.zero
	self.Animation = MazeSceneAnimation.New(self)
	self.Mask = mainCameraGo.transform:Find("Mask"):GetComponent(typeof(ToJ.Mask))

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeInit, true)

	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]

	if cfgMazeInstanceData.IsShowAnimation and MazeDataModule.StreamingLoadType == Constant.Maze.StreamingTypeNone and MazeDataModule.IsFirstTimeHere and not MazeDataModule.IsRestoreMaze then
		self:BeforeEnterMazeAnimation()
	end
end

function m:OnTimerUpdate()
	self:Update()
end

function m:Show()
	self.InitMaze = true
	self.DefaultUIOpened = false

	self:InitBGM()
	self:InitBG()
	self:InitScrollStage()
	self:InitHero(function(haveError)
		if not haveError then
			if MazeDataModule.StreamingLoadType ~= Constant.Maze.StreamingTypeNone then
				self:CheckStreamingLoad()
			else
				self:LoadAll()
			end
		else
			local timer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.Maze, function()
				GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.Maze))
				EventDispatcher.Dispatch(EventID.MazeSceneInitialized)
				MazeModule.Prepared()
				MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_START_MAZE)
				EventDispatcher.Dispatch(EventID.MazeMainUITweenShow)
			end, 1)

			timer:Start()
		end
	end)
	self:InitDefaultUI()
end

function m:InitDefaultUI()
	if MazeDataModule.ChapterType == Constant.Maze.ChapterTypeNormal then
		self.DefaultUIName = Constant.UIControllerName.MazeMainUI
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeEndless then
		self.DefaultUIName = Constant.UIControllerName.EndlessMazeMainUI
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeIllusion then
		self.DefaultUIName = Constant.UIControllerName.IllusionMazeMainUI
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeRpg or MazeDataModule.ChapterType == Constant.Maze.ChapterTypeHorizontalRPG or MazeDataModule.ChapterType == Constant.Maze.ChapterTypeHorizontalChallenge then
		self.DefaultUIName = Constant.UIControllerName.RpgMazeMainUI
	elseif MazeDataModule.IsScrollMaze() then
		self.DefaultUIName = Constant.UIControllerName.ScrollMazeMainUI

		UIModule.Open(Constant.UIControllerName.ScrollMazeStageDialogUI, Constant.UILayer.DefaultUI)
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeLunaFort then
		self.DefaultUIName = Constant.UIControllerName.MazeMainUI
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeDualTeamExplore then
		self.DefaultUIName = Constant.UIControllerName.MazeMainUI
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeEndlessPlus then
		self.DefaultUIName = Constant.UIControllerName.EndlessPlusMazeMainUI
	else
		logError("没找到迷宫主界面")
	end

	UIModule.Open(self.DefaultUIName, Constant.UILayer.DefaultUI)
	UIModule.Open(Constant.UIControllerName.MazeStageBubbleUI, Constant.UILayer.DefaultUI)
	UIModule.Open(Constant.UIControllerName.MazeStageDialogUI, Constant.UILayer.DefaultUI)
end

function m:OnUIBecameVisible(sender, args)
	self.DefaultUIOpened = true

	if args.UIName == self.DefaultUIName then
		self:CheckStartExplore()
	end
end

function m:InitHero(onLoad)
	local elementPOD = MazeDataModule.LeaderElementPOD

	self.Hero = MazeHero.New(elementPOD, self.ElementRoot)

	self.Hero:LoadOnInit(onLoad)
end

function m:IsNodeInSteamingArea(areaNodeData)
	local heroX, heroY = self.Hero:GetNodeIndex()
	local minX = heroX - m.LOAD_RANGE_X
	local maxX = heroX + m.LOAD_RANGE_X
	local minY = heroY - m.LOAD_RANGE_Y
	local maxY = heroY + m.LOAD_RANGE_Y
	local heroAreaIx = self.Hero.NodeData.AreaIx

	return MazeDataModule.StreamingLoadType == Constant.Maze.StreamingTypeInScopeAndArea and areaNodeData.AreaIx == heroAreaIx or minX <= areaNodeData.XIndex and maxX >= areaNodeData.XIndex and minY <= areaNodeData.YIndex and maxY >= areaNodeData.YIndex
end

function m:IsNodeOutOfSteamingArea(areaNodeData)
	local heroX, heroY = self.Hero:GetNodeIndex()
	local minX = heroX - m.LOAD_RANGE_X
	local maxX = heroX + m.LOAD_RANGE_X
	local minY = heroY - m.LOAD_RANGE_Y
	local maxY = heroY + m.LOAD_RANGE_Y
	local heroAreaIx = self.Hero.NodeData.AreaIx

	return (MazeDataModule.StreamingLoadType ~= Constant.Maze.StreamingTypeInScopeAndArea or areaNodeData.AreaIx ~= heroAreaIx) and (minX > areaNodeData.XIndex or maxX < areaNodeData.XIndex or minY > areaNodeData.YIndex or maxY < areaNodeData.YIndex)
end

function m:CheckStreamingLoad()
	self:ClearNotIn()

	self.VisibleNodeMinX = 2147483647
	self.VisibleNodeMinY = 2147483647
	self.VisibleNodeMaxX = 0
	self.VisibleNodeMaxY = 0

	local pathNum = 0
	local elementNum = 0

	for nodeId, areaNodeData in pairs(MazeDataModule.MazeMapData.NodeMap) do
		if self:IsNodeInSteamingArea(areaNodeData) then
			if self.NodeMap[areaNodeData.NodeId] == nil then
				local isWaiting = false

				for idxWait = 1, #self.WaitForLoadNodes do
					local loadingNodeData = self.WaitForLoadNodes[idxWait]

					if loadingNodeData.NodeId == areaNodeData.NodeId then
						isWaiting = true

						break
					end
				end

				if not isWaiting then
					table.insert(self.WaitForLoadNodes, areaNodeData)

					for i = 1, #areaNodeData.NextNodes do
						local endNodeDataId = areaNodeData.NextNodes[i]

						if endNodeDataId ~= 0 then
							pathNum = pathNum + 1
						end
					end

					local elementColumn = MazeDataModule.ElementPODGrid[areaNodeData.XIndex + 1]

					if elementColumn ~= nil then
						local elementPODs = elementColumn[areaNodeData.YIndex + 1]

						if elementPODs ~= nil then
							for i = 1, #elementPODs do
								local elementPOD = elementPODs[i]

								if elementPOD.ID ~= MazeDataModule.LeaderElementPOD.ID then
									elementNum = elementNum + 1
								end
							end
						end
					end
				end
			end

			self.VisibleNodeMinX = math.min(self.VisibleNodeMinX, areaNodeData.x)
			self.VisibleNodeMinY = math.min(self.VisibleNodeMinY, areaNodeData.y)
			self.VisibleNodeMaxX = math.max(self.VisibleNodeMaxX, areaNodeData.x)
			self.VisibleNodeMaxY = math.max(self.VisibleNodeMaxY, areaNodeData.y)
		end
	end

	self:SortWaitForLoadNodes()

	self.TotalAssetNum = self.TotalAssetNum + #self.WaitForLoadNodes + pathNum + elementNum
end

function m:SortWaitForLoadNodes()
	local refX = self.Hero.NodeData.XIndex
	local refY = self.Hero.NodeData.YIndex

	table.sort(self.WaitForLoadNodes, function(data1, data2)
		local xOffset1 = refX - data1.XIndex
		local yOffset1 = refY - data1.YIndex
		local xOffset2 = refX - data2.XIndex
		local yOffset2 = refY - data2.YIndex
		local disRef1 = xOffset1 * xOffset1 + yOffset1 * yOffset1
		local disRef2 = xOffset2 * xOffset2 + yOffset2 * yOffset2

		if disRef1 == disRef2 then
			return data1.NodeId < data2.NodeId
		end

		return disRef1 < disRef2
	end)
end

function m:LoadAll()
	for i = 1, #MazeDataModule.MazeMapPathNodes do
		local areaNodeData = MazeDataModule.MazeMapPathNodes[i]
		local assetNum = self:LoadNodeAndRelativeAssets(areaNodeData)

		self.TotalAssetNum = self.TotalAssetNum + assetNum
	end
end

function m:LoadNodeAndRelativeAssets(areaNodeData)
	local assetNum = 1
	local node = MazeNode.New(areaNodeData, self.NodeRoot)

	table.insert(self.Nodes, node)

	self.NodeMap[areaNodeData.NodeId] = node

	local startNodeData = areaNodeData

	for i = 1, #startNodeData.NextNodes do
		local endNodeDataId = startNodeData.NextNodes[i]

		if endNodeDataId ~= 0 then
			local endNodeData = MazeDataModule.GetNodeDataById(endNodeDataId)
			local path = MazePath.New(startNodeData, endNodeData, self.PathRoot)

			node:AddPath(path)

			assetNum = assetNum + 1

			table.insert(self.Paths, path)
		end
	end

	local elementPODs = MazeDataModule.GetElementPODsByNode(areaNodeData.NodeId)

	if elementPODs ~= nil then
		for i = 1, #elementPODs do
			local elementPOD = elementPODs[i]

			if not elementPOD.IsRemoved and elementPOD.ID ~= MazeDataModule.LeaderElementPOD.ID then
				local existElement = self:GetElement(elementPOD.ID)

				if existElement == nil then
					local element = MazeElement.New(elementPOD, self.ElementRoot)

					table.insert(self.Elements, element)

					assetNum = assetNum + 1
				end
			end
		end
	end

	return assetNum
end

function m:OnElementNodeChange(elementId, fromNodeId, toNodeId)
	local areaNodeData = MazeDataModule.GetNodeDataById(toNodeId)
	local isInArea = self:IsNodeInSteamingArea(areaNodeData)

	if isInArea then
		local node = self:GetNode(toNodeId)

		if node ~= nil then
			local mazeElement = self:GetElement(elementId)

			if mazeElement == nil then
				local elementPOD = MazeDataModule.GetElementPOD(elementId)
				local element = MazeElement.New(elementPOD, self.ElementRoot)

				table.insert(self.Elements, element)
			end
		end
	end

	local isOutOfArea = self:IsNodeOutOfSteamingArea(areaNodeData)

	if isOutOfArea then
		local node = self:GetNode(toNodeId)

		if node == nil then
			local mazeElement, index = self:GetElement(elementId)

			if mazeElement ~= nil then
				mazeElement:Dispose()
				table.remove(self.Elements, index)
			end
		end
	end
end

function m:ClearNotIn()
	for i = #self.WaitForLoadNodes, 1, -1 do
		local areaNodeData = self.WaitForLoadNodes[i]

		if self:IsNodeOutOfSteamingArea(areaNodeData) then
			table.remove(self.WaitForLoadNodes, i)
		end
	end

	for nodeI = #self.Nodes, 1, -1 do
		local mazeNode = self.Nodes[nodeI]
		local areaNodeData = mazeNode.NodeData

		if self:IsNodeOutOfSteamingArea(areaNodeData) then
			local elementPODs = MazeDataModule.GetElementPODsByNode(areaNodeData.NodeId)

			if elementPODs ~= nil then
				for elementI = 1, #elementPODs do
					local elementPOD = elementPODs[elementI]
					local element = self:GetElement(elementPOD.ID)

					if element ~= nil then
						element.NeedToRemove = true
					end
				end
			end

			if mazeNode.Paths ~= nil then
				for pathI = 1, #mazeNode.Paths do
					local path = mazeNode.Paths[pathI]

					path.NeedToRemove = true
				end

				mazeNode.Paths = nil
			end

			mazeNode:Dispose()
			table.remove(self.Nodes, nodeI)

			self.NodeMap[areaNodeData.NodeId] = nil
		end
	end

	for i = #self.Elements, 1, -1 do
		local element = self.Elements[i]

		if element.NeedToRemove then
			element:Dispose()
			table.remove(self.Elements, i)
		end
	end

	for i = #self.Paths, 1, -1 do
		local path = self.Paths[i]

		if path.NeedToRemove then
			path:Dispose()
			table.remove(self.Paths, i)
		end
	end
end

function m:BeforeEnterMazeAnimation()
	self.BornNodeNeighbors = {}

	for i = 1, #MazeDataModule.ElementPODs do
		local elementPOD = MazeDataModule.ElementPODs[i]

		if elementPOD.Pid == MazeDataModule.PlayerInfo.BaseInfo.pid then
			local nodeData = MazeDataModule.GetNodeDataById(elementPOD.NodeId)

			for j = 1, #nodeData.NextNodes do
				local nextNodeData = MazeDataModule.GetNodeDataById(nodeData.NextNodes[j])

				table.insert(self.BornNodeNeighbors, nextNodeData)
			end

			break
		end
	end

	for i = 1, #self.BornNodeNeighbors do
		local nodeData = self.BornNodeNeighbors[i]

		nodeData.IsActive = false
	end
end

function m:AddEventListeners()
	EventDispatcher.AddEventListener(EventID.MazeLoadEntityComplete, self.DelegateOnLoadEntityComplete)
	EventDispatcher.AddEventListener(EventID.MazeAddElement, self.DelegateOnAddElement)
	EventDispatcher.AddEventListener(EventID.MazeUpdateNodeData, self.DelegateOnNodeUpdate)
	EventDispatcher.AddEventListener(EventID.GuideChangeState, self.DelegateOnGuideChangeState)
	EventDispatcher.AddEventListener(EventID.MazeElementNodeChange, self.DelegateOnElementNodeChange)
	EventDispatcher.AddEventListener(EventID.MazeUpdateDoll, self.DelegateOnMazeUpdateDoll)
	EventDispatcher.AddEventListener(EventID.MazeNotifyMaskManually, self.DelegateOnNotifyMaskManually)
	GameEntry.LuaEvent:Subscribe(UIBecameVisibleEventArgs.EventId, self.DelegateOnUIBecameVisible)
end

function m:RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeLoadEntityComplete, self.DelegateOnLoadEntityComplete)
	EventDispatcher.RemoveEventListener(EventID.MazeAddElement, self.DelegateOnAddElement)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateNodeData, self.DelegateOnNodeUpdate)
	EventDispatcher.RemoveEventListener(EventID.GuideChangeState, self.DelegateOnGuideChangeState)
	EventDispatcher.RemoveEventListener(EventID.MazeElementNodeChange, self.DelegateOnElementNodeChange)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateDoll, self.DelegateOnMazeUpdateDoll)
	EventDispatcher.RemoveEventListener(EventID.MazeNotifyMaskManually, self.DelegateOnNotifyMaskManually)
	GameEntry.LuaEvent:Unsubscribe(UIBecameVisibleEventArgs.EventId, self.DelegateOnUIBecameVisible)
end

function m:OnLoadEntityComplete(controller, type)
	self.GOInsIDControllerMap[controller.gameObject:GetInstanceID()] = controller

	if controller ~= self.Hero then
		self:CheckLoadComplete(true)
	end
end

function m:RecordBgRollingDragDelta()
	local targetPos = self.Hero:GetCameraFocusPosition()
	local validPosition = self:GetRestrictedCameraPosition(targetPos)

	self.BgRollingDragDelta = targetPos - validPosition
end

function m:MoveCamera(position, isUpdate, isNotMoveOrSet)
	if isNotMoveOrSet then
		self.CameraFollowHero = false
	end

	local validPosition = self:GetRestrictedCameraPosition(position)

	self.MainCamera.transform.position = validPosition
	self.ModelRoot.position = Vector3(validPosition.x, validPosition.y, 0)

	local bgVisualCameraPos

	if isUpdate then
		bgVisualCameraPos = validPosition + self.BgRollingDragDelta
	else
		bgVisualCameraPos = position
	end

	self:RefreshRollingBg(bgVisualCameraPos)
	EventDispatcher.Dispatch(EventID.MazeCameraMove, self.MainCamera.transform.position, isNotMoveOrSet)
end

function m:RefreshRollingBg(bgVisualCameraPos)
	if self.RollingGroundComponent ~= nil then
		self.RollingGroundComponent.value = bgVisualCameraPos.y / 7.5
	end

	if self.TwoDimensionSeriesComponents ~= nil then
		for i = 0, self.TwoDimensionSeriesComponents.Length - 1 do
			local twoDimensionSeriesComponent = self.TwoDimensionSeriesComponents[i]

			twoDimensionSeriesComponent.value = bgVisualCameraPos.x / 17
		end
	end
end

function m:InitBGM()
	MazeBGMModule.Init()
end

function m:InitBG()
	local cfgMazeLevelResData = CfgMazeLevelResTable[MazeDataModule.MazeLevelResID]

	self:RefreshBG(cfgMazeLevelResData)
end

function m:RefreshBG(cfgMazeLevelResData)
	if cfgMazeLevelResData.MapPrefab ~= "" then
		AssetUtil.LoadAsset(self, "Assets/03_Prefabs/ART_Prefabs/Scene" .. cfgMazeLevelResData.MapPrefab .. ".prefab", self.OnLoadBgSuccess, self.OnLoadBgFail)
	else
		if self.Background ~= nil then
			self.Background.transform:SetParent(nil, false)
			UnityEngine.Object.Destroy(self.Background)

			self.Background = nil
		end

		if self.InitMaze then
			self.BgLoadComplete = true

			self:CheckLoadComplete()
		end
	end
end

function m:OnLoadBgSuccess(assetName, asset, duration, userData)
	if self.Background ~= nil then
		self.Background.transform:SetParent(nil, false)
		UnityEngine.Object.Destroy(self.Background)
	end

	self.Background = UnityEngine.Object.Instantiate(asset)

	self.Background.transform:SetParent(self.ModelRoot, false)

	self.RollingGroundComponent = self.Background:GetComponentInChildren(typeof(IQIGame.Onigao.Game.VerticalRollingGround))
	self.TwoDimensionSeriesComponents = self.Background:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.TwoDimensionSeriesComponent))

	if self.InitMaze then
		self.BgLoadComplete = true

		self:CheckLoadComplete()
	else
		self:RefreshRollingBg(self.MainCamera.transform.position)
	end
end

function m:OnLoadBgFail(assetName, status, errorMessage, userData)
	if self.InitMaze then
		self.BgLoadComplete = true

		self:CheckLoadComplete()
	end
end

function m:ChangeLevelRes(cfgMazeLevelResData)
	self:RefreshBG(cfgMazeLevelResData)
	MazeBGMModule.ChangeWeatherSound()
end

function m:InitScrollStage()
	local cfgMazeLevelResData = CfgMazeLevelResTable[MazeDataModule.MazeLevelResID]

	self:RefreshScrollStage(cfgMazeLevelResData)
end

function m:RefreshScrollStage(cfgMazeLevelResData)
	if cfgMazeLevelResData.ScrollStagePrefab ~= "" then
		AssetUtil.LoadAsset(self, "Assets/03_Prefabs/ART_Prefabs/Scene/ScrollStage" .. cfgMazeLevelResData.ScrollStagePrefab, self.OnLoadScrollStageSuccess, self.OnLoadScrollStageFail)
	else
		if self.ScrollStageController ~= nil then
			self.ScrollStageController:Clear()
		end

		if self.InitMaze then
			self.ScrollStageLoadComplete = true

			self:CheckLoadComplete()
		end
	end
end

function m:OnLoadScrollStageSuccess(assetName, asset, duration, userData)
	if self.ScrollStageController == nil then
		self.ScrollStageController = ScrollMazeStage.New(self.MainCamera)
	end

	self.ScrollStageController:Refresh(UnityEngine.Object.Instantiate(asset), function()
		if self.InitMaze then
			self.ScrollStageLoadComplete = true

			self:CheckLoadComplete()
		end
	end)
end

function m:OnLoadScrollStageFail(assetName, status, errorMessage, userData)
	if self.ScrollStageController ~= nil then
		self.ScrollStageController:Clear()
	end

	if self.InitMaze then
		self.ScrollStageLoadComplete = true

		self:CheckLoadComplete()
	end
end

function m:CheckLoadComplete(updateLoad)
	self.NeedCheckLoadCompleteNextFrame = true

	if updateLoad then
		self.LoadedAssetNum = self.LoadedAssetNum + 1

		EventDispatcher.Dispatch(EventID.SceneCustomPreloadUpdate, self.LoadedAssetNum, self.TotalAssetNum)
	end
end

function m:CheckLoadCompleteNextFrame()
	if self.BgLoadComplete and self.ScrollStageLoadComplete and self:IsAllEntityLoaded() and self.InitMaze then
		if self.ScrollStageController ~= nil then
			self.ScrollStageController:PlayBorn()
		end

		GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.Maze))
		EventDispatcher.Dispatch(EventID.MazeSceneInitialized)

		self.InitMaze = false

		if m.FIRST_ENTER_GUIDE_ID == 0 or GuideModule.CheckGuideFinish(m.FIRST_ENTER_GUIDE_ID) or not GuideModule.IsGuideEnabled(CfgGuideTable[m.FIRST_ENTER_GUIDE_ID]) then
			self:CheckStartAnimation()
		end
	end

	self.NeedCheckLoadCompleteNextFrame = false
end

function m:OnGuideChangeState(id, step, type)
	if id == m.FIRST_ENTER_GUIDE_ID and type == 3 then
		self:CheckStartAnimation()
	end
end

function m:IsAllEntityLoaded()
	local isLoading = false

	if not self.Hero.HaveShowed then
		isLoading = true
	end

	for i = 1, #self.Nodes do
		local node = self.Nodes[i]

		if node.IsLoading then
			isLoading = true

			break
		end
	end

	for i = 1, #self.Elements do
		local element = self.Elements[i]

		if not element.HaveShowed then
			isLoading = true

			break
		end
	end

	for i = 1, #self.Paths do
		local path = self.Paths[i]

		if path.IsLoading then
			isLoading = true

			break
		end
	end

	return not isLoading
end

function m:CheckStartAnimation()
	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]

	if cfgMazeInstanceData.IsShowAnimation and MazeDataModule.StreamingLoadType == Constant.Maze.StreamingTypeNone and MazeDataModule.IsFirstTimeHere and not MazeDataModule.IsRestoreMaze then
		local exitNode, moveDuration

		for i = 1, #self.Nodes do
			local mazeNode = self.Nodes[i]
			local cfgMazePathNodeData = CfgMazePathNodeTable[mazeNode.NodeData.CID]

			if cfgMazePathNodeData.Type == 2 then
				exitNode = mazeNode
				moveDuration = cfgMazePathNodeData.MoveTime

				if moveDuration == 0 then
					moveDuration = 1
				end

				break
			end
		end

		self.Hero:SetVisible(false)
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeActiveNode, true)
		self.Animation:PlayShowNodeAnimation(exitNode, true, function()
			self.MazePrepared = true

			local timer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.Maze, function()
				self.Hero:SetVisible(true)
				EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeActiveNode, false)
			end, 3)

			timer:Start()
			self:StartActiveBornNodeNeighbors()
		end, nil, moveDuration)
	else
		self.MazePrepared = true

		self:MoveCamera(self.Hero:GetCameraFocusPosition())

		local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, function()
			self:StartExplore(not MazeDataModule.IsRestoreMaze)
		end, 1.8)

		timer:Start()
	end
end

function m:GetControllerByGOInsID(id)
	return self.GOInsIDControllerMap[id]
end

function m:IsNode(controller)
	for i = 1, #self.Nodes do
		if self.Nodes[i] == controller then
			return true
		end
	end

	return false
end

function m:Update()
	self.StateMachineMgr:Update()

	if not self.IsActive then
		return
	end

	xpcall(function()
		if #self.WaitForLoadNodes > 0 then
			local temp = {}

			for i = 1, #self.WaitForLoadNodes do
				if i <= 3 then
					self:LoadNodeAndRelativeAssets(self.WaitForLoadNodes[i])
				else
					table.insert(temp, self.WaitForLoadNodes[i])
				end
			end

			self.WaitForLoadNodes = temp
		elseif self.NeedCheckLoadCompleteNextFrame then
			self:CheckLoadCompleteNextFrame()
		end

		self:UpdateHeroMove()
		self:UpdateElement()

		for i = 1, #self.Paths do
			self.Paths[i]:Update()
		end

		self.Animation:Update()

		if self.ScrollStageController ~= nil then
			self.ScrollStageController:Update()
		end
	end, function(msg)
		logError("迷宫刷新出错：" .. tostring(msg))
	end)
end

function m:StartActiveBornNodeNeighbors()
	if self.BornNodeNeighbors ~= nil then
		for i = 1, #self.BornNodeNeighbors do
			local nodeData = self.BornNodeNeighbors[i]

			nodeData.IsActive = true

			EventDispatcher.Dispatch(EventID.MazeUpdateNodeData, nodeData, true)
		end
	end

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, function()
		self:StartExplore(true)
	end, 1.5)

	timer:Start()
end

function m:StartExplore(isNotRestore)
	function self.DelegateStartExplore()
		self.DelegateStartExplore = nil

		EventDispatcher.Dispatch(EventID.ShowStartExploreNotice, isNotRestore)
		MazeModule.Prepared()
		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_START_MAZE)
		EventDispatcher.Dispatch(EventID.MazeMainUITweenShow)
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeInit, false)
		EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "MazeMainUITweenShow")
		self.Hero:SetVisible(true)
		self:CheckNodeAction(self.Hero.NodeData.NodeId)

		if self.ScrollStageController ~= nil then
			self.ScrollStageController:PlayStart(isNotRestore)
		end
	end

	if self.DefaultUIOpened then
		self.DelegateStartExplore()
	end
end

function m:CheckStartExplore()
	if self.DelegateStartExplore ~= nil then
		self.DelegateStartExplore()
	end
end

function m:UpdateHeroMove()
	if self.Hero == nil then
		return
	end

	self.Hero:Update()

	if self.Hero:IsMoving() then
		self.Hero.MoveElapsedTime = self.Hero.MoveElapsedTime + UnityEngine.Time.deltaTime

		local lerpValue = self.Hero.MoveElapsedTime / self.Hero.MoveDuration

		self.Hero.gameObject.transform.position = Vector3.Lerp(self.Hero.MoveStartPosition, self.Hero.MoveNextPosition, lerpValue)

		EventDispatcher.Dispatch(EventID.MazeHeroMove, self.Hero.gameObject.transform.position)

		if lerpValue >= 1 then
			lerpValue = 1
		end

		if lerpValue == 1 then
			local heroMoveNextNode = self.Hero.MoveNextNode

			self.Hero:SetNodeData(heroMoveNextNode.NodeId)
			self:SendMoveArriveOrder(heroMoveNextNode.NodeId)

			if heroMoveNextNode.NodeId ~= self.Hero.MoveFinalNode.NodeId then
				self:MoveToNode(self.Hero.MoveFinalNode)
			else
				self.Hero:StopMove(heroMoveNextNode.NodeId)
			end
		end
	end

	if self.CameraFollowHero and not self.IsPlayingMoveCameraAnimation then
		local heroPos = self.Hero:GetCameraFocusPosition()
		local validCameraPosition = self:GetRestrictedCameraPosition(heroPos)

		if not self.Hero:IsMoving() and (validCameraPosition - self.MainCamera.transform.position).magnitude < 0.1 then
			self.CameraFollowHero = false
		else
			local targetPos = Vector3.Lerp(self.MainCamera.transform.position, heroPos, 0.1)

			self:RecordBgRollingDragDelta()
			self:MoveCamera(targetPos, true)
		end
	end
end

function m:SendMoveArriveOrder(nodeId)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_MOVE_ARRIVED, {
		NodeID = nodeId
	})

	local elementPODs = MazeDataModule.GetElementPODsByNode(nodeId)

	if elementPODs ~= nil then
		for i = 1, #elementPODs do
			local elementPOD = elementPODs[i]
			local element = self:GetElement(elementPOD.ID)

			if element ~= nil and element.NeedChangeState then
				self:SendStateTriggerOrder(element.ElementPOD.ID, element.State)
			end
		end
	end

	self:MoveTryCheckNodeAction(nodeId, true)
end

function m:OnHeroMoveArrived(nodeId, stop)
	local oldHeroNodeId = self.Hero.NodeData.NodeId

	self.Hero:SetNodeData(nodeId)

	self.MoveArriveOrderNotConfirmed = false

	if stop then
		self.MoveCheckNodes = {}

		self.Hero:StopMove(nodeId)
		self:MoveCamera(self.Hero:GetCameraFocusPosition())

		self.MoveToNodeIdAfterConfirm = 0

		if oldHeroNodeId ~= nodeId then
			EventDispatcher.Dispatch(EventID.MazeHeroCorrectPosition)
		end
	end

	if self.MoveToNodeIdAfterConfirm ~= 0 then
		self:TrySendMoveToOrder(self.MoveToNodeIdAfterConfirm)

		self.MoveToNodeIdAfterConfirm = 0
	end

	if MazeDataModule.StreamingLoadType ~= Constant.Maze.StreamingTypeNone then
		self:CheckStreamingLoad()
	end

	self:MoveTryCheckNodeAction(nodeId, false)

	if self.Hero.TransportTargetNodeId ~= nil and self.Hero.TransportTargetNodeId == nodeId then
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeTransport, false)
		self.Hero:SetTransportArrived()
	end

	local areaNodData = MazeDataModule.GetNodeDataById(nodeId)
	local cfgMazePathNodeData = CfgMazePathNodeTable[areaNodData.CID]

	if cfgMazePathNodeData.Type == Constant.Maze.NodeTypeExit and MazeDataModule.PlayerInfo.ExploreScore < 100 then
		EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "MazeArriveExit_" .. MazeDataModule.MazeInstanceID)
	end

	self:CheckHideLowerLayer(areaNodData)
end

function m:MoveTryCheckNodeAction(nodeId, isSend)
	if isSend then
		self:CheckNodeAction(nodeId)
		table.insert(self.MoveCheckNodes, nodeId)
	else
		local index = table.indexOf(self.MoveCheckNodes, nodeId)

		if index == -1 then
			self:CheckNodeAction(nodeId)
		else
			table.remove(self.MoveCheckNodes, index)
		end
	end
end

function m:CheckNodeAction(nodeId)
	self:CheckNodeHintEffect(nodeId)
	self:CheckServiceTriggerNotice(nodeId)
end

function m:CheckNodeHintEffect(nodeId)
	local nodesAround = MazeDataModule.GetNodesAround(nodeId, 2)
	local nodeTypeEffectMapDefine = MazeSceneApi:GetString("NodeNoticeEffects")
	local validNodeTypes

	for i = 1, #nodesAround do
		local areaNodeData = nodesAround[i]

		if areaNodeData.IsActive and not areaNodeData.IsComplete then
			local cfgMazePathNodeData = CfgMazePathNodeTable[areaNodeData.CID]

			validNodeTypes = validNodeTypes or {}
			validNodeTypes[cfgMazePathNodeData.Type] = cfgMazePathNodeData.Type
		end
	end

	for type, effectCid in pairs(nodeTypeEffectMapDefine) do
		self.Hero:RefreshLoopEffect(effectCid, validNodeTypes ~= nil and validNodeTypes[type] ~= nil)
	end
end

function m:CheckServiceTriggerNotice(nodeId)
	local elementPODs = MazeDataModule.GetElementPODsByNode(nodeId)

	if elementPODs == nil then
		return
	end

	local needConfirmElementIds

	for i = 1, #elementPODs do
		local mazeElementPOD = elementPODs[i]

		if not mazeElementPOD.IsRemoved then
			local cfgElementAllData = CfgElementAllTable[mazeElementPOD.CID]

			for j = 1, #cfgElementAllData.ServiceIDList do
				local cfgElementServiceData = CfgElementServiceTable[cfgElementAllData.ServiceIDList[j]]

				if cfgElementServiceData.TriggerType == 104 then
					local targetExecutions

					if ConditionModule.Check(cfgElementServiceData.ConditionID) then
						targetExecutions = cfgElementServiceData.ExecutionID
					else
						targetExecutions = cfgElementServiceData.VetoExecutionID
					end

					if #targetExecutions > 0 then
						needConfirmElementIds = needConfirmElementIds or {}

						table.insert(needConfirmElementIds, mazeElementPOD.ID)

						break
					end
				end
			end
		end
	end

	if needConfirmElementIds ~= nil then
		EventDispatcher.Dispatch(EventID.MazeArriveAtManualTriggerServiceNode, nodeId, needConfirmElementIds)
	end
end

function m:GetNode(nodeId)
	return self.NodeMap[nodeId]
end

function m:GetElement(elementId)
	for i = 1, #self.Elements do
		local element = self.Elements[i]

		if element.ElementPOD.ID == elementId and not element.ElementPOD.IsRemoved then
			return element, i
		end
	end

	return nil, -1
end

function m:GetNodeByCID(nodeCid)
	for i = 1, #self.Nodes do
		local node = self.Nodes[i]

		if node.NodeData.CID == nodeCid then
			return node
		end
	end

	return nil
end

function m:UpdateElement()
	for i = 1, #self.Elements do
		local element = self.Elements[i]

		element:Update()

		if element ~= self.Hero and element:IsMoving() and element.gameObject ~= nil then
			element.MoveElapsedTime = element.MoveElapsedTime + UnityEngine.Time.deltaTime

			local lerpValue = element.MoveElapsedTime / element.MoveDuration

			element.gameObject.transform.position = Vector3.Lerp(element.MoveStartPosition, element.MoveNextPosition, lerpValue)

			if lerpValue >= 1 then
				lerpValue = 1
			end

			if lerpValue == 1 then
				element.gameObject.transform.position = element.MoveNextPosition

				element:StopMove()
			end
		end
	end
end

function m:SetActive(value)
	if self.MainCamera == nil then
		logError("self.MainCamera is nil. PlayerModule.InMaze: " .. tostring(PlayerModule.InMaze))

		return
	end

	self.IsActive = value
	self.MainCamera.enabled = value

	local colliders = self.NodeRoot:GetComponentsInChildren(typeof(UnityEngine.Collider2D))

	for i = 0, colliders.Length - 1 do
		colliders[i].enabled = value
	end

	local canvases = self.UIEffectCanvas:GetComponentsInChildren(typeof(UnityEngine.Canvas))

	for i = 0, canvases.Length - 1 do
		canvases[i].enabled = value
	end

	local renderers = self.UIEffectCanvas:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, renderers.Length - 1 do
		renderers[i].enabled = value
	end

	self.StateMachineMgr:SetActive(value)
end

function m:AutoTapNextNode()
	local nodeId = self.Hero.NodeData.NextNodes[1]

	if nodeId == nil then
		logError("MazeScene.AutoTapNextNode Error. self.Hero.NodeData.NextNodes[1] == nil")

		return
	end

	local mazeNode = self:GetNode(nodeId)

	if mazeNode == nil then
		logError("MazeScene.AutoTapNextNode Error. mazeNode == nil. NodeId = " .. tostring(nodeId))

		return
	end

	self:TapNode(mazeNode)
end

function m:HasNextNode()
	return #self.Hero.NodeData.NextNodes > 0
end

function m:OnTapNode(mazeNode)
	self:TapNode(mazeNode)
end

function m:TapNode(mazeNode)
	if mazeNode.NodeData.NodeId == self.Hero.NodeData.NodeId then
		return
	end

	if self.Hero.MoveNextNode ~= nil then
		self.Hero.MoveFinalNode = mazeNode.NodeData

		return
	end

	self:MoveToNode(mazeNode.NodeData)
end

function m:MoveToNode(nodeData)
	self.Hero.MoveFinalNode = nodeData

	local pathNodes = MazeModule.FindNodePath(nodeData)

	if #pathNodes == 0 then
		if MazeModule.IsOneStepNoBackward() then
			NoticeModule.ShowNotice(21045062)
		end

		return
	end

	local nextNodeData = pathNodes[1]

	self.Hero:SetMoveNextNodeData(nextNodeData)

	self.CameraFollowHero = true
	self.Hero.MoveStartPosition = self.Hero.gameObject.transform.position
	self.Hero.MoveDuration = (self.Hero.MoveNextPosition - self.Hero.MoveStartPosition).magnitude / self.Hero.MoveSpeed
	self.Hero.MoveElapsedTime = 0

	self:TrySendMoveToOrder(nextNodeData.NodeId)

	local dir = nextNodeData.x - self.Hero.gameObject.transform.position.x

	self.Hero:LookAtDirection(dir)
	EventDispatcher.Dispatch(EventID.MazeHeroStartMove)
end

function m:TrySendMoveToOrder(nodeId)
	if self.MoveArriveOrderNotConfirmed then
		self.MoveToNodeIdAfterConfirm = nodeId
	else
		self.MoveArriveOrderNotConfirmed = true

		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_MOVE_TO, {
			NodeID = nodeId
		})
	end
end

function m:TransportTo(nodeData, mode)
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeTransport, true)
	self.Hero:StopMove(self.Hero.NodeData.NodeId)
	self.Hero:StartTransport(nodeData.NodeId)

	if mode == 1 then
		GameEntry.Effect:PlayMountPointEffect(9000921, 50000, 0, self.UIEffectCanvas, 0, 0, LayerMask.NameToLayer("UI"), 0, 30000)
	end
end

function m:CameraStartFollowHero()
	self.CameraFollowHero = true
end

function m:OnStartTransport(nodeId, mode)
	EventDispatcher.Dispatch(EventID.MazeHeroStartMove)

	local nodeData = MazeDataModule.GetNodeDataById(nodeId)

	self:TransportTo(nodeData, mode)
end

function m:IsNodesConnected(nodeData1, nodeData2)
	for i = 1, #nodeData1.NextNodes do
		if nodeData1.NextNodes[i] == nodeData2.NodeId then
			return true
		end
	end

	for i = 1, #nodeData2.NextNodes do
		if nodeData2.NextNodes[i] == nodeData1.NodeId then
			return true
		end
	end

	return false
end

function m:GetRestrictedCameraPosition(position)
	local result = position:Clone()
	local cameraSizeX = self.MainCamera.orthographicSize * (UnityEngine.Screen.width / UnityEngine.Screen.height)
	local cameraSizeY = self.MainCamera.orthographicSize
	local nodeMinX, nodeMinY, nodeMaxX, nodeMaxY
	local nodeRightMarginX = MazeSceneApi:GetString("NodeRightMarginX")
	local nodeTopMarginY = MazeSceneApi:GetString("NodeTopMarginY")

	if MazeDataModule.StreamingLoadType ~= Constant.Maze.StreamingTypeNone then
		nodeMinX = 0
		nodeMinY = 0
		nodeMaxX = MazeDataModule.AllNodeMaxX + nodeRightMarginX
		nodeMaxY = MazeDataModule.AllNodeMaxY + nodeTopMarginY

		local loadRectMinPosX = self.Hero.gameObject.transform.position.x - m.LOAD_RANGE_X * MazeDataModule.AreaNodeDistanceX
		local loadRectMinPosY = self.Hero.gameObject.transform.position.y - m.LOAD_RANGE_Y * MazeDataModule.AreaNodeDistanceY
		local loadRectMaxPosX = self.Hero.gameObject.transform.position.x + m.LOAD_RANGE_X * MazeDataModule.AreaNodeDistanceX
		local loadRectMaxPosY = self.Hero.gameObject.transform.position.y + m.LOAD_RANGE_Y * MazeDataModule.AreaNodeDistanceY
		local finalRectMinPosX = math.min(loadRectMinPosX, self.VisibleNodeMinX)
		local finalRectMaxPosX = math.max(loadRectMaxPosX, self.VisibleNodeMaxX)
		local finalRectMinPosY = math.min(loadRectMinPosY, self.VisibleNodeMinY)
		local finalRectMaxPosY = math.max(loadRectMaxPosY, self.VisibleNodeMaxY)

		nodeMinX = math.max(nodeMinX, finalRectMinPosX - Constant.Maze.InfiniteMazeLoadRectMargin)
		nodeMaxX = math.min(nodeMaxX, finalRectMaxPosX + Constant.Maze.InfiniteMazeLoadRectMargin)
		nodeMinY = math.max(nodeMinY, finalRectMinPosY - Constant.Maze.InfiniteMazeLoadRectMargin)
		nodeMaxY = math.min(nodeMaxY, finalRectMaxPosY + Constant.Maze.InfiniteMazeLoadRectMargin)
	else
		nodeMinX = 0
		nodeMinY = 0
		nodeMaxX = MazeDataModule.ActiveNodeMaxX + nodeRightMarginX
		nodeMaxY = MazeDataModule.ActiveNodeMaxY + nodeTopMarginY
		nodeMaxX = math.max(nodeMaxX, self.Hero.gameObject.transform.position.x + cameraSizeX)
		nodeMaxY = math.max(nodeMaxY, self.Hero.gameObject.transform.position.y + cameraSizeY)
		nodeMaxX = math.min(nodeMaxX, MazeDataModule.AllNodeMaxX + nodeRightMarginX)
		nodeMaxY = math.min(nodeMaxY, MazeDataModule.AllNodeMaxY + nodeTopMarginY)
	end

	local minCameraX = nodeMinX + cameraSizeX
	local minCameraY = nodeMinY + cameraSizeY
	local maxCameraX = nodeMaxX - cameraSizeX
	local maxCameraY = nodeMaxY - cameraSizeY

	if maxCameraX < minCameraX then
		maxCameraX = minCameraX
	end

	if maxCameraY < minCameraY then
		maxCameraY = minCameraY
	end

	if minCameraX > result.x then
		result.x = minCameraX
	end

	if minCameraY > result.y then
		result.y = minCameraY
	end

	if maxCameraX < result.x then
		result.x = maxCameraX
	end

	if maxCameraY < result.y then
		result.y = maxCameraY
	end

	return result
end

function m:OnAddElement(mazeElementPOD)
	local element = MazeElement.New(mazeElementPOD, self.ElementRoot)

	table.insert(self.Elements, element)
end

function m:RemoveElement(element)
	local index = table.indexOf(self.Elements, element)

	table.remove(self.Elements, index)
	element:Dispose()
end

function m:OnNodeUpdate(nodeData, isNewActive)
	if isNewActive then
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeActiveNode, true)

		local cfgMazePathNodeData = CfgMazePathNodeTable[nodeData.CID]

		if cfgMazePathNodeData.ShowType == 0 then
			if self.Animation.CameraLockNode == nil then
				self.CameraFollowHero = true
			end

			local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, function()
				EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeActiveNode, false)
			end, 1)

			timer:Start()
		elseif cfgMazePathNodeData.ShowType == 1 then
			local mazeNode = self:GetNode(nodeData.NodeId)

			self.Animation:PlayShowNodeAnimation(mazeNode, true, function()
				EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeActiveNode, false)
			end, nil, cfgMazePathNodeData.MoveTime)
		end
	end
end

function m:CommandMoveCamera(screenSwitchCidList)
	self:PlayScreenMoveAnimation(screenSwitchCidList)
end

function m:PlayScreenMoveAnimation(screenSwitchCidList)
	self.IsPlayingMoveCameraAnimation = true

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeAutoMoveCamera, true)

	self.MoveCameraCmdCidList = screenSwitchCidList

	self:CommandMoveCameraToNextNode()
end

function m:CommandMoveCameraToNextNode()
	local needAddBackToHero = false
	local backToHeroDurationAtLast = 0

	if #self.MoveCameraCmdCidList > 0 then
		local mazeScreenSwitchCid = self.MoveCameraCmdCidList[1]

		table.remove(self.MoveCameraCmdCidList, 1)

		local cfgMazeScreenSwitchData = CfgMazeScreenSwitchTable[mazeScreenSwitchCid]

		if #self.MoveCameraCmdCidList == 0 and cfgMazeScreenSwitchData.NodeId ~= 0 then
			needAddBackToHero = true
			backToHeroDurationAtLast = cfgMazeScreenSwitchData.MoveTime
		end

		if cfgMazeScreenSwitchData.SwitchMode == 2 then
			GameEntry.Effect:PlayMountPointEffect(9000921, 50000, 0, self.UIEffectCanvas, 0, 0, LayerMask.NameToLayer("UI"), 0, 30000)
		end

		local isTeleport = cfgMazeScreenSwitchData.SwitchMode == 2

		if cfgMazeScreenSwitchData.NodeId ~= 0 then
			local targetNode

			for i = 1, #self.Nodes do
				local node = self.Nodes[i]

				if node.NodeData.CID == cfgMazeScreenSwitchData.NodeId and node.NodeData.AreaIx == self.Hero.NodeData.AreaIx then
					targetNode = node

					break
				end
			end

			if targetNode == nil then
				logError("镜头找不到对应的格子。Node cid: " .. cfgMazeScreenSwitchData.NodeId)
				MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_SCREEN_SWITCH_FINISH, {
					ScreenSwitchID = mazeScreenSwitchCid
				})
				self:CommandMoveCameraToNextNode()

				return
			end

			self.Animation:PlayMoveCameraAnimation(targetNode, function()
				local function onComplete()
					MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_SCREEN_SWITCH_FINISH, {
						ScreenSwitchID = mazeScreenSwitchCid
					})

					local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, function()
						self:CommandMoveCameraToNextNode()
					end, cfgMazeScreenSwitchData.LastTime)

					timer:Start()
				end

				if isTeleport then
					local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, onComplete, 1)

					timer:Start()
				else
					onComplete()
				end
			end, isTeleport, isTeleport and 1 or nil, cfgMazeScreenSwitchData.MoveTime)
		else
			self.Animation:MoveBackToHero(function()
				local function onComplete()
					MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_SCREEN_SWITCH_FINISH, {
						ScreenSwitchID = mazeScreenSwitchCid
					})

					self.IsPlayingMoveCameraAnimation = false

					EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeAutoMoveCamera, false)
				end

				if isTeleport then
					local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, onComplete, 1)

					timer:Start()
				else
					onComplete()
				end
			end, isTeleport, isTeleport and 1 or nil, cfgMazeScreenSwitchData.MoveTime)
		end
	end

	if needAddBackToHero then
		self.Animation:MoveBackToHero(function()
			self.IsPlayingMoveCameraAnimation = false

			EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeAutoMoveCamera, false)
		end, false, nil, backToHeroDurationAtLast)
	end
end

function m:PlayElementAction(cid)
	local cfgElementActionData = CfgElementActionTable[cid]
	local targetType = cfgElementActionData.EffectTarget
	local nodes = {}
	local elementPODs = {}

	if targetType == 1 then
		table.insert(elementPODs, self.Hero.ElementPOD)
	else
		for i = 1, #cfgElementActionData.NodeID do
			local node

			if cfgElementActionData.NodeID[i] == 0 then
				node = self:GetNode(self.Hero.NodeData.NodeId)
			else
				node = self:GetNodeByCID(cfgElementActionData.NodeID[i])

				if node == nil then
					logError("根据ElementAction(Id = " .. cid .. ").NodeID[" .. i .. "] 找不到对应的节点. 迷宫：" .. MazeDataModule.MazeInstanceID)

					break
				end
			end

			if targetType == 2 then
				elementPODs = MazeDataModule.GetElementPODsByNode(node.NodeData.NodeId)
			elseif targetType == 3 then
				table.insert(nodes, node)
			end
		end
	end

	local gameObject

	if cfgElementActionData.SpineAction ~= "" then
		for i = 1, #elementPODs do
			local elementPOD = elementPODs[i]
			local element

			if self.Hero.ElementPOD.ID == elementPOD.ID then
				element = self.Hero
			else
				element = self:GetElement(elementPOD.ID)
			end

			if element ~= nil then
				element.CustomAnimation = cfgElementActionData.SpineAction
			end
		end
	end

	if cfgElementActionData.EffectID ~= 0 then
		for i = 1, #nodes do
			local node = nodes[i]

			gameObject = node.gameObject

			local mountPointTrans = getMountPoint(gameObject.transform, cfgElementActionData.EffectPoint)
			local maxSortingOrder = 0
			local renderers = gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))

			for j = 0, renderers.Length - 1 do
				maxSortingOrder = math.max(maxSortingOrder, renderers[j].sortingOrder)
			end

			MazeModule.PlayMaskedNormalEffect(cfgElementActionData.EffectID, mountPointTrans.position, cfgElementActionData.EffectDelay, 0, 0, 0, maxSortingOrder + 2)
		end

		for i = 1, #elementPODs do
			local elementPOD = elementPODs[i]
			local element

			if self.Hero.ElementPOD.ID == elementPOD.ID then
				element = self.Hero
			else
				element = self:GetElement(elementPOD.ID)
			end

			if element ~= nil then
				gameObject = element.gameObject

				local mountPointTrans = getMountPoint(gameObject.transform, cfgElementActionData.EffectPoint)
				local maxSortingOrder = 0
				local renderers = gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))

				for j = 0, renderers.Length - 1 do
					maxSortingOrder = math.max(maxSortingOrder, renderers[j].sortingOrder)
				end

				MazeModule.PlayMaskedNormalEffect(cfgElementActionData.EffectID, mountPointTrans.position, cfgElementActionData.EffectDelay, 0, 0, LuaCodeInterface.SortingLayerNameToID("Element"), maxSortingOrder + 1)
			end
		end
	end

	if cfgElementActionData.SoundEffectID ~= 0 then
		local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, function()
			for i = 1, #nodes do
				local node = nodes[i]

				gameObject = node.gameObject

				GameEntry.Sound:PlaySound(cfgElementActionData.SoundEffectID, Constant.SoundGroup.ENVIRONMENT, nil, gameObject.transform.position)
			end

			for i = 1, #elementPODs do
				local elementPOD = elementPODs[i]
				local element

				if self.Hero.ElementPOD.ID == elementPOD.ID then
					element = self.Hero
				else
					element = self:GetElement(elementPOD.ID)
				end

				if element ~= nil then
					gameObject = element.gameObject

					GameEntry.Sound:PlaySound(cfgElementActionData.SoundEffectID, Constant.SoundGroup.ENVIRONMENT, nil, gameObject.transform.position)
				end
			end
		end, cfgElementActionData.SoudDelay)

		timer:Start()
	end
end

function m:SendStateTriggerOrder(elementId, state)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_ELEMENT_STATE_TRIGGER, {
		Id = elementId,
		State = tostring(state)
	})
end

function m:ResetCameraToHero()
	self.CameraFollowHero = true
end

function m:PlayQuickFight()
	if self.ScrollStageController ~= nil then
		MazeModule.CommandSwitch(false)
		self.ScrollStageController:PlayQuickFight(function()
			MazeModule.CommandSwitch(true)
		end)
	else
		local duration = 2

		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeQuickFight, true)
		self.Hero:PauseMove(Constant.PauseMoveReason.QuickFight)
		MazeModule.CommandSwitch(false)

		local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, function()
			EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeQuickFight, false)
			self.Hero:ResumeMove(Constant.PauseMoveReason.QuickFight)
			MazeModule.CommandSwitch(true)
		end, duration)

		timer:Start()
		self:PlayEffectOnHeroNode(duration)
	end
end

function m:PlayEffectOnHeroNode(duration)
	local node = self:GetNode(self.Hero.NodeData.NodeId)
	local mountPointTrans = getMountPoint(node.gameObject.transform, 50000)

	MazeModule.PlayMaskedNormalEffect(9000910, mountPointTrans.position, 0, duration, 0, LuaCodeInterface.SortingLayerNameToID("Element"), Constant.Unity.SortingOrderMaxValue)
end

function m:OnMazeUpdateDoll(changedProps)
	local hasDollLvUp = false

	for id, changedProp in pairs(changedProps) do
		if changedProp.lv > 0 then
			hasDollLvUp = true

			break
		end
	end

	if hasDollLvUp and self.Hero ~= nil and self.Hero.gameObject ~= nil then
		self.NodeEffectPlayId = MazeModule.PlayMaskedMountPointEffect(9000517, 50000, self.Hero.EntityId, self.Hero.gameObject, 0, 0, 0, LuaCodeInterface.SortingLayerNameToID("Element"), Constant.Unity.SortingOrderMaxValue)
	end
end

function m:CheckHideLowerLayer(arriveNodeData)
	if not MazeDataModule.IsEndlessPlusLikeMaze() then
		return
	end

	for i = 1, #self.Elements do
		local element = self.Elements[i]

		if not element.IsLoading and element.NodeData.XIndex < arriveNodeData.XIndex then
			local oldValue = element.IsVisible
			local newValue = false

			if oldValue ~= newValue then
				element:SetVisible(newValue)
				EventDispatcher.Dispatch(EventID.MazeElementVisibleChanged, element.NodeData.NodeId, newValue)
			end
		end
	end
end

function m:OnNotifyMaskManually(gameObject, isRemove)
	if not isRemove then
		self.Mask:AddMaskItem(gameObject)
	else
		self.Mask:RemoveMaskItem(gameObject)
	end
end

function m:Dispose()
	GameEntry.Timer:RemoveRender(self.DelegateOnTimerUpdate)
	AssetUtil.UnloadAsset(self)
	self:RemoveEventListeners()
	self.InputMgr:Dispose()
	MazeBGMModule.Clear()

	for i = 1, #self.Nodes do
		local node = self.Nodes[i]

		node:Dispose()
	end

	self.Nodes = nil

	for i = 1, #self.Paths do
		local path = self.Paths[i]

		path:Dispose()
	end

	self.Paths = nil

	for i = 1, #self.Elements do
		local element = self.Elements[i]

		element:Dispose()
	end

	if self.ScrollStageController ~= nil then
		self.ScrollStageController:Dispose()

		self.ScrollStageController = nil
	end

	self.Background = nil
	self.RollingGroundComponent = nil
	self.TwoDimensionSeriesComponents = nil
	self.Elements = nil

	self.Hero:Dispose()

	self.Hero = nil
	self.ModelRoot = nil
	self.PathRoot = nil
	self.NodeRoot = nil
	self.ElementFootRoot = nil
	self.ElementRoot = nil
	self.MainCamera = nil
	self.UIEffectCanvas = nil
	self.ConstantMainUIEffectCanvasGo = nil

	self.StateMachineMgr:Dispose()

	self.BornNodeNeighbors = nil
	self.MazePrepared = false

	self.Animation:Dispose()

	self.Mask = nil
end

return m
