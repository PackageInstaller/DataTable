-- chunkname: @IQIGame\\Scene\\DualTeamExplore\\DualTeamExploreScene.lua

local DualTeamExploreNode = require("IQIGame.Scene.DualTeamExplore.DualTeamExploreNode")
local DualTeamExploreHero = require("IQIGame.Scene.DualTeamExplore.DualTeamExploreHero")
local DualTeamExploreElement = require("IQIGame.Scene.DualTeamExplore.DualTeamExploreElement")
local DualTeamExplorePath = require("IQIGame.Scene.DualTeamExplore.DualTeamExplorePath")
local PathFinder = require("IQIGame.Scene.DualTeamExplore.Path.DualTeamExplorePathFinder")
local DualTeamExploreInputManager = require("IQIGame.Scene.DualTeamExplore.Input.DualTeamExploreInputManager")
local m = {
	CameraAnimDuration = 0,
	NodeMaxX = 0,
	IsActive = true,
	IsPlayingMoveCameraAnimation = false,
	HeroLoadCompleteCount = 0,
	CameraFollowHero = false,
	NodeMaxY = 0,
	CameraAnimMoveElapsedTime = 0,
	IsReadyToStart = false,
	SoundPackageId = 0,
	Nodes = {},
	Paths = {},
	NodeMinX = Constant.Number.IntMaxValue,
	NodeMinY = Constant.Number.IntMaxValue,
	NodeElementsMap = {},
	Heroes = {}
}

function m.New()
	local obj = Clone(m)

	return obj
end

function m:Init()
	function self.DelegateOnTimerUpdate()
		self:OnTimerUpdate()
	end

	function self.DelegateOnEntityLoaded(isSuccess)
		self:OnEntityLoaded(isSuccess)
	end

	self:AddListeners()

	local mainCameraGo = UnityEngine.GameObject.Find("Main Camera")

	self.MainCamera = mainCameraGo:GetComponent("Camera")
	self.MapRoot = UnityEngine.GameObject.Find("MapRoot").transform
	self.ElementRoot = self.MapRoot:Find("Element")
	self.PathRoot = self.MapRoot:Find("Path")
	self.UIEffectCanvas = UnityEngine.GameObject.Find("UIMountPointCanvas")
	self.UIEffectCanvas:GetComponent("Canvas").worldCamera = GameEntry.UICamera
	self.CfgDualTeamExploreLevelData = CfgDualTeamExploreLevelTable[DualTeamExploreModule.LevelPOD.levelCid]
	self.InputMgr = DualTeamExploreInputManager.New()
	self.StateMachineMgr = StateMachineMgr.New()

	GameEntry.Timer:AddFrameRender(1, self.DelegateOnTimerUpdate, true)

	self.PathFinder = PathFinder.New()

	self:InitBGM()
	self:InitBG()
	self:LockInputOnInit(2)
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.DualTeamExploreEntityLoaded, self.DelegateOnEntityLoaded)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.DualTeamExploreEntityLoaded, self.DelegateOnEntityLoaded)
end

function m:InitBGM()
	local package = SoundPackageData.New(self.CfgDualTeamExploreLevelData.BGM, nil)

	self.SoundPackageId = SoundPackagePlayer.Add(package)
end

function m:InitBG()
	AssetUtil.LoadAsset(self, UIGlobalApi.GetPrefabRoot(self.CfgDualTeamExploreLevelData.ExploreLevel), self.OnLoadBgSuccess)
end

function m:OnLoadBgSuccess(assetName, asset, duration, userData)
	local background = UnityEngine.Object.Instantiate(asset)

	background.transform:SetParent(self.MapRoot, false)

	local dualTeamExploreNodeComponents = background:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.DualTeamExploreNodeComponent), true)

	self:InitNodes(dualTeamExploreNodeComponents)
	self:InitPaths()
	self:InitElements()
	self:InitHeroes()
end

function m:InitHeroes()
	for i = 1, 2 do
		local cfgSoulResData = DualTeamExploreModule.GetLeaderResCfgData(i)
		local hero = DualTeamExploreHero.New(cfgSoulResData.EntityId, self.ElementRoot, i, function()
			self.HeroLoadCompleteCount = self.HeroLoadCompleteCount + 1
		end)

		self.Heroes[i] = hero
	end
end

