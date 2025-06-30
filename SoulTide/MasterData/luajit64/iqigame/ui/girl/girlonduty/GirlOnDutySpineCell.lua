-- chunkname: @IQIGame\\UI\\Girl\\GirlOnDuty\\GirlOnDutySpineCell.lua

local m = {
	EntityId = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnBtnSelf()
		self:OnClickBtnSelf()
	end

	function self.delegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateOnBtnSelf)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateOnBtnSelf)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function m:SetData(data)
	self.soulData = data

	if self.soulData then
		local cfgEntityID = self.soulData:GetCfgSoulRes3D().UIEntityId

		if cfgEntityID ~= nil then
			self:ShowElement(cfgEntityID)
		end
	end
end

function m:ShowElement(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.Spine.transform, Vector3.zero)
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function m:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		local skeletonGraphic = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

		if skeletonGraphic then
			local skeletonAnimation = skeletonGraphic.AnimationState

			if skeletonAnimation then
				skeletonAnimation:SetEmptyAnimation(0, 0)
				skeletonAnimation:SetAnimation(0, "idle", true)
			end
		end
	end
end

function m:OnClickBtnSelf()
	if self.clickSelfCallBack then
		self.clickSelfCallBack(self.soulData)
	end
end

function m:Close()
	self:HideEntity()
end

function m:Dispose()
	self:HideEntity()
	self:RemoveListener()

	self.clickSelfCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
