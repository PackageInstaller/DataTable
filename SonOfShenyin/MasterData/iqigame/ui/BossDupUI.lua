-- chunkname: @IQIGame\\UI\\BossDupUI.lua

local BossDupUI = {
	curNewUnlockPass = 1,
	toggleItems = {}
}

BossDupUI = Base:Extend("BossDupUI", "IQIGame.Onigao.UI.BossDupUI", BossDupUI)

local bossDiffToggleItem = require("IQIGame.UI.Chapter.BossChapter.BossDiffToggleItem")
local bossRewardItem = require("IQIGame.UI.Chapter.BossChapter.BossRewardItem")
local monsterDetailsView = require("IQIGame.UI.Chapter.BossChapter.MonsterDetailsView")
local StageDetailPanel = require("IQIGame.UI.Chapter.StageDetailPanel")

function BossDupUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitBaseInfo()
end

function BossDupUI:GetPreloadAssetPaths()
	return nil
end

function BossDupUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BossDupUI:IsManualShowOnOpen(userData)
	return false
end

function BossDupUI:GetBGM(userData)
	return nil
end

function BossDupUI:OnOpen(chapterData)
	self:InitChapterInfo(chapterData)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.GameLevelUI)
end

function BossDupUI:OnClose(userData)
	self.StageDetail:OnClose()
end

function BossDupUI:OnPause()
	return
end

function BossDupUI:OnResume()
	return
end

function BossDupUI:OnCover()
	return
end

function BossDupUI:OnReveal()
	return
end

function BossDupUI:OnRefocus(userData)
	return
end

function BossDupUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BossDupUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BossDupUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BossDupUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BossDupUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	self.StageDetail:OnDestroy()

	for k, v in pairs(self.itemList) do
		v:Dispose()
	end

	for k, v in pairs(self.toggleItems) do
		v:Dispose()
	end

	self.MonsterDetailsView:Dispose()
	self.moneyCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
end

function BossDupUI:OnAddListeners()
	self.StartBtn:GetComponent("Button").onClick:AddListener(self.delegateEnterBtn)
	self.DareBtn:GetComponent("Button").onClick:AddListener(self.delegateOpenChallengeRuleBtn)
	self.ChallengeCloseBtn:GetComponent("Button").onClick:AddListener(self.delegateCloseChallengeRuleBtn)
	self.StageDetailParent:GetComponent("Button").onClick:AddListener(self.delegateOpenStageDetailBtn)
end

function BossDupUI:OnRemoveListeners()
	self.StartBtn:GetComponent("Button").onClick:RemoveListener(self.delegateEnterBtn)
	self.DareBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOpenChallengeRuleBtn)
	self.ChallengeCloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateCloseChallengeRuleBtn)
	self.StageDetailParent:GetComponent("Button").onClick:RemoveListener(self.delegateOpenStageDetailBtn)
end

function BossDupUI:InitBaseInfo()
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.diffScrollView = self.DiffScrollView:GetComponent("ScrollAreaList")

	function self.diffScrollView.onRenderCell(cell)
		self:OnRenderDiffItem(cell)
	end

	function self.diffScrollView.onSelectedCell(cell)
		self:OnSelectCell(cell)
	end

	self.rewardScrollView = self.RewardScrollView:GetComponent("ScrollAreaList")

	function self.rewardScrollView.onRenderCell(cell)
		self:OnRenderRewardItem(cell)
	end

	function self.delegateEnterBtn()
		self:OnEnterBtnClick()
	end

	function self.delegateOpenChallengeRuleBtn()
		self:OnChallengeRuleBtn()
	end

	function self.delegateCloseChallengeRuleBtn()
		self:OnCloseChallengeRuleBtn()
	end

	self.StageDetail = StageDetailPanel.New(self.StageDetailPanel)

	function self.delegateOpenStageDetailBtn()
		local monsterTeamID = self.stageData:GetCfg().MonsterTeam

		self.StageDetail:OnOpen(monsterTeamID)
	end

	UGUIUtil.SetText(self.ConsumTitle, ChapterUIApi:GetConsumTitle())
	UGUIUtil.SetText(self.RuleTitle, ChapterUIApi:GetRuleTitle())
	UGUIUtil.SetTextInChildren(self.MonsterDetailsBtn, ChapterUIApi:GetMonsterDetailsBtn())

	self.MonsterDetailsView = monsterDetailsView.New(self.MonsterDetailsPanel)
	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)
end

