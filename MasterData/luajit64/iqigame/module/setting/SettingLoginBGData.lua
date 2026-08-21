-- chunkname: @IQIGame\\Module\\Setting\\SettingLoginBGData.lua

SettingLoginBGData = {}

function SettingLoginBGData.New(cfgID, isLock)
	local o = Clone(SettingLoginBGData)

	o:Init(cfgID, isLock)

	return o
end

function SettingLoginBGData:Init(cfgID, isLock)
	self.cfgID = cfgID
	self.cfgInfo = CfgLoginBGTable[self.cfgID]
	self.isLock = isLock
end

return SettingLoginBGData
