-- chunkname: @IQIGame\\Scene\\Mining\\MiningPlantCell.lua

local m = {
	EntityId = 0
}

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.View = view
	self.root = root

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateUpdateMiningPlantEvent(gridId)
		self:OnUpdateMiningPlantEvent(gridId)
	end

	self.Effect:SetActive(false)
	self:AddListener()
end

function m:AddListener()
	EventDispatcher.AddEventListener(EventID.UpdateMiningPlantEvent, self.DelegateUpdateMiningPlantEvent)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.UpdateMiningPlantEvent, self.DelegateUpdateMiningPlantEvent)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:OnUpdateMiningPlantEvent(gridId)
	if self.miningPlantData and self.miningPlantData.miningGridPOD.id == gridId then
		local data = MiningModule.GetMiningPlantDataById(gridId)

		self:SetData(data)
	end
end

function m:SetData(data)
	self.miningPlantData = data

	self:RefreshBG()

	self.View.name = self.miningPlantData.miningGridPOD.x .. "-" .. self.miningPlantData.miningGridPOD.y

	local startPos = self.root.StartPoint.transform.position
	local pos = Vector3.New(startPos.x + self.miningPlantData.miningGridPOD.x * 0.91, startPos.y - self.miningPlantData.miningGridPOD.y * 0.91, 0)

	self.View.transform.position = pos
end

function m:PlayEffect()
	self:HideEffect()
	self.Effect:SetActive(true)
end

function m:HideEffect()
	self.Effect:SetActive(false)
end

function m:RefreshPlantState()
	if self.plantGroundObj then
		local tr = self.plantGroundObj.transform:Find("Unknown")

		if tr then
			tr.gameObject:SetActive(self.miningPlantData.miningGridPOD.state == Constant.MiningPlantState.Mining_Plant_Default)
		end

		local haveMiningSpine = self.miningPlantData:GetCfgElementData().MiningSpine > 0
		local showStairs = haveMiningSpine and self.miningPlantData.miningGridPOD.state ~= Constant.MiningPlantState.Mining_Plant_Default and self.miningPlantData:IsStairType()
		local showElement = haveMiningSpine and self.miningPlantData.miningGridPOD.state == Constant.MiningPlantState.Mining_Plant_Have_Reward
		local isShow = showStairs or showElement

		self.plantGroundObj.transform:Find("Point_Root").gameObject:SetActive(isShow)

		if isShow then
			self:ShowElement(self.miningPlantData:GetCfgElementData().MiningSpine)
		else
			self:HideEntity()
		end
	end
end

function m:ShowElement(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.EntityId, elementEntityCid, 0, self.plantGroundObj.transform:Find("Point_Root").transform, Vector3.zero)
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function m:RefreshBG()
	local cfgMiningElementShapeData = CfgMiningElementShapeTable[self.miningPlantData.miningGridPOD.skinId]
	local path = "Assets/03_Prefabs/ART_Prefabs/Scene/" .. cfgMiningElementShapeData.LandSkin .. ".prefab"

	AssetUtil.LoadAsset(self, path, self.OnLoadBgSuccess, self.OnLoadBgFail)
end

function m:OnLoadBgSuccess(assetName, asset, duration, userData)
	if self.plantGroundObj ~= nil then
		self.plantGroundObj.transform:SetParent(nil, false)
		UnityEngine.Object.Destroy(self.plantGroundObj)
	end

	self.plantGroundObj = UnityEngine.Object.Instantiate(asset)

	self.plantGroundObj.transform:SetParent(self.Root.transform, false)

	local renderers = self.plantGroundObj.transform:Find("Unknown").gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, renderers.Length - 1 do
		renderers[i].sortingOrder = self.miningPlantData.miningGridPOD.y
	end

	local effectRenderers = self.Effect:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, effectRenderers.Length - 1 do
		effectRenderers[i].sortingOrder = self.miningPlantData.miningGridPOD.y + 1
	end

	if self.plantLoadCallBack then
		self.plantLoadCallBack(self.plantGroundObj:GetInstanceID(), self)
	end

	self:RefreshPlantState()
end

function m:OnLoadBgFail(assetName, status, errorMessage, userData)
	return
end

function m:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(1, 1, 1)

		local spineRenderers = args.Entity:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

		for j = 0, spineRenderers.Length - 1 do
			local renderer = spineRenderers[j]

			renderer.enabled = true
		end

		local renderers = args.Entity:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			renderers[i].enabled = true
			renderers[i].sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Default")
		end
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.plantLoadCallBack = nil

	self:HideEntity()

	if self.plantGroundObj then
		UnityEngine.Object.Destroy(self.plantGroundObj)
	end

	self.plantGroundObj = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
