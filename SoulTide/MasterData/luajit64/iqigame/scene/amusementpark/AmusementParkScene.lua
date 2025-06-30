-- chunkname: @IQIGame\\Scene\\AmusementPark\\AmusementParkScene.lua

local m = {
	IsLockInput = false,
	IsEdit = false,
	DragBuild = 0,
	LastCount = 0,
	NpcWalkAreas = {},
	BuildAreas = {},
	BuildAreaCellPool = {},
	npcPool = {}
}
local AmusementParkCameraCtrl = require("IQIGame.Scene.AmusementPark.AmusementParkCameraCtrl")
local AmusementParkInputManager = require("IQIGame.Scene.AmusementPark.Input.AmusementParkInputManager")
local AmusementParkNpcWalkAreaData = require("IQIGame.Scene.AmusementPark.AmusementParkNpcWalkAreaData")
local AmusementParkBuildAreaData = require("IQIGame.Scene.AmusementPark.AmusementParkBuildAreaData")
local AmusementParkBuildAreaCell = require("IQIGame.Scene.AmusementPark.AmusementParkBuildAreaCell")
local AmusementParkNPC = require("IQIGame.Scene.AmusementPark.AmusementParkNPC")

function m.New()
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init()
	local mainCameraGo = UnityEngine.GameObject.Find("Main Camera")

	self.MainCamera = mainCameraGo:GetComponent("Camera")

	local rootTrans = UnityEngine.GameObject.Find("AmusementPark").transform

	self.MapRoot = rootTrans:Find("MapRoot")

	local path = UIGlobalApi.GetPrefabRoot("/ART_Prefabs/Scene/AmusementPark/Map/Map_01/Map_01.prefab")

	AssetUtil.LoadAsset(self, path, self.OnLoadBGPrefabSuccess, self.OnLoadBgPrefabFail, {
		ShowEffect = false
	})
	GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.CommonActivity))

	self.InputMgr = AmusementParkInputManager.New()
	self.CameraCtrl = AmusementParkCameraCtrl.New(self.MainCamera)
end

function m:InitBuildAreaData()
	self.BuildAreas = {}
	self.BuildAreaCellPool = {}

	for i = 1, self.buildingAreas.transform.childCount do
		local trans = self.buildingAreas.transform:Find("Point_" .. i)

		if trans then
			local buildAreaData = AmusementParkBuildAreaData.New(i)

			self.BuildAreas[i] = buildAreaData

			local buildAreaCell = AmusementParkBuildAreaCell.New(UnityEngine.GameObject.Instantiate(self.BuildAreaMould), self.goNpc)

			buildAreaCell.View:SetActive(true)

			buildAreaCell.View.name = "BuildPos_" .. i

			buildAreaCell.View.transform:SetParent(trans, false)

			self.BuildAreaCellPool[i] = buildAreaCell
		end
	end
end

function m:InitNpcWalkAreaPosData()
	self.NpcWalkAreas = {}

	for i = 1, self.walkAreaRoot.transform.childCount do
		local trans = self.walkAreaRoot.transform:Find("WalkArea_" .. i)

		if trans then
			local walkAreaData = AmusementParkNpcWalkAreaData.New(trans)

			table.insert(self.NpcWalkAreas, walkAreaData)
		end
	end
end

function m:OnLoadBGPrefabSuccess(assetName, asset, duration, innerUserData)
	local showEff = innerUserData.ShowEffect

	self.View = UnityEngine.Object.Instantiate(asset)

	self.View.transform:SetParent(self.MapRoot, false)
	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateTimer()
		self:OnTimerUpdate()
	end

	function self.DelegateAPUpdateInfoPark()
		self:OnUpdateInfoPark()
	end

	function self.DelegateUpdateFinishedTaskOver(cid)
		self:OnUpdateFinishedTaskOver(cid)
	end

	function self.DelegateEditStateEvent(isEdit)
		self:OnEditStateEvent(isEdit)
	end

	self:ShowScene(false)

	function self.DelegateUpdateScenePlayer(positionInformationPOD, lastPost, lastLocation)
		self:OnUpdateScenePlayer(positionInformationPOD, lastPost, lastLocation)
	end

	function self.DelegateUpdateFinishedTaskOver(cid)
		self:OnUpdateFinishedTaskOver(cid)
	end

	self:InitData()
	self:Refresh()
	EventDispatcher.Dispatch(EventID.APCameraChangePosEvent)
	UIModule.Open(Constant.UIControllerName.AmusementParkMainUI, Constant.UILayer.UI)

	self.GameFrameTimer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.AmusementPark, function()
		self:FrameUpdate()
	end, -1, -1)

	self.GameFrameTimer:Start()
end

function m:OnLoadBgPrefabFail(assetName, asset, duration, innerUserData)
	logError(assetName)
end

function m:InitData()
	self:InitBuildAreaData()
	self:InitNpcWalkAreaPosData()
end

function m:Refresh()
	self:RefreshBGM()
	self:AddListeners()
	self:RefreshCamera()
	self:RefreshBuildAreas()
	self:RefreshScenePlayers()
	self:RefreshRegionalBoundary()
