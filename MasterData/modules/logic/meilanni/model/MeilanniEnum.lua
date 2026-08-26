-- chunkname: @modules/logic/meilanni/model/MeilanniEnum.lua

module("modules.logic.meilanni.model.MeilanniEnum", package.seeall)

local MeilanniEnum = _M

MeilanniEnum.ElementType = {
	MaxCount = 2,
	Battle = 2,
	Dialog = 1
}
MeilanniEnum.StoryType = {
	openDay = 1,
	finishMap = 3,
	openDayAndFinishMap = 5,
	finishAllMap = 4,
	enterMap = 2
}
MeilanniEnum.ResultType = {
	score = 1,
	feature = 2
}
MeilanniEnum.ResultString = {
	options = "options",
	result = "result",
	dialog = "dialog"
}
MeilanniEnum.orthographicSize = 7.1
MeilanniEnum.activityId = 11102
MeilanniEnum.episodeId = 1150101
MeilanniEnum.unlockMapId = 103
MeilanniEnum.threatNum = 5
MeilanniEnum.endStoryBindIndex = 5
MeilanniEnum.dialogTime = 0.1
MeilanniEnum.selectedTime = 0.7
MeilanniEnum.skipTime = 0.1
MeilanniEnum.epilogueTime = 0.4
MeilanniEnum.prefaceTime = 1
MeilanniEnum.confirmTime = 0
MeilanniEnum.showExcludeRulesTime = 1
MeilanniEnum.showEnemyTime = 1.2
MeilanniEnum.resultTime = 1
MeilanniEnum.changeMapTime = 1
MeilanniEnum.changeWeatherTime = 0
MeilanniEnum.showElementTime = 0
MeilanniEnum.optionTime = 0.14

return MeilanniEnum