function m:InitElements()
	self.InitLoadElementNum = 0

	for id, nodeData in pairs(DualTeamExploreModule.NodeDataMap) do
		local elementNum = self:ShowElement(nodeData)

		self.InitLoadElementNum = self.InitLoadElementNum + elementNum
	end
end

function m:ShowElement(nodeData)
	local loadElementNum = 0
	local elementsData = self.NodeElementsMap[nodeData.id]

	if elementsData == nil then
		elementsData = {}
		self.NodeElementsMap[nodeData.id] = elementsData
	end

	local cfgDualTeamExploreCellDataData = CfgDualTeamExploreCellDataTable[nodeData.cid]

	if elementsData.npc == nil and cfgDualTeamExploreCellDataData.NPC ~= 0 or elementsData.npc ~= nil and elementsData.npc.EntityCid ~= cfgDualTeamExploreCellDataData.NPC then
		self:RemoveElement(nodeData.id, false)

		if cfgDualTeamExploreCellDataData.NPC ~= 0 then
			loadElementNum = loadElementNum + 1

			local npcElement = DualTeamExploreElement.New(cfgDualTeamExploreCellDataData.NPC, self.ElementRoot, nodeData)

			elementsData.npc = npcElement
		end
	end

	if elementsData.building == nil and cfgDualTeamExploreCellDataData.Building ~= 0 or elementsData.building ~= nil and elementsData.building.EntityCid ~= cfgDualTeamExploreCellDataData.Building then
		self:RemoveElement(nodeData.id, true)

		if cfgDualTeamExploreCellDataData.Building ~= 0 then
			loadElementNum = loadElementNum + 1

			local buildingElement = DualTeamExploreElement.New(cfgDualTeamExploreCellDataData.Building, self.ElementRoot, nodeData)

			elementsData.building = buildingElement
		end
	end

	return loadElementNum
end

function m:InitNodes(nodeComponents)
	for i = 0, nodeComponents.Length - 1 do
		local component = nodeComponents[i]
		local node = DualTeamExploreNode.New(component.gameObject, component.id)

		self.Nodes[node.id] = node
		self.NodeMinX = math.min(self.NodeMinX, node.gameObject.transform.position.x)
		self.NodeMinY = math.min(self.NodeMinY, node.gameObject.transform.position.y)
		self.NodeMaxX = math.max(self.NodeMaxX, node.gameObject.transform.position.x)
		self.NodeMaxY = math.max(self.NodeMaxY, node.gameObject.transform.position.y)
	end

	self:RefreshAllNode()
	self.PathFinder:InitMap(DualTeamExploreModule.NodeDataMap)
end

function m:RefreshAllNode()
	for id, nodeData in pairs(DualTeamExploreModule.NodeDataMap) do
		self:RefreshNode(nodeData)
	end
end

function m:RefreshNode(nodeData)
	local node = self:GetNodeById(nodeData.id)

	if node == nil then
		logError("找不到节点：" .. nodeData.id .. "，请检查预设")
	end

	node:__SetData(nodeData)
end

function m:InitPaths()
	local tempPaths = {}

	for id, nodeData in pairs(DualTeamExploreModule.NodeDataMap) do
		for i = 1, #nodeData.nextNodes do
			local nextNodeData = nodeData.nextNodes[i]
			local isConnectedReversely = false

			for j = 1, #tempPaths do
				local tempPath = tempPaths[j]

				if tempPath.node2.id == nodeData.id and tempPath.node1.id == nextNodeData.id then
					isConnectedReversely = true
					tempPath.isConnectedReversely = true

					break
				end
			end

			if not isConnectedReversely then
				table.insert(tempPaths, {
					isConnectedReversely = false,
					node1 = nodeData,
					node2 = nextNodeData
				})
			end
		end
	end

	self.InitLoadPathNum = #tempPaths

	for i = 1, #tempPaths do
		local tempPath = tempPaths[i]
		local path = DualTeamExplorePath.New(tempPath.node1, tempPath.node2, self.PathRoot, tempPath.isConnectedReversely)

		table.insert(self.Paths, path)
	end
end

function m:OnEntityLoaded(isSuccess)
	self:CheckLoadComplete()
end

function m:CheckLoadComplete()
	if self.HeroLoadCompleteCount == 2 and self:IsAllPathLoadedAtInit() and self:IsAllElementLoadedAtInit() and not self.IsReadyToStart then
		self:ResetAllHeroPos()
		self:RefreshHeroShow()

		self.IsReadyToStart = true

		GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.DualTeamExplore))
		DualTeamExploreModule.StartLevel()
	end
