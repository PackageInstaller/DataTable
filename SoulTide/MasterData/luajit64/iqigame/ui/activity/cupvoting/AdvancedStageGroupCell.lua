-- chunkname: @IQIGame\\UI\\Activity\\CupVoting\\AdvancedStageGroupCell.lua

local m = {
	groupHeadCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AdvancedStageGroupHeadCell = require("IQIGame.UI.Activity.CupVoting.AdvancedStageGroupHeadCell")
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

	function self.DelegateBtnSelf()
		self:OnBtnSelf()
	end

	self.HeadModel:SetActive(false)

	self.groupHeadCellPool = UIObjectPool.New(5, function()
		return AdvancedStageGroupHeadCell.New(UnityEngine.Object.Instantiate(self.HeadModel))
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelf)
end

function m:UpdateView()
	local groupName = ActiveCupVotingModule.GetGroupName(self.operateEventID, self.groupNum)

	UGUIUtil.SetText(self.GroupName, groupName)

	local UIController = self.View:GetComponentInParent(typeof(UIController))
	local tab = {}

	for i = 1, #self.members do
		local id = self.members[i]
		local noteNum = ActiveCupVotingModule.GetMemberNoteNum(id)
		local lastVoteTime = ActiveCupVotingModule.GetMemberLastVoteTime(id)

		if noteNum > 0 then
			local data = ActiveCupVoteMemberData.New(id, noteNum, self.groupNum, groupName, lastVoteTime)

			table.insert(tab, data)
		end
	end

	table.sort(tab, function(a, b)
		if a.voteNum == b.voteNum then
			if a.lastVoteTime == b.lastVoteTime then
				return a.cid < b.cid
			end

			return a.lastVoteTime < b.lastVoteTime
		end

		return a.voteNum > b.voteNum
	end)

	local showMax = 0

	if ActiveCupVotingModule.centerCupMatchVoteDataPOD then
		if ActiveCupVotingModule.centerCupMatchVoteDataPOD.stage == Constant.CupVotingStage.CupVoting_GroupStage then
			showMax = 2
		elseif ActiveCupVotingModule.centerCupMatchVoteDataPOD.stage == Constant.CupVotingStage.CupVoting_EliminatedStage then
			showMax = 3
		end
	end

	local tabIDs = {}

	for i = 1, #tab do
		if i <= showMax then
			local data = tab[i]

			table.insert(tabIDs, data.cid)
		end
	end

	for i, v in pairs(self.groupHeadCells) do
		v.View.transform:SetParent(UIController.transform, false)
		v.View:SetActive(false)
		self.groupHeadCellPool:Release(v)
	end

	self.groupHeadCells = {}

	table.sort(self.members, function(a, b)
		return a < b
	end)

	for i = 1, #self.members do
		local id = self.members[i]
		local cell = self.groupHeadCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.GroupHeadNode.transform, false)
		cell:SetData(id)

		if table.indexOf(tabIDs, id) ~= -1 then
			cell:ShowTag(true)
		else
			cell:ShowTag(false)
		end

		table.insert(self.groupHeadCells, cell)
	end
end

function m:SetData(groupNum, members)
	self.groupNum = groupNum
	self.members = members

	self:UpdateView()
end

function m:OnBtnSelf()
	UIModule.Open(Constant.UIControllerName.VotingSystemVoteUI, Constant.UILayer.UI, {
		OperateEventID = self.operateEventID,
		GroupNum = self.groupNum,
		Members = self.members
	})
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.groupHeadCells) do
		self.groupHeadCellPool:Release(v)
	end

	self.groupHeadCells = {}

	self.groupHeadCellPool:Dispose()

	self.groupHeadCellPool = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
