-- chunkname: @IQIGame\\Net\\ChapterNet\\NetBossChapterResponse.lua

function net_bossDup.notifyDup(dupPODs)
	BossChapterModule.NotifyDup(dupPODs)
end

function net_bossDup.enterDupResult(code)
	GameChapterModule.EnterDup(Constant.ChapterPassType.TYPE_BOSS)
end

function net_bossDup.notifyDupComplete(star, shows)
	GameChapterModule.NotifyDupComplete(star, shows)
end
