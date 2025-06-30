-- chunkname: @IQIGame\\Scene\\AmusementPark\\AmusementParkBuildAreaCell.lua

local m = {
	EntityId = 0,
	IsInit = false,
	NpcWalkAreas = {},
	NpcPool = {},
	StaticNpcPool = {}
}
local AmusementParkNpcWalkAreaData = require("IQIGame.Scene.AmusementPark.AmusementParkNpcWalkAreaData")
local AmusementParkNPC = require("IQIGame.Scene.AmusementPark.AmusementParkNPC")

function m.New(view, RootNpcPrefab)
	local obj = Clone(m)

	obj:Init(view, RootNpcPrefab)

	return obj
end

function m:Init(view, RootNpcPrefab)
	self.View = view
	self.RootNpcPrefab = RootNpcPrefab

	LuaCodeInterface.BindOutlet(self.View, self)
	self.BuildEffect:SetActive(false)
	self.LevelUpEffect:SetActive(false)

	function self.DelegateBuildLevelUpEffect(id)
		self:OnBuildLevelUpEffect(id)
	end

	function self.DelegateBuildEffect(id)
		self:OnBuildEffect(id)
	end

	self.IsInit = false
	self.BuildAreaCollider = self.View:GetComponent(typeof(UnityEngine.Collider2D))
	self.BuildCollider = self.RootBuilding:GetComponent(typeof(UnityEngine.Collider2D))

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self:AddListener()
	self:SetSelect(false)
end

function m:AddListener()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	EventDispatcher.AddEventListener(EventID.APBuildLevelUpEffect, self.DelegateBuildLevelUpEffect)
	EventDispatcher.AddEventListener(EventID.APBuildEffect, self.DelegateBuildEffect)
end

function m:RemoveListener()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	EventDispatcher.RemoveEventListener(EventID.APBuildLevelUpEffect, self.DelegateBuildLevelUpEffect)
	EventDispatcher.RemoveEventListener(EventID.APBuildEffect, self.DelegateBuildEffect)
end

function m:OnUpdate()
	for i, v in pairs(self.StaticNpcPool) do
		v:OnUpdate()
	end

	for i, v in pairs(self.NpcPool) do
		v:OnUpdate()
	end
end

function m:InitNpcData()
	self:InitNpcWalkAreaPosData()
	self:InitStaticNpc()

	self.IsInit = true

	self:RefreshBuildNpc()
end

function m:InitNpcWalkAreaPosData()
	self.NpcWalkAreas = {}

	local SoulPath = self.BuildObj.transform:Find("Soul")

	if SoulPath then
		for i = 1, SoulPath.childCount do
			local trans = SoulPath.transform:Find("WalkArea_" .. i)

			if trans then
				local walkAreaData = AmusementParkNpcWalkAreaData.New(trans)

				table.insert(self.NpcWalkAreas, walkAreaData)
			end
		end
	end
end

function m:InitStaticNpc()
	for i = 0, self.BuildObj.transform.childCount - 1 do
		local object = self.BuildObj.transform:GetChild(i).gameObject
		local strTab = string.split(object.name, "_")
		local objType = strTab[1]
		local value = tonumber(strTab[2])

		if objType == "Npc" then
			local npc = AmusementParkNPC.New(object)

			npc:RefreshStatic(value)

			self.StaticNpcPool[value] = npc
		end
	end
end

function m:RefreshBuildNpc()
	if not self.IsInit then
		return
	end

	self:CleanNpc()

	if self.BuildAreaData then
		local buildData = self.BuildAreaData:GetAreaBuildData()

		if buildData then
			local players = buildData:GetBuildPlayers()

			for i = 1, #players do
				local roID = players[i]
				local roData = CfgAmusementParkRoleTable[roID]
				local walkAreaData = self.NpcWalkAreas[i]

				self:AddNpc(roData, walkAreaData)
			end
		end
	end
end

function m:CleanNpc()
	for i, v in pairs(self.NpcPool) do
		v:OnDestroy()
	end

	self.NpcPool = {}
end

function m:AddNpc(roData, areaData)
	local npc = AmusementParkNPC.New(UnityEngine.Object.Instantiate(self.RootNpcPrefab))

	self.NpcPool[roData.Id] = npc

	local randomPos = areaData:GetRandomPoint()

	npc:Refresh(roData, randomPos, areaData, self.BuildAreaData)
end

function m:SetData(buildAreaData)
	self.BuildCollider.enabled = false
	self.BuildAreaData = buildAreaData

	local buildData = self.BuildAreaData:GetAreaBuildData()

	self.RootBuilding.gameObject:SetActive(buildData ~= nil)
	self.RootEmpty.gameObject:SetActive(buildData == nil)

	if buildData ~= nil then
		local cfgBuildLevelData = buildData:GetCfgBuildLevelData()

		if cfgBuildLevelData then
			self:ShowBuilding(cfgBuildLevelData.Entity)
		end
	end

	local isOpen = self.BuildAreaData:IsOpen()

	self.View:SetActive(isOpen)
end

function m:ShowBuilding(elementEntityCid)
	if self.LastCfgBuild == elementEntityCid then
		return
	end

	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.EntityId, elementEntityCid, 0, self.RootBuilding.transform, Vector3.zero, nil, false)

	self.LastCfgBuild = elementEntityCid
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
		self.LastCfgBuild = nil
	end
end

function m:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		self.BuildObj = args.Entity.gameObject

		self:SetBuildOrder(1)
		self:InitNpcData()
	end
end

function m:SetSelect(top)
	self.Check:SetActive(top)

	if top then
		GameEntry.Sound:PlaySound(10201, Constant.SoundGroup.UI)
	end
end

function m:OnBuildLevelUpEffect(id)
	if self.BuildAreaData and self.BuildAreaData.pos == id then
		self:PlayLevelUpEffect()
	end
end

function m:OnBuildEffect(id)
	if self.BuildAreaData and self.BuildAreaData.pos == id then
		self:PlayBuildEffect()
	end
end

function m:PlayBuildEffect()
	self.BuildEffect:SetActive(false)
	self.BuildEffect:SetActive(true)

	local time = Timer.New(function()
		self.BuildEffect:SetActive(false)
	end, 2)

	time:Start()
end

function m:PlayLevelUpEffect()
	self.LevelUpEffect:SetActive(false)
	self.LevelUpEffect:SetActive(true)

	local time = Timer.New(function()
		self.LevelUpEffect:SetActive(false)
	end, 1)

	time:Start()
end

function m:SetBuildOrder(type)
	local value = 2 + self.BuildAreaData.pos

	if type == 2 then
		value = 1000
	end

	if self.BuildObj then
		local renderers = self.BuildObj:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			renderers[i].sortingOrder = value
		end
	end
end

function m:CheckBoundsIntersects(otherBuildCollider)
	return self.BuildAreaCollider.bounds:Intersects(otherBuildCollider.bounds)
end

function m:StartDrag()
	self:SetBuildOrder(2)

	self.BuildCollider.enabled = true
end

function m:OnDrag(pos)
	self.RootBuilding.transform.position = pos
end

function m:EndDrag()
	self:SetBuildOrder(1)

	self.RootBuilding.transform.localPosition = Vector3.New(0, 0, 0)
	self.BuildCollider.enabled = false
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self:CleanNpc()

	for i, v in pairs(self.StaticNpcPool) do
		v:OnDestroyStaticNPC()
	end

	self:HideEntity()

	self.NpcWalkAreas = {}

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
