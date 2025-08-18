-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\TouchManager.lua

local Const = Const
local TouchManager = {}

TouchManager._enabled = true
TouchManager._eventHandlers = {}

function TouchManager.register(touchType, handler)
	if handler == nil then
		return false
	end

	if TouchManager._eventHandlers[touchType] == nil then
		TouchManager._eventHandlers[touchType] = {}
	end

	local handlers = TouchManager._eventHandlers[touchType]

	table.insert(handlers, handler)

	return true
end

function TouchManager.unregister(touchType, handler)
	local handlers = TouchManager._eventHandlers[touchType]

	if handlers then
		for i, v in pairs(handlers) do
			if v == handler then
				table.remove(handlers, i)

				break
			end
		end
	end
end

function TouchManager.enabled(isEnbled)
	TouchManager._enabled = isEnbled

	TouchManager.easyTouch:SetEnable(isEnbled)
end

function TouchManager.clearAll()
	TouchManager._eventHandlers = {}
end

function TouchManager.__activeFunc(touchType, gesture)
	if TouchManager._enabled == false then
		return
	end

	local handlers = TouchManager._eventHandlers[touchType]

	if handlers then
		for _, handler in pairs(handlers) do
			handler(gesture)
		end
	end
end

function TouchManager.OnSimpleTap(gesture)
	TouchManager.__activeFunc(Const.TOUCH_SIMPLETAP, gesture)
end

function TouchManager.OnLongTap(gesture)
	TouchManager.__activeFunc(Const.TOUCH_LONGTAP, gesture)
end

function TouchManager.On_TouchStart(gesture)
	TouchManager.__activeFunc(Const.TOUCH_DOWN, gesture)
end

function TouchManager.OnTouchUp(gesture)
	TouchManager.__activeFunc(Const.TOUCH_UP, gesture)
end

function TouchManager.OnPinchIn(gesture)
	TouchManager.__activeFunc(Const.TOUCH_PINCHIN, gesture)
end

function TouchManager.OnPinchOut(gesture)
	TouchManager.__activeFunc(Const.TOUCH_PINCHOUT, gesture)
end

function TouchManager.OnSwipe(gesture)
	TouchManager.__activeFunc(Const.TOUCH_SWIPE, gesture)
end

function TouchManager.OnDragStart(gesture)
	TouchManager.__activeFunc(Const.TOUCH_DRAGSTART, gesture)
end

TouchManager.easyTouch = Framework.Tools.TouchDelegate.GetInstance(TouchManager)

return TouchManager
