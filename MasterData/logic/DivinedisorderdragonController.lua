-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedisorderdragon/controller/DivinedisorderdragonController.lua

module("logic.extensions.divinedisorderdragon.controller.DivinedisorderdragonController", package.seeall)

local DivinedisorderdragonController = class("DivinedisorderdragonController", BaseController)

function DivinedisorderdragonController:ctor()
	return
end

function DivinedisorderdragonController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterdivinedisorderdragonmainview", self._enterEventOpenView, self)
end

function DivinedisorderdragonController:onReset()
	return
end

function DivinedisorderdragonController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DivineDisorderDragon)
end

function DivinedisorderdragonController:allHasPass(activityId)
	local cfgs = DivinedisorderdragonConfig.instance:getStageCfgs(activityId)

	return DivinedisorderdragonModel.instance:getPassStage(activityId) >= #cfgs
end

function DivinedisorderdragonController:_enterEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.DivinedisorderdragonmainView, actId)
end

DivinedisorderdragonController.instance = DivinedisorderdragonController.New()

return DivinedisorderdragonController
