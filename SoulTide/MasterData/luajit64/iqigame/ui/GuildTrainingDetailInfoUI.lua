-- chunkname: @IQIGame\\UI\\GuildTrainingDetailInfoUI.lua

local GuildTrainingDetailInfoUI = {
	EntityId = 0,
	BossAffixPool = {},
	BossAffixCells = {},
	MonsterElementCells = {},
	MemberRenders = {}
}

GuildTrainingDetailInfoUI = Base:Extend("GuildTrainingDetailInfoUI", "IQIGame.Onigao.UI.GuildTrainingDetailInfoUI", GuildTrainingDetailInfoUI)

require("IQIGame.UIExternalApi.GuildTrainingDetailInfoUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local GuildTrainingRankData = require("IQIGame.Module.Guild.GuildTraining.GuildTrainingRankData")
local GuildTrainingBossAffixCell = require("IQIGame.UI.Guild.GuildTraining.GuildTrainingDetailInfo.GuildTrainingBossAffixCell")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local GuildTrainingMemberRender = require("IQIGame.UI.Guild.GuildTraining.GuildTrainingMemberContribution.GuildTrainingMemberRender")

function GuildTrainingDetailInfoUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnClickBtnHelp()
		self:OnClickBtnHelp()
	end

	function self.DelegateOnBtnTrainingRank()
		self:OnTrainingRank()
	end

	function self.DelegateOnBtnTrainingRankReward()
		self:OnTrainingRankReward()
	end

	function self.DelegateOnBtnMemberContribution()
		self:OnMemberContribution()
	end

	function self.DelegateOnMemberPointReward()
		self:OnMemberPointReward()
	end

	function self.DelegateBtnChallenge()
		self:OnBtnChallenge()
	end

	function self.DelegateBtnSkill()
		self:OnBtnSkill()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateUpdateTrainingRankEvent()
		self:OnUpdateTrainingRank()
	end

	function self.DelegateUpdateTrainingMemberEvent()
		self:OnUpdateTrainingMember()
	end

	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)

	self.RuneModule:SetActive(false)

	self.BossAffixPool = UIObjectPool.New(5, function()
		local cell = GuildTrainingBossAffixCell.New(UnityEngine.Object.Instantiate(self.RuneModule))

		return cell
	end, function(cell)
		cell:Dispose()
	end)

	self.Mould:SetActive(false)

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.Mould))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	self.MemberRank:SetActive(false)

	self.MemberRenderPool = UIObjectPool.New(3, function()
		local cell = GuildTrainingMemberRender.New(UnityEngine.Object.Instantiate(self.MemberRank))

		return cell
	end, function(cell)
		cell:Dispose()
	end)
	self.timer = Timer.New(function()
		self:ShowEndTime()
	end, 60, -1)
end

function GuildTrainingDetailInfoUI:GetPreloadAssetPaths()
	return nil
end

function GuildTrainingDetailInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildTrainingDetailInfoUI:IsManualShowOnOpen(userData)
	return false
end

function GuildTrainingDetailInfoUI:GetBGM(userData)
	return nil
end

function GuildTrainingDetailInfoUI:OnOpen(userData)
	GuildTrainingModule.GetGuildTrainingIntegral()
	GuildTrainingModule.GetRanking()

	self.areaID = userData.Area
	self.cfgGuildTrainingData = CfgGuildTrainingLayerTable[GuildTrainingModule.CenterGuildTrainingPOD.id]

	UGUIUtil.SetTextInChildren(self.BtnClose, CfgGuildAreaTable[self.areaID].Name)
	self:UpdateView()
	self.timer:Start()
end

function GuildTrainingDetailInfoUI:OnClose(userData)
	self.timer:Stop()
	self:HideEntity()
	EventDispatcher.Dispatch(EventID.GuildCameraChangePosEvent)
end

function GuildTrainingDetailInfoUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnHelp:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnHelp)
	self.BtnTrainingRank:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnTrainingRank)
	self.BtnTrainingRankReward:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnTrainingRankReward)
	self.BtnMemberContribution:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnMemberContribution)
	self.BtnMemberPointReward:GetComponent("Button").onClick:AddListener(self.DelegateOnMemberPointReward)
	self.BtnChallenge:GetComponent("Button").onClick:AddListener(self.DelegateBtnChallenge)
	self.BtnSkill:GetComponent("Button").onClick:AddListener(self.DelegateBtnSkill)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	EventDispatcher.AddEventListener(EventID.GuildUpdateTrainingRankEvent, self.DelegateUpdateTrainingRankEvent)
	EventDispatcher.AddEventListener(EventID.GuildUpdateTrainingMemberEvent, self.DelegateUpdateTrainingMemberEvent)
