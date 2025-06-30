-- chunkname: @IQIGame\\UI\\EndlessMazeRune\\EndlessMazeRuneLegendSuitEffectItem.lua

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

function m:SetData(index, cid)
	local cfgLegendConstituteData = CfgLegendConstituteTable[cid]
	local buffTexts = {}

	for i = 1, #cfgLegendConstituteData.Buff do
		local buffCid = cfgLegendConstituteData.Buff[i]

		if buffCid ~= 0 then
			local cfgBuffData = CfgBuffTable[buffCid]

			table.insert(buffTexts, cfgBuffData.Describe)
		end
	end

	UGUIUtil.SetText(self.View, EndlessMazeRuneLegendSuitTipUIApi:GetString("SuitEffectText", index, buffTexts))
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
