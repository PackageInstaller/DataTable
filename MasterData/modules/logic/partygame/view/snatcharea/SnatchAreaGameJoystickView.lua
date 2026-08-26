-- chunkname: @modules/logic/partygame/view/snatcharea/SnatchAreaGameJoystickView.lua

module("modules.logic.partygame.view.snatcharea.SnatchAreaGameJoystickView", package.seeall)

local SnatchAreaGameJoystickView = class("SnatchAreaGameJoystickView", BaseView)

function SnatchAreaGameJoystickView:onInitView()
	self.goJoystick = gohelper.findChild(self.viewGO, "root/left/go_joystick")
	self.interface = PartyGameCSDefine.SnatchAreaInterfaceCs
end

function SnatchAreaGameJoystickView:addEvents()
	return
end

function SnatchAreaGameJoystickView:removeEvents()
	return
end

function SnatchAreaGameJoystickView:frameTick()
	local curState = self.interface.GetCurState()

	if curState == SnatchEnum.GameState.Playing then
		gohelper.setActive(self.goJoystick, true)
	else
		gohelper.setActive(self.goJoystick, false)
	end
end

function SnatchAreaGameJoystickView:onOpen()
	self:createJoystick()
end

function SnatchAreaGameJoystickView:createJoystick()
	local itemRes = self.viewContainer:getSetting().otherRes.joystick
	local go = self.viewContainer:getResInst(itemRes, self.goJoystick)

	self.joystickComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, JoystickComp)
end

function SnatchAreaGameJoystickView:onDestroyView()
	return
end

return SnatchAreaGameJoystickView
