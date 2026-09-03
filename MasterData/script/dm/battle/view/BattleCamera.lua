-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleCamera.lua

BattleCamera = class("BattleCamera")

function BattleCamera:initialize(vw, vh)
	super.initialize(self)

	self._viewWidth = vw
	self._viewHeight = vh
	self._baseScale = 1
	self._scale = 1
	self._center = {
		vw * 0.5,
		vh * 0.5
	}
	self._disturbance = {
		0,
		0,
		1
	}
end

function BattleCamera:setBaseScale(value)
	if self._baseScale == value then
		return
	end

	self._baseScale = value
	self._transform = nil
end

function BattleCamera:getBaseScale()
	return self._baseScale
end

function BattleCamera:setScale(value)
	if self._scale == value then
		return
	end

	self._scale = value
	self._transform = nil
end

function BattleCamera:getScale()
	return self._scale
end

function BattleCamera:lookAt(x, y)
	local center = self._center

	if center[1] == x and center[2] == y then
		return
	end

	center[1], center[2] = x, y
	self._transform = nil
end

function BattleCamera:getCenter()
	local center = self._center

	return center[1], center[2]
end

function BattleCamera:setDisturbance(x, y, scale)
	local disturbance = self._disturbance

	if disturbance[1] == x and disturbance[2] == y and disturbance[3] == scale then
		return
	end

	disturbance[1], disturbance[2], disturbance[3] = x, y, scale or 1
	self._transform = nil
end

function BattleCamera:getDisturbance()
	local disturbance = self._disturbance

	return disturbance[1], disturbance[2], disturbance[3]
end

function BattleCamera:getTransform()
	local transform = self._transform

	if transform ~= nil then
		return transform
	end

	local scale = self._baseScale * self._scale
	local center = self._center
	local width, height = self._viewWidth, self._viewHeight
	local cx, cy = center[1], center[2]

	if scale > 1 then
		local factor = 0.47 / scale
		local rw, rh = width * factor, height * factor

		if cx < rw then
			cx = rw
		elseif cx > width - rw then
			cx = width - rw
		end

		if cy < rh then
			cy = rh
		elseif cy > height - rh then
			cy = height - rh
		end
	else
		cy = height * 0.5
		cx = width * 0.5
	end

	local disturbance = self._disturbance

	scale = scale * disturbance[3]
	cy = cy + disturbance[2]
	cx = cx + disturbance[1]
	transform = {
		c = 0,
		b = 0,
		a = scale,
		d = scale,
		tx = -cx * scale + width * 0.5,
		ty = -cy * scale + height * 0.5
	}
	self._transform = transform

	return transform
end

function BattleCamera:applyTransformOnNodes(nodes)
	if nodes then
		local transform = self:getTransform()

		for i = 1, #nodes do
			nodes[i]:setAdditionalTransform(transform)
		end
	end
end

function BattleCamera:workOnNodes(nodes)
	self._targetNodes = nodes

	self:applyTransformOnNodes(nodes)
end

function BattleCamera:focusOn(x, y, scale, time)
	if time == nil or time <= 0 then
		self:setScale(scale)
		self:lookAt(x, y)

		self._focusAction = nil
	else
		local cx, cy = self:getCenter()
		local s0 = self:getScale()
		local finalOffsetX = x - cx
		local offset = (1386 * scale - display.width) / 2

		if s0 <= scale and offset < math.abs(finalOffsetX) and math.abs(x - cx) > 0 then
			finalOffsetX = (x - cx) / math.abs(x - cx) * offset / scale
		end

		if self._deltaX and self._deltaX == finalOffsetX then
			finalOffsetX = 0
		end

		local action = {
			time = time,
			deltaX = finalOffsetX,
			deltaY = y - cy,
			x0 = cx,
			y0 = cy,
			deltaS = scale - s0,
			s0 = s0
		}

		action.current = action
		self._focusAction = action
		self._deltaX = finalOffsetX
	end
end

function BattleCamera:shake(path, interval, amplitude)
	if path == nil or #path == 0 then
		self:setDisturbance(0, 0, 1)

		self._shakeAction = nil
	else
		local segments = {}

		if amplitude == nil then
			amplitude = 1
		end

		local x_k, y_k, s_k = self:getDisturbance()

		for i = 1, #path do
			local elem = path[i]
			local x = elem[1] * amplitude
			local y = elem[2] * amplitude

			if not elem[3] then
				segments[i] = {
					time = interval,
					deltaX = x - x_k,
					deltaY = y - y_k,
					x0 = x_k,
					y0 = y_k,
					deltaS = elem[3] - s_k,
					s0 = s_k
				}
				s_k = elem[3]
				y_k = y
				x_k = x
			end
		end

		if x_k ~= 0 or y_k ~= 0 or s_k ~= 1 then
			segments[#segments + 1] = {
				time = interval,
				deltaX = -x_k,
				deltaY = -y_k,
				x0 = x_k,
				y0 = y_k,
				deltaS = 1 - s_k,
				s0 = s_k
			}
		end

		segments.time = interval
		segments.idx = 1
		segments.current = segments[1]
		self._shakeAction = segments
	end
end

local function calcAndUpdateActionProgress(action, dt)
	if action.elapsed then
		if not (action.elapsed + dt) then
			local elapsed = 0

			action.elapsed = elapsed

			if elapsed < action.time then
				return elapsed / action.time, action.current, false
			else
				if action.idx == nil then
					return 1, action.current, true
				end

				local time = action.time

				while true do
					local idx = action.idx + 1
					local current = action[idx]

					if current == nil then
						return 1, action.current, true
					end

					action.idx = idx
					action.current = current
					elapsed = elapsed - time
					time = current.time

					if elapsed < current.time then
						action.time = time
						action.elapsed = elapsed

						return elapsed / time, action.current, false
					end
				end
			end
		end
	end
end

function BattleCamera:update(dt)
	local focusAction = self._focusAction

	if focusAction ~= nil then
		local p, value, done = calcAndUpdateActionProgress(focusAction, dt)
		local x = value.x0 + value.deltaX * p
		local y = value.y0 + value.deltaY * p

		self:lookAt(x, y)

		local s = value.s0 + value.deltaS * p

		self:setScale(s)

		if done then
			self._focusAction = nil
		end
	end

	local shakeAction = self._shakeAction

	if shakeAction ~= nil then
		local p, value, done = calcAndUpdateActionProgress(shakeAction, dt)
		local x = value.x0 + value.deltaX * p
		local y = value.y0 + value.deltaY * p
		local s = value.s0 + value.deltaS * p

		self:setDisturbance(x, y, s)

		if done then
			self._shakeAction = nil
		end
	end

	if self._transform == nil and self._targetNodes ~= nil then
		self:applyTransformOnNodes(self._targetNodes)
	end
end
