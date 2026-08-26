-- chunkname: @modules/logic/open/controller/OpenHelper.lua

module("modules.logic.open.controller.OpenHelper", package.seeall)

local OpenHelper = class("OpenHelper")

function OpenHelper.getToastIdAndParam(openId)
	local openCo = OpenConfig.instance:getOpenCo(openId)
	local toastId = openCo.dec
	local getToastFunc = OpenHelper.ToastId2FuncDict[toastId]

	getToastFunc = getToastFunc or OpenHelper.defaultGetToast

	return getToastFunc(openCo)
end

function OpenHelper.defaultGetToast(openCo)
	return openCo and openCo.dec
end

function OpenHelper.getDungeonToast(openCo)
	local toastId = openCo.dec

	if VersionValidator.instance:isInReviewing() then
		if not openCo.verifingEpisodeId then
			local episodeId = openCo.episodeId

			if not episodeId or episodeId == 0 then
				return toastId
			end

			local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(episodeId)

			return toastId, {
				episodeDisplay
			}
		end
	end
end

function OpenHelper.getActivityDungeonToast(openCo)
	local toastId = openCo.dec
	local episodeCo = DungeonConfig.instance:getEpisodeCO(openCo.episodeId)
	local chapterCo = DungeonConfig.instance:getChapterCO(episodeCo and episodeCo.chapterId)
	local actCo = ActivityConfig.instance:getActivityCo(chapterCo and chapterCo.actId)
	local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(openCo.episodeId)

	return toastId, {
		actCo and actCo.name,
		episodeDisplay
	}
end

function OpenHelper.getActivityDungeon1Toast(openCo)
	local toastId = openCo.dec
	local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(openCo.episodeId)

	return toastId, {
		luaLang("v1a2_enterview_activitytip"),
		episodeDisplay
	}
end

function OpenHelper.getActivityUnlockTxt(openId)
	local openCo = OpenConfig.instance:getOpenCo(openId)
	local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(openCo.episodeId)

	return string.format(luaLang("versionactivity1_3_hardlocktip"), episodeDisplay)
end

OpenHelper.ToastId2FuncDict = {
	[ToastEnum.DungeonMapLevel] = OpenHelper.getDungeonToast,
	[ToastEnum.ActivityDungeon] = OpenHelper.getActivityDungeonToast,
	[ToastEnum.ActivityDungeon1] = OpenHelper.getActivityDungeon1Toast
}

return OpenHelper
