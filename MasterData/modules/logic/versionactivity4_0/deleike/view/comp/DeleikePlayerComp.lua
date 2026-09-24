-- chunkname: @modules/logic/versionactivity4_0/deleike/view/comp/DeleikePlayerComp.lua

module("modules.logic.versionactivity4_0.deleike.view.comp.DeleikePlayerComp", package.seeall)

local DeleikePlayerComp = class("DeleikePlayerComp", LuaCompBase)
local CULL_DIST = math.sqrt(DeleikeEnum.CubeSize.x^2 + DeleikeEnum.CubeSize.y^2) * 0.5 + DeleikeEnum.PlayerRadius

function DeleikePlayerComp:ctor(goJoystick)
	self.joyStick = MonoHelper.addLuaComOnceToGo(goJoystick, CommonJoystick, CommonJoystick.InputType.Dynamic)
end

function DeleikePlayerComp:init(go)
	self.go = go
	self.transform = go.transform
	self.goCircle = gohelper.findChild(go, "circle")
	self.dirUp = gohelper.findChild(go, "back")
	self.dirDown = gohelper.findChild(go, "front")
	self.dirLeft = gohelper.findChild(go, "left")
	self.dirRight = gohelper.findChild(go, "right")
	self.dirs = {
		self.dirUp,
		self.dirDown,
		self.dirLeft,
		self.dirRight
	}
end

function DeleikePlayerComp:initData(initPos)
	self.posX, self.posY = initPos.x, initPos.y
	self.skillCntMap = {
		0,
		0
	}
	self.curSpeed = DeleikeEnum.PlayerSpeed
	self.isCharging = false

	if self._dragBlocked and self.joyStick and not gohelper.isNil(self.joyStick.go) then
		gohelper.setActive(self.joyStick.go, true)
	end

	self._dragBlocked = false
	self._isMoving = false
	self._restVersion = nil
	self._solidScratch = {}
	self._solidPolyScratch = {}
	self._gridPolyScratch = {}

	TaskDispatcher.cancelTask(self._onCircleTimeout, self)
	gohelper.setActive(self.goCircle, false)

	self._touchingEdge = false

	for i = 1, #self.dirs do
		gohelper.setActive(self.dirs[i], false)
	end

	self._curDirGo = self.dirDown

	gohelper.setActive(self._curDirGo, true)
	self:_syncRt()
end

function DeleikePlayerComp:addEventListeners()
	self._updateHandle = FixedUpdateBeat:CreateListener(self.onFixedUpdate, self)

	FixedUpdateBeat:AddListener(self._updateHandle)
end

function DeleikePlayerComp:removeEventListeners()
	if self._updateHandle then
		FixedUpdateBeat:RemoveListener(self._updateHandle)

		self._updateHandle = nil
	end
end

function DeleikePlayerComp:onDestroy()
	TaskDispatcher.cancelTask(self._onCircleTimeout, self)

	self.joyStick = nil
end

function DeleikePlayerComp:_syncRt()
	recthelper.setAnchor(self.transform, self.posX, self.posY)
end

function DeleikePlayerComp:getLogicPos()
	return self.posX, self.posY
end

function DeleikePlayerComp:setPos(x, y)
	self.posX, self.posY = x, y

	self:_syncRt()
end

function DeleikePlayerComp:setCharging(bool)
	self.isCharging = bool
end

function DeleikePlayerComp:onFixedUpdate()
	if DeleikeGameMgr.instance.inputLocked then
		return
	end

	if self.isCharging then
		self.curSpeed = DeleikeEnum.PlayerSlowSpeed or DeleikeEnum.PlayerSpeed
	end

	local inputX, inputY = 0, 0

	if self.joyStick and not self:_isDragInputBlocked() then
		inputX, inputY = self.joyStick:getInput()
	end

	self:_updateDirVisual(inputX, inputY)

	local lenSq = inputX * inputX + inputY * inputY
	local moving = lenSq > 0.0001

	if moving ~= self._isMoving then
		self._isMoving = moving

		AudioMgr.instance:trigger(AudioEnum4_0.Deleike.player_move)
	end

	if moving then
		local len = math.sqrt(lenSq)
		local dt = Time.deltaTime

		self.posX = self.posX + inputX / len * self.curSpeed * dt
		self.posY = self.posY + inputY / len * self.curSpeed * dt
	end

	local unitCoord = DeleikeGameMgr.instance.unitCoord

	if unitCoord then
		if not unitCoord.sceneVersion then
			local sceneVersion = 0

			if not moving and (not unitCoord or not unitCoord:isTweening()) and self._restPosX == self.posX and self._restPosY == self.posY and self._restVersion == sceneVersion then
				return
			end

			local gridTouching = self:_clampToGridArea()
			local solidTouching = self:_resolveCollisions()

			self:_setEdgeTouching(gridTouching or solidTouching)
			self:_pollPickups()
			self:_syncRt()
			self:_followCamera()

			self._restPosX, self._restPosY = self.posX, self.posY
			self._restVersion = sceneVersion
		end
	end
