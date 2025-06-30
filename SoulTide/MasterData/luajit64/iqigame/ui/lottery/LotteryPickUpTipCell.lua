-- chunkname: @IQIGame\\UI\\Lottery\\LotteryPickUpTipCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.SoulHeadCell = SoulHeadCell.New(self.SoulHead, false, false)
	self.ItemCell = ItemCell.New(self.CommonSlotUI, false)
end

function m:SetData(type, cid, typeIconPath)
	self.SoulHeadCell.goView:SetActive(type == 1)
	self.ItemCell.ViewGo:SetActive(type ~= 1)

	local name

	if type == 1 then
		local soulData = SoulData.New()

		soulData:Initialize(cid)
		self.SoulHeadCell:RefreshView(soulData)

		name = soulData:GetCfgSoul().Name
	else
		self.ItemCell:SetItemByCID(cid, 1)

		name = self.ItemCell.ItemCfgOrData.Name
	end

	UGUIUtil.SetText(self.ItemNameText, name)
	AssetUtil.LoadImage(self, typeIconPath, self.TypeIcon:GetComponent("Image"))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self.SoulHeadCell:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
