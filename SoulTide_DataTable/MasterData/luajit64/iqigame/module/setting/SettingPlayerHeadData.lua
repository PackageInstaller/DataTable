-- chunkname: @IQIGame\\Module\\Setting\\SettingPlayerHeadData.lua

SettingPlayerHeadData = {}

function SettingPlayerHeadData.New(cfgID, isLock)
	local o = Clone(SettingPlayerHeadData)

	o:Init(cfgID, isLock)

	return o
end

function SettingPlayerHeadData:Init(cfgID, isLock)
	self.cfgID = cfgID
	self.cfgInfo = CfgPlayerHeadIconTable[self.cfgID]
	self.isLock = isLock
end

function SettingPlayerHeadData:GetTimeLimit()
	if PlayerModule.PlayerInfo.headIconTimelimit then
		for i, v in pairs(PlayerModule.PlayerInfo.headIconTimelimit) do
			if i == self.cfgID then
				return v
			end
		end
	end

	return -1
end

return SettingPlayerHeadData
