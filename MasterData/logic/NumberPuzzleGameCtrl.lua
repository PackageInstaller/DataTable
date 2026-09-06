-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/data/NumberPuzzleGameCtrl.lua

module("logic.extensions.numberpuzzlegame.view.data.NumberPuzzleGameCtrl", package.seeall)

local NumberPuzzleGameCtrl = class("NumberPuzzleGameCtrl")

function NumberPuzzleGameCtrl:ctor(mapId)
	self._mapId = checknumber(mapId)
	self._mapData = NumberPuzzleGameConfig.instance:getNpgMapData(self._mapId)
	self._mapCtrl = NumberPuzzleGameMapCtrl.New(self._mapId)
	self._detailMo = NumberPuzzleGameDetailMo.New(self._mapId)
	self._eachGetPropScore = self._mapData.eachGetPropScore
	self._maxCanStepCount = self._mapData.maxCanStepCount
	self._needMergeCount = self._mapData.needMergeCount
	self._state = NPGEnum.State_Stoping
	self._eachGetPropScoreIndex = 0
	self._curGameTime = 0
	self._propCounts = {}
	self._startUpPropNums = {}

	if not self._mapData.startUpPropNum then
		for index, prop in ipairs(NPGEnum.PropList) do
			self._startUpPropNums[prop] = checknumber(self._mapData.startUpPropNum[prop])
		end

		self:onReset()
	end
end

function NumberPuzzleGameCtrl:onReset()
	self._mapCtrl:onReset()
	self._detailMo:onReset()

	self._ignoreUsePropLimitInRecord = false
	self._state = NPGEnum.State_Stoping
	self._eachGetPropScoreIndex = 0
	self._curGameTime = 0

	table.clear(self._propCounts)

	for k, prop in ipairs(NPGEnum.PropList) do
		self._propCounts[prop] = self._startUpPropNums[prop]
	end

	local maxGridId = 0
	local gridIndexListMap = self._mapCtrl:getGridIndexListMap()

	for gridId, gridIndex in pairs(gridIndexListMap) do
		maxGridId = Mathf.Max(maxGridId, gridId)
	end

	local gbId = NumberPuzzleGameConfig.instance:getGbId(self._mapId, maxGridId)

	self._detailMo:setMaxGbId(gbId)
end

function NumberPuzzleGameCtrl:onDestroy()
	self._mapCtrl:onDestroy()
	self._detailMo:onDestroy()
end

function NumberPuzzleGameCtrl:onTicking(deltaTime)
	self._deltaTime = deltaTime

	if self._state == NPGEnum.State_Runing then
		self._curGameTime = self._curGameTime + self._deltaTime
	elseif self._state == NPGEnum.State_Stoping then
		-- block empty
	elseif self._state == NPGEnum.State_Ended then
		-- block empty
	end

	if self._isNeedDispatch then
		self._isNeedDispatch = false

		self:dispatchUpdateGameUI()
	end
end

function NumberPuzzleGameCtrl:resetGame()
	self:onReset()
	self:continueGame()
end

function NumberPuzzleGameCtrl:endGame()
	self:_changeState(NPGEnum.State_Ended)
end

function NumberPuzzleGameCtrl:stopGame()
	self:_changeState(NPGEnum.State_Stoping)
end

function NumberPuzzleGameCtrl:continueGame()
	self:_changeState(NPGEnum.State_Runing)
end

function NumberPuzzleGameCtrl:getCurState()
	return self._state
end

function NumberPuzzleGameCtrl:_changeState(state)
	self._state = state
end

function NumberPuzzleGameCtrl:isPass()
	return self._isPass
end

function NumberPuzzleGameCtrl:_setIsPass(isPass)
	self._isPass = isPass
end

function NumberPuzzleGameCtrl:getCurGameTime()
	return self._curGameTime
end

function NumberPuzzleGameCtrl:readyToDispatchUpdateGameUI()
	self._isNeedDispatch = true
end

function NumberPuzzleGameCtrl:dispatchUpdateGameUI()
	GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameUpdateUI)
end

function NumberPuzzleGameCtrl:getTryMergeMapResultAndTips()
	local result = NPGEnum.ResultCode_Success
	local tips = ""

	if not self._mapCtrl:isHaveAir() then
		result = NPGEnum.ResultCode_Error
		tips = "无法移动"
	end

	if result == NPGEnum.ResultCode_Success and self._detailMo:getGameMode() == NPGEnum.GameMode_Sup and self._detailMo:getLeftEnergy() <= 0 then
		result = NPGEnum.ResultCode_Error
		tips = "体力不足"
	end

	return result, tips
