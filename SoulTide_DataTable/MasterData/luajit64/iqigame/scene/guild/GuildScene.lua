-- chunkname: @IQIGame\\Scene\\Guild\\GuildScene.lua

local m = {
	isLockInput = false,
	SoundPackageId = 0,
	areaInstancePool = {},
	walkAreas = {},
	npcPool = {},
	lastShowNpc = {}
}
local GuildPlayerWalkAreaData = require("IQIGame.Scene.Guild.GuildPlayerWalkAreaData")
local CameraCtrl = require("IQIGame.Scene.TownArea.CameraCtrl")
local GuildInputManager = require("IQIGame.Scene.Guild.Input.GuildInputManager")
local GuildPlayer = require("IQIGame.Scene.Guild.GuildPlayer")

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	local mainCameraGo = UnityEngine.GameObject.Find("Main Camera")

	self.MainCamera = mainCameraGo:GetComponent("Camera")

	local rootTrans = UnityEngine.GameObject.Find("Guild").transform

	self.MapRoot = rootTrans:Find("MapRoot")

	local path = UIGlobalApi.GetPrefabRoot("/ART_Prefabs/Scene/Guild/Guild_BG.prefab")

	AssetUtil.LoadAsset(self, path, self.OnLoadBGPrefabSuccess, self.OnLoadBgPrefabFail)
	GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.CommonActivity))

	self.InputMgr = GuildInputManager.New()
	self.cameraCtrl = CameraCtrl.New()
	self.cameraCtrl.speedAutoMoveToTarget = TownAreaUIApi:GetString("sceneStairSpeed")

	function self.cameraCtrl.onMoveTargetOverDelegate()
		self:OnMoveTargetOver()
	end

	function self.cameraCtrl.cameraChangePosCallBack()
		self:OnCameraChangePos()
	end

	self:RefreshBGM()
end

function m:RefreshBGM()
	local package = SoundPackageData.New(35, nil)

	self.SoundPackageId = SoundPackagePlayer.Add(package)
end

function m:OnLoadBGPrefabSuccess(assetName, asset, duration, innerUserData)
	local sceneObj = UnityEngine.Object.Instantiate(asset)

	self.View = sceneObj

	sceneObj.transform:SetParent(self.MapRoot, false)
	LuaCodeInterface.BindOutlet(self.View, self)

	self.walkAreas = {}

	for i = 1, self.goWalkAreaRoot.transform.childCount do
		local trans = self.goWalkAreaRoot.transform:Find("WalkArea_" .. i)
		local walkAreaData = GuildPlayerWalkAreaData.New(trans)

		self.walkAreas[i] = walkAreaData
	end

	function self.onTimerDelegate()
		self:OnTimerUpdate()
	end

	function self.DelegateUpdateMembersEvent()
		self:OnUpdateMembersEvent()
	end

	function self.DelegateUpdateGuildEvent()
		self:OnUpdateGuildEvent()
	end

	function self.DelegateUpdateGuildNoticeEvent()
		self:RefreshGuildBoard()
	end

	self:Refresh()
	EventDispatcher.Dispatch(EventID.GuildCameraChangePosEvent)
end

function m:OnLoadBgPrefabFail(assetName, asset, duration, innerUserData)
	logError(assetName)
end

function m:GetAreaPos(index)
	if self.Areas and not LuaCodeInterface.GameObjIsDestroy(self.Areas) then
		local pos = self.Areas.transform:Find("Pos" .. index)

		if pos then
			return pos.position
		else
			logError("获取怪物学园区域位置信息出错：找不到挂点 Pos" .. index)
		end
	end

	return Vector3.New(0, 0, 0)
end

function m:OnMoveTargetOver()
	self.cameraCtrl:SetDragEnable(false)
end

function m:OnCameraChangePos()
	EventDispatcher.Dispatch(EventID.GuildCameraChangePosEvent)
end

function m:OnTimerUpdate()
	if self.cameraCtrl ~= nil then
		self.cameraCtrl:OnUpdate()
	end

	for i, v in pairs(self.npcPool) do
		v:OnUpdate()
	end
end

function m:GetShowPlayers()
	local tab = {}
	local tempTab = {}
	local maxNum = 15

	for i, v in pairs(GuildModule.guildPOD.members) do
		if v.position == Constant.GuildPosition.Guild_Ordinary_Members then
			if v.online then
				if v.player.pid == PlayerModule.PlayerInfo.baseInfo.pid then
					tab[v.player.pid] = v
					maxNum = maxNum - 1
				else
					table.insert(tempTab, v)
				end
			end
		else
			tab[v.player.pid] = v
		end
	end

	table.sort(tempTab, function(a, b)
		return a.activeNum > b.activeNum
	end)

	for i = 1, #tempTab do
		if i <= maxNum then
			local pod = tempTab[i]

			tab[pod.player.pid] = pod
		end
	end

	return tab
end

function m:OnUpdateMembersEvent()
	local newMembers = self:GetShowPlayers()

	for i, v in pairs(self.lastShowNpc) do
		if newMembers[i] == nil then
			self:RemoveNpc(v.player.pid)
		end
	end

	for i, v in pairs(newMembers) do
		if self.lastShowNpc[v.player.pid] == nil then
			self:AddNpc(v)
		end
	end

	for i, v in pairs(self.lastShowNpc) do
		if newMembers[i] ~= nil and newMembers[i].position ~= v.position then
			self:RemoveNpc(v.player.pid)
			self:AddNpc(newMembers[i])
		end
	end