end

function m:IsAllPathLoadedAtInit()
	if self.InitLoadPathNum == nil then
		return false
	end

	local loadedNum = 0

	for i = 1, #self.Paths do
		local path = self.Paths[i]

		if not path.IsLoading then
			loadedNum = loadedNum + 1
		end
	end

	return loadedNum >= self.InitLoadPathNum
end

function m:IsAllElementLoadedAtInit()
	if self.InitLoadElementNum == nil then
		return false
	end

	local loadedNum = 0

	for nodeId, elementsData in pairs(self.NodeElementsMap) do
		if elementsData.npc ~= nil and not elementsData.npc.IsLoading then
			loadedNum = loadedNum + 1
		end

		if elementsData.building ~= nil and not elementsData.building.IsLoading then
			loadedNum = loadedNum + 1
		end
	end

	return loadedNum >= self.InitLoadElementNum
end

function m:ResetAllHeroPos()
	for teamIndex, hero in pairs(self.Heroes) do
		local nodeData = DualTeamExploreModule.GetHeroNodeData(teamIndex)

		hero:SetNode(nodeData)
		hero:StopMove()
	end

	local currentHero = self.Heroes[DualTeamExploreModule.GetCurrentTeamIndex()]

	self:MoveCamera(currentHero:GetCameraFocusPosition())
end

function m:RefreshHeroShow()
	for teamIndex, hero in pairs(self.Heroes) do
		hero:SetActive(DualTeamExploreModule.IsSeparate() or teamIndex == DualTeamExploreModule.GetCurrentTeamIndex())
	end
end

function m:SetSingleHeroPos(hero, nodeData, byMove)
	hero:SetNode(nodeData, byMove)
	hero:StopMove()
	self:MoveCamera(hero:GetCameraFocusPosition())
end

function m:LockInputOnInit(duration)
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DualTeamExploreInit, true)

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.DualTeamExplore, function()
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DualTeamExploreInit, false)
	end, duration)

	timer:Start()
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
	self:UpdateCameraFollowHero()
	self:UpdateCameraAnimation()
end

function m:SetActive(value)
	self.IsActive = value
	self.MainCamera.enabled = value

	local colliders = self.MapRoot:GetComponentsInChildren(typeof(UnityEngine.Collider2D))

	for i = 0, colliders.Length - 1 do
		colliders[i].enabled = value
	end

	self.StateMachineMgr:SetActive(value)
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DualTeamExploreSceneActive, not value)
end

function m:RemoveElement(nodeId, isBuilding)
	local elementsData = self.NodeElementsMap[nodeId]

	if elementsData == nil then
		logError("移除元素错误，NodeElementsMap中未找到节点id：" .. tostring(nodeId))

		return
	end

	local element

	if isBuilding then
		element = elementsData.building
		elementsData.building = nil
	else
		element = elementsData.npc
		elementsData.npc = nil
	end

	if element ~= nil then
		element:Dispose()
	end
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
	local nodeLeftMarginX = DualTeamExploreSceneApi:GetString("NodeLeftMarginX")
	local nodeBottomMarginY = DualTeamExploreSceneApi:GetString("NodeBottomMarginY")
	local nodeRightMarginX = DualTeamExploreSceneApi:GetString("NodeRightMarginX")
	local nodeTopMarginY = DualTeamExploreSceneApi:GetString("NodeTopMarginY")

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
	if self.CameraFollowHero then
		return
	end

	local currentHero = self.Heroes[DualTeamExploreModule.GetCurrentTeamIndex()]

	if node.id == currentHero.NodeData.id then
		return
	end

	if currentHero:IsMoving() then
		return
	end

	local teamIndexes = {}

	if DualTeamExploreModule.IsSeparate() then
		table.insert(teamIndexes, DualTeamExploreModule.GetCurrentTeamIndex())
	else
		for i = 1, 2 do
			table.insert(teamIndexes, i)
		end
	end

	for i = 1, #teamIndexes do
		local activeTeamIndex = teamIndexes[i]
		local teamPOD = DualTeamExploreModule.GetTeam(activeTeamIndex)

		if teamPOD.stop then
			warning("当前队伍不能行动")

			return
		end
	end

	self:MoveToNode(node.NodeData)
end

