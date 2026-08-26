-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/HedoneStatHelper.lua

module("modules.logic.versionactivity3_9.hedone.controller.HedoneStatHelper", package.seeall)

local HedoneStatHelper = class("HedoneStatHelper")

HedoneStatHelper.OperationType = {
	GameSettle = "关卡结算",
	ExitGame = "手动退出",
	PickSkill = "选取技能"
}
HedoneStatHelper.GameResultStat = {
	Exit = "手动退出",
	Fail = "失败",
	Success = "成功"
}

function HedoneStatHelper._getCommonProperties(operationType)
	local gameId = HedoneGameModel.instance:getGameId()
	local playerMO = HedoneGameModel.instance:getPlayerMO()

	if not gameId or not playerMO then
		return
	end

	local allSkillIdList = playerMO:getSkillIdList()

	return {
		[StatEnum.EventProperties.OperationType] = operationType,
		[StatEnum.EventProperties.MapId] = tostring(gameId),
		[StatEnum.EventProperties.TotalRound] = HedoneGameModel.instance:getGameTime(),
		[StatEnum.EventProperties.AfterLevel] = playerMO:getCurLv(),
		[StatEnum.EventProperties.ActTravelSkillList] = allSkillIdList
	}
end

function HedoneStatHelper.sendSettleInfo(operationType, result)
	local properties = HedoneStatHelper._getCommonProperties(operationType)

	if not properties then
		return
	end

	local startTime = HedoneGameModel.instance:getGameStartTime()

	properties[StatEnum.EventProperties.Result] = result
	properties[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - startTime

	StatController.instance:track(StatEnum.EventName.HedoneGame, properties)
end

function HedoneStatHelper.sendPickSkillInfo(pickSkillId, newSkillIdList)
	local properties = HedoneStatHelper._getCommonProperties(HedoneStatHelper.OperationType.PickSkill)

	if not properties then
		return
	end

	properties[StatEnum.EventProperties.ActTravelSkillId] = pickSkillId
	properties[StatEnum.EventProperties.ActTravelSelectableSkills] = newSkillIdList

	StatController.instance:track(StatEnum.EventName.HedoneGame, properties)
end

return HedoneStatHelper
