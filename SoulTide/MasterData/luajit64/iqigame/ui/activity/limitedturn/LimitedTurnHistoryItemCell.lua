-- chunkname: @IQIGame\\UI\\Activity\\LimitedTurn\\LimitedTurnHistoryItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(limitTurnTableHistoryPOD)
	local cfgLimitedTurntableGroupData = CfgLimitedTurntableGroupTable[limitTurnTableHistoryPOD.rewardId]
	local cfgItemData = CfgItemTable[cfgLimitedTurntableGroupData.Reward[1]]

	UGUIUtil.SetText(self.NameText, LimitedTurnHistoryListUIApi:GetString("NameText", cfgItemData.Name, cfgLimitedTurntableGroupData.Reward[2]))
	UGUIUtil.SetText(self.TimeText, getDateTimeText(limitTurnTableHistoryPOD.time))
	self.QualityImage0:SetActive(cfgItemData.Quality < 4)
	self.QualityImage4:SetActive(cfgItemData.Quality == 4)
	self.QualityImage5:SetActive(cfgItemData.Quality == 5)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
