-- chunkname: @IQIGame\\Scene\\Panda\\PandaScene.lua

local m = {
	isLockInput = false,
	SoundPackageId = 0,
	npcPool = {},
	walkAreas = {},
	npcInstancePool = {}
}
local CameraCtrl = require("IQIGame.Scene.TownArea.CameraCtrl")
local PandaNpc = require("IQIGame.Scene.Panda.PandaNpc")
local PandaInputManager = require("IQIGame.Scene.Panda.Input.PandaInputManager")

function m.New(pandaGlobalID, operateEventID)
	local obj = Clone(m)

	obj:Init(pandaGlobalID, operateEventID)

	return obj
end

function m:Init(pandaGlobalID, operateEventID)
	self.pandaGlobalID = pandaGlobalID
	self.operateEventID = operateEventID

	local mainCameraGo = UnityEngine.GameObject.Find("Main Camera")

	self.MainCamera = mainCameraGo:GetComponent("Camera")

	GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.Panda))

	local path = UIGlobalApi.GetArtPath(CfgPandaActivityGlobalTable[self.pandaGlobalID].ScenePrefabs)

	AssetUtil.LoadAsset(self, path, self.OnLoadAreaSuccess, self.OnLoadBgFail)
	warning("Panda scene init.")

	self.InputMgr = PandaInputManager.New()

	self:InitBGM()
end

function m:InitBGM()
	local package = SoundPackageData.New(CfgPandaActivityGlobalTable[self.pandaGlobalID].BGM, nil)

	self.SoundPackageId = SoundPackagePlayer.Add(package)
end

function m:OnLoadAreaSuccess(assetName, asset, duration, innerUserData)
	local goArea = UnityEngine.Object.Instantiate(asset)

	self.View = goArea

	LuaCodeInterface.BindOutlet(self.View, self)

	self.cameraCtrl = CameraCtrl.New()
	self.cameraCtrl.speedAutoMoveToTarget = TownAreaUIApi:GetString("sceneStairSpeed")

	function self.cameraCtrl.onMoveTargetOverDelegate()
		self:OnMoveTargetOver()
	end

	self.goTaskEntry:SetActive(false)
	self.goEventEntry:SetActive(false)
	self.goAreaEventEntry:SetActive(false)

	for i = 1, self.goWalkAreaRoot.transform.childCount do
		local trans = self.goWalkAreaRoot.transform:Find("WalkArea_" .. i)
		local leftPos = trans:Find("LimitLeft").localPosition
		local rightPos = trans:Find("LimitRight").localPosition

		self.walkAreas[i] = {
			leftPos,
			rightPos,
			trans
		}
	end

	function self.onTimerDelegate()
		self:OnTimerUpdate()
	end

	self:AddListeners()
	self:Refresh()
	ActivePandaModule.CheckResumeDialog()
end

function m:OnLoadBgFail(assetName, asset, duration, innerUserData)
	logError(assetName)
end

function m:OnTapObject(gameObject)
	if self.isLockInput then
		return
	end

	local instanceID = gameObject:GetInstanceID()
	local pandaEventCid = self.npcInstancePool[instanceID]
	local type = CfgPandaEventListTable[pandaEventCid].Type

	if type == 1 then
		ActivePandaModule.DoEvent(pandaEventCid)
	elseif type == 2 then
		UIModule.Open(Constant.UIControllerName.PandaChallengeDetailInfoUI, Constant.UILayer.UI, {
			self.operateEventID,
			pandaEventCid
		})
	elseif type == 3 then
		ActivePandaModule.DoEvent(pandaEventCid)
	end
end

function m:AddListeners()
	GameEntry.Timer:AddFrameRender(1, self.onTimerDelegate, true)
end

function m:RemoveListeners()
	GameEntry.Timer:RemoveRender(self.onTimerDelegate)
end

function m:OnTimerUpdate()
	if self.cameraCtrl ~= nil then
		self.cameraCtrl:OnUpdate()
	end

	for i, v in pairs(self.npcPool) do
		v:OnUpdate()
	end
end

function m:Refresh()
	self:RefreshMisc()
	self:RefreshCamera()
	self:RefreshAllNpc()
end

function m:RefreshMisc()
	for i, v in pairs(self.npcPool) do
		v:SetActive(false)
	end
end

function m:RefreshCamera()
	if self.MainCamera == nil or LuaCodeInterface.GameObjIsDestroy(self.MainCamera) then
		return
	end

	self.cameraCtrl:Refresh(0, self.goLimitLeft.transform.position, self.goLimitRight.transform.position, self.MainCamera, 3.75)
end

function m:RefreshAllEventEntry()
	for i, v in pairs(self.npcPool) do
		v:OnDestroy()
	end

	self.npcPool = {}

	self:RefreshAllNpc()
end

function m:RefreshAllNpc()
	self.npcInstancePool = {}

	for i, v in ipairs(ActivePandaModule.sceneEvents) do
		self:AddNpc(v)
	end
end

function m:RemoveNpc(id)
	for i, v in pairs(self.npcPool) do
		if v.id == id then
			v:OnDestroy()

			self.npcPool[i] = nil
		end
	end
end

function m:AddNpc(id)
	local randomPos, randomArea = self:GetRandomData()
	local npc = self:GetIdleNpc(randomArea[3])

	npc:Refresh(id, randomPos, randomArea)

	self.npcInstancePool[npc.View:GetInstanceID()] = id
end

function m:GetRandomData()
	local randomArea = self.walkAreas[math.random(1, #self.walkAreas)]
	local randomPos = Vector3.New(math.Random(randomArea[1].x, randomArea[2].x), randomArea[1].y, randomArea[1].z)

	return randomPos, randomArea
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

		npc = PandaNpc.New(go)
		self.npcPool[#self.npcPool + 1] = npc
	end

	return npc
end

function m:OnMoveTargetOver()
	self.cameraCtrl:SetDragEnable(false)
end

function m:SetActive(value)
	if self.MainCamera == nil then
		logError("self.MainCamera is nil. PlayerModule.InMaze: " .. tostring(PlayerModule.InMaze))

		return
	end

	self.MainCamera.enabled = value

	for j, v in pairs(self.npcPool) do
		local colliders = v.View:GetComponentsInChildren(typeof(UnityEngine.Collider2D))

		for i = 0, colliders.Length - 1 do
			colliders[i].enabled = value
		end

		local canvases = v.View:GetComponentsInChildren(typeof(UnityEngine.Canvas))

		for i = 0, canvases.Length - 1 do
			canvases[i].enabled = value
		end

		local renderers = v.View:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			renderers[i].enabled = value
		end
	end

	self.isLockInput = not value
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	self.InputMgr:Dispose()
	self.cameraCtrl:OnDestroy()

	for i, v in pairs(self.npcPool) do
		v:OnDestroy()
	end

	self.npcPool = {}

	SoundPackagePlayer.Remove(self.SoundPackageId)

	self.SoundPackageId = 0
end

return m
