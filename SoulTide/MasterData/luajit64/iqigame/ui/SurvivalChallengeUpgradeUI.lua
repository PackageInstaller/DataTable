-- chunkname: @IQIGame\\UI\\SurvivalChallengeUpgradeUI.lua

local SurvivalChallengeUpgradeUI = {
	haveMaterials = false,
	entityId = 0,
	survivalPlayerHeadCells = {},
	survivalPlayerAttrCells = {},
	upgradeStarPrefabPath = {}
}

SurvivalChallengeUpgradeUI = Base:Extend("SurvivalChallengeUpgradeUI", "IQIGame.Onigao.UI.SurvivalChallengeUpgradeUI", SurvivalChallengeUpgradeUI)

require("IQIGame.UIExternalApi.SurvivalChallengeUpgradeUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local SurvivalPlayerHeadCell = require("IQIGame.UI.ExploreHall.Survival.SurvivalChallengeUpgrade.SurvivalPlayerHeadCell")
local SurvivalPlayerAttrCell = require("IQIGame.UI.ExploreHall.Survival.SurvivalChallengeFormation.SurvivalPlayerAttrCell")
local SurvivalChallengeStarView = require("IQIGame.UI.ExploreHall.Survival.SurvivalChallengeUpgrade.SurvivalChallengeStarView")

function SurvivalChallengeUpgradeUI:OnInit()
	UGUIUtil.SetText(self.TitleText, SurvivalChallengeUpgradeUIApi:GetString("TitleText"))

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateBtnUpGrade()
		self:OnBtnUpGrade()
	end

	function self.DelegateSurvivalUpgradeEvent()
		self:OnUpdateFlightChallenge()
	end

	function self.DelegateOnShowEntitySuccess(sender, args)
		self:OnShowEntitySuccess(sender, args)
	end

	function self.DelegateUpdateItem()
		self:OnUpdateItem()
	end

	self.moneyCellBuilder = MoneyCellsBuilder.New(self.CurrencyCom)

	self.PlayerHeadPrefab:SetActive(false)

	self.survivalPlayerHeadCellPool = UIObjectPool.New(3, function()
		local cell = SurvivalPlayerHeadCell.New(UnityEngine.Object.Instantiate(self.PlayerHeadPrefab))

		function cell.clickSelfCallBack(flightPlayerData)
			self:OnSelectPlayHeadCell(flightPlayerData)
		end

		return cell
	end, function(cell)
		cell:Dispose()
	end)

	self.AttrPrefab:SetActive(false)

	self.survivalPlayerAttrPool = UIObjectPool.New(5, function()
		return SurvivalPlayerAttrCell.New(UnityEngine.Object.Instantiate(self.AttrPrefab))
	end, function(cell)
		cell:Dispose()
	end)
end

function SurvivalChallengeUpgradeUI:GetPreloadAssetPaths()
	return nil
end

function SurvivalChallengeUpgradeUI:GetOpenPreloadAssetPaths(userData)
	self.upgradeStarPrefabPath = {}

	local pathTab = {}

	for i, v in pairs(SurvivalModule.survivalPlayer) do
		local path = UIGlobalApi.GetUIPrefab(v:GetConfigData().PlayerStart)

		self.upgradeStarPrefabPath[v.cid] = path

		table.insert(pathTab, path)
	end

	return pathTab
end

function SurvivalChallengeUpgradeUI:IsManualShowOnOpen(userData)
	return false
end

function SurvivalChallengeUpgradeUI:GetBGM(userData)
	return nil
end

function SurvivalChallengeUpgradeUI:OnOpen(userData)
	local cfgControlData = CfgSurvivalChallengeControlTable[SurvivalModule.GlobalCid]

	self.moneyCellBuilder:RefreshView({
		cfgControlData.ItemId
	})
	self:UpdateView()
end

function SurvivalChallengeUpgradeUI:OnClose(userData)
	self:HideEntity()
end

function SurvivalChallengeUpgradeUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnUpGrade:GetComponent("Button").onClick:AddListener(self.DelegateBtnUpGrade)
	EventDispatcher.AddEventListener(EventID.SurvivalUpgradeEvent, self.DelegateSurvivalUpgradeEvent)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowEntitySuccess)
end

function SurvivalChallengeUpgradeUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnUpGrade:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnUpGrade)
	EventDispatcher.RemoveEventListener(EventID.SurvivalUpgradeEvent, self.DelegateSurvivalUpgradeEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowEntitySuccess)
