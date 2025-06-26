-- chunkname: @IQIGame\\Scene\\MagicTower\\MagicTowerScene.lua

local MagicTowerHero = require("IQIGame.Scene.MagicTower.MagicTowerHero")
local MagicTowerElement = require("IQIGame.Scene.MagicTower.MagicTowerElement")
local MagicTowerNode = require("IQIGame.Scene.MagicTower.MagicTowerNode")
local MagicTowerInputManager = require("IQIGame.Scene.MagicTower.Input.MagicTowerInputManager")
local m = {
	CameraFollowHero = false,
	NodeMaxY = 0,
	StartRefreshMap = false,
	LoadEntityNum = 0,
	IsActive = true,
	InitLoadEntityNum = 0,
	NodeMaxX = 0,
	RefreshMapEffectId = 0,
	BgLoadComplete = false,
	IsReadyToStart = false,
	SoundPackageId = 0,
	Elements = {},
	Nodes = {},
	NodeXYMap = {},
	NodeMinX = Constant.Number.IntMaxValue,
	NodeMinY = Constant.Number.IntMaxValue
}

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	function self.DelegateOnTimerUpdate()
		self:OnTimerUpdate()
	end

	function self.DelegateOnEntityLoaded()
		self:OnEntityLoaded()
	end

	function self.DelegateOnEffectShow(sender, args)
		self:OnEffectShow(sender, args)
	end

	self:AddListeners()

	local mainCameraGo = UnityEngine.GameObject.Find("Main Camera")

	self.MainCamera = mainCameraGo:GetComponent("Camera")

	local rootTrans = UnityEngine.GameObject.Find("MagicTower").transform

	self.MapRoot = rootTrans:Find("MapRoot")
	self.NodeRoot = self.MapRoot:Find("Node")
	self.ElementRoot = self.MapRoot:Find("Element")
	self.InputMgr = MagicTowerInputManager.New()
	self.StateMachineMgr = StateMachineMgr.New()

	GameEntry.Timer:AddFrameRender(1, self.DelegateOnTimerUpdate, true)
	UIModule.Open(Constant.UIControllerName.MagicTowerMainUI, Constant.UILayer.DefaultUI)
	self:InitBGM()
	self:InitBG()
	self:InitNodes()
	self:InitHero()
	self:LockInputOnInit(2)
end

function m:AddListeners()
	GameEntry.LuaEvent:Subscribe(EffectShowEventArgs.EventId, self.DelegateOnEffectShow)
	EventDispatcher.AddEventListener(EventID.MagicTowerLoadEntityComplete, self.DelegateOnEntityLoaded)
end

function m:RemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(EffectShowEventArgs.EventId, self.DelegateOnEffectShow)
	EventDispatcher.RemoveEventListener(EventID.MagicTowerLoadEntityComplete, self.DelegateOnEntityLoaded)
end

function m:InitBGM()
	local package = SoundPackageData.New(41, nil)

	self.SoundPackageId = SoundPackagePlayer.Add(package)
end

function m:InitBG()
	AssetUtil.LoadAsset(self, UIGlobalApi.GetPrefabRoot("/ART_Prefabs/Scene/MagicTower/Map/MagicTower_Game1_Chapter1.prefab"), self.OnLoadBgSuccess, self.OnLoadBgFail)
end

function m:OnLoadBgSuccess(assetName, asset, duration, userData)
	local background = UnityEngine.Object.Instantiate(asset)

	background.transform:SetParent(self.MapRoot, false)

	self.BgLoadComplete = true

	self:CheckLoadComplete()
end

function m:OnLoadBgFail(assetName, status, errorMessage, userData)
	self.BgLoadComplete = true

	self:CheckLoadComplete()
end

function m:InitHero()
	local cellPOD = MagicTowerModule.GetCellPODByID(MagicTowerModule.MapData.mapPOD.role.cellId)

	self.Hero = MagicTowerHero.New(40500007, self.ElementRoot, cellPOD, #self.Nodes + 1)

	table.insert(self.Elements, self.Hero)

	self.InitLoadEntityNum = self.InitLoadEntityNum + 1
end

function m:CheckLoadComplete()
	if not self.IsReadyToStart then
		if self.BgLoadComplete and self.LoadEntityNum >= self.InitLoadEntityNum then
			self:ResetHeroPos()

			self.IsReadyToStart = true

			GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.CommonActivity))

			self.InitLoadEntityNum = 0
			self.LoadEntityNum = 0
			self.BgLoadComplete = false

			MagicTowerModule.CheckResumeDialog()
		end
	elseif self.StartRefreshMap and self.LoadEntityNum >= self.InitLoadEntityNum then
		self:RefreshMapComplete()
	end
end

function m:OnEntityLoaded()
	self.LoadEntityNum = self.LoadEntityNum + 1

	if self.LoadEntityNum >= self.InitLoadEntityNum then
		self:CheckLoadComplete()
	end
end

