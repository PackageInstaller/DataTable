-- chunkname: @IQIGame\\Scene\\Dreamland\\DreamlandScene.lua

local m = {
	HeroLoadComplete = false,
	NodeMaxY = 0,
	CameraFollowHero = false,
	NodeMaxX = 0,
	IsActive = true,
	BgLoadComplete = false,
	IsReadyToStart = false,
	SoundPackageId = 0,
	Elements = {},
	Nodes = {},
	NodeMinX = Constant.Number.IntMaxValue,
	NodeMinY = Constant.Number.IntMaxValue
}
local DreamlandHero = require("IQIGame.Scene.Dreamland.DreamlandHero")
local DreamlandElement = require("IQIGame.Scene.Dreamland.DreamlandElement")
local DreamlandNode = require("IQIGame.Scene.Dreamland.DreamlandNode")
local DreamlandInputManager = require("IQIGame.Scene.Dreamland.Input.DreamlandInputManager")
local HexagonPathFinder = require("IQIGame.Util.PathFinder.HexagonPathFinder")

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	function self.DelegateOnTimerUpdate()
		self:OnTimerUpdate()
	end

	self:AddListeners()

	local mainCameraGo = UnityEngine.GameObject.Find("Main Camera")

	self.MainCamera = mainCameraGo:GetComponent("Camera")
	self.MapRoot = UnityEngine.GameObject.Find("MapRoot").transform
	self.ElementRoot = self.MapRoot:Find("Element")
	self.CfgDreamMapListData = CfgDreamMapListTable[DreamlandModule.MapData.mapId]
	self.InputMgr = DreamlandInputManager.New()
	self.StateMachineMgr = StateMachineMgr.New()

	GameEntry.Timer:AddFrameRender(1, self.DelegateOnTimerUpdate, true)

	self.PathFinder = HexagonPathFinder.New()

	self:InitBGM()
	self:InitBG()
	self:InitHero()
	self:LockInputOnInit(2)
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:InitBGM()
	local package = SoundPackageData.New(self.CfgDreamMapListData.BGM, nil)

	self.SoundPackageId = SoundPackagePlayer.Add(package)
end

function m:InitBG()
	AssetUtil.LoadAsset(self, UIGlobalApi.GetPrefabRoot(self.CfgDreamMapListData.DreamMapPrefab), self.OnLoadBgSuccess, self.OnLoadBgFail)
end

function m:OnLoadBgSuccess(assetName, asset, duration, userData)
	local background = UnityEngine.Object.Instantiate(asset)

	background.transform:SetParent(self.MapRoot, false)

	local dreamlandNodeComponents = background:GetComponentsInChildren(typeof(DreamlandNodeComponent), true)

	self:InitNodes(dreamlandNodeComponents)

	self.TwoDimensionSeriesComponents = background:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.TwoDimensionSeriesComponent))
	self.BgLoadComplete = true

	self:CheckLoadComplete()
end

function m:OnLoadBgFail(assetName, status, errorMessage, userData)
	self.BgLoadComplete = true

	self:CheckLoadComplete()
end

function m:InitHero()
	self.Hero = DreamlandHero.New(self.CfgDreamMapListData.PlayerEntity, self.ElementRoot, function()
		self.HeroLoadComplete = true

		self:CheckLoadComplete()
	end)

	table.insert(self.Elements, self.Hero)
end

function m:CheckLoadComplete()
	if self.BgLoadComplete and self.HeroLoadComplete then
		self:ResetHeroPos()

		self.IsReadyToStart = true

		GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.Dreamland))
		DreamlandModule.CheckResumeDialog()
	end
end

function m:ResetHeroPos()
	local node = self:GetNodeByXY(DreamlandModule.MapData.roleX, DreamlandModule.MapData.roleY)

	self.Hero:SetNode(node)
	self.Hero:StopMove()
	self:MoveCamera(self.Hero:GetCameraFocusPosition())
end

