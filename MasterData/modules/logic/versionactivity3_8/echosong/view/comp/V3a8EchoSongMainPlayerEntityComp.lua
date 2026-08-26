-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongMainPlayerEntityComp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongMainPlayerEntityComp", package.seeall)

local V3a8EchoSongMainPlayerEntityComp = class("V3a8EchoSongMainPlayerEntityComp", LuaCompBase)

function V3a8EchoSongMainPlayerEntityComp:init(go)
	self._go = go
	self._posCache = Vector2()
	self._dirCache = Vector2()
	self._moveTime = nil
	self._tempPos = Vector3()
	self._maxFootprint = V3a8EchoSongEnum.MainPlayerConst.MaxFootprint
	self._curFootprintIndex = 1
	self._footprintList = {}
	self._standFootprintList = {}
	self._footprintCache = self:getUserDataTb_()
	self._footprint = self:getUserDataTb_()
	self._id = V3a8EchoSongEnum.MainPlayerId
	self._recordInfo = {
		type = V3a8EchoSongEnum.UnitType.MainPlayer,
		id = self._id
	}

	for i = 1, self._maxFootprint do
		local go = gohelper.findChild(self._go, "footprint" .. i)

		if go then
			table.insert(self._footprint, go)
			gohelper.setActive(go, false)
		else
			logError("V3a8EchoSongMainPlayerEntityComp can not find footprint" .. tostring(i))
		end
	end

	local standFootprint = gohelper.findChild(self._go, "node_Role")

	if standFootprint then
		self._footprint[V3a8EchoSongEnum.MainPlayerConst.StandFootprintIndex] = standFootprint

		gohelper.setActive(standFootprint, false)
	else
		logError("V3a8EchoSongMainPlayerEntityComp can not find standFootprint")
	end

	local parent = self._go.transform.parent

	self._explorContainer = gohelper.create2d(parent.gameObject, "explorContainer")

	gohelper.setAsFirstSibling(self._explorContainer)

	self._footprintContainer = gohelper.create2d(parent.gameObject, "footprintContainer")

	gohelper.setAsFirstSibling(self._footprintContainer)

	self._line = gohelper.findChild(self._go, "Image_Line")

	gohelper.setActive(self._line, false)

	local exploreGo = gohelper.findChild(self._go, "Image_Point_fire")

	gohelper.addChild(self._explorContainer, exploreGo)

	self._exploreItem = MonoHelper.addNoUpdateLuaComOnceToGo(exploreGo, V3a8EchoSongGameExploreItem)
	self._projAnimator = ZProj.ProjAnimatorPlayer.Get(go)

	TaskDispatcher.runRepeat(self._frameHandler, self, 0)
end

function V3a8EchoSongMainPlayerEntityComp:rollback(info)
	self._rawRecordInfo = self._rawRecordInfo or self:getRecordInfo()
	info = info or tabletool.copy(self._rawRecordInfo)
	self._recordInfo = info
	self._curFootprintIndex = info.curFootprintIndex

	for i = #self._footprintList, 1, -1 do
		local item = self._footprintList[i]

		if item.animator then
			item.animator:Play("close" .. tostring(item.footprintType), 0, 0)
		end

		local cacheList = self._footprintCache[item.index]

		if cacheList then
			table.insert(cacheList, item)
		end

		table.remove(self._footprintList, i)
	end

	if self._curStandFootprint then
		table.insert(self._standFootprintList, self._curStandFootprint)

		self._curStandFootprint = nil
	end

	self._createStandFootprintTime = Time.time - V3a8EchoSongEnum.MainPlayerConst.StandFootprintInterval

	for i = #self._standFootprintList, 1, -1 do
		local item = self._standFootprintList[i]

		if item.animator then
			item.animator:Play("close", 0, 0)
		end

		local cacheList = self._footprintCache[item.index]

		if cacheList then
			table.insert(cacheList, item)
		end

		table.remove(self._standFootprintList, i)
	end

	self._moveTime = nil
	self._isDead = false
	self._isWin = false

	if self._exploreItem then
		self._exploreItem:reset()
	end

	if self._line then
		gohelper.setActive(self._line, false)
	end

	self._lastDragAngle = nil

	local pos = info.pos

	if pos and pos.x and pos.y then
		recthelper.setAnchor(self._go.transform, pos.x, pos.y)
	else
		logError("V3a8EchoSongMainPlayerEntityComp:rollback posCache is nil", self._id)
	end

	self._projAnimator:Play("open")
end