end

function DeleikePlayerComp:_followCamera()
	local mgr = DeleikeGameMgr.instance
	local sceneRt = mgr.sceneRootRt

	if not sceneRt then
		return
	end

	local camPos = sceneRt.anchoredPosition
	local camX, camY = camPos.x, camPos.y
	local rect = sceneRt.rect
	local limitX = rect.width * 0.5 - DeleikeEnum.CameraEdgeMargin
	local limitY = rect.height * 0.5 - DeleikeEnum.CameraEdgeMargin

	if limitX < 0 then
		limitX = 0
	end

	if limitY < 0 then
		limitY = 0
	end

	local viewX = self.posX + camX
	local viewY = self.posY + camY
	local dx, dy = 0, 0

	if limitX < viewX then
		dx = viewX - limitX
	elseif viewX < -limitX then
		dx = viewX + limitX
	end

	if limitY < viewY then
		dy = viewY - limitY
	elseif viewY < -limitY then
		dy = viewY + limitY
	end

	if dx ~= 0 or dy ~= 0 then
		recthelper.setAnchor(sceneRt, camX - dx, camY - dy)
	end
end

function DeleikePlayerComp:_isDragInputBlocked()
	local skillMgr = DeleikeGameMgr.instance.skillMgr
	local blocked = skillMgr ~= nil and skillMgr.skill2 ~= nil and skillMgr.skill2.dragActive == true

	if blocked ~= self._dragBlocked then
		self._dragBlocked = blocked

		if self.joyStick and not gohelper.isNil(self.joyStick.go) then
			gohelper.setActive(self.joyStick.go, not blocked)
		end
	end

	return blocked
end

function DeleikePlayerComp:_updateDirVisual(inputX, inputY)
	local lenSq = inputX * inputX + inputY * inputY

	if lenSq <= 0.0001 then
		return
	end

	local dirGo = math.abs(inputX) >= math.abs(inputY) and (inputX > 0 and self.dirRight or self.dirLeft) or inputY > 0 and self.dirUp or self.dirDown

	if self._curDirGo ~= dirGo then
		if self._curDirGo and not gohelper.isNil(self._curDirGo) then
			gohelper.setActive(self._curDirGo, false)
		end

		gohelper.setActive(dirGo, true)

		self._curDirGo = dirGo
	end
end

