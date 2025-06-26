-- chunkname: @IQIGame\\Module\\HomeLandProcess\\HomeLandProcessData.lua

HomeLandProcessData = {}

function HomeLandProcessData.New()
	local o = Clone(HomeLandProcessData)

	return o
end

function HomeLandProcessData:Init(cid, unLock)
	self.cid = cid
	self.unlock = unLock
	self.cfgInfo = CfgHomeLandPropsProcessingTable[self.cid]
end

return HomeLandProcessData
