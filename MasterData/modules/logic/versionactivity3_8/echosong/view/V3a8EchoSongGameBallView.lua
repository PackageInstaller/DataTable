-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongGameBallView.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongGameBallView", package.seeall)

local V3a8EchoSongGameBallView = class("V3a8EchoSongGameBallView", BaseView)

function V3a8EchoSongGameBallView:onInitView()
	self._goscene = gohelper.findChild(self.viewGO, "#go_scene")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8EchoSongGameBallView:addEvents()
	return
end

function V3a8EchoSongGameBallView:removeEvents()
	return
end

function V3a8EchoSongGameBallView:_acquireBallItem()
	if #self._ballItemCache > 0 then
		return table.remove(self._ballItemCache)
	end

	return self:_createBallItem()
end

function V3a8EchoSongGameBallView:_createBallItem()
	local go = gohelper.cloneInPlace(self._goball)
	local item = V3a8EchoSongGameBallItem.New()

	item:_init(go)

	return item
end

function V3a8EchoSongGameBallView:_acquireHitBallItem()
	if #self._hitBallItemCache > 0 then
		return table.remove(self._hitBallItemCache)
	end

	local go = gohelper.cloneInPlace(self._gohitball)
	local item = V3a8EchoSongGameHitBallItem.New()

	item:_init(go)

	return item
end

function V3a8EchoSongGameBallView:addHitBall(pos)
	local item = self:_acquireHitBallItem()
	local go = item.viewGO

	gohelper.setActive(go, true)

	item.time = Time.time

	table.insert(self._hitBallList, item)
	item:onUpdateMO(V3a8EchoSongEnum.ParticleLifeTime.HitTime)
	transformhelper.setPos(go.transform, pos.x, pos.y, 0)
end

function V3a8EchoSongGameBallView:_editableInitView()
	self._hitBallList = self:getUserDataTb_()
	self._runningBallList = self:getUserDataTb_()
	self._ballItemCache = self:getUserDataTb_()
	self._hitBallItemCache = self:getUserDataTb_()
	self._matGroupCache = self:getUserDataTb_()
	self._batchCache = self:getUserDataTb_()
	self._batchList = self:getUserDataTb_()
	self._updateFrame = 0

	TaskDispatcher.cancelTask(self._updateHandler, self)
	TaskDispatcher.runRepeat(self._updateHandler, self, 0)
end

function V3a8EchoSongGameBallView:_acquireMatGroup()
	if #self._matGroupCache > 0 then
		return table.remove(self._matGroupCache)
	end

	if not self._ballMatPrototype then
		local mr = self._goball:GetComponent(typeof(UnityEngine.MeshRenderer))
		local lr = self._goball:GetComponent("LineRenderer")

		if mr then
			self._ballMatPrototype = mr.sharedMaterial or nil
		end

		if lr then
			self._lineMatPrototype = lr.sharedMaterial or nil
		end
	end

	local ballMat = self._ballMatPrototype and UnityEngine.Object.Instantiate(self._ballMatPrototype) or nil
	local lineMat = self._lineMatPrototype and UnityEngine.Object.Instantiate(self._lineMatPrototype) or nil
	local color = ballMat and MaterialUtil.GetMainColor(ballMat) or nil

	return {
		ballMat = ballMat,
		lineMat = lineMat,
		color = color
	}
end

function V3a8EchoSongGameBallView:_releaseMatGroup(group)
	if group and group.color then
		group.color.a = 1

		if group.ballMat then
			MaterialUtil.setMainColor(group.ballMat, group.color)
		end

		if group.lineMat then
			MaterialUtil.setMainColor(group.lineMat, group.color)
		end
	end

	table.insert(self._matGroupCache, group)
end

function V3a8EchoSongGameBallView:_acquireBatch()
	if #self._batchCache > 0 then
		return table.remove(self._batchCache)
	end

	return {}
end

function V3a8EchoSongGameBallView:_releaseBatch(batch)
	batch.matGroup = nil
	batch.startTime = 0
	batch.lifeTime = 0

	table.insert(self._batchCache, batch)
end

