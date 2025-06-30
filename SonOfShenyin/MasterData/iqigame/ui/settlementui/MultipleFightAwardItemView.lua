-- chunkname: @IQIGame\\UI\\SettlementUI\\MultipleFightAwardItemView.lua

local MultipleFightAwardItemView = {
	itemCells = {}
}

function MultipleFightAwardItemView.New(go, mainView)
	local o = Clone(MultipleFightAwardItemView)

	o:Initialize(go, mainView)

	return o
end

function MultipleFightAwardItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MultipleFightAwardItemView:InitComponent()
	self.rewardScollWarp = self.itemsRoot:GetComponent("ScrollAreaList")

	function self.rewardScollWarp.onRenderCell(cell)
		self:__OnRenderCell(cell)
	end
end

function MultipleFightAwardItemView:InitDelegate()
	return
end

function MultipleFightAwardItemView:AddListener()
	return
end

function MultipleFightAwardItemView:RemoveListener()
	return
end

function MultipleFightAwardItemView:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function MultipleFightAwardItemView:Show(index, data)
	local expNum = 0

	self.rewardItems = {}

	ForPairs(data.awards, function(_, awardItem)
		if awardItem.cid == Constant.ItemCid.Exp then
			expNum = expNum + awardItem.num

			return
		end

		table.insert(self.rewardItems, awardItem)
	end)
	table.sort(self.rewardItems, function(awardItem1, awardItem2)
		return CfgItemTable[awardItem1.cid].Quality > CfgItemTable[awardItem2.cid].Quality
	end)
	self.rewardScollWarp:Refresh(#self.rewardItems)

	self.titleText.gameObject:GetComponent("Text").text = GameLevelEndUIApi:GetUnitAwardTitle(index)
	self.expText.gameObject:GetComponent("Text").text = GameLevelEndUIApi:GetUnitAwardExpText(expNum)
end

function MultipleFightAwardItemView:__OnRenderCell(cell)
	local insID = cell.gameObject:GetInstanceID()
	local item = self.itemCells[insID]

	if item == nil then
		item = ItemCell.New(cell.gameObject, true, true, true)
		self.itemCells[insID] = item
	end

	local index = cell.index + 1
	local awardItem = self.rewardItems[index]
	local itemData = WarehouseModule.GetItemDataById(awardItem.id)

	if itemData ~= nil then
		item:SetItem(itemData)
		item:SetTag(awardItem.tag)
		item:SetNum(awardItem.num)
	end
end

function MultipleFightAwardItemView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function MultipleFightAwardItemView:Dispose()
	for k, v in pairs(self.itemCells) do
		v:Dispose()
	end

	self.itemCells = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function MultipleFightAwardItemView:Refresh(Data)
	return
end

return MultipleFightAwardItemView
