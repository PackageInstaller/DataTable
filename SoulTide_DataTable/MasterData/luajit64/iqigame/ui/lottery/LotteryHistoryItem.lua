-- chunkname: @IQIGame\\UI\\Lottery\\LotteryHistoryItem.lua

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

function m:SetData(historyPOD)
	local cfgItemData = CfgItemTable[historyPOD.itemCid]
	local isSoulItem, soulCid = ItemModule.IsSoulItem(cfgItemData)

	UGUIUtil.SetText(self.TypeText, LotteryHistoryUIApi:GetString("TypeText", isSoulItem, cfgItemData.Type))
	UGUIUtil.SetText(self.NameText, LotteryHistoryUIApi:GetString("NameText", cfgItemData.Name, historyPOD.itemNum, isSoulItem, cfgItemData.Type))
	UGUIUtil.SetText(self.TimeText, getDateTimeText(historyPOD.time))
	self.QualityImage0:SetActive(cfgItemData.Quality < 4)
	self.QualityImage4:SetActive(cfgItemData.Quality == 4)
	self.QualityImage5:SetActive(cfgItemData.Quality == 5)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
