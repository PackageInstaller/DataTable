-- chunkname: @IQIGame\\UI\\EndlessMazeRune\\EndlessMazeRuneSuitEffectItem.lua

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

function m:SetData(needNum, isActive, activeBuff, activeAttr)
	local buffText, attrNames, attrValues

	if activeBuff ~= 0 then
		local cfgBuffData = CfgBuffTable[activeBuff]

		buffText = cfgBuffData.Describe
	else
		attrNames = {}
		attrValues = {}

		for i = 1, #activeAttr, 2 do
			local attrId = activeAttr[i]
			local attrValue = activeAttr[i + 1]

			table.insert(attrNames, AttributeModule.GetAttName(attrId))
			table.insert(attrValues, AttributeModule.GetAttShowValue(attrId, attrValue))
		end
	end

	UGUIUtil.SetText(self.View, EndlessMazeRuneSuitTipUIApi:GetString("SuitEffectText", needNum, isActive, buffText, attrNames, attrValues))
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
