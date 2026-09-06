-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/controller/FirstChargeController.lua

module("logic.extensions.firstcharge.controller.FirstChargeController", package.seeall)

local FirstChargeController = class("FirstChargeController", BaseController)

function FirstChargeController:ctor()
	return
end

function FirstChargeController:onInit()
	RedPointAgent.instance:addHandler(RedPointAgent.PM_LoadAllRedPointRes, self.updateSkinGotoRedPointState, self)
end

function FirstChargeController:onReset()
	return
end

function FirstChargeController:sendGetInfoReq(handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		ScopeConsumeAgent.instance:sendPM_GetScopeConsumeInfoReq(self._getInfoRes, self, self._errorCall)
	end
end

function FirstChargeController:_getInfoRes(msg)
	FirstChargeModel.instance:updateAfterGetInfo(msg)
	self:_callback()
end

function FirstChargeController:sendGetPrizeReq(activityId, index, money, handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		FirstChargeModel.instance:tryGetPirze(index + 1)

		local day = FirstChargeModel.instance:getSignIndex(money)

		ScopeConsumeAgent.instance:sendPM_ScopeConsumeGainGiftReq(activityId, index, day, self._getGiftRes, self, self._errorCall)
	end
end

function FirstChargeController:_getGiftRes(msg)
	FirstChargeModel.instance:updateAfterGetGift(msg)
	self:_callback()
end

function FirstChargeController:_callback(...)
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

function FirstChargeController:_errorCall()
	self._handler = nil
	self._handlerObj = nil
end

function FirstChargeController:_checkIsReqing()
	if self._handler then
		print("_checkIsReqing")
		print(debug.traceback())
		FloatWordMgr.instance:show("FirstCharge sent req ")

		return true
	else
		return false
	end
end

function FirstChargeController:updateSkinGotoRedPointState()
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

function FirstChargeController:updateSkinGotoRedPointData(id)
	local dateKey = "Skin_Goto_Data_Key_" .. id
	local isShow = checknumber(GameUtil.getUserDayData(dateKey)) <= 0

	if isShow then
		GameUtil.saveUserDayData(dateKey, 1)
		self:updateSkinGotoRedPointState()
	end
end

FirstChargeController.instance = FirstChargeController.New()

return FirstChargeController
