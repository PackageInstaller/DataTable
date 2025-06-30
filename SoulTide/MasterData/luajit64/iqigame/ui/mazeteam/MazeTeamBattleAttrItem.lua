-- chunkname: @IQIGame\\UI\\MazeTeam\\MazeTeamBattleAttrItem.lua

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

function m:SetData(attrId, valueText)
	UGUIUtil.SetText(self.LabelText, SoulUIApi:GetString("attViewAttValue", AttributeModule.GetAttName(attrId)))
	UGUIUtil.SetText(self.ValueText, valueText)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
