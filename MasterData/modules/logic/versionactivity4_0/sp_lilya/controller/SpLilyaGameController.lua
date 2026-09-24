-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/controller/SpLilyaGameController.lua

module("modules.logic.versionactivity4_0.sp_lilya.controller.SpLilyaGameController", package.seeall)

local SpLilyaGameController = class("SpLilyaGameController", BaseController)

function SpLilyaGameController:onInit()
	self:reInit()
end

function SpLilyaGameController:onInitFinish()
	return
end

function SpLilyaGameController:addConstEvents()
	return
end

function SpLilyaGameController:reInit()
	self._isRunning = false
	self._isPaused = false
	self._timeUpdateElapsed = 0
	self._isGameOver = false
	self._isPower = false
	self._statSent = false
	self._energyLaunchQueue = nil
end

function SpLilyaGameController:enterGame(actId, episodeId)
	self:initGame(actId, episodeId)
	ViewMgr.instance:openView(ViewName.SpLilyaGameView)
	ViewMgr.instance:openView(ViewName.SpLilyaGameTipView)
end

function SpLilyaGameController:initGame(actId, episodeId)
	self:_clearEnergyLaunchQueue()
	SpLilyaGameModel.instance:initGame(actId, episodeId)
	SpLilyaGameSceneMgr.instance:init(self)

	local gameMO = SpLilyaGameModel.instance:getGameMO()

	SpLilyaGameSceneMgr.instance:loadMonsterTeam(gameMO.monsterTeam)

	self._isGameOver = false
	self._statSent = false
	self._playerMoveDirX = nil
	self._playerMoveDirY = nil
end

function SpLilyaGameController:fire(posX, posY, dirX, dirY, trajectorySpeed, damage, energy, radius, explodeRadius, type, moveSpeed)
	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local sceneMo = gameMO and gameMO.sceneMo

	if not sceneMo then
		return nil
	end

	if gameMO.winType == SpLilyaEnum.VictoryType.LimitBulle then
		local bulletLimit = tonumber(gameMO.winParam)

		if bulletLimit then
			if bulletLimit <= (gameMO.shotCount or 0) then
				self:checkBulletLimit()

				return nil
			end
		end
	end

	local mo = sceneMo:addBullet(posX, posY, dirX, dirY, trajectorySpeed, damage, energy, radius, explodeRadius, type, moveSpeed)

	if mo then
		gameMO.shotCount = (gameMO.shotCount or 0) + 1

		self:checkBulletLimit()
	end

	return mo
end

function SpLilyaGameController:startPower()
	if self._isPower then
		return
	end

	self._isPower = true
	self._powerHoldTime = 0

	local playerMo = self:_getPlayerMo()

	if playerMo then
		playerMo.powerTime = 0
	end
end

function SpLilyaGameController:stopPower()
	if not self._isPower then
		return
	end

	self._isPower = false
	self._powerHoldTime = 0

	self:_doFire()

	local playerMo = self:_getPlayerMo()

	if playerMo then
		playerMo.powerTime = 0

		self:dispatchEvent(SpLilyaEvent.PowerUpdate, playerMo.powerTime)
	end
end

function SpLilyaGameController:setPlayerRotation(angle)
	local playerMo = self:_getPlayerMo()

	if playerMo then
		playerMo.rotation = angle
	end
end

function SpLilyaGameController:setPlayerMoveDir(dirX, dirY)
	self._playerMoveDirX = dirX
	self._playerMoveDirY = dirY
end

function SpLilyaGameController:setPlayerAimState(aimState)
	local playerMo = self:_getPlayerMo()

	if not playerMo or playerMo.aimState == aimState then
		return
	end

	playerMo.aimState = aimState

	self:dispatchEvent(SpLilyaEvent.PlayerAimState, aimState)
end

function SpLilyaGameController:setBulletOriginPos(posX, posY)
	local playerMo = self:_getPlayerMo()

	if playerMo then
		playerMo.bulletPosX = posX
		playerMo.bulletPosY = posY
	end
