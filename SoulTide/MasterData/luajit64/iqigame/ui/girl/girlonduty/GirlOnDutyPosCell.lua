-- chunkname: @IQIGame\\UI\\Girl\\GirlOnDuty\\GirlOnDutyPosCell.lua

local m = {
	EntityId = 0
}

function m.New(view, index)
	local obj = Clone(m)

	obj:Init(view, index)

	return obj
end

function m:Init(view, index)
	self.View = view
	self.index = index

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.BtnRemoveTitle, GirlOnDutyUIApi:GetString("BtnRemoveTitle"))
	UGUIUtil.SetText(self.BtnNullTitle, GirlOnDutyUIApi:GetString("BtnNullTitle"))

	local p = self.index * 2 - 1
	local startTime = CfgDiscreteDataTable[6520088].Data[p]
	local endTime = CfgDiscreteDataTable[6520088].Data[p + 1]

	UGUIUtil.SetText(self.TextTime, GirlOnDutyUIApi:GetString("TextTime", startTime, endTime))

	function self.delegateOnBtnRemove()
		self:OnClickBtnRemove()
	end

	function self.delegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnRemove:GetComponent("Button").onClick:AddListener(self.delegateOnBtnRemove)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function m:RemoveListener()
	self.BtnRemove:GetComponent("Button").onClick:RemoveListener(self.delegateOnBtnRemove)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function m:SetData(soulData)
	self.soulData = soulData

	if self.soulData then
		local cfgEntityID = soulData:GetCfgSoulRes3D().UIEntityId

		if cfgEntityID ~= nil then
			self:ShowElement(cfgEntityID)
		end

		self.BtnNull:SetActive(false)
		self.BtnRemove:SetActive(true)
	else
		self.BtnNull:SetActive(true)
		self.BtnRemove:SetActive(false)
		self:HideEntity()
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

function m:OnClickBtnRemove()
	if self.removeSoulCallBack then
		self.removeSoulCallBack(self.index, self.soulData)
	end
end

function m:Close()
	self:HideEntity()
end

function m:Dispose()
	self:HideEntity()
	self:RemoveListener()

	self.removeSoulCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
