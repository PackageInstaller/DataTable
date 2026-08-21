-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameRankReward\\PlaceGameRankRewardCell.lua

local m = {
	rankRewardCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.RewardMould:SetActive(false)

	self.rankRewardCellPool = UIObjectPool.New(4, function()
		return ItemCell.New(UnityEngine.Object.Instantiate(self.RewardMould))
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

function m:SetData(data, index)
	self.cfgData = data
	self.index = index

	self:UpdateView()
end

function m:UpdateView()
	local tog = self.index % 2
	local isSow = tog == 1

	self.BgOdd:SetActive(isSow)
	self.BgEven:SetActive(not isSow)

	local isShowImgNum = false

	for i = 1, 3 do
		local numTransform = self.Num123.transform:Find("Image_" .. i)

		if numTransform then
			numTransform.gameObject:SetActive(i == self.index)
		end

		if isShowImgNum == false then
			isShowImgNum = i == self.index
		end
	end

	self.RankingText:SetActive(not isShowImgNum)
	self.ImgIcon:SetActive(not isShowImgNum)
	UGUIUtil.SetText(self.RankingText, PlaceGameRankRewardUIApi:GetString("TextRewardIndex", self.cfgData.RankLowerLimit, self.cfgData.RankUpperLimit, self.cfgData.RankType))

	if not isShowImgNum then
		local path = UIGlobalApi.GetImagePath(self.cfgData.Image)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	end

	for i, v in pairs(self.rankRewardCells) do
		self.rankRewardCellPool:Release(v)
		v.ViewGo:SetActive(false)
		v.ViewGo.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
	end

	self.rankRewardCells = {}

	for i = 1, #self.cfgData.Reward, 2 do
		local itemID = self.cfgData.Reward[i]
		local itemNum = self.cfgData.Reward[i + 1]

		if CfgItemTable[itemID].IsPanelShow then
			local itemCell = self.rankRewardCellPool:Obtain()

			itemCell.ViewGo:SetActive(true)
			itemCell.ViewGo.transform:SetParent(self.RewardGrid.transform, false)
			itemCell:SetItemByCID(itemID, itemNum)
			table.insert(self.rankRewardCells, itemCell)
		end
	end
end

function m:Dispose()
	for i, v in pairs(self.rankRewardCells) do
		self.rankRewardCellPool:Release(v)
	end

	self.rankRewardCells = {}

	self.rankRewardCellPool:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
