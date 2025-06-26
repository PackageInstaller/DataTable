-- chunkname: @IQIGame\\UI\\ActivityPassUI\\levelRewardScrollItem.lua

local levelRewardScrollItem = {}

function levelRewardScrollItem.New(go)
	local o = Clone(levelRewardScrollItem)

	o:Initialize(go)

	return o
end

function levelRewardScrollItem:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function levelRewardScrollItem:InitComponent()
	self.cellItem = ExtendItemCellOne.New(self.Item.gameObject)
end

function levelRewardScrollItem:InitDelegate()
	return
end

function levelRewardScrollItem:AddListener()
	return
end

function levelRewardScrollItem:RemoveListener()
	return
end

function levelRewardScrollItem:Refresh(data)
	self.Data = data

	self.cellItem:SetAwardData(self.Data.ItemData, self.Data.ActionParam[2])
end

function levelRewardScrollItem:Dispose()
	self.cellItem:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return levelRewardScrollItem
