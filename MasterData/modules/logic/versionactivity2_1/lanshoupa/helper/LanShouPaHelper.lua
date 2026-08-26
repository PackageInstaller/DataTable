-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/helper/LanShouPaHelper.lua

module("modules.logic.versionactivity2_1.lanshoupa.helper.LanShouPaHelper", package.seeall)

local LanShouPaHelper = {}

function LanShouPaHelper.getLimitTimeStr()
	local actInfoMo = ActivityModel.instance:getActMO(VersionActivity2_1Enum.ActivityId.LanShouPa)

	if not actInfoMo then
		return ""
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		return TimeUtil.SecondToActivityTimeFormat(offsetSecond)
	end

	return ""
end

function LanShouPaHelper.isOpenDay(episodeId)
	local actId = VersionActivity2_1Enum.ActivityId.LanShouPa
	local actMO = ActivityModel.instance:getActMO(actId)
	local cfg = Activity164Config.instance:getEpisodeCo(actId, episodeId)

	if actMO and cfg then
		local openTime = actMO:getRealStartTimeStamp() + (cfg.openDay - 1) * 24 * 60 * 60
		local serverTimeStamp = ServerTime.now()
		local preIsClear = cfg.preEpisode == 0 or Activity164Model.instance:isEpisodeClear(cfg.preEpisode)
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

function LanShouPaHelper.isOpenChapterDay(chapterId)
	local episodeCfg = LanShouPaHelper.getFristEpisodeCoByChapterId(chapterId)

	if not episodeCfg then
		return false, -1
	end

	return LanShouPaHelper.isOpenDay(episodeCfg.id)
end

function LanShouPaHelper.getFristEpisodeCoByChapterId(chapterId)
	local actId = VersionActivity2_1Enum.ActivityId.LanShouPa
	local episodeCfgList = Activity164Config.instance:getChapterEpisodeList(actId, chapterId)

	return episodeCfgList and episodeCfgList[1]
end

function LanShouPaHelper.showToastByEpsodeId(episodeId, isChapter)
	local actId = VersionActivity2_1Enum.ActivityId.LanShouPa
	local episodeCfg = Activity164Config.instance:getEpisodeCo(actId, episodeId)

	if not episodeCfg then
		logNormal(string.format("can not find v1a3 activity episodeCfg. actId:%s episodeId:%s", VersionActivity2_1Enum.ActivityId.LanShouPa, episodeId))

		return
	end

	local isOpen, cdTime = LanShouPaHelper.isOpenDay(episodeCfg.id)

	if not isOpen and (episodeCfg.preEpisode ~= 0 or not Activity164Model.instance:isEpisodeClear(episodeCfg.preEpisode)) then
		local preCfg = Activity164Config.instance:getEpisodeCo(episodeCfg.activityId, episodeCfg.preEpisode)
	end
end

return LanShouPaHelper