function m:ResetHeroPos()
	local heroNodePOD = MagicTowerModule.GetCellPODByID(MagicTowerModule.MapData.mapPOD.role.cellId)

	self.Hero:SetNode(heroNodePOD)
	self.Hero:StopMove()
	self:MoveCamera(self.Hero:GetCameraFocusPosition())
end

function m:InitNodes()
	local curFloorCellPODList = {}
	local cellXYMap = {}
	local cellPosMap = {}

	for i = 1, #MagicTowerModule.MapData.mapPOD.cells do
		local cellPOD = MagicTowerModule.MapData.mapPOD.cells[i]

		if cellPOD.floor == MagicTowerModule.MapData.currentFloor then
			table.insert(curFloorCellPODList, cellPOD)

			local indexX, indexY = MagicTowerModule.NodeSeqXYToIndexXY(MagicTowerModule.MapData.currentFloor, cellPOD.x, cellPOD.y)
			local x, y = MagicTowerModule.NodeIndexXYToPositionXY(indexX, indexY)

			cellXYMap[cellPOD.id] = {
				indexX,
				indexY
			}
			cellPosMap[cellPOD.id] = Vector3(x, y, 0)
		end
	end

	table.sort(curFloorCellPODList, function(pod1, pod2)
		local pos1 = cellPosMap[pod1.id]
		local pos2 = cellPosMap[pod2.id]

		return pos1.y > pos2.y
	end)

	local heroCellPOD = MagicTowerModule.GetCellPODByID(MagicTowerModule.MapData.mapPOD.role.cellId)

	for i = 1, #curFloorCellPODList do
		local cellPOD = curFloorCellPODList[i]
		local xy = cellXYMap[cellPOD.id]
		local position = cellPosMap[cellPOD.id]
		local indexX = xy[1]
		local indexY = xy[2]
		local node = MagicTowerNode.New(cellPOD, self.NodeRoot, position, i)

		self.Nodes[i] = node
		self.NodeXYMap[indexX] = self.NodeXYMap[indexX] or {}
		self.NodeXYMap[indexX][indexY] = node
		self.NodeMinX = math.min(self.NodeMinX, position.x)
		self.NodeMinY = math.min(self.NodeMinY, position.y)
		self.NodeMaxX = math.max(self.NodeMaxX, position.x)
		self.NodeMaxY = math.max(self.NodeMaxY, position.y)
		self.InitLoadEntityNum = self.InitLoadEntityNum + 1

		if cellPOD.x > heroCellPOD.x then
			local cfgMagicTowerCellDataData = CfgMagicTowerCellDataTable[cellPOD.dataId]
			local element = MagicTowerElement.New(cfgMagicTowerCellDataData.EntityId, self.ElementRoot, cellPOD, position, i)

			table.insert(self.Elements, element)

			self.InitLoadEntityNum = self.InitLoadEntityNum + 1
		end
	end
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

function m:KillElementsOnHeroIndexX()
	local heroCellPOD = MagicTowerModule.GetCellPODByID(MagicTowerModule.MapData.mapPOD.role.cellId)

	for i = 1, #self.Elements do
		local element = self.Elements[i]

		if not element.IsHero and element.CellPOD.x == heroCellPOD.x then
			element:SetRemoved()
		end
	end
end

function m:RemoveElement(element)
	local index = table.indexOf(self.Elements, element)

	table.remove(self.Elements, index)
	element:Dispose()
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
	local nodeLeftMarginX = MagicTowerSceneApi:GetString("NodeLeftMarginX")
	local nodeBottomMarginY = MagicTowerSceneApi:GetString("NodeBottomMarginY")
	local nodeRightMarginX = MagicTowerSceneApi:GetString("NodeRightMarginX")
	local nodeTopMarginY = MagicTowerSceneApi:GetString("NodeTopMarginY")

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
	if node.CellPOD.id == self.Hero.CellPOD.id then
		return
	end

	if not self:CanMove() then
		return
	end

	local heroCellPOD = MagicTowerModule.GetCellPODByID(MagicTowerModule.MapData.mapPOD.role.cellId)

	if not MagicTowerModule.IsNearBy(heroCellPOD, node.CellPOD) or node.CellPOD.x - self.Hero.CellPOD.x ~= 1 then
		return
	end

	self:MoveToNode(node.CellPOD)
end

function m:MoveToNode(nextNodePOD)
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MagicTowerMove, true)
	self.Hero:SetMoveNextNodeData(nextNodePOD)

	self.CameraFollowHero = true
	self.Hero.MoveStartPosition = self.Hero.gameObject.transform.position
	self.Hero.MoveDuration = (self.Hero.MoveNextPosition - self.Hero.MoveStartPosition).magnitude / self.Hero.MoveSpeed
	self.Hero.MoveElapsedTime = 0

	local pos = MagicTowerModule.NodeSeqXYToPosition(MagicTowerModule.MapData.currentFloor, nextNodePOD.x, nextNodePOD.y)
	local dir = pos.x - self.Hero.gameObject.transform.position.x

	self.Hero:LookAtDirection(dir)
end

