-- chunkname: @IQIGame\\Module\\Battle\\BattleEntitySortingOrderManager.lua

BattleEntitySortingOrderManager = {}

local this = BattleEntitySortingOrderManager

function BattleEntitySortingOrderManager.Init()
	this.m_IsStarted = false
	this.m_BattleEntities = {}
	this.m_SkeletonMeshRenderersCache = {}
	this.m_MeshRenderersCache = {}
	this.m_BattleEntitiesOrderChangeRecord = {}

	this.AddListener()
end

function BattleEntitySortingOrderManager.Start(scopeDistance, deltaSortingOrder)
	this.m_IsStarted = true
	this.m_HalfScopeDistance = scopeDistance / 3
	this.m_DeltaSortingOrder = deltaSortingOrder
	this.m_UpdateFrameTimer = FrameTimer.New(this.Update, 1, -1)

	this.m_UpdateFrameTimer:Start()
	log("BattleEntity渲染层级更新组件 - Start：m_HalfScopeDistance={0}, m_DeltaSortingOrder={1}", this.m_HalfScopeDistance, this.m_DeltaSortingOrder)
end

function BattleEntitySortingOrderManager.Dispose()
	this.m_IsStarted = false

	this.RemoveListener()

	if this.m_UpdateFrameTimer then
		this.m_UpdateFrameTimer:Stop()

		this.m_UpdateFrameTimer = nil
	end

	if this.m_BattleEntities then
		for key, _ in pairs(this.m_BattleEntities) do
			this.DelBattleEntityData(key)
		end

		this.m_BattleEntities = nil
	end

	if this.m_SkeletonMeshRenderersCache then
		for key, _ in pairs(this.m_SkeletonMeshRenderersCache) do
			this.m_SkeletonMeshRenderersCache[key] = nil
		end

		this.m_SkeletonMeshRenderersCache = nil
	end

	this.m_MeshRenderersCache = nil
	this.m_BattleEntitiesOrderChangeRecord = nil
end

function BattleEntitySortingOrderManager.AddListener()
	GameEntry.LuaEvent:Subscribe(ShowEntitySuccessEventArgs.EventId, this.OnShowEntitySucess)
	GameEntry.LuaEvent:Subscribe(HideEntityCompleteEventArgs.EventId, this.OnHideEntityComplete)
end

function BattleEntitySortingOrderManager.RemoveListener()
	GameEntry.LuaEvent:Unsubscribe(ShowEntitySuccessEventArgs.EventId, this.OnShowEntitySucess)
	GameEntry.LuaEvent:Unsubscribe(HideEntityCompleteEventArgs.EventId, this.OnHideEntityComplete)
end

function BattleEntitySortingOrderManager.Update()
	if not this.m_IsStarted then
		return
	end

	for entityId, node in pairs(this.m_BattleEntities) do
		if node.m_Transform.gameObject.activeInHierarchy then
			local newRow = this.GetCurRow(node)

			if node.m_CurRow ~= newRow then
				local changeOrder = (newRow > node.m_CurRow and 1 or -1) * this.m_DeltaSortingOrder * math.abs(node.m_CurRow - newRow)

				this.UpdateAllSortingOrder(entityId, node, changeOrder)

				node.m_CurRow = newRow
			end
		end
	end
end

function BattleEntitySortingOrderManager.OnShowEntitySucess(sender, args)
	local entityTrans = args.Entity.transform
	local entityId = tostring(args.Entity.Id)

	this.m_BattleEntities[entityId] = this.GenBattleEntityData(entityTrans)
	this.m_BattleEntitiesOrderChangeRecord[entityId] = 0

	this.UpdateAllSortingOrder(entityId, this.m_BattleEntities[entityId], 300)
end

function BattleEntitySortingOrderManager.OnHideEntityComplete(sender, args)
	local entityId = tostring(args.EntityId)

	this.DelBattleEntityData(entityId)
end

