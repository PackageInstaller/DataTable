-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianwelfare/controller/NianNianWelfareController.lua

module("logic.extensions.niannianwelfare.controller.NianNianWelfareController", package.seeall)

local NianNianWelfareController = class("NianNianWelfareController", BaseController)

NianNianWelfareController.PM_NianNianBenefitsInfoRes = "NianNianWelfareController.PM_NianNianBenefitsInfoRes"
NianNianWelfareController.PM_NianNianBenefitsUpgradeRes = "NianNianWfoundlandController.PM_NianNianBenefitsUpgradeRes"
NianNianWelfareController.PM_NianNianBenefitsGainDailPrizeRes = "NianNianWfoundlandController.PM_NianNianBenefitsGainDailPrizeRes"
NianNianWelfareController.PM_NianNianBenefitsRefineRes = "NianNianWfoundlandController.PM_NianNianBenefitsRefineRes"
NianNianWelfareController.PM_NianNianBenefitsAchievementPrizeRes = "NianNianWfoundlandController.PM_NianNianBenefitsAchievementPrizeRes"

function NianNianWelfareController:sendPM_NianNianBenefitsInfoReq(actId, partsPlan)
	self._sendInfo = {
		partsPlan = partsPlan
	}

	NianNianBenefitsAgent.instance:sendPM_NianNianBenefitsInfoReq(actId)
end

function NianNianWelfareController:handlePM_NianNianBenefitsInfoRes(msg)
	NianNianWelfareModel.instance:setDailyItemNum(msg.dailyItemNum)
	NianNianWelfareModel.instance:setIsGainDailyPrize(msg.isGainDailyPrize)
	NianNianWelfareModel.instance:setIsRefine(msg.isRefine)
	NianNianWelfareModel.instance:setGainAchievementPrizeIds(msg.gainAchievementPrizeIds)
	NianNianWelfareModel.instance:setPartinfos(msg.infos, self._sendInfo.partsPlan)

	self._sendInfo = nil

	GlobalDispatcher:dispatch(NianNianWelfareController.PM_NianNianBenefitsInfoRes)
end

function NianNianWelfareController:sendPM_NianNianBenefitsUpgradeReq(actId, partsId)
	self._sendUp = {
		partsId = partsId
	}

	NianNianBenefitsAgent.instance:sendPM_NianNianBenefitsUpgradeReq(actId, partsId)
end

function NianNianWelfareController:handlePM_NianNianBenefitsUpgradeRes()
	NianNianWelfareModel.instance:upPart(self._sendUp.partsId)
	GlobalDispatcher:dispatch(NianNianWelfareController.PM_NianNianBenefitsUpgradeRes, self._sendUp.partsId)

	self._sendUp = nil
end

function NianNianWelfareController:handlePM_NianNianBenefitsGainDailPrizeRes(msg)
	NianNianWelfareModel.instance:setIsGainDailyPrize(true)

	local items = MaterialModel.instance:getMaterialMos(msg.changeSetId)

	if items and items[1] then
		NianNianWelfareModel.instance:setDailyItemNum(NianNianWelfareModel.instance:getDailyItemNum() + items[1]:GetCount())
	end

	GlobalDispatcher:dispatch(NianNianWelfareController.PM_NianNianBenefitsGainDailPrizeRes)
end

function NianNianWelfareController:handlePM_NianNianBenefitsRefineRes(msg)
	NianNianWelfareModel.instance:setIsRefine(true)
	GlobalDispatcher:dispatch(NianNianWelfareController.PM_NianNianBenefitsRefineRes)
end

function NianNianWelfareController:sendPM_NianNianBenefitsAchievementPrizeReq(actId, achievementId)
	self._sendAchievement = {
		achievementId = achievementId
	}

	NianNianBenefitsAgent.instance:sendPM_NianNianBenefitsAchievementPrizeReq(actId, achievementId)
end

function NianNianWelfareController:handlePM_NianNianBenefitsAchievementPrizeRes(msg)
	NianNianWelfareModel.instance:gainAchievementPrize(self._sendAchievement.achievementId)

	self._sendAchievement = nil

	GlobalDispatcher:dispatch(NianNianWelfareController.PM_NianNianBenefitsAchievementPrizeRes)
end

function NianNianWelfareController:getActivity()
	local activity = NianNianWelfareConfig.instance:getActivity()

	for i, activityCfg in ipairs(activity) do
		if ActivityDefineController.instance:isInActivityTimeById(77, activityCfg.actId) then
			local activityInfo = clone(activityCfg)
			local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(77, activityInfo.actId)

			activityInfo.startTime = startTime
			activityInfo.endTime = endTime

			return activityInfo
		end
	end
end

function NianNianWelfareController:isCanRefine()
	local partInfo = NianNianWelfareModel.instance:getPartInfo()

	return partInfo.lv >= partInfo.maxLevel and not NianNianWelfareModel.instance:isRefine()
end

NianNianWelfareController.instance = NianNianWelfareController.New()

return NianNianWelfareController
