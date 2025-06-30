-- chunkname: @IQIGame\\UI\\LibraryRewardUI.lua

local LibraryRewardUI = Base:Extend("LibraryRewardUI", "IQIGame.Onigao.UI.LibraryRewardUI", {
	isGetReward = false,
	rewardCellPool = {}
})
local LibraryRewardCell = require("IQIGame.UI.Library.LibraryRewardCell")

function LibraryRewardUI:OnInit()
	UGUIUtil.SetText(self.goTitle, LibraryRewardUIApi:GetString("TextTitle"))

	self.btnCloseComponent = self.goBtnClose:GetComponent("Button")
	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(renderCell)
		self:OnRenderGridCell(renderCell)
	end

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateTaskCommitResponse(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end
end

function LibraryRewardUI:GetPreloadAssetPaths()
	return nil
end

function LibraryRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibraryRewardUI:IsManualShowOnOpen(userData)
	return false
end

function LibraryRewardUI:GetBGM(userData)
	return nil
end

function LibraryRewardUI:OnOpen(userData)
	self.taskType = userData
	self.taskDataTab = TownLibraryModule.GetLibraryTask(self.taskType)

	self:UpDateView()
end

function LibraryRewardUI:OnClose(userData)
	return
end

function LibraryRewardUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateClickBtnClose)
	self.goBtnClose1:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.delegateTaskCommitResponse)
end

function LibraryRewardUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateClickBtnClose)
	self.goBtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.delegateTaskCommitResponse)
end

function LibraryRewardUI:OnPause()
	return
end

function LibraryRewardUI:OnResume()
	return
end

function LibraryRewardUI:OnCover()
	return
end

function LibraryRewardUI:OnReveal()
	return
end

function LibraryRewardUI:OnRefocus(userData)
	return
end

function LibraryRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibraryRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LibraryRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibraryRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibraryRewardUI:OnDestroy()
	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end
end

function LibraryRewardUI:UpDateView()
	table.sort(self.taskDataTab, function(a, b)
		local res = false

		if a.TaskStatus == b.TaskStatus then
			res = a.cid < b.cid
		else
			res = a.TaskStatus < b.TaskStatus
		end

		return res
	end)
	self.scrollList:Refresh(#self.taskDataTab)
end

function LibraryRewardUI:OnRenderGridCell(cell)
	local taskData = self.taskDataTab[cell.index + 1]

	if taskData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local insID = cell.gameObject:GetInstanceID()
	local handbookRewardCell = self.rewardCellPool[insID]

	if handbookRewardCell == nil then
		handbookRewardCell = LibraryRewardCell.New(cell.gameObject, self)
		self.rewardCellPool[insID] = handbookRewardCell
	end

	handbookRewardCell:SetData(taskData)
end

function LibraryRewardUI:OnTaskCommitResponse(cids, awards)
	if self.isGetReward and #awards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, awards)
	end

	self.isGetReward = false
	self.taskDataTab = TownLibraryModule.GetLibraryTask(self.taskType)

	self:UpDateView()
end

function LibraryRewardUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.LibraryRewardUI)
end

return LibraryRewardUI