function V3a8EchoSongGameBallView:_onEmittedParticle(playerPos, triggerType, lifeTime)
	local num = V3a8EchoSongEnum.BallConst.Num
	local pos = playerPos

	if V3a8EchoSongEnum.BallRandom.Num > 0 then
		num = num + math.random(1, V3a8EchoSongEnum.BallRandom.Num)
	end

	lifeTime = lifeTime or V3a8EchoSongEnum.ParticleLifeTime.Long

	local sceneAnchorPos = recthelper.rectToRelativeAnchorPos(playerPos, self._goscene.transform)
	local deltaAngle = 2 * Mathf.PI / num
	local phase = math.random() * deltaAngle
	local matGroup = self:_acquireMatGroup()
	local batch = self:_acquireBatch()

	batch.matGroup = matGroup
	batch.startTime = Time.time
	batch.lifeTime = lifeTime

	table.insert(self._batchList, batch)

	matGroup.color = triggerType == V3a8EchoSongEnum.ParticleType.Enemy2 and Color.red or Color.white

	for i = 1, num do
		local item = self:_acquireBallItem()
		local go = item.viewGO

		gohelper.setActive(go, true)
		transformhelper.setPosXY(go.transform, pos.x, pos.y)

		local angle = (i - 1) * deltaAngle + phase

		if V3a8EchoSongEnum.BallRandom.Angle > 0 then
			local randomAngle = V3a8EchoSongEnum.BallRandom.Angle * deltaAngle

			angle = angle + (math.random() * 2 - 1) * randomAngle
		end

		local randomLifeTime = 0

		if V3a8EchoSongEnum.BallRandom.LifeTime > 0 then
			randomLifeTime = math.random(-V3a8EchoSongEnum.BallRandom.LifeTime, V3a8EchoSongEnum.BallRandom.LifeTime)
		end

		item:setTriggerType(triggerType)
		item:setMatGroup(matGroup)
		item:onUpdateMO(angle, self, lifeTime + randomLifeTime, sceneAnchorPos)
		table.insert(self._runningBallList, item)
	end
end

function V3a8EchoSongGameBallView:_updateHandler()
	local deltaTime = Time.deltaTime
	local gameSceneView = self.viewContainer:getGameSceneView()

	self._updateFrame = self._updateFrame + 1

	local frameMod = self._updateFrame % 2
	local now = Time.time

	for i = #self._batchList, 1, -1 do
		local batch = self._batchList[i]
		local matGroup = batch.matGroup

		if not batch.lifeTime then
			local elapsed = now - batch.startTime

			if batch.lifeTime > 0 and batch.lifeTime <= elapsed then
				table.remove(self._batchList, i)

				if matGroup then
					self:_releaseMatGroup(matGroup)
				end

				self:_releaseBatch(batch)
			elseif matGroup and matGroup.color then
				local a = 1

				if batch.lifeTime > 0 then
					a = 1 - elapsed / batch.lifeTime

					if 1 - elapsed / batch.lifeTime < 0 then
						a = 0
					end
				end

				matGroup.color.a = a

				if matGroup.ballMat then
					MaterialUtil.setMainColor(matGroup.ballMat, matGroup.color)
				end

				if matGroup.lineMat then
					MaterialUtil.setMainColor(matGroup.lineMat, matGroup.color)
				end
			end
		end
	end

	for i = #self._hitBallList, 1, -1 do
		local item = self._hitBallList[i]

		if item:isDead() then
			local last = #self._hitBallList

			self._hitBallList[i] = self._hitBallList[last]
			self._hitBallList[last] = nil

			item:reset()
			table.insert(self._hitBallItemCache, item)
		else
			local needMatUpdate = i % 2 == frameMod

			item:update(deltaTime, needMatUpdate)
		end
	end

	UnityEngine.Physics2D.SyncTransforms()

	for i = #self._runningBallList, 1, -1 do
		local item = self._runningBallList[i]

		if item:isDead() then
			local last = #self._runningBallList

			self._runningBallList[i] = self._runningBallList[last]
			self._runningBallList[last] = nil

			item:reset()
			table.insert(self._ballItemCache, item)
		else
			local needRaycast = i % 2 == frameMod

			item:update(deltaTime, needRaycast)

			if gameSceneView then
				gameSceneView:checkEntityHit(item)
			end
		end
	end
end

function V3a8EchoSongGameBallView:onUpdateParam()
	return
end

