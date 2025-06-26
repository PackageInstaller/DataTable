-- chunkname: @IQIGame\\UI\\ExploreHall\\Survival\\SurvivalFlyGameSettlement\\SurvivalFlyGameSettlementEndlessView.lua

local m = {
	rewards = {},
	rewardCellPool = {}
}
local SurvivalFlyGameSettlementRewardCell = require("IQIGame.UI.ExploreHall.Survival.SurvivalFlyGameSettlement.SurvivalFlyGameSettlementRewardCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.RewardScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:OnRenderGridCell(cell)
	local data = self.rewards[cell.index + 1]

	if data == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.rewardCellPool[instanceID]

	if renderCell == nil then
		renderCell = SurvivalFlyGameSettlementRewardCell.New(cell.gameObject)
		self.rewardCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data)
end

function m:SetData(items, bossNum)
	self.rewards = items

	UGUIUtil.SetText(self.TextBossNum, bossNum)
	self.RewardScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.rewards)
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
