-- chunkname: @modules/logic/versionactivity4_0/deleike/model/DeleikeUnitCoord.lua

module("modules.logic.versionactivity4_0.deleike.model.DeleikeUnitCoord", package.seeall)

local DeleikeUnitCoord = class("DeleikeUnitCoord")
local Time = UnityEngine.Time
local MOVE_DURATION = 0.3

function DeleikeUnitCoord:ctor()
	self.units = {}
	self.unitList = {}
	self.triggerList = {}
	self._moveTweens = {}
	self.sceneVersion = 0
	self._dragActive = false
	self._dragPerpX, self._dragPerpY = 0, 1
	self._dragMaxShift = 0
	self._dragOriginX, self._dragOriginY = 0, 0
	self._dragItems = {}

	UpdateBeat:Add(self.onUpdate, self)
end

function DeleikeUnitCoord:dispose()
	UpdateBeat:Remove(self.onUpdate, self)
end

function DeleikeUnitCoord:bumpSceneVersion()
	self.sceneVersion = self.sceneVersion + 1
end

function DeleikeUnitCoord:isTweening()
	return #self._moveTweens > 0
end

function DeleikeUnitCoord:registerUnit(comp)
	if not comp or not comp.go or gohelper.isNil(comp.go) then
		return
	end

	local id = comp.go:GetInstanceID()

	if self.units[id] then
		return
	end

	self.units[id] = comp

	table.insert(self.unitList, comp)

	if comp.tryPickup then
		table.insert(self.triggerList, comp)
	end

	self:bumpSceneVersion()
end

function DeleikeUnitCoord:unregisterUnit(comp)
	if not comp or not comp.go or gohelper.isNil(comp.go) then
		return
	end

	local id = comp.go:GetInstanceID()

	if not self.units[id] then
		return
	end

	self.units[id] = nil

	for i = 1, #self.unitList do
		if self.unitList[i] == comp then
			table.remove(self.unitList, i)

			break
		end
	end

	if comp.tryPickup then
		for i = 1, #self.triggerList do
			if self.triggerList[i] == comp then
				table.remove(self.triggerList, i)

				break
			end
		end
	end

	self:bumpSceneVersion()
end

function DeleikeUnitCoord:getAllUnits()
	local result = {}

	for i = 1, #self.unitList do
		table.insert(result, self.unitList[i])
	end

	return result
end

function DeleikeUnitCoord:_getUnitPos(comp)
	return comp:getLogicPos()
end

function DeleikeUnitCoord:_setUnitPos(comp, x, y)
	comp:setLogicPos(x, y)
end

function DeleikeUnitCoord:getCentroid(comp)
	if comp.mo and comp.getWorldPolygon then
		local poly = comp:getWorldPolygon()
		local sx, sy = 0, 0

		for i = 1, #poly do
			sx = sx + poly[i].x
			sy = sy + poly[i].y
		end

		return sx / #poly, sy / #poly
	end

	return self:_getUnitPos(comp)
end

function DeleikeUnitCoord:moveUnit(comp, dx, dy)
	if not comp or not comp.go or gohelper.isNil(comp.go) then
		return
	end

	local x, y = self:_getUnitPos(comp)

	self:_setUnitPos(comp, x + dx, y + dy)
	self:bumpSceneVersion()
end

function DeleikeUnitCoord:dragUnitsByOffset(comps, dx, dy)
	if not comps then
		return
	end

	for i = 1, #comps do
		self:moveUnit(comps[i], dx, dy)
	end
end

function DeleikeUnitCoord:killTweensOf(comps)
	if not comps or #comps == 0 or #self._moveTweens == 0 then
		return
	end

	local targets = {}

	for i = 1, #comps do
		targets[comps[i]] = true
	end

	for ti = #self._moveTweens, 1, -1 do
		local items = self._moveTweens[ti].items

		for ii = #items, 1, -1 do
			if targets[items[ii].comp] then
				table.remove(items, ii)
			end
		end

		if #items == 0 then
			table.remove(self._moveTweens, ti)
		end
	end
end

function DeleikeUnitCoord:clearAllTweens()
	self._moveTweens = {}
end

