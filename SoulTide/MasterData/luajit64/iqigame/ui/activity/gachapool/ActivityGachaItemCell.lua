-- chunkname: @IQIGame\\UI\\Activity\\GachaPool\\ActivityGachaItemCell.lua

local m = {
	hasGot = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlotUIPrefab, true, true, true)

	UGUIUtil.SetTextInChildren(self.GotView, ActivityUIApi:GetString("GachaRewardGotViewText"))
end

function m:SetData(cfgGachaPoolRewardData, getRewards, isRefresh)
	self.CfgGachaPoolRewardData = cfgGachaPoolRewardData
	self.hasGot = table.indexOf(getRewards, cfgGachaPoolRewardData.Id) ~= -1

	self.GotView:SetActive(self.hasGot)
	self.TagGacha:SetActive(cfgGachaPoolRewardData.Mark)

	local alpha = cfgGachaPoolRewardData.Mark and 0.5 or 1

	EntityShowUtil.SetAlpha(self.TagGacha, alpha)

	if isRefresh then
		self.ItemCell:SetItemByCID(cfgGachaPoolRewardData.RefreshReward[1], cfgGachaPoolRewardData.RefreshReward[2])
	else
		self.ItemCell:SetItemByCID(cfgGachaPoolRewardData.Reward[1], cfgGachaPoolRewardData.Reward[2])
	end
end

function m:SetRefreshShowData(cfgGachaPoolRewardData)
	self.GotView:SetActive(false)
	self.TagGacha:SetActive(cfgGachaPoolRewardData.Mark)
	self.ItemCell:SetItemByCID(cfgGachaPoolRewardData.RefreshReward[1], cfgGachaPoolRewardData.RefreshReward[2])
end

function m:PlayEffect()
	local effectCid = 9003802

	if self.CfgGachaPoolRewardData.Rare == 1 then
		effectCid = 9003801
	end

	GameEntry.Effect:PlayUIMountPointEffect(effectCid, 50000, 0, self.View, Constant.Unity.SortingOrderMaxValue - 1)
end

function m:Dispose()
	self.ItemCell:Dispose()

	self.ItemCell = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.CfgGachaPoolRewardData = nil
end

return m
