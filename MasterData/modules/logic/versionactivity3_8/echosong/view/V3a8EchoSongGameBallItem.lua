-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongGameBallItem.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongGameBallItem", package.seeall)

local V3a8EchoSongGameBallItem = class("V3a8EchoSongGameBallItem")

function V3a8EchoSongGameBallItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8EchoSongGameBallItem:addEvents()
	return
end

function V3a8EchoSongGameBallItem:removeEvents()
	return
end

function V3a8EchoSongGameBallItem:_init(go)
	self.viewGO = go

	self:onInitView()
end

function V3a8EchoSongGameBallItem:_editableInitView()
	self._pos = Vector3.New(0, 0, 0)
	self._rayOrigin = Vector3.New(0, 0, 0)
	self._meshRenderer = self.viewGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	self._tempVector1 = Vector3.New(0, 0, 0)
	self._tempVector2 = Vector3.New(0, 0, 0)
	self._moveDir = Vector2.New(0, 0)
	self._maxReflectCount = V3a8EchoSongEnum.BallConst.MaxReflectCount
	self._trailPoints = {}

	for i = 1, self._maxReflectCount + 2 do
		self._trailPoints[i] = Vector3.New(0, 0, 0)
	end

	self._trailPointCount = 0
	self._reflectCount = 0
	self._segLens = {}

	for i = 1, self._maxReflectCount + 1 do
		self._segLens[i] = 0
	end

	self._hitNormalX = 0
	self._hitNormalY = 0
	self._parentTransform = self.viewGO.transform.parent

	self:_initReflection()
end

function V3a8EchoSongGameBallItem:_initReflection()
	require("tolua.reflection")
	tolua.loadassembly("SL_AS")

	local type = tolua.findtype("UnityEngine.LineRenderer")

	self._lineCompProperty = tolua.getproperty(type, "positionCount")
	self._lineCompMethod = tolua.getmethod(type, "SetPosition", typeof("System.Int32"), typeof(Vector3))
	self._lineComp = self.viewGO:GetComponent("LineRenderer")
end

function V3a8EchoSongGameBallItem:_hideLine()
	if self._lineComp then
		self._lineCompProperty:Set(self._lineComp, 0, nil)
	end
end

function V3a8EchoSongGameBallItem:_pushTrailPoint(worldX, worldY)
	local idx = self._trailPointCount + 1

	if idx > #self._trailPoints then
		return
	end

	local px, py = 0, 0

	if self._parentTransform then
		px, py = transformhelper.getPos(self._parentTransform)
	end

	self._trailPoints[idx]:Set(worldX - px, worldY - py, 0)

	self._trailPointCount = idx
end

function V3a8EchoSongGameBallItem:_calcChaseProgress()
	local startRatio = V3a8EchoSongEnum.BallConst.TrailChaseStartRatio
	local endRatio = V3a8EchoSongEnum.BallConst.TrailChaseEndRatio

	if not V3a8EchoSongEnum.BallConst.TrailChaseMaxRatio then
		local maxRatio = 1

		if maxRatio <= 0 then
			return 0
		end

		if maxRatio > 1 then
			maxRatio = 1
		end

		if not startRatio or not endRatio or endRatio <= startRatio then
			return 0
		end

		if not self._lifeTime or self._lifeTime <= 0 or not self._startTime then
			return 0
		end

		local lifeProgress = (Time.time - self._startTime) / self._lifeTime

		if lifeProgress <= startRatio then
			return 0
		end

		local raw = endRatio <= lifeProgress and 1 or (lifeProgress - startRatio) / (endRatio - startRatio)

		if maxRatio < raw then
			raw = maxRatio
		end

		return raw
	end
end