function m:InitNodes(dreamlandNodeComponents)
	local nodeDataForNav = {}

	for i = 0, dreamlandNodeComponents.Length - 1 do
		local component = dreamlandNodeComponents[i]
		local node = DreamlandNode.New(component.gameObject, component.typeCid, component.indexX, component.indexY)

		self.Nodes[node.IndexX] = self.Nodes[node.IndexX] or {}
		self.Nodes[node.IndexX][node.IndexY] = node
		self.NodeMinX = math.min(self.NodeMinX, node.View.transform.position.x)
		self.NodeMinY = math.min(self.NodeMinY, node.View.transform.position.y)
		self.NodeMaxX = math.max(self.NodeMaxX, node.View.transform.position.x)
		self.NodeMaxY = math.max(self.NodeMaxY, node.View.transform.position.y)
		nodeDataForNav[node.IndexY + 1] = nodeDataForNav[node.IndexY + 1] or {}
		nodeDataForNav[node.IndexY + 1][node.IndexX + 1] = node.CellCid == 0 and HexagonPathFinder.BLOCK_GRID or HexagonPathFinder.MOVABLE_GRID
	end

	self.PathFinder:InitMap(nodeDataForNav)
	self:RefreshAllNode()
end

function m:RefreshAllNode()
	for i = 1, #DreamlandModule.MapData.cells do
		local cellData = DreamlandModule.MapData.cells[i]

		self:RefreshNode(cellData.x, cellData.y, cellData)
	end
end

function m:RefreshNode(x, y, cellPOD)
	local node = self:GetNodeByXY(x, y)

	if node == nil then
		logError("找不到节点：" .. x .. ", " .. y .. "，请检查预设")
	end

	node:__SetData(cellPOD)
end

function m:OnTimerUpdate()
	self:Update()
end

function m:Update()
	self.StateMachineMgr:Update()

	if not self.IsActive then
		return
	end

	self:UpdateHeroMove()
end

function m:SetActive(value)
	self.IsActive = value
	self.MainCamera.enabled = value

	local colliders = self.MapRoot:GetComponentsInChildren(typeof(UnityEngine.Collider2D))

	for i = 0, colliders.Length - 1 do
		colliders[i].enabled = value
	end

	self.StateMachineMgr:SetActive(value)
end

function m:RemoveElement(element)
	local index = table.indexOf(self.Elements, element)

	table.remove(self.Elements, index)
	element:Dispose()
	self.Hero:ResetPositionOnNode()
	DreamlandModule.ShowExecAnimationComplete()
end

function m:RemoveElementOnHeroNode()
	local result = false

	for i = 1, #self.Elements do
		local element = self.Elements[i]

		if element.Node.IndexX == self.Hero.Node.IndexX and element.Node.IndexY == self.Hero.Node.IndexY then
			element:SetRemoved()

			result = true
		end
	end

	return result
end

function m:MoveCamera(position)
	local validPosition = self:GetRestrictedCameraPosition(position)

	self.MainCamera.transform.position = validPosition
end

function m:GetRestrictedCameraPosition(position)
	local result = position:Clone()
	local cameraSizeX = self.MainCamera.orthographicSize * (UnityEngine.Screen.width / UnityEngine.Screen.height)
	local cameraSizeY = self.MainCamera.orthographicSize
	local nodeMinX, nodeMinY, nodeMaxX, nodeMaxY
	local nodeLeftMarginX = DreamlandSceneApi:GetString("NodeLeftMarginX")
	local nodeBottomMarginY = DreamlandSceneApi:GetString("NodeBottomMarginY")
	local nodeRightMarginX = DreamlandSceneApi:GetString("NodeRightMarginX")
	local nodeTopMarginY = DreamlandSceneApi:GetString("NodeTopMarginY")

	nodeMinX = self.NodeMinX - nodeLeftMarginX
	nodeMinY = self.NodeMinY - nodeBottomMarginY
	nodeMaxX = self.NodeMaxX + nodeRightMarginX
	nodeMaxY = self.NodeMaxY + nodeTopMarginY

	local minCameraX = nodeMinX + cameraSizeX
	local minCameraY = nodeMinY + cameraSizeY
	local maxCameraX = nodeMaxX - cameraSizeX
	local maxCameraY = nodeMaxY - cameraSizeY

	if maxCameraX < minCameraX then
		local midPosX = maxCameraX + (minCameraX - maxCameraX) * 0.5

		minCameraX = midPosX
		maxCameraX = midPosX
	end

	if maxCameraY < minCameraY then
		local midPosY = maxCameraY + (minCameraY - maxCameraY) * 0.5

		minCameraY = midPosY
		maxCameraY = midPosY
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

