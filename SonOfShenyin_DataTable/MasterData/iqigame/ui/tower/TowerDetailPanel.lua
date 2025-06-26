-- chunkname: @IQIGame\\UI\\Tower\\TowerDetailPanel.lua

local TowerDetailPanel = {
	SelectedStage = 0,
	LevelIconButtonDict = {},
	DailyRewardScrollViewItems = {},
	PassRewardScrollViewItems = {},
	StageIconScrollViewItems = {}
}
local StageDetailPanel = require("IQIGame.UI.Chapter.StageDetailPanel")

function TowerDetailPanel.New(obj)
	local tbl = Clone(TowerDetailPanel)

	tbl:OnInit(obj)

	return tbl
end

function TowerDetailPanel:OnInit(obj)
	self.gameObject = obj

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.SmallSlotUI:SetActive(false)
	self.CommonSlotUI:SetActive(false)

	self.StageDetail = StageDetailPanel.New(self.StageDetailPanel)

	function self.delegateOpenTowerDetail(towerID)
		self.towerID = towerID

		self:OnOpen()
	end

	function self.delegateClose()
		self:OnClose()
	end

	function self.delegateOpenDailyRewardExplanation()
		self:OnOpenDailyRewardExplanation()
	end

	function self.delegateCloseDailyRewardExplanation()
		self:OnCloseDailyRewardExplanation()
	end

	function self.delegateOpenStageDetail()
		self:OnOpenStageDetail()
	end

	function self.delegateRefresh()
		self:Refresh()
	end

	function self.delegateOnStagePanelCentered(index, _)
		local level = index + 1

		logDebug("爬塔尝试Snap的层数:" .. level)

		local stageList = TowerChapterModule.GetStageListByTowerID(self.towerID)
		local stage = stageList[level]

		self.SelectedStage = stage

		self:RefreshStageInfo(stage)
		self:RefreshPassRewardPanel(stage)
	end

	function self.delegateClickEnterDupButton()
		local userData = {
			OpenType = 2,
			IsActiveReturnBtn = true,
			ChapterType = Constant.ChapterPassType.TYPE_CLIMB_TOWER,
			StageId = self.SelectedStage.Id
		}

		UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
	end

	function self.delegateClickReceiveDailyRewardButton()
		local level = self:GetRewardStage()

		TowerChapterModule.RpcDailyPrize(level.Id)
	end

	function self.delegateTowerDailyRewardReceived(dailyStatus, items)
		logDebug("delegateTowerDailyRewardReceived")
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
		TowerChapterModule.SetTowerDailyStatus(self.towerID, dailyStatus)
		self:RefreshDailyRewardPanel(self.towerID)
	end

	self:OnAddListeners()
end

function TowerDetailPanel:OnOpen()
	self.gameObject:SetActive(true)
	self.DailyRewardPanelObject:SetActive(true)

	local stage = TowerChapterModule.GetTowerLowestNotPassedStage(self.towerID)

	if getTableLength(stage) == 0 then
		stage = TowerChapterModule.GetTowerHighestStage(self.towerID)
	end

	self.SelectedStage = stage

	self:Refresh()
end

function TowerDetailPanel:OnClose(userData)
	self.gameObject:SetActive(false)
	self.DailyRewardPanelObject:SetActive(false)
	self:OnCloseDailyRewardExplanation()
	self.StageDetail:OnClose()

	if self.activityRemainingTimeTimer then
		self.activityRemainingTimeTimer:Stop()

		self.activityRemainingTimeTimer = nil
	end
end

function TowerDetailPanel:OnOpenDailyRewardExplanation()
	self.DailyRewardExplanationPanel:SetActive(true)
	UGUIUtil.SetText(self.DailyRewardExplanationTitleText, ClimbTowerApi:GetDailyRewardTitleTips())
	UGUIUtil.SetText(self.DailyRewardExplanationContentText, ClimbTowerApi:GetDailyRewardExplanationText())
end

function TowerDetailPanel:OnCloseDailyRewardExplanation()
	self.DailyRewardExplanationPanel:SetActive(false)
end

