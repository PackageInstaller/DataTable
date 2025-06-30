-- chunkname: @IQIGame\\Net\\ChapterNet\\NetEquipChapterResponse.lua

function net_equipDup.notifyDup(dupPODs)
	EquipChapterModule.NotifyDup(dupPODs)
end

function net_equipDup.enterDupResult(code)
	GameChapterModule.EnterDup(Constant.ChapterPassType.TYPE_EQUIP)
end

function net_equipDup.sweepDupResult(code, shows)
	EquipChapterModule.SweepDupSucceed(code, shows)
end

function net_equipDup.notifyDupComplete(star, shows)
	GameChapterModule.NotifyDupComplete(star, shows)
end
