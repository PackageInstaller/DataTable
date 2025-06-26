-- chunkname: @IQIGame\\UI\\Activity\\Vote\\ActiveVoteView.lua

local m = {
	votingOptions = {},
	votingOptionCellPool = {}
}
local VotingOptionCell = require("IQIGame.UI.Activity.Vote.VotingOptionCell")

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
	UGUIUtil.SetText(self.MostPopularDes, ActivityUIApi:GetString("VoteMostPopularDes"))
	UGUIUtil.SetText(self.BtnVoteLabel, ActivityUIApi:GetString("VoteBtnVoteLabel"))

	self.scrollList = self.Scroll:GetComponent("ScrollAreaList")

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.delegateUpdateOperations()
		self:OnUpdateOperations()
	end

	function self.delegateBtnVote()
		self:OnBtnVote()
	end

	function self.delegateUpdateVoteEvent()
		self:OnUpdateVoteEvent()
	end
end

function m.GetPreloadAssetPaths()
	return
end

function m:Update(elapseSeconds, realElapseSeconds)
	return
end

function m:AddListener()
	self.BtnVote:GetComponent("Button").onClick:AddListener(self.delegateBtnVote)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	EventDispatcher.AddEventListener(EventID.UpdateVoteEvent, self.delegateUpdateVoteEvent)
end

function m:RemoveListener()
	self.BtnVote:GetComponent("Button").onClick:RemoveListener(self.delegateBtnVote)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	EventDispatcher.RemoveEventListener(EventID.UpdateVoteEvent, self.delegateUpdateVoteEvent)
end

function m:OnUpdateOperations()
	self:UpDateView()
end

function m:OnUpdateVoteEvent()
	self:UpDateView()
end

function m:OnBtnVote()
	if self.selectVotingOption == nil then
		NoticeModule.ShowNotice(21045041)

		return
	end

	local have = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.PANDA_VOTE)

	if have < 1 then
		NoticeModule.ShowNotice(21052002)

		return
	end

	ActiveVoteModule.Vote(self.operateEventID, self.selectVotingOption.Id)
end

function m:OnSelectedGridCell(cell)
	self.selectVotingOption = self.votingOptions[cell.index + 1]

	for i, v in pairs(self.votingOptionCellPool) do
		if v.View:GetInstanceID() == cell.gameObject:GetInstanceID() then
			v:SetSelect(true)
		else
			v:SetSelect(false)
		end
	end
end

function m:OnRenderGridCell(cell)
	local votingOption = self.votingOptions[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local votingOptionCell = self.votingOptionCellPool[instanceID]

	if votingOptionCell == nil then
		votingOptionCell = VotingOptionCell.New(cell.gameObject)
		self.votingOptionCellPool[instanceID] = votingOptionCell
	end

	local count

	if ActiveVoteModule.centerVoteDataPOD and ActiveVoteModule.centerVoteDataPOD.votes then
		count = ActiveVoteModule.centerVoteDataPOD.votes[votingOption.Id]
	end

	if count == nil then
		count = 0
	end

	votingOptionCell:SetData(votingOption, count)
	votingOptionCell:SetSelect(false)

	if self.selectVotingOption ~= nil and self.selectVotingOption.Id == votingOption.Id then
		votingOptionCell:SetSelect(true)
	end
end

function m:UpDateView()
	self.votingOptions = {}

	if ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

		if self.eventPOD then
			local mostPopularID, mostPopularNum = ActiveVoteModule.GetMostPopularData()

			if mostPopularID > 0 then
				local mostPopularData = CfgVotingOptionsTable[mostPopularID]

				UGUIUtil.SetText(self.MostPopularName, mostPopularData.Title)
				UGUIUtil.SetText(self.MostPopularScore, mostPopularNum)
			end

			for i, v in pairsCfg(CfgVotingOptionsTable) do
				if v.Group == self.eventPOD.dataCfgId then
					table.insert(self.votingOptions, v)
				end
			end

			table.sort(self.votingOptions, function(a, b)
				return a.Id < b.Id
			end)
			self.scrollList:Refresh(#self.votingOptions)
		end
	end

	UGUIUtil.SetText(self.NeedText, ActivityUIApi:GetString("VoteNeedText", CfgItemTable[Constant.ItemID.PANDA_VOTE].Name, 1))
end

function m:Open()
	self:AddListener()

	self.selectVotingOption = nil

	ActiveVoteModule.GetVoteInfo(self.operateEventID)
	self.View:SetActive(true)
	self:UpDateView()
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:OnHide()
	self:RemoveListener()
end

function m:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