end

function SpLilyaGameController:setSceneSize(width, height)
	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local sceneMo = gameMO and gameMO.sceneMo

	if sceneMo then
		sceneMo:setSceneSize(width, height)

		gameMO.enemyEndPosX = -sceneMo.groundPosX
	end
end

function SpLilyaGameController:getShotSpeed()
	local playerMo = self:_getPlayerMo()

	if not playerMo or not playerMo.speedRange then
		return SpLilyaEnum.DefaultShotSpeed
	end

	if not playerMo.maxPowerTime then
		local maxPowerTime = 0

		if not playerMo.powerTime then
			local powerTime = 0
			local ratio = maxPowerTime > 0 and math.min(powerTime / maxPowerTime, 1) or 0
			local speedRange = playerMo.speedRange

			return speedRange[1] + (speedRange[2] - speedRange[1]) * ratio
		end
	end
end

function SpLilyaGameController:getShotExplodeRadius()
	local playerMo = self:_getPlayerMo()

	if not playerMo or not playerMo.damageRadiusRange then
		return 0
	end

	if not playerMo.maxPowerTime then
		local maxPowerTime = 0

		if not playerMo.powerTime then
			local powerTime = 0
			local ratio = maxPowerTime > 0 and math.min(powerTime / maxPowerTime, 1) or 0
			local damageRadiusRange = playerMo.damageRadiusRange

			return damageRadiusRange[1] + (damageRadiusRange[2] - damageRadiusRange[1]) * ratio
		end
	end
end

function SpLilyaGameController:_updatePower(deltaTime)
	if not self._isPower then
		return
	end

	local playerMo = self:_getPlayerMo()

	if not playerMo then
		return
	end

	self._powerHoldTime = (self._powerHoldTime or 0) + deltaTime

	if not SpLilyaEnum.PowerChargeDelay then
		local chargeDelay = 0

		if chargeDelay > self._powerHoldTime then
			return
		end

		if not playerMo.maxPowerTime then
			local maxPowerTime = 0

			if not playerMo.powerTime then
				local oldPowerTime = 0
				local powerTime = oldPowerTime + deltaTime * 1000

				if maxPowerTime < powerTime then
					powerTime = maxPowerTime
				end

				playerMo.powerTime = powerTime

				if powerTime ~= oldPowerTime then
					self:dispatchEvent(SpLilyaEvent.PowerUpdate, powerTime)
				end
			end
		end
	end
end

function SpLilyaGameController:_updatePlayerMove(deltaTime)
	local dirX = self._playerMoveDirX
	local dirY = self._playerMoveDirY

	if not dirX or not dirY or dirX == 0 and dirY == 0 then
		return
	end

	local gameMO = SpLilyaGameModel.instance:getGameMO()

	if not gameMO or gameMO.isGravity ~= SpLilyaEnum.UseGravity.Unuse then
		return
	end

	local playerMo = gameMO.playerMo

	if not playerMo then
		return
	end

	local sceneMo = gameMO.sceneMo
	local halfWidth = sceneMo and sceneMo:getHalfWidth() or 0
	local halfHeight = sceneMo and sceneMo:getHalfHeight() or 0
	local moveStep = SpLilyaEnum.AirPlayerMoveSpeed * deltaTime

	if not playerMo.posX then
		local oldPosX = 0

		if not playerMo.posY then
			local oldPosY = 0
			local newPosX = math.max(-halfWidth, math.min(oldPosX + dirX * moveStep, halfWidth))
			local newPosY = math.max(-halfHeight, math.min(oldPosY + dirY * moveStep, halfHeight))

			if newPosX == oldPosX and newPosY == oldPosY then
				return
			end

			playerMo:setPos(newPosX, newPosY)

			if playerMo.bulletPosX then
				playerMo.bulletPosX = playerMo.bulletPosX + (newPosX - oldPosX)
				playerMo.bulletPosY = playerMo.bulletPosY + (newPosY - oldPosY)
			end

			self:dispatchEvent(SpLilyaEvent.PlayerMoveEvent, newPosX, newPosY)
		end
	end