function m:MoveToNode(nodeData)
	local activeHeroes = self:GetActiveHeroes()
	local moveResult, nextNodeData
	local pathNodes = self.PathFinder:FastFindPath(activeHeroes[1].NodeData.id, nodeData.id)

	for i = 1, #activeHeroes do
		local moveResult2, nextNodeData2 = self:HeroMoveToNode(activeHeroes[i], nodeData, pathNodes, #activeHeroes)

		if moveResult ~= nil and moveResult2 ~= moveResult then
			logError("两个Hero均可行动，但行动结果不同。Hero1 move result: " .. moveResult .. " Hero2 move result: " .. moveResult2)

			moveResult = Constant.DualTeamExploreMoveResult.Fail
			nextNodeData = nil
		else
			moveResult = moveResult2
			nextNodeData = nextNodeData2
		end
	end

	self:HandleMoveResult(moveResult, nextNodeData)

	if moveResult == Constant.DualTeamExploreMoveResult.Success then
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DualTeamExploreMove, true)
	end
end

function m:HandleMoveResult(moveResult, nextNodeData)
	if moveResult == Constant.DualTeamExploreMoveResult.NeedSeparate then
		DualTeamExploreModule.ShowSeparateConfirmUI(function(index)
			local lNextNodeData = nextNodeData

			if lNextNodeData.occupierTeamId ~= 0 and lNextNodeData.occupierTeamId ~= index then
				NoticeModule.ShowNotice(84500002)

				return
			end

			DualTeamExploreModule.LevelPOD.separate = true

			DualTeamExploreModule.SetCurrentTeam(index, true)
			self:RefreshHeroShow()
			EventDispatcher.Dispatch(EventID.DualTeamExploreSeparateOrUnite)
			self:MoveToNode(lNextNodeData)
		end)
	elseif moveResult == Constant.DualTeamExploreMoveResult.Occupied then
		NoticeModule.ShowNotice(84500002)
	end
end

function m:HeroMoveToNode(hero, targetNodeData, pathNodes, activeTeamNum)
	if pathNodes == nil or #pathNodes <= 1 then
		return Constant.DualTeamExploreMoveResult.Fail, nil
	end

	local nextNode = pathNodes[2]

	if activeTeamNum > nextNode.capacity then
		return Constant.DualTeamExploreMoveResult.NeedSeparate, nextNode
	end

	if nextNode.capacity == 1 and nextNode.occupierTeamId ~= 0 and nextNode.occupierTeamId ~= hero.TeamIndex then
		return Constant.DualTeamExploreMoveResult.Occupied, nil
	end

	hero.MoveFinalNode = targetNodeData

	hero:SetMoveNextNodeData(nextNode)

	self.CameraFollowHero = true
	hero.MoveStartPosition = hero.gameObject.transform.position
	hero.MoveDuration = (hero.MoveNextPosition - hero.MoveStartPosition).magnitude / hero.MoveSpeed
	hero.MoveElapsedTime = 0

	local node = self:GetNodeById(nextNode.id)
	local dir = node:GetPos().x - hero.gameObject.transform.position.x

	hero:LookAtDirection(dir)

	return Constant.DualTeamExploreMoveResult.Success, nextNode
end

