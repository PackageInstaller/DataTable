-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialrecover/controller/MaterialRecoverController.lua

module("logic.extensions.materialrecover.controller.MaterialRecoverController", package.seeall)

local MaterialRecoverController = class("MaterialRecoverController", BaseController)

function MaterialRecoverController:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._resetRecoverInfos, self)
end

function MaterialRecoverController:onReset()
	self._saveLastFuncType = nil
	self._saveLastState = nil
end

function MaterialRecoverController:requestAllInfos()
	local info = MaterialRecoverModel.instance:getAllRecoverInfos()

	if info then
		return
	end

	MaterialRecoverAgent.instance:sendPM_GetMaterialRecoverInfosReq()
end

function MaterialRecoverController:onGetAllRecoverInfos(info)
	MaterialRecoverModel.instance:setAllRecoverInfos(info)
	GlobalDispatcher:dispatch(GlobalNotify.OnResRecoverInfos)
end

function MaterialRecoverController:requestGainMaterialRecover(funType, state)
	self._saveLastFuncType = funType
	self._saveLastState = state

	MaterialRecoverAgent.instance:sendPM_GainMaterialRecoverReq(funType, state)
end

function MaterialRecoverController:onGainMaterialRecover()
	if self._saveLastFuncType and self._saveLastState then
		MaterialRecoverModel.instance:onGainMaterialRecover(self._saveLastFuncType, self._saveLastState)

		self._saveLastFuncType = nil
		self._saveLastState = nil

		GlobalDispatcher:dispatch(GlobalNotify.OnRecoverRes)
	end
end

function MaterialRecoverController:aotoPopupViewWhileEnterGame()
	if not RedPointModel.instance:isActive(117) then
		return false
	end

	local useId = RoleModel.instance:getUserId()

	return GameUtil.getUserDayData((useId or "") .. "mat_recocer_popup") == nil
end

function MaterialRecoverController:setHasShowUIOnEnterGame()
	local useId = RoleModel.instance:getUserId()

	GameUtil.saveUserDayData((useId or "") .. "mat_recocer_popup", 1)
end

function MaterialRecoverController:_resetRecoverInfos()
	MaterialRecoverModel.instance:onReset()
	self:requestAllInfos()
	GlobalDispatcher:dispatch(GlobalNotify.OnResRecoverInfos)
end

function MaterialRecoverController:_onStartEnterGame()
	return
end

MaterialRecoverController.instance = MaterialRecoverController.New()

return MaterialRecoverController
