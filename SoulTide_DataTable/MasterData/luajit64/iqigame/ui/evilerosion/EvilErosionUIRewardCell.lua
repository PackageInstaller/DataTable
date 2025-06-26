-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionUIRewardCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlotUI, true, true, true)
end

function m:SetData(itemCid, itemNum)
	self.View:SetActive(itemCid ~= 0)

	if itemCid == 0 then
		return
	end

	self.ItemCell:SetItemByCID(itemCid, 1)
	UGUIUtil.SetText(self.NumText, EvilErosionUIApi:GetString("RewardCell_NumText", itemNum))
end

function m:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
