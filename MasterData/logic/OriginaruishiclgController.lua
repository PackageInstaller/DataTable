-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaruishiclg/controller/OriginaruishiclgController.lua

module("logic.extensions.originaruishiclg.controller.OriginaruishiclgController", package.seeall)

local OriginaruishiclgController = class("OriginaruishiclgController", BaseController)

function OriginaruishiclgController:ctor()
	return
end

function OriginaruishiclgController:onInit()
	self:onReset()
end

function OriginaruishiclgController:onReset()
	self._lastSelectFloorId = 0
end

function OriginaruishiclgController:onChallengeResultRes(msg)
	if not msg.isWin then
		return false
	end

	OriginaruishiclgModel.instance:onChallengeResultRes(msg)
end

function OriginaruishiclgController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(275)
end

function OriginaruishiclgController:getLastSelectFloorId()
	return self._lastSelectFloorId
end

function OriginaruishiclgController:setLastSelectFloorId(floorId)
	self._lastSelectFloorId = floorId
end

OriginaruishiclgController.instance = OriginaruishiclgController.New()

return OriginaruishiclgController