end

function SurvivalChallengeUpgradeUI:OnPause()
	return
end

function SurvivalChallengeUpgradeUI:OnResume()
	return
end

function SurvivalChallengeUpgradeUI:OnCover()
	return
end

function SurvivalChallengeUpgradeUI:OnReveal()
	return
end

function SurvivalChallengeUpgradeUI:OnRefocus(userData)
	return
end

function SurvivalChallengeUpgradeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SurvivalChallengeUpgradeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SurvivalChallengeUpgradeUI:OnLoadSucceed(assetName, asset, duration, userData)
	local type = userData.type
	local cid = userData.cid

	if type == "loadStarPrefab" and cid == self.selectPlayerData.cid then
		self:LoadStarPrefab(asset)
	end
end

function SurvivalChallengeUpgradeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SurvivalChallengeUpgradeUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:HideEntity()

	for i, v in pairs(self.survivalPlayerHeadCells) do
		self.survivalPlayerHeadCellPool:Release(v)
	end

	self.survivalPlayerHeadCells = {}

	self.survivalPlayerHeadCellPool:Dispose()

	for i, v in pairs(self.survivalPlayerAttrCells) do
		self.survivalPlayerAttrPool:Release(v)
	end

	self.survivalPlayerAttrCells = {}

	self.survivalPlayerAttrPool:Dispose()
	self.survivalStarView:Dispose()

	self.survivalStarView = nil

	self.moneyCellBuilder:Dispose()

	self.moneyCellBuilder = nil
end

function SurvivalChallengeUpgradeUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function SurvivalChallengeUpgradeUI:OnSelectPlayHeadCell(flightPlayerData)
	if self.selectPlayerData and self.selectPlayerData.cid == flightPlayerData.cid then
		return
	end

	self.selectPlayerData = flightPlayerData

	for i, v in pairs(self.survivalPlayerHeadCells) do
		v:SetSelect(v.playerData.cid == self.selectPlayerData.cid)
	end

	self:ShowSelect()
end

function SurvivalChallengeUpgradeUI:OnUpdateFlightChallenge()
	self:UpdateView()
end

function SurvivalChallengeUpgradeUI:OnUpdateItem()
	for i, v in pairs(self.survivalPlayerHeadCells) do
		v:SetRedPoint(v.playerData:CanBeUpgraded())
	end
end

function SurvivalChallengeUpgradeUI:UpdateView()
	for i, v in pairs(self.survivalPlayerHeadCells) do
		self.survivalPlayerHeadCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.survivalPlayerHeadCells = {}

	for i, v in pairs(SurvivalModule.survivalPlayer) do
		if self.selectPlayerData == nil then
			self.selectPlayerData = v
		elseif self.selectPlayerData.cid == v.cid then
			self.selectPlayerData = v
		end

		local flightPlayerHeadCell = self.survivalPlayerHeadCellPool:Obtain()

		flightPlayerHeadCell.View:SetActive(true)
		flightPlayerHeadCell.View.transform:SetParent(self.PlayerList.transform, false)
		flightPlayerHeadCell:SetData(v)
		flightPlayerHeadCell:SetSelect(self.selectPlayerData.cid == v.cid)
		flightPlayerHeadCell:SetRedPoint(v:CanBeUpgraded())
		table.insert(self.survivalPlayerHeadCells, flightPlayerHeadCell)
	end

	self:ShowSelect()
end

