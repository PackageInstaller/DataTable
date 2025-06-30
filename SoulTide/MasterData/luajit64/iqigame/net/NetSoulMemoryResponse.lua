-- chunkname: @IQIGame\\Net\\NetSoulMemoryResponse.lua

function net_soulMemory.notifySoulMemoryDressProgress(soulCid, memoryDressProgress)
	GirlModule.UpdateSoulMemoryDressProgress(soulCid, memoryDressProgress)

	if MemoryModule.currentSoulID == soulCid then
		MemoryModule.GetSoulMemoryDressProgressResult()
	end
end

function net_soulMemory.notifyUpdateSoulMemoryChapter(soulMemoryChapter)
	MemoryModule.SetSoulMemoryChapterResult(MemoryModule.currentSoulID, soulMemoryChapter)
	MemoryModule.UpdateSoulMemoryChapter(MemoryModule.currentSoulID, soulMemoryChapter)
end

function net_soulMemory.activeMemoryPieceResult(code, chapterCid, pieceCid, soulMemoryChapter)
	MemoryModule.ActiveMemoryFragmentResult(chapterCid, pieceCid, soulMemoryChapter)
end

function net_soulMemory.experienceMemoryResult(code, chapterCid)
	MemoryModule.ExperienceMemoryResult(chapterCid)
end

function net_soulMemory.getRewardsResult(code, chapterCid, showRewards, soulMemoryChapter, newSoulMemoryChapter)
	MemoryModule.GetRewardsResultResult(chapterCid, showRewards, soulMemoryChapter, newSoulMemoryChapter)
end

function net_soulMemory.viewMemoryResult(code)
	return
end
