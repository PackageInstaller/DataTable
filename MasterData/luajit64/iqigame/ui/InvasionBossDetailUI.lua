-- chunkname: @IQIGame\\UI\\InvasionBossDetailUI.lua

local InvasionBossDetailUI = {
	EntityId = 0,
	isShowTap = false,
	MonsterHeadCells = {}
}

InvasionBossDetailUI = Base:Extend("InvasionBossDetailUI", "IQIGame.Onigao.UI.InvasionBossDetailUI", InvasionBossDetailUI)

local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterHeadCell = require("IQIGame.UI.Common.MonsterHeadCell")

function InvasionBossDetailUI:OnInit()
	UGUIUtil.SetText(self.TextMonsterTitle, InvasionBossDetailUIApi:GetString("TextMonsterTitle"))
	UGUIUtil.SetText(self.TextChallengeBtn, InvasionBossDetailUIApi:GetString("TextChallengeBtn"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnChallenge()
		self:OnBtnChallenge()
	end

	function self.delegateUpdateOperations()
		self:UpdateOperations()
	end

	function self.delegateBtnTip()
		self:OnBtnTip()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.delegateBtnScore()
		self:OnBtnScore()
	end

	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)
	self.MonsterHeadCellPool = UIObjectPool.New(10, function()
		return MonsterHeadCell.__New(UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetMonsterHeadCellAssetPath())))
	end, function(cell)
		cell:Dispose()
	end)
end

function InvasionBossDetailUI:GetPreloadAssetPaths()
	local paths = {}

	table.insert(paths, UIGlobalApi.GetMonsterHeadCellAssetPath())

	return paths
end

function InvasionBossDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function InvasionBossDetailUI:IsManualShowOnOpen(userData)
	return false
end

function InvasionBossDetailUI:GetBGM(userData)
	return nil
end

function InvasionBossDetailUI:OnOpen(userData)
	self.operateEventID = userData[1]
	self.pos = userData[2]
	self.fightListCfgId = userData[3]
	self.cfgDoubleFightList = CfgDoubleFightListTable[self.fightListCfgId]
	self.lastElementEntityCid = nil

	self:UpdateView()
end

function InvasionBossDetailUI:OnClose(userData)
	return
end

function InvasionBossDetailUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnChallenge)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.delegateBtnTip)
	self.BtnScore:GetComponent("Button").onClick:AddListener(self.delegateBtnScore)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function InvasionBossDetailUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChallenge)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTip)
	self.BtnScore:GetComponent("Button").onClick:RemoveListener(self.delegateBtnScore)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function InvasionBossDetailUI:OnPause()
	return
end

function InvasionBossDetailUI:OnResume()
	return
end

function InvasionBossDetailUI:OnCover()
	return
end

function InvasionBossDetailUI:OnReveal()
	return
end

function InvasionBossDetailUI:OnRefocus(userData)
	return
end

function InvasionBossDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function InvasionBossDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function InvasionBossDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function InvasionBossDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function InvasionBossDetailUI:OnDestroy()
	self.FormationPanelController:Dispose()

	for i, v in pairs(self.MonsterHeadCells) do
		self.MonsterHeadCellPool:Release(v)
	end

	self.MonsterHeadCells = {}

	self.MonsterHeadCellPool:Dispose()
	self:HideEntity()
end

function InvasionBossDetailUI:UpdateOperations()
	if self.operateEventID then
		self:UpdateView()
	end
end

function InvasionBossDetailUI:UpdateView()
	UGUIUtil.SetText(self.TextBtnScore, InvasionBossDetailUIApi:GetString("TextBtnScore", 0, 0))

	local eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

	self.BtnScore:SetActive(false)

	self.doubleFightRecordPOD = nil

	if eventPOD then
		local cfgDoubleFightGlobalData = CfgDoubleFightGlobalTable[eventPOD.dataCfgId]

		UGUIUtil.SetText(self.TitleName, cfgDoubleFightGlobalData.Name)
		self:UpdateMonsterCells(self.cfgDoubleFightList.MonsterTeam[self.pos])
		self:ShowMonster(self.cfgDoubleFightList.MonsterSpine[self.pos])

		local selectDoubleFightStepPOD = ActiveDoubleFightModule.GetDoubleFightStepPOD(self.operateEventID, self.fightListCfgId)

		if selectDoubleFightStepPOD and selectDoubleFightStepPOD.records then
			for i, v in pairs(selectDoubleFightStepPOD.records) do
				if v.index == self.pos then
					self.doubleFightRecordPOD = v

					break
				end
			end

			if self.doubleFightRecordPOD then
				local currentScore = self.doubleFightRecordPOD.hurtScore + self.doubleFightRecordPOD.roundScore
				local maxScore = self.cfgDoubleFightList.RoundScore[self.pos][1] + self.cfgDoubleFightList.HPScore[self.pos][1]

				UGUIUtil.SetText(self.TextBtnScore, InvasionBossDetailUIApi:GetString("TextBtnScore", currentScore, maxScore))
				self.BtnScore:SetActive(currentScore > 0)
			end
		end
	end

	self.FormationPanelController:UpdateView()
