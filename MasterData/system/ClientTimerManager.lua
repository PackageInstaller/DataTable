-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\ClientTimerManager.lua

local ClientTimerManager = {}
local self = ClientTimerManager

ClientTimerManager.TimerDict = {}
ClientTimerManager.FuncDict = {}

function ClientTimerManager.initAllTimer()
	self.stopAllTimer()

	self.clientTimers = {}

	for timeString, callbackList in pairs(ClientTimerManager.TimerDict) do
		self._startSingleTimer(timeString)
	end

	self.globalTimers = {}
end

function ClientTimerManager.stopAllTimer()
	if self.clientTimers then
		for k, timer in pairs(self.clientTimers) do
			timer:Stop()
		end
	end

	self.clientTimers = nil

	if self.globalTimers then
		for timerName, _ in pairs(self.globalTimers) do
			self.stopGlobalTimer(timerName)
		end
	end

	self.globalTimers = nil
end

function ClientTimerManager.addTimerFunc(timeString, funcString, func)
	if not ClientTimerManager.TimerDict[timeString] then
		ClientTimerManager.TimerDict[timeString] = {
			funcString
		}
	else
		local alreadyExist = false

		for i, funcName in ipairs(ClientTimerManager.TimerDict[timeString]) do
			if funcName == funcString then
				alreadyExist = true

				break
			end
		end

		if not alreadyExist then
			table.insert(ClientTimerManager.TimerDict[timeString], funcString)
		end
	end

	ClientTimerManager.FuncDict[funcString] = func

	if not self.clientTimers[timeString] then
		self._startSingleTimer(timeString)
	end
end

function ClientTimerManager.delTimerFunc(timeString, funcString)
	local funcList = ClientTimerManager.TimerDict[timeString]

	if funcList and #funcList > 0 then
		for i = #funcList, 1, -1 do
			local funcName = funcList[i]

			if funcName == funcString then
				table.remove(funcList, i)
			end
		end

		if #funcList == 0 and self.clientTimers[timeString] then
			self._stopSingleTimer(timeString)
		end
	end

	ClientTimerManager.FuncDict[funcString] = nil
end

function ClientTimerManager.startGlobalTimer(timerName, timeStamp, func)
	if self.globalTimers[timerName] then
		self.stopGlobalTimer(timerName)
	end

	local nextBeatLength = timeStamp + 5
	local timer = Timer.New(Slot(self._globalTimerBeat, timerName), nextBeatLength, 1, false)

	self.globalTimers[timerName] = {
		timer,
		func
	}

	timer:Start()
end

function ClientTimerManager.stopGlobalTimer(timerName)
	if self.globalTimers == nil then
		return
	end

	if self.globalTimers[timerName] then
		local timer = self.globalTimers[timerName][1]

		if timer then
			timer:Stop()
		end

		self.globalTimers[timerName] = nil
	end
end

function ClientTimerManager._timeStringToStamp(timeString)
	local timeSplitList = utils.splitString(timeString, ":")
	local hour = tonumber(timeSplitList[1])
	local minute = tonumber(timeSplitList[2])
	local second = tonumber(timeSplitList[3])
	local todayStamp = ClientUtils.getTodayTimeStamp(hour, minute, second)

	return todayStamp
end

local OneDaySeconds = 86400

function ClientTimerManager._calcNextBeat(targetTimeStamp)
	local nowTimeStamp = ClientUtils.getServerTime()

	if nowTimeStamp < targetTimeStamp then
		return targetTimeStamp - nowTimeStamp
	else
		return 86400 - (nowTimeStamp - targetTimeStamp)
	end
end

function ClientTimerManager._startSingleTimer(timeString)
	local targetTimeStamp = self._timeStringToStamp(timeString)
	local nextBeatLength = ClientTimerManager._calcNextBeat(targetTimeStamp) + 5
	local timer = Timer.New(Slot(self._timerBeat, timeString), nextBeatLength, 1, false)

	self.clientTimers[timeString] = timer

	timer:Start()
end

function ClientTimerManager._stopSingleTimer(timeString)
	local timer = self.clientTimers[timeString]

	if timer then
		timer:Stop()

		self.clientTimers[timeString] = nil
	end
end

function ClientTimerManager._timerBeat(timeString)
	local callbackList = ClientTimerManager.TimerDict[timeString]

	if callbackList then
		for i, funcString in ipairs(callbackList) do
			local func = ClientTimerManager.FuncDict[funcString]

			if func then
				func()
			end
		end
	end

	self._stopSingleTimer(timeString)
	self._startSingleTimer(timeString)
end

function ClientTimerManager._globalTimerBeat(timerName)
	if not self.globalTimers[timerName] then
		return
	end

	local func = self.globalTimers[timerName][2]

	if func then
		func()
	end
end

function ClientTimerManager.freeCastWeapon()
	HintManager.triggerEvent(UIConst.HINT_EVENT.FREE_WEAPON_CAST, true)
end

