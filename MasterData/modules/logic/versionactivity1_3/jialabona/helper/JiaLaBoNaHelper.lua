-- chunkname: @modules/logic/versionactivity1_3/jialabona/helper/JiaLaBoNaHelper.lua

module("modules.logic.versionactivity1_3.jialabona.helper.JiaLaBoNaHelper", package.seeall)

local JiaLaBoNaHelper = {}

function JiaLaBoNaHelper.getLimitTimeStr()
	local actMO = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act306)

	if actMO then
		return string.format(luaLang("activity_warmup_remain_time"), actMO:getRemainTimeStr2ByEndTime())
	end

	return ""
end

function JiaLaBoNaHelper.isOpenDay(episodeId)
	local actId = VersionActivity1_3Enum.ActivityId.Act306
	local actMO = ActivityModel.instance:getActMO(actId)
	local cfg = Activity120Config.instance:getEpisodeCo(actId, episodeId)

	if actMO and cfg then
		local openTime = actMO:getRealStartTimeStamp() + (cfg.openDay - 1) * 24 * 60 * 60
		local serverTimeStamp = ServerTime.now()
		local preIsClear = cfg.preEpisode == 0 or Activity120Model.instance:isEpisodeClear(cfg.preEpisode)
		local cdtime = math.max(openTime - serverTimeStamp, 0)

		if not preIsClear or cdtime > 0 then
			return false, cdtime
		end
	else
		if not cfg then
			logNormal(string.format("can not find v1a3 activity episodeCfg. actId:%s episodeId:%s", actId, episodeId))
		end

		return false, -1
	end

	return true
end

function JiaLaBoNaHelper.isOpenChapterDay(chapterId)
	local episodeCfg = JiaLaBoNaHelper.getFristEpisodeCoByChapterId(chapterId)

	if not episodeCfg then
		return false, -1
	end

	return JiaLaBoNaHelper.isOpenDay(episodeCfg.id)
end

function JiaLaBoNaHelper.getFristEpisodeCoByChapterId(chapterId)
	local actId = VersionActivity1_3Enum.ActivityId.Act306
	local episodeCfgList = Activity120Config.instance:getChapterEpisodeList(actId, chapterId)

	return episodeCfgList and episodeCfgList[1]
end

function JiaLaBoNaHelper.showToastByEpsodeId(episodeId, isChapter)
	local actId = VersionActivity1_3Enum.ActivityId.Act306
	local episodeCfg = Activity120Config.instance:getEpisodeCo(actId, episodeId)

	if not episodeCfg then
		logNormal(string.format("can not find v1a3 activity episodeCfg. actId:%s episodeId:%s", VersionActivity1_3Enum.ActivityId.Act306, episodeId))

		return
	end

	local isOpen, cdTime = JiaLaBoNaHelper.isOpenDay(episodeCfg.id)

	if not isOpen then
		if episodeCfg.preEpisode ~= 0 or not Activity120Model.instance:isEpisodeClear(episodeCfg.preEpisode) then
			local preCfg = Activity120Config.instance:getEpisodeCo(episodeCfg.activityId, episodeCfg.preEpisode)

			GameFacade.showToast(ToastEnum.Va3Act120PreEpisodeNotOpen, (preCfg or nil) and (preCfg.name or episodeCfg.preEpisode))
		else
			GameFacade.showToast((isChapter or nil) and (ToastEnum.Va3Act120ChapterNotOpenTime or ToastEnum.Va3Act120EpisodeNotOpenTime))
		end
	end
end

return JiaLaBoNaHelper
