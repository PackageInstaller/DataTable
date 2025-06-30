-- chunkname: @IQIGame\\UI\\HomeLand\\HLWorkList\\D3Cell.lua

local D3Cell = {
	npcRoots = {},
	entityids = {}
}

function D3Cell.New()
	local obj = Clone(D3Cell)

	obj:Init()

	return obj
end

function D3Cell:Init()
	self.aiTimer = Timer.New(function()
		self:OnTimer()
	end, 1, -1)
end

function D3Cell:Refresh(view, affairData)
	self.affairData = affairData

	if self.View ~= nil then
		LuaCodeInterface.ClearOutlet(self.View, self)
		UnityEngine.Object.Instantiate(self.View)
	end

	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.View:SetActive(true)

	self.soul2CounterDic = {}
	self.soul2EntityIDDic = {}
	self.npcRoots[1] = self.goPoint1
	self.npcRoots[2] = self.goPoint2
	self.npcRoots[3] = self.goPoint3

	self:RefreshAllNpc()
	self:StartAI()
end

function D3Cell:OnHide()
	self:StopAI()
	self:DisposeEntity()
end

function D3Cell:OnDestroy()
	if self.View == nil then
		return
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function D3Cell:OnAddListeners()
	return
end

function D3Cell:OnRemoveListeners()
	return
end

function D3Cell:OnTimer()
	for i, v in pairs(self.soul2CounterDic) do
		self.soul2CounterDic[i] = v - 1

		if self.soul2CounterDic[i] <= 0 then
			local entity = GameEntry.Entity:GetEntity(self.soul2EntityIDDic[i])

			if LuaCodeInterface.GameObjIsDestroy(entity) then
				return
			end

			local state = entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic)).AnimationState
			local cfgData = CfgHomeLandWorkBehaviorListTable[i]
			local anim = cfgData.BehaviorList[math.random(1, #cfgData.BehaviorList)]
			local validNames = {}

			LuaCodeInterface.GetSpineAnimationNames(entity.gameObject, validNames)

			local isValidAnimation = false

			for m, n in pairs(validNames) do
				if n == anim then
					isValidAnimation = true

					break
				end
			end

			if isValidAnimation then
				state:SetAnimation(0, anim, true)

				local localScale = entity.transform.localScale
				local randomRet = math.random(-1, 1)

				if randomRet >= 0 then
					localScale.x = math.abs(localScale.x)
				else
					localScale.x = -math.abs(localScale.x)
				end

				entity.transform.localScale = localScale
			end

			self:RandomCounter(i)
		end
	end
end

function D3Cell:RefreshAllNpc()
	self:DisposeEntity()

	local idleRoots = {}

	for i, v in pairs(self.npcRoots) do
		idleRoots[#idleRoots + 1] = v
	end

	for i, v in ipairs(self.affairData.soulCids) do
		local index = math.random(1, #idleRoots)
		local parent = idleRoots[index].transform

		table.remove(idleRoots, index)

		local cfgData = CfgHomeLandWorkBehaviorListTable[v]
		local entityId = GameEntry.Entity:GenerateEntityID()

		self.entityids[#self.entityids + 1] = entityId
		self.soul2EntityIDDic[v] = entityId

		GameEntry.Entity:ShowUIElement(entityId, SoulModule.GetSoulData(cfgData.Id):GetCfgSoulRes3D().UIEntityId, 0, parent, Vector3.zero)
	end
end

function D3Cell:DisposeEntity()
	for i, v in ipairs(self.entityids) do
		GameEntry.Entity:HideEntity(v)
	end

	self.entityids = {}
end

function D3Cell:StartAI()
	self:StopAI()

	for i, v in pairs(self.affairData.soulCids) do
		self:RandomCounter(v)
	end

	self.aiTimer:Start()
	self:OnTimer()
end

function D3Cell:StopAI()
	self.aiTimer:Stop()
end

function D3Cell:RandomCounter(soulCid)
	self.soul2CounterDic[soulCid] = math.random(3, 20)
end

return D3Cell
