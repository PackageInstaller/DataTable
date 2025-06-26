-- chunkname: @IQIGame\\Module\\Memory\\MemoryChapterInfo.lua

MemoryChapterInfo = {
	isNew = false,
	arrUnlockPiecesCidsList = {}
}

function MemoryChapterInfo.New()
	local cloneObj = Clone(MemoryChapterInfo)

	return cloneObj
end

function MemoryChapterInfo:Initialize(soulMemoryChapterPOD)
	self.cid = soulMemoryChapterPOD.cid
	self.arrUnlockPiecesCidsList = soulMemoryChapterPOD.unlockPieceCids
	self.isGetReward = soulMemoryChapterPOD.isGetReward
	self.isExperience = soulMemoryChapterPOD.isExperience
	self.cfgChapter = CfgSoulMemoryChapterTable[soulMemoryChapterPOD.cid]
	self.isNew = soulMemoryChapterPOD.isNew
end
