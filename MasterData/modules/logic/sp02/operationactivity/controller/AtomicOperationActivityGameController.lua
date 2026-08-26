-- chunkname: @modules/logic/sp02/operationactivity/controller/AtomicOperationActivityGameController.lua

module("modules.logic.sp02.operationactivity.controller.AtomicOperationActivityGameController", package.seeall)

local AtomicOperationActivityGameController = class("AtomicOperationActivityGameController", BaseController)

function AtomicOperationActivityGameController:onInit()
	self:reInit()
end

function AtomicOperationActivityGameController:reInit()
	self.logicData = nil
end

function AtomicOperationActivityGameController:initGame()
	self.logicData = AtomicOperationActivityGameModel.instance:getInfoMo()

	self.logicData:init()
	self:buildGameData()
end

function AtomicOperationActivityGameController:initPosData(posDataList)
	self.logicData:initPointData(posDataList)
end

function AtomicOperationActivityGameController:buildGameData()
	self:buildTarget()
end

function AtomicOperationActivityGameController:buildTarget()
	self.logicData.targetConfigList = AtomicOperationActivityConfig.instance:getTargetConfigList()
end

function AtomicOperationActivityGameController:getRandomIndex()
	local index

	while index == nil do
		local tempIndex = math.floor(math.random(1, AtomicOperationActivityEnum.GameMaxTargetCount))

		if not self.logicData:isUseTargetIndex(tempIndex) then
			index = tempIndex
		end
	end

	return index
end

function AtomicOperationActivityGameController:getRandomIndexWithUsed()
	return (math.floor(math.random(1, AtomicOperationActivityEnum.GameMaxTargetCount)))
end

function AtomicOperationActivityGameController:enterGame()
	logNormal("enterGame")
	self:initGame()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenViewFinish, self)
	ViewMgr.instance:openView(ViewName.AtomicOperationActivityGameView)
end

function AtomicOperationActivityGameController:onOpenViewFinish()
	self:dispatchEvent(AtomicOperationActivityGameEvent.InitGame)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenViewFinish, self)
	ViewMgr.instance:openView(ViewName.AtomicOperationActivityGameCountDownView)
	TaskDispatcher.runDelay(self.startGame, self, AtomicOperationActivityEnum.DelayTime.GameCountDown)
end

function AtomicOperationActivityGameController:startGame()
	TaskDispatcher.cancelTask(self.startGame, self)
	ViewMgr.instance:closeView(ViewName.AtomicOperationActivityGameCountDownView)
	logNormal("startGame")
	TaskDispatcher.runRepeat(self.gameLogicUpdate, self, AtomicOperationActivityEnum.DelayTime.GameLogic)
	self:dispatchEvent(AtomicOperationActivityGameEvent.StartGame)
end

function AtomicOperationActivityGameController:gameLogicUpdate()
	if self.logicData.isPause then
		return
	end

	local deltaTime = Time.deltaTime * Time.timeScale

	self.logicData.remainTime = self.logicData.remainTime - deltaTime
	self.logicData.deltaTime = deltaTime

	if self.logicData.remainTime <= 0 then
		TaskDispatcher.cancelTask(self.gameLogicUpdate, self)
		self:endGame()

		return
	end

	self:checkTargetDisappear()
end

function AtomicOperationActivityGameController:pauseGame()
	self.logicData.isPause = true
end

function AtomicOperationActivityGameController:resumeGame()
	self.logicData.isPause = false
end

function AtomicOperationActivityGameController:checkTargetDisappear()
	local tempRemoveList = {}
	local removeCount = 0

	if self.logicData.curTargetCount > 0 then
		for _, targetMo in pairs(self.logicData.useTargetDic) do
			targetMo.remainTime = targetMo.remainTime - self.logicData.deltaTime

			if targetMo.hitCD > 0 then
				targetMo.hitCD = math.max(0, targetMo.hitCD - self.logicData.deltaTime)
			end

			if targetMo.remainTime <= 0 then
				if targetMo.state == AtomicOperationActivityEnum.TargetState.Normal then
					self:changeTargetState(targetMo, AtomicOperationActivityEnum.TargetState.Disappear)
				elseif targetMo.state == AtomicOperationActivityEnum.TargetState.Hit then
					self:changeTargetState(targetMo, AtomicOperationActivityEnum.TargetState.HitDisappear)
				else
					removeCount = removeCount + 1

					table.insert(tempRemoveList, targetMo.index)
				end
			end
		end
	end

	if removeCount > 0 then
		for _, index in ipairs(tempRemoveList) do
			self:removeTargetNode(index)
		end

		self:dispatchEvent(AtomicOperationActivityGameEvent.RemoveTarget, tempRemoveList)
	end

	if self.logicData.curTargetCount < self.logicData.maxTargetCount then
		local tempAddList = {}
		local addCount = 0

		for i, _ in pairs(self.logicData.targetPosIndexList) do
			if not self.logicData:isUseTargetIndex(i) then
				logNormal("尝试目标生成 位置: " .. tostring(i))

				if not self.logicData.targetPosRemainTimeDic[i] then
					local remainCD = 0

					remainCD = self.logicData.targetPosRemainTimeDic[i] - self.logicData.deltaTime

					if self.logicData.curTargetCount < self.logicData.maxTargetCount and self.logicData.targetPosRemainTimeDic[i] <= 0 then
						logNormal("尝试目标生成 CD为0 位置: " .. tostring(i))

						local id = self:getRandomTarget()

						self:addTargetNode(i, id)
						table.insert(tempAddList, i)

						addCount = addCount + 1
					else
						logNormal("尝试目标生成失败,未到CD 位置: " .. tostring(i))

						self.logicData.targetPosRemainTimeDic[i] = self.logicData.targetPosRemainTimeDic[i]
					end
				end
			end
		end

		if addCount > 0 then
			self:dispatchEvent(AtomicOperationActivityGameEvent.AddTarget, tempAddList)
		end
	end