end

function NumberPuzzleGameCtrl:doMergeMap(toward)
	local result = NPGEnum.ResultCode_Success

	if result == NPGEnum.ResultCode_Success then
		local recordId = self._mapCtrl:mergeMap(toward)

		if recordId > 0 then
			result = NPGEnum.ResultCode_Success

			self:_updateDetails(recordId)
			self._detailMo:addCurStep(1)
			self._detailMo:updateLeftEnergy(-1)
		else
			result = NPGEnum.ResultCode_Error
		end
	end

	return result
end

function NumberPuzzleGameCtrl:getTryAddRadomGridResultAndTips()
	local result = NPGEnum.ResultCode_Success
	local tips = ""

	if not self._mapCtrl:isHaveEmptyGrid() then
		result = NPGEnum.ResultCode_Error
		tips = "没有空位"
	end

	return result, tips
end

function NumberPuzzleGameCtrl:doAddRadomGrid(count)
	local result = NPGEnum.ResultCode_Success
	local recordId = self._mapCtrl:addRadomGrid(count)

	if recordId > 0 then
		result = NPGEnum.ResultCode_Success

		self:_updateDetails(recordId)
		self._detailMo:addCurStep(1)
	else
		result = NPGEnum.ResultCode_Error
	end

	return result
end

function NumberPuzzleGameCtrl:getGameStateResultAndTips()
	local result = NPGEnum.ResultCode_GameRuning
	local gameMode = self._detailMo:getGameMode()

	if gameMode == NPGEnum.GameMode_Nor then
		local isEnoughNotOverMaxStep = self:isEnoughCondOfNotOverMaxStep()
		local isEnoughMergeCount = self:isEnoughCondOfNeedMergeCount()

		if not isEnoughNotOverMaxStep then
			result = NPGEnum.ResultCode_GameOverOfFail
		elseif isEnoughNotOverMaxStep and isEnoughMergeCount then
			result = NPGEnum.ResultCode_GameOverOfSuccess
		elseif not self._mapCtrl:isHaveAir() and not self:isCanUseProp() then
			result = NPGEnum.ResultCode_GameOverOfFail
		end
	elseif gameMode == NPGEnum.GameMode_Ext then
		if not self._mapCtrl:isHaveAir() and not self:isCanUseProp() then
			result = NPGEnum.ResultCode_GameOverOfFail
		end
	elseif gameMode == NPGEnum.GameMode_Sup then
		local isEnoughMergeCount = self:isEnoughCondOfNeedMergeCount()

		if self:isEnoughCondOfNeedMergeCount() then
			result = NPGEnum.ResultCode_GameOverOfSuccess
		elseif not self._mapCtrl:isHaveAir() and not self:isCanUseProp() then
			result = NPGEnum.ResultCode_GameOverOfFail
		elseif self._detailMo:getLeftEnergy() <= 0 then
			result = NPGEnum.ResultCode_GameOverOfFail
		end
	end

	return result
end

function NumberPuzzleGameCtrl:getTryUsePropQueueResultAndTips()
	local result = NPGEnum.ResultCode_Success
	local tips = ""
	local propType = NPGEnum.Prop_Queue

	if not self:isEnoughCountOfProp(propType) then
		result = NPGEnum.ResultCode_Error
		tips = "道具数量不足"
	elseif self:isHasUsePropCurRecord() then
		result = NPGEnum.ResultCode_Error
		tips = "该回合已使用道具"
	end

	return result, tips
end

function NumberPuzzleGameCtrl:usePropQueue(isReverse)
	local result = NPGEnum.ResultCode_Success
	local propType = NPGEnum.Prop_Queue
	local recordId = self._mapCtrl:queueMap(isReverse)

	if recordId > 0 then
		result = NPGEnum.ResultCode_Success

		self:setPropCount(propType, self:getPropCount(propType) - 1)
		self:_updateDetails(recordId)
	else
		result = NPGEnum.ResultCode_Error
	end

	return result
end