function V3a8EchoSongMainPlayerEntityComp:getRecordInfo()
	self._recordInfo.curFootprintIndex = self._curFootprintIndex

	local posX, posY = recthelper.getAnchor(self._go.transform)

	self._recordInfo.pos = Vector2(posX, posY)

	return tabletool.copy(self._recordInfo)
end

function V3a8EchoSongMainPlayerEntityComp:addEventListeners()
	V3a8EchoSongController.instance:registerCallback(V3a8EchoSongEvent.DragLine, self._onDragLine, self)
	V3a8EchoSongController.instance:registerCallback(V3a8EchoSongEvent.DragEnd, self._onDragEnd, self)
	V3a8EchoSongController.instance:registerCallback(V3a8EchoSongEvent.DragExplore, self._onDragExplore, self)
	V3a8EchoSongController.instance:registerCallback(V3a8EchoSongEvent.PauseGame, self._onPauseGame, self)
	V3a8EchoSongController.instance:registerCallback(V3a8EchoSongEvent.ResumeGame, self._onResumeGame, self)
	V3a8EchoSongController.instance:registerCallback(V3a8EchoSongEvent.TouchEmitted, self._onTouchEmitted, self)
	V3a8EchoSongController.instance:registerCallback(V3a8EchoSongEvent.MainPlayerWin, self._onMainPlayerWin, self)
end

function V3a8EchoSongMainPlayerEntityComp:removeEventListeners()
	V3a8EchoSongController.instance:unregisterCallback(V3a8EchoSongEvent.DragLine, self._onDragLine, self)
	V3a8EchoSongController.instance:unregisterCallback(V3a8EchoSongEvent.DragEnd, self._onDragEnd, self)
	V3a8EchoSongController.instance:unregisterCallback(V3a8EchoSongEvent.DragExplore, self._onDragExplore, self)
	V3a8EchoSongController.instance:unregisterCallback(V3a8EchoSongEvent.PauseGame, self._onPauseGame, self)
	V3a8EchoSongController.instance:unregisterCallback(V3a8EchoSongEvent.ResumeGame, self._onResumeGame, self)
	V3a8EchoSongController.instance:unregisterCallback(V3a8EchoSongEvent.TouchEmitted, self._onTouchEmitted, self)
	V3a8EchoSongController.instance:unregisterCallback(V3a8EchoSongEvent.MainPlayerWin, self._onMainPlayerWin, self)
end

function V3a8EchoSongMainPlayerEntityComp:_onMainPlayerWin()
	self._isWin = true
end

function V3a8EchoSongMainPlayerEntityComp:_onTouchEmitted(type)
	local lifeTime = type == V3a8EchoSongEnum.TouchEmittedType.Long and V3a8EchoSongEnum.ParticleLifeTime.StandLong or V3a8EchoSongEnum.ParticleLifeTime.Short
	local posX, posY = transformhelper.getPos(self._go.transform)

	self._tempPos.x = posX
	self._tempPos.y = posY

	if lifeTime == V3a8EchoSongEnum.ParticleLifeTime.Short then
		V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.EmittedParticle, self._tempPos, V3a8EchoSongEnum.ParticleType.MainPlayerShort, lifeTime)
	else
		V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.EmittedParticle, self._tempPos, V3a8EchoSongEnum.ParticleType.MainPlayer, lifeTime)
	end
end

function V3a8EchoSongMainPlayerEntityComp:_onPauseGame()
	self._pauseTime = Time.time

	TaskDispatcher.cancelTask(self._frameHandler, self)
end

function V3a8EchoSongMainPlayerEntityComp:_onResumeGame()
	if self._pauseTime then
		local pauseDuration = Time.time - self._pauseTime

		if pauseDuration > 0 then
			if self._footprintList then
				for i = 1, #self._footprintList do
					self._footprintList[i].time = self._footprintList[i].time + pauseDuration
				end
			end

			if self._standFootprintList then
				for i = 1, #self._standFootprintList do
					self._standFootprintList[i].time = self._standFootprintList[i].time + pauseDuration
				end
			end

			if self._moveTime then
				self._moveTime = self._moveTime + pauseDuration
			end
		end

		self._pauseTime = nil
	end

	TaskDispatcher.cancelTask(self._frameHandler, self)
	TaskDispatcher.runRepeat(self._frameHandler, self, 0)
end

function V3a8EchoSongMainPlayerEntityComp:_onDragExplore()
	local posX, posY = transformhelper.getPos(self._go.transform)

	transformhelper.setPosXY(self._exploreItem.viewGO.transform, posX, posY)

	if not self._lastDragAngle then
		return
	end

	local angle = self._lastDragAngle

	self._lastDragAngle = nil
	self._lineLength = 0

	self._exploreItem:onUpdateMO(angle)
