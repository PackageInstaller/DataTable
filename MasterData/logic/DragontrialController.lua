-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/controller/DragontrialController.lua

module("logic.extensions.dragontrial.controller.DragontrialController", package.seeall)

local DragontrialController = class("DragontrialController", BaseController)

DragontrialController.PM_DragonTrialSecondTrialFightFinishRes = "DragontrialController.PM_DragonTrialSecondTrialFightFinishRes"
DragontrialController.PM_DragonTrialFirstTrialFightFinishRes = "DragontrialController.PM_DragonTrialFirstTrialFightFinishRes"
DragontrialController.PM_DragonTrialViewRankRes = "DragontrialController.PM_DragonTrialViewRankRes"
DragontrialController.PM_DragonTrialGainCultivateTaskPrizeRes = "DragontrialController.PM_DragonTrialGainCultivateTaskPrizeRes"
DragontrialController.PM_DragonTrialGainDailyTaskPrizeRes = "DragontrialController.PM_DragonTrialGainDailyTaskPrizeRes"
DragontrialController.PM_DragonTrialBuyTimesRes = "DragontrialController.PM_DragonTrialBuyTimesRes"
DragontrialController.PM_DragonTrialSecondFightRes = "DragontrialController.PM_DragonTrialSecondFightRes"
DragontrialController.PM_DragonTrialSetDreamTrialFormRes = "DragontrialController.PM_DragonTrialSetDreamTrialFormRes"
DragontrialController.PM_DragonTrialFirstFightRes = "DragontrialController.PM_DragonTrialFirstFightRes"
DragontrialController.PM_DragonTrialSetFirstTrialFormRes = "DragontrialController.PM_DragonTrialSetFirstTrialFormRes"
DragontrialController.PM_DragonTrialGetInfoRes = "DragontrialController.PM_DragonTrialGetInfoRes"
DragontrialController.PM_DragonTrialValidatePetStrengthenRes = "DragontrialController.PM_DragonTrialValidatePetStrengthenRes"
DragontrialController.ForceSelectMainViewTab = "DragontrialController.ForceSelectMainViewTab"

function DragontrialController:ctor()
	return
end

function DragontrialController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialSecondTrialFightFinishRes, self._PM_DragonTrialSecondTrialFightFinishRes, self)
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialFirstTrialFightFinishRes, self._PM_DragonTrialFirstTrialFightFinishRes, self)
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialViewRankRes, self._PM_DragonTrialViewRankRes, self)
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialGainCultivateTaskPrizeRes, self._PM_DragonTrialGainCultivateTaskPrizeRes, self)
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialGainDailyTaskPrizeRes, self._PM_DragonTrialGainDailyTaskPrizeRes, self)
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialBuyTimesRes, self._PM_DragonTrialBuyTimesRes, self)
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialSecondFightRes, self._PM_DragonTrialSecondFightRes, self)
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialSetDreamTrialFormRes, self._PM_DragonTrialSetDreamTrialFormRes, self)
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialFirstFightRes, self._PM_DragonTrialFirstFightRes, self)
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialSetFirstTrialFormRes, self._PM_DragonTrialSetFirstTrialFormRes, self)
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialGetInfoRes, self._PM_DragonTrialGetInfoRes, self)
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialValidatePetStrengthenRes, self._PM_DragonTrialValidatePetStrengthenRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ClearDragontrialDailyDot, self._ClearDragontrialDailyDot, self)
	DragonTrialAgent.instance:setShowChangeSetFunc(GameUtil.handler(self._showChangeSet, self))
end

function DragontrialController:onReset()
	self._isBuyDragomTime = false
end

function DragontrialController:_PM_DragonTrialSecondTrialFightFinishRes(status, msg)
	if status == 0 then
		DragontrialModel.instance:setSecondMaxDamage(self._isDragonTrial, msg.damage)
	end

	GlobalDispatcher:dispatch(DragontrialController.PM_DragonTrialSecondTrialFightFinishRes, status, msg)
end

function DragontrialController:_PM_DragonTrialFirstTrialFightFinishRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(DragontrialController.PM_DragonTrialFirstTrialFightFinishRes, status, msg)
end

function DragontrialController:_PM_DragonTrialViewRankRes(status, msg)
	if status == 0 then
		DragontrialModel.instance:viewRankRes(self._rankRoot, self._rankLeaf, msg)
	end

	GlobalDispatcher:dispatch(DragontrialController.PM_DragonTrialViewRankRes, status, msg)
end

function DragontrialController:_PM_DragonTrialGainCultivateTaskPrizeRes(status, msg)
	if status == 0 and self._gainCultivateTaskPrizeRaceId then
		DragontrialModel.instance:gainCultivateTaskPrizeRes(self._gainCultivateTaskPrizeRaceId, msg.taskId)
	end

	GlobalDispatcher:dispatch(DragontrialController.PM_DragonTrialGainCultivateTaskPrizeRes, status, msg)
