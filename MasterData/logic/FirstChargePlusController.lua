-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/controller/FirstChargePlusController.lua

module("logic.extensions.firstcharge.controller.FirstChargePlusController", package.seeall)

local FirstChargePlusController = class("FirstChargePlusController", BaseController)

function FirstChargePlusController:ctor()
	return
end

function FirstChargePlusController:onInit()
	RedPointAgent.instance:addHandler(RedPointAgent.PM_LoadAllRedPointRes, self.updateSkinGotoRedPointState, self)
end

function FirstChargePlusController:onReset()
	return
end

function FirstChargePlusController:sendGetInfoReq(activityId, handler, handlerObj)
	self._handler = handler
	self._handlerObj = handlerObj

	ScopeConsumePlusAgent.instance:sendPM_GetScopePlusConsumeInfoReq(activityId)
end

function FirstChargePlusController:_getInfoRes(msg)
	FirstChargePlusModel.instance:updateAfterGetInfo(msg)
	self:_callback()
	GlobalDispatcher:dispatch(GlobalNotify.FIRST_CHARGE_UPATE)
end

function FirstChargePlusController:sendGetPrizeReq(activityId, prizeId, handler, handlerObj)
	self._handler = handler
	self._handlerObj = handlerObj
	self._sendActivityId = activityId
	self._sendPrizeId = prizeId

	ScopeConsumePlusAgent.instance:sendPM_ScopeConsumePlusGainGiftReq(activityId, prizeId)
end

function FirstChargePlusController:updatePrize(msg)
	FirstChargePlusModel.instance:updatePrize(self._sendActivityId, self._sendPrizeId)
	self:_callback()
end

function FirstChargePlusController:sendGetSignPrizeReq(activityId, handler, handlerObj)
	self._handler = handler
	self._handlerObj = handlerObj
	self._sendActivityId = activityId

	local day = FirstChargePlusModel.instance:getSignIndex(activityId)

	self._sendDay = day

	ScopeConsumePlusAgent.instance:sendPM_ScopeConsumePlusGainSignPrizeReq(activityId, day)
end

function FirstChargePlusController:updateDay(msg)
	FirstChargePlusModel.instance:updateDay(self._sendActivityId, self._sendDay)
	self:_callback()
end

function FirstChargePlusController:_callback(...)
	local handler = self._handler
	local handlerObj = self._handlerObj

	if handler then
		if handlerObj then
			self._handler(handlerObj, ...)
		else
			handler(...)
		end
	end

	self._handler = nil
	self._handlerObj = nil
end

function FirstChargePlusController:_errorCall()
	self._handler = nil
	self._handlerObj = nil
end

function FirstChargePlusController:_checkIsReqing()
	return false
end

function FirstChargePlusController:updateSkinGotoRedPointState()
	local isShow = false
	local actCfgs = PetSkinConfig.instance:getCurActPetSkinGotoCfgs()

	for k, v in pairs(actCfgs) do
		local dateKey = "Skin_Goto_Data_Key_" .. v.id

		isShow = checknumber(GameUtil.getUserDayData(dateKey)) <= 0

		if isShow then
			break
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PET_SKIN_GOTO, isShow)
end

function FirstChargePlusController:updateSkinGotoRedPointData(id)
	local dateKey = "Skin_Goto_Data_Key_" .. id
	local isShow = checknumber(GameUtil.getUserDayData(dateKey)) <= 0

	if isShow then
		GameUtil.saveUserDayData(dateKey, 1)
		self:updateSkinGotoRedPointState()
	end
end

FirstChargePlusController.instance = FirstChargePlusController.New()

return FirstChargePlusController