function TowerDetailPanel:OnAddListeners()
	self.CloseButton:GetComponent("Button").onClick:AddListener(self.delegateClose)
	self.ReceiveDailyRewardButton:GetComponent("Button").onClick:AddListener(self.delegateClickReceiveDailyRewardButton)
	self.EnterDupButton:GetComponent("Button").onClick:AddListener(self.delegateClickEnterDupButton)
	self.OpenDailyRewardExplanationButton:GetComponent("Button").onClick:AddListener(self.delegateOpenDailyRewardExplanation)
	self.CloseDailyRewardExplanationButton:GetComponent("Button").onClick:AddListener(self.delegateCloseDailyRewardExplanation)
	self.StageDetailButton:GetComponent("Button").onClick:AddListener(self.delegateOpenStageDetail)
	EventDispatcher.AddEventListener(EventID.OpenTowerDetailEvent, self.delegateOpenTowerDetail)
	EventDispatcher.AddEventListener(EventID.TowerDailyRewardReceived, self.delegateTowerDailyRewardReceived)
	EventDispatcher.AddEventListener(EventID.RefreshTowerCfg, self.delegateRefresh)
end

function TowerDetailPanel:OnRemoveListeners()
	self.CloseButton:GetComponent("Button").onClick:RemoveListener(self.delegateClose)
	self.ReceiveDailyRewardButton:GetComponent("Button").onClick:RemoveListener(self.delegateClickReceiveDailyRewardButton)
	self.EnterDupButton:GetComponent("Button").onClick:RemoveListener(self.delegateClickEnterDupButton)
	self.OpenDailyRewardExplanationButton:GetComponent("Button").onClick:RemoveListener(self.delegateOpenDailyRewardExplanation)
	self.CloseDailyRewardExplanationButton:GetComponent("Button").onClick:RemoveListener(self.delegateCloseDailyRewardExplanation)
	self.StageDetailButton:GetComponent("Button").onClick:RemoveListener(self.delegateOpenStageDetail)
	EventDispatcher.RemoveEventListener(EventID.OpenTowerDetailEvent, self.delegateOpenTowerDetail)
	EventDispatcher.RemoveEventListener(EventID.TowerDailyRewardReceived, self.delegateTowerDailyRewardReceived)
	EventDispatcher.RemoveEventListener(EventID.RefreshTowerCfg, self.delegateRefresh)
end

function TowerDetailPanel:Refresh()
	local stage = self.SelectedStage

	self:RefreshStageInfo(stage)
	self:RefreshPassRewardPanel(stage)
	self:ReloadStageScrollView(self.towerID, stage.Level)
	self:RefreshDailyRewardPanel(self.towerID)
end

function TowerDetailPanel:GetRewardStage()
	return self.dailyRewardStage
end

function TowerDetailPanel:SetDailyRewardStage(stage)
	self.dailyRewardStage = stage
end

function TowerDetailPanel:RefreshDailyRewardPanel(towerID)
	local hasDailyRewardToReceive, dailyRewardToReceive = TowerChapterModule.HasDailyRewardToReceive(towerID)
	local rewardStage

	if hasDailyRewardToReceive then
		rewardStage = dailyRewardToReceive
	else
		rewardStage = TowerChapterModule.GetTowerHighestPassedLevel(towerID)
	end

	self:SetDailyRewardStage(rewardStage)
	UGUIUtil.SetText(self.DailyRewardTitleTipsText, ClimbTowerApi:GetDailyRewardTitleTips())

	local rewardIDs = rewardStage.DailyReward or {}

	self:ReloadDailyRewardScrollView(rewardIDs)
	self:RefreshDailyRewardReceivePanel(hasDailyRewardToReceive)
end

