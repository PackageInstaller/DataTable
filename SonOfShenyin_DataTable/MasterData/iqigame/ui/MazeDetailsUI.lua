-- chunkname: @IQIGame\\UI\\MazeDetailsUI.lua

local mazeStageDetailsView = require("IQIGame.UI.Maze.UI.MazeDetailsUI.MazeStageDetailsView")
local MazeDetailsUI = {
	RewardDataList = {},
	RewardItemList = {}
}

MazeDetailsUI = Base:Extend("MazeDetailsUI", "IQIGame.Onigao.UI.MazeDetailsUI", MazeDetailsUI)

function MazeDetailsUI:OnInit()
	function self.DelegateOnClickStartBtn()
		self:OnClickStartBtn()
	end

	function self.DelegateOnClickContinueBtn()
		self:OnClickContinueBtn()
	end

	function self.DelegateOnClickQuitBtn()
		self:OnClickQuitBtn()
	end

	self.wrapContent = self.RewardScrollView:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	self.MazeStageDetailsView = mazeStageDetailsView.New(self.MazeStageDetailsPanel)
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)
end

function MazeDetailsUI:GetPreloadAssetPaths()
	return nil
end

function MazeDetailsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeDetailsUI:IsManualShowOnOpen(userData)
	return false
end

function MazeDetailsUI:GetBGM(userData)
	return nil
end

function MazeDetailsUI:OnOpen(userData)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.SkillBreachUI)

	self.stageCfg = userData.stageCfg
	self.mazeStageData = MazeModule.GetMazeStageDataByMazeID(self.stageCfg.Id)

	self.MazeStageDetailsView:SetData(self.stageCfg)
	self:RefreshBtnState()
	self:RefreshConsumeState()
	self.wrapContent:Refresh(10)
end

function MazeDetailsUI:OnClose(userData)
	self:InitStageInfo()
end

function MazeDetailsUI:OnAddListeners()
	self.StartBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStartBtn)
	self.ContinueBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickContinueBtn)
	self.QuitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickQuitBtn)
end

function MazeDetailsUI:OnRemoveListeners()
	self.StartBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStartBtn)
	self.ContinueBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickContinueBtn)
	self.QuitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickQuitBtn)
end

function MazeDetailsUI:OnPause()
	return
end

function MazeDetailsUI:OnResume()
	return
end

function MazeDetailsUI:OnCover()
	return
end

function MazeDetailsUI:OnReveal()
	return
end

function MazeDetailsUI:OnRefocus(userData)
	return
end

function MazeDetailsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeDetailsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeDetailsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeDetailsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeDetailsUI:OnDestroy()
	self.MazeStageDetailsView:Dispose()
	self.moneyCell:Dispose()
	self.commonReturnBtn:Dispose()

	for k, v in pairs(self.RewardItemList) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
end

function MazeDetailsUI:InitStageInfo()
	return
end

function MazeDetailsUI:OnRenderItem(cell)
	local itemData = self.RewardDataList[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.RewardItemList[instanceId]

	if itemCell == nil then
		itemCell = ItemCell.New(cell.gameObject)
		self.RewardItemList[instanceId] = itemCell
	end
end

function MazeDetailsUI:RefreshBtnState()
	LuaUtility.SetGameObjectShow(self.ContinueBtn, self.mazeStageData ~= nil and self.mazeStageData.state == 1)
	LuaUtility.SetGameObjectShow(self.QuitBtn, self.mazeStageData ~= nil and self.mazeStageData.state == 1)
	LuaUtility.SetGameObjectShow(self.StartBtn, self.mazeStageData == nil or self.mazeStageData.state == 0 or self.mazeStageData.state == 2)
end

function MazeDetailsUI:RefreshConsumeState()
	LuaUtility.SetGameObjectShow(self.ConsumeParent, self.mazeStageData == nil or self.mazeStageData.state == 0 or self.mazeStageData.state == 2)
	UGUIUtil.SetText(self.ConsumeText, self.stageCfg.Cost[2])
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.stageCfg.Cost[1]].SmallIcon), self.ConsumeImage:GetComponent("Image"))
end

function MazeDetailsUI:OnClickStartBtn()
	local userData = {}

	userData.StageId = self.stageCfg.Id
	userData.OpenType = Constant.FormationOpenType.Maze
	userData.ChapterType = Constant.ChapterPassType.TYPE_Maze

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function MazeDetailsUI:OnClickContinueBtn()
	local enterDupData = {}

	enterDupData.ChapterType = Constant.ChapterPassType.TYPE_Maze
	enterDupData.PassId = self.stageCfg.Id
	enterDupData.FormationID = self.mazeStageData.formationPOD.cid

	GameChapterModule.EnterDupByChapterType(enterDupData)
end

function MazeDetailsUI:OnClickQuitBtn()
	NoticeModule.ShowNotice(80002, function()
		MazeModule.FinishMazeStage(self.stageCfg.Id)
	end)
end

return MazeDetailsUI
