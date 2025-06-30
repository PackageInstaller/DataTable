-- chunkname: @IQIGame\\UI\\FlightGameTeamUI.lua

local FlightGameTeamUI = {
	entityId = 0,
	haveMaterials = false,
	flightPlayerHeadCells = {},
	flightChallengePlayerAttrCells = {},
	flightPlayerMaterialCellPool = {}
}

FlightGameTeamUI = Base:Extend("FlightGameTeamUI", "IQIGame.Onigao.UI.FlightGameTeamUI", FlightGameTeamUI)

require("IQIGame.UIExternalApi.FlightGameTeamUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FlightGameTeamPlayerHeadCell = require("IQIGame.UI.ExploreHall.FlightChallenge.FlightGameTeam.FlightGameTeamPlayerHeadCell")
local FlightGamePlayerAttrCell = require("IQIGame.UI.ExploreHall.FlightChallenge.FlightGameFormation.FlightGamePlayerAttrCell")
local FlightPlayerMaterialsCell = require("IQIGame.UI.ExploreHall.FlightChallenge.FlightGameTeam.FlightPlayerMaterialsCell")

function FlightGameTeamUI:OnInit()
	UGUIUtil.SetText(self.TitleText, FlightGameTeamUIApi:GetString("TitleText"))

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateBtnUpGrade()
		self:OnBtnUpGrade()
	end

	function self.DelegateUpdateFlightChallenge()
		self:OnUpdateFlightChallenge()
	end

	function self.DelegateOnShowEntitySuccess(sender, args)
		self:OnShowEntitySuccess(sender, args)
	end

	function self.DelegateUpdateItem()
		self:OnUpdateItem()
	end

	self.PlayerHeadPrefab:SetActive(false)

	self.flightGameTeamPlayerHeadCellPool = UIObjectPool.New(3, function()
		local cell = FlightGameTeamPlayerHeadCell.New(UnityEngine.Object.Instantiate(self.PlayerHeadPrefab))

		function cell.clickSelfCallBack(flightPlayerData)
			self:OnSelectPlayHeadCell(flightPlayerData)
		end

		return cell
	end, function(cell)
		cell:Dispose()
	end)

	self.AttrPrefab:SetActive(false)

	self.flightChallengePlayerAttrPool = UIObjectPool.New(5, function()
		return FlightGamePlayerAttrCell.New(UnityEngine.Object.Instantiate(self.AttrPrefab))
	end, function(cell)
		cell:Dispose()
	end)
	self.flightPlayerMaterialCellPool = {}

	for i = 0, self.MaterialsNode.transform.childCount - 1 do
		local materialCell = FlightPlayerMaterialsCell.New(self.MaterialsNode.transform:GetChild(i).gameObject)

		table.insert(self.flightPlayerMaterialCellPool, materialCell)
	end
end

function FlightGameTeamUI:GetPreloadAssetPaths()
	return nil
end

function FlightGameTeamUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FlightGameTeamUI:IsManualShowOnOpen(userData)
	return false
end

function FlightGameTeamUI:GetBGM(userData)
	return nil
end

function FlightGameTeamUI:OnOpen(userData)
	self:UpdateView()
end

function FlightGameTeamUI:OnClose(userData)
	self:HideEntity()
end

function FlightGameTeamUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnUpGrade:GetComponent("Button").onClick:AddListener(self.DelegateBtnUpGrade)
	EventDispatcher.AddEventListener(EventID.UpdateFlightChallengeEvent, self.DelegateUpdateFlightChallenge)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowEntitySuccess)
end

function FlightGameTeamUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnUpGrade:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnUpGrade)
	EventDispatcher.RemoveEventListener(EventID.UpdateFlightChallengeEvent, self.DelegateUpdateFlightChallenge)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowEntitySuccess)
end

function FlightGameTeamUI:OnPause()
	return
end

function FlightGameTeamUI:OnResume()
	return
end

function FlightGameTeamUI:OnCover()
	return
end

function FlightGameTeamUI:OnReveal()
	return
end

function FlightGameTeamUI:OnRefocus(userData)
	return
end

function FlightGameTeamUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FlightGameTeamUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FlightGameTeamUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FlightGameTeamUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FlightGameTeamUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:HideEntity()

	for i, v in pairs(self.flightPlayerHeadCells) do
		self.flightGameTeamPlayerHeadCellPool:Release(v)
	end

	self.flightPlayerHeadCells = {}

	self.flightGameTeamPlayerHeadCellPool:Dispose()

	for i, v in pairs(self.flightChallengePlayerAttrCells) do
		self.flightChallengePlayerAttrPool:Release(v)
	end

	self.flightChallengePlayerAttrCells = {}

	self.flightChallengePlayerAttrPool:Dispose()

	for i, v in pairs(self.flightPlayerMaterialCellPool) do
		v:Dispose()
	end
