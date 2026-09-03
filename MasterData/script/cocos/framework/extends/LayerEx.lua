-- chunkname: @/tmp/or_script/lua_compile/cocos/framework/extends/LayerEx.lua

local Layer = cc.Layer

function Layer:onTouch(callback, isMultiTouches, swallowTouches)
	if type(isMultiTouches) ~= "boolean" then
		isMultiTouches = false
	end

	if type(swallowTouches) ~= "boolean" then
		swallowTouches = false
	end

	self:registerScriptTouchHandler(function(state, ...)
		local args = {
			...
		}
		local event = {
			name = state
		}

		if isMultiTouches then
			args = args[1]

			local points = {}

			for i = 1, #args, 3 do
				local x, y, id = args[i], args[i + 1], args[i + 2]

				points[id] = {
					x = x,
					y = y,
					id = id
				}
			end

			event.points = points
		else
			event.x = args[1]
			event.y = args[2]
		end

		return callback(event)
	end, isMultiTouches, 0, swallowTouches)
	self:setTouchEnabled(true)

	return self
end

function Layer:removeTouch()
	self:unregisterScriptTouchHandler()
	self:setTouchEnabled(false)

	return self
end

function Layer:onKeypad(callback)
	self:registerScriptKeypadHandler(callback)
	self:setKeyboardEnabled(true)

	return self
end

function Layer:removeKeypad()
	self:unregisterScriptKeypadHandler()
	self:setKeyboardEnabled(false)

	return self
end

function Layer:onAccelerate(callback)
	self:registerScriptAccelerateHandler(callback)
	self:setAccelerometerEnabled(true)

	return self
end

function Layer:removeAccelerate()
	self:unregisterScriptAccelerateHandler()
	self:setAccelerometerEnabled(false)

	return self
end
