-- chunkname: @IQIGame\\UI\\HomeLandRoom\\HomeLandRoomRenderAICell.lua

local m = {
	EntityId = 0,
	cd = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self.aiTimer = Timer.New(function()
		self:OnTimer()
	end, 1, -1)

	self:OnAddListeners()
end

function m:OnAddListeners()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function m:OnRemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function m:SetData(cfgData)
	self.cfgData = cfgData

	if self.cfgData then
		self:Update()
	else
		self:StopAI()
		self.View:SetActive(false)
	end
end

function m:Update()
	if self.cfgData then
		self.View:SetActive(true)

		if HomeLandLuaModule.isVisitHome then
			local homeRolePOD = HomeLandLuaModule.GetDormRoleByCid(self.cfgData.Id)

			if homeRolePOD then
				local cfgDress3D = CfgDressTable[homeRolePOD.dress3DCid]

				self:ShowElement(CfgSoulResTable[cfgDress3D.SoulResID].UIEntityId)
			end
		else
			self:ShowElement(SoulModule.GetSoulData(self.cfgData.Id):GetCfgSoulRes3D().UIEntityId)
		end
	end
end

function m:ShowElement(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.View.transform, Vector3.zero)
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function m:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		self.entityObj = args.Entity.gameObject

		self:OnTimer()
		self:StartAI()
	end
end

function m:OnTimer()
	if LuaCodeInterface.GameObjIsDestroy(self.entityObj) then
		return
	end

	self.cd = self.cd - 1

	if self.cd <= 0 then
		local anim = self.cfgData.BehaviorList[math.random(1, #self.cfgData.BehaviorList)]
		local validNames = {}

		LuaCodeInterface.GetSpineAnimationNames(self.entityObj, validNames)

		local isValidAnimation = false

		for m, n in pairs(validNames) do
			if n == anim then
				isValidAnimation = true

				break
			end
		end

		if isValidAnimation then
			local skeletonGraphic = self.entityObj:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

			if skeletonGraphic then
				local skeletonAnimation = skeletonGraphic.AnimationState

				if skeletonAnimation then
					skeletonAnimation:SetEmptyAnimation(0, 0)
					skeletonAnimation:SetAnimation(0, anim, true)
				end
			end

			local localScale = self.entityObj.transform.localScale
			local randomRet = math.random(-1, 1)

			if randomRet >= 0 then
				localScale.x = math.abs(localScale.x)
			else
				localScale.x = -math.abs(localScale.x)
			end

			self.entityObj.transform.localScale = localScale
		end

		self.cd = self:RandomCounter()
	end
end

function m:RandomCounter()
	return math.random(3, 20)
end

function m:StartAI()
	self.aiTimer:Stop()

	self.cd = self:RandomCounter()

	self.aiTimer:Start()
end

function m:StopAI()
	self.cd = 0

	self.aiTimer:Stop()
end

function m:Dispose()
	if self.aiTimer then
		self.aiTimer:Stop()

		self.aiTimer = nil
	end

	self.cd = 0

	self:HideEntity()
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
