-- chunkname: @modules/logic/activity/controller/warmup/ActivityWarmUpGameController.lua

module("modules.logic.activity.controller.warmup.ActivityWarmUpGameController", package.seeall)

local ActivityWarmUpGameController = class("ActivityWarmUpGameController", BaseController)

function ActivityWarmUpGameController:onInit()
	return
end

function ActivityWarmUpGameController:reInit()
	return
end

function ActivityWarmUpGameController:openGameView(gameSettingId)
	math.randomseed((tonumber(tostring(ServerTime.now()):reverse():sub(1, 7))))
	ActivityWarmUpGameController.instance:initSettings(gameSettingId)
	ViewMgr.instance:openView(ViewName.ActivityWarmUpGameView)
end

function ActivityWarmUpGameController:initSettings(gameSettingId)
	self:defaultSettings()
	self:overrideSettings(gameSettingId)

	self._isPlaying = false
	self._startTime = -1
	self._finishTime = -1
end

function ActivityWarmUpGameController:defaultSettings()
	logNormal("defaultSettings")

	self.settings = {
		minBlock = 0.08,
		pointerSpeed = 0.012,
		cdTime = 1,
		randomLength = 0,
		blockCount = 4,
		victoryRound = 3,
		stayProb = 0.2,
		levelTime = 30,
		blockInterval = 0.05
	}
	self.poolTargetIds = {
		110404,
		110501,
		110502,
		110503,
		110504,
		111001,
		111002,
		111003,
		111004
	}
end

function ActivityWarmUpGameController:overrideSettings(gameSettingId)
	local gameCo = Activity106Config.instance:getMiniGameSettings(gameSettingId)

	if not gameCo then
		logError("minigame settings config not found : " .. tostring(gameSettingId))

		return
	end

	for k, v in pairs(self.settings) do
		if gameCo[k] ~= nil then
			self.settings[k] = gameCo[k]
		end
	end

	self.settings.minBlock = tonumber(self.settings.minBlock)
	self.settings.randomLength = tonumber(self.settings.randomLength)
	self.settings.pointerSpeed = tonumber(self.settings.pointerSpeed)

	if not string.nilorempty(gameCo.matPool) then
		self.poolTargetIds = string.splitToNumber(gameCo.matPool, ",")
	end
end

function ActivityWarmUpGameController:prepareGame()
	ActivityWarmUpGameModel.instance:init(self.settings, self.poolTargetIds)
end

function ActivityWarmUpGameController:startGame()
	self:clearLastResult()

	self._isPlaying = true
	self._moveDir = 1
	self._startTime = ServerTime.now()
	self._finishTime = self._startTime + self.settings.levelTime
	self._cdStartTime = 0
	ActivityWarmUpGameModel.instance.round = 1
end

function ActivityWarmUpGameController:stopGame()
	self._isPlaying = false
	self._cdStartTime = 0
end

function ActivityWarmUpGameController:saveGameClearResult()
	self._gameResult = true
end

function ActivityWarmUpGameController:clearLastResult()
	self._gameResult = false
	self._costTime = -1
end

function ActivityWarmUpGameController:getGameCostTime()
	return self._costTime
end

function ActivityWarmUpGameController:goNextRound()
	if ActivityWarmUpGameModel.instance.round then
		ActivityWarmUpGameModel.instance.round = ActivityWarmUpGameModel.instance.round + 1

		logNormal("round = " .. tostring(ActivityWarmUpGameModel.instance.round))
	end

	ActivityWarmUpGameModel.instance:init(self.settings, self.poolTargetIds, true)
end

function ActivityWarmUpGameController:gameClear()
	self:dispatchEvent(ActivityWarmUpEvent.NotifyGameClear)
end

local debugMoveTimes = 0

function ActivityWarmUpGameController:onGameUpdate()
	if self._isPlaying then
		if self:checkTimeOut() then
			return
		end

		local pointerVal = ActivityWarmUpGameModel.instance.pointerVal
		local fixedSpeed = self.settings.pointerSpeed * (Time.deltaTime / 0.016667)
		local nextVal = pointerVal + self._moveDir * fixedSpeed

		if self._moveDir > 0 then
			if nextVal >= 1 then
				self._moveDir = -1
				nextVal = 1
			end
		elseif nextVal <= 0 then
			self._moveDir = 1
			nextVal = 0
		end

		ActivityWarmUpGameModel.instance.pointerVal = nextVal
		debugMoveTimes = debugMoveTimes + 1
	end
end

function ActivityWarmUpGameController:checkTimeOut()
	if ServerTime.now() >= self._finishTime then
		self:dispatchEvent(ActivityWarmUpEvent.GameOverTimeOut)

		return true
	end

	return false
end

function ActivityWarmUpGameController:pointerTrigger()
	local pointerValue = ActivityWarmUpGameModel.instance.pointerVal
	local block = ActivityWarmUpGameModel.instance:getBlockDataByPointer(pointerValue)
	local noHit = true

	if block ~= nil and ActivityWarmUpGameModel.instance:isCurrentTarget(block) then
		noHit = false

		ActivityWarmUpGameModel.instance:gotoNextTarget()

		if ActivityWarmUpGameModel.instance:isAllTargetClean() then
			self:dispatchEvent(ActivityWarmUpEvent.GameTriggerHit, block)

			if ActivityWarmUpGameModel.instance.round >= self.settings.victoryRound then
				self._costTime = ServerTime.now() - self._startTime

				self:dispatchEvent(ActivityWarmUpEvent.GameOverFinished)
			else
				self:dispatchEvent(ActivityWarmUpEvent.GameNextRound)
			end

			return
		end
	end

	if noHit then
		self:dispatchEvent(ActivityWarmUpEvent.GameTriggerNoHit)
	else
		self:dispatchEvent(ActivityWarmUpEvent.GameTriggerHit, block)
	end
end

function ActivityWarmUpGameController:markCDTime()
	self._cdStartTime = ServerTime.now()
end

function ActivityWarmUpGameController:getIsCD()
	local curTime = ServerTime.now()

	if not self._cdStartTime then
		return false
	end

	return curTime - self._cdStartTime <= self.settings.cdTime
end

function ActivityWarmUpGameController:getIsPlaying()
	return self._isPlaying
end

function ActivityWarmUpGameController:getRemainTime()
	if self._isPlaying then
		return self._finishTime - ServerTime.now()
	else
		return nil
	end
end

function ActivityWarmUpGameController:getSettingRemainTime()
	return self.settings.levelTime
end

function ActivityWarmUpGameController:getSaveResult()
	return self._gameResult
end

ActivityWarmUpGameController.instance = ActivityWarmUpGameController.New()

LuaEventSystem.addEventMechanism(ActivityWarmUpGameController.instance)

return ActivityWarmUpGameController