end

function GuildTrainingDetailInfoUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnHelp:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnHelp)
	self.BtnTrainingRank:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnTrainingRank)
	self.BtnTrainingRankReward:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnTrainingRankReward)
	self.BtnMemberContribution:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnMemberContribution)
	self.BtnMemberPointReward:GetComponent("Button").onClick:RemoveListener(self.DelegateOnMemberPointReward)
	self.BtnChallenge:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnChallenge)
	self.BtnSkill:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSkill)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateTrainingRankEvent, self.DelegateUpdateTrainingRankEvent)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateTrainingMemberEvent, self.DelegateUpdateTrainingMemberEvent)
end

function GuildTrainingDetailInfoUI:OnPause()
	return
end

function GuildTrainingDetailInfoUI:OnResume()
	return
end

function GuildTrainingDetailInfoUI:OnCover()
	return
end

function GuildTrainingDetailInfoUI:OnReveal()
	return
end

function GuildTrainingDetailInfoUI:OnRefocus(userData)
	return
end

function GuildTrainingDetailInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildTrainingDetailInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildTrainingDetailInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildTrainingDetailInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildTrainingDetailInfoUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.timer:Stop()

	self.timer = nil

	for i, v in pairs(self.BossAffixCells) do
		self.BossAffixPool:Release(v)
	end

	self.BossAffixCells = {}

	self.BossAffixPool:Dispose()

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()

	for i, v in pairs(self.MemberRenders) do
		self.MemberRenderPool:Release(v)
	end

	self.MemberRenders = {}

	self.MemberRenderPool:Dispose()
	self.FormationPanelController:Dispose()
end

function GuildTrainingDetailInfoUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function GuildTrainingDetailInfoUI:OnUpdateTrainingRank()
	self:ShowMyGuildRank()
end

function GuildTrainingDetailInfoUI:OnUpdateTrainingMember()
	self:UpdateView()
end

function GuildTrainingDetailInfoUI:UpdateView()
	if not GuildTrainingModule.IsOpen() then
		return
	end

	self.cfgGuildTrainingData = CfgGuildTrainingLayerTable[GuildTrainingModule.CenterGuildTrainingPOD.id]

	UGUIUtil.SetText(self.TextMonsterName, self.cfgGuildTrainingData.Name)
	self:ShowMyGuildRank()
	self:ShowTopThree()
	self:ShowEndTime()
	self.FormationPanelController:UpdateView()
	self:ShowMonster(self.cfgGuildTrainingData.ElementEntityID)

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	for i = 1, #self.cfgGuildTrainingData.WeakType do
		local weakType = self.cfgGuildTrainingData.WeakType[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.SortWeak.transform, false)
		cell:SetData(weakType)
		table.insert(self.MonsterElementCells, cell)
	end

	self:RefreshAffixBuff()
	self:RefreshRedPoint()
end

function GuildTrainingDetailInfoUI:RefreshRedPoint()
	local showRed = false

	if GuildTrainingModule.GuildTrainingPOD then
		showRed = GuildTrainingModule.GuildTrainingPOD.maxIntegral == 0
	end

	self.RedPoint:SetActive(showRed)
end

function GuildTrainingDetailInfoUI:ShowMyGuildRank()
	UGUIUtil.SetText(self.TextScore, GuildTrainingModule.myGuildScore)
	self.TextRank:SetActive(GuildTrainingModule.myGuildScore <= 0)
	self.MyGuildRank:SetActive(GuildTrainingModule.myGuildScore > 0)
	self.MyGuildRankText:SetActive(GuildTrainingModule.myGuildRankType == 1)

	if GuildTrainingModule.myGuildRanking > 0 then
		local myGuildRankData = GuildTrainingRankData.New(GuildModule.guildPOD.base.id, GuildTrainingModule.myGuildRanking, GuildTrainingModule.myGuildRankType, GuildModule.guildPOD.base.headIcon, GuildModule.guildPOD.base.avatarFrame, GuildModule.guildPOD.base.guildName, GuildTrainingModule.myGuildScore)
		local path = UIGlobalApi.GetImagePath(myGuildRankData.cfgRankRewardData.Image)

		AssetUtil.LoadImage(self, path, self.MyGuildRankIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.MyGuildRankText, myGuildRankData.rank)
	end
end

