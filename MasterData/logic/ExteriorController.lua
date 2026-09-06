-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/controller/ExteriorController.lua

module("logic.extensions.roleinfo.controller.ExteriorController", package.seeall)

local ExteriorController = class("ExteriorController", BaseController)

function ExteriorController:ctor()
	return
end

function ExteriorController:onInit()
	self:onReset()
end

function ExteriorController:onReset()
	self._currOpenViewName = nil
end

function ExteriorController:getExteriorCfg()
	local matType = MatType.PlayerMessageSkin
	local messageSkinId = BattleStartAnimModel.instance:getUsingItemId(matType) > 0 and BattleStartAnimModel.instance:getUsingItemId(matType) or 1

	return (BattleStartAnimConfig.instance:getPlayerMessageSkinCfgById(messageSkinId))
end

function ExteriorController:setCurrOpenViewName(viewName)
	self._currOpenViewName = viewName
end

function ExteriorController:getCurrOpenViewName()
	return self._currOpenViewName
end

function ExteriorController:setCurrExteriorSelectId(id)
	self._currExteriorSelectId = id
end

function ExteriorController:getCurrExteriorSelectId()
	return self._currExteriorSelectId
end

ExteriorController.instance = ExteriorController.New()

return ExteriorController