end

function FlightGameTeamUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function FlightGameTeamUI:OnSelectPlayHeadCell(flightPlayerData)
	if self.selectPlayerData and self.selectPlayerData.cid == flightPlayerData.cid then
		return
	end

	self.selectPlayerData = flightPlayerData

	for i, v in pairs(self.flightPlayerHeadCells) do
		v:SetSelect(v.playerData.cid == self.selectPlayerData.cid)
	end

	self:ShowSelect()
end

function FlightGameTeamUI:OnUpdateFlightChallenge()
	self:UpdateView()
end

function FlightGameTeamUI:OnUpdateItem()
	for i, v in pairs(self.flightPlayerHeadCells) do
		v:SetRedPoint(v.playerData:CanBeUpgraded())
	end
end

function FlightGameTeamUI:UpdateView()
	for i, v in pairs(self.flightPlayerHeadCells) do
		self.flightGameTeamPlayerHeadCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.flightPlayerHeadCells = {}

	for i, v in pairs(FlightChallengeModule.flightGamePlayer) do
		if self.selectPlayerData == nil then
			self.selectPlayerData = v
		elseif self.selectPlayerData.cid == v.cid then
			self.selectPlayerData = v
		end

		local flightPlayerHeadCell = self.flightGameTeamPlayerHeadCellPool:Obtain()

		flightPlayerHeadCell.View:SetActive(true)
		flightPlayerHeadCell.View.transform:SetParent(self.PlayerList.transform, false)
		flightPlayerHeadCell:SetData(v)
		flightPlayerHeadCell:SetSelect(self.selectPlayerData.cid == v.cid)
		flightPlayerHeadCell:SetRedPoint(v:CanBeUpgraded())
		table.insert(self.flightPlayerHeadCells, flightPlayerHeadCell)
	end

	self:ShowSelect()
end

function FlightGameTeamUI:ShowSelect()
	for i, v in pairs(self.flightChallengePlayerAttrCells) do
		self.flightChallengePlayerAttrPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.haveMaterials = false
	self.flightChallengePlayerAttrCells = {}

	if self.selectPlayerData then
		UGUIUtil.SetText(self.TextPlayerName, self.selectPlayerData:GetConfigData().Name)
		UGUIUtil.SetText(self.TextSkill, self.selectPlayerData:GetConfigData().Skill)

		for i, v in pairs(self.selectPlayerData.flightChallengeMechaPOD.growthAttribute) do
			local playerAttrCell = self.flightChallengePlayerAttrPool:Obtain()

			playerAttrCell.View:SetActive(true)
			playerAttrCell.View.transform:SetParent(self.PlayerAttrNode.transform, false)
			playerAttrCell:SetData(i, v)
			table.insert(self.flightChallengePlayerAttrCells, playerAttrCell)
		end

		local materialIds = FlightChallengeModule.flightPlayerUpdateSpend[self.selectPlayerData.cid]

		table.sort(materialIds, function(a, b)
			return a < b
		end)

		for j = 1, #materialIds do
			local id = materialIds[j]
			local itemID = CfgFlightChallengeElementTable[id].ItemID
			local num = WarehouseModule.GetItemNumByCfgID(itemID)

			if self.flightPlayerMaterialCellPool[j] then
				self.flightPlayerMaterialCellPool[j]:SetData(itemID, num)
			end

			if num > 0 then
				self.haveMaterials = true
			end
		end

		self:ShowElement(self.selectPlayerData:GetConfigData().PlayerSpine)
	end

	self.ImgRed:SetActive(self.haveMaterials)
end

function FlightGameTeamUI:ShowElement(entityCid)
	self:HideEntity()

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.entityId, entityCid, 0, self.SpinePoint.transform, Vector3.zero)
end

function FlightGameTeamUI:HideEntity()
	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function FlightGameTeamUI:OnShowEntitySuccess(sender, args)
	if self.entityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(100, 100, 100)

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")

		local renderers = args.Entity:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			renderers[i].sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Default")
		end

		local canvas = self.UIController.gameObject:GetComponent("Canvas")

		args.Entity.gameObject:GetComponentInChildren(typeof(UnityEngine.Renderer)).sortingOrder = canvas.sortingOrder + 1

		local playerSkeletonAnimation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		playerSkeletonAnimation.state:SetAnimation(0, "Flight", true)
	end
end

function FlightGameTeamUI:OnBtnUpGrade()
	if self.selectPlayerData == nil then
		return
	end

	if not FlightChallengeModule.IsShow() then
		return
	end

	if not self.haveMaterials then
		NoticeModule.ShowNotice(21040078)

		return
	end

	FlightChallengeModule.FlightChallengeLevelUp(self.selectPlayerData.cid)
end

return FlightGameTeamUI
