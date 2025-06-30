-- chunkname: @IQIGame\\UI\\FlightGameUpTipUI.lua

local FlightGameUpTipUI = {
	entityId = 0,
	flightGameUpAttrs = {}
}

FlightGameUpTipUI = Base:Extend("FlightGameUpTipUI", "IQIGame.Onigao.UI.FlightGameUpTipUI", FlightGameUpTipUI)

require("IQIGame.UIExternalApi.FlightGameUpTipUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FlightGameUpAttrCell = require("IQIGame.UI.ExploreHall.FlightChallenge.FlightGameUpTip.FlightGameUpAttrCell")

function FlightGameUpTipUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnShowEntitySuccess(sender, args)
		self:OnShowEntitySuccess(sender, args)
	end

	self.AttCellPrefab:SetActive(false)

	self.flightGameUpAttrPool = UIObjectPool.New(5, function()
		local cell = FlightGameUpAttrCell.New(UnityEngine.Object.Instantiate(self.AttCellPrefab))

		return cell
	end, function(cell)
		cell:Dispose()
	end)
end

function FlightGameUpTipUI:GetPreloadAssetPaths()
	return nil
end

function FlightGameUpTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FlightGameUpTipUI:IsManualShowOnOpen(userData)
	return false
end

function FlightGameUpTipUI:GetBGM(userData)
	return nil
end

function FlightGameUpTipUI:OnOpen(userData)
	self.playerData = userData.PlayerData
	self.oldData = userData.OldData
	self.newData = userData.NewData

	self:UpdateView()
end

function FlightGameUpTipUI:OnClose(userData)
	self:HideEntity()
end

function FlightGameUpTipUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowEntitySuccess)
end

function FlightGameUpTipUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowEntitySuccess)
end

function FlightGameUpTipUI:OnPause()
	return
end

function FlightGameUpTipUI:OnResume()
	return
end

function FlightGameUpTipUI:OnCover()
	return
end

function FlightGameUpTipUI:OnReveal()
	return
end

function FlightGameUpTipUI:OnRefocus(userData)
	return
end

function FlightGameUpTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FlightGameUpTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FlightGameUpTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FlightGameUpTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FlightGameUpTipUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:HideEntity()

	for i, v in pairs(self.flightGameUpAttrs) do
		self.flightGameUpAttrPool:Release(v)
	end

	self.flightGameUpAttrs = {}

	self.flightGameUpAttrPool:Dispose()
end

function FlightGameUpTipUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function FlightGameUpTipUI:UpdateView()
	UGUIUtil.SetText(self.AttTitle, FlightGameUpTipUIApi:GetString("AttTitle", CfgFlightChallengePlayerTable[self.newData.id].Name))

	for i, v in pairs(self.flightGameUpAttrs) do
		self.flightGameUpAttrPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.flightGameUpAttrs = {}

	for i, v in ipairs(self.newData.growthAttribute) do
		local oldValue = self.oldData.growthAttribute[i]

		if oldValue ~= v then
			local flightGameUpAttrCell = self.flightGameUpAttrPool:Obtain()

			flightGameUpAttrCell.View:SetActive(true)
			flightGameUpAttrCell.View.transform:SetParent(self.AttGrid.transform, false)
			flightGameUpAttrCell:SetData(i, oldValue, v)
			table.insert(self.flightGameUpAttrs, flightGameUpAttrCell)
		end
	end

	self:ShowElement(self.playerData:GetConfigData().PlayerSpine)
end

function FlightGameUpTipUI:ShowElement(entityCid)
	self:HideEntity()

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.entityId, entityCid, 0, self.SpineNode.transform, Vector3.zero)
end

function FlightGameUpTipUI:HideEntity()
	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function FlightGameUpTipUI:OnShowEntitySuccess(sender, args)
	if self.entityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(100, 100, 100)

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")

		local renderers = args.Entity:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			renderers[i].sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Default")
		end

		local canvas = self.UIController.gameObject:GetComponent("Canvas")

		args.Entity.gameObject:GetComponentInChildren(typeof(UnityEngine.Renderer)).sortingOrder = canvas.sortingOrder + 3

		local playerSkeletonAnimation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		playerSkeletonAnimation.state:SetAnimation(0, "Flight", true)
	end
end

return FlightGameUpTipUI