function V3a8EchoSongGameBallItem:_updateTrail()
	if not self._lineComp then
		return
	end

	local count = self._trailPointCount

	if count <= 0 then
		self._lineCompProperty:Set(self._lineComp, 0, nil)

		return
	end

	local px, py = 0, 0

	if self._parentTransform then
		px, py = transformhelper.getPos(self._parentTransform)
	end

	local chaseProgress = self:_calcChaseProgress()

	if chaseProgress <= 0 then
		local total = count + 1

		self._lineCompProperty:Set(self._lineComp, total, nil)

		for i = 1, count do
			local p = self._trailPoints[i]

			self._tempVector2:Set(p.x + px, p.y + py, 0)
			self._lineCompMethod:Call(self._lineComp, i - 1, self._tempVector2)
		end

		self._tempVector1:Set(self._pos.x, self._pos.y, 0)
		self._lineCompMethod:Call(self._lineComp, total - 1, self._tempVector1)

		return
	end

	if chaseProgress >= 1 then
		self._lineCompProperty:Set(self._lineComp, 0, nil)

		return
	end

	local totalLen = 0
	local segLens = self._segLens
	local prevX, prevY

	do
		local p = self._trailPoints[1]

		prevY = p.y + py
		prevX = p.x + px
	end

	for k = 1, count do
		local curX, curY

		if count >= k + 1 then
			local p = self._trailPoints[k + 1]

			curY = p.y + py
			curX = p.x + px
		else
			curY = self._pos.y
			curX = self._pos.x
		end

		local dx = curX - prevX
		local dy = curY - prevY
		local len = math.sqrt(dx * dx + dy * dy)

		segLens[k] = len
		totalLen = totalLen + len
		prevY = curY
		prevX = curX
	end

	if totalLen <= 0 then
		self._lineCompProperty:Set(self._lineComp, 0, nil)

		return
	end

	local eatLen = totalLen * chaseProgress
	local acc = 0
	local startSeg = count
	local startX, startY

	do
		local p = self._trailPoints[1]

		prevY = p.y + py
		prevX = p.x + px
	end

	for k = 1, count do
		local segLen = segLens[k]
		local nextX, nextY

		if count >= k + 1 then
			local p = self._trailPoints[k + 1]

			nextY = p.y + py
			nextX = p.x + px
		else
			nextY = self._pos.y
			nextX = self._pos.x
		end

		if eatLen <= acc + segLen then
			local remain = eatLen - acc

			if segLen > 0 then
				if not (remain / segLen) then
					local ratio = 1

					startX = prevX + (nextX - prevX) * ratio
					startY = prevY + (nextY - prevY) * ratio
					startSeg = k

					break
				end
			end
		end

		acc = acc + segLen
		prevY = nextY
		prevX = nextX
	end

	if not startX then
		self._lineCompProperty:Set(self._lineComp, 0, nil)

		return
	end

	local firstAnchorIdx = startSeg + 1
	local total = 1 + ((firstAnchorIdx <= count or nil) and count - firstAnchorIdx + 1) + 1

	self._lineCompProperty:Set(self._lineComp, total, nil)
	self._tempVector1:Set(startX, startY, 0)
	self._lineCompMethod:Call(self._lineComp, 0, self._tempVector1)

	local writeIdx = 1

	for i = firstAnchorIdx, count do
		local p = self._trailPoints[i]

		self._tempVector2:Set(p.x + px, p.y + py, 0)
		self._lineCompMethod:Call(self._lineComp, writeIdx, self._tempVector2)

		writeIdx = writeIdx + 1
	end

	self._tempVector1:Set(self._pos.x, self._pos.y, 0)
	self._lineCompMethod:Call(self._lineComp, writeIdx, self._tempVector1)
end

function V3a8EchoSongGameBallItem:_castRayFromCurrent(skipSync)
	self._needInitRaycast = false

	local remainTime = self._lifeTime - (Time.time - self._startTime)

	if remainTime <= 0 then
		self._hitDist = -1

		return
	end

	self._rayOrigin.x = self._pos.x
	self._rayOrigin.y = self._pos.y

	local maxDist = remainTime * self._moveSpeed

	if not skipSync then
		UnityEngine.Physics2D.SyncTransforms()
	end

	local hit = UnityEngine.Physics2D.Raycast(self._rayOrigin, self._moveDir, maxDist, V3a8EchoSongEnum.ColliderLayer)

	if hit and hit.collider ~= nil then
		self._hitDist = hit.distance
		self._hitNormalX = hit.normal.x
		self._hitNormalY = hit.normal.y
	else
		self._hitDist = -1
	end
end

function V3a8EchoSongGameBallItem:_reflectDir()
	local nx, ny = self._hitNormalX, self._hitNormalY
	local dx, dy = self._moveDir.x, self._moveDir.y
	local dot2 = 2 * (dx * nx + dy * ny)

	self._moveDir.x = dx - dot2 * nx
	self._moveDir.y = dy - dot2 * ny

	self._moveDir:SetNormalize()
end

function V3a8EchoSongGameBallItem:_resetState()
	self:_hideLine()

	self._pos.x, self._pos.y = transformhelper.getPos(self.viewGO.transform)
	self._moveSpeed = V3a8EchoSongEnum.BallConst.Speed

	if V3a8EchoSongEnum.BallRandom.Speed > 0 then
		self._moveSpeed = self._moveSpeed + math.random(-V3a8EchoSongEnum.BallRandom.Speed, V3a8EchoSongEnum.BallRandom.Speed)
	end

	self._startTime = Time.time
	self._lifeTime = V3a8EchoSongEnum.ParticleLifeTime.Long
	self._isHit = false
	self._hitDist = -1
	self._movedDist = 0
	self._reflectCount = 0
	self._trailPointCount = 0
	self._hitNormalX = 0
	self._hitNormalY = 0

	transformhelper.setLocalRotation(self.viewGO.transform, 0, 0, math.random(0, 360))
