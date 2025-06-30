-- chunkname: @IQIGame\\UI\\ChallengeTower\\TowerRewardCell.lua

local TowerRewardCell = {}

function TowerRewardCell.New(view, itemCellGo)
	local obj = Clone(TowerRewardCell)

	obj:Init(view, itemCellGo)

	return obj
end

function TowerRewardCell:Init(view, itemCellGo)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextFlag, ChallengeTowerLastRewardUIApi:GetString("TextFlag"))
	itemCellGo.transform:SetParent(self.ItemCellNode.transform, false)

	self.ItemCell = ItemCell.New(itemCellGo)
end

function TowerRewardCell:SetData(itemCid, itemNum, isFirstPassReward)
	self.View:SetActive(itemCid ~= 0)
	self.ItemCell:SetItemByCID(itemCid, itemNum)
	self.FirstPassFlag:SetActive(isFirstPassReward)
end

function TowerRewardCell:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return TowerRewardCell