function ClientTimerManager.freeDrawSkill()
	HintManager.triggerEvent(UIConst.HINT_EVENT.FREE_SKILL_DRAW, true)
end

function ClientTimerManager.checkWantedSystem()
	local ca = GameContext.CurrentEntity

	if ca then
		local ui = UIManager.getUI("newWantedDlg", nil, false)

		if ui and ui:getVisible() then
			RPC.taskNewWantedLinkGet()
		end

		local wantedMonsterDlg = UIManager.getUI("wantedMonsterDlg", nil, false)

		if wantedMonsterDlg then
			wantedMonsterDlg:setVisible(false)
		end
	end
end

ClientTimerManager.SecondTickDict = {}

function ClientTimerManager.AddSecondTickUI(uiLabel, second, increase, preStr, afterStr, callBack, upBound, timeMode)
	local root = uiLabel.mRoot

	if not root then
		return
	end

	preStr = preStr or ""
	afterStr = afterStr or ""

	local result = self._updateSecondStr(uiLabel, second, preStr .. "%s" .. afterStr, callBack, increase, upBound, timeMode)

	if result == true then
		if not self.SecondTickDict[root.id] then
			self.SecondTickDict[root.id] = {}
		end

		if increase then
			self.SecondTickDict[root.id][uiLabel] = {
				Time.unscaledTime - second,
				increase,
				preStr .. "%s" .. afterStr,
				callBack,
				upBound,
				timeMode
			}
		else
			self.SecondTickDict[root.id][uiLabel] = {
				Time.unscaledTime + second,
				increase,
				preStr .. "%s" .. afterStr,
				callBack,
				upBound,
				timeMode
			}
		end

		if not self.SecondTickTimer:IsRunning() then
			self.SecondTickTimer:Start()
		end
	elseif result == false and callBack then
		callBack()
	end
end

function ClientTimerManager.AddSecondFormatTickUI(uiLabel, second, increase, format, callBack, upBound, timeMode)
	local root = uiLabel.mRoot

	if not root then
		return
	end

	format = format or "%s"

	local result = self._updateSecondStr(uiLabel, second, format, callBack, increase, upBound, timeMode)

	if result == true then
		if not self.SecondTickDict[root.id] then
			self.SecondTickDict[root.id] = {}
		end

		if increase then
			self.SecondTickDict[root.id][uiLabel] = {
				Time.unscaledTime - second,
				increase,
				format,
				callBack,
				upBound,
				timeMode
			}
		else
			self.SecondTickDict[root.id][uiLabel] = {
				Time.unscaledTime + second,
				increase,
				format,
				callBack,
				upBound,
				timeMode
			}
		end

		if not self.SecondTickTimer:IsRunning() then
			self.SecondTickTimer:Start()
		end
	elseif result == false and callBack then
		callBack()
	end
end

function ClientTimerManager.RemoveSecondTickUI(uiLabel)
	local root = uiLabel.mRoot

	if root and self.SecondTickDict[root.id] then
		self.SecondTickDict[root.id][uiLabel] = nil

		if next(self.SecondTickDict[root.id]) == nil then
			self.SecondTickDict[root.id] = nil
		end
	end
end

function ClientTimerManager._tickSecondQuest()
	if next(self.SecondTickDict) == nil then
		self.SecondTickTimer:Stop()
	else
		local nowTime = Time.unscaledTime

		for rootId, quests in pairs(self.SecondTickDict) do
			for uiLabel, timeInfo in pairs(quests) do
				local second

				if timeInfo[2] then
					second = math.floor(nowTime - timeInfo[1])
				else
					second = math.floor(timeInfo[1] - nowTime)
				end

				local result = self._updateSecondStr(uiLabel, second, timeInfo[3], timeInfo[4], timeInfo[2], timeInfo[5], timeInfo[6])

				if not result then
					self.RemoveSecondTickUI(uiLabel)

					if result == false and timeInfo[4] then
						timeInfo[4]()
					end
				end
			end
		end
	end
end

function ClientTimerManager._updateSecondStr(uiLabel, second, strFormat, callBack, increase, upBound, timeMode)
	if not uiLabel:isAlive() then
		return nil
	end

	if increase then
		if upBound and upBound < second then
			return false
		end
	elseif second < 0 then
		if callBack then
			callBack()
		end

		return false
	end

	if timeMode == 1 then
		uiLabel:setText(utils.calcShortTimeTxt(second, strFormat))
	elseif timeMode == 2 then
		uiLabel:setText(string.format(strFormat, math.floor(second)))
	else
		uiLabel:setText(string.format(strFormat, utils.calcTimeTxt(second)))
	end

	return true
end

function ClientTimerManager.RemoveSecondTickRoot(rootId)
	if self.SecondTickDict[rootId] then
		self.SecondTickDict[rootId] = nil
	end
end

ClientTimerManager.SecondTickTimer = Timer.New(ClientTimerManager._tickSecondQuest, 1, -1)

return ClientTimerManager
