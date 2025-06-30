-- chunkname: @IQIGame\\UI\\Activity\\CupVoting\\CupVotingView.lua

local m = {
	lastGetInfoTime = 0
}
local CupVotingAdvancedStageView = require("IQIGame.UI.Activity.CupVoting.CupVotingAdvancedStageView")
local CupVotingFinalStageView = require("IQIGame.UI.Activity.CupVoting.CupVotingFinalStageView")
local VotingTicketCell = require("IQIGame.UI.Activity.CupVoting.VotingTicketCell")

function m.New(view, root, operateEventID)
	local obj = Clone(m)

	obj:Init(view, root, operateEventID)

	return obj
end

function m:Init(view, root, operateEventID)
	self.View = view
	self.root = root
	self.operateEventID = operateEventID

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetTextInChildren(self.BtnDes, ActivityUIApi:GetString("CupVotingBtnDesLabel"))

	function self.DelegateBtnDes()
		self:OnBtnDes()
	end

	function self.DelegateUpdateCupVoteEvent()
		self:OnUpdateCupVoteEvent()
	end

	function self.DelegateUpdateOperationsEvent()
		self:OnUpdateOperationsEvent()
	end

	self.cupVotingAdvancedStageView = CupVotingAdvancedStageView.New(self.AdvancedStage, self.operateEventID)
	self.cupVotingFinalStageView = CupVotingFinalStageView.New(self.FinalStage, self.operateEventID)
	self.votingTicketCell = VotingTicketCell.New(self.VotingTicket)
	self.lastGetInfoTime = PlayerModule.GetServerTime()

	ActiveCupVotingModule.GetVoteInfo(self.operateEventID)
end

function m:Update(elapseSeconds, realElapseSeconds)
	if self.operateEventID == nil then
		return
	end

	if not ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		return false
	end

	local nowTime = PlayerModule.GetServerTime()

	if nowTime - self.lastGetInfoTime > 10 then
		self.lastGetInfoTime = nowTime

		ActiveCupVotingModule.GetVoteInfo(self.operateEventID)
	end
end

function m:AddListener()
	self.BtnDes:GetComponent("Button").onClick:AddListener(self.DelegateBtnDes)
	EventDispatcher.AddEventListener(EventID.UpdateCupVoteEvent, self.DelegateUpdateCupVoteEvent)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.DelegateUpdateOperationsEvent)
end

function m:RemoveListener()
	self.BtnDes:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnDes)
	EventDispatcher.RemoveEventListener(EventID.UpdateCupVoteEvent, self.DelegateUpdateCupVoteEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.DelegateUpdateOperationsEvent)
end

function m:UpDateView()
	if not ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		return false
	end

	if ActiveCupVotingModule.centerCupMatchVoteDataPOD == nil then
		return
	end

	self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

	if self.eventPOD then
		self.cfgCupMatchVoteGlobalData = CfgCupMatchVoteGlobalTable[self.eventPOD.dataCfgId]

		local showStartTime = self.eventPOD.startTime
		local showEndTime = self.eventPOD.endTime

		if ActiveCupVotingModule.centerCupMatchVoteDataPOD.stage == Constant.CupVotingStage.CupVoting_GroupStage then
			showEndTime = ActiveCupVotingModule.centerCupMatchVoteDataPOD.knockoutTime
		elseif ActiveCupVotingModule.centerCupMatchVoteDataPOD.stage == Constant.CupVotingStage.CupVoting_EliminatedStage then
			showStartTime = ActiveCupVotingModule.centerCupMatchVoteDataPOD.knockoutTime
			showEndTime = ActiveCupVotingModule.centerCupMatchVoteDataPOD.finalTime
		elseif ActiveCupVotingModule.centerCupMatchVoteDataPOD.stage == Constant.CupVotingStage.CupVoting_FinalsStage then
			showStartTime = ActiveCupVotingModule.centerCupMatchVoteDataPOD.finalTime
			showEndTime = ActiveCupVotingModule.centerCupMatchVoteDataPOD.finishTime
		end

		local startYear = getYearText(showStartTime)
		local endYear = getYearText(showEndTime)
		local startMoth = getMonthText(showStartTime)
		local endMoth = getMonthText(showEndTime)
		local startDay = getOnlyDateText(showStartTime)
		local endDay = getOnlyDateText(showEndTime)
		local startHM = getHourMinuteText(showStartTime)
		local endHM = getHourMinuteText(showEndTime)

		UGUIUtil.SetText(self.TextStartTime, ActivityUIApi:GetString("CupVotingStartTime", startYear, startMoth, startDay, startHM))
		UGUIUtil.SetText(self.TextEndTime, ActivityUIApi:GetString("CupVotingEndTime", endYear, endMoth, endDay, endHM))

		local path = ActivityUIApi:GetString("CupVotingImgTitlePath", ActiveCupVotingModule.centerCupMatchVoteDataPOD.stage)

		AssetUtil.LoadImage(self, path, self.ImgTitle:GetComponent("Image"))
	end

	self:ShowChildView()
end

function m:ShowChildView()
	self.cupVotingAdvancedStageView:Close()
	self.cupVotingFinalStageView:Close()

	if ActiveCupVotingModule.centerCupMatchVoteDataPOD then
		if ActiveCupVotingModule.centerCupMatchVoteDataPOD.stage >= Constant.CupVotingStage.CupVoting_FinalsStage then
			self.cupVotingFinalStageView:Open()
		elseif ActiveCupVotingModule.centerCupMatchVoteDataPOD.stage == Constant.CupVotingStage.CupVoting_GroupStage or ActiveCupVotingModule.centerCupMatchVoteDataPOD.stage == Constant.CupVotingStage.CupVoting_EliminatedStage then
			self.cupVotingAdvancedStageView:Open()
		end
	end
end

function m:OnUpdateCupVoteEvent()
	self:UpDateView()
end

function m:OnUpdateOperationsEvent()
	self:UpDateView()
end

function m:OnBtnDes()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, self.cfgCupMatchVoteGlobalData.Desc)
end

function m:Open()
	self:AddListener()
	self.View:SetActive(true)
	self.votingTicketCell:RefreshData(self.operateEventID)
	self:UpDateView()
end

function m:Close()
	self.View:SetActive(false)
	self.cupVotingAdvancedStageView:Close()
	self.cupVotingFinalStageView:Close()
	self:OnHide()
end

function m:OnHide()
	self:RemoveListener()
end

function m:OnDestroy()
	self.cupVotingAdvancedStageView:Dispose()

	self.cupVotingAdvancedStageView = nil

	self.cupVotingFinalStageView:Dispose()

	self.cupVotingFinalStageView = nil

	self.votingTicketCell:Dispose()

	self.votingTicketCell = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
