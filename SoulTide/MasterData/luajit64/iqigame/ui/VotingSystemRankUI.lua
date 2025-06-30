-- chunkname: @IQIGame\\UI\\VotingSystemRankUI.lua

local VotingSystemRankUI = {
	rankType = 1,
	rankRenderCellPool = {},
	rankMembers = {}
}

VotingSystemRankUI = Base:Extend("VotingSystemRankUI", "IQIGame.Onigao.UI.VotingSystemRankUI", VotingSystemRankUI)

require("IQIGame.UIExternalApi.VotingSystemRankUIApi")

local VotingSystemRankRenderCell = require("IQIGame.UI.Activity.CupVoting.VotingSystemRankRenderCell")
local ActiveCupVoteMemberData = require("IQIGame.Module.ActiveCupVoting.ActiveCupVoteMemberData")

function VotingSystemRankUI:OnInit()
	UGUIUtil.SetText(self.TitleText, VotingSystemRankUIApi:GetString("TitleText"))

	for i = 1, 4 do
		self["Toggle" .. i]:GetComponent("ToggleHelperComponent").text = VotingSystemRankUIApi:GetString("ToggleTitle", i)
	end

	self.ScrollAreaList:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateToggleChange1(isOn)
		self:OnToggleValueChanged1(isOn)
	end

	function self.DelegateToggleChange2(isOn)
		self:OnToggleValueChanged2(isOn)
	end

	function self.DelegateUpdateCupVoteEvent()
		self:OnUpdateCupVoteEvent()
	end
end

function VotingSystemRankUI:GetPreloadAssetPaths()
	return nil
end

function VotingSystemRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function VotingSystemRankUI:IsManualShowOnOpen(userData)
	return false
end

function VotingSystemRankUI:GetBGM(userData)
	return nil
end

function VotingSystemRankUI:OnOpen(userData)
	self.operateEventID = userData
	self.rankType = 1
	self.Toggle1:GetComponent("Toggle").isOn = true

	self:UpdateView()
end

function VotingSystemRankUI:OnClose(userData)
	return
end

function VotingSystemRankUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.Toggle1:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateToggleChange1)
	self.Toggle2:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateToggleChange2)
	EventDispatcher.AddEventListener(EventID.UpdateCupVoteEvent, self.DelegateUpdateCupVoteEvent)
end

function VotingSystemRankUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.Toggle1:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateToggleChange1)
	self.Toggle2:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateToggleChange2)
	EventDispatcher.RemoveEventListener(EventID.UpdateCupVoteEvent, self.DelegateUpdateCupVoteEvent)
end

function VotingSystemRankUI:OnPause()
	return
end

function VotingSystemRankUI:OnResume()
	return
end

function VotingSystemRankUI:OnCover()
	return
end

function VotingSystemRankUI:OnReveal()
	return
end

function VotingSystemRankUI:OnRefocus(userData)
	return
end

function VotingSystemRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function VotingSystemRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function VotingSystemRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function VotingSystemRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function VotingSystemRankUI:OnDestroy()
	for i, v in pairs(self.rankRenderCellPool) do
		v:Dispose()
	end
end

function VotingSystemRankUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function VotingSystemRankUI:OnToggleValueChanged1(isOn)
	if isOn then
		self.rankType = 1

		self:UpdateView()
	end
end

function VotingSystemRankUI:OnToggleValueChanged2(isOn)
	if isOn then
		self.rankType = 2

		self:UpdateView()
	end
end

function VotingSystemRankUI:OnUpdateCupVoteEvent()
	if self.operateEventID then
		self:UpdateView()
	end
end

function VotingSystemRankUI:UpdateView()
	self.members = {}

	local groupData = ActiveCupVotingModule.GetCupVoteTeamData(self.operateEventID)

	for groupNum, members in pairs(groupData) do
		for i, id in pairs(members) do
			local noteNum = ActiveCupVotingModule.GetMemberNoteNum(id)
			local groupName = ActiveCupVotingModule.GetGroupName(self.operateEventID, groupNum)
			local lastVoteTime = ActiveCupVotingModule.GetMemberLastVoteTime(id)
			local memberData = ActiveCupVoteMemberData.New(id, noteNum, groupNum, groupName, lastVoteTime)

			table.insert(self.members, memberData)
		end
	end

	if self.rankType == 1 then
		table.sort(self.members, function(a, b)
			if a.voteNum == b.voteNum then
				if a.lastVoteTime == b.lastVoteTime then
					return a.cid < b.cid
				end

				return a.lastVoteTime < b.lastVoteTime
			end

			return a.voteNum > b.voteNum
		end)
	elseif self.rankType == 2 then
		table.sort(self.members, function(a, b)
			if a.groupNum == b.groupNum then
				if a.voteNum == b.voteNum then
					if a.lastVoteTime == b.lastVoteTime then
						return a.cid < b.cid
					end

					return a.lastVoteTime < b.lastVoteTime
				end

				return a.voteNum > b.voteNum
			else
				return a.groupNum < b.groupNum
			end
		end)
	end

	self.ScrollAreaList:GetComponent("ScrollAreaList"):Refresh(#self.members)
end

function VotingSystemRankUI:OnRenderGridCell(cell)
	local data = self.members[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.rankRenderCellPool[instanceID]

	if renderCell == nil then
		renderCell = VotingSystemRankRenderCell.New(cell.gameObject)
		self.rankRenderCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data, cell.index)
end

return VotingSystemRankUI
