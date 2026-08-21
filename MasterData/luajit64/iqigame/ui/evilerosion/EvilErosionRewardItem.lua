-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionRewardItem.lua

local EvilErosionUIRewardCell = require("IQIGame.UI.EvilErosion.EvilErosionUIRewardCell")
local m = {
	RewardCells = {}
}

function m.New(view, rewardMaxNum)
	local obj = Clone(m)

	obj:Init(view, rewardMaxNum)

	return obj
end

function m:Init(view, rewardMaxNum)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.RewardPrefab:SetActive(true)

	for i = 1, rewardMaxNum do
		local cell = EvilErosionUIRewardCell.New(UnityEngine.Object.Instantiate(self.RewardPrefab))

		cell.View.transform:SetParent(self.RewardGrid.transform, false)
		table.insert(self.RewardCells, cell)
	end

	self.RewardPrefab:SetActive(false)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(cfgEvilErosionRewardData)
	AssetUtil.LoadImage(self, EvilErosionUIApi:GetString("RatingImage", cfgEvilErosionRewardData.RewardLevel), self.RatingImage:GetComponent("Image"))
	UGUIUtil.SetText(self.TimeText, EvilErosionUIApi:GetString("RewardItem_TimeText", cfgEvilErosionRewardData.TimeLimit))

	for i = 1, #self.RewardCells do
		local cell = self.RewardCells[i]
		local itemCid = cfgEvilErosionRewardData.Rewards[(i - 1) * 2 + 1]
		local itemNum = cfgEvilErosionRewardData.Rewards[(i - 1) * 2 + 2]

		if itemCid == nil then
			itemCid = 0
			itemNum = 0
		end

		cell:SetData(itemCid, itemNum)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()

	for i = 1, #self.RewardCells do
		local cell = self.RewardCells[i]

		cell:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