function V3a8EchoSongGameBallView:onOpen()
	self._goroot = V3a8EchoSongModel.instance:getSceneNode()
	self._goball = V3a8EchoSongModel.instance:getBall()
	self._gohitball = V3a8EchoSongModel.instance:getHitBall()

	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.EmittedParticle, self._onEmittedParticle, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.PauseGame, self._onPauseGame, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.ResumeGame, self._onResumeGame, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.ResetGame, self._onResetGame, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.RestartGame, self._onResetGame, self)
	self:_startPrewarm()
end

function V3a8EchoSongGameBallView:_startPrewarm()
	self._prewarmRemain = V3a8EchoSongEnum.BallConst.PrewarmCount or 0

	if self._prewarmRemain <= 0 then
		return
	end

	TaskDispatcher.cancelTask(self._prewarmHandler, self)
	TaskDispatcher.runRepeat(self._prewarmHandler, self, 0)
end

function V3a8EchoSongGameBallView:_prewarmHandler()
	if not V3a8EchoSongEnum.BallConst.PrewarmPerFrame then
		for _ = 1, V3a8EchoSongEnum.BallConst.PrewarmPerFrame do
			if self._prewarmRemain <= 0 then
				break
			end

			local item = self:_createBallItem()

			gohelper.setActive(item.viewGO, false)
			table.insert(self._ballItemCache, item)

			self._prewarmRemain = self._prewarmRemain - 1
		end

		if self._prewarmRemain <= 0 then
			TaskDispatcher.cancelTask(self._prewarmHandler, self)
		end
	end
end

function V3a8EchoSongGameBallView:_onResetGame()
	for i = #self._hitBallList, 1, -1 do
		local item = self._hitBallList[i]

		item:reset()
		table.insert(self._hitBallItemCache, item)

		self._hitBallList[i] = nil
	end

	for i = #self._runningBallList, 1, -1 do
		local item = self._runningBallList[i]

		item:reset()
		table.insert(self._ballItemCache, item)

		self._runningBallList[i] = nil
	end

	for i = #self._batchList, 1, -1 do
		local batch = self._batchList[i]

		if batch.matGroup then
			self:_releaseMatGroup(batch.matGroup)
		end

		self:_releaseBatch(batch)

		self._batchList[i] = nil
	end
end

function V3a8EchoSongGameBallView:_onPauseGame()
	self._pauseTime = Time.time

	TaskDispatcher.cancelTask(self._updateHandler, self)
end

function V3a8EchoSongGameBallView:_onResumeGame()
	if self._pauseTime then
		local pauseDuration = Time.time - self._pauseTime

		if pauseDuration > 0 then
			for i = 1, #self._runningBallList do
				self._runningBallList[i]:offsetStartTime(pauseDuration)
			end

			for i = 1, #self._hitBallList do
				self._hitBallList[i]:offsetStartTime(pauseDuration)
			end

			for i = 1, #self._batchList do
				self._batchList[i].startTime = self._batchList[i].startTime + pauseDuration
			end
		end

		self._pauseTime = nil
	end

	TaskDispatcher.cancelTask(self._updateHandler, self)
	TaskDispatcher.runRepeat(self._updateHandler, self, 0)
end

function V3a8EchoSongGameBallView:onClose()
	TaskDispatcher.cancelTask(self._updateHandler, self)
	TaskDispatcher.cancelTask(self._prewarmHandler, self)
	self:_destroyAllMatInstances()
end

function V3a8EchoSongGameBallView:onDestroyView()
	return
end

function V3a8EchoSongGameBallView:_destroyAllMatInstances()
	for i = #self._batchList, 1, -1 do
		local batch = self._batchList[i]

		if batch.matGroup then
			self:_destroyMatGroup(batch.matGroup)
		end

		self._batchList[i] = nil
	end

	for i = #self._matGroupCache, 1, -1 do
		self:_destroyMatGroup(self._matGroupCache[i])

		self._matGroupCache[i] = nil
	end
end

function V3a8EchoSongGameBallView:_destroyMatGroup(group)
	if not group then
		return
	end

	if group.ballMat then
		UnityEngine.Object.Destroy(group.ballMat)

		group.ballMat = nil
	end

	if group.lineMat then
		UnityEngine.Object.Destroy(group.lineMat)

		group.lineMat = nil
	end

	group.color = nil
end

return V3a8EchoSongGameBallView