end

function AtomicOperationActivityGameController:getRandomTargetPosCD()
	return self.logicData.posRemainTimeRange[1] + (self.logicData.posRemainTimeRange[2] - self.logicData.posRemainTimeRange[1]) * math.random()
end

function AtomicOperationActivityGameController:getRandomTarget()
	local randomValue = math.random()
	local weight = randomValue * AtomicOperationActivityEnum.WeightMultiple

	return (self:getTargetByWeight(weight))
end

function AtomicOperationActivityGameController:getTargetByWeight(weight)
	local totalWeight = 0

	for _, config in ipairs(self.logicData.targetConfigList) do
		totalWeight = totalWeight + config.weight

		if weight <= totalWeight then
			return config.id
		end
	end

	return 1
end

function AtomicOperationActivityGameController:addTargetNode(index, targetId)
	if self:isPreparationFix(AtomicOperationActivityEnum.PreparationId.MoreScoreEnemy) then
		local replaceId = self.logicData.replaceTargetDic[targetId]

		if replaceId then
			targetId = replaceId
		end
	end

	local infoMo = self.logicData:getTargetNode(index)

	infoMo:updateMo(targetId, index)
	self:changeTargetState(infoMo, AtomicOperationActivityEnum.TargetState.Normal)
	self.logicData:addTargetNode(infoMo)
	logNormal("目标生成 位置: " .. tostring(index) .. " id: " .. tostring(targetId))
end

function AtomicOperationActivityGameController:removeTargetNode(index)
	self.logicData:removeTargetNode(index)

	self.logicData.targetPosRemainTimeDic[index] = 0

	local remainTime = self:getRandomTargetPosCD()

	self.logicData.targetPosRemainTimeDic[index] = remainTime

	logNormal("目标移除 位置: " .. tostring(index) .. " CD: " .. tostring(remainTime))
end

function AtomicOperationActivityGameController:changeTargetState(targetMo, state)
	targetMo.state = state

	local delayTime = 0

	if state == AtomicOperationActivityEnum.TargetState.Normal then
		local disappearParam = string.splitToNumber(targetMo.config.disappearTime, "#")
		local disappearDelay = math.random(disappearParam[1], disappearParam[2])

		delayTime = disappearDelay + AtomicOperationActivityEnum.DelayTime.TargetAppear
	elseif state == AtomicOperationActivityEnum.TargetState.Disappear then
		delayTime = AtomicOperationActivityEnum.DelayTime.TargetDisappear
	elseif state == AtomicOperationActivityEnum.TargetState.HitDisappear then
		delayTime = AtomicOperationActivityEnum.DelayTime.TargetHitAppear
	elseif state == AtomicOperationActivityEnum.TargetState.Hit then
		delayTime = AtomicOperationActivityEnum.DelayTime.TargetHit
	end

	targetMo.stateTime = delayTime
	targetMo.remainTime = delayTime

	self:dispatchEvent(AtomicOperationActivityGameEvent.ChangeState, targetMo.index, state)
end

function AtomicOperationActivityGameController:onHitBackground(pointData)
	if self.logicData.curTargetCount <= 0 then
		return
	end

	logNormal("点击区域 pos: x: " .. tostring(pointData[1]) .. "y: " .. tostring(pointData[2]))

	for _, targetMo in pairs(self.logicData.singleTargetDic) do
		if targetMo.hitCD <= 0 and self:isHit(targetMo, pointData) then
			self:onTargetHit(targetMo, true)
		end
	end
end

