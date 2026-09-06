-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterhopeclg/controller/SummonMasterHopeClgController.lua

module("logic.extensions.summonmasterhopeclg.controller.SummonMasterHopeClgController", package.seeall)

local SummonMasterHopeClgController = class("SummonMasterHopeClgController", BaseController)

function SummonMasterHopeClgController:ctor()
	return
end

function SummonMasterHopeClgController:onInit()
	return
end

function SummonMasterHopeClgController:onReset()
	return
end

function SummonMasterHopeClgController:sendPM_SummonMasterHopeClgGetInfoReq(activityId)
	SummonMasterHopeClgAgent.instance:sendPM_SummonMasterHopeClgGetInfoReq(activityId)
end

function SummonMasterHopeClgController:handlePM_SummonMasterHopeClgGetInfoRes(msg)
	SummonMasterHopeClgModel.instance:handlePM_SummonMasterHopeClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SummonMasterHopeClgGetInfoRes)
end

function SummonMasterHopeClgController:sendPM_SummonMasterHopeClgFightReq(activityId, stageId, form)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEnd, self, activityId))
	SummonMasterHopeClgAgent.instance:sendPM_SummonMasterHopeClgFightReq(activityId, stageId, form)
end

function SummonMasterHopeClgController:handlePM_SummonMasterHopeClgNotifyFightResultRes(msg)
	SummonMasterHopeClgModel.instance:handlePM_SummonMasterHopeClgNotifyFightResultRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SummonMasterHopeClgNotifyFightResultRes)
end

function SummonMasterHopeClgController:sendPM_SummonMasterHopeClgGetGodRankReq(activityId)
	SummonMasterHopeClgAgent.instance:sendPM_SummonMasterHopeClgGetGodRankReq(activityId)
end

function SummonMasterHopeClgController:handlePM_SummonMasterHopeClgGetGodRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SummonMasterHopeClgGetGodRankRes, msg)
end

function SummonMasterHopeClgController:sendPM_SummonMasterHopeClgGetDailyRankReq(activityId)
	SummonMasterHopeClgAgent.instance:sendPM_SummonMasterHopeClgGetDailyRankReq(activityId)
end

function SummonMasterHopeClgController:handlePM_SummonMasterHopeClgGetDailyRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SummonMasterHopeClgGetDailyRankRes, msg)
end

function SummonMasterHopeClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function SummonMasterHopeClgController:getSkinId(activityId)
	return SummonMasterHopeClgConfig.instance:getCommonData(activityId).skinId
end

function SummonMasterHopeClgController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function SummonMasterHopeClgController:getActivityType()
	return GameEnum.ActivityType.SummonMasterHopeClg
end

function SummonMasterHopeClgController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function SummonMasterHopeClgController:_onResFightEnd(activityId)
	local curModel = SummonMasterHopeClgModel.instance:GetModel(activityId)

	if not curModel.curFightTagInfos then
		local tagInfos = {}
		local tagRuleData = SummonMasterHopeClgConfig.instance:getSMHClgTagRuleData(activityId)

		if #tagInfos > 0 then
			local tagNums = {}

			for i = 1, #tagInfos do
				local tagType = tagInfos[i].left

				table.insert(tagNums, tagType)
			end

			for i = 1, #tagRuleData do
				if table.indexof(tagNums, i) ~= false then
					local index = table.indexof(tagNums, i)
					local tagName = tagRuleData[i].name

					BattleSettlementController.instance:addConditionElement(langPara("%s: 获得印记%s", tagName, tagInfos[index].right))
				else
					local tagName = tagRuleData[i].name

					BattleSettlementController.instance:addConditionElement(langPara("%s: 获得印记%s", tagName, 0))
				end
			end
		else
			for i, v in ipairs(tagRuleData) do
				local tagName = tagRuleData[i].name

				BattleSettlementController.instance:addConditionElement(langPara("%s: 获得印记%s", tagName, 0))
			end
		end
	end
end

function SummonMasterHopeClgController:enterBattleClg(activityId, stageId)
	local customFmtMo = SummonMasterHopeClgModel.instance:getCustomFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function SummonMasterHopeClgController:canShowDailyRank(activityId)
	local arr = SummonMasterHopeClgConfig.instance:getDataRange(activityId)

	if #arr == 0 then
		return false
	end

	return GameUtil.checkIsInTimePeriod(arr[1], arr[2], false)
end

SummonMasterHopeClgController.instance = SummonMasterHopeClgController.New()

return SummonMasterHopeClgController
