-- chunkname: @IQIGame\\UI\\ElementTipsUI.lua

local ElementTipsUI = Base:Extend("ElementTipsUI", "IQIGame.Onigao.UI.ElementTipsUI", {
	EntityId = 0
})

function ElementTipsUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end
end

function ElementTipsUI:GetPreloadAssetPaths()
	return nil
end

function ElementTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ElementTipsUI:OnOpen(userData)
	self:UpdateView(userData.cid)
end

function ElementTipsUI:OnClose(userData)
	self:HideEntity()
end

function ElementTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function ElementTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function ElementTipsUI:OnPause()
	return
end

function ElementTipsUI:OnResume()
	return
end

function ElementTipsUI:OnCover()
	return
end

function ElementTipsUI:OnReveal()
	return
end

function ElementTipsUI:OnRefocus(userData)
	return
end

function ElementTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ElementTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Canvas = self.UIController:GetComponent("Canvas")

	self:UpdateSpineSortingOrder()
end

function ElementTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ElementTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ElementTipsUI:OnDestroy()
	return
end

function ElementTipsUI:UpdateView(townAlienEventBookResCid)
	local cfgTownAlienEventBookResData = CfgTownAlienEventBookResTable[townAlienEventBookResCid]

	UGUIUtil.SetText(self.TitleText, cfgTownAlienEventBookResData.TitleDescribe)
	UGUIUtil.SetText(self.DescText, cfgTownAlienEventBookResData.Describe)
	self:ShowElement(cfgTownAlienEventBookResData.EntityID)
end

function ElementTipsUI:ShowElement(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.SpineNode.transform, Vector3.zero)
end

function ElementTipsUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function ElementTipsUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.ElementTipsUI)
end

function ElementTipsUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		local transforms = args.Entity.gameObject:GetComponentsInChildren(typeof(UnityEngine.Transform), true)

		for i = 0, transforms.Length - 1 do
			transforms[i].gameObject.layer = LayerMask.NameToLayer("UI")
		end

		self.SpineRenderers = args.Entity.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		self:UpdateSpineSortingOrder()

		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end
	end
end

function ElementTipsUI:UpdateSpineSortingOrder()
	if self.SpineRenderers ~= nil and self.Canvas ~= nil then
		for i = 0, self.SpineRenderers.Length - 1 do
			self.SpineRenderers[i].sortingOrder = self.Canvas.sortingOrder + 1
		end
	end
end

return ElementTipsUI
