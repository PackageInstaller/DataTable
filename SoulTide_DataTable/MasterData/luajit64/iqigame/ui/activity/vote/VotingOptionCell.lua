-- chunkname: @IQIGame\\UI\\Activity\\Vote\\VotingOptionCell.lua

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

function m:SetData(cfgData, poll)
	self.cfgVotingOptionData = cfgData

	UGUIUtil.SetText(self.TextNameDown, self.cfgVotingOptionData.Title)
	UGUIUtil.SetText(self.TextNameUp, self.cfgVotingOptionData.Title)
	UGUIUtil.SetText(self.TextValue, poll)
end

function m:SetSelect(top)
	self.goDown:SetActive(not top)
	self.goUp:SetActive(top)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