function GuildTrainingDetailInfoUI:ShowTopThree()
	local maxIntegral = GuildTrainingModule.GuildTrainingPOD.maxIntegral

	UGUIUtil.SetText(self.TextMyMaxScore, GuildTrainingDetailInfoUIApi:GetString("TextMyMaxScore", maxIntegral))

	local trainingPlayerRanks = GuildTrainingModule.centerGuildTrainingPlayerRanks or {}

	table.sort(trainingPlayerRanks, function(a, b)
		if a.score == b.score then
			return a.createTime < b.createTime
		end

		return a.score > b.score
	end)

	for i, v in pairs(self.MemberRenders) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MemberRenderPool:Release(v)
	end

	self.MemberRenders = {}

	for i = 1, #trainingPlayerRanks do
		if i <= 3 then
			local data = trainingPlayerRanks[i]
			local memberRender = self.MemberRenderPool:Obtain()

			memberRender.View.transform:SetParent(self.MemberNode.transform, false)
			memberRender.View:SetActive(true)
			memberRender:SetData(i, data)
			table.insert(self.MemberRenders, memberRender)
		end
	end
end

function GuildTrainingDetailInfoUI:ShowEndTime()
	if GuildTrainingModule.IsOpen() then
		local cfgDailyDupData = CfgDailyDupTable[GuildTrainingModule.DailyDupPOD.common.cid]
		local currentServerTime = PlayerModule.GetServerTime()
		local openDate = GuildTrainingModule.DailyDupPOD.common.openDate
		local accessEndTime = openDate + cfgDailyDupData.AccessibleTime
		local haveTime = accessEndTime - currentServerTime

		UGUIUtil.SetText(self.TextEndTime, GuildTrainingDetailInfoUIApi:GetString("TextEndTime", haveTime))
	end
end

function GuildTrainingDetailInfoUI:RefreshAffixBuff()
	for i, v in pairs(self.BossAffixCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.BossAffixPool:Release(v)
	end

	self.BossAffixCells = {}

	for i = 1, #self.cfgGuildTrainingData.ShowAffix do
		local id = self.cfgGuildTrainingData.ShowAffix[i]
		local cfgData = CfgSkillSpecialEffectExplainTable[id]
		local runeSuitItem = self.BossAffixPool:Obtain()

		runeSuitItem.View.transform:SetParent(self.RuneSort.transform, false)
		runeSuitItem.View:SetActive(true)
		runeSuitItem:SetData(cfgData)
		table.insert(self.BossAffixCells, runeSuitItem)
	end
end

function GuildTrainingDetailInfoUI:ShowMonster(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.MonsterPoint.transform, Vector3.zero)
end

function GuildTrainingDetailInfoUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function GuildTrainingDetailInfoUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		local SpineRenderers = args.Entity.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end

		if SpineRenderers ~= nil then
			local canvas = self.UIController:GetComponent("Canvas")

			for i = 0, SpineRenderers.Length - 1 do
				SpineRenderers[i].sortingOrder = canvas.sortingOrder + 1
			end
		end

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")
	end
end

function GuildTrainingDetailInfoUI:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower())
end

function GuildTrainingDetailInfoUI:ShowPower(power)
	UGUIUtil.SetText(self.TextPowerNum, GuildTrainingDetailInfoUIApi:GetString("TextPowerNum", power))
end

function GuildTrainingDetailInfoUI:OnClickBtnHelp()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, GuildTrainingDetailInfoUIApi:GetString("BtnTipDes"))
end

function GuildTrainingDetailInfoUI:OnTrainingRank()
	UIModule.Open(Constant.UIControllerName.GuildTrainingRankUI, Constant.UILayer.UI)
end

function GuildTrainingDetailInfoUI:OnTrainingRankReward()
	UIModule.Open(Constant.UIControllerName.GuildTrainingTotalPointRewardUI, Constant.UILayer.UI)
end

function GuildTrainingDetailInfoUI:OnMemberContribution()
	UIModule.Open(Constant.UIControllerName.GuildTrainingMemberContributionUI, Constant.UILayer.UI)
end

function GuildTrainingDetailInfoUI:OnMemberPointReward()
	UIModule.Open(Constant.UIControllerName.GuildTrainingPointRewardUI, Constant.UILayer.UI)
end

function GuildTrainingDetailInfoUI:OnBtnSkill()
	UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
		monsterCid = self.cfgGuildTrainingData.MonsterInfo[1],
		monsterCidList = self.cfgGuildTrainingData.MonsterInfo
	})
end

function GuildTrainingDetailInfoUI:OnBtnChallenge()
	if #PlayerModule.PlayerInfo.formations == 0 then
		return
	end

	local valid, formationPOD = self.FormationPanelController:CheckValidation()

	if not formationPOD then
		return
	end

	if not valid then
		return
	end

	self.formationID = formationPOD.id

	GuildTrainingModule.Attack(self.formationID, self.cfgGuildTrainingData.Id)
end

return GuildTrainingDetailInfoUI