end

function SpLilyaGameController:_doFire()
	local gameMO = SpLilyaGameModel.instance:getGameMO()

	if not gameMO then
		return nil
	end

	local playerMo = gameMO.playerMo

	if not playerMo then
		return nil
	end

	if not playerMo.shotLimit then
		local shotLimit = 0

		if shotLimit > 0 then
			if gameMO.sceneMo then
				local nowTime = (gameMO.sceneMo.elapsedTime or 0) * 1000

				if playerMo.lastFireTime and shotLimit > nowTime - playerMo.lastFireTime then
					return nil
				end
			end
		end

		if not playerMo.maxPowerTime then
			local maxPowerTime = 0

			if not playerMo.powerTime then
				local powerTime = 0
				local ratio = maxPowerTime > 0 and math.min(powerTime / maxPowerTime, 1) or 0
				local rad = math.rad(playerMo.rotation or 0)
				local dirX = math.cos(rad)
				local dirY = math.sin(rad)
				local trajectorySpeed = self:getShotSpeed()

				if not playerMo.normalBulletSpeed then
					local moveSpeed = SpLilyaEnum.NormalBulletSpeed

					if not playerMo.damageRange then
						local damageRange = {
							0,
							0
						}
						local damage = damageRange[1] + (damageRange[2] - damageRange[1]) * ratio

						if not playerMo.damageEnergyRange then
							local energyRange = {
								0,
								0
							}
							local energy = energyRange[1] + (energyRange[2] - energyRange[1]) * ratio

							if not playerMo.bulletRadius then
								local radius = 0
								local explodeRadius = self:getShotExplodeRadius()
								local bulletType = gameMO.isGravity == SpLilyaEnum.UseGravity.Use and SpLilyaEnum.BulletType.Gravity or SpLilyaEnum.BulletType.NoGravity
								local sceneMo = gameMO.sceneMo

								if not playerMo.bulletPosX then
									local posX = playerMo.posX

									if not playerMo.bulletPosY then
										local posY = playerMo.posY

										if sceneMo then
											if not sceneMo.groundPosX then
												do
													local groundPosX = 0

													if not sceneMo.groundPosY then
														local groundPosY = 0

														posX = math.max(-groundPosX, math.min(posX, groundPosX))
														posY = math.max(-groundPosY, math.min(posY, groundPosY))
													end
												end

												local bulletMo = self:fire(posX, posY, dirX, dirY, trajectorySpeed, damage, energy, radius, explodeRadius, bulletType, moveSpeed)

												if bulletMo then
													playerMo.lastFireTime = ((gameMO.sceneMo or nil) and (gameMO.sceneMo.elapsedTime or 0)) * 1000
												end

												return bulletMo
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function SpLilyaGameController:fireEnergy()
	local gameMO = SpLilyaGameModel.instance:getGameMO()

	if not gameMO then
		return
	end

	if gameMO.isEnergy ~= SpLilyaEnum.UseEnergy.Use then
		return
	end

	local playerMo = gameMO.playerMo
	local sceneMo = gameMO.sceneMo

	if not playerMo or not sceneMo then
		return
	end

	if not playerMo.energyMax then
		local energyMax = 0

		if energyMax > 0 then
			if (playerMo.curEnergy or 0) < energyMax then
				return
			end
		end

		if not playerMo.energyBulletCount then
			local count = 0

			if count <= 0 then
				return
			end

			playerMo.curEnergy = 0

			self:dispatchEvent(SpLilyaEvent.EnergyUpdate, playerMo.curEnergy, energyMax)
			logNormal("Energy fired : cur " .. tostring(playerMo.curEnergy) .. " / " .. tostring(energyMax))

			if not playerMo.energyBulletDamage then
				local damage = 0

				if not playerMo.bulletPosX then
					local posX = playerMo.posX

					if not playerMo.bulletPosY then
						local posY = playerMo.posY

						if not sceneMo.groundPosX then
							local groundPosX = 0

							if not sceneMo.groundPosY then
								local groundPosY = 0

								posX = math.max(-groundPosX, math.min(posX, groundPosX))
								posY = math.max(-groundPosY, math.min(posY, groundPosY))

								if not playerMo.energyBulletSpeed then
									if not playerMo.bulletRadius then
										local radius = 0
										local enemySnapshotList = self:_createEnergyEnemySnapshot(sceneMo)
										local targetAssignList = self:_calcEnergyTargetAssign(enemySnapshotList, count, damage)

										self._energyLaunchQueue = {
											elapsed = 0,
											nextIndex = 1,
											sceneMo = sceneMo,
											posX = posX,
											posY = posY,
											speed = playerMo.energyBulletSpeed,
											damage = damage,
											radius = radius,
											count = count,
											targetAssignList = targetAssignList
										}

										self:_updateEnergyLaunch(0)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function SpLilyaGameController:_createEnergyEnemySnapshot(sceneMo)
	local enemySnapshotList = {}

	for _, enemyMo in pairs(sceneMo.useMoDic) do
		if enemyMo and enemyMo:isHittable() then
			enemySnapshotList[#enemySnapshotList + 1] = {
				uid = enemyMo.uid,
				curLife = enemyMo.curLife,
				posX = enemyMo.posX,
				posY = enemyMo.posY
			}
		end
	end

	return enemySnapshotList