function m:UpdateHeroMove()
	local stopHeroNum = 0

	for i = 1, #self.Heroes do
		local hero = self.Heroes[i]

		hero:Update()

		if not hero:IsMoving() then
			stopHeroNum = stopHeroNum + 1
		end
	end

	if stopHeroNum == #self.Heroes then
		self.UpdateTempActiveHeroesCache = nil

		return
	end

	if self.UpdateTempActiveHeroesCache == nil then
		self.UpdateTempActiveHeroesCache = self:GetActiveHeroes()
	end

	local activeHeroes = self.UpdateTempActiveHeroesCache
	local moveResult, nextNodeData, pathNodes

	for i = 1, #activeHeroes do
		local hero = activeHeroes[i]

		if hero:IsMoving() then
			hero.MoveElapsedTime = hero.MoveElapsedTime + UnityEngine.Time.deltaTime

			local lerpValue = hero.MoveElapsedTime / hero.MoveDuration

			hero.gameObject.transform.position = Vector3.Lerp(hero.MoveStartPosition, hero.MoveNextPosition, lerpValue)

			if lerpValue >= 1 then
				lerpValue = 1
			end

			if lerpValue == 1 then
				local currentNode = hero.MoveNextNode

				hero:SetNode(currentNode, true)

				if hero.IsActive then
					self:SendArriveNode(currentNode)
				end

				if currentNode.id ~= hero.MoveFinalNode.id then
					if pathNodes == nil then
						pathNodes = self.PathFinder:FastFindPath(hero.NodeData.id, hero.MoveFinalNode.id)
					end

					local innerMoveResult, innerNextNodeData = self:HeroMoveToNode(hero, hero.MoveFinalNode, pathNodes, #activeHeroes)

					if moveResult ~= nil and innerMoveResult ~= moveResult then
						logError("两个Hero均可行动，但行动结果不同。Hero1 move result: " .. moveResult .. " Hero2 move result: " .. innerMoveResult)

						moveResult = Constant.DualTeamExploreMoveResult.Fail
						nextNodeData = nil
					else
						moveResult = innerMoveResult
						nextNodeData = innerNextNodeData
					end

					if innerMoveResult ~= Constant.DualTeamExploreMoveResult.Success then
						hero:StopMove()
					end
				else
					hero:StopMove()
				end
			end
		end
	end

	if moveResult ~= nil then
		self:HandleMoveResult(moveResult, nextNodeData)
	end
end

function m:UpdateCameraFollowHero()
	if self.CameraFollowHero and not self.IsPlayingMoveCameraAnimation then
		local currentHero = self.Heroes[DualTeamExploreModule.GetCurrentTeamIndex()]
		local heroPos = currentHero:GetCameraFocusPosition()
		local validCameraPosition = self:GetRestrictedCameraPosition(heroPos)

		if not currentHero:IsMoving() and (validCameraPosition - self.MainCamera.transform.position).magnitude < 0.1 then
			self.CameraFollowHero = false
		else
			local targetPos = Vector3.Lerp(self.MainCamera.transform.position, heroPos, 0.1)

			self:MoveCamera(targetPos)
		end
	end
end

function m:UpdateCameraAnimation()
	if self.CameraAnimTargetPosition ~= nil then
		self.CameraAnimMoveElapsedTime = self.CameraAnimMoveElapsedTime + UnityEngine.Time.deltaTime

		local lerpValue = self.CameraAnimMoveElapsedTime / self.CameraAnimDuration

		self.MainCamera.gameObject.transform.position = Vector3.Lerp(self.CameraAnimStartPosition, self.CameraAnimTargetPosition, lerpValue)

		if lerpValue >= 1 then
			lerpValue = 1
		end

		if lerpValue == 1 then
			if self.CameraAnimCompleteCallback ~= nil then
				self.CameraAnimCompleteCallback()
			end

			self.CameraAnimStartPosition = nil
			self.CameraAnimTargetPosition = nil
			self.CameraAnimDuration = nil
			self.CameraAnimCompleteCallback = nil
			self.CameraAnimMoveElapsedTime = 0
		end
	end
end

function m:MoveCameraToCurrentHero()
	self.CameraFollowHero = true
end

function m:IsLockingInput()
	return self.InputMgr:IsLock()
end

function m:SendArriveNode(nodeData)
	DualTeamExploreModule.SendArriveNode(nodeData.id)
end

function m:OnResponseMoveArrived(teamId, nodeId, isStop, hasClientState)
	local mainHero = self.Heroes[teamId]
	local activeHeroes = {}

	table.insert(activeHeroes, mainHero)

	if not DualTeamExploreModule.IsSeparate() then
		if teamId == 1 then
			table.insert(activeHeroes, self.Heroes[2])
		else
			table.insert(activeHeroes, 1, self.Heroes[1])
		end
	end

	local hasTransformComplete = false

	for i = 1, #activeHeroes do
		local hero = activeHeroes[i]

		if hero.TransportTargetNodeId ~= nil and hero.TransportTargetNodeId == nodeId then
			hasTransformComplete = true

			hero:SetTransportArrived()
		end
	end

	if hasTransformComplete then
		warning("服务器确认传送完毕，解锁操作。TeamId：" .. tostring(teamId) .. "，NodeId：" .. tostring(nodeId) .. "，IsStop：" .. tostring(isStop))
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DualTeamExploreTransport, false)
	end

	if isStop or hasClientState then
		for i = 1, #activeHeroes do
			local hero = activeHeroes[i]
			local nodeData

			if nodeId == 0 then
				nodeData = DualTeamExploreModule.GetHeroNodeData(hero.TeamIndex)
			else
				nodeData = DualTeamExploreModule.GetNodeDataById(nodeId)
			end

			self:SetSingleHeroPos(hero, nodeData, true)
		end
	end
