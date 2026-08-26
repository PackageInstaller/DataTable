-- chunkname: @modules/logic/versionactivity2_4/warmup/model/V2a4_WarmUpBattleRoundMO.lua

module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpBattleRoundMO", package.seeall)

local sf = string.format
local ti = table.insert
local V2a4_WarmUpBattleRoundMO = class("V2a4_WarmUpBattleRoundMO")

function V2a4_WarmUpBattleRoundMO:ctor(waveMO, index, gachaRoundMO)
	self._index = index
	self._waveMO = waveMO
	self._gachaMO = gachaRoundMO
	self._isFinished = false
	self._isWin = false
	self._state = V2a4_WarmUpEnum.RoundState.None
	self._userAnsIsYes = nil
end

function V2a4_WarmUpBattleRoundMO:index()
	return self._index
end

function V2a4_WarmUpBattleRoundMO:isWin()
	return self._isWin
end

function V2a4_WarmUpBattleRoundMO:isFinished()
	return self._isFinished
end

function V2a4_WarmUpBattleRoundMO:userAnsIsYes()
	return self._userAnsIsYes
end

function V2a4_WarmUpBattleRoundMO:cfgId()
	return self._gachaMO:cfgId()
end

function V2a4_WarmUpBattleRoundMO:type()
	return self._gachaMO:type()
end

function V2a4_WarmUpBattleRoundMO:isText()
	return self:type() == V2a4_WarmUpEnum.AskType.Text
end

function V2a4_WarmUpBattleRoundMO:isPhoto()
	return self:type() == V2a4_WarmUpEnum.AskType.Photo
end

function V2a4_WarmUpBattleRoundMO:resUrl()
	local imgName = self._gachaMO:imgName()

	return ResUrl.getV2a4WarmUpSingleBg(imgName)
end

function V2a4_WarmUpBattleRoundMO:answer(isYes)
	if self._isFinished then
		return
	end

	self._isFinished = true
	self._userAnsIsYes = isYes
	self._isWin = self._gachaMO:ansIsYes() == isYes
end

function V2a4_WarmUpBattleRoundMO:isPreTalk()
	return self._state == V2a4_WarmUpEnum.RoundState.PreTalk
end

function V2a4_WarmUpBattleRoundMO:isAsk()
	return self._state == V2a4_WarmUpEnum.RoundState.Ask
end

function V2a4_WarmUpBattleRoundMO:isWaitAns()
	return self._state == V2a4_WarmUpEnum.RoundState.WaitAns
end

function V2a4_WarmUpBattleRoundMO:isAnsed()
	return self._state == V2a4_WarmUpEnum.RoundState.Ansed
end

function V2a4_WarmUpBattleRoundMO:isReplyResult()
	return self._state == V2a4_WarmUpEnum.RoundState.ReplyResult
end

function V2a4_WarmUpBattleRoundMO:isLastRound()
	return self._waveMO:isLastRound()
end

function V2a4_WarmUpBattleRoundMO:isFirstRound()
	return self._waveMO:isFirstRound()
end

function V2a4_WarmUpBattleRoundMO:isFirstWave()
	return self._waveMO:isFirstWave()
end

function V2a4_WarmUpBattleRoundMO:isNeedPreface()
	return self:isFirstWave() and not V2a4_WarmUpController.instance:getIsShownPreface()
end

function V2a4_WarmUpBattleRoundMO:isNeedPassTalkAllYes()
	return self:isLastRound() and self._waveMO:isAllAskYes()
end