function DeleikePlayerComp:_clampToGridArea()
	local unitCoord = DeleikeGameMgr.instance.unitCoord

	if not unitCoord then
		return false
	end

	local unitList = unitCoord.unitList
	local polys = self._gridPolyScratch

	tabletool.clear(polys)

	for i = 1, #unitList do
		local comp = unitList[i]
		local mo = comp.mo

		if mo and mo.tileType == DeleikeEnum.TileType.Grid and not gohelper.isNil(comp.go) then
			polys[#polys + 1] = comp:getWorldPolygon()
		end
	end

	local px, py = self.posX, self.posY
	local r = DeleikeEnum.PlayerRadius
	local hostPoly

	for i = 1, #polys do
		if DeleikeCollision.pointInConvexPoly(px, py, polys[i]) then
			hostPoly = polys[i]

			break
		end
	end

	if not hostPoly then
		local bestX, bestY = px, py
		local bestDSq = math.huge

		for i = 1, #polys do
			local nx, ny = DeleikeCollision.circleClampInsidePoly(px, py, r, polys[i])
			local dx, dy = nx - px, ny - py
			local dSq = dx * dx + dy * dy

			if dSq < bestDSq then
				bestY = ny
				bestX = nx
				bestDSq = dSq
			end
		end

		self.posX, self.posY = bestX, bestY

		return true
	end

	local curX, curY = px, py
	local n = #hostPoly

	for _ = 1, 4 do
		local worstD = r
		local wnx, wny = 0, 0

		for i = 1, n do
			local a = hostPoly[i]
			local b = hostPoly[i % n + 1]
			local ex, ey = b.x - a.x, b.y - a.y
			local nx, ny = -ey, ex
			local len = math.sqrt(nx * nx + ny * ny)

			if len > 1e-06 then
				ny = ny / len
				nx = nx / len

				local d = nx * (curX - a.x) + ny * (curY - a.y)

				if d < worstD then
					local qx, qy = curX - nx * r, curY - ny * r
					local covered = false

					for oj = 1, #polys do
						if polys[oj] ~= hostPoly and DeleikeCollision.pointInConvexPoly(qx, qy, polys[oj], 1) then
							covered = true

							break
						end
					end

					if not covered then
						wny = ny
						wnx = nx
						worstD = d
					end
				end
			end
		end

		if r <= worstD then
			break
		end

		curX = curX + wnx * (r - worstD)
		curY = curY + wny * (r - worstD)
	end

	local dx, dy = curX - px, curY - py

	self.posX, self.posY = curX, curY

	return dx * dx + dy * dy > 1e-08
end

function DeleikePlayerComp:_setEdgeTouching(touching)
	if touching then
		if not self._touchingEdge then
			self._touchingEdge = true

			gohelper.setActive(self.goCircle, false)
			gohelper.setActive(self.goCircle, true)
		end

		TaskDispatcher.cancelTask(self._onCircleTimeout, self)
		TaskDispatcher.runDelay(self._onCircleTimeout, self, DeleikeEnum.CircleShowTime)
	else
		self._touchingEdge = false
	end
end

function DeleikePlayerComp:_onCircleTimeout()
	gohelper.setActive(self.goCircle, false)
end

function DeleikePlayerComp:_resolveCollisions()
	local unitCoord = DeleikeGameMgr.instance.unitCoord

	if not unitCoord then
		return false
	end

	local cullSq = CULL_DIST * CULL_DIST
	local unitList = unitCoord.unitList
	local solids = self._solidScratch
	local polyScratch = self._solidPolyScratch
	local sc = 0

	for i = 1, #unitList do
		local comp = unitList[i]
		local mo = comp.mo

		if mo and not gohelper.isNil(comp.go) then
			local t = mo.tileType

			if t ~= DeleikeEnum.TileType.Bg and t ~= DeleikeEnum.TileType.Grid and t ~= DeleikeEnum.TileType.Line then
				sc = sc + 1
				solids[sc] = comp
				polyScratch[sc] = comp:getWorldPolygon()
			end
		end
	end

	for i = #solids, sc + 1, -1 do
		solids[i] = nil
		polyScratch[i] = nil
	end

	local touched = false

	for _ = 1, 3 do
		local pushed = false

		for i = 1, sc do
			local mo = solids[i].mo
			local dx = self.posX - mo.pos.x
			local dy = self.posY - mo.pos.y

			if cullSq >= dx * dx + dy * dy then
				local nx, ny = DeleikeCollision.circlePushOutOfPoly(self.posX, self.posY, DeleikeEnum.PlayerRadius, polyScratch[i])

				if nx ~= self.posX or ny ~= self.posY then
					self.posX, self.posY = nx, ny
					pushed = true
					touched = true
				end
			end
		end

		if not pushed then
			break
		end
	end

	return touched
end

function DeleikePlayerComp:_pollPickups()
	local unitCoord = DeleikeGameMgr.instance.unitCoord

	if not unitCoord then
		return
	end

	local triggers = unitCoord.triggerList

	for i = 1, #triggers do
		local comp = triggers[i]

		if not comp.isCollected and not gohelper.isNil(comp.go) then
			comp:tryPickup(self.posX, self.posY)
		end
	end
end

function DeleikePlayerComp:getSkillCount(skillId)
	return self.skillCntMap[skillId] or 0
end

function DeleikePlayerComp:setSkillCount(skillId, count, isAdd)
	self.skillCntMap[skillId] = count

	DeleikeController.instance:dispatchEvent(DeleikeEvent.SkillCntChange, skillId, isAdd)

	if isAdd then
		DeleikeController.instance:dispatchEvent(DeleikeEvent.ZTriggerGetSkill, skillId)
	end
end

return DeleikePlayerComp