end

function V3a8EchoSongMainPlayerEntityComp:_onDragEnd()
	self._lineLength = 0
end

function V3a8EchoSongMainPlayerEntityComp:_onDragLine(showLine, screenPosBegin, screenPosEnd, lineLength)
	gohelper.setActive(self._line, showLine)

	if not showLine then
		return
	end

	lineLength = lineLength or 0
	lineLength = math.min(lineLength, V3a8EchoSongEnum.DragLength)

	if self._lineLength then
		lineLength = math.max(lineLength, self._lineLength)
	end

	recthelper.setWidth(self._line.transform, lineLength)

	local angleRad = math.atan2(screenPosEnd.y - screenPosBegin.y, screenPosEnd.x - screenPosBegin.x)

	transformhelper.setLocalRotation(self._line.transform, 0, 0, math.deg(angleRad - (self._angle and math.rad(self._angle) or 0)))

	self._lastDragAngle = angleRad
	self._lineLength = lineLength
end

function V3a8EchoSongMainPlayerEntityComp:_frameHandler()
	local posX, posY = transformhelper.getPos(self._go.transform)

	self._posCache.x = posX
	self._posCache.y = posY

	for i = #self._footprintList, 1, -1 do
		local item = self._footprintList[i]

		if item.time + V3a8EchoSongEnum.MainPlayerConst.SingleFootprintLifeTime < Time.time then
			table.remove(self._footprintList, i)

			if item.animator then
				item.isClosed = true

				item.animator:Play("close" .. tostring(item.footprintType), 0, 0)
			end

			local list = self._footprintCache[item.index]

			table.insert(list, item)
		end
	end

	for i = #self._standFootprintList, 1, -1 do
		local item = self._standFootprintList[i]

		if item.time + V3a8EchoSongEnum.MainPlayerConst.DoubleFootprintLifeTime < Time.time then
			table.remove(self._standFootprintList, i)

			if item.animator then
				item.animator:Play("close", 0, 0)
			end

			local list = self._footprintCache[item.index]

			table.insert(list, item)
		end
	end

	if not self._exploreItem:isDead() then
		self._exploreItem:update(Time.deltaTime)
	else
		self._exploreItem:reset()
	end

	if self._createStandFootprintTime and self._createStandFootprintTime + V3a8EchoSongEnum.MainPlayerConst.StandFootprintInterval <= Time.time then
		self._createStandFootprintTime = nil

		self:_checkAddStandFootprint()
	end
end

function V3a8EchoSongMainPlayerEntityComp:clearMoveTime()
	self._moveTime = nil
end

function V3a8EchoSongMainPlayerEntityComp:stopMove()
	self._createStandFootprintTime = Time.time
end

function V3a8EchoSongMainPlayerEntityComp:_checkAddStandFootprint()
	if not self._curStandFootprint then
		local x, y = self._posCache.x, self._posCache.y

		if not self._angle then
			self._curStandFootprint = self:_addStandFootprint(x, y, self._angle)
		end
	end
end

function V3a8EchoSongMainPlayerEntityComp:checkHitParticle(ballItem)
	if self._isDead then
		return
	end

	if self._isWin then
		return
	end

	local worldPos = ballItem:getPos()
	local dx = worldPos.x - self._posCache.x
	local dy = worldPos.y - self._posCache.y

	if dx * dx + dy * dy < 1 then
		self._isDead = true

		V3a8EchoSongController.instance:dispatchGameResult(false)
	end
end

