-- chunkname: @modules/logic/versionactivity1_3/astrology/controller/VersionActivity1_3AstrologyController.lua

module("modules.logic.versionactivity1_3.astrology.controller.VersionActivity1_3AstrologyController", package.seeall)

local VersionActivity1_3AstrologyController = class("VersionActivity1_3AstrologyController", BaseController)

function VersionActivity1_3AstrologyController:onInit()
	return
end

function VersionActivity1_3AstrologyController:reInit()
	return
end

function VersionActivity1_3AstrologyController:openVersionActivity1_3AstrologyView()
	local viewParam = {}

	viewParam.defaultTabIds = {
		[2] = 1
	}

	local resultId = Activity126Model.instance:receiveHoroscope()

	viewParam.defaultTabIds[3] = resultId and resultId > 0 and 2 or 1

	ViewMgr.instance:openView(ViewName.VersionActivity1_3AstrologyView, viewParam)
end

function VersionActivity1_3AstrologyController:openVersionActivity1_3AstrologySuccessView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.VersionActivity1_3AstrologySuccessView, param, isImmediate)
end

function VersionActivity1_3AstrologyController:openVersionActivity1_3AstrologyPropView(rewards)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.VersionActivity1_3AstrologyPropView, rewards)
end

VersionActivity1_3AstrologyController.instance = VersionActivity1_3AstrologyController.New()

LuaEventSystem.addEventMechanism(VersionActivity1_3AstrologyController.instance)

return VersionActivity1_3AstrologyController
