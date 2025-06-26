-- chunkname: @IQIGame\\Module\\Setting\\SettingPlayerHeadFrameData.lua

SettingPlayerHeadFrameData = {}

function SettingPlayerHeadFrameData.New(cfgID, isLock)
	local o = Clone(SettingPlayerHeadFrameData)

	o:Init(cfgID, isLock)

	return o
end

function SettingPlayerHeadFrameData:Init(cfgID, isLock)
	self.cfgID = cfgID
	self.cfgInfo = CfgPlayerAvatarFrameTable[self.cfgID]
	self.isLock = isLock
end

function SettingPlayerHeadFrameData:GetTimeLimit()
	if PlayerModule.PlayerInfo.avatarFrameTimelimit then
		for i, v in pairs(PlayerModule.PlayerInfo.avatarFrameTimelimit) do
			if i == self.cfgID then
				return v
			end
		end
	end

	return -1
end

return SettingPlayerHeadFrameData