end

function V3a8EchoSongGameBallItem:setMatGroup(matGroup)
	if not matGroup then
		return
	end

	if self._meshRenderer then
		self._meshRenderer.sharedMaterial = matGroup.ballMat
	end

	if self._lineComp then
		self._lineComp.sharedMaterial = matGroup.lineMat
	end
end

function V3a8EchoSongGameBallItem:getPos()
	return self._pos
end

function V3a8EchoSongGameBallItem:setTriggerType(type)
	self._triggerType = type

	if not type then
		logError("V3a8EchoSongGameBallItem:setTriggerType type is nil")
	end
end

function V3a8EchoSongGameBallItem:getTriggerType()
	return self._triggerType
end

function V3a8EchoSongGameBallItem:update(deltaTime, needRaycast)
	local time = Time.time - self._startTime

	if time > self._lifeTime then
		return
	end

	if not self._moveDir or not self.viewGO then
		return
	end

	self._pos.x, self._pos.y = transformhelper.getPos(self.viewGO.transform)

	if self._needInitRaycast then
		if needRaycast ~= false then
			self:_castRayFromCurrent(true)
		else
			return
		end
	end

	local curFrameDist = self._moveSpeed * deltaTime

	if self._hitDist >= 0 and self._movedDist + curFrameDist >= self._hitDist then
		local remain = self._hitDist - self._movedDist
		local hitX = self._pos.x + self._moveDir.x * remain
		local hitY = self._pos.y + self._moveDir.y * remain

		self._rayOrigin.x = hitX
		self._rayOrigin.y = hitY

		self._mainView:addHitBall(self._rayOrigin)

		self._reflectCount = self._reflectCount + 1

		if self._reflectCount > self._maxReflectCount then
			self._isHit = true

			return
		end

		self:_pushTrailPoint(hitX, hitY)
		self:_reflectDir()

		local epsilon = V3a8EchoSongEnum.BallConst.ReflectEpsilon

		self._pos.x = hitX + self._hitNormalX * epsilon
		self._pos.y = hitY + self._hitNormalY * epsilon

		transformhelper.setPosXY(self.viewGO.transform, self._pos.x, self._pos.y)

		self._movedDist = 0

		self:_castRayFromCurrent(true)
		self:_updateTrail()

		return
	end

	if self._hitDist >= 0 then
		self._movedDist = self._movedDist + curFrameDist
	end

	self._pos.x = self._pos.x + self._moveDir.x * curFrameDist
	self._pos.y = self._pos.y + self._moveDir.y * curFrameDist

	transformhelper.setPosXY(self.viewGO.transform, self._pos.x, self._pos.y)
	self:_updateTrail()
end

function V3a8EchoSongGameBallItem:onUpdateMO(angle, mainView, lifeTime, sceneAnchorPos)
	self:_resetState()

	self._mainView = mainView
	self._moveDir.x = Mathf.Cos(angle)
	self._moveDir.y = Mathf.Sin(angle)

	self._moveDir:SetNormalize()

	self._lifeTime = lifeTime or V3a8EchoSongEnum.ParticleLifeTime.Long
	self._sceneAnchorPos = sceneAnchorPos
	self._pos.x, self._pos.y = transformhelper.getPos(self.viewGO.transform)

	self:_pushTrailPoint(self._pos.x, self._pos.y)

	self._needInitRaycast = true
end

function V3a8EchoSongGameBallItem:getSrcPos()
	return self._sceneAnchorPos
end

function V3a8EchoSongGameBallItem:isDead()
	if self._isHit then
		return true
	end

	return self._startTime and self._startTime + self._lifeTime < Time.time
end

function V3a8EchoSongGameBallItem:offsetStartTime(delta)
	if self._startTime then
		self._startTime = self._startTime + delta
	end
end

function V3a8EchoSongGameBallItem:reset()
	self._isHit = false
	self._trailPointCount = 0
	self._reflectCount = 0
	self._hitDist = -1
	self._movedDist = 0

	self:_hideLine()
	transformhelper.setPosXY(self.viewGO.transform, 10000, 10000)
end

return V3a8EchoSongGameBallItem
