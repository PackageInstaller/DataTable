-- chunkname: @IQIGame\\UI\\Activity\\LuckyTurnTable\\LuckyTurnHistoryItemCell.lua

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

function m:SetData(LuckDrawHistoryPOD)
	local cfgItemData = CfgItemTable[LuckDrawHistoryPOD.itemCid]

	UGUIUtil.SetText(self.NameText, DailyHistoryListUIApi:GetString("NameText", cfgItemData.Name, LuckDrawHistoryPOD.itemNum))
	UGUIUtil.SetText(self.TimeText, getDateTimeText(LuckDrawHistoryPOD.time))
	self.QualityImage0:SetActive(cfgItemData.Quality < 4)
	self.QualityImage4:SetActive(cfgItemData.Quality == 4)
	self.QualityImage5:SetActive(cfgItemData.Quality == 5)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