function m:OnTapNode(node)
	if DreamlandModule.MapData.movePoint < 1 then
		NoticeModule.ShowNotice(21063001)

		return
	end

	if node.IndexX == self.Hero.Node.IndexX and node.IndexY == self.Hero.Node.IndexY then
		return
	end

	if self.Hero:IsMoving() then
		return
	end

	self:MoveToNode(node)
end

function m:MoveToNode(node)
	local pathNodes = self:FindPath(node)

	if #pathNodes == 0 then
		return
	end

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DreamlandMove, true)

	self.Hero.MoveFinalNode = node

	local nextNode = pathNodes[1]

	self.Hero:SetMoveNextNodeData(nextNode)

	self.CameraFollowHero = true
	self.Hero.MoveStartPosition = self.Hero.gameObject.transform.position
	self.Hero.MoveDuration = (self.Hero.MoveNextPosition - self.Hero.MoveStartPosition).magnitude / self.Hero.MoveSpeed
	self.Hero.MoveElapsedTime = 0

	local dir = nextNode:GetPos().x - self.Hero.gameObject.transform.position.x

	self.Hero:LookAtDirection(dir)
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

		if lerpValue >= 1 then
			lerpValue = 1
		end

		if lerpValue == 1 then
			local nextNode = self.Hero.MoveNextNode

			self.Hero:SetNode(nextNode)

			if nextNode.IndexX ~= self.Hero.MoveFinalNode.IndexX or nextNode.IndexY ~= self.Hero.MoveFinalNode.IndexY then
				self:MoveToNode(self.Hero.MoveFinalNode)
			else
				self.Hero:StopMove()
			end
		end
	end

	if self.CameraFollowHero then
		local heroPos = self.Hero:GetCameraFocusPosition()
		local validCameraPosition = self:GetRestrictedCameraPosition(heroPos)

		if not self.Hero:IsMoving() and (validCameraPosition - self.MainCamera.transform.position).magnitude < 0.1 then
			self.CameraFollowHero = false
		else
			local targetPos = Vector3.Lerp(self.MainCamera.transform.position, heroPos, 0.1)

			self:MoveCamera(targetPos)
		end
	end
end

function m:OpenHeroCell()
	self.Hero:SetOpeningCell(true)
	self.Hero.Node:PlayOpenCell()
end

function m:FindPath(node)
	local movePathNodes = {}
	local rawPathNodes = self.PathFinder:FindPath(self.Hero.Node.IndexX + 1, self.Hero.Node.IndexY + 1, node.IndexX + 1, node.IndexY + 1)

	if rawPathNodes ~= nil then
		for i = 2, #rawPathNodes do
			local pathNode = rawPathNodes[i]
			local lNode = self:GetNodeByXY(pathNode.x - 1, pathNode.y - 1)

			if lNode == nil then
				logError("寻路错误：找不到节点：[" .. pathNode.x - 1 .. ", " .. pathNode.y - 1 .. "]. 最终目标节点id：" .. node.CellCid .. "，位置：" .. "[" .. node.IndexX .. ", " .. node.IndexY .. "]")

				return movePathNodes
			end

			table.insert(movePathNodes, lNode)
		end
	end

	return movePathNodes