end

function DragontrialController:_PM_DragonTrialGainDailyTaskPrizeRes(status, msg)
	if status == 0 then
		DragontrialModel.instance:gainDailyTaskPrizeRes(msg.taskId)
	end

	GlobalDispatcher:dispatch(DragontrialController.PM_DragonTrialGainDailyTaskPrizeRes, status, msg)
end

function DragontrialController:_PM_DragonTrialBuyTimesRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("购买次数成功")
		DragontrialModel.instance:buyTimeRes(self._isBuyDragomTime)
	end

	GlobalDispatcher:dispatch(DragontrialController.PM_DragonTrialBuyTimesRes, status, msg)
end

function DragontrialController:_PM_DragonTrialSecondFightRes(status, msg)
	if status == 0 then
		if self._isDragonTrial then
			DragontrialModel.instance:dragonFightTimeAdd()
		else
			DragontrialModel.instance:dreamFightTimeAdd()
		end
	end

	GlobalDispatcher:dispatch(DragontrialController.PM_DragonTrialSecondFightRes, status, msg)
end

function DragontrialController:_PM_DragonTrialSetDreamTrialFormRes(status, msg)
	if status == 0 then
		DragontrialModel.instance:setDreamTrialForm(msg.activityId, msg.form)
	end

	GlobalDispatcher:dispatch(DragontrialController.PM_DragonTrialSetDreamTrialFormRes, status, msg)
end

function DragontrialController:_PM_DragonTrialFirstFightRes(status, msg)
	if status == 0 then
		DragontrialModel.instance:setTrialFirstFightPass()
	end

	GlobalDispatcher:dispatch(DragontrialController.PM_DragonTrialFirstFightRes, status, msg)
end

function DragontrialController:_PM_DragonTrialSetFirstTrialFormRes(status, msg)
	if status == 0 then
		DragontrialModel.instance:setFirstTrialForm(msg.activityId, msg.form)
	end

	GlobalDispatcher:dispatch(DragontrialController.PM_DragonTrialSetFirstTrialFormRes, status, msg)
end

function DragontrialController:_PM_DragonTrialGetInfoRes(status, msg)
	if status == 0 then
		DragontrialModel.instance:setInfos(msg)
	end

	GlobalDispatcher:dispatch(DragontrialController.PM_DragonTrialGetInfoRes, status, msg)
end

function DragontrialController:_PM_DragonTrialValidatePetStrengthenRes(status, msg)
	if status == 0 and self._validatePetId then
		DragontrialModel.instance:validatePetStrengthenRes(self._validatePetId, msg.taskId)
	end

	GlobalDispatcher:dispatch(DragontrialController.PM_DragonTrialValidatePetStrengthenRes, status, msg)
end

function DragontrialController:recordBuyDragonOrDreamTime(flag)
	self._isBuyDragomTime = flag
end

function DragontrialController:sendPM_DragonTrialSecondFightReq(activityId, dragonTrial)
	dragonTrial = checkbool(dragonTrial)
	self._isDragonTrial = dragonTrial

	DragonTrialAgent.instance:sendPM_DragonTrialSecondFightReq(activityId, dragonTrial)
end

function DragontrialController:sendPM_DragonTrialViewRankReq(root, leaf)
	local cfg = DragontrialConfig.instance:getRankCfg(root, leaf)
	local activityId = DragontrialModel.instance:getCurrActivityId()

	self._rankRoot = root
	self._rankLeaf = leaf

	DragonTrialAgent.instance:sendPM_DragonTrialViewRankReq(activityId, cfg.leaf, cfg.isDragonTrial)
end

function DragontrialController:sendPM_DragonTrialGainCultivateTaskPrizeReq(activityId, raceId, taskId)
	self._gainCultivateTaskPrizeRaceId = raceId

	DragonTrialAgent.instance:sendPM_DragonTrialGainCultivateTaskPrizeReq(activityId, raceId, taskId)
end

function DragontrialController:sendPM_DragonTrialValidatePetStrengthenReq(activityId, petId)
	self._validatePetId = petId

	DragonTrialAgent.instance:sendPM_DragonTrialValidatePetStrengthenReq(activityId, petId)
end

function DragontrialController:_showChangeSet(changeSetId, msgName)
	if changeSetId and changeSetId > 0 then
		if msgName == "handlePM_DragonTrialFirstTrialFightFinishRes" or msgName == "handlePM_DragonTrialSecondTrialFightFinishRes" then
			BattleSettlementModel.instance:setChangeSetId(changeSetId)
		else
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
		end
	end
end

function DragontrialController:_ClearDragontrialDailyDot()
	DragontrialModel.instance:clearDailyDot()
end

DragontrialController.instance = DragontrialController.New()

return DragontrialController