function TowerDetailPanel:RefreshDailyRewardReceivePanel(hasDailyRewardToReceive)
	if hasDailyRewardToReceive then
		self.NextDailyRewardTimeText:SetActive(false)
		self.ReceiveDailyRewardButton:SetActive(true)
	else
		self:RefreshNextDailyRewardTime(self.NextDailyRewardTimeText)

		if self.activityRemainingTimeTimer then
			self.activityRemainingTimeTimer:Stop()

			self.activityRemainingTimeTimer = nil
		end

		self.activityRemainingTimeTimer = Timer.New(function()
			self:RefreshNextDailyRewardTime(self.NextDailyRewardTimeText)
		end, 1, -1)

		self.activityRemainingTimeTimer:Start()
		self.NextDailyRewardTimeText:SetActive(true)
		self.ReceiveDailyRewardButton:SetActive(false)
	end
end

function TowerDetailPanel:RefreshNextDailyRewardTime(textObj)
	local now = PlayerModule.GetServerTime()
	local ts = dateTimeToTimeStamp({
		month = 1,
		year = 1971,
		day = 1,
		hour = CfgDiscreteDataTable[69].Data[1]
	}, PlayerModule.TimeZone)
	local leftSecondTime = 86400 - (now - ts) % 86400

	if leftSecondTime < 0 then
		leftSecondTime = 0
	end

	UGUIUtil.SetText(textObj, DateTimeFormat(leftSecondTime, "hh:mm:ss后刷新"))
end

function TowerDetailPanel:ReloadStageScrollView(towerID, startStageLevel)
	self:ResetStageIconScrollView()

	local stageList = TowerChapterModule.GetStageListByTowerID(towerID)

	self.LevelIconButton:SetActive(false)

	for _, stage in pairs(stageList) do
		local gameObject = UnityEngine.Object.Instantiate(self.LevelIconButton, self.LevelList.transform)
		local t = {
			gameObject = gameObject,
			stage = stage
		}

		LuaCodeInterface.BindOutlet(gameObject, t)
		self:SetStageStatusIcon(t, stage)
		gameObject:SetActive(true)
		self:AddStageIconScrollViewItem(gameObject)
	end

	local SimpleScrollSnap = self.LevelScrollView:GetComponent(typeof(DanielLochner.Assets.SimpleScrollSnap.SimpleScrollSnap))

	SimpleScrollSnap.StartingPanel = startStageLevel - 1

	SimpleScrollSnap.OnPanelCentered:AddListener(self.delegateOnStagePanelCentered)
	SimpleScrollSnap:Reload()
end

function TowerDetailPanel:SetStageStatusIcon(t, stage)
	local IsStagePassed = TowerChapterModule.IsStagePassed(stage.Id)

	if IsStagePassed then
		t.PassedPanel:SetActive(true)
		UGUIUtil.SetText(t.PassedLevelText, ClimbTowerApi:FormatStageLevel(stage.Level))
	elseif ConditionModule.Check(stage.UnlockConditionId) then
		t.SelectedPanel:SetActive(true)
		UGUIUtil.SetText(t.SelectedLevelText, ClimbTowerApi:FormatStageLevel(stage.Level))
	else
		t.LockedPanel:SetActive(true)
		UGUIUtil.SetText(t.LockedLevelText, ClimbTowerApi:FormatStageLevel(stage.Level))
	end
end

function TowerDetailPanel:RefreshStageInfo(stage)
	local tower = CfgTowerChapterTable[self.towerID]

	UGUIUtil.SetText(self.TitleText, ClimbTowerApi:GetStageTitleTips(tower.Name, stage.Level))
	UGUIUtil.SetText(self.StageDetailTipsText, ClimbTowerApi:GetStageDetailTips())
	UGUIUtil.SetText(self.InfoTipsText, ClimbTowerApi:GetStageInfoTips())
	UGUIUtil.SetText(self.DescriptionText, stage.Desc)
	UGUIUtil.SetText(self.DungeonBuffTipsText, ClimbTowerApi:GetDungeonBuffTips())
	UGUIUtil.SetText(self.DungeonBuffText, ClimbTowerApi:GenerateDungeonBuffDesc(stage.DungeonBuff))
end

function TowerDetailPanel:ResetStageIconScrollView()
	for _, gameObject in pairs(self.StageIconScrollViewItems) do
		gameObject.transform:SetParent(nil)
		GameObject.Destroy(gameObject)
	end

	self.StageIconScrollViewItems = {}