function NumberPuzzleGameCtrl:getTryUsePropUniversalCardResultAndTips()
	local result = NPGEnum.ResultCode_Success
	local tips = ""
	local propType = NPGEnum.Prop_UniversalCard

	if not self:isEnoughCountOfProp(propType) then
		result = NPGEnum.ResultCode_Error
		tips = "道具数量不足"
	elseif self:isHasUsePropCurRecord() then
		result = NPGEnum.ResultCode_Error
		tips = "该回合已使用道具"
	elseif self._mapCtrl._mapMoOfRun:getEmptyGridCount() <= 0 then
		result = NPGEnum.ResultCode_Error
		tips = "当前没有空位可以使用万能材料！"
	end

	return result, tips
end

function NumberPuzzleGameCtrl:usePropUniversalCard()
	local result = NPGEnum.ResultCode_Success
	local propType = NPGEnum.Prop_UniversalCard
	local recordId = self._mapCtrl:universalMap()

	if recordId > 0 then
		result = NPGEnum.ResultCode_Success

		self:setPropCount(propType, self:getPropCount(propType) - 1)
		self:_updateDetails(recordId)
	else
		result = NPGEnum.ResultCode_Error
	end

	return result
end

function NumberPuzzleGameCtrl:getTryUsePropKnockResultAndTips()
	local result = NPGEnum.ResultCode_Success
	local tips = ""
	local propType = NPGEnum.Prop_Knock

	if not self:isEnoughCountOfProp(propType) then
		result = NPGEnum.ResultCode_Error
		tips = "道具数量不足"
	elseif self:isHasUsePropCurRecord() then
		result = NPGEnum.ResultCode_Error
		tips = "该回合已使用道具"
	elseif self._mapCtrl:getDifferentGridIdCount() < 2 then
		result = NPGEnum.ResultCode_Error
		tips = "可消除格子类型不足2个"
	end

	return result, tips
end

function NumberPuzzleGameCtrl:usePropKnock()
	local result = NPGEnum.ResultCode_Success
	local propType = NPGEnum.Prop_Knock
	local recordId = self._mapCtrl:knockMap(2)

	if recordId > 0 then
		result = NPGEnum.ResultCode_Success

		self:setPropCount(propType, self:getPropCount(propType) - 1)
		self:_updateDetails(recordId)
	else
		result = NPGEnum.ResultCode_Error
	end

	return result
end

function NumberPuzzleGameCtrl:isCanUseProp()
	if self:getTryUsePropQueueResultAndTips() == NPGEnum.ResultCode_Success or self:getTryUsePropUniversalCardResultAndTips() == NPGEnum.ResultCode_Success or self:getTryUsePropKnockResultAndTips() == NPGEnum.ResultCode_Success then
		return true
	end

	return false
end