end

function InvasionBossDetailUI:UpdateMonsterCells(MonsterTeam)
	for i, v in pairs(self.MonsterHeadCells) do
		v:Dispose()
	end

	self.MonsterHeadCells = {}

	local cfgMonsterTeam = CfgMonsterTeamTable[MonsterTeam]

	for i = 1, #cfgMonsterTeam.TeamUnit do
		local monsterID = cfgMonsterTeam.TeamUnit[i]
		local state = 0

		if monsterID > 0 and not CfgMonsterTable[monsterID].NotShowInUI then
			state = i < 6 and 1 or 2

			local monsterHeadCell = self.MonsterHeadCellPool:Obtain()

			monsterHeadCell.goView:SetActive(true)
			monsterHeadCell.goView.transform:SetParent(self.MonsterGrid.transform, false)
			monsterHeadCell:SetData(monsterID, state)

			function monsterHeadCell.clickHandler(monsterID)
				self:OnClickMonsterCell(monsterID)
			end

			table.insert(self.MonsterHeadCells, monsterHeadCell)
		end
	end
end

function InvasionBossDetailUI:OnClickMonsterCell(monsterID)
	UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
		monsterCid = monsterID
	})
end

function InvasionBossDetailUI:ShowSelect()
	self:OnUpdateFormation()
end

function InvasionBossDetailUI:OnUpdateFormation()
	self.FormationPanelController:SetFormationSoulLv(self.cfgDoubleFightList.LimitLv)

	local lastPos = self.pos == 1 and 2 or 1
	local lastDoubleFightRecordPOD
	local selectDoubleFightStepPOD = ActiveDoubleFightModule.GetDoubleFightStepPOD(self.operateEventID, self.fightListCfgId)

	if selectDoubleFightStepPOD and selectDoubleFightStepPOD.records then
		for i, v in pairs(selectDoubleFightStepPOD.records) do
			if v.index == lastPos then
				lastDoubleFightRecordPOD = v.formationInfoPOD

				break
			end
		end
	end

	self.isShowTap = self.FormationPanelController:SetFormationShowTag(lastDoubleFightRecordPOD, InvasionBossDetailUIApi:GetString("TagText"))

	self.TextPowerNum:SetActive(false)
	self.TextCurrentNum:SetActive(false)
	self.SortName:SetActive(false)
end

function InvasionBossDetailUI:ShowMonster(elementEntityCid)
	if self.lastElementEntityCid ~= elementEntityCid then
		self.lastElementEntityCid = elementEntityCid

		self:HideEntity()

		self.EntityId = GameEntry.Entity:GenerateEntityID()

		GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.Spine.transform, Vector3.zero)
	end
end

function InvasionBossDetailUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function InvasionBossDetailUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		local ShowUiSize = self.cfgDoubleFightList.ShowUiSize[self.pos]
		local ShowUiPosition = self.cfgDoubleFightList.ShowUiPosition[self.pos]

		args.Entity.gameObject.transform.localScale = Vector3(ShowUiSize, ShowUiSize, ShowUiSize)
		args.Entity.gameObject.transform.localPosition = Vector3(ShowUiPosition[1], ShowUiPosition[2], ShowUiPosition[3])

		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")
	end
end

function InvasionBossDetailUI:OnBtnTip()
	return
end

function InvasionBossDetailUI:OnBtnScore()
	UIModule.Open(Constant.UIControllerName.InvasionScoreTipsUI, Constant.UILayer.UI, {
		self.doubleFightRecordPOD,
		self.cfgDoubleFightList.Id,
		self.pos
	})
end

function InvasionBossDetailUI:OnBtnChallenge()
	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, MazeBossDetailUIApi:GetString("NoFormations"))

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

	local eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

	if eventPOD then
		local cfgDoubleFightGlobalData = CfgDoubleFightGlobalTable[eventPOD.dataCfgId]
		local step = table.indexOf(cfgDoubleFightGlobalData.FightList, self.fightListCfgId)

		if step > 0 then
			if self.isShowTap then
				NoticeModule.ShowNotice(21045034, function()
					ActiveDoubleFightModule.Fight(self.operateEventID, step, self.pos, self.formationID, self.fightListCfgId)
				end)
			else
				ActiveDoubleFightModule.Fight(self.operateEventID, step, self.pos, self.formationID, self.fightListCfgId)
			end
		end
	end
end

function InvasionBossDetailUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.InvasionBossDetailUI)
end

return InvasionBossDetailUI
