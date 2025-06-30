-- chunkname: @IQIGame\\UI\\SurvivalFlyGameSettlementUI.lua

local SurvivalFlyGameSettlementUI = {
	isBtnCD = false,
	monsterNum = 0,
	openType = 1,
	entityId = 0,
	bossNum = 0,
	levelCid = 0,
	survivalPlayerAttrCells = {}
}

SurvivalFlyGameSettlementUI = Base:Extend("SurvivalFlyGameSettlementUI", "IQIGame.Onigao.UI.SurvivalFlyGameSettlementUI", SurvivalFlyGameSettlementUI)

require("IQIGame.UIExternalApi.SurvivalFlyGameSettlementUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local SurvivalFlyGameSettlementPanelView = require("IQIGame.UI.ExploreHall.Survival.SurvivalFlyGameSettlement.SurvivalFlyGameSettlementPanelView")
local SurvivalFlyGameSettlementEndlessView = require("IQIGame.UI.ExploreHall.Survival.SurvivalFlyGameSettlement.SurvivalFlyGameSettlementEndlessView")
local SurvivalPlayerAttrCell = require("IQIGame.UI.ExploreHall.Survival.SurvivalChallengeFormation.SurvivalPlayerAttrCell")

function SurvivalFlyGameSettlementUI:OnInit()
	function self.DelegateOnClickBtnCancel()
		self:OnClickBtnCancel()
	end

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnClickBtnAgainChallenge()
		self:OnBtnAgainChallenge()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self.survivalFlyGameEndPanelView = SurvivalFlyGameSettlementPanelView.New(self.PanelLevel)
	self.survivalFlyGameEndlessView = SurvivalFlyGameSettlementEndlessView.New(self.PanelEndless)

	self.AttrModule:SetActive(false)

	self.survivalPlayerAttrPool = UIObjectPool.New(5, function()
		return SurvivalPlayerAttrCell.New(UnityEngine.Object.Instantiate(self.AttrModule))
	end, function(cell)
		cell:Dispose()
	end)
end

function SurvivalFlyGameSettlementUI:GetPreloadAssetPaths()
	return nil
end

function SurvivalFlyGameSettlementUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SurvivalFlyGameSettlementUI:IsManualShowOnOpen(userData)
	return false
end

function SurvivalFlyGameSettlementUI:GetBGM(userData)
	return nil
end

function SurvivalFlyGameSettlementUI:OnOpen(userData)
	self.openType = userData.OpenType
	self.rewards = userData.Reward
	self.playerCid = userData.PlayerCid
	self.monsterNum = userData.MonsterNum
	self.bossNum = userData.BossNum
	self.levelCid = userData.LevelCid
	self.isBtnCD = false

	self:UpdateView()
end

function SurvivalFlyGameSettlementUI:OnClose(userData)
	self:HideEntity()
end

function SurvivalFlyGameSettlementUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnAgainChallenge:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnAgainChallenge)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function SurvivalFlyGameSettlementUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnAgainChallenge:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnAgainChallenge)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function SurvivalFlyGameSettlementUI:OnPause()
	return
end

function SurvivalFlyGameSettlementUI:OnResume()
	return
end

function SurvivalFlyGameSettlementUI:OnCover()
	return
end

function SurvivalFlyGameSettlementUI:OnReveal()
	return
end

function SurvivalFlyGameSettlementUI:OnRefocus(userData)
	return
end

function SurvivalFlyGameSettlementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SurvivalFlyGameSettlementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SurvivalFlyGameSettlementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SurvivalFlyGameSettlementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SurvivalFlyGameSettlementUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.survivalFlyGameEndPanelView:Dispose()
	self.survivalFlyGameEndlessView:Dispose()

	for i, v in pairs(self.survivalPlayerAttrCells) do
		self.survivalPlayerAttrPool:Release(v)
	end

	self.survivalPlayerAttrCells = {}

	self.survivalPlayerAttrPool:Dispose()
end

