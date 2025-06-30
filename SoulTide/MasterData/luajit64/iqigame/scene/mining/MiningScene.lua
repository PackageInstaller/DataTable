-- chunkname: @IQIGame\\Scene\\Mining\\MiningScene.lua

local m = {
	isLockInput = false,
	lastTime = 0,
	IsCreateScene = false,
	SoundPackageId = 0,
	plantCells = {},
	plantInstancePool = {}
}
local MiningInputManager = require("IQIGame.Scene.Mining.Input.MiningInputManager")
local CameraCtrl = require("IQIGame.Scene.TownArea.CameraCtrl")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MiningPlantCell = require("IQIGame.Scene.Mining.MiningPlantCell")

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	local mainCameraGo = UnityEngine.GameObject.Find("Main Camera")

	self.MainCamera = mainCameraGo:GetComponent("Camera")

	local rootTrans = UnityEngine.GameObject.Find("Mining").transform

	self.MapRoot = rootTrans:Find("MapRoot")

	local path = UIGlobalApi.GetPrefabRoot("/ART_Prefabs/Scene/MiningElement/MiningSceneBG.prefab")

	AssetUtil.LoadAsset(self, path, self.OnLoadBGPrefabSuccess, self.OnLoadBgPrefabFail)
	GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.CommonActivity))

	self.InputMgr = MiningInputManager.New()
	self.cameraCtrl = CameraCtrl.New()
	self.cameraCtrl.speedAutoMoveToTarget = TownAreaUIApi:GetString("sceneStairSpeed")

	function self.cameraCtrl.onMoveTargetOverDelegate()
		self:OnMoveTargetOver()
	end

	function self.cameraCtrl.cameraChangePosCallBack()
		self:OnCameraChangePos()
	end

	function self.DelegateUpdateAutoMiningPlant()
		self:OnUpdateAutoMining()
	end

	self.IsCreateScene = false

	self:AddListeners()
end

function m:RefreshBGM()
	local package = SoundPackageData.New(36, nil)

	self.SoundPackageId = SoundPackagePlayer.Add(package)
end

function m:OnLoadBGPrefabSuccess(assetName, asset, duration, innerUserData)
	local sceneObj = UnityEngine.Object.Instantiate(asset)

	self.View = sceneObj

	sceneObj.transform:SetParent(self.MapRoot, false)
	LuaCodeInterface.BindOutlet(self.View, self)

	self.IsCreateScene = true

	local haveDialog = MiningModule.CheckResumeDialog()

	self:SetActive(not haveDialog)

	if haveDialog then
		local time = Timer.New(function()
			self:SetActive(true)
		end, 2)

		time:Start()
	end

	self.PlantCellMould:SetActive(false)

	self.plantCellPool = UIObjectPool.New(50, function()
		local cell = MiningPlantCell.New(UnityEngine.Object.Instantiate(self.PlantCellMould), self)

		function cell.plantLoadCallBack(InstanceID, plantCell)
			self:PlantLoadComplete(InstanceID, plantCell)
		end

		return cell
	end, function(cell)
		cell:Dispose()
	end)

	self:RefreshPlant()
	self:Refresh()
end

function m:OnLoadBgPrefabFail(assetName, asset, duration, innerUserData)
	logError(assetName)
end

function m:OnMoveTargetOver()
	self.cameraCtrl:SetDragEnable(false)
end

function m:OnCameraChangePos()
	return
end

function m:OnTapObject(gameObject)
	local nowTime = PlayerModule.GetServerTime()

	if nowTime - self.lastTime < 0.7 then
		return
	end

	self.lastTime = nowTime

	if self.isLockInput then
		return
	end

	local instanceID = gameObject:GetInstanceID()
	local plantCell = self.plantInstancePool[instanceID]
	local plantData = plantCell.miningPlantData

	if plantData == nil then
		return
	end

	if plantData.miningGridPOD.state == Constant.MiningPlantState.Mining_Plant_Complete and not plantData:IsStairType() then
		return
	end

	if plantData.miningGridPOD.state == Constant.MiningPlantState.Mining_Plant_Default then
		local temp = true
		local cfgLayer = CfgMiningLayerTable[MiningModule.miningLayerPOD.floor]

		for i = 1, #cfgLayer.Cost, 2 do
			local id = cfgLayer.Cost[i]
			local need = cfgLayer.Cost[i + 1]
			local have = WarehouseModule.GetItemNumByCfgID(id)

			if have < need then
				temp = false

				break
			end
		end

		if temp == false then
			NoticeModule.ShowNotice(21045081)

			return
		end

		GameEntry.Sound:PlaySound(10604, Constant.SoundGroup.ENVIRONMENT)
		self:PlayCellEffect(plantCell, MiningModule.Excavate, plantData.miningGridPOD.id)
	elseif plantData.miningGridPOD.state == Constant.MiningPlantState.Mining_Plant_Have_Reward then
		local type = plantData:GetCfgElementData().Type

		if type == Constant.MiningElementType.MiningElementType_Monster then
			GameEntry.Sound:PlaySound(10602, Constant.SoundGroup.ENVIRONMENT)
			UIModule.Open(Constant.UIControllerName.MiningChallengeDetailUI, Constant.UILayer.UI, plantData)
		elseif type == Constant.MiningElementType.MiningElementType_Gold_Mine or type == Constant.MiningElementType.MiningElementType_Silver_Ore or type == Constant.MiningElementType.MiningElementType_Copper_Mine or type == Constant.MiningElementType.MiningElementType_Iron_Ore then
			if self:CheckInteract(plantData.miningGridPOD.id) then
				GameEntry.Sound:PlaySound(10604, Constant.SoundGroup.ENVIRONMENT)
				self:PlayCellEffect(plantCell, MiningModule.Interact, plantData.miningGridPOD.id)
			end
		else
			if not self:CheckInteract(plantData.miningGridPOD.id) then
				return
			end

			if type == Constant.MiningElementType.MiningElementType_Treasure_Chest then
				GameEntry.Sound:PlaySound(10601, Constant.SoundGroup.ENVIRONMENT)
			elseif type == Constant.MiningElementType.MiningElementType_Plot then
				GameEntry.Sound:PlaySound(10603, Constant.SoundGroup.ENVIRONMENT)
			end

			MiningModule.Interact(plantData.miningGridPOD.id)
		end
	elseif plantData:IsStairType() and self:CheckInteract(plantData.miningGridPOD.id) then
		MiningModule.Interact(plantData.miningGridPOD.id)
	end