function BossDupUI:InitChapterInfo(chapterData)
	self.chapterData = chapterData
	self.curChapterIsPass = BossChapterModule.GetChapterIsPass(self.chapterData.cid)

	local strs = string.split(self.chapterData:GetCfg().Name, "|")

	UGUIUtil.SetText(self.ChapterName, strs[1])
	UGUIUtil.SetText(self.BossName, strs[2])
	LuaUtility.SetGameObjectShow(self.LastRewardParent, self.chapterData:GetCfg().RewardTimes ~= -1)
	UGUIUtil.SetText(self.LastRewardText, ChapterUIApi:GetLastRewardText(self.chapterData:GetCfg().RewardTimes - self.chapterData.prizeTime, self.chapterData:GetCfg().RewardTimes))

	local path = UIGlobalApi.GetImagePath(self.chapterData:GetCfg().BackPicture)

	self:OnLoadImg(path, self.BossImg)

	self.stageList = {}
	self.itemList = {}

	local list = self.chapterData.passStatus

	for k, v in pairs(list) do
		table.insert(self.stageList, v)
	end

	table.sort(self.stageList, function(a, b)
		return a.cid < b.cid
	end)

	self.curNewUnlockPass = BossChapterModule.GetNewUnLockPass(self.chapterData.cid)

	self.diffScrollView:Refresh(#self.stageList)
	self:OnCloseChallengeRuleBtn()
end

function BossDupUI:OnRenderDiffItem(cell)
	local data = self.stageList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local toggleObj = self.toggleItems[instanceID]

	if toggleObj == nil then
		toggleObj = bossDiffToggleItem.New(cell.gameObject, function(stageData)
			self:RefreshStageInfo(stageData)
		end)
		self.toggleItems[instanceID] = toggleObj
	end

	toggleObj:SetData(data, cell.index + 1)

	if cell.index + 1 == self.curNewUnlockPass then
		self:OnSelectCell(cell)
	end
end

function BossDupUI:OnSelectCell(cell)
	if self.stageList[cell.index + 1].isUnLock == false then
		NoticeModule.ShowNotice(49005)

		return
	end

	local instanceID = cell.gameObject:GetInstanceID()
	local Cell = self.toggleItems[instanceID]

	self:UnselectedHeadCells()
	Cell:OnClickCell()

	self.selectIndex = cell.index + 1
end

function BossDupUI:UnselectedHeadCells()
	for i, v in pairs(self.toggleItems) do
		v:OnUnselected()
	end
end

function BossDupUI:RefreshStageInfo(stageData)
	self.stageData = stageData

	UGUIUtil.SetText(self.DescText, self.stageData:GetCfg().Desc)
	self:GetShowReward()
	self:RefreshEnterConsumItem()
end

function BossDupUI:GetShowReward()
	self.rewardItems = {}

	for k = 1, #self.stageData:GetCfg().PassReward do
		for i, j in pairs(CfgDropLibTable[self.stageData:GetCfg().PassReward[k]].DropShowItem) do
			table.insert(self.rewardItems, j)
		end
	end

	self.rewardScrollView:Refresh(#self.rewardItems)
end

function BossDupUI:RefreshEnterConsumItem()
	local cfgData = self.stageData:GetCfg()
	local needItemCid = 0
	local consumNum, enterConsum, passConsum = 0, 0, 0

	if cfgData.EnterCost ~= nil and #cfgData.EnterCost ~= 0 then
		enterConsum = cfgData.EnterCost[2]
		needItemCid = cfgData.EnterCost[1]
	end

	if cfgData.PassCost ~= nil and #cfgData.PassCost ~= 0 then
		passConsum = cfgData.PassCost[2]
		needItemCid = cfgData.PassCost[1]
	end

	consumNum = enterConsum + passConsum

	local isReduce = self.chapterData.prizeTime < self.chapterData:GetCfg().RewardTimes and BossChapterModule.ReduceConsumeCount() > 0

	self.ReduceConsumNumText:SetActive(isReduce)
	UGUIUtil.SetText(self.ReduceConsumNumText, consumNum)

	if isReduce then
		UGUIUtil.SetText(self.ConsumNumText, enterConsum + math.floor(BossChapterModule.ReduceStrength(passConsum)))
	else
		UGUIUtil.SetText(self.ConsumNumText, consumNum)
	end

	local path = UIGlobalApi.GetIconPath(CfgItemTable[needItemCid].SmallIcon)

	self:OnLoadImg(path, self.ConsumSlotImg)
end

function BossDupUI:OnRenderRewardItem(cell)
	local data = self.rewardItems[cell.index + 1]
	local Obj = self.itemList[cell.gameObject]

	if Obj == nil then
		Obj = bossRewardItem.New(cell.gameObject)
		self.itemList[cell.gameObject] = Obj
	end

	Obj:SetData(data)
end

function BossDupUI:OnLoadImg(path, obj)
	AssetUtil.LoadImage(self, path, obj:GetComponent("Image"), self.LoadImageSucess, nil, obj)
end

function BossDupUI:LoadImageSucess(assetName, asset, duration, userData)
	userData:GetComponent("Image"):SetNativeSize()
end

function BossDupUI:OnEnterBtnClick()
	local userData = {}

	userData.OpenType = 2
	userData.ChapterType = Constant.ChapterPassType.TYPE_BOSS
	userData.StageId = self.stageData.cid

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function BossDupUI:OnChallengeRuleBtn()
	self.ChallengeRuleParent:SetActive(true)
end

function BossDupUI:OnCloseChallengeRuleBtn()
	self.ChallengeRuleParent:SetActive(false)
end

return BossDupUI
