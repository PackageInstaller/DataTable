-- chunkname: @IQIGame\\UI\\MonsterInfoUI.lua

local MonsterInfoUI = Base:Extend("MonsterInfoUI", "IQIGame.Onigao.UI.MonsterInfoUI", {
	EntityId = 0
})

function MonsterInfoUI:OnInit()
	function self.delegateClickBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end
end

function MonsterInfoUI:GetPreloadAssetPaths()
	return nil
end

function MonsterInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterInfoUI:OnOpen(userData)
	self.monsterID = userData

	self:UpdateView()
end

function MonsterInfoUI:OnClose(userData)
	self:HideEntity()
end

function MonsterInfoUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function MonsterInfoUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function MonsterInfoUI:OnPause()
	return
end

function MonsterInfoUI:OnResume()
	return
end

function MonsterInfoUI:OnCover()
	return
end

function MonsterInfoUI:OnReveal()
	return
end

function MonsterInfoUI:OnRefocus(userData)
	return
end

function MonsterInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterInfoUI:OnDestroy()
	return
end

function MonsterInfoUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.MonsterInfoUI)
end

function MonsterInfoUI:UpdateView()
	local cfgMonster = CfgMonsterTable[self.monsterID]

	self.TextMonster:GetComponent("Text").text = cfgMonster.Explain
	self.TextTitle:GetComponent("Text").text = cfgMonster.Name

	self:ShowElement(cfgMonster.EntityID)
end

function MonsterInfoUI:ShowElement(EntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	local cfgMonster = CfgMonsterTable[self.monsterID]
	local pos = Vector3.zero

	if cfgMonster.ShowUiPosition ~= nil then
		pos = Vector3(cfgMonster.ShowUiPosition[1], cfgMonster.ShowUiPosition[2], cfgMonster.ShowUiPosition[3])
	end

	GameEntry.Entity:ShowUIElement(self.EntityId, EntityCid, 0, self.MonsterPos.transform, pos)
end

function MonsterInfoUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function MonsterInfoUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		local monsterObj = args.Entity.gameObject

		setGameObjectLayers(monsterObj.transform, IQIGame.Onigao.Game.Constant.Layer.UI_LAYER_NAME)

		local skeletonAnimation = monsterObj:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		skeletonAnimation.loop = true
		skeletonAnimation.AnimationName = nil
		skeletonAnimation.AnimationName = "idle"

		local cfgMonster = CfgMonsterTable[self.monsterID]

		if cfgMonster.ShowUiSize ~= nil then
			monsterObj.transform.localScale = Vector3(cfgMonster.ShowUiSize, cfgMonster.ShowUiSize, cfgMonster.ShowUiSize)
		end
	end
end

return MonsterInfoUI
