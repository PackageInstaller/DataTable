-- chunkname: @IQIGame\\UI\\ActivityPassUI\\highRewardScrollItem.lua

local highRewardScrollItem = {}

function highRewardScrollItem.New(go)
	local o = Clone(highRewardScrollItem)

	o:Initialize(go)

	return o
end

function highRewardScrollItem:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function highRewardScrollItem:InitComponent()
	self.cellNormal = ItemCell.New(self.Item.gameObject, true, true)
end

function highRewardScrollItem:InitDelegate()
	return
end

function highRewardScrollItem:AddListener()
	return
end

function highRewardScrollItem:RemoveListener()
	return
end

function highRewardScrollItem:Refresh(Data)
	local cfgItemData = CfgUtil.GetItemCfgDataWithID(Data.cid)

	LuaUtility.SetGameObjectShow(self.subscript, Data.subscriptShow)
	self.cellNormal:SetItemByCid(Data.cid)

	if Data.num > 0 then
		self.cellNormal:SetNum(Data.num)
	end
end

function highRewardScrollItem:Dispose()
	self.cellNormal:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return highRewardScrollItem
