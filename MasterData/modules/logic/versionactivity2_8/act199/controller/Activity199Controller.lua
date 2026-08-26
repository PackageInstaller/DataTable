-- chunkname: @modules/logic/versionactivity2_8/act199/controller/Activity199Controller.lua

module("modules.logic.versionactivity2_8.act199.controller.Activity199Controller", package.seeall)

local Activity199Controller = class("Activity199Controller", BaseController)

function Activity199Controller:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._checkActivityInfo, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._checkActivityInfo, self)
end

function Activity199Controller:_checkActivityInfo()
	self:getActivity199Info()
end

function Activity199Controller:getActivity199Info(cb, cbObj)
	local isOpen = Activity199Model.instance:isActivity199Open()

	if not isOpen then
		return
	end

	local actId = Activity199Model.instance:getActivity199Id()

	Activity199Rpc.instance:sendGet199InfoRequest(actId, cb, cbObj)
end

function Activity199Controller:openV2a8_SelfSelectCharacterView()
	self.getActivity199Info(self, self._realV2a8_SelfSelectCharacterView, self)
end

function Activity199Controller:_realV2a8_SelfSelectCharacterView()
	ViewMgr.instance:openView(ViewName.V2a8_SelfSelectCharacterView, {
		actId = Activity199Model.instance:getActivity199Id()
	})
end

Activity199Controller.instance = Activity199Controller.New()

return Activity199Controller
