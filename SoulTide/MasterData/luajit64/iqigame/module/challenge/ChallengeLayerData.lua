-- chunkname: @IQIGame\\Module\\Challenge\\ChallengeLayerData.lua

ChallengeLayerData = {}

function ChallengeLayerData.New(cfgID, isLock)
	local o = Clone(ChallengeLayerData)

	o:Init(cfgID, isLock)

	return o
end

function ChallengeLayerData:Init(cfgID, isLock)
	self.cfgID = cfgID
	self.cfgInfo = CfgChallengeLayerTable[cfgID]
	self.isLock = isLock
end

return ChallengeLayerData