function m:CanMove()
	if self.Hero:IsMoving() then
		return false
	end

	return true
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
			self.Hero:StopMove()
			MagicTowerModule.SendMoveArrive(nextNode.id)
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

function m:GetNodeByXY(x, y)
	local yNodes = self.NodeXYMap[x]

	if yNodes == nil then
		return nil
	end

	return yNodes[y]
end

function m:GetNodeByInstanceID(instanceID)
	for i = 1, #self.Nodes do
		local node = self.Nodes[i]

		if node.gameObject:GetInstanceID() == instanceID then
			return node
		end
	end

	return nil
end

function m:LockInputOnInit(duration)
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MagicTowerInit, true)

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.MagicTower, function()
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MagicTowerInit, false)
	end, duration)

	timer:Start()
end

function m:OnElementStopInteract()
	self.Hero:ResetInteractState()
end

function m:SetHeroNodeState(state)
	self.Hero:SetExecState(state, true)

	for i = 1, #self.Elements do
		local element = self.Elements[i]

		if not element.IsHero and element.CellPOD.id == MagicTowerModule.MapData.mapPOD.role.cellId then
			element:SetExecState(state, true)
		end
	end
end

function m:GoToNextFloor(onComplete)
	self.OnRefreshMapCompleteCallback = onComplete

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MagicTowerResetEffect, true)

	self.RefreshMapEffectId = GameEntry.Effect:PlayMountPointEffect(2010006, Constant.MountPoint.PointRoot, 0, MagicTowerModule.MagicTowerScene.MainCamera.gameObject, 0, 0, LayerMask.NameToLayer("Default"), LuaCodeInterface.SortingLayerNameToID("Element"), Constant.Unity.SortingOrderMaxValue, 1, false)

	GameEntry.Sound:PlaySound(10528, Constant.SoundGroup.ENVIRONMENT)
end

function m:OnEffectShow(sender, args)
	if args.EffectPlayID == self.RefreshMapEffectId then
		local effectId = self.RefreshMapEffectId
		local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.MagicTower, function()
			GameEntry.Effect:SetEffectSpeed(effectId, 0.01)
			MagicTowerModule.MagicTowerScene:RefreshMap()
		end, 1)

		timer:Start()
	end
end

function m:RefreshMap()
	self.StartRefreshMap = true

	for i = #self.Elements, 1, -1 do
		local element = self.Elements[i]

		if not element.IsHero then
			element:Dispose()
			table.remove(self.Elements, i)
		end
	end

	for i = 1, #self.Nodes do
		local node = self.Nodes[i]

		node:Dispose()
	end

	self.Nodes = {}

	self:ResetHeroPos()
	self:InitNodes()
end

function m:RefreshMapComplete()
	GameEntry.Effect:SetEffectSpeed(self.RefreshMapEffectId, 1)

	self.RefreshMapEffectId = 0
	self.StartRefreshMap = false

	self.StateMachineMgr:SetTrigger(self.Hero, "refreshMap")

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.MagicTower, function()
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MagicTowerResetEffect, false)

		if self.OnRefreshMapCompleteCallback ~= nil then
			self.OnRefreshMapCompleteCallback()

			self.OnRefreshMapCompleteCallback = nil
		end
	end, 1)

	timer:Start()
end

function m:UpdateHeroOrder()
	table.sort(self.Elements, function(element1, element2)
		local idxX1, idxY1 = MagicTowerModule.NodeSeqXYToIndexXY(MagicTowerModule.MapData.currentFloor, element1.CellPOD.x, element1.CellPOD.y)
		local idxX2, idxY2 = MagicTowerModule.NodeSeqXYToIndexXY(MagicTowerModule.MapData.currentFloor, element2.CellPOD.x, element2.CellPOD.y)
		local x1, y1 = MagicTowerModule.NodeIndexXYToPositionXY(idxX1, idxY1)
		local x2, y2 = MagicTowerModule.NodeIndexXYToPositionXY(idxX2, idxY2)

		if y1 == y2 then
			local h1 = element1.IsHero and 1 or 0
			local h2 = element2.IsHero and 1 or 0

			if h1 == h2 then
				return false
			end

			return h1 < h2
		end

		return y2 < y1
	end)

	for i = 1, #self.Elements do
		local element = self.Elements[i]

		element:SetSortingOrder(i)
	end
end

function m:Dispose()
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.MagicTower)
	AssetUtil.UnloadAsset(self)
	SoundPackagePlayer.Remove(self.SoundPackageId)
	GameEntry.Timer:RemoveRender(self.DelegateOnTimerUpdate)
	self:RemoveListeners()

	for i = 1, #self.Nodes do
		local node = self.Nodes[i]

		node:Dispose()
	end

	for i = 1, #self.Elements do
		local element = self.Elements[i]

		element:Dispose()
	end

	self.InputMgr:Dispose()
	self.StateMachineMgr:Dispose()

	self.MainCamera = nil
	self.MapRoot = nil
	self.ElementRoot = nil
end

return m