function V2a4_WarmUpBattleRoundMO:_moveState()
	local newState = self._state + 1

	self._tmp_dialogStep = 0

	if newState == V2a4_WarmUpEnum.RoundState.__End then
		self._tmp_dialogCOList = {}

		return false
	end

	self._state = self:isWaitAns() and (self._isFinished and newState or self._state) or newState

	local __errlog

	if isDebugBuild then
		local __msg = {}

		function __errlog(condition, dialogType)
			if not condition then
				ti(__msg, sf("error state = %s, dialog type = %s", V2a4_WarmUpBattleRoundMO.s_state(self._state), dialogType))
				self:dump(__msg, 1)
				logError(table.concat(__msg, "\n"))
			end
		end
	end

	if self:isPreTalk() then
		if self:isFirstRound() then
			if self:isNeedPreface() then
				self._tmp_dialogCOList = self._gachaMO:getDialogCOList_prefaceAndPreTalk()

				V2a4_WarmUpController.instance:setIsShownPreface(true)
			else
				self._tmp_dialogCOList = self._gachaMO:getDialogCOList_preTalk()
			end
		else
			return self:_moveState()
		end
	elseif self:isAsk() then
		self._tmp_dialogCOList = self._gachaMO:getDialogCOList_yesorno()
	elseif self:isWaitAns() then
		local dialogType = V2a4_WarmUpEnum.DialogType.Wait
		local dialogCO = V2a4_WarmUpConfig.instance:getRandomDialogCO(dialogType)

		if isDebugBuild then
			__errlog(dialogCO ~= nil, dialogType)
		end

		self._tmp_dialogCOList = self._gachaMO:getDialogCOList(dialogCO.id)
	elseif self:isAnsed() then
		if self:userAnsIsYes() then
			if not V2a4_WarmUpEnum.DialogType.AnsTrue then
				local dialogType = V2a4_WarmUpEnum.DialogType.AnsFalse
				local dialogCO = V2a4_WarmUpConfig.instance:getRandomDialogCO(dialogType)

				if isDebugBuild then
					__errlog(dialogCO ~= nil, dialogType)
				end

				self._tmp_dialogCOList = self._gachaMO:getDialogCOList(dialogCO.id)
			end
		end
	elseif self:isReplyResult() then
		if self:isWin() then
			if self:isLastRound() then
				if self:isNeedPassTalkAllYes() then
					self._tmp_dialogCOList = self._gachaMO:getDialogCOList_passTalkAllYes() or self._gachaMO:getDialogCOList_passTalk()
				end
			else
				local dialogType = V2a4_WarmUpEnum.DialogType.ReplyAnsRight
				local dialogCO = V2a4_WarmUpConfig.instance:getRandomDialogCO(dialogType)

				if not dialogCO then
					self._tmp_dialogStep = 0
					self._tmp_dialogCOList = {}

					return true
				end

				self._tmp_dialogCOList = self._gachaMO:getDialogCOList(dialogCO.id)
			end
		else
			self._tmp_dialogCOList = self._gachaMO:getDialogCOList_failTalk()
		end
	end

	self._tmp_dialogStep = 1

	return true
end

function V2a4_WarmUpBattleRoundMO:moveStep()
	if not self._tmp_dialogCOList then
		if not self._tmp_dialogStep then
			local COIndex = 0
			local __errlog

			if isDebugBuild then
				local __msg = {}

				function __errlog(condition)
					if not condition then
						ti(__msg, sf("error step: %s", self._tmp_dialogStep))
						self:dump(__msg, 1)
						logError(table.concat(__msg, "\n"))
					end
				end
			end

			if COIndex < #self._tmp_dialogCOList then
				COIndex = COIndex + 1
				self._tmp_dialogStep = COIndex

				if isDebugBuild then
					__errlog(self._tmp_dialogCOList[COIndex] ~= nil)
				end

				return true, self._tmp_dialogCOList[COIndex]
			end

			local ok = self:_moveState()

			return ok, self._tmp_dialogCOList[1]
		end
	end
end

function V2a4_WarmUpBattleRoundMO:isLastStep()
	if not self._tmp_dialogCOList then
		if not self._tmp_dialogStep then
			local COIndex = 0

			return COIndex == #self._tmp_dialogCOList
		end
	end
end

function V2a4_WarmUpBattleRoundMO.s_state(state)
	for k, v in pairs(V2a4_WarmUpEnum.RoundState) do
		if v == state then
			return k
		end
	end

	return "[V2a4_WarmUpBattleRoundMO.s_state] error!!"
end

function V2a4_WarmUpBattleRoundMO:dump(refStrBuf, depth)
	depth = depth or 0

	local tab = string.rep("\t", depth)

	ti(refStrBuf, tab .. sf("index = %s", self._index))
	ti(refStrBuf, tab .. sf("wave = %s", self._waveMO:index()))
	ti(refStrBuf, tab .. sf("isFinished = %s", self._isFinished))
	ti(refStrBuf, tab .. sf("isWin = %s", self._isWin))
	ti(refStrBuf, tab .. sf("state = %s", V2a4_WarmUpBattleRoundMO.s_state(self._state)))
	ti(refStrBuf, tab .. sf("_step = %s", self._tmp_dialogStep or 0))

	local stepListStr = {}

	for _, CO in ipairs(self._tmp_dialogCOList or {}) do
		ti(stepListStr, CO.id)
	end

	ti(refStrBuf, tab .. sf("_stepList = %s", table.concat(stepListStr, ",")))
	ti(refStrBuf, tab .. "GachaRound = {")
	self._gachaMO:dump(refStrBuf, depth + 1)
	ti(refStrBuf, tab .. "}")
end

return V2a4_WarmUpBattleRoundMO