function V3a8EchoSongMainPlayerEntityComp:move(x, y, strength)
	if self._isDead or self._isWin then
		return
	end

	if self._curStandFootprint then
		table.insert(self._standFootprintList, self._curStandFootprint)

		self._curStandFootprint.time = Time.time
		self._curStandFootprint = nil
	end

	self._createStandFootprintTime = nil

	local posX, posY = transformhelper.getPos(self._go.transform)
	local speed = V3a8EchoSongEnum.MainPlayerConst.MoveSpeed
	local radius = V3a8EchoSongEnum.MainPlayerConst.CircleCastRadius

	self._posCache.x = posX
	self._posCache.y = posY
	self._dirCache.x = x
	self._dirCache.y = y

	self._dirCache:SetNormalize()

	local angle = math.deg(math.atan2(y, x))

	transformhelper.setLocalRotation(self._go.transform, 0, 0, angle)

	self._angle = angle

	if not self._moveTime or Time.time - self._moveTime > V3a8EchoSongEnum.MainPlayerConst.EmitInterval then
		self._moveTime = Time.time
		self._tempPos.x = posX
		self._tempPos.y = posY

		if strength >= V3a8EchoSongEnum.MainPlayerConst.StrengthThreshold then
			if not V3a8EchoSongEnum.ParticleLifeTime.Long then
				do
					local lifeTime = V3a8EchoSongEnum.ParticleLifeTime.Short
					local footprintType = V3a8EchoSongEnum.FootprintType.Normal

					if lifeTime == V3a8EchoSongEnum.ParticleLifeTime.Short then
						footprintType = V3a8EchoSongEnum.FootprintType.Light

						V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.EmittedParticle, self._tempPos, V3a8EchoSongEnum.ParticleType.MainPlayerShort, lifeTime)
						AudioMgr.instance:trigger(V3a8EchoSongEnum.Audio.play_ui_shiji3_8_hsy_fstp1)
					else
						footprintType = V3a8EchoSongEnum.FootprintType.Normal

						V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.EmittedParticle, self._tempPos, V3a8EchoSongEnum.ParticleType.MainPlayer, lifeTime)
						AudioMgr.instance:trigger(V3a8EchoSongEnum.Audio.play_ui_shiji3_8_hsy_fstp2)
					end

					self:_addFootprint(posX, posY, angle, footprintType)
				end

				local hit = UnityEngine.Physics2D.CircleCast(self._posCache, radius, self._dirCache, V3a8EchoSongEnum.MainPlayerConst.CircleCastDist, V3a8EchoSongEnum.ColliderLayer)

				if hit and hit.collider ~= nil then
					return
				end

				local offsetX = x * Time.deltaTime * speed
				local offsetY = y * Time.deltaTime * speed

				transformhelper.setPosXY(self._go.transform, posX + offsetX, posY + offsetY)
			end
		end
	end
end

function V3a8EchoSongMainPlayerEntityComp:_addFootprint(x, y, angle, footprintType)
	local footPrintItem = self:_getFootprint(self._curFootprintIndex)

	if footPrintItem then
		local lastFootPrintItem = self._footprintList[#self._footprintList]

		if lastFootPrintItem and not lastFootPrintItem.isClosed then
			lastFootPrintItem.animator:Play("reduce" .. tostring(lastFootPrintItem.footprintType), 0, 0)
		end

		table.insert(self._footprintList, footPrintItem)

		footPrintItem.footprintType = footprintType

		if footPrintItem.animator then
			footPrintItem.animator:Play("open" .. tostring(footPrintItem.footprintType), 0, 0)
		end

		footPrintItem.time = Time.time

		transformhelper.setPosXY(footPrintItem.go.transform, x, y)

		if angle then
			transformhelper.setLocalRotation(footPrintItem.go.transform, 0, 0, angle)
		end
	end

	self._curFootprintIndex = self._curFootprintIndex + 1

	if self._curFootprintIndex > self._maxFootprint then
		self._curFootprintIndex = 1
	end
end

function V3a8EchoSongMainPlayerEntityComp:_addStandFootprint(x, y, angle)
	local footPrintItem = self:_getFootprint(V3a8EchoSongEnum.MainPlayerConst.StandFootprintIndex)

	if footPrintItem then
		if footPrintItem.animator then
			footPrintItem.animator:Play("open", 0, 0)
		end

		footPrintItem.time = Time.time

		transformhelper.setPosXY(footPrintItem.go.transform, x, y)

		if angle then
			transformhelper.setLocalRotation(footPrintItem.go.transform, 0, 0, angle)
		end

		return footPrintItem
	end
end

function V3a8EchoSongMainPlayerEntityComp:_getFootprint(index)
	local list = self._footprintCache[index]

	if not list then
		list = {}
		self._footprintCache[index] = list
	end

	if #list > 0 then
		local item = table.remove(list)

		item.isClosed = false

		return item
	end

	local go = self._footprint[index]

	if go then
		local fpGo = gohelper.clone(go, self._footprintContainer)

		gohelper.setActive(fpGo, true)

		return {
			isClosed = false,
			index = index,
			go = fpGo,
			animator = fpGo:GetComponent("Animator")
		}
	end
end

function V3a8EchoSongMainPlayerEntityComp:onDestroy()
	TaskDispatcher.cancelTask(self._frameHandler, self)
end

return V3a8EchoSongMainPlayerEntityComp