end

function m:CheckInteract(gridId)
	local gridData = MiningModule.GetMiningPlantDataById(gridId)

	if gridData:GetCfgElementData().ServerType == nil then
		return false
	end

	if gridData:GetCfgElementData().ServerType == 2 and gridData:GetCfgElementData().Type == Constant.MiningElementType.MiningElementType_Descending_Stairs then
		local temp = false

		for i, v in pairs(MiningModule.miningPlantDataTab) do
			if v.miningGridPOD.state == Constant.MiningPlantState.Mining_Plant_Have_Reward then
				local type = v:GetCfgElementData().Type

				if type == Constant.MiningElementType.MiningElementType_Monster then
					temp = true

					break
				end
			end
		end

		if temp then
			NoticeModule.ShowNotice(21045079)

			return false
		end
	end

	local temp = true

	for i = 1, #gridData:GetCfgElementData().Cost, 2 do
		local id = gridData:GetCfgElementData().Cost[i]
		local need = gridData:GetCfgElementData().Cost[i + 1]
		local have = WarehouseModule.GetItemNumByCfgID(id)

		if have < need then
			temp = false

			break
		end
	end

	if temp == false then
		NoticeModule.ShowNotice(21045081)

		return false
	end

	return true
end

function m:PlayCellEffect(plantCell, callBack, param)
	plantCell:PlayEffect()

	self.isLockInput = true
	self.timer = Timer.New(function()
		plantCell:HideEffect()

		self.isLockInput = false

		callBack(param)
	end, 0.7)

	self.timer:Start()
end

function m:Refresh()
	self:RefreshBGM()
	self:RefreshCamera()
end

function m:RefreshPlant()
	self.plantInstancePool = {}

	for i, v in pairs(self.plantCells) do
		v.View.transform:SetParent(self.View.transform, false)
		v.View:SetActive(false)
		self.plantCellPool:Release(v)
	end

	self.plantCells = {}

	local plantDataTab = MiningModule.miningPlantDataTab

	for i = 1, #plantDataTab do
		local data = plantDataTab[i]
		local cell = self.plantCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.PlantRoot.transform, false)
		cell:SetData(data)
		table.insert(self.plantCells, cell)
	end
end

function m:PlantLoadComplete(InstanceID, plantCell)
	self.plantInstancePool[InstanceID] = plantCell
end

function m:RefreshCamera()
	if self.MainCamera == nil or LuaCodeInterface.GameObjIsDestroy(self.MainCamera) then
		return
	end

	self.cameraCtrl:Refresh(self.goLimitLeft.transform.position.x, self.goLimitLeft.transform.position, self.goLimitRight.transform.position, self.MainCamera, 3.75)
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.UpdateAutoMiningPlantEvent, self.DelegateUpdateAutoMiningPlant)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.UpdateAutoMiningPlantEvent, self.DelegateUpdateAutoMiningPlant)
end

function m:OnUpdateAutoMining()
	if not self.IsCreateScene then
		return
	end

	self:RefreshPlant()
end

function m:SetActive(value)
	if self.MainCamera == nil then
		return
	end

	self.MainCamera.enabled = value

	for j, v in pairs(self.plantCells) do
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

function m:ClearScene()
	for i, v in pairs(self.plantCells) do
		self.plantCellPool:Release(v)
	end

	self.plantCells = {}

	self.plantCellPool:Dispose()

	self.plantInstancePool = {}

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	self:ClearScene()
	self.InputMgr:Dispose()
	self.cameraCtrl:OnDestroy()

	self.cameraCtrl = nil

	if self.SoundPackageId > 0 then
		SoundPackagePlayer.Remove(self.SoundPackageId)

		self.SoundPackageId = 0
	end

	if self.View then
		LuaCodeInterface.ClearOutlet(self.View, self)
		UnityEngine.Object.Destroy(self.View)

		self.View = nil
	end
end

return m
