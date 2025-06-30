-- chunkname: @IQIGame\\UI\\Chapter\\StoryChapter\\StoryStageDetailUI.lua

local StoryStageDetailUI = {
	PassRewardScrollViewItems = {}
}
local StageDetailPanel = require("IQIGame.UI.Chapter.StageDetailPanel")

function StoryStageDetailUI.New(gameObject)
	local view = Clone(StoryStageDetailUI)

	view:OnInit(gameObject)

	return view
end

function StoryStageDetailUI:OnInit(gameObject)
	self.gameObject = gameObject

	LuaCodeInterface.BindOutlet(gameObject, self)

	self.StageDetailView = StageDetailPanel.New(self.StageDetailPanel)

	self:InitDelegation()
end

function StoryStageDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function StoryStageDetailUI:Show(stageID)
	self:OnAddListeners()

	self.stageID = stageID
	self.stageConfig = StoryChapterModule.GetStageByID(self.stageID)

	self:RefreshStageInfo()
	self.gameObject:SetActive(true)
end

function StoryStageDetailUI:Hide()
	self.gameObject:SetActive(false)
	self.StageDetailView:OnClose()
	self:OnRemoveListeners()
end

function StoryStageDetailUI:OnAddListeners()
	self.CloseButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateOnClickCloseButton)
	self.StartButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateOnClickStartButton)
	EventDispatcher.AddEventListener(EventID.StartStageLevel, self.delegateOnStartStageLevel)
	self.StageDetailButton:GetComponent("Button").onClick:AddListener(self.delegateOpenStageDetail)
end

function StoryStageDetailUI:OnRemoveListeners()
	self.CloseButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateOnClickCloseButton)
	self.StartButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateOnClickStartButton)
	EventDispatcher.RemoveEventListener(EventID.StartStageLevel, self.delegateOnStartStageLevel)
	self.StageDetailButton:GetComponent("Button").onClick:RemoveListener(self.delegateOpenStageDetail)
end

function StoryStageDetailUI:InitDelegation()
	function self.delegateOnClickCloseButton()
		self:Hide()
	end

	function self.delegateOnClickStartButton()
		self:OnClickStartButton()
	end

	function self.delegateOnStartStageLevel(plotStageDupPOD)
		self:OnStartStageLevel(plotStageDupPOD)
	end

	function self.delegateOpenStageDetail()
		self:OnOpenStageDetail()
	end
end

function StoryStageDetailUI:RefreshStageInfo()
	local stageConfig = StoryChapterModule.GetStageByID(self.stageID)

	UGUIUtil.SetText(self.StageNameText, stageConfig.Name)
	UGUIUtil.SetText(self.StageDescriptionText, stageConfig.Desc)
	LuaUtility.SetGameObjectShow(self.StageDetailButton, self.stageConfig.ShowStoryBattleID ~= 0)
	self.StartGamePanel:SetActive(true)

	local hasCost = #stageConfig.PassCost > 0

	if hasCost then
		self.CostText:SetActive(true)
		self.CostIconImage:SetActive(true)

		local stageCost = stageConfig.PassCost[2]
		local enterCost = stageConfig.EnterCost[2] or 0

		UGUIUtil.SetText(self.CostText, tostring(stageCost + enterCost))

		local itemID = stageConfig.PassCost[1]

		AssetUtil.LoadImage(self, string.format("%s%s", UIGlobalApi.IconPath, CfgItemTable[itemID].SmallIcon), self.CostIconImage:GetComponent(typeof(UnityEngine.UI.Image)))
	else
		self.CostText:SetActive(false)
		self.CostIconImage:SetActive(false)
	end

	self:ReloadPassRewardScrollView(StoryChapterModule.GetDropItems(self.stageID))
end

function StoryStageDetailUI:ReloadPassRewardScrollView(dropItems)
	self.CommonSlotUI:SetActive(false)
	self:ResetPassRewardScrollView()

	for _, dropItem in pairs(dropItems) do
		local dropLib = CfgDropLibTable[dropItem.dropID]

		for index, itemID in pairs(dropLib.GiftItemIds) do
			local gameObject = UnityEngine.Object.Instantiate(self.CommonSlotUI, self.PassRewardScrollViewContent.transform)

			gameObject:SetActive(true)
			self:AddPassRewardScrollViewItem(gameObject)

			local itemCell = ItemCell.New(gameObject, true, false)
			local itemData = ItemData.CreateByCIDAndNumber(itemID)

			itemCell:SetItem(itemData)
			itemCell:SetNum(dropLib.GiftItemCount[index])
			itemCell:SetTag(dropItem.tag)
		end
	end
end

function StoryStageDetailUI:ResetPassRewardScrollView()
	for i, gameObject in pairs(self.PassRewardScrollViewItems) do
		gameObject.transform:SetParent(nil)
		GameObject.Destroy(gameObject)
	end

	self.PassRewardScrollViewItems = {}
end

function StoryStageDetailUI:AddPassRewardScrollViewItem(gameObject)
	table.insert(self.PassRewardScrollViewItems, gameObject)
end

function StoryStageDetailUI:OnClickStartButton()
	if self.stageConfig.Battle == Constant.PlotSceneType.Talk then
		net_plotStage.enterLevel(self.stageConfig.Id)
	end
end

function StoryStageDetailUI:OnStartStageLevel(plotStageDupPOD)
	self:Hide()
end

function StoryStageDetailUI:OnOpenStageDetail()
	local storyBattleID = self.stageConfig.ShowStoryBattleID
	local monsterTeamID = CfgStoryBattleTable[storyBattleID].MonsterTeam

	self.StageDetailView:OnOpen(monsterTeamID)
end

return StoryStageDetailUI
