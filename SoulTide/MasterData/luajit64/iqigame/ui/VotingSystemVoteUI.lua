-- chunkname: @IQIGame\\UI\\VotingSystemVoteUI.lua

local VotingSystemVoteUI = {
	cupVoteMembers = {},
	renderCellPool = {}
}

VotingSystemVoteUI = Base:Extend("VotingSystemVoteUI", "IQIGame.Onigao.UI.VotingSystemVoteUI", VotingSystemVoteUI)

require("IQIGame.UIExternalApi.VotingSystemVoteUIApi")

local VotingSystemRenderCell = require("IQIGame.UI.Activity.CupVoting.VotingSystemRenderCell")
local ActiveCupVoteMemberData = require("IQIGame.Module.ActiveCupVoting.ActiveCupVoteMemberData")
local VotingTicketCell = require("IQIGame.UI.Activity.CupVoting.VotingTicketCell")

function VotingSystemVoteUI:OnInit()
	UGUIUtil.SetTextInChildren(self.CloseBtn, VotingSystemVoteUIApi:GetString("CloseBtnLabel"))
	UGUIUtil.SetTextInChildren(self.BtnVote, VotingSystemVoteUIApi:GetString("BtnVoteLabel"))
	UGUIUtil.SetText(self.SelectNullNodeText, VotingSystemVoteUIApi:GetString("SelectNullNodeText"))
	UGUIUtil.SetTextInChildren(self.BackBtn, VotingSystemVoteUIApi:GetString("BackBtnLabel"))

	self.votingTicketCell = VotingTicketCell.New(self.VotingTicket)

	local list = self.ScrollAreaList:GetComponent("ScrollAreaList")

	function list.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function list.onSelectedCell(cell)
		self:OnSelectedCell(cell)
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnBtnVote()
		self:OnBtnVote()
	end

	function self.DelegateUpdateCupVoteEvent()
		self:OnUpdateCupVoteEvent()
	end
end

function VotingSystemVoteUI:GetPreloadAssetPaths()
	return nil
end

function VotingSystemVoteUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function VotingSystemVoteUI:IsManualShowOnOpen(userData)
	return false
end

function VotingSystemVoteUI:GetBGM(userData)
	return nil
end

function VotingSystemVoteUI:OnOpen(userData)
	self.operateEventID = userData.OperateEventID
	self.groupNum = userData.GroupNum
	self.members = userData.Members
	self.selectMember = nil

	self.votingTicketCell:RefreshData(self.operateEventID)
	self:UpdateView()
end

function VotingSystemVoteUI:OnClose(userData)
	return
end

function VotingSystemVoteUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnVote:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnVote)
	self.BackBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.UpdateCupVoteEvent, self.DelegateUpdateCupVoteEvent)
end

function VotingSystemVoteUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnVote:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnVote)
	self.BackBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateCupVoteEvent, self.DelegateUpdateCupVoteEvent)
end

function VotingSystemVoteUI:OnPause()
	return
end

function VotingSystemVoteUI:OnResume()
	return
end

function VotingSystemVoteUI:OnCover()
	return
end

function VotingSystemVoteUI:OnReveal()
	return
end

function VotingSystemVoteUI:OnRefocus(userData)
	return
end

function VotingSystemVoteUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function VotingSystemVoteUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function VotingSystemVoteUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function VotingSystemVoteUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function VotingSystemVoteUI:OnDestroy()
	for i, v in pairs(self.renderCellPool) do
		v:Dispose()
	end

	self.votingTicketCell:Dispose()

	self.votingTicketCell = nil
end

function VotingSystemVoteUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function VotingSystemVoteUI:OnUpdateCupVoteEvent()
	self:UpdateView()
end

function VotingSystemVoteUI:OnRenderCell(cell)
	local voteMemberData = self.cupVoteMembers[cell.index + 1]

	if voteMemberData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.renderCellPool[instanceID]

	if renderCell == nil then
		renderCell = VotingSystemRenderCell.New(cell.gameObject)
		self.renderCellPool[instanceID] = renderCell
	end

	renderCell:SetData(cell.index + 1, voteMemberData)

	if self.selectMember and self.selectMember == voteMemberData.cid then
		renderCell:Select(true)
	else
		renderCell:Select(false)
	end
end

function VotingSystemVoteUI:OnSelectedCell(cell)
	local voteMemberData = self.cupVoteMembers[cell.index + 1]

	self.selectMember = voteMemberData.cid

	for i, v in pairs(self.renderCellPool) do
		v:Select(v.memberData.cid == self.selectMember)
	end

	self:ShowSelectNode()
end

function VotingSystemVoteUI:UpdateView()
	local teamName = ActiveCupVotingModule.GetGroupName(self.operateEventID, self.groupNum)

	UGUIUtil.SetText(self.TitleText, VotingSystemVoteUIApi:GetString("TitleText", ActiveCupVotingModule.centerCupMatchVoteDataPOD.stage, teamName))

	self.cupVoteMembers = {}

	for i = 1, #self.members do
		local id = self.members[i]
		local voteNum = ActiveCupVotingModule.GetMemberNoteNum(id)
		local groupName = ActiveCupVotingModule.GetGroupName(self.operateEventID, self.groupNum)
		local lastVoteTime = ActiveCupVotingModule.GetMemberLastVoteTime(id)
		local memberData = ActiveCupVoteMemberData.New(id, voteNum, self.groupNum, groupName, lastVoteTime)

		table.insert(self.cupVoteMembers, memberData)
	end

	table.sort(self.cupVoteMembers, function(a, b)
		if a.voteNum == b.voteNum then
			if a.lastVoteTime == b.lastVoteTime then
				return a.cid < b.cid
			end

			return a.lastVoteTime < b.lastVoteTime
		end

		return a.voteNum > b.voteNum
	end)

	local list = self.ScrollAreaList:GetComponent("ScrollAreaList")

	list:Refresh(#self.cupVoteMembers)
	self:ShowSelectNode()
end

function VotingSystemVoteUI:ShowSelectNode()
	self.SelectNullNode:SetActive(self.selectMember == nil)
	self.SelectNode:SetActive(self.selectMember ~= nil)

	if self.selectMember then
		UGUIUtil.SetText(self.SelectText, VotingSystemVoteUIApi:GetString("SelectText", CfgCupMatchVoteGroupTable[self.selectMember].OptionName))
	else
		UGUIUtil.SetText(self.SelectText, VotingSystemVoteUIApi:GetString("SelectText", ""))
	end
end

function VotingSystemVoteUI:OnBtnVote()
	if self.selectMember == nil then
		return
	end

	if ActiveCupVotingModule.GetCupVotingTickets(self.operateEventID) <= 0 then
		NoticeModule.ShowNotice(21041013)

		return
	end

	ActiveCupVotingModule.Vote(self.operateEventID, self.selectMember)
end

return VotingSystemVoteUI
