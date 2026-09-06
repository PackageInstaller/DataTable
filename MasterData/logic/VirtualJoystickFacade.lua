-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/joystick/facade/VirtualJoystickFacade.lua

module("logic.extensions.joystick.facade.VirtualJoystickFacade", package.seeall)

local VirtualJoystickFacade = class("VirtualJoystickFacade", BaseFacade)

function VirtualJoystickFacade:getVector()
	return VirtualJoystickModel.instance.virtualjyostick:GetVector(0, 0, 0)
end

function VirtualJoystickFacade:getAutoMovePointList(beginPos, endPos)
	return
end

function VirtualJoystickFacade:isCanMove(x, z, tx, tz)
	return
end

function VirtualJoystickFacade:setSmallJoystickModel(isSmallJoystickModel)
	VirtualJoystickModel.instance:setSmallJoystickModel(isSmallJoystickModel)
end

function VirtualJoystickFacade:setViewRoot(rootType)
	VirtualJoystickModel.instance:setViewRoot(rootType)
end

function VirtualJoystickFacade:enable(key)
	VirtualJoystickModel.instance:enable(key)
end

function VirtualJoystickFacade:disable(key)
	VirtualJoystickModel.instance:disable(key)
end

function VirtualJoystickFacade:clearSignal()
	VirtualJoystickModel.instance:clearSignal()
end

VirtualJoystickFacade.instance = VirtualJoystickFacade.New()

return VirtualJoystickFacade