end

function SpLilyaGameController:_calcEnergyTargetAssign(enemyList, bulletCount, damage)
	local assignList = {}
	local enemyCount = #enemyList

	if enemyCount == 0 or bulletCount <= 0 or damage <= 0 then
		return assignList
	end

	local candidates = {}

	for i = 1, enemyCount do
		local target = enemyList[i]

		candidates[#candidates + 1] = {
			target = target,
			needed = math.max(math.ceil(target.curLife / damage), 1)
		}
	end

	table.sort(candidates, function(a, b)
		if a.needed ~= b.needed then
			return a.needed < b.needed
		end

		if a.target.curLife ~= b.target.curLife then
			return a.target.curLife < b.target.curLife
		end

		return a.target.uid < b.target.uid
	end)

	local remaining = bulletCount
	local killAssign = {}

	for i = 1, #candidates do
		local candidate = candidates[i]

		if remaining >= candidate.needed then
			killAssign[i] = candidate.needed
			remaining = remaining - candidate.needed
		else
			break
		end
	end

	local idx = 1

	for i = 1, #candidates do
		local cnt = killAssign[i]

		if not cnt then
			break
		end

		for _ = 1, cnt do
			assignList[idx] = candidates[i].target
			idx = idx + 1
		end
	end

	local fallbackTargets = {}

	for i = 1, #candidates do
		if not killAssign[i] then
			fallbackTargets[#fallbackTargets + 1] = candidates[i]
		end
	end

	if #fallbackTargets == 0 then
		fallbackTargets = candidates
	end

	local fallbackCount = #fallbackTargets
	local fallbackIndex = 1

	while idx <= bulletCount do
		assignList[idx] = fallbackTargets[fallbackIndex].target
		fallbackIndex = fallbackIndex % fallbackCount + 1
		idx = idx + 1
	end

	return assignList
end

function SpLilyaGameController:_updateEnergyLaunch(deltaTime)
	local queue = self._energyLaunchQueue

	if not queue then
		return
	end

	queue.elapsed = queue.elapsed + deltaTime

	local interval = SpLilyaEnum.EnergyBulletLaunchInterval

	while queue.nextIndex <= queue.count do
		local launchTime = (queue.nextIndex - 1) * interval

		if launchTime > queue.elapsed then
			break
		end

		self:_launchEnergyBullet(queue, queue.nextIndex)

		queue.nextIndex = queue.nextIndex + 1
	end

	if queue.nextIndex > queue.count then
		self:_clearEnergyLaunchQueue()
	end
end

function SpLilyaGameController:_launchEnergyBullet(queue, bulletIndex)
	local targetSnapshot = queue.targetAssignList[bulletIndex]
	local dirX, dirY

	if targetSnapshot then
		local dx = targetSnapshot.posX - queue.posX
		local dy = targetSnapshot.posY - queue.posY

		if dx ~= 0 or dy ~= 0 then
			local maneuverSign = bulletIndex % 2 == 1 and 1 or -1
			local maneuverAngle = math.random(SpLilyaEnum.EnergyBulletManeuverAngleMin, SpLilyaEnum.EnergyBulletManeuverAngleMax)
			local launchAngle = math.atan2(dy, dx) + math.rad(maneuverAngle * maneuverSign)

			dirX = math.cos(launchAngle)
			dirY = math.sin(launchAngle)
		end
	end

	if not dirX then
		local rad = math.rad((bulletIndex - 1) * 360 / queue.count)

		dirX = math.cos(rad)
		dirY = math.sin(rad)
	end

	local bulletMo = queue.sceneMo:addBullet(queue.posX, queue.posY, dirX, dirY, queue.speed, queue.damage, 0, queue.radius, queue.radius, SpLilyaEnum.BulletType.Energy, queue.speed)

	if bulletMo and targetSnapshot then
		bulletMo.targetUid = targetSnapshot.uid
	end
end

function SpLilyaGameController:_hasPendingEnergyLaunch()
	local queue = self._energyLaunchQueue

	return queue ~= nil and queue.nextIndex <= queue.count
end

function SpLilyaGameController:_clearEnergyLaunchQueue()
	self._energyLaunchQueue = nil
end

function SpLilyaGameController:_getPlayerMo()
	local gameMO = SpLilyaGameModel.instance:getGameMO()

	return gameMO and gameMO.playerMo
end

function SpLilyaGameController:_initConstParam()
	self._maxPowerTime = SpLilyaConfig.instance:getConstValue(SpLilyaEnum.ConstId.PowerTime, true) or 0

	local speedMin = SpLilyaConfig.instance:getConstValue(SpLilyaEnum.ConstId.SpeedMin, true)
	local speedMax = SpLilyaConfig.instance:getConstValue(SpLilyaEnum.ConstId.SpeedMax, true)

	self._speedMin = speedMin or 0
	self._speedMax = speedMax or self._speedMin
	self._shotLimit = SpLilyaConfig.instance:getConstValue(SpLilyaEnum.ConstId.ShotLimit, true) or 0

	self:_initDamageList()
end

function SpLilyaGameController:startGame()
	if self._isRunning then
		return
	end

	self._updateHandle = FixedUpdateBeat:CreateListener(self._onUpdate, self)

	FixedUpdateBeat:AddListener(self._updateHandle)

	self._isRunning = true

	self.addEventCb(self, self, SpLilyaEvent.GamePause, self._onGamePause, self)
	self.addEventCb(self, self, SpLilyaEvent.GameResume, self._onGameResume, self)

	local gameId = SpLilyaGameModel.instance:getCurGameId()

	logWarn(string.format("[SpLilya][%.3f] GameStart gameId=%s", Time.realtimeSinceStartup, tostring(gameId)))
	self:dispatchEvent(SpLilyaEvent.GameStart, gameId)
end

function SpLilyaGameController:stopGame()
	self:_clearEnergyLaunchQueue()

	if not self._isRunning then
		return
	end

	if self._updateHandle then
		FixedUpdateBeat:RemoveListener(self._updateHandle)

		self._updateHandle = nil
	end

	self.removeEventCb(self, self, SpLilyaEvent.GamePause, self._onGamePause, self)
	self.removeEventCb(self, self, SpLilyaEvent.GameResume, self._onGameResume, self)

	self._isRunning = false
	self._isPaused = false
end

function SpLilyaGameController:_onGamePause()
	if self._isPaused then
		return
	end

	self._isPaused = true

	logWarn(string.format("[SpLilya][%.3f] GamePause", Time.realtimeSinceStartup))
end

function SpLilyaGameController:_onGameResume()
	if not self._isPaused then
		return
	end

	self._isPaused = false

	logWarn(string.format("[SpLilya][%.3f] GameResume", Time.realtimeSinceStartup))
end

function SpLilyaGameController:_onUpdate()
	if self._isPaused then
		return
	end

	local deltaTime = Time.deltaTime

	self:_updateEnergyLaunch(deltaTime)
	SpLilyaGameSceneMgr.instance:update(deltaTime)
	self:_updateTime(deltaTime)
	self:_updatePower(deltaTime)
	self:_updatePlayerMove(deltaTime)
	self:_updateAutoFire()
	self:_checkGameResult()
end

function SpLilyaGameController:_updateAutoFire()
	local gameMO = SpLilyaGameModel.instance:getGameMO()

	if not gameMO or gameMO.isGravity ~= SpLilyaEnum.UseGravity.Unuse then
		return
	end

	local playerMo = gameMO.playerMo

	if not playerMo then
		return
	end

	if playerMo.aimState ~= SpLilyaEnum.AimState.Aim then
		return
	end

	playerMo.powerTime = 0

	self:_doFire()
end

function SpLilyaGameController:_updateTime(deltaTime)
	local gameMO = SpLilyaGameModel.instance:getGameMO()

	if not gameMO then
		return
	end

	if gameMO.winType == SpLilyaEnum.VictoryType.Normal then
		return
	end

	local remainTime = (gameMO.remainTime or 0) - deltaTime

	gameMO.remainTime = remainTime
	self._timeUpdateElapsed = self._timeUpdateElapsed + deltaTime

	if self._timeUpdateElapsed >= SpLilyaEnum.GameTimeUpdateDuration then
		self._timeUpdateElapsed = 0

		self:dispatchEvent(SpLilyaEvent.TimeUpdate, remainTime)
	end
end

function SpLilyaGameController:_checkGameResult()
	if self._isGameOver then
		return
	end

	local gameMO = SpLilyaGameModel.instance:getGameMO()

	if not gameMO then
		return
	end

	if gameMO.winType == SpLilyaEnum.VictoryType.LimitTime then
		local remainTime = gameMO.remainTime

		if remainTime ~= nil and remainTime <= 0 then
			self:_setGameResult(true, gameMO.winType)
		end
	end
end

function SpLilyaGameController:checkEnemyCleared()
	if self._isGameOver then
		return
	end

	if not SpLilyaGameSceneMgr.instance:hasEnemy() then
		local gameMO = SpLilyaGameModel.instance:getGameMO()

		if gameMO then
			self:_setGameResult(true, gameMO.winType)
		end
	end
end

function SpLilyaGameController:checkPlayerLife()
	if self._isGameOver then
		return
	end

	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local playerMo = gameMO and gameMO.playerMo

	if playerMo then
		if (playerMo.life or 0) <= 0 then
			self:_setGameResult(false, gameMO.winType)
		end
	end
end

function SpLilyaGameController:checkBulletLimit()
	if self._isGameOver then
		return
	end

	local gameMO = SpLilyaGameModel.instance:getGameMO()

	if not gameMO or gameMO.winType ~= SpLilyaEnum.VictoryType.LimitBulle then
		return
	end

	local bulletLimit = tonumber(gameMO.winParam)

	if not bulletLimit then
		return
	end

	local sceneMo = gameMO.sceneMo

	if sceneMo then
		::label_40_0::

		local var_40_0 = sceneMo.useBulletMoDic

		if sceneMo.useBulletMoDic then
			local hasFlyingBullet = next(sceneMo.useBulletMoDic) ~= nil

			if bulletLimit <= (gameMO.shotCount or 0) and not hasFlyingBullet and not self:_canFireEnergy() and not self:_hasPendingEnergyLaunch() and SpLilyaGameSceneMgr.instance:hasKillableEnemy() then
				self:_setGameResult(false, gameMO.winType)
			end
		end
	end
end

function SpLilyaGameController:_canFireEnergy()
	local gameMO = SpLilyaGameModel.instance:getGameMO()

	if not gameMO or gameMO.isEnergy ~= SpLilyaEnum.UseEnergy.Use then
		return false
	end

	local playerMo = gameMO.playerMo

	if not playerMo then
		return false
	end

	if not playerMo.energyMax then
		local energyMax = 0
		local var_41_2

		if energyMax > 0 then
			if energyMax > (playerMo.curEnergy or 0) then
				var_41_2 = false

				goto label_41_0
			end
		end

		::label_41_0::

		return true
	end
end

function SpLilyaGameController:_setGameResult(isWin, winType)
	self._isGameOver = true

	self:stopGame()
	SpLilyaGameSceneMgr.instance:stop()

	local gameMO = SpLilyaGameModel.instance:getGameMO()

	if gameMO then
		if isWin then
			gameMO.gameResult = SpLilyaEnum.GameResult.Success or SpLilyaEnum.GameResult.Fail
		end

		local var_42_0

		if isWin then
			var_42_0 = StatEnum.Result.Success or StatEnum.Result.Fail
		end
	end

	self:sendGameStat(var_42_0)
	self:dispatchEvent(SpLilyaEvent.GameEnd, winType)
	self:lockScreen(true, SpLilyaEnum.AnimTime.Success)
	TaskDispatcher.runDelay(self._onSuccessAnimPlayFinish, self, SpLilyaEnum.AnimTime.Result)
end

function SpLilyaGameController:_onSuccessAnimPlayFinish()
	self:lockScreen(false)
	TaskDispatcher.cancelTask(self._onSuccessAnimPlayFinish, self)
	SpLilyaController.instance:openGameResultView()
end

function SpLilyaGameController:lockScreen(lock, time, viewName)
	if lock then
		UIBlockHelper.instance:startBlock(SpLilyaEnum.LockScreenKey, time, viewName)
	else
		UIBlockHelper.instance:endBlock(SpLilyaEnum.LockScreenKey)
	end
end

function SpLilyaGameController:exitGame()
	self:sendGameStat(StatEnum.Result.Exit)
	self:stopGame()

	self._isPower = false

	SpLilyaGameSceneMgr.instance:onDestroy()
	SpLilyaGameModel.instance:clearGameMO()

	self._isGameOver = false

	ViewMgr.instance:closeView(ViewName.SpLilyaGameResultView)
	ViewMgr.instance:closeView(ViewName.SpLilyaGameView)
	ViewMgr.instance:closeView(ViewName.SpLilyaGameTipView)
end

function SpLilyaGameController:restartGame()
	local actId = SpLilyaModel.instance:getActId()
	local episodeId = SpLilyaGameModel.instance:getCurEpisodeId()

	if not actId or not episodeId then
		return
	end

	self:sendGameStat(StatEnum.Result.Reset)
	ViewMgr.instance:closeView(ViewName.SpLilyaGameResultView)

	self._isPower = false

	self:initGame(actId, episodeId)
	self:startGame()
	self:dispatchEvent(SpLilyaEvent.GameReset)
end

function SpLilyaGameController:sendGameStat(result)
	if self._statSent then
		return
	end

	self._statSent = true

	local episodeId = SpLilyaGameModel.instance:getCurEpisodeId()

	if not episodeId then
		return
	end

	local nowTime = ServerTime.now()
	local startTime = SpLilyaGameModel.instance:getStartTime()
	local useTime = math.max(0, nowTime - (startTime or nowTime))

	StatController.instance:track(StatEnum.EventName.SpLilyaGame, {
		[StatEnum.EventProperties.SpLilyaGameEpisode] = tostring(episodeId),
		[StatEnum.EventProperties.SpLilyaResult] = StatEnum.Result2Cn[result],
		[StatEnum.EventProperties.SpLilyaUseTime] = useTime
	})
end

SpLilyaGameController.instance = SpLilyaGameController.New()

return SpLilyaGameController
