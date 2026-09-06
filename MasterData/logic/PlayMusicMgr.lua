-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playmusic/view/PlayMusicMgr.lua

module("logic.extensions.playmusic.view.PlayMusicMgr", package.seeall)

local PlayMusicMgr = class("PlayMusicMgr")

PlayMusicMgr.State = {
	Standing = 1,
	Runing = 3,
	Ended = 6,
	Stoping = 4,
	Ending = 5,
	Readying = 2
}

function PlayMusicMgr:ctor(gamePlanId, symbolCellRoot)
	self._symbolCellRoot = symbolCellRoot
	self._gamePlanId = gamePlanId

	if self._pmRecordMo == nil then
		self._pmRecordMo = PlayMusicRecordMo.New()
	end

	if self._pmObjPoolMgr == nil then
		self._pmObjPoolMgr = PlayMusicObjPoolMgr.New()
	end

	if self._pmLineMgr == nil then
		self._pmLineMgr = PlayMusicLineMgr.New()
	end

	self._isHasReset = false

	self:reset()
end

function PlayMusicMgr:reset()
	self._lastState = nil

	self:_onUpdateRhythm(0)

	self._lastTotalScore = nil
	self._curCoolingTime = 9999

	self._pmRecordMo:reset(self._gamePlanId)
	self._pmLineMgr:reset(self._gamePlanId)

	if self._symbolCellList then
		while #self._symbolCellList > 0 do
			self:_returnSymbolCell(self._symbolCellList[#self._symbolCellList])
		end
	else
		self._symbolCellList = {}
	end

	self._isHasReset = true
end

function PlayMusicMgr:clear()
	self:reset()
	self._pmRecordMo:clear()
	self._pmObjPoolMgr:clear()
	self._pmLineMgr:clear()

	self._isHasReset = false
end

function PlayMusicMgr:destroy()
	self._pmRecordMo:destroy()

	self._pmRecordMo = nil

	self._pmObjPoolMgr:destroy()

	self._pmObjPoolMgr = nil

	self._pmLineMgr:destroy()

	self._pmLineMgr = nil
end

function PlayMusicMgr:onTicking(deltaTime)
	if not self._isHasReset then
		printWarn("试图在未Reset就执行,请务必检查逻辑问题")

		return false
	end

	self._deltaTime = deltaTime

	if self:getCurTotalScore() ~= self._lastTotalScore then
		self._lastTotalScore = self:getCurTotalScore()

		self:_onUpdateRhythm(self._lastTotalScore)
	end

	self._curCoolingTime = self._curCoolingTime + self._deltaTime

	if self._state == PlayMusicMgr.State.Standing then
		-- block empty
	elseif self._state == PlayMusicMgr.State.Readying then
		-- block empty
	elseif self._state == PlayMusicMgr.State.Runing then
		self._pmRecordMo:addDeltaGameTime(self._deltaTime)
		self:_onUpdateGameRuning()
	elseif self._state == PlayMusicMgr.State.Stoping then
		-- block empty
	elseif self._state == PlayMusicMgr.State.Ending then
		-- block empty
	elseif self._state == PlayMusicMgr.State.Ended then
		-- block empty
	end

	return true
end

function PlayMusicMgr:changeState(state)
	self._state = state
end

function PlayMusicMgr:getCurState()
	return self._state
end

function PlayMusicMgr:_onUpdateGameRuning()
	local endSymbolCellList = {}

	for idx, symbolCell in ipairs(self._symbolCellList) do
		if symbolCell:isHit() == true then
			self._pmRecordMo:recordHit(symbolCell:getSymbolId(), symbolCell:getCurHitTimeRatio())
		elseif symbolCell:isOver() == true then
			self._pmRecordMo:recordHit(symbolCell:getSymbolId(), -1)
		end

		symbolCell:setAnimSpeed(self._gobalSymbolAnimSpeed)
		symbolCell:onTicking(self._deltaTime)

		if symbolCell:getCurState() == CircleSymbolCell.State.Ended then
			table.insert(endSymbolCellList, symbolCell)
		end
	end

	for i = 1, #endSymbolCellList do
		self:_returnSymbolCell(endSymbolCellList[i])

		endSymbolCellList[i] = nil
	end

	if self._pmRecordMo:isEnoughCompleteScore() then
		self:endingGame()

		return
	end

	if self._curCoolingTime >= self._createSymbolCD then
		for i = 1, self._maxOnceCDCreateSymbolCellCount do
			if #self._symbolCellList >= self._maxRunningSymbolCellCount then
				break
			end

			local lineId, symbolId = self._pmLineMgr:calcNewNodeInfo()

			if lineId == 0 or symbolId == 0 then
				break
			end

			local symbolCell = self:_fetchSymbolCell(symbolId)
			local posX, posY = self._pmLineMgr:createNode(symbolCell:getEntityId(), lineId)

			if posX == nil or posY == nil then
				self:_returnSymbolCell(symbolCell)
			else
				goutil.addChildToParent(symbolCell:getGameObject(), self._symbolCellRoot)
				GameUtil.setLocalPos(symbolCell:getGameObject(), posX, posY)
				GameUtil.SetActive(symbolCell:getGameObject(), true)

				self._curCoolingTime = 0
			end
		end
	end
end

function PlayMusicMgr:_onUpdateRhythm(score)
	local rhythmData = PlayMusicConfig.instance:getPmRhythmDataByIdAndCount(self._gamePlanId, score)

	self._gobalSymbolAnimSpeed = rhythmData.symbolAnimSpeed
	self._createSymbolCD = rhythmData.createSymbolCD
	self._maxOnceCDCreateSymbolCellCount = rhythmData.maxOnceCDCreateSymbolCellCount
	self._maxRunningSymbolCellCount = rhythmData.maxRunningSymbolCellCount
end

function PlayMusicMgr:stopGame()
	if self:getCurState() == PlayMusicMgr.State.Stoping then
		return
	end

	self._lastState = self:getCurState()

	self:changeState(PlayMusicMgr.State.Stoping)

	for _, symbolCell in ipairs(self._symbolCellList) do
		symbolCell:setEnable(false)
	end
end

function PlayMusicMgr:continueGame()
	if self:getCurState() == PlayMusicMgr.State.Runing then
		return
	end

	if self._lastState then
		self:changeState(self._lastState)

		self._lastState = nil
	else
		self:changeState(PlayMusicMgr.State.Runing)
	end

	for _, symbolCell in ipairs(self._symbolCellList) do
		symbolCell:setEnable(true)
	end
end

function PlayMusicMgr:endingGame()
	if self:getCurState() == PlayMusicMgr.State.Ending then
		return
	end

	self:changeState(PlayMusicMgr.State.Ending)
end

function PlayMusicMgr:endedGame()
	if self:getCurState() == PlayMusicMgr.State.Ended then
		return
	end

	self:changeState(PlayMusicMgr.State.Ended)
end

function PlayMusicMgr:resetGame()
	if self:getCurState() == PlayMusicMgr.State.Readying then
		return
	end

	self:reset()
	self:changeState(PlayMusicMgr.State.Readying)
end

function PlayMusicMgr:_fetchSymbolCell(symbolId)
	local symbolCell = self._pmObjPoolMgr:fetchSymbolCell(symbolId)

	table.insert(self._symbolCellList, symbolCell)

	return symbolCell
end

function PlayMusicMgr:_returnSymbolCell(symbolCell)
	self._pmLineMgr:removeNode(symbolCell:getEntityId())
	table.removebyvalue(self._symbolCellList, symbolCell)
	self._pmObjPoolMgr:returnSymbolCell(symbolCell)
end

function PlayMusicMgr:getCurSymbolCellCount()
	return #self._symbolCellList
end

function PlayMusicMgr:getCurGameTime()
	return self._pmRecordMo:getCurGameTime()
end

function PlayMusicMgr:getCurTotalScore()
	return self._pmRecordMo:getCurTotalScore()
end

function PlayMusicMgr:getCurTotalProgress()
	return self._pmRecordMo:getCurTotalProgress()
end

function PlayMusicMgr:getCurComboNum()
	return self._pmRecordMo:getCurComboNum()
end

function PlayMusicMgr:getMaxComboNum()
	return self._pmRecordMo:getMaxComboNum()
end

return PlayMusicMgr
