-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandRoleSpineCell.lua

local HomeLandRoleSpineCell = {
	EntityId = 0
}

function HomeLandRoleSpineCell.__New(itemCellView)
	local itemCell = Clone(HomeLandRoleSpineCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandRoleSpineCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.btnSelf = self.goView:GetComponent("Button")

	function self.delegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.delegateOnBtnSelf()
		self:OnClickBtnSelf()
	end

	self:AddListener()
end

function HomeLandRoleSpineCell:AddListener()
	self.btnSelf.onClick:AddListener(self.delegateOnBtnSelf)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function HomeLandRoleSpineCell:RemoveListener()
	self.btnSelf.onClick:RemoveListener(self.delegateOnBtnSelf)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function HomeLandRoleSpineCell:SetData(data)
	self.rolePOD = data

	self:Update()
end

function HomeLandRoleSpineCell:Update()
	if self.rolePOD then
		local cfgEntityID

		if self.rolePOD.dress3DCid > 0 then
			local soulID = CfgHomeLandRoleTable[self.rolePOD.roleCid].SoulId
			local soulData = SoulModule.GetSoulData(soulID)

			if soulData then
				cfgEntityID = soulData:GetCfgSoulRes3D().UIEntityId
			end
		else
			cfgEntityID = CfgHomeLandRoleTable[self.rolePOD.roleCid].EntityId
		end

		if cfgEntityID ~= nil then
			self:ShowElement(cfgEntityID)
		end
	end
end

function HomeLandRoleSpineCell:ShowElement(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.Spine.transform, Vector3.zero)
end

function HomeLandRoleSpineCell:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function HomeLandRoleSpineCell:OnShowElementEntitySuccess(sender, args)
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

function HomeLandRoleSpineCell:OnClickBtnSelf()
	if self.clickSelfCallBack then
		self.clickSelfCallBack(self.rolePOD)
	end
end

function HomeLandRoleSpineCell:Close()
	self:HideEntity()
end

function HomeLandRoleSpineCell:Dispose()
	self:HideEntity()
	self:RemoveListener()

	self.clickSelfCallBack = nil

	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.Destroy(self.goView)

	self.goView = nil
end

return HomeLandRoleSpineCell
