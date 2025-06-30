-- chunkname: @IQIGame\\Module\\Setting\\SettingPlayerTitleData.lua

SettingPlayerTitleData = {}

function SettingPlayerTitleData.New(cfgID, isLock)
	local o = Clone(SettingPlayerTitleData)

	o:Init(cfgID, isLock)

	return o
end

function SettingPlayerTitleData:Init(cfgID, isLock)
	self.cfgID = cfgID
	self.cfgInfo = CfgPlayerCoatOfArmsTable[self.cfgID]
	self.isLock = isLock
end

function SettingPlayerTitleData:GetTimeLimit()
	if PlayerModule.PlayerInfo.titleTimelimit then
		for i, v in pairs(PlayerModule.PlayerInfo.titleTimelimit) do
			if i == self.cfgID then
				return v
			end
		end
	end

	return -1
end

return SettingPlayerTitleData
