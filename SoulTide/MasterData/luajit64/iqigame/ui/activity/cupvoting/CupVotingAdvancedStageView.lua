-- chunkname: @IQIGame\\UI\\Activity\\CupVoting\\CupVotingAdvancedStageView.lua

local m = {
	groupCells = {},
	groupData = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AdvancedStageGroupCell = require("IQIGame.UI.Activity.CupVoting.AdvancedStageGroupCell")

function m.New(view, operateEventID)
	local obj = Clone(m)

	obj:Init(view, operateEventID)

	return obj
end

function m:Init(view, operateEventID)
	self.View = view
	self.operateEventID = operateEventID

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetTextInChildren(self.BtnLookRank, ActivityUIApi:GetString("CupVotingBtnLookRankLabel"))

	function self.DelegateBtnLookRank()
		self:OnBtnLookRank()
	end

	self.GroupModel:SetActive(false)

	self.groupCellPool = UIObjectPool.New(6, function()
		return AdvancedStageGroupCell.New(UnityEngine.Object.Instantiate(self.GroupModel), self.operateEventID)
	end, function(cell)
		cell:Dispose()
	end)
end

function m:AddListener()
	self.BtnLookRank:GetComponent("Button").onClick:AddListener(self.DelegateBtnLookRank)
end

function m:RemoveListener()
	self.BtnLookRank:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnLookRank)
end

function m:UpdateView()
	local UIController = self.View:GetComponentInParent(typeof(UIController))

	for i, v in pairs(self.groupCells) do
		v.View.transform:SetParent(UIController.transform, false)
		v.View:SetActive(false)
		self.groupCellPool:Release(v)
	end

	self.groupCells = {}

	for i, v in pairs(self.groupData) do
		local cell = self.groupCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.ContentNode.transform, false)
		cell:SetData(i, v)
		table.insert(self.groupCells, cell)
	end
end

function m:OnBtnLookRank()
	UIModule.Open(Constant.UIControllerName.VotingSystemRankUI, Constant.UILayer.UI, self.operateEventID)
end

function m:Open()
	self.View:SetActive(true)
	self:AddListener()

	self.groupData = ActiveCupVotingModule.GetCupVoteTeamData(self.operateEventID)

	self:UpdateView()
end

function m:Close()
	self.View:SetActive(false)
	self:RemoveListener()
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.groupCells) do
		self.groupCellPool:Release(v)
	end

	self.groupCells = {}

	self.groupCellPool:Dispose()

	self.groupCellPool = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
