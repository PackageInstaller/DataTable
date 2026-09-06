-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/controller/GoddessShopController.lua

module("logic.extensions.goddessshop.controller.GoddessShopController", package.seeall)

local GoddessShopController = class("GoddessShopController", BaseController)

function GoddessShopController:onInit()
	self:onReset()
end

function GoddessShopController:onReset()
	self:_destroyAllMgr()
end

function GoddessShopController:sendPM_SurroundByDreamGirlInfoReq(activityId)
	SurroundByDreamGirlAgent.instance:sendPM_SurroundByDreamGirlInfoReq(activityId)
end

function GoddessShopController:handlePM_SurroundByDreamGirlInfoRes(msg)
	local mo = self:getGoddessShopMo(msg.activityId)

	mo:handlePM_SurroundByDreamGirlInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SurroundByDreamGirlInfoRes)
	GlobalDispatcher:dispatch(GlobalNotify.SurroundByDreamGirlShopMoneyHandle)
end

function GoddessShopController:sendPM_SurroundByDreamGirlGainMoneyProgressPrizeReq(activityId, prizeId)
	SurroundByDreamGirlAgent.instance:sendPM_SurroundByDreamGirlGainMoneyProgressPrizeReq(activityId, prizeId)
end

function GoddessShopController:handlePM_SurroundByDreamGirlGainMoneyProgressPrizeRes(msg)
	local mo = self:getGoddessShopMo(msg.activityId)

	mo:handlePM_SurroundByDreamGirlGainMoneyProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SurroundByDreamGirlGainMoneyProgressPrizeRes)
end

function GoddessShopController:sendPM_SurroundByDreamGirlInvestReq(activityId, girlId)
	SurroundByDreamGirlAgent.instance:sendPM_SurroundByDreamGirlInvestReq(activityId, girlId)
end

function GoddessShopController:handlePM_SurroundByDreamGirlInvestRes(msg)
	local mo = self:getGoddessShopMo(msg.activityId)

	mo:handlePM_SurroundByDreamGirlInvestRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SurroundByDreamGirlInvestRes)
	GlobalDispatcher:dispatch(GlobalNotify.SurroundByDreamGirlShopMoneyHandle)
end

function GoddessShopController:sendPM_SurroundByDreamGirlGetGirlTodayChatInfoReq(activityId, girlId)
	SurroundByDreamGirlAgent.instance:sendPM_SurroundByDreamGirlGetGirlTodayChatInfoReq(activityId, girlId)
end

function GoddessShopController:handlePM_SurroundByDreamGirlGetGirlTodayChatInfoRes(msg)
	local mo = self:getGoddessShopMo(msg.activityId)

	mo:handlePM_SurroundByDreamGirlGetGirlTodayChatInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SurroundByDreamGirlGetGirlTodayChatInfoRes, msg)
end

function GoddessShopController:sendPM_SurroundByDreamGirlChatReq(activityId, girlId)
	SurroundByDreamGirlAgent.instance:sendPM_SurroundByDreamGirlChatReq(activityId, girlId)
end

function GoddessShopController:handlePM_SurroundByDreamGirlChatRes(status, msg)
	if status == 0 then
		local mo = self:getGoddessShopMo(msg.activityId)

		mo:handlePM_SurroundByDreamGirlChatRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SurroundByDreamGirlChatRes, status, msg)
end

function GoddessShopController:sendPM_SurroundByDreamGirlSelectAnswerReq(activityId, girlId, answer)
	SurroundByDreamGirlAgent.instance:sendPM_SurroundByDreamGirlSelectAnswerReq(activityId, girlId, answer)
end

function GoddessShopController:handlePM_SurroundByDreamGirlSelectAnswerRes(msg)
	local mo = self:getGoddessShopMo(msg.activityId)

	mo:handlePM_SurroundByDreamGirlSelectAnswerRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SurroundByDreamGirlSelectAnswerRes, msg)
end

function GoddessShopController:sendPM_SurroundByDreamGirlPresentGiftReq(activityId, girlId, giftId, presentNum)
	SurroundByDreamGirlAgent.instance:sendPM_SurroundByDreamGirlPresentGiftReq(activityId, girlId, giftId, presentNum)
end

function GoddessShopController:handlePM_SurroundByDreamGirlPresentGiftRes(msg)
	local mo = self:getGoddessShopMo(msg.activityId)

	mo:handlePM_SurroundByDreamGirlPresentGiftRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SurroundByDreamGirlPresentGiftRes)
	GlobalDispatcher:dispatch(GlobalNotify.SurroundByDreamGirlShopFetterUpdate)
end

function GoddessShopController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function GoddessShopController:getActivityType()
	return GameEnum.ActivityType.GoddessShop
end

function GoddessShopController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function GoddessShopController:getGoddessShopMo(activityId)
	return GoddessShopModel.instance:getGoddessShopMo(activityId)
end

function GoddessShopController:enterInMgr(activityId)
	if self._mgrs[activityId] == nil then
		self._mgrs[activityId] = GoddessShopMgr.New(activityId)
		self._mgrDeltas[activityId] = 0
	end

	if self._mgrDeltas[activityId] == 0 then
		self._mgrs[activityId]:onEnter()
	end

	self._mgrDeltas[activityId] = self._mgrDeltas[activityId] + 1
end

function GoddessShopController:exitInMgr(activityId)
	if self._mgrs[activityId] then
		self._mgrDeltas[activityId] = Mathf.Max(self._mgrDeltas[activityId] - 1, 0)

		if self._mgrDeltas[activityId] <= 0 then
			self._mgrs[activityId]:onExit()
		end
	end
end

function GoddessShopController:_destroyAllMgr()
	if self._mgrs then
		for activityId, mgr in pairs(self._mgrs) do
			mgr:onDestroy()

			self._mgrs[activityId] = nil
			self._mgrDeltas[activityId] = 0
		end
	else
		self._mgrs = {}
		self._mgrDeltas = {}
	end
end

function GoddessShopController:getMgr(activityId)
	return self._mgrs[activityId]
end

function GoddessShopController:updateFetterValueAndNotify(activityId, girlId, value)
	local mo = self:getGoddessShopMo(activityId)

	mo:_updateValueInShop(girlId, "fetter", Mathf.Max(value, 0))
	GlobalDispatcher:dispatch(GlobalNotify.SurroundByDreamGirlShopFetterUpdate)
end

GoddessShopController.instance = GoddessShopController.New()

return GoddessShopController
