-- chunkname: @modules/logic/sp01/assassinChase/controller/AssassinChaseController.lua

module("modules.logic.sp01.assassinChase.controller.AssassinChaseController", package.seeall)

local AssassinChaseController = class("AssassinChaseController", BaseController)

function AssassinChaseController:onInit()
	self:reInit()
end

function AssassinChaseController:onInitFinish()
	return
end

function AssassinChaseController:addConstEvents()
	return
end

function AssassinChaseController:reInit()
	return
end

function AssassinChaseController:openGameStartView(activityId)
	if not AssassinChaseModel.instance:isActOpen(activityId, true, true) then
		return
	end

	if AssassinChaseModel.instance:isActOpen(activityId, false, false) then
		local infoMo = AssassinChaseModel.instance:getActInfo(activityId)

		if infoMo:isSelect() == false then
			local viewParam = {}

			viewParam.activityId = activityId
			viewParam.gameStageId = Act205Enum.GameStageId.Chase

			ViewMgr.instance:openView(ViewName.Act205GameStartView, viewParam)

			return
		end
	end

	self:openAssassinChaseView(activityId)
end

function AssassinChaseController:openAssassinChaseView(activityId)
	if not AssassinChaseModel.instance:isActOpen(activityId, true, true) then
		return
	end

	AssassinChaseModel.instance:setCurActivityId(activityId)
	self.getAct206GetInfo(self, activityId, self.onGetAssassinChaseInfo, self)
end

function AssassinChaseController:getAct206GetInfo(activityId, callback, callbackObj)
	AssassinChaseRpc.instance:sendAct206GetInfoRequest(activityId, callback, callbackObj)
end

function AssassinChaseController:onGetAssassinChaseInfo()
	local actId = AssassinChaseModel.instance:getCurActivityId()

	if actId == nil then
		logError("奥德赛 下半活动 追逐游戏活动id不存在")
		AssassinChaseModel.instance:setCurActivityId(nil)

		return
	end

	local infoMo = AssassinChaseModel.instance:getActInfo(actId)

	if infoMo == nil then
		logError("奥德赛 下半活动 追逐游戏活动数据不存在 id:" .. actId)
		AssassinChaseModel.instance:setCurActivityId(nil)

		return
	end

	if (infoMo.hasChosenDirection == false or infoMo.chosenInfo == nil or infoMo.chosenInfo.rewardId == nil or infoMo.chosenInfo.rewardId == 0) and not AssassinChaseModel.instance:isActOpen(actId, true, false) then
		return
	end

	ViewMgr.instance:openView(ViewName.AssassinChaseGameView)
end

function AssassinChaseController:selectionDirection(activityId, directionId)
	AssassinChaseRpc.instance:sendAct206ChooseDirectionRequest(activityId, directionId)
end

function AssassinChaseController:getReward(activityId)
	AssassinChaseRpc.instance:sendAct206GetBonusRequest(activityId)
end

function AssassinChaseController:openDialogueView(activityId)
	local param = {}

	param.actId = activityId

	ViewMgr.instance:openView(ViewName.AssassinChaseChatView, param)
end

AssassinChaseController.instance = AssassinChaseController.New()

return AssassinChaseController
