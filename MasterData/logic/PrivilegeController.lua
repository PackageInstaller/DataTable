-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/privilege/controller/PrivilegeController.lua

module("logic.extensions.privilege.controller.PrivilegeController", package.seeall)

local PrivilegeController = class("PrivilegeController", BaseController)

function PrivilegeController:ctor()
	return
end

function PrivilegeController:onInit()
	return
end

function PrivilegeController:onReset()
	return
end

function PrivilegeController:sendGetInfoReq(handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		PrivilegeGiftAgent.instance:sendPM_GetUserPrivilegeInfoReq(self._GetInfoRes, self, self._errorCall)
	end
end

function PrivilegeController:_GetInfoRes(msg)
	PrivilegeModel.instance:updateAfterGetInfo(msg)
	self:_callback()
end

function PrivilegeController:_addDayByOtherWay(status, msg)
	if status == 0 then
		PrivilegeModel.instance:updateAfterAddDayByOtherWay(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PrivilegeAddDayByOtherWay)
	end
end

function PrivilegeController:_onEnterGame()
	self:sendGetInfoReq()
end

function PrivilegeController:_callback(...)
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

function PrivilegeController:_errorCall()
	self._handler = nil
	self._handlerObj = nil
end

function PrivilegeController:_checkIsReqing()
	if self._handler then
		print("_checkIsReqing")
		print(debug.traceback())
		FloatWordMgr.instance:show("Privilegerepet sent req ")

		return true
	else
		return false
	end
end

PrivilegeController.instance = PrivilegeController.New()

return PrivilegeController