function NumberPuzzleGameCtrl:randomAddProp(delta)
	delta = delta or 1

	for i = 1, delta do
		local propType = NPGEnum.PropList[Mathf.Random(1, #NPGEnum.PropList)]

		self:setPropCount(propType, self:getPropCount(propType) + 1)
	end
end

function NumberPuzzleGameCtrl:getTotalPropCount()
	local count = 0

	for _, propType in ipairs(NPGEnum.PropList) do
		count = count + self:getPropCount(propType)
	end

	return count
end

function NumberPuzzleGameCtrl:getPropCount(propType)
	return self._propCounts[propType] or 0
end

function NumberPuzzleGameCtrl:setPropCount(propType, num)
	self._propCounts[propType] = Mathf.Max(0, num)
end

function NumberPuzzleGameCtrl:isEnoughCountOfProp(propType)
	return self:getPropCount(propType) > 0
end

function NumberPuzzleGameCtrl:isHasUsePropCurRecord()
	local isHasUse = false
	local recordId = self._mapCtrl:getCurRecordId()

	if recordId > 0 then
		local motionRecord = self._mapCtrl:getMotionRecord(recordId)

		for _, motionMo in ipairs(motionRecord) do
			if motionMo:getMotionType() == NPGEnum.Motion_Queue or motionMo:getMotionType() == NPGEnum.Motion_UniversalCard or motionMo:getMotionType() == NPGEnum.Motion_Knock then
				isHasUse = true

				break
			end
		end
	end

	if self._ignoreUsePropLimitInRecord then
		isHasUse = false
	end

	return isHasUse
end

function NumberPuzzleGameCtrl:setIgnoreUsePropLimitInRecord(value)
	self._ignoreUsePropLimitInRecord = value
end

function NumberPuzzleGameCtrl:_updateDetails(recordId)
	if recordId <= 0 then
		printError("非法操作")

		return
	end

	local motionRecord = self._mapCtrl:getMotionRecord(recordId)

	for _, motionMo in ipairs(motionRecord) do
		local motionType = motionMo:getMotionType()
		local motionParam = motionMo:getParam()

		if motionType == NPGEnum.Motion_Move then
			self:_updateDetailOfMove(GameUtil.unpack10(motionParam))
		elseif motionType == NPGEnum.Motion_Merge then
			self:_updateDetailOfMerge(GameUtil.unpack10(motionParam))
		elseif motionType == NPGEnum.Motion_Create then
			self:_updateDetailOfCreate(GameUtil.unpack10(motionParam))
		elseif motionType == NPGEnum.Motion_Destroy then
			self:_updateDetailOfDestroy(GameUtil.unpack10(motionParam))
		elseif motionType == NPGEnum.Motion_Queue then
			self:_updateDetailOfQueue(GameUtil.unpack10(motionParam))
		elseif motionType == NPGEnum.Motion_UniversalCard then
			self:_updateDetailOfUniversalCard(GameUtil.unpack10(motionParam))
		elseif motionType == NPGEnum.Motion_Knock then
			self:_updateDetailOfKnock(GameUtil.unpack10(motionParam))
		end
	end

	if self._eachGetPropScore > 0 then
		local totalScore = self._detailMo:getTotalScore()
		local fitIndex = Mathf.Floor(totalScore / self._eachGetPropScore)
		local delta = fitIndex - self._eachGetPropScoreIndex

		self._eachGetPropScoreIndex = fitIndex

		self:randomAddProp(delta)
	end
end

function NumberPuzzleGameCtrl:_updateDetailOfMove(formGridIndex, toGridIndex)
	return
end

function NumberPuzzleGameCtrl:_updateDetailOfMerge(formGridIndex, toGridIndex, formBeforeGridId, toAfterGridId)
	self._detailMo:mergeGrid(toAfterGridId)
end

function NumberPuzzleGameCtrl:_updateDetailOfCreate(gridIndex, gridId)
	return
end

function NumberPuzzleGameCtrl:_updateDetailOfDestroy(gridIndex, gridId)
	return
end

function NumberPuzzleGameCtrl:_updateDetailOfQueue(beforeQueue, afterQueue)
	return
end

function NumberPuzzleGameCtrl:_updateDetailOfUniversalCard()
	return
end

function NumberPuzzleGameCtrl:_updateDetailOfKnock(gridIndexList)
	return
end

function NumberPuzzleGameCtrl:isEnoughCondOfNotOverMaxStep()
	local isEnough = true

	if self:isNeedCheckCondOfNotOverMaxStep() then
		local curStep = self._detailMo:getCurStep()

		isEnough = curStep <= self._maxCanStepCount
	end

	return isEnough
end

function NumberPuzzleGameCtrl:isNeedCheckCondOfNotOverMaxStep()
	return self:getMaxCanStepCount() > 0
end

function NumberPuzzleGameCtrl:getLeftStepCount()
	local curStep = self._detailMo:getCurStep()

	return Mathf.Max(self:getMaxCanStepCount() - curStep, 0)
end

function NumberPuzzleGameCtrl:getMaxCanStepCount()
	return self._maxCanStepCount
end

function NumberPuzzleGameCtrl:isEnoughCondOfNeedMergeCount()
	local isEnough = true

	if self:isNeedCheckCondOfNeedMergeCount() then
		local gridId = self:getNeedMergeGridIdCond()
		local count = self:getNeedMergeCountCond()
		local curCount = self._detailMo:getGridMergeCount(gridId)

		isEnough = count <= curCount
	end

	return isEnough
end

function NumberPuzzleGameCtrl:getNeedMergeGridIdCond()
	return (self:isNeedCheckCondOfNeedMergeCount() or nil) and self._needMergeCount[1]
end

function NumberPuzzleGameCtrl:getNeedMergeCountCond()
	return (self:isNeedCheckCondOfNeedMergeCount() or nil) and self._needMergeCount[2]
end

function NumberPuzzleGameCtrl:isNeedCheckCondOfNeedMergeCount()
	return self._needMergeCount ~= nil
end

return NumberPuzzleGameCtrl