end

function m:GetNodeByXY(x, y)
	local yNodes = self.Nodes[x]

	if yNodes == nil then
		return nil
	end

	return yNodes[y]
end

function m:GetNodeByInstanceID(instanceID)
	for indexX, yNodes in pairs(self.Nodes) do
		for indexY, node in pairs(yNodes) do
			if node.View:GetInstanceID() == instanceID then
				return node
			end
		end
	end

	return nil
end

function m:ShowNpc(entityId)
	local element = DreamlandElement.New(entityId, self.ElementRoot, self.Hero.Node)

	table.insert(self.Elements, element)

	self.Hero.gameObject.transform.position = self.Hero.Node:GetHeroNodePos()

	local faceToNpcDir = self.Hero.Node:GetFaceToNpcDir()

	self.Hero:LookAtDirection(faceToNpcDir)
end

function m:StartGather()
	self.Hero:SetExecState(DreamExecStateEnum.Gather, true)

	for i = 1, #self.Elements do
		local element = self.Elements[i]

		if not element.IsHero and element.Node.IndexX == self.Hero.Node.IndexX and element.Node.IndexY == self.Hero.Node.IndexY then
			element:SetExecState(DreamExecStateEnum.Gather, true)
		end
	end
end

function m:StartFight()
	self.Hero:SetExecState(DreamExecStateEnum.Fight, true)

	for i = 1, #self.Elements do
		local element = self.Elements[i]

		if not element.IsHero and element.Node.IndexX == self.Hero.Node.IndexX and element.Node.IndexY == self.Hero.Node.IndexY then
			element:SetExecState(DreamExecStateEnum.Fight, true)
		end
	end
end

function m:ShowResetMap()
	GameEntry.Effect:PlayMountPointEffect(2010006, Constant.MountPoint.PointRoot, 0, DreamlandModule.DreamlandScene.MainCamera.gameObject, 0, 0, LayerMask.NameToLayer("Default"), LuaCodeInterface.SortingLayerNameToID("Element"), Constant.Unity.SortingOrderMaxValue, 1, false)
	GameEntry.Sound:PlaySound(10528, Constant.SoundGroup.ENVIRONMENT)
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DreamlandResetEffect, true)

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Dreamland, function()
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DreamlandResetEffect, false)
		DreamlandModule.DreamlandScene:ResetMap()
	end, 1)

	timer:Start()
end

function m:ResetMap()
	for i = 1, #self.Elements do
		local element = self.Elements[i]

		if element ~= self.Hero then
			element:SetRemoved()
		end
	end

	self:RefreshAllNode()
	self:ResetHeroPos()
	self.StateMachineMgr:SetTrigger(self.Hero, "refreshMap")
	self:LockInputOnInit(2)
end

function m:LockInputOnInit(duration)
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DreamlandInit, true)

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Dreamland, function()
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DreamlandInit, false)
	end, duration)

	timer:Start()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	SoundPackagePlayer.Remove(self.SoundPackageId)
	GameEntry.Timer:RemoveRender(self.DelegateOnTimerUpdate)
	self:RemoveListeners()

	for i = 1, #self.Elements do
		local element = self.Elements[i]

		element:Dispose()
	end

	for indexX, yNodes in pairs(self.Nodes) do
		for indexY, node in pairs(yNodes) do
			node:Dispose()
		end
	end

	self.InputMgr:Dispose()
	self.StateMachineMgr:Dispose()

	self.SoundPackageId = 0
	self.BgLoadComplete = false
	self.HeroLoadComplete = false
	self.TwoDimensionSeriesComponents = nil
	self.IsReadyToStart = false
	self.MainCamera = nil
	self.MapRoot = nil
	self.ElementRoot = nil
	self.NodeMinX = 0
	self.NodeMinY = 0
	self.NodeMaxX = 0
	self.NodeMaxY = 0
end

return m