end

function m:GetNodeById(id)
	return self.Nodes[id]
end

function m:GetNodeByInstanceID(instanceID)
	for id, node in pairs(self.Nodes) do
		if node.gameObject:GetInstanceID() == instanceID then
			return node
		end
	end

	return nil
end

function m:GetActiveHeroes()
	local teamIndexes = DualTeamExploreModule.GetActiveTeamIndexes()
	local activeHeroes = {}

	for i = 1, #teamIndexes do
		table.insert(activeHeroes, self.Heroes[teamIndexes[i]])
	end

	return activeHeroes
end

function m:RefreshPathBetween(startNodeData, endNodeData, isAdd)
	local targetPath

	for i = 1, #self.Paths do
		local path = self.Paths[i]

		if path.StartNodeData.id == startNodeData.id and path.EndNodeData.id == endNodeData.id or path.EndNodeData.id == startNodeData.id and path.StartNodeData.id == endNodeData.id then
			targetPath = path

			break
		end
	end

	local directions = {}

	if targetPath ~= nil then
		directions[1] = {
			startId = targetPath.StartNodeData.id,
			endId = targetPath.EndNodeData.id
		}

		if targetPath.IsConnectedReversely then
			directions[2] = {
				startId = targetPath.EndNodeData.id,
				endId = targetPath.StartNodeData.id
			}
		end
	end

	if isAdd then
		if #directions == 2 then
			return
		end

		if #directions == 1 then
			local pathData = directions[1]

			if pathData.startId == startNodeData.id then
				return
			end
		end

		if targetPath ~= nil then
			targetPath.IsConnectedReversely = true

			return
		end

		local path = DualTeamExplorePath.New(startNodeData, endNodeData, self.PathRoot, false)

		table.insert(self.Paths, path)
	else
		if #directions == 0 then
			return
		end

		if #directions == 1 then
			local pathData = directions[1]

			if pathData.startId ~= startNodeData.id then
				return
			end
		end

		local index = table.indexOf(self.Paths, targetPath)

		table.remove(self.Paths, index)
		targetPath:Dispose()

		if #directions == 2 then
			local path = DualTeamExplorePath.New(endNodeData, startNodeData, self.PathRoot, false)

			table.insert(self.Paths, path)
		end
	end
end

function m:ChangeGatherState(value)
	local activeHeroes = self:GetActiveHeroes()

	for i = 1, #activeHeroes do
		local hero = activeHeroes[i]

		hero:SetExecState(DualTeamExploreExecStateEnum.Gather, value)
	end
end

function m:TransportActiveHeroesTo(mode, nodeId)
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DualTeamExploreTransport, true)

	local targetNodeData = DualTeamExploreModule.GetNodeDataById(nodeId)
	local activeHeroes = self:GetActiveHeroes()

	warning("开始传送。Mode：" .. tostring(mode) .. "，NodeId：" .. tostring(nodeId) .. "，被传送的人偶数量：" .. #activeHeroes)

	for i = 1, #activeHeroes do
		local hero = activeHeroes[i]

		hero:StopMove()
		hero:StartTransport(targetNodeData.id)
	end

	if mode == 1 then
		GameEntry.Effect:PlayUIMountPointEffect(9000921, 50000, 0, self.UIEffectCanvas, Constant.Unity.SortingOrderMaxValue - 1)
	end
end

function m:PlayCameraAnimation(showCidList)
	DualTeamExploreModule.Adaptor:CommandSwitch(false)

	self.IsPlayingMoveCameraAnimation = true

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DualTeamExplorePlayMoveCamera, true)

	self.MoveCameraShowCidList = table.clone(showCidList)

	self:MoveCameraToNextNode()
end

