-- chunkname: @IQIGame\\UI\\SoulMarry\\SoulMarryConfirm\\SoulMarryConfirmRenderCell.lua

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

function m:SetData(cfgSoulMarry, state)
	self.cfgSoulMarry = cfgSoulMarry
	self.state = state

	local value = GirlModule.soulOathPOD.dateData[self.state]

	self.View:SetActive(tonumber(value) > 0)
	UGUIUtil.SetText(self.TextTime, SoulMarryConfirmUIApi:GetString("TextTime", getDateTimeMText(GirlModule.soulOathPOD.dateData[self.state] / 1000), tonumber(value), self.state))

	local str = cfgSoulMarry["FavorStage" .. self.state]

	if PlayerModule.PlayerInfo.baseInfo.pName ~= nil then
		str = string.gsub(str, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)
	end

	UGUIUtil.SetText(self.TextMsg, str)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