function AtomicOperationActivityGameController:onTargetHit(targetMo, isDirectHit)
	logNormal("点击目标 index: " .. tostring(targetMo.index))

	if targetMo.hitCount >= 1 and not self:isPreparationFix(AtomicOperationActivityEnum.PreparationId.AfterHit) then
		return
	end

	targetMo.hitCD = AtomicOperationActivityConfig.instance:getConstNum(AtomicOperationActivityEnum.ConstId.hitCD)

	if targetMo.hitCount <= 0 then
		if not targetMo.config.firstScore then
			local score = targetMo.config.afterScore

			targetMo.hitCount = targetMo.hitCount + 1
			self.logicData.curHitCount = self.logicData.curHitCount + 1

			if score > 0 and self:isPreparationFix(AtomicOperationActivityEnum.PreparationId.DoubleScore) then
				local config = AtomicOperationActivityConfig.instance:getPreparationConfig(AtomicOperationActivityEnum.PreparationId.DoubleScore)

				score = score * tonumber(config.buffpara)
			elseif score < 0 and self:isPreparationFix(AtomicOperationActivityEnum.PreparationId.NoReduceScore) then
				local config = AtomicOperationActivityConfig.instance:getPreparationConfig(AtomicOperationActivityEnum.PreparationId.NoReduceScore)

				score = score * tonumber(config.buffpara)
			end

			if score >= 0 then
				local curCombo = self.logicData.comboCount + 1

				if curCombo >= AtomicOperationActivityEnum.ComboLimit then
					score = score + targetMo.config.afterScore
				end

				self.logicData.comboCount = curCombo
				self.logicData.maxComboCount = math.max(self.logicData.maxComboCount, curCombo)
			else
				self.logicData.comboCount = 0
			end

			self.logicData.curScore = math.max(0, self.logicData.curScore + score)

			self:changeTargetState(targetMo, AtomicOperationActivityEnum.TargetState.Hit)

			if isDirectHit and self:isPreparationFix(AtomicOperationActivityEnum.PreparationId.NearHit) then
				local config = AtomicOperationActivityConfig.instance:getPreparationConfig(AtomicOperationActivityEnum.PreparationId.NearHit)
				local nearCount = tonumber(config.buffpara)
				local nearPointCount = math.min(nearCount, self.logicData.curTargetCount - 1)
				local nearData = self.logicData:getNearPoint(targetMo.index)
				local hitCount = 0

				for _, pointData in ipairs(nearData) do
					if self.logicData.useTargetDic[pointData.p] then
						self:onTargetHit(self.logicData.useTargetDic[pointData.p], false)

						hitCount = hitCount + 1
					end

					if nearPointCount <= hitCount then
						return
					end
				end
			end
		end
	end
end

function AtomicOperationActivityGameController:isPreparationFix(id)
	if id then
		return false
	end

	local infoMo = AtomicOperationActivityModel.instance:getCurInfoMo()

	return infoMo and infoMo:isPreparationFixed(id)
end

function AtomicOperationActivityGameController:isHit(targetMo, pointData)
	local pos = self.logicData.targetPosList[targetMo.index]
	local distance = AtomicOperationActivityHelper.dist(pos, pointData)

	return distance <= targetMo.hitRadius
end

function AtomicOperationActivityGameController:tryEndGame()
	self:pauseGame()
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.IgorGameExitConfirm, MsgBoxEnum.BoxType.Yes_No, self.manualExitGame, self.resumeGame, nil, self, self)
end

function AtomicOperationActivityGameController:onEndGame()
	self.logicData.isPause = false

	TaskDispatcher.cancelTask(self.startGame, self)
	TaskDispatcher.cancelTask(self.gameLogicUpdate, self)
	logNormal("endGame")
	self:dispatchEvent(AtomicOperationActivityGameEvent.EndGame)
	ViewMgr.instance:openView(ViewName.AtomicOperationActivityResultGameView)
end

function AtomicOperationActivityGameController:manualExitGame()
	logNormal("manualExitGame")
	TaskDispatcher.cancelTask(self.startGame, self)
	TaskDispatcher.cancelTask(self.gameLogicUpdate, self)
	self:exitGame()
end

function AtomicOperationActivityGameController:endGame()
	local gameInfo = {}

	gameInfo[1] = AtomicOperationActivityEnum.ProgressType.GameCount
	gameInfo[2] = 1

	local hitInfo = {}

	hitInfo[1] = AtomicOperationActivityEnum.ProgressType.Score
	hitInfo[2] = self.logicData.curScore

	local data = {
		gameInfo,
		hitInfo
	}
	local actId = AtomicOperationActivityModel.instance:getCurGameId()

	AtomicOperationActivityRpc.instance:sendFinishMiniGameRequest(actId, data, self.onEndGame, self)
end

function AtomicOperationActivityGameController:exitGame()
	self.logicData = nil

	logNormal("exitGame")
	ViewMgr.instance:closeView(ViewName.AtomicOperationActivityGameCountDownView)
	ViewMgr.instance:closeView(ViewName.AtomicOperationActivityGameView)
	ViewMgr.instance:closeView(ViewName.AtomicOperationActivityResultGameView)
end

function AtomicOperationActivityGameController:restartGame()
	logNormal("restartGame")
	self:initGame()
	self:onOpenViewFinish()
	ViewMgr.instance:closeView(ViewName.AtomicOperationActivityResultGameView)
end

AtomicOperationActivityGameController.instance = AtomicOperationActivityGameController.New()

return AtomicOperationActivityGameController