end

function TowerDetailPanel:AddStageIconScrollViewItem(gameObject)
	table.insert(self.StageIconScrollViewItems, gameObject)
end

function TowerDetailPanel:RefreshPassRewardPanel(stage)
	local rewardIDs = CfgTowerStageTable[stage.Id].PassReward or {}

	self:ReloadPassRewardScrollView(rewardIDs)

	local isPassed = TowerChapterModule.IsStagePassed(stage.Id)
	local isUnlocked = ConditionModule.Check(stage.UnlockConditionId)

	LuaUtility.SetGameObjectShow(self.PassedMaskPanel, isPassed)
	UGUIUtil.SetText(self.PassedMaskTipsText, ClimbTowerApi:GetLevelPassedTips())
	LuaUtility.SetGameObjectShow(self.EnterDupButton, not isPassed and isUnlocked)
	LuaUtility.SetGameObjectShow(self.LockedStageText, not isPassed and not isUnlocked)
end

function TowerDetailPanel:ReloadDailyRewardScrollView(rewardIDs)
	self:ResetDailyRewardScrollView()

	for _, rewardID in pairs(rewardIDs) do
		local drop = CfgDropLibTable[rewardID]

		for index, itemID in pairs(drop.GiftItemIds) do
			local gameObject = UnityEngine.Object.Instantiate(self.SmallSlotUI, self.DailyRewardContent.transform)

			gameObject:SetActive(true)
			self:AddDailyRewardScrollViewItem(gameObject)

			local itemCell = ItemCell.New(gameObject, true, false)
			local itemData = ItemData.CreateByCIDAndNumber(itemID)

			itemCell:SetItem(itemData)
			itemCell:SetNum(drop.GiftItemCount[index])
			itemCell.View.ItemParent:SetActive(true)
			itemCell.View.Image_SmallIconbg:SetActive(false)
		end
	end
end

function TowerDetailPanel:ResetDailyRewardScrollView()
	for i, gameObject in pairs(self.DailyRewardScrollViewItems) do
		gameObject.transform:SetParent(nil)
		GameObject.Destroy(gameObject)
	end

	self.DailyRewardScrollViewItems = {}
end

function TowerDetailPanel:AddDailyRewardScrollViewItem(gameObject)
	table.insert(self.DailyRewardScrollViewItems, gameObject)
end

function TowerDetailPanel:ReloadPassRewardScrollView(rewardIDs)
	self:ResetPassRewardScrollView()

	for _, rewardID in pairs(rewardIDs) do
		local drop = CfgDropLibTable[rewardID]

		for index, itemID in pairs(drop.GiftItemIds) do
			local gameObject = UnityEngine.Object.Instantiate(self.CommonSlotUI, self.PassRewardScrollViewContent.transform)

			gameObject:SetActive(true)
			self:AddPassRewardScrollViewItem(gameObject)

			local itemCell = ItemCell.New(gameObject, true, true)
			local itemData = ItemData.CreateByCIDAndNumber(itemID)

			itemCell:SetItem(itemData)
			itemCell:SetNum(drop.GiftItemCount[index])
		end
	end
end

function TowerDetailPanel:ResetPassRewardScrollView()
	for i, gameObject in pairs(self.PassRewardScrollViewItems) do
		gameObject.transform:SetParent(nil)
		GameObject.Destroy(gameObject)
	end

	self.PassRewardScrollViewItems = {}
end

function TowerDetailPanel:AddPassRewardScrollViewItem(gameObject)
	table.insert(self.PassRewardScrollViewItems, gameObject)
end

function TowerDetailPanel:OnOpenStageDetail()
	local monsterTeamID = CfgTowerStageTable[self.SelectedStage.Id].MonsterTeam

	self.StageDetail:OnOpen(monsterTeamID)
end

function TowerDetailPanel:OnDestroy()
	self:OnRemoveListeners()
	self.StageDetail:OnDestroy()

	if self.activityRemainingTimeTimer then
		self.activityRemainingTimeTimer:Stop()

		self.activityRemainingTimeTimer = nil
	end

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return TowerDetailPanel
