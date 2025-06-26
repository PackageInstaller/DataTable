-- chunkname: @IQIGame\\UI\\Dreamland\\DreamlandSpeRewardCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.ItemCellGO, true, true)
end

function m:SetData(cfgDreamMapSPRewardDataData)
	local cfgItemData = CfgItemTable[cfgDreamMapSPRewardDataData.RewardID]

	self.ItemCell:SetItemByCID(cfgDreamMapSPRewardDataData.RewardID, cfgDreamMapSPRewardDataData.RewardNum)
	UGUIUtil.SetText(self.NameText, cfgItemData.Name)

	local hasCount = DreamlandModule.DailyDupPOD.dreamMapPOD.spRewardsCount[cfgDreamMapSPRewardDataData.Id]

	if hasCount == nil then
		hasCount = 0
	end

	UGUIUtil.SetText(self.ProgressText, DreamlandRewardListUIApi:GetString("RewardProgressText", hasCount, cfgDreamMapSPRewardDataData.DropLimit))
end

function m:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
