-- chunkname: @IQIGame\\UI\\RoleDevelopment\\ItemCell\\AttrGrowupItemCell.lua

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

function m:SetData(dataTable)
	self.lastGradeImg.gameObject:SetActive(false)
	self.presentGradeImg.gameObject:SetActive(false)
	UGUIUtil.SetText(self.attNameText, CfgAttributeTable[dataTable.type].Name)
	UGUIUtil.SetText(self.lastNumText, dataTable.lastValue)
	UGUIUtil.SetText(self.presentNumText, dataTable.newValue)
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
