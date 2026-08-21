-- chunkname: @IQIGame\\UI\\Activity\\CupVoting\\CupVotingFinalStageView.lua

local m = {
	finalsHeadCells = {},
	groupData = {},
	members = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FinalsHeadCell = require("IQIGame.UI.Activity.CupVoting.FinalsHeadCell")
local ActiveCupVoteMemberData = require("IQIGame.Module.ActiveCupVoting.ActiveCupVoteMemberData")

function m.New(view, operateEventID)
	local obj = Clone(m)

	obj:Init(view, operateEventID)

	return obj
end

function m:Init(view, operateEventID)
	self.View = view
	self.operateEventID = operateEventID

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnVote()
		self:OnBtnVote()
	end

	self.FinalsHeadMould:SetActive(false)

	self.finalsHeadCellPool = UIObjectPool.New(6, function()
		return FinalsHeadCell.New(UnityEngine.Object.Instantiate(self.FinalsHeadMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function m:AddListener()
	self.BtnVote:GetComponent("Button").onClick:AddListener(self.DelegateBtnVote)
end

function m:RemoveListener()
	self.BtnVote:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnVote)
end

function m:UpDateView()
	local UIController = self.View:GetComponentInParent(typeof(UIController))

	for i, v in pairs(self.finalsHeadCells) do
		v.View.transform:SetParent(UIController.transform, false)
		v.View:SetActive(false)
		self.finalsHeadCellPool:Release(v)
	end

	self.finalsHeadCells = {}

	local tab = self.groupData[1]

	self.members = {}

	for i, v in pairs(tab) do
		local noteNum = ActiveCupVotingModule.GetMemberNoteNum(v)
		local groupName = ActiveCupVotingModule.GetGroupName(self.operateEventID, 1)
		local lastVoteTime = ActiveCupVotingModule.GetMemberLastVoteTime(v)
		local data = ActiveCupVoteMemberData.New(v, noteNum, 1, groupName, lastVoteTime)

		table.insert(self.members, data)
	end

	table.sort(self.members, function(a, b)
		if a.voteNum == b.voteNum then
			if a.lastVoteTime == b.lastVoteTime then
				return a.cid < b.cid
			end

			return a.lastVoteTime < b.lastVoteTime
		end

		return a.voteNum > b.voteNum
	end)

	for i = 1, #self.members do
		local data = self.members[i]
		local cell = self.finalsHeadCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self["Rank" .. i].transform, false)
		cell:SetData(data, i)
		table.insert(self.finalsHeadCells, cell)
	end

	if ActiveCupVotingModule.centerCupMatchVoteDataPOD and ActiveCupVotingModule.centerCupMatchVoteDataPOD.stage == Constant.CupVotingStage.CupVoting_FinalsStage then
		self.BtnVote:SetActive(true)
	else
		self.BtnVote:SetActive(false)
	end
end

function m:OnBtnVote()
	UIModule.Open(Constant.UIControllerName.VotingSystemVoteUI, Constant.UILayer.UI, {
		GroupNum = 1,
		OperateEventID = self.operateEventID,
		Members = self.groupData[1]
	})
end

function m:Open()
	self.groupData = ActiveCupVotingModule.GetCupVoteTeamData(self.operateEventID)

	self.View:SetActive(true)
	self:AddListener()
	self:UpDateView()
end

function m:Close()
	self.View:SetActive(false)
	self:RemoveListener()
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.finalsHeadCells) do
		self.finalsHeadCellPool:Release(v)
	end

	self.finalsHeadCells = {}

	self.finalsHeadCellPool:Dispose()

	self.finalsHeadCellPool = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
