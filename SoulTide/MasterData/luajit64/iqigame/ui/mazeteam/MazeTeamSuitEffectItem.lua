-- chunkname: @IQIGame\\UI\\MazeTeam\\MazeTeamSuitEffectItem.lua

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

function m:SetData(pabilityCid, hasNum, needNum)
	local cfgPabilityData = CfgPabilityTable[pabilityCid]

	UGUIUtil.SetText(self.View, RpgMazeTeamUIApi:GetString("SuitEffectDescText", cfgPabilityData.Describe, needNum <= hasNum))
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
