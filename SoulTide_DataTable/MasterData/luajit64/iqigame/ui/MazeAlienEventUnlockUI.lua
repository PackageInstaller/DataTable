-- chunkname: @IQIGame\\UI\\MazeAlienEventUnlockUI.lua

local MazeAlienEventUnlockUI = {
	LastSpineSortingLayerID = 0,
	EntityId = 0,
	Page = 0
}

MazeAlienEventUnlockUI = Base:Extend("MazeAlienEventUnlockUI", "IQIGame.Onigao.UI.MazeAlienEventUnlockUI", MazeAlienEventUnlockUI)

function MazeAlienEventUnlockUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickPrevBtn()
		self:OnClickPrevBtn()
	end

	function self.DelegateOnClickNextBtn()
		self:OnClickNextBtn()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end
end

function MazeAlienEventUnlockUI:GetPreloadAssetPaths()
	return nil
end

function MazeAlienEventUnlockUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeAlienEventUnlockUI:OnOpen(userData)
	self:UpdateView(userData.dataList)
end

function MazeAlienEventUnlockUI:OnClose(userData)
	self:HideEntity()
end

function MazeAlienEventUnlockUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.PrevBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPrevBtn)
	self.NextBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNextBtn)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function MazeAlienEventUnlockUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.PrevBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPrevBtn)
	self.NextBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNextBtn)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function MazeAlienEventUnlockUI:OnPause()
	return
end

function MazeAlienEventUnlockUI:OnResume()
	return
end

function MazeAlienEventUnlockUI:OnCover()
	return
end

function MazeAlienEventUnlockUI:OnReveal()
	return
end

function MazeAlienEventUnlockUI:OnRefocus(userData)
	return
end

function MazeAlienEventUnlockUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeAlienEventUnlockUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Canvas = self.UIController:GetComponent("Canvas")

	self:UpdateSpineSortingOrder()
end

function MazeAlienEventUnlockUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeAlienEventUnlockUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeAlienEventUnlockUI:OnDestroy()
	return
end

function MazeAlienEventUnlockUI:UpdateView(dataList)
	self.DataList = dataList
	self.Page = 1

	self:ShowPage()
end

function MazeAlienEventUnlockUI:ShowPage()
	local data = self.DataList[self.Page]
	local cfgElementAllData = CfgElementAllTable[data.elementCid]

	self.NameText:GetComponent("Text").text = cfgElementAllData.Name
	self.DescText:GetComponent("Text").text = cfgElementAllData.Describe

	self:ShowElement(cfgElementAllData.EntityId)
	self.PrevBtn:SetActive(self.Page > 1)
	self.NextBtn:SetActive(self.Page < #self.DataList)
end

function MazeAlienEventUnlockUI:ShowElement(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.SpineNode.transform, Vector3.zero)
end

function MazeAlienEventUnlockUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		local transforms = args.Entity.gameObject:GetComponentsInChildren(typeof(UnityEngine.Transform), true)

		for i = 0, transforms.Length - 1 do
			transforms[i].gameObject.layer = LayerMask.NameToLayer("UI")
		end

		self.SpineRenderer = args.Entity.gameObject:GetComponentInChildren(typeof(UnityEngine.Renderer))
		self.LastSpineSortingLayerID = self.SpineRenderer.sortingLayerID
		self.SpineRenderer.sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Default")

		self:UpdateSpineSortingOrder()

		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end
	end
end

function MazeAlienEventUnlockUI:UpdateSpineSortingOrder()
	if self.SpineRenderer ~= nil and self.Canvas ~= nil then
		self.SpineRenderer.sortingOrder = self.Canvas.sortingOrder + 1
	end
end

function MazeAlienEventUnlockUI:HideEntity()
	if self.EntityId ~= 0 then
		self.SpineRenderer.sortingLayerID = self.LastSpineSortingLayerID

		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end

	self.SpineRenderer = nil
	self.LastSpineSortingLayerID = 0
end

function MazeAlienEventUnlockUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.MazeAlienEventUnlockUI)
end

function MazeAlienEventUnlockUI:OnClickPrevBtn()
	self.Page = self.Page - 1

	if self.Page < 1 then
		self.Page = 1
	end

	self:ShowPage()
end

function MazeAlienEventUnlockUI:OnClickNextBtn()
	self.Page = self.Page + 1

	if self.Page > #self.DataList then
		self.Page = #self.DataList
	end

	self:ShowPage()
end

return MazeAlienEventUnlockUI
