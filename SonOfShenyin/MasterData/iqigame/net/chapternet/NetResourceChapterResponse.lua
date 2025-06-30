-- chunkname: @IQIGame\\Net\\ChapterNet\\NetResourceChapterResponse.lua

function net_dailyDup.notifyDup(dupPODs)
	ResourceChapterModule.NotifyDup(dupPODs)
end

function net_dailyDup.enterDupResult(code)
	log("进入资源副本--")
	GameChapterModule.EnterDup(Constant.ChapterPassType.TYPE_RESOURCES)
end

function net_dailyDup.sweepDupResult(code, shows)
	EquipChapterModule.SweepDupSucceed(code, shows)
end

function net_dailyDup.notifyDupComplete(star, shows)
	GameChapterModule.NotifyDupComplete(star, shows)
end
