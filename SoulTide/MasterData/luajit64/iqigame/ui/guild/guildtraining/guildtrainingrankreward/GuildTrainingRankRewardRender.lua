-- chunkname: @IQIGame\\UI\\Guild\\GuildTraining\\GuildTrainingRankReward\\GuildTrainingRankRewardRender.lua

local m = {
	TrainingRankRewardCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local GuildTrainingRankRewardCell = require("IQIGame.UI.Guild.GuildTraining.GuildTrainingRankReward.GuildTrainingRankRewardCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.RewardMould:SetActive(false)

	self.TrainingRankRewardCellPool = UIObjectPool.New(4, function()
		return GuildTrainingRankRewardCell.New(UnityEngine.Object.Instantiate(self.RewardMould))
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.cfgData = data

	self:UpdateView()
end

function m:UpdateView()
	UGUIUtil.SetText(self.RankText, self.cfgData.Id)

	local path = UIGlobalApi.GetImagePath(self.cfgData.Image)

	AssetUtil.LoadImage(self, path, self.RankIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.RankText, self.cfgData.Desc)

	for i, v in pairs(self.TrainingRankRewardCells) do
		self.TrainingRankRewardCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
	end

	self.TrainingRankRewardCells = {}

	for i = 1, #self.cfgData.RewardShow, 2 do
		local itemID = self.cfgData.RewardShow[i]
		local itemNum = self.cfgData.RewardShow[i + 1]

		if CfgItemTable[itemID].IsPanelShow then
			local itemCell = self.TrainingRankRewardCellPool:Obtain()

			itemCell.View:SetActive(true)
			itemCell.View.transform:SetParent(self.RewardNode.transform, false)
			itemCell:SetData(itemID, itemNum)
			table.insert(self.TrainingRankRewardCells, itemCell)
		end
	end
end

function m:Dispose()
	for i = 1, #self.TrainingRankRewardCells do
		local cell = self.TrainingRankRewardCells[i]

		cell.View:SetActive(false)
		self.TrainingRankRewardCellPool:Release(cell)
	end

	self.TrainingRankRewardCells = {}

	self.TrainingRankRewardCellPool:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
