-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthSignin/controller/MonthSigninController.lua

module("logic.extensions.monthSignin.controller.MonthSigninController", package.seeall)

local M = class("MonthSigninController", BaseController)

M.POP_UP_HISTORY = {
	jumpId = 80000002,
	key = LoginPopEnum.PopCode[LoginPopEnum.PopType.MonthSign]
}

function M:onInit()
	self:_setEvent(true)
end

function M:onReset()
	return
end

function M:handlerGetSignInfo(msg)
	MonthSigninModel.instance:setModelList(msg)
	self:_setMainLoginPop()
end

function M:handlerSignSuccess(msg)
	MonthSigninModel.instance:setModelList(msg)
	GlobalDispatcher:dispatchEvent(EventType.MONTHSING_REFRESH_VIEW)
end

function M:getCurrentMonth()
	return MonthSigninModel.instance:getCurrentMonth()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, GameEnum.SystemEnum.MonthSignIn), self._setMainLoginPop, self)
		GlobalDispatcher:addEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._everyDayFive, self)
	else
		GlobalDispatcher:removeEventListener(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, GameEnum.SystemEnum.MonthSignIn), self._setMainLoginPop, self)
		GlobalDispatcher:removeEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._everyDayFive, self)
	end
end

function M:_everyDayFive()
	MonthSignInAgent.instance:sendGetMonthSignInInfoRequest()
end

function M:_setMainLoginPop()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.MonthSignIn, false) then
		return
	end

	if not self:getTodayIsFinish() then
		local code = self.POP_UP_HISTORY.key
		local jumpId = self.POP_UP_HISTORY.jumpId
		local info = {
			isPop = true
		}

		GlobalDispatcher:dispatchEvent(EventType.LOGIN_POP_UP_REG, code, 0, true, jumpId, info)
	end
end

function M:getTodayRewardInfo()
	return MonthSigninModel.instance:getTodayRewardInfo()
end

function M:getList()
	return MonthSigninModel.instance:getList()
end

function M:getTodayIsFinish()
	return MonthSigninModel.instance:getTodayIsFinish()
end

M.instance = M.New()

return M