function DeleikeUnitCoord:moveUnitsAnimated(comps, dx, dy)
	if not comps or #comps == 0 then
		return
	end

	self:killTweensOf(comps)

	local items = {}

	for i = 1, #comps do
		local comp = comps[i]

		if comp and comp.go and not gohelper.isNil(comp.go) then
			local x, y = self:_getUnitPos(comp)

			table.insert(items, {
				comp = comp,
				x = x,
				y = y
			})
		end
	end

	if #items > 0 then
		table.insert(self._moveTweens, {
			elapsed = 0,
			items = items,
			dx = dx,
			dy = dy
		})
		self:bumpSceneVersion()
	end
end

function DeleikeUnitCoord:onUpdate()
	local dt = Time.deltaTime

	for ti = #self._moveTweens, 1, -1 do
		local tween = self._moveTweens[ti]

		tween.elapsed = tween.elapsed + dt

		local t = tween.elapsed / MOVE_DURATION

		if t > 1 then
			t = 1
		end

		local eased = t * t * (3 - 2 * t)

		for i = 1, #tween.items do
			local item = tween.items[i]

			if not gohelper.isNil(item.comp.go) then
				self:_setUnitPos(item.comp, item.x + tween.dx * eased, item.y + tween.dy * eased)
			end
		end

		if t >= 1 then
			table.remove(self._moveTweens, ti)
		end
	end
end

function DeleikeUnitCoord:dragStart(targets, perpX, perpY, maxShift, originX, originY)
	self._dragActive = true
	self._dragPerpX, self._dragPerpY = perpX, perpY
	self._dragMaxShift = maxShift
	self._dragOriginX, self._dragOriginY = originX, originY
	self._dragItems = {}

	if not targets then
		return
	end

	for i = 1, #targets do
		local comp = targets[i]

		if comp and comp.go and not gohelper.isNil(comp.go) then
			local x, y = self:_getUnitPos(comp)

			table.insert(self._dragItems, {
				comp = comp,
				startX = x,
				startY = y,
				clipBaseX = x,
				clipBaseY = y
			})
		end
	end
end

function DeleikeUnitCoord:dragUpdate(mouseX, mouseY)
	if not self._dragActive then
		return
	end

	local offX = mouseX - self._dragOriginX
	local offY = mouseY - self._dragOriginY
	local projection = offX * self._dragPerpX + offY * self._dragPerpY
	local maxPerpComp = math.max(math.abs(self._dragPerpX), math.abs(self._dragPerpY))
	local effectiveMax = self._dragMaxShift / math.max(maxPerpComp, 0.001)

	for i = 1, #self._dragItems do
		local item = self._dragItems[i]

		if not gohelper.isNil(item.comp.go) then
			local currentTotal = (item.startX - item.clipBaseX) * self._dragPerpX + (item.startY - item.clipBaseY) * self._dragPerpY
			local newTotal = currentTotal + projection
			local clamped = projection

			if effectiveMax < newTotal then
				clamped = effectiveMax - currentTotal
			elseif newTotal < -effectiveMax then
				clamped = -effectiveMax - currentTotal
			end

			self:_setUnitPos(item.comp, item.startX + self._dragPerpX * clamped, item.startY + self._dragPerpY * clamped)
		end
	end
end

function DeleikeUnitCoord:dragEnd()
	self._dragActive = false
	self._dragItems = {}
end

function DeleikeUnitCoord:getUnitsBehindB(bx, by, dirX, dirY)
	local result = {}
	local bProj = bx * dirX + by * dirY

	for i = 1, #self.unitList do
		local comp = self.unitList[i]

		if comp.go and not gohelper.isNil(comp.go) then
			local cx, cy = self:getCentroid(comp)
			local proj = cx * dirX + cy * dirY

			if bProj < proj then
				table.insert(result, comp)
			end
		end
	end

	return result
end

function DeleikeUnitCoord:getUnitsInFrontB(bx, by, dirX, dirY)
	local result = {}
	local bProj = bx * dirX + by * dirY

	for i = 1, #self.unitList do
		local comp = self.unitList[i]

		if comp.go and not gohelper.isNil(comp.go) then
			local cx, cy = self:getCentroid(comp)
			local proj = cx * dirX + cy * dirY

			if proj <= bProj then
				table.insert(result, comp)
			end
		end
	end

	return result
end

function DeleikeUnitCoord:clearAll()
	self.units = {}
	self.unitList = {}
	self.triggerList = {}
	self._moveTweens = {}

	self:dragEnd()
	self:bumpSceneVersion()
end

return DeleikeUnitCoord
