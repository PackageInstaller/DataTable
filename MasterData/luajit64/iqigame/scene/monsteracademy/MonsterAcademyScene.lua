-- chunkname: @IQIGame\\Scene\\MonsterAcademy\\MonsterAcademyScene.lua

local m = {
	SoundPackageId = 0,
	areaInstancePool = {}
}
local CameraCtrl = require("IQIGame.Scene.TownArea.CameraCtrl")
local MonsterAcademyInputManager = require("IQIGame.Scene.MonsterAcademy.Input.MonsterAcademyInputManager")

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	local mainCameraGo = UnityEngine.GameObject.Find("Main Camera")

	self.MainCamera = mainCameraGo:GetComponent("Camera")

	local rootTrans = UnityEngine.GameObject.Find("MonsterAcademy").transform

	self.MapRoot = rootTrans:Find("MapRoot")

	GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.CommonActivity))

	local path = UIGlobalApi.GetPrefabRoot(CfgGalgameMonsterActivityGlobalTable[MonsterAcademyModule.GlobalCid].SceneFile)

	AssetUtil.LoadAsset(self, path, self.OnLoadBGPrefabSuccess, self.OnLoadBgPrefabFail)

	self.InputMgr = MonsterAcademyInputManager.New()
	self.cameraCtrl = CameraCtrl.New()
	self.cameraCtrl.speedAutoMoveToTarget = TownAreaUIApi:GetString("sceneStairSpeed")

	function self.cameraCtrl.onMoveTargetOverDelegate()
		self:OnMoveTargetOver()
	end

	function self.cameraCtrl.cameraChangePosCallBack()
		self:OnCameraChangePos()
	end

	function self.onTimerDelegate()
		self:OnTimerUpdate()
	end

	function self.onUpdateBaseEvent()
		self:onUpdateBase()
	end

	self:RefreshBGM()
end

function m:RefreshBGM()
	local package = SoundPackageData.New(CfgGalgameMonsterActivityGlobalTable[MonsterAcademyModule.GlobalCid].BGM, nil)

	self.SoundPackageId = SoundPackagePlayer.Add(package)
end

function m:OnLoadBGPrefabSuccess(assetName, asset, duration, innerUserData)
	local sceneObj = UnityEngine.Object.Instantiate(asset)
	local haveDialog = MonsterAcademyModule.CheckResumeDialog()

	self.View = sceneObj

	sceneObj.transform:SetParent(self.MapRoot, false)
	self:ShowScene(not haveDialog)
	LuaCodeInterface.BindOutlet(self.View, self)
	self:Refresh()
	EventDispatcher.Dispatch(EventID.MonsterAcademyCameraChangePosEvent)
end

function m:OnLoadBgPrefabFail(assetName, asset, duration, innerUserData)
	logError(assetName)
end

function m:ShowScene(top)
	if self.View and not LuaCodeInterface.GameObjIsDestroy(self.View) then
		self.View:SetActive(top)
	end
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
	EventDispatcher.Dispatch(EventID.MonsterAcademyCameraChangePosEvent)
end

function m:RefreshArea()
	self.areaInstancePool = {}

	for k, v in pairs(MonsterAcademyModule.monsterAreaDic) do
		local pos = v.cfgInfo.SiteIconPosition
		local posObj = self.Areas.transform:Find("Pos" .. pos).gameObject

		self.areaInstancePool[posObj:GetInstanceID()] = v.cfgID
	end
end

function m:Refresh()
	self:RefreshBG()
	self:RefreshBGM()
	self:AddListeners()
	self:RefreshArea()
	self:RefreshCamera()
end

function m:onUpdateBase()
	self:RefreshBG()
end

function m:RefreshBG()
	local cfgGlobal = CfgGalgameMonsterActivityGlobalTable[MonsterAcademyModule.GlobalCid]
	local path = cfgGlobal.ImageBg[MonsterAcademyModule.SaveDataDetailPOD.basePOD.dayOfPhase]

	if path then
		AssetUtil.LoadAsset(self, UIGlobalApi.GetUIPrefab("/_MonsterAcademyUI/" .. path), self.onLoadImageSuccess)
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

function m:OnTimerUpdate()
	if self.cameraCtrl ~= nil then
		self.cameraCtrl:OnUpdate()
	end
end

function m:RefreshCamera()
	if self.MainCamera == nil or LuaCodeInterface.GameObjIsDestroy(self.MainCamera) then
		return
	end

	self.cameraCtrl:Refresh(0, self.goLimitLeft.transform.position, self.goLimitRight.transform.position, self.MainCamera, 3.75)
end

function m:OnTapObject(gameObject)
	return
end

function m:AddListeners()
	GameEntry.Timer:AddFrameRender(1, self.onTimerDelegate, true)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateBaseEvent, self.onUpdateBaseEvent)
end

function m:RemoveListeners()
	GameEntry.Timer:RemoveRender(self.onTimerDelegate)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateBaseEvent, self.onUpdateBaseEvent)
end

function m:ClearScene()
	self:ShowScene(false)
	self:RemoveListeners()

	self.areaInstancePool = {}

	if self.SoundPackageId > 0 then
		SoundPackagePlayer.Remove(self.SoundPackageId)

		self.SoundPackageId = 0
	end
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	AssetUtil.UnloadAsset(self)
	self:ClearScene()
	self.InputMgr:Dispose()
	self.cameraCtrl:OnDestroy()

	self.cameraCtrl = nil
end

return m
