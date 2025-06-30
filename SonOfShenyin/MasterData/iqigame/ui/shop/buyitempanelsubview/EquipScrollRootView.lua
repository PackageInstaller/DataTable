-- chunkname: @IQIGame\\UI\\Shop\\BuyItemPanelSubView\\EquipScrollRootView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(itemCfg)
	local equipCfg = CfgEquipTable[itemCfg.LikeId]
	local suitId = equipCfg.SuitId[1]
	local normaleSuitConfigs = EquipModule.GetSuitNeedCount(suitId, Constant.Equip.SuitType.Normal)
	local awakenSuitConfigs = EquipModule.GetSuitNeedCount(suitId, Constant.Equip.SuitType.Awaken)

	LuaUtility.SetGameObjectShow(self.normalTitle, #normaleSuitConfigs > 0)
	LuaUtility.SetGameObjectShow(self.suitDetailInfoText, #normaleSuitConfigs > 0)
	LuaUtility.SetGameObjectShow(self.awakenTitle, #awakenSuitConfigs > 0)
	LuaUtility.SetGameObjectShow(self.suitDetailInfoText, #awakenSuitConfigs > 0)

	local normalDesc = ""

	for i = 1, #normaleSuitConfigs do
		normalDesc = normalDesc .. normaleSuitConfigs[i].EquipTips .. "\n"
	end

	UGUIUtil.SetText(self.suitDetailInfoText, normalDesc)

	local awakenDesc = ""

	for i = 1, #awakenSuitConfigs do
		awakenDesc = awakenDesc .. awakenSuitConfigs[i].EquipTips .. "\n"
	end

	UGUIUtil.SetText(self.awakenDetailInfoText, awakenDesc)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
