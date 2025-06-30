-- chunkname: @IQIGame\\Module\\SignIn\\SignInModule.lua

SignInModule = {
	dateToCfgDataDic = {}
}

local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function SignInModule.ReloadData(signInfo)
	SignInModule.signInfo = signInfo
	SignInModule.hasOpenedSignUI = false

	for i, v in pairsCfg(CfgSignInTable) do
		if v.Date ~= nil and v.Data ~= "" then
			local checkTimeStamp = cfgDateTimeToTimeStamp(v.Date, PlayerModule.TimeZone)
			local dateTable = getDateTimeTable(checkTimeStamp)

			SignInModule.dateToCfgDataDic[dateTable.year .. "_" .. dateTable.month .. "_" .. dateTable.day] = v
		end
	end
end

function SignInModule.GetCfgSignData(year, month, day)
	local ret = SignInModule.dateToCfgDataDic[year .. "_" .. month .. "_" .. day]

	if ret then
		return ret
	else
		return CfgSignInTable[1]
	end
end

function SignInModule.GetSignProgressTaskData()
	local ret = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.SIGN_TASK)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.SIGN_TASK)

	table.sort(processing, function(element1, element2)
		local task1OK = element1.finNum >= element1.tgtNum
		local task2OK = element2.finNum >= element2.tgtNum

		if task1OK and task2OK or not task1OK and not task2OK then
			if element1:IsFailed() and element2:IsFailed() or not element1:IsFailed() and not element2:IsFailed() then
				return element1.cid < element2.cid
			end

			return element2.IsFail
		end

		return task1OK
	end)

	for i = 1, #processing do
		local taskData = processing[i]
		local uiTaskData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(ret, uiTaskData)
	end

	local filteredFinished = {}

	for i, v in ipairs(finished) do
		local cfgTaskData = CfgMainQuestTable[v]

		if cfgTaskData.FinishIsShow == 1 then
			filteredFinished[#filteredFinished + 1] = v
		end
	end

	for i = 1, #filteredFinished do
		local taskCid = filteredFinished[i]
		local cfgTaskData = CfgMainQuestTable[taskCid]
		local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
		local uiTaskData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

		table.insert(ret, uiTaskData)
	end

	return ret[1]
end

function SignInModule.GetMonthDay(dateStr)
	local dateAndTime = string.split(string.trim(dateStr), " ")
	local dates = string.split(dateAndTime[1], "/")

	return dates[1], dates[2]
end

function SignInModule.GetDayByYearMonth(_year, _month)
	local _curYear = tonumber(_year)
	local _curMonth = tonumber(_month)

	if not _curYear or _curYear <= 0 or not _curMonth or _curMonth <= 0 then
		return
	end

	local _curDate = {}

	_curDate.year = _curYear
	_curDate.month = _curMonth + 1
	_curDate.day = 0

	local _maxDay = os.date("%d", os.time(_curDate))

	return _maxDay
end

function SignInModule.GetServerTime()
	return math.floor(PlayerModule.GetServerTime()) - 14400
end

function SignInModule.CheckIsSign(day)
	return getBinBitValue(SignInModule.signInfo, day) == 1
end

function SignInModule.CheckRedPointOnSign()
	local serverTime = SignInModule.GetServerTime()
	local curDay = tonumber(getOnlyDateText(serverTime))
	local taskData = SignInModule.GetSignProgressTaskData()

	return UnlockFunctionModule.IsUnlock(Constant.UnlockType.SIGN) and not SignInModule.CheckIsSign(curDay) or taskData ~= nil and taskData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and taskData.CurrentNum >= taskData.TargetNum
end

function SignInModule.CheckNeedOpenSignUI()
	return not GuideModule.HasGuide() and PlayerModule.PlayerInfo.currDialog == 0 and not SignInModule.hasOpenedSignUI and SignInModule.CheckRedPointOnSign()
end

function SignInModule.ReqSign()
	net_active.sign()
end

function SignInModule.OnReqSignResult(signInfo, rewards)
	SignInModule.signInfo = signInfo

	EventDispatcher.Dispatch(EventID.UpdateSignInEvent)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
end

function SignInModule.NotifySign(signInfo)
	SignInModule.signInfo = signInfo

	EventDispatcher.Dispatch(EventID.UpdateSignInEvent)
end
