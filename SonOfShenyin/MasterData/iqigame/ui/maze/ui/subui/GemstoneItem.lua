-- chunkname: @IQIGame\\UI\\Maze\\UI\\SubUI\\GemstoneItem.lua

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

function m:SetData(attrType, attrValue)
	local attrCfg = CfgAttributeTable[attrType]
	local showValue = attrValue

	if attrCfg.IsPer then
		showValue = showValue * 100 .. "%"
	end

	UGUIUtil.SetText(self.buffText, attrCfg.Name .. "+" .. showValue)
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
