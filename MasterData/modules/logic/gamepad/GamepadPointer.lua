-- chunkname: @modules/logic/gamepad/GamepadPointer.lua

module("modules.logic.gamepad.GamepadPointer", package.seeall)

local GamepadPointer = class("GamepadPointer", LuaCompBase)

function GamepadPointer:ctor()
	self:__onInit()

	self._go = gohelper.create2d(ViewMgr.instance:getUILayer("Adaption"), "GamepadPointer")
	self._resLoader = PrefabInstantiate.Create(self._go)

	self._resLoader:startLoad("ui/viewres/gamepad/gamepadpointer.prefab", self._onResLoaded, self)

	self._x = 0
	self._y = 0
	self._trans = self._go.transform
	self._moveScale = 25

	recthelper.setAnchor(self._trans, 0, 0)
	self:_onScreenResize()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function GamepadPointer:getPos()
	return self._x, self._y
end

function GamepadPointer:getScreenPos()
	local uiCamera = CameraMgr.instance:getUICamera()

	if uiCamera then
		local v = uiCamera:WorldToScreenPoint(self._trans.position)

		return v.x, v.y
	end
end

function GamepadPointer:setAnchor(x, y)
	self._x = x
	self._y = y

	self:_updatePos()
end

function GamepadPointer:updateX(x)
	self._x = self._x + x * self._moveScale

	self:_updatePos()
end

function GamepadPointer:updateY(y)
	self._y = self._y + y * self._moveScale

	self:_updatePos()
end

function GamepadPointer:_onScreenResize()
	self._screenWidth = 1920

	local rate = UnityEngine.Screen.width / UnityEngine.Screen.height

	if rate > 1.7777777777777777 then
		self._screenWidth = 1080 * rate
	end

	self._halfScreenWidth = self._screenWidth / 2
	self._halfScreenWidthMinus = -self._halfScreenWidth
	self._realHalfScreenHeight = UnityEngine.Screen.height / 2
	self._halfScreenHeight = 540
	self._halfScreenHeightMinus = -540

	self:_updatePos()
end

function GamepadPointer:_updatePos()
	self._x = math.max(self._halfScreenWidthMinus, self._x)
	self._x = math.min(self._halfScreenWidth, self._x)
	self._y = math.max(self._halfScreenHeightMinus, self._y)
	self._y = math.min(self._halfScreenHeight, self._y)

	recthelper.setAnchor(self._trans, self._x, self._y)
end

function GamepadPointer:_onResLoaded()
	return
end

function GamepadPointer:onDestroy()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)

	if self._resLoader then
		self._resLoader:dispose()

		self._resLoader = nil
	end

	self:__onDispose()
end

return GamepadPointer
