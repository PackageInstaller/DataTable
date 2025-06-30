-- chunkname: @IQIGame\\UI\\MazeChallengeBonusUI.lua

local MazeChallengeBonusUI = {
	mazeChallengeBonusCellPool = {},
	mazeChallengeBonusDataTab = {}
}

MazeChallengeBonusUI = Base:Extend("MazeChallengeBonusUI", "IQIGame.Onigao.UI.MazeChallengeBonusUI", MazeChallengeBonusUI)

require("IQIGame.UIExternalApi.MazeChallengeBonusUIApi")

local MazeChallengeBonusCell = require("IQIGame.UI.ExploreHall.MazeChallengeBonus.MazeChallengeBonusCell")

function MazeChallengeBonusUI:OnInit()
	function self.DelegateOnBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateOnBtnClose2()
		self:OnBtnClose()
	end

	function self.DelegateUnlockChapterTask()
		self:OnUnlockChapterTask()
	end

	function self.DelegateTaskCommitResponse(cids, rewards)
		self:OnTaskCommitResponse(cids, rewards)
	end

	self.ScrollAreaChapter:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderChapterCell(cell)
	end
	self.ScrollAreaChapter:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectedChapterCell(cell)
	end
end

function MazeChallengeBonusUI:GetPreloadAssetPaths()
	return nil
end

function MazeChallengeBonusUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeChallengeBonusUI:IsManualShowOnOpen(userData)
	return false
end

function MazeChallengeBonusUI:GetBGM(userData)
	return nil
end

function MazeChallengeBonusUI:OnOpen(userData)
	self:UpdateView()
end

function MazeChallengeBonusUI:OnClose(userData)
	return
end

function MazeChallengeBonusUI:OnAddListeners()
	self.goBtnClose2:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClose2)
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClose)
	EventDispatcher.AddEventListener(EventID.UnlockChapterTasksEvent, self.DelegateUnlockChapterTask)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.DelegateTaskCommitResponse)
end

function MazeChallengeBonusUI:OnRemoveListeners()
	self.goBtnClose2:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClose2)
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClose)
	EventDispatcher.RemoveEventListener(EventID.UnlockChapterTasksEvent, self.DelegateUnlockChapterTask)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.DelegateTaskCommitResponse)
end

function MazeChallengeBonusUI:OnPause()
	return
end

function MazeChallengeBonusUI:OnResume()
	return
end

function MazeChallengeBonusUI:OnCover()
	return
end

function MazeChallengeBonusUI:OnReveal()
	return
end

function MazeChallengeBonusUI:OnRefocus(userData)
	return
end

function MazeChallengeBonusUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeChallengeBonusUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeChallengeBonusUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeChallengeBonusUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeChallengeBonusUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.mazeChallengeBonusCellPool) do
		v:Dispose()
	end
end

function MazeChallengeBonusUI:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function MazeChallengeBonusUI:OnUnlockChapterTask()
	self:UpdateView()
end

function MazeChallengeBonusUI:UpdateView()
	self:RefreshChapter()
end

function MazeChallengeBonusUI:RefreshChapter()
	self.mazeChallengeBonusDataTab = MazeChallengeBonusModule.mazeChallengeBonusDataTab

	table.sort(self.mazeChallengeBonusDataTab, function(a, b)
		return a.cid < b.cid
	end)
	self.ScrollAreaChapter:GetComponent("ScrollAreaList"):Refresh(#self.mazeChallengeBonusDataTab)
end

function MazeChallengeBonusUI:OnRenderChapterCell(cell)
	local data = self.mazeChallengeBonusDataTab[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.mazeChallengeBonusCellPool[instanceID]

	if renderCell == nil then
		renderCell = MazeChallengeBonusCell.New(cell.gameObject)
		self.mazeChallengeBonusCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data)
end

function MazeChallengeBonusUI:OnSelectedChapterCell(cell)
	local data = self.mazeChallengeBonusDataTab[cell.index + 1]

	if data.buyState == 1 then
		self:BuyTask(data)
	else
		local tasks = data:GetCanGetRewardTasks()

		if #tasks > 0 then
			TaskModule.SendCommitTaskMsgBatch(tasks)
		end
	end
end

function MazeChallengeBonusUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function MazeChallengeBonusUI:BuyTask(data)
	local hasCostItemNum = PlayerModule.PlayerInfo.baseInfo.payPoint
	local buyNeedMoney = data:GetConfig().payPoint

	if hasCostItemNum < buyNeedMoney then
		NoticeModule.MoneyDeficitTip(2, buyNeedMoney - hasCostItemNum)

		return
	end

	NoticeModule.ShowNoticeBuyConfirm(21045031, function()
		MazeChallengeBonusModule.UnlockChapterTasks({
			data.cid
		})
	end, nil, nil, {
		Constant.ItemID.ID_PAYPOINT_SHOW
	}, {
		buyNeedMoney
	})
end

return MazeChallengeBonusUI