end

function m:RefreshRegionalBoundary()
	local count, regionalBoundary = AmusementParkModule.GetRandomPathNum()

	for i = 1, 5 do
		self["AreaBG" .. i]:SetActive(regionalBoundary == i)
	end
end

function m:OnTapObject(gameObject)
	if self.IsLockInput then
		return
	end

	if self.IsEdit then
		return
	end

	local strTab = string.split(gameObject.name, "_")
	local objType = strTab[1]
	local value = tonumber(strTab[2])

	if objType == "BuildPos" then
		if UIModule.HasUI(Constant.UIControllerName.AmusementParkMainBuildUI) then
			EventDispatcher.Dispatch(EventID.APUpdateParkMainBuildUIEvent, self.BuildAreas[value])
		else
			UIModule.Open(Constant.UIControllerName.AmusementParkMainBuildUI, Constant.UILayer.UI, {
				BuildAreaData = self.BuildAreas[value]
			})
		end

		self:RefreshAreaSelect(value)
	elseif objType == "Npc" then
		EventDispatcher.Dispatch(EventID.APNpcTalkEvent, value)
	end
end

function m:RefreshAreaSelect(index)
	for i, v in pairs(self.BuildAreaCellPool) do
		v:SetSelect(v.BuildAreaData.pos == index)
	end
end

function m:RefreshBGM()
	local package = SoundPackageData.New(452, nil)

	self.SoundPackageId = SoundPackagePlayer.Add(package)
end

function m:RefreshCamera()
	if self.MainCamera == nil or LuaCodeInterface.GameObjIsDestroy(self.MainCamera) then
		return
	end

	self.CameraCtrl:Refresh(self.goLimitLeft.transform.position, self.goLimitRight.transform.position, self.goLimitUp.transform.position, self.goLimitDown.transform.position)
end

function m:FrameUpdate()
	return
end

function m:OnTimerUpdate()
	if self.CameraCtrl ~= nil then
		self.CameraCtrl:OnUpdate()
	end

	for i, v in pairs(self.BuildAreaCellPool) do
		v:OnUpdate()
	end

	for i, v in pairs(self.npcPool) do
		v:OnUpdate()
	end
end

function m:ShowScene(top)
	self.View:SetActive(top)
end

function m:AddListeners()
	GameEntry.Timer:AddFrameRender(1, self.DelegateTimer, true)
	EventDispatcher.AddEventListener(EventID.APUpdateInfoEvent, self.DelegateAPUpdateInfoPark)
	EventDispatcher.AddEventListener(EventID.UpdateFinishedTaskOver, self.DelegateUpdateFinishedTaskOver)
	EventDispatcher.AddEventListener(EventID.APEditStateEvent, self.DelegateEditStateEvent)
end

function m:RemoveListeners()
	GameEntry.Timer:RemoveRender(self.DelegateTimer)
	EventDispatcher.RemoveEventListener(EventID.APUpdateInfoEvent, self.DelegateAPUpdateInfoPark)
	EventDispatcher.RemoveEventListener(EventID.UpdateFinishedTaskOver, self.DelegateUpdateFinishedTaskOver)
	EventDispatcher.RemoveEventListener(EventID.APEditStateEvent, self.DelegateEditStateEvent)
end

function m:OnUpdateFinishedTaskOver(cid)
	local cfgMainQuest = CfgMainQuestTable[cid]

	if cfgMainQuest.Type ~= TaskModule.TaskType.AMUSEMENT_PARK_TASK then
		return
	end

	UIModule.Open(Constant.UIControllerName.AmusementParkAchievementTipUI, Constant.UILayer.UI, cid)
end

function m:OnEditStateEvent(isEdit)
	if not isEdit then
		self:RefreshAreaSelect(nil)

		for i, v in pairs(self.BuildAreaCellPool) do
			v.BuildCollider.enabled = false
		end
	end
end

function m:OnUpdateInfoPark()
	self:RefreshBuildAreas()
	self:RefreshScenePlayers()
	self:RefreshRegionalBoundary()
end

function m:RefreshBuildAreas()
	for i, v in pairs(self.BuildAreaCellPool) do
		local buildAreaData = self.BuildAreas[i]

		v:SetData(buildAreaData)
	end
end

function m:RandomPosData(tab)
	local randomPosTab = table.clone(tab)

	for i = #randomPosTab, 2, -1 do
		local random_index = math.random(i)

		randomPosTab[i], randomPosTab[random_index] = randomPosTab[random_index], randomPosTab[i]
	end

	return randomPosTab
end