function SurvivalChallengeUpgradeUI:ShowSelect()
	for i, v in pairs(self.survivalPlayerAttrCells) do
		self.survivalPlayerAttrPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.haveMaterials = false
	self.survivalPlayerAttrCells = {}

	if self.selectPlayerData then
		local path = self.upgradeStarPrefabPath[self.selectPlayerData.cid]

		AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil, {
			type = "loadStarPrefab",
			cid = self.selectPlayerData.cid
		})
		UGUIUtil.SetText(self.TextPlayerName, self.selectPlayerData:GetConfigData().Name)
		UGUIUtil.SetText(self.TextSkill, self.selectPlayerData:GetConfigData().Skill)
		UGUIUtil.SetText(self.TextLv, self.selectPlayerData.grade)

		local nextLv = self.selectPlayerData.grade + 1

		if nextLv > self.selectPlayerData.maxLv then
			nextLv = self.selectPlayerData.maxLv
		end

		UGUIUtil.SetText(self.TextNextLv, nextLv)
		UGUIUtil.SetText(self.TextMaxLv, self.selectPlayerData.maxLv)

		local isMaxLv = self.selectPlayerData.grade >= self.selectPlayerData.maxLv

		self.PanelMsg:SetActive(not isMaxLv)
		self.PanelMaxLv:SetActive(isMaxLv)

		local cfgLevelData = self.selectPlayerData:GetConfigLevelData(self.selectPlayerData.grade)
		local nextLevelData = self.selectPlayerData:GetConfigLevelData(nextLv)

		for i = 1, #cfgLevelData.AttType do
			local attID = cfgLevelData.AttType[i]

			if CfgSurvivalChallengeAttributeTable[attID].IsShow then
				local attNum = cfgLevelData.AttValue[i]
				local nextLvAttNum = nextLevelData.AttValue[i]
				local playerAttrCell = self.survivalPlayerAttrPool:Obtain()

				playerAttrCell.View:SetActive(true)
				playerAttrCell.View.transform:SetParent(self.PlayerAttrNode.transform, false)
				playerAttrCell:SetData(attID, attNum, isMaxLv, nextLvAttNum)
				table.insert(self.survivalPlayerAttrCells, playerAttrCell)
			end
		end

		for j = 1, #cfgLevelData.DepleteNum, 2 do
			local itemID = cfgLevelData.DepleteNum[j]
			local needNum = cfgLevelData.DepleteNum[j + 1]
			local num = WarehouseModule.GetItemNumByCfgID(itemID)

			if needNum <= num then
				self.haveMaterials = true
			end

			UGUIUtil.SetText(self.TextBtnSpendUnlock, SurvivalChallengeUpgradeUIApi:GetString("UpgradeSpend", needNum))
			UGUIUtil.SetText(self.TextBtnSpendLock, SurvivalChallengeUpgradeUIApi:GetString("UpgradeSpend", needNum))
		end

		self:ShowElement(self.selectPlayerData:GetConfigData().PlayerSpine)

		local path = UIGlobalApi.GetImagePath(self.selectPlayerData:GetConfigData().PlayerImage)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))

		local canUpdate = self.selectPlayerData:CanBeUpgraded()

		self.BtnUnLock:SetActive(canUpdate)
		self.BtnLock:SetActive(not canUpdate)

		local cfgData = self.selectPlayerData:GetCfgSpecialData()

		self.LockSkill:SetActive(cfgData == nil)
		self.UnLockSkill:SetActive(cfgData ~= nil)
		self.BtnUpGrade:SetActive(not isMaxLv)
	end
end

function SurvivalChallengeUpgradeUI:ShowElement(entityCid)
	self:HideEntity()

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.entityId, entityCid, 0, self.SpinePoint.transform, Vector3.zero)
end

function SurvivalChallengeUpgradeUI:HideEntity()
	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function SurvivalChallengeUpgradeUI:OnShowEntitySuccess(sender, args)
	if self.entityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(100, 100, 100)

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")

		local renderers = args.Entity:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			renderers[i].sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Default")
		end

		local canvas = self.UIController.gameObject:GetComponent("Canvas")

		args.Entity.gameObject:GetComponentInChildren(typeof(UnityEngine.Renderer)).sortingOrder = canvas.sortingOrder + 2

		local playerSkeletonAnimation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		playerSkeletonAnimation.state:SetAnimation(0, "idle", true)
	end
end

function SurvivalChallengeUpgradeUI:LoadStarPrefab(asset)
	if self.survivalStarView then
		if self.survivalStarView.playerData.cid == self.selectPlayerData.cid then
			self.survivalStarView:SetData(self.selectPlayerData)

			return
		else
			self.survivalStarView:Dispose()

			self.survivalStarView = nil
		end
	end

	local obj = UnityEngine.GameObject.Instantiate(asset)

	obj.transform:SetParent(self.StarNode.transform, false)

	self.survivalStarView = SurvivalChallengeStarView.New(obj)

	self.survivalStarView:SetData(self.selectPlayerData)
end

function SurvivalChallengeUpgradeUI:OnBtnUpGrade()
	if self.selectPlayerData == nil then
		return
	end

	if not SurvivalModule.IsShow() then
		return
	end

	if not self.haveMaterials then
		NoticeModule.ShowNotice(21040078)

		return
	end

	SurvivalModule.Level()
end

return SurvivalChallengeUpgradeUI
