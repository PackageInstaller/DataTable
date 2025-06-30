-- chunkname: @IQIGame\\Scene\\Survival\\SurvivalFlyGameRewardBoxCell.lua

local m = {
	picked = false,
	moveSpeed = -5,
	active = false,
	entityId = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnShowEntitySuccess(sender, args)
		self:OnShowEntitySuccess(sender, args)
	end

	self:AddListener()
	self:Reset()
end

function m:AddListener()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowEntitySuccess)
end

function m:RemoveListener()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowEntitySuccess)
end

function m:FrameUpdate()
	if self.active then
		self.View.transform:Translate(Vector3.New(self.moveSpeed * UnityEngine.Time.deltaTime, 0, 0))
	end
end

function m:SetData(pos, rewardBoxData, callback)
	self.rewardBoxData = rewardBoxData
	self.moveSpeed = self.rewardBoxData:GetChallengeRewardBoxAttr(FlightGameConstant.Attribute.Flight_Element_Move_Speed)
	self.moveSpeed = self.moveSpeed > 0 and -self.moveSpeed or self.moveSpeed
	self.View.transform.position = pos

	self.View:SetActive(true)

	self.recycleEnemyCallBack = callback
	self.active = true

	self:ShowElement(self.rewardBoxData:GetConfigData().ItemSpine)
end

function m:Pickup()
	self.picked = true

	self.Effect:SetActive(false)
	self.Effect:SetActive(true)
	self.SpineNode:SetActive(false)

	local timer = Timer.New(function()
		if self.recycleEnemyCallBack then
			self.recycleEnemyCallBack(self)
		end
	end, 1.2)

	timer:Start()
end

function m:Reset()
	self.collider2D = self.View:GetComponent(typeof(UnityEngine.Collider2D))
	self.rewardBoxData = nil
	self.recycleEnemyCallBack = nil
	self.active = false
	self.picked = false

	self.View:SetActive(false)
	self.Effect:SetActive(false)
	self.SpineNode:SetActive(true)
end

function m:ShowElement(entityCid)
	self:HideEntity()

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.entityId, entityCid, 0, self.SpineNode.transform, Vector3.zero)
end

function m:HideEntity()
	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function m:OnShowEntitySuccess(sender, args)
	if self.entityId == args.Entity.Id then
		setGameObjectLayers(args.Entity.gameObject.transform, "Default")

		local renderers = args.Entity:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			renderers[i].sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Default")
		end

		local polygonCollider2D = args.Entity.gameObject:GetComponent(typeof(UnityEngine.Collider2D))

		if polygonCollider2D then
			self.collider2D = polygonCollider2D
		end
	end
end

function m:Dispose()
	self.rewardBoxData = nil
	self.recycleEnemyCallBack = nil
	self.collider2D = nil

	self:HideEntity()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