function m:RefreshScenePlayers()
	local npcList = AmusementParkModule.AmusementParkNpcTab[AmusementParkConstant.RoleType.Ground_Npc]
	local count, regionalBoundary = AmusementParkModule.GetRandomPathNum()

	if self.LastCount ~= count then
		self.LastCount = count

		self:CleanNpc()

		local randomNpcList = self:RandomPosData(npcList)
		local minCount = math.min(#npcList, count)

		for i = 1, minCount do
			local walkArea = self.NpcWalkAreas[i]
			local cfgNpc = randomNpcList[i]

			self:AddNpc(cfgNpc, walkArea)
		end
	end

	for i, v in pairs(self.BuildAreaCellPool) do
		v:RefreshBuildNpc()
	end
end

function m:SetActive(value)
	if self.MainCamera == nil then
		return
	end

	self.MainCamera.enabled = value

	for j, v in pairs(self.BuildAreaCellPool) do
		local canvases = v.View:GetComponentsInChildren(typeof(UnityEngine.Canvas))

		for i = 0, canvases.Length - 1 do
			canvases[i].enabled = value
		end

		local renderers = v.View:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			renderers[i].enabled = value
		end
	end

	self.IsLockInput = not value
end

function m:OnBeganDrag(state, deltaX, deltaY)
	local pos = UnityEngine.Input.mousePosition
	local hits = LuaCodeInterface.RaycastAll(AmusementParkModule.AmusementParkScene.MainCamera:ScreenToWorldPoint(Vector3(pos.x, pos.y, 0)), Vector2.zero)
	local hitObjects = {}

	self.DragBuild = 0

	for i = 0, hits.Length - 1 do
		local hit = hits[i]

		if hit.collider ~= nil then
			local hitObj = hit.collider.gameObject

			if hitObj ~= nil then
				table.insert(hitObjects, hitObj)
			end
		end
	end

	if self.IsEdit then
		for i = 1, #hitObjects do
			local obj = hitObjects[i]
			local strTab = string.split(obj.name, "_")
			local objType = strTab[1]
			local value = tonumber(strTab[2])

			if objType == "BuildPos" then
				local buildData = self.BuildAreas[value]:GetAreaBuildData()

				if buildData ~= nil then
					self.DragBuild = value
				end

				self.BuildAreaCellPool[value]:StartDrag()

				break
			end
		end
	end
end

function m:OnDrag(state, deltaX, deltaY)
	if self.DragBuild ~= 0 then
		local pos = self.MainCamera:ScreenToWorldPoint(Vector3(UnityEngine.Input.mousePosition.x, UnityEngine.Input.mousePosition.y, 0))

		pos.z = 0

		self.BuildAreaCellPool[self.DragBuild]:OnDrag(pos)
	else
		self.CameraCtrl:MoveCamera(-deltaX * 0.01, -deltaY * 0.01)
	end
end

function m:OnDragEnd(state, deltaX, deltaY)
	if self.DragBuild ~= 0 then
		self:CheckDragSusses(self.DragBuild)
		self.BuildAreaCellPool[self.DragBuild]:EndDrag()

		self.DragBuild = 0
	end
end

function m:CheckDragSusses(dragBuildAreaPos)
	local dragAreaCell = self.BuildAreaCellPool[dragBuildAreaPos]

	for targetBuildAreaPos, v in ipairs(self.BuildAreaCellPool) do
		if targetBuildAreaPos ~= dragBuildAreaPos and v.BuildAreaData:IsOpen() then
			local top = v:CheckBoundsIntersects(dragAreaCell.BuildCollider)

			if top then
				if GameEntry.Base.DevMode then
					log("位置放入成功 拖放的建筑区域 " .. dragBuildAreaPos .. "  目标区域 " .. targetBuildAreaPos)
				end

				if dragAreaCell.BuildAreaData:GetAreaBuildData() then
					local dragBuildID = dragAreaCell.BuildAreaData:GetAreaBuildData().cid
					local targetBuildID
					local targetBuildData = v.BuildAreaData:GetAreaBuildData()

					if targetBuildData then
						targetBuildID = targetBuildData.cid
					end

					AmusementParkModule.ChangeLayout(dragBuildAreaPos, targetBuildAreaPos, dragBuildID, targetBuildID)
					dragAreaCell.RootBuilding:SetActive(false)

					return
				end
			end
		end
	end
end

function m:CleanNpc()
	for i, v in pairs(self.npcPool) do
		v:OnDestroy()
	end

	self.npcPool = {}
end

function m:AddNpc(roData, areaData)
	local npc = self:GetIdleNpc()
	local randomPos = areaData:GetRandomPoint()

	npc:Refresh(roData, randomPos, areaData)
end

function m:GetIdleNpc()
	local npc

	for i, v in pairs(self.npcPool) do
		if not v.isWorking then
			npc = v

			break
		end
	end

	if npc == nil then
		local go = UnityEngine.Object.Instantiate(self.goNpc)

		npc = AmusementParkNPC.New(go)
		self.npcPool[#self.npcPool + 1] = npc
	end

	return npc
end

function m:ClearScene()
	self:RemoveListeners()

	for i, v in pairs(self.BuildAreaCellPool) do
		v:Dispose()
	end

	self:CleanNpc()

	self.NpcWalkAreas = {}

	if self.View then
		LuaCodeInterface.ClearOutlet(self.View, self)
		UnityEngine.Object.Destroy(self.View)

		self.View = nil
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self.InputMgr:Dispose()
	self.CameraCtrl:Dispose()

	self.CameraCtrl = nil

	self:ClearScene()
end

return m