function m:MoveCameraToNextNode()
	if #self.MoveCameraShowCidList > 0 then
		local mazeScreenSwitchCid = self.MoveCameraShowCidList[1]

		table.remove(self.MoveCameraShowCidList, 1)

		local cfgDualTeamExploreShowData = CfgDualTeamExploreShowTable[mazeScreenSwitchCid]

		if cfgDualTeamExploreShowData.SwitchMode == 2 then
			GameEntry.Effect:PlayUIMountPointEffect(9000921, 50000, 0, self.UIEffectCanvas, Constant.Unity.SortingOrderMaxValue - 1)
		end

		local transportDelay = cfgDualTeamExploreShowData.SwitchMode == 2 and 1 or 0

		if cfgDualTeamExploreShowData.NodeId ~= 0 then
			local targetNode = self:GetNodeById(cfgDualTeamExploreShowData.NodeId)

			if targetNode == nil then
				logError("镜头找不到对应的格子。Node cid: " .. cfgDualTeamExploreShowData.NodeId)
				self:MoveCameraToNextNode()

				return
			end

			self:MoveCameraTo(targetNode.gameObject.transform.position, cfgDualTeamExploreShowData.Delay + transportDelay, cfgDualTeamExploreShowData.MoveTime, function()
				local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.DualTeamExplore, function()
					self:MoveCameraToNextNode()
				end, transportDelay)

				timer:Start()
			end)
		else
			local activeHeroes = self:GetActiveHeroes()
			local sampleHero = activeHeroes[1]

			self:MoveCameraTo(sampleHero:GetCameraFocusPosition(), cfgDualTeamExploreShowData.Delay + transportDelay, cfgDualTeamExploreShowData.MoveTime, function()
				local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.DualTeamExplore, function()
					self:MoveCameraToNextNode()
				end, transportDelay)

				timer:Start()
			end)
		end
	else
		self:PlayMoveCameraComplete()
	end
end

function m:MoveCameraTo(position, delay, duration, onComplete)
	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.DualTeamExplore, function()
		self.CameraAnimStartPosition = self.MainCamera.gameObject.transform.position

		local targetPosition = self:GetRestrictedCameraPosition(position)

		targetPosition.z = self.CameraAnimStartPosition.z
		self.CameraAnimTargetPosition = targetPosition
		self.CameraAnimDuration = duration
		self.CameraAnimCompleteCallback = onComplete
	end, delay)

	timer:Start()
end

function m:PlayMoveCameraComplete()
	DualTeamExploreModule.Adaptor:CommandSwitch(true)

	self.IsPlayingMoveCameraAnimation = false

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DualTeamExplorePlayMoveCamera, false)
end

function m:PlayQuickFight(duration)
	local activeHeroes = DualTeamExploreModule.DualTeamExploreScene:GetActiveHeroes()
	local sampleHero = activeHeroes[1]
	local node = DualTeamExploreModule.DualTeamExploreScene:GetNodeById(sampleHero.NodeData.id)

	GameEntry.Effect:PlayNormalEffect(9000910, node:GetPos(), 0, duration, 0, LuaCodeInterface.SortingLayerNameToID("Element"), Constant.Unity.SortingOrderMaxValue)
end

function m:SuspendHeroesMove()
	local activeHeroes = DualTeamExploreModule.DualTeamExploreScene:GetActiveHeroes()

	for i, hero in pairs(activeHeroes) do
		local nodeData

		if DualTeamExploreModule.UnConfirmedMoveNodeIds.Size > 0 then
			local nodeId = DualTeamExploreModule.UnConfirmedMoveNodeIds:Peek()

			nodeData = DualTeamExploreModule.GetNodeDataById(nodeId)
		else
			nodeData = DualTeamExploreModule.GetHeroNodeData(hero.TeamIndex)
		end

		hero:SetNode(nodeData)
		hero:StopMove()
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	GameEntry.Timer:RemoveRender(self.DelegateOnTimerUpdate)
	self:RemoveListeners()

	for nodeId, elementsData in pairs(self.NodeElementsMap) do
		self:RemoveElement(nodeId, true)
		self:RemoveElement(nodeId, false)
	end

	for i = 1, #self.Heroes do
		local hero = self.Heroes[i]

		hero:Dispose()
	end

	for i = 1, #self.Paths do
		local path = self.Paths[i]

		path:Dispose()
	end

	for id, node in pairs(self.Nodes) do
		node:Dispose()
	end

	self.InputMgr:Dispose()
	self.StateMachineMgr:Dispose()
	self.PathFinder:Dispose()
	SoundPackagePlayer.Remove(self.SoundPackageId)

	self.SoundPackageId = 0
	self.MainCamera = nil
	self.MapRoot = nil
	self.ElementRoot = nil
	self.PathRoot = nil
	self.UIEffectCanvas = nil
end

return m
