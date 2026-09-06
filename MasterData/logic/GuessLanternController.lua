-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesslantern/controller/GuessLanternController.lua

module("logic.extensions.guesslantern.controller.GuessLanternController", package.seeall)

local GuessLanternController = class("GuessLanternController", BaseController)

function GuessLanternController:ctor()
	return
end

function GuessLanternController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onChangeDate, self)
end

function GuessLanternController:_onChangeDate()
	GuessLanternModel.instance:onReset()

	local cfg = ActivityDefineController.instance:getActivityCfgByType(GuessLanternModel.instance:getActivityType())

	if cfg then
		GuessLanternAgent.instance:sendPM_GuessLanternGetInfoReq(cfg.activityId)
	end
end

GuessLanternController.instance = GuessLanternController.New()

return GuessLanternController
