-- chunkname: @IQIGame\\UI\\ActivityCreditUI.lua

local ActivityCreditUI = Base:Extend("ActivityCreditUI", "IQIGame.Onigao.UI.ActivityCreditUI", {
	itemCellPool = {},
	rewardDatum = {}
})

function ActivityCreditUI:OnInit()
	self:Initialize()
end

function ActivityCreditUI:GetPreloadAssetPaths()
	return nil
end

function ActivityCreditUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActivityCreditUI:IsManualShowOnOpen(userData)
	return false
end

function ActivityCreditUI:GetBGM(userData)
	return nil
end

function ActivityCreditUI:OnOpen(userData)
	self:Refresh(userData)
end

function ActivityCreditUI:OnClose(userData)
	self:OnHide()
end

function ActivityCreditUI:OnAddListeners()
	return
end

function ActivityCreditUI:OnRemoveListeners()
	return
end

function ActivityCreditUI:OnPause()
	return
end

function ActivityCreditUI:OnResume()
	return
end

function ActivityCreditUI:OnCover()
	return
end

function ActivityCreditUI:OnReveal()
	return
end

function ActivityCreditUI:OnRefocus(userData)
	return
end

function ActivityCreditUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ActivityCreditUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActivityCreditUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActivityCreditUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActivityCreditUI:Initialize()
	self.moneyCellBuilder = MoneyCellsBuilder.New(self.goMoneyParent)
	self.energyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.rewardList = self.goRewardList:GetComponent("ScrollAreaList")

	function self.rewardList.onRenderCell(grid)
		self:OnRenderReward(grid)
	end

	self.btnJump = self.goBtnJump:GetComponent("Button")
	self.btnPV = self.goBtnPV:GetComponent("Button")
	self.btnDetail = self.goBtnDetail:GetComponent("Button")

	function self.onClickBtnPVDelegate()
		self:OnClickBtnPV()
	end

	function self.onClickBtnDetailDelegate()
		self:OnClickBtnDetail()
	end

	function self.onClickBtnJumpDelegate()
		self:OnClickBtnJump()
	end

	function self.onTaskUpdateDelegate(id)
		self:OnTaskUpdate(id)
	end

	function self.onTaskCommitResponseDelegate(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end

	self.goBtnPV.transform:Find("Text"):GetComponent("Text").text = ActivityCreditUIApi:GetString("FRBtnPVTxt")
	self.goBtnDetail.transform:Find("Text_01"):GetComponent("Text").text = ActivityCreditUIApi:GetString("FRBtnDetailTxt_1")
	self.goBtnDetail.transform:Find("Text_02"):GetComponent("Text").text = ActivityCreditUIApi:GetString("FRBtnDetailTxt_2")
	self.goDesc1:GetComponent("Text").text = ActivityCreditUIApi:GetString("FRDesc1")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = ActivityCreditUIApi:GetString("goBtnCloseTxt")
end

function ActivityCreditUI:Refresh(userData)
	self.taskData = ActiveModule.GetFirstRechargeTaskData()

	self:RefreshMisc()
	self:RefreshReward()
	EventDispatcher.Dispatch(EventID.StopBGM)
end

function ActivityCreditUI:OnHide()
	EventDispatcher.Dispatch(EventID.L2DResume)
	EventDispatcher.Dispatch(EventID.RestoreBGM)
end

function ActivityCreditUI:OnDestroy()
	self.moneyCellBuilder:Dispose()
	self.energyCell:Dispose()

	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end
end

function ActivityCreditUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnJump.onClick:AddListener(self.onClickBtnJumpDelegate)
	self.btnPV.onClick:AddListener(self.onClickBtnPVDelegate)
	self.btnDetail.onClick:AddListener(self.onClickBtnDetailDelegate)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
end

function ActivityCreditUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnJump.onClick:RemoveListener(self.onClickBtnJumpDelegate)
	self.btnPV.onClick:RemoveListener(self.onClickBtnPVDelegate)
	self.btnDetail.onClick:RemoveListener(self.onClickBtnDetailDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
end

function ActivityCreditUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function ActivityCreditUI:OnClickBtnJump()
	if self.isTaskOver then
		TaskModule.SendCommitTaskMsg(self.taskData.cid)
	else
		JumpModule.Jump(10202004)
	end
end

function ActivityCreditUI:OnClickBtnPV()
	local cgID = ActivityCreditUIApi:GetString("FRcgid")

	UIModule.Open(Constant.UIControllerName.AvPlayUI, Constant.UILayer.UI, cgID)
end

function ActivityCreditUI:OnClickBtnDetail()
	UIModule.Open(Constant.UIControllerName.SoulLockUI, Constant.UILayer.UI, SoulModule.GetSoulData(20010005))
end

function ActivityCreditUI:OnRenderReward(cell)
	local luaIndex = cell.index + 1
	local data = self.rewardDatum[luaIndex]
	local itemCell = self.itemCellPool[luaIndex]

	if itemCell == nil then
		itemCell = ItemCell.PackageOrReuseView(self, cell.transform:GetChild(0).gameObject, true)
		self.itemCellPool[luaIndex] = itemCell
	end

	itemCell:SetItemByCID(data.id, data.count)
end

function ActivityCreditUI:OnTaskUpdate(id)
	self:Refresh()
end

function ActivityCreditUI:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end

	UIModule.CloseSelf(self)
end

function ActivityCreditUI:RefreshMisc()
	self.moneyCellBuilder:RefreshView({
		Constant.ItemID.MONEY,
		Constant.ItemID.TREASURE
	})

	if self.taskData.CurrentNum >= self.taskData.TargetNum then
		self.isTaskOver = true
		self.goBtnJump.transform:Find("Text_01"):GetComponent("Text").text = ActivityCreditUIApi:GetString("FRBtnGetTxt")
		self.goBtnJump.transform:Find("Text_02"):GetComponent("Text").text = ActivityCreditUIApi:GetString("FRBtnGetTxtEng")
	else
		self.isTaskOver = false
		self.goBtnJump.transform:Find("Text_01"):GetComponent("Text").text = ActivityCreditUIApi:GetString("FRBtnJumpTxt")
		self.goBtnJump.transform:Find("Text_02"):GetComponent("Text").text = ActivityCreditUIApi:GetString("FRBtnJumpTxtEng")
	end
end

function ActivityCreditUI:RefreshReward()
	local cfgMainQuest

	for i, v in pairsCfg(CfgMainQuestTable) do
		if v.Type == TaskModule.TaskType.FIRST_RECHARGE_TASK then
			cfgMainQuest = v

			break
		end
	end

	self.rewardDatum = {}

	for i, v in ipairs(cfgMainQuest.Reward) do
		if i % 2 ~= 0 then
			local data = {}

			data.id = v
			data.count = cfgMainQuest.Reward[i + 1]
			self.rewardDatum[#self.rewardDatum + 1] = data
		end
	end

	self.rewardList:Refresh(#self.rewardDatum)
end

return ActivityCreditUI
