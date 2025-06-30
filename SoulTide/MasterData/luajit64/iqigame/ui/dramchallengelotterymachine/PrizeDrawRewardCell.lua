-- chunkname: @IQIGame\\UI\\DramChallengeLotteryMachine\\PrizeDrawRewardCell.lua

local m = {
	RemainingNum = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(view, self)

	self.RewardNumText = self.RewardNum:GetComponent("Text")
	self.IconImg = self.Icon:GetComponent("Image")
	self.ItemCell = ItemCell.New(self.CommonSlotUI)
end

function m:SetItem(itemData)
	self.View:SetActive(itemData ~= nil)

	if itemData == nil then
		return
	end

	self.RewardNumText.text = DramChallengeLotteryUIApi:GetString("RewardCountText", itemData.CurrentItemTime, itemData.ItemTime)
	self.itemData = itemData

	self.ItemCell:SetItemByCID(itemData.Id, itemData.ItemNum)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
