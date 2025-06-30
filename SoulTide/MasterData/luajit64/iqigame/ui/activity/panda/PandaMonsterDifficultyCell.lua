-- chunkname: @IQIGame\\UI\\Activity\\Panda\\PandaMonsterDifficultyCell.lua

local m = {
	selected = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(data, operateEventID)
	self.cfgPandaMonsterListData = data
	self.operateEventID = operateEventID

	UGUIUtil.SetText(self.TextDown, PandaChallengeDetailInfoUIApi:GetString("TextDifficulty", self.cfgPandaMonsterListData.Difficulty))
	UGUIUtil.SetText(self.TextUp, PandaChallengeDetailInfoUIApi:GetString("TextDifficulty", self.cfgPandaMonsterListData.Difficulty))
	UGUIUtil.SetText(self.TextMsg, PandaChallengeDetailInfoUIApi:GetString("TextMsg"))
	self:SetSelect(self.selected)
end

function m:SetSelect(top)
	self.selected = top

	self.nodeDown:SetActive(not self.selected)
	self.nodeUp:SetActive(self.selected)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