function BattleEntitySortingOrderManager.GenBattleEntityData(trans)
	local battleEntityTb = {}

	battleEntityTb.m_Transform = trans
	battleEntityTb.m_CurRow = 0
	battleEntityTb.m_ParticleSystemRenderers = trans:GetComponentsInChildren(typeof(UnityEngine.ParticleSystemRenderer), true)
	battleEntityTb.m_SkeletonMeshRenderers = {}
	battleEntityTb.m_SpinePassRenderers = {}

	local spinePass = trans:GetComponentsInChildren(typeof(RoleEffect), true)

	for i = 0, spinePass.Length - 1 do
		local pass = spinePass[i]

		if pass ~= nil then
			pass:SetOrder(BattleConstant.BattleUnitDefaultSortingOrder)
			table.insert(battleEntityTb.m_SpinePassRenderers, pass)
		end
	end

	local resetSortingOrder = false

	resetSortingOrder = spinePass.Length > 0 and true or resetSortingOrder

	local SkeletonAniArr = trans:GetComponentsInChildren(typeof(Spine.Unity.SkeletonAnimation), true)

	for i = 0, SkeletonAniArr.Length - 1 do
		local eachMeshRendererTb = SkeletonAniArr[i]:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

		for k = 0, eachMeshRendererTb.Length - 1 do
			if resetSortingOrder then
				eachMeshRendererTb[k].sortingOrder = BattleConstant.BattleUnitDefaultSortingOrder
			end

			table.insert(battleEntityTb.m_SkeletonMeshRenderers, eachMeshRendererTb[k])

			this.m_SkeletonMeshRenderersCache[eachMeshRendererTb[k].gameObject:GetInstanceID()] = eachMeshRendererTb[k].sortingOrder
		end
	end

	local meshName = "DynamicQuad"

	battleEntityTb.m_MeshRenderers = {}

	local meshRenderers = trans:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

	for i = 0, meshRenderers.Length - 1 do
		local meshRenderer = meshRenderers[i]

		if meshRenderer.gameObject.name == meshName then
			table.insert(battleEntityTb.m_MeshRenderers, meshRenderer)

			this.m_MeshRenderersCache[meshRenderer.gameObject:GetInstanceID()] = meshRenderer.sortingOrder
		end
	end

	return battleEntityTb
end

function BattleEntitySortingOrderManager.DelBattleEntityData(key)
	if this.m_BattleEntities[key] ~= nil then
		if this.m_BattleEntitiesOrderChangeRecord[key] ~= nil and this.m_BattleEntitiesOrderChangeRecord[key] ~= 0 then
			this.UpdateAllSortingOrder(key, this.m_BattleEntities[key], -this.m_BattleEntitiesOrderChangeRecord[key])
		end

		this.m_BattleEntitiesOrderChangeRecord[key] = nil
		this.m_BattleEntities[key].m_ParticleSystemRenderers = nil

		for _, meshRenderer in pairs(this.m_BattleEntities[key].m_SkeletonMeshRenderers) do
			if meshRenderer ~= nil and meshRenderer.gameObject ~= nil and this.m_SkeletonMeshRenderersCache[meshRenderer.gameObject:GetInstanceID()] ~= nil then
				meshRenderer.sortingOrder = this.m_SkeletonMeshRenderersCache[meshRenderer.gameObject:GetInstanceID()]
			end
		end

		for _, meshRenderer in pairs(this.m_BattleEntities[key].m_MeshRenderers) do
			if meshRenderer ~= nil and meshRenderer.gameObject ~= nil and this.m_MeshRenderersCache[meshRenderer.gameObject:GetInstanceID()] ~= nil then
				meshRenderer.sortingOrder = this.m_MeshRenderersCache[meshRenderer.gameObject:GetInstanceID()]
			end
		end

		this.m_BattleEntities[key].m_SkeletonMeshRenderers = nil
		this.m_BattleEntities[key].m_SpinePassRenderers = nil
		this.m_BattleEntities[key].m_MeshRenderers = nil
		this.m_BattleEntities[key].m_Transform = nil
		this.m_BattleEntities[key] = nil
	end
end

function BattleEntitySortingOrderManager.GetCurRow(node)
	local z = node.m_Transform.position.z

	if z > this.m_HalfScopeDistance then
		return -1
	elseif z >= -this.m_HalfScopeDistance then
		return 0
	else
		return 1
	end
end

function BattleEntitySortingOrderManager.UpdateAllSortingOrder(entityId, node, sortingOrderChange)
	for _, meshRenderer in pairs(node.m_MeshRenderers) do
		if meshRenderer then
			meshRenderer.sortingOrder = meshRenderer.sortingOrder + sortingOrderChange
		end
	end

	local len = node.m_ParticleSystemRenderers.Length

	for i = 0, len - 1 do
		local renderer = node.m_ParticleSystemRenderers[i]

		if renderer then
			renderer.sortingOrder = renderer.sortingOrder + sortingOrderChange
		end
	end

	for _, meshRenderer in pairs(node.m_SkeletonMeshRenderers) do
		if meshRenderer then
			meshRenderer.sortingOrder = meshRenderer.sortingOrder + sortingOrderChange
		end
	end

	for _, pass in pairs(node.m_SpinePassRenderers) do
		if not LuaCodeInterface.IsUnityNull(pass) then
			pass:AddOrder(sortingOrderChange)
		end
	end

	this.m_BattleEntitiesOrderChangeRecord[entityId] = this.m_BattleEntitiesOrderChangeRecord[entityId] + sortingOrderChange
end
