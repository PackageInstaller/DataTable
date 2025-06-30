-- chunkname: @IQIGame\\Net\\NetSoulNewStoryResponse.lua

function net_soulNewStory.experienceNewStoryChapterResult(code, storyCid, chapterIndex)
	MemoryNewModule.ExperienceNewStoryChapterResult(storyCid, chapterIndex)
end

function net_soulNewStory.notifyCompleteNewStoryChapter(soulNewStory, showRewards, beginFavorLv, beginFavor, endFavorLv, endFavor)
	MemoryNewModule.NotifyCompleteNewStoryChapter(soulNewStory, showRewards, beginFavorLv, beginFavor, endFavorLv, endFavor)
end

function net_soulNewStory.notifyUpdateSoulNewStory(soulNewStory)
	MemoryNewModule.UpdateSoulNewStory(soulNewStory)
end
