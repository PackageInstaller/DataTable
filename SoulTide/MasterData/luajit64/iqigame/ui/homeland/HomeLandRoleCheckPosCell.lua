-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandRoleCheckPosCell.lua

local HomeLandRoleCheckPosCell = {
	EntityId = 0
}

function HomeLandRoleCheckPosCell.__New(itemCellView)
	local itemCell = Clone(HomeLandRoleCheckPosCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandRoleCheckPosCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	UGUIUtil.SetText(self.BtnRemoveTitle, HomeLandSoulCheckInUIApi:GetString("BtnRemoveTitle"))
	UGUIUtil.SetText(self.BtnNullTitle, HomeLandSoulCheckInUIApi:GetString("BtnNullTitle"))

	self.btnRemoveComponent = self.BtnRemove:GetComponent("Button")

	function self.delegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.delegateOnBtnRemove()
		self:OnClickBtnRemove()
	end

	self:AddListener()
end

function HomeLandRoleCheckPosCell:AddListener()
	self.btnRemoveComponent.onClick:AddListener(self.delegateOnBtnRemove)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function HomeLandRoleCheckPosCell:RemoveListener()
	self.btnRemoveComponent.onClick:RemoveListener(self.delegateOnBtnRemove)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function HomeLandRoleCheckPosCell:SetData(data)
	self.rolePOD = data

	self:Update()
end

function HomeLandRoleCheckPosCell:Update()
	if self.rolePOD then
		local cfgEntityID

		if self.rolePOD.dress3DCid > 0 then
			local soulID = CfgHomeLandRoleTable[self.rolePOD.roleCid].SoulId
			local soulData = SoulModule.GetSoulData(soulID)

			cfgEntityID = soulData:GetCfgSoulRes3D().UIEntityId
		else
			cfgEntityID = CfgHomeLandRoleTable[self.rolePOD.roleCid].EntityId
		end

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

function HomeLandRoleCheckPosCell:ShowElement(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.Spine.transform, Vector3.zero)
end

function HomeLandRoleCheckPosCell:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function HomeLandRoleCheckPosCell:OnShowElementEntitySuccess(sender, args)
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

function HomeLandRoleCheckPosCell:OnClickBtnRemove()
	HomeLandLuaModule.EnterRoom(0, self.rolePOD.roleCid)
end

function HomeLandRoleCheckPosCell:Close()
	self:HideEntity()
end

function HomeLandRoleCheckPosCell:Dispose()
	self:HideEntity()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.Destroy(self.goView)

	self.goView = nil
end

return HomeLandRoleCheckPosCell
