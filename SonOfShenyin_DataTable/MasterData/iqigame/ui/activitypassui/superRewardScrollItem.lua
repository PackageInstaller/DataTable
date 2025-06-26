-- chunkname: @IQIGame\\UI\\ActivityPassUI\\superRewardScrollItem.lua

local superRewardScrollItem = {}

function superRewardScrollItem.New(go)
	local o = Clone(superRewardScrollItem)

	o:Initialize(go)

	return o
end

function superRewardScrollItem:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function superRewardScrollItem:InitComponent()
	self.cellNormal = ItemCell.New(self.Item.gameObject)
end

function superRewardScrollItem:InitDelegate()
	return
end

function superRewardScrollItem:AddListener()
	return
end

function superRewardScrollItem:RemoveListener()
	return
end

function superRewardScrollItem:Refresh(Data)
	local cfgItemData = CfgUtil.GetItemCfgDataWithID(Data.cid)

	LuaUtility.SetGameObjectShow(self.subscript, Data.subscriptShow)
	self.cellNormal:SetItemByCid(Data.cid)

	if Data.num > 0 then
		self.cellNormal:SetNum(Data.num)
	end
end

function superRewardScrollItem:Dispose()
	self.cellNormal:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return superRewardScrollItem