function SurvivalFlyGameSettlementUI:UpdateView()
	local survivalPlayerData = SurvivalModule.survivalPlayer[self.playerCid]

	UGUIUtil.SetText(self.TextName, survivalPlayerData:GetConfigData().Name)
	UGUIUtil.SetText(self.TextLv, survivalPlayerData.grade)

	local cfgData = survivalPlayerData:GetCfgSpecialData()

	self.SkillLock:SetActive(cfgData == nil)
	self.SkillUnlock:SetActive(cfgData ~= nil)

	if cfgData then
		UGUIUtil.SetText(self.SkillDes, cfgData.Skill)
	end

	if survivalPlayerData then
		self:ShowPlayer(survivalPlayerData:GetConfigData().PlayerSpine)

		for i, v in pairs(self.survivalPlayerAttrCells) do
			v.View:SetActive(false)
			v.View.transform:SetParent(self.UIController.transform, false)
			self.survivalPlayerAttrPool:Release(v)
		end

		self.survivalPlayerAttrCells = {}

		local cfgLevelData = survivalPlayerData:GetConfigLevelData(survivalPlayerData.grade)

		if cfgLevelData then
			for i = 1, #cfgLevelData.AttType do
				local attrID = cfgLevelData.AttType[i]
				local attrValue = cfgLevelData.AttValue[i]

				if CfgSurvivalChallengeAttributeTable[attrID].IsShow then
					local playerAttrCell = self.survivalPlayerAttrPool:Obtain()

					playerAttrCell.View:SetActive(true)
					playerAttrCell.View.transform:SetParent(self.AttrNode.transform, false)
					playerAttrCell:SetData(attrID, attrValue, false)
					table.insert(self.survivalPlayerAttrCells, playerAttrCell)
				end
			end
		end
	end

	self.PanelLevel:SetActive(false)
	self.PanelEndless:SetActive(false)

	local costTab = {}
	local needItemCid, needItemNum

	if self.openType == FlyGameConstant.ChallengeType.Challenge_Level_Mode then
		self.PanelLevel:SetActive(true)
		self.survivalFlyGameEndPanelView:SetData(self.levelCid, self.monsterNum, self.bossNum)

		costTab = CfgSurvivalChallengeLevelTable[self.levelCid].Cost
	elseif self.openType == FlyGameConstant.ChallengeType.Challenge_Endless_Mode then
		self.PanelEndless:SetActive(true)
		self.survivalFlyGameEndlessView:SetData(self.rewards, self.bossNum)

		costTab = SurvivalModule.GetFlightGameCost()
	end

	if #costTab > 0 then
		needItemCid = costTab[1]
		needItemNum = costTab[2]
	end

	if needItemCid then
		local iconPath = UIGlobalApi.GetIconPath(CfgItemTable[needItemCid].Icon)

		AssetUtil.LoadImage(self, iconPath, self.SpendIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.SpendNum, SurvivalFlyGameSettlementUIApi:GetString("SpendValue", needItemNum))
	end
end

function SurvivalFlyGameSettlementUI:ShowPlayer(elementEntityCid)
	self:HideEntity()

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.entityId, elementEntityCid, 0, self.Spine.transform, Vector3.zero)
end

function SurvivalFlyGameSettlementUI:HideEntity()
	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function SurvivalFlyGameSettlementUI:OnShowElementEntitySuccess(sender, args)
	if self.entityId == args.Entity.Id then
		local renderers = args.Entity:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			renderers[i].sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Default")
			renderers[i].sortingOrder = self.UIController:GetComponent("Canvas").sortingOrder + 1
		end

		local playerSkeletonAnimation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		playerSkeletonAnimation.state:SetAnimation(0, "idle", true)
	end
end

function SurvivalFlyGameSettlementUI:OnClickBtnCancel()
	self:QuitGame()
end

function SurvivalFlyGameSettlementUI:OnClickBtnClose()
	self:QuitGame()
end

function SurvivalFlyGameSettlementUI:OnBtnAgainChallenge()
	if self.isBtnCD then
		return
	end

	self.isBtnCD = true

	FlyGameModule.DisposeSurvivalFlyGameScene()

	local time = Timer.New(function()
		if self.openType == FlyGameConstant.ChallengeType.Challenge_Level_Mode then
			SurvivalModule.StartChallenge(self.playerCid, self.levelCid)
		elseif self.openType == FlyGameConstant.ChallengeType.Challenge_Endless_Mode then
			SurvivalModule.StartChallengeUnlimited(self.playerCid)
		end

		self.isBtnCD = false
	end, 0.5)

	time:Start()
end

function SurvivalFlyGameSettlementUI:QuitGame()
	UIModule.CloseSelf(self)
	FlyGameModule.ExitFlightGame()
end

return SurvivalFlyGameSettlementUI
