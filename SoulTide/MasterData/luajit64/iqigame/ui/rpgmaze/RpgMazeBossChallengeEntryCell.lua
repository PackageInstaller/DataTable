-- chunkname: @IQIGame\\UI\\RpgMaze\\RpgMazeBossChallengeEntryCell.lua

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
	self.Root = root

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self:AddListener()
end

function m:AddListener()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:RemoveListener()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:SetData(rpgMazeBoosID)
	self.RPGMazeBossCid = rpgMazeBoosID

	self:UpdateView()
end

function m:UpdateView()
	self.cfgRPGMazeBossData = CfgRPGMazeBossTable[self.RPGMazeBossCid]

	local cfgMonsterData = CfgMonsterTable[self.cfgRPGMazeBossData.Monster]

	self.cfgMonsterRes = CfgTownMonsterBookResTable[cfgMonsterData.ArchivesID]

	UGUIUtil.SetText(self.TextBossName, cfgMonsterData.Name)
	self:ShowMonster(cfgMonsterData.EntityID)

	self.isUnlock = RpgMazeModule.IsUnlockBoos(self.RPGMazeBossCid)

	self.Lock:SetActive(not self.isUnlock)
	self.Spine:SetActive(self.isUnlock)
end

function m:ShowMonster(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.Spine.transform, Vector3.zero)
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		local entity = GameEntry.Entity:GetEntity(self.EntityId)

		if not LuaCodeInterface.GameObjIsDestroy(entity) then
			EntityShowUtil.SetColor(entity.gameObject, Color.white)
		end

		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function m:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(self.cfgMonsterRes.EntityScale[1], self.cfgMonsterRes.EntityScale[2], self.cfgMonsterRes.EntityScale[3])
		args.Entity.gameObject.transform.localPosition = Vector3(self.cfgMonsterRes.EntityPosition[1], self.cfgMonsterRes.EntityPosition[2], self.cfgMonsterRes.EntityPosition[3])
		self.SpineRenderers = args.Entity.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end

		self:UpdateSpineSortingOrder()
		setGameObjectLayers(args.Entity.gameObject.transform, "UI")

		if self.isUnlock then
			EntityShowUtil.SetColor(args.Entity.gameObject, Color.white)
		else
			EntityShowUtil.SetColor(args.Entity.gameObject, Color.black)
		end
	end
end

function m:UpdateSpineSortingOrder()
	if self.SpineRenderers ~= nil then
		local canvas = self.Root.UIController.gameObject:GetComponent("Canvas")

		for i = 0, self.SpineRenderers.Length - 1 do
			self.SpineRenderers[i].sortingOrder = canvas.sortingOrder
		end
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:HideEntity()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