end

function m:OnUpdateGuildEvent()
	self:RefreshGuildBoard()
end

function m:Refresh()
	self:RefreshBG()
	self:RefreshBGM()
	self:RefreshArea()
	self:AddListeners()
	self:RefreshCamera()
	self:RefreshAllNpc()
	self:RefreshGuildBoard()
end

function m:RefreshGuildBoard()
	UGUIUtil.SetText(self.GuildBoardTitle, GuildMainUIApi:GetString("GuildBoardTitle"))

	if GuildModule.guildPOD.banNotice then
		UGUIUtil.SetText(self.GuildBoardContent, GuildMainUIApi:GetString("BanNotice"))
	else
		UGUIUtil.SetText(self.GuildBoardContent, GuildModule.guildPOD.notice)
	end
end

function m:RefreshAllNpc()
	self.lastShowNpc = {}

	local showPlayers = self:GetShowPlayers()

	for i, v in pairs(showPlayers) do
		self:AddNpc(v)
	end
end

function m:RemoveNpc(id)
	for i, v in pairs(self.npcPool) do
		if v.guildMemberPOD.player.pid == id then
			v:OnDestroy()

			self.npcPool[i] = nil
		end
	end

	self.lastShowNpc[id] = nil
end

function m:AddNpc(pod)
	local randomPos, randomArea = self:GetRandomData()
	local npc = self:GetIdleNpc(randomArea[3])
	local trans = randomArea.trans

	if pod.position ~= Constant.GuildPosition.Guild_Ordinary_Members then
		randomPos = Vector3.New(0, 0, 0)
		trans = self:GetPresidentTransform(pod)
	end

	npc:Refresh(pod, randomPos, randomArea, trans)

	self.lastShowNpc[pod.player.pid] = pod
end

function m:GetPresidentTransform(pod)
	if pod.position == Constant.GuildPosition.Guild_President then
		return self.posPresident.transform
	elseif pod.position == Constant.GuildPosition.Guild_Vice_President then
		for i = 1, 2 do
			if self["posVicePresident" .. i].transform.childCount == 0 then
				return self["posVicePresident" .. i].transform
			end
		end
	end

	return self.View.transform
end

function m:GetRandomData()
	local randomArea = self.walkAreas[math.random(1, #self.walkAreas)]
	local randomPos = Vector3.New(math.Random(randomArea.leftPos.x, randomArea.rightPos.x), randomArea.leftPos.y, randomArea.leftPos.z)

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

		npc = GuildPlayer.New(go)
		self.npcPool[#self.npcPool + 1] = npc
	end

	return npc
end

function m:RefreshBG()
	return
end

function m:RefreshArea()
	self.areaInstancePool = {}

	for k, v in pairs(GuildModule.guildAreaDic) do
		local pos = v.cfgInfo.PosIndex
		local posObj = self.goAreas.transform:Find("Pos" .. pos).gameObject

		self.areaInstancePool[posObj:GetInstanceID()] = v
	end
end

function m:onLoadImageSuccess(assetName, asset, duration, userData)
	while self.Background.transform.childCount > 0 do
		local child = self.Background.transform:GetChild(0)

		child.transform:SetParent(nil)
		UnityEngine.Object.Destroy(child.gameObject)
	end

	local bgObj = UnityEngine.Object.Instantiate(asset)

	bgObj.transform:SetParent(self.Background.transform, false)
end

function m:RefreshCamera()
	if self.MainCamera == nil or LuaCodeInterface.GameObjIsDestroy(self.MainCamera) then
		return
	end

	self.cameraCtrl:Refresh(0, self.goLimitLeft.transform.position, self.goLimitRight.transform.position, self.MainCamera, 3.75)
end

function m:AddListeners()
	GameEntry.Timer:AddFrameRender(1, self.onTimerDelegate, true)
	EventDispatcher.AddEventListener(EventID.GuildUpdateMembersEvent, self.DelegateUpdateMembersEvent)
	EventDispatcher.AddEventListener(EventID.GuildUpdateEvent, self.DelegateUpdateGuildEvent)
	EventDispatcher.AddEventListener(EventID.GuildUpdateNoticeEvent, self.DelegateUpdateGuildNoticeEvent)
end

function m:RemoveListeners()
	GameEntry.Timer:RemoveRender(self.onTimerDelegate)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateMembersEvent, self.DelegateUpdateMembersEvent)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateEvent, self.DelegateUpdateGuildEvent)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateNoticeEvent, self.DelegateUpdateGuildNoticeEvent)
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

function m:GetAreaPos(index)
	if self.goAreas and not LuaCodeInterface.GameObjIsDestroy(self.goAreas) then
		local pos = self.goAreas.transform:Find("Pos" .. index)

		if pos then
			return pos.position
		end
	end

	return Vector3.New(0, 0, 0)
end

function m:ClearScene()
	self:RemoveListeners()

	if self.SoundPackageId > 0 then
		SoundPackagePlayer.Remove(self.SoundPackageId)

		self.SoundPackageId = 0
	end

	self.lastShowNpc = {}
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:ClearScene()
	self.InputMgr:Dispose()
	self.cameraCtrl:OnDestroy()

	self.cameraCtrl = nil

	for i, v in pairs(self.npcPool) do
		v:OnDestroy()
	end

	self.npcPool = {}

	if self.View then
		LuaCodeInterface.ClearOutlet(self.View, self)
		UnityEngine.Object.Destroy(self.View)

		self.View = nil
	end
end

return m
