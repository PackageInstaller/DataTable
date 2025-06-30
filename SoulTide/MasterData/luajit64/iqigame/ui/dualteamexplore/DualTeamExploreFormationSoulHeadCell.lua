-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamExploreFormationSoulHeadCell.lua

local m = {
	m_IsRepetitive = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.SoulHeadCell = SoulHeadCell.New(self.SoulHeadGO)

	self.SoulHeadCell:SetMouseEnabled(false)
	UGUIUtil.SetTextInChildren(self.RepeatTag, DualTeamExploreLevelFormationUIApi:GetString("SoulHead_RepeatTagText"))
end

function m:SetData(soulData, isRepetitive)
	self.m_IsRepetitive = isRepetitive

	self.EmptyView:SetActive(soulData == nil)
	self.RepeatTag:SetActive(soulData ~= nil and isRepetitive)

	if soulData == nil then
		return
	end

	self.SoulHeadCell:RefreshView(soulData)
end

function m:IsRepetitive()
	return self.m_IsRepetitive
end

function m:Dispose()
	self.SoulHeadCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
