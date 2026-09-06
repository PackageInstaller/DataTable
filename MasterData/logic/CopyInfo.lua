-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/model/CopyInfo.lua

module("logic.extensions.plotcopy.model.CopyInfo", package.seeall)

local CopyInfo = class("CopyInfo")

function CopyInfo:ctor()
	self:onReset()
end

function CopyInfo:onReset()
	self._chapterProgressRes = {
		typeId = 0,
		progressList = {}
	}
	self._notifyAfterChallenge = {
		isWin = false,
		curStageProgress = {}
	}
	self._chapterId = 0
	self._stageId = 0
	self._chapterProgressMap = {}
end

function CopyInfo:setChapterAndStageInBattle(chapterId, stageId)
	self._chapterId = chapterId
	self._stageId = stageId
end

function CopyInfo:getChapterAndStageInBattle()
	return self._chapterId, self._stageId
end

function CopyInfo:onGetChapterProgress(msg)
	self._chapterProgressRes.typeId = msg.typeId
	self._chapterProgressRes.progressList = msg.progressList

	for i, v in ipairs(self._chapterProgressRes.progressList) do
		self._chapterProgressMap[v.chapterId] = v
	end
end

function CopyInfo:getChapterType()
	return self._chapterProgressRes.typeId
end

function CopyInfo:onNotifyAfterChallenge(msg)
	self._notifyAfterChallenge.isWin = msg.isWin
	self._notifyAfterChallenge.changeSetId = msg.changeSetId
	self._notifyAfterChallenge.curStageProgress = msg.curStageProgress
	self._notifyAfterChallenge.perfectPass = msg:HasField("perfectPass") and msg.perfectPass or nil

	self:_updateChapterProgress(msg)
end

function CopyInfo:onCopyZdlSecKillRes(msg)
	printInfo("test 秒杀信息更新")
	self:_updateChapterProgressBySecKillParam(msg)
end

function CopyInfo:_updateChapterProgressBySecKillParam(msg)
	local changeList = msg.curStageProgressList

	for i, changeInfo in ipairs(changeList) do
		local isFind = false

		for j, curInfo in ipairs(self._chapterProgressRes.progressList) do
			if changeInfo.chapterId == curInfo.chapterId then
				isFind = true
				curInfo.curStageId = changeInfo.curStageId
				curInfo.hasGainPrize = changeInfo.hasGainPrize
				curInfo.stagePerfectPassBit = changeInfo.stagePerfectPassBit

				break
			end
		end

		if not isFind then
			table.insert(self._chapterProgressRes.progressList, changeInfo)
		end
	end

	for i, v in ipairs(self._chapterProgressRes.progressList) do
		self._chapterProgressMap[v.chapterId] = v
	end

	GlobalDispatcher:dispatch(GlobalNotify.CopyInfoChange)
end

function CopyInfo:onGainChapterPrizeRes(msg)
	local progressList = self._chapterProgressRes.progressList

	for i, v in ipairs(progressList) do
		if v.chapterId == msg.chapterId then
			v.hasGainPrize = GameUtil.setBitByDigit(v.hasGainPrize, msg.index, true)

			return
		end
	end
end

function CopyInfo:onGainPreciousBoxPrizeRes(updateProgressList)
	for i, v in ipairs(updateProgressList) do
		local chapterProgress = self:_getChapterProgress(v.chapterId)

		if chapterProgress then
			chapterProgress.curStageId = v.curStageId
			chapterProgress.hasGainPrize = v.hasGainPrize
			chapterProgress.stagePerfectPassBit = v.stagePerfectPassBit
		end
	end
end

function CopyInfo:getLockedChapterReason(chapterId)
	local chapterCfg = CopyConfig.instance:getChapter(chapterId)

	if not chapterCfg then
		return 0
	end

	local preChapter = chapterCfg.preChapter
	local taskLimit = chapterCfg.taskLimit
	local needPlayerLevel = chapterCfg.needPlayerLevel
	local maxZdlLimit = chapterCfg.maxZdlLimit

	if preChapter and preChapter > 0 then
		local isPass = PlotCopyModel.instance:isChapterPassed(preChapter)

		if not isPass then
			return 1
		end
	end

	if not string.nilorempty(taskLimit) then
		local taskIds = string.split(taskLimit, "-")

		if taskIds and taskIds[1] and taskIds[2] then
			local taskId = checknumber(taskIds[1])
			local stepId = checknumber(taskIds[2])
			local isFinishTask = TaskFacade.instance:isTaskStepFinished(taskId, stepId)

			if not isFinishTask then
				return 2
			end
		end
	end

	local curPlayerLevel = MofangModel.instance:getCurLv()

	if curPlayerLevel < needPlayerLevel then
		return 3
	end

	local curPower = RoleModel.instance:getMaxPower()

	if curPower < maxZdlLimit then
		return 4
	end

	return 0
end

function CopyInfo:getUnlockState(chapterId, stageId)
	local cfg = CopyConfig.instance:getStageById(chapterId, stageId)

	if not cfg then
		return 0
	end

	if not string.nilorempty(cfg.preStage) then
		local params = string.split(cfg.preStage, "-")

		if params[1] and params[2] then
			local preChapterId = checknumber(params[1])
			local preStageId = checknumber(params[2])
			local isStagePass = self:isStagePassed(preChapterId, preStageId)

			if not isStagePass then
				return 1
			end
		end
	end

	if not string.nilorempty(cfg.taskLimit) then
		local taskIds = string.split(cfg.taskLimit, "-")

		if taskIds and taskIds[1] and taskIds[2] then
			local taskId = checknumber(taskIds[1])
			local stepId = checknumber(taskIds[2])
			local isFinishTask = TaskFacade.instance:isTaskStepFinished(taskId, stepId)

			if not isFinishTask then
				return 2
			end
		end
	end

	local needPlayerLevel = cfg.needPlayerLevel
	local curLv = MofangModel.instance:getCurLv()

	if curLv < needPlayerLevel then
		return 3
	end

	local maxZdlLimit = cfg.maxZdlLimit
	local curPower = RoleModel.instance:getMaxPower()

	if curPower < maxZdlLimit then
		return 4
	end

	return 0
end

function CopyInfo:isPerfectPass()
	return self._notifyAfterChallenge and self._notifyAfterChallenge.perfectPass
end

function CopyInfo:isStagePerfectPass(chapterId, stageId)
	local chapterProgresses = self._chapterProgressRes.progressList

	for i, v in ipairs(chapterProgresses) do
		if v.chapterId == chapterId then
			return (GameUtil.isBitOpenByDigit(v.stagePerfectPassBit, stageId))
		end
	end

	return false
end

function CopyInfo:isChapterUnlock(chapterId)
	local chapterCfg = CopyConfig.instance:getChapter(chapterId)

	if not chapterCfg then
		return false
	end

	local preChapter = chapterCfg.preChapter
	local taskLimit = chapterCfg.taskLimit
	local needPlayerLevel = chapterCfg.needPlayerLevel
	local maxZdlLimit = chapterCfg.maxZdlLimit

	if preChapter and preChapter > 0 then
		local isPass = PlotCopyModel.instance:isChapterPassed(preChapter)

		if not isPass then
			return false
		end
	end

	if not string.nilorempty(taskLimit) then
		local taskIds = string.split(taskLimit, "-")

		if taskIds and taskIds[1] and taskIds[2] then
			local taskId = checknumber(taskIds[1])
			local stepId = checknumber(taskIds[2])
			local isFinishTask = TaskFacade.instance:isTaskStepFinished(taskId, stepId)

			if not isFinishTask then
				return false
			end
		end
	end

	local curPlayerLevel = MofangModel.instance:getCurLv()

	if curPlayerLevel < needPlayerLevel then
		return false
	end

	local curPower = RoleModel.instance:getMaxPower()

	if curPower < maxZdlLimit then
		return false
	end

	return true
end

function CopyInfo:getCostLimitCount(chapterId)
	local curCount = 0
	local totalCount = 0

	return curCount, totalCount
end

function CopyInfo:isHaveChapterRewardsGain()
	local chapterProgresses = self._chapterProgressRes.progressList

	for k, v in ipairs(chapterProgresses) do
		local cfgChapter = CopyConfig.instance:getChapter(v.chapterId)

		if cfgChapter and cfgChapter.progressReward > 0 then
			local cfgStrategys = CopyConfig.instance:getRewardStrategys(cfgChapter.progressReward)

			for k1, v1 in ipairs(cfgStrategys) do
				if self:isCanGetChapterReward(v.chapterId, k1 - 1) then
					return true
				end
			end
		end
	end

	return false
end

function CopyInfo:isChapterRewardCanGet(chapterId)
	local chapterProgresses = self._chapterProgressRes.progressList

	for k, v in ipairs(chapterProgresses) do
		if v.chapterId == chapterId then
			local cfgChapter = CopyConfig.instance:getChapter(v.chapterId)

			if cfgChapter and cfgChapter.progressReward > 0 then
				local cfgStrategys = CopyConfig.instance:getRewardStrategys(cfgChapter.progressReward)

				for k1, v1 in ipairs(cfgStrategys) do
					if self:isCanGetChapterReward(v.chapterId, k1 - 1) then
						return true
					end
				end
			end
		end
	end

	return false
end

function CopyInfo:isChapterRewardGain(chapterId, index)
	local chapterProgress = self:_getChapterProgress(chapterId)

	if chapterProgress == nil then
		return false
	else
		return GameUtil.isBitOpenByDigit(chapterProgress.hasGainPrize, index)
	end
end

function CopyInfo:isCanGetChapterReward(chapterId, index)
	local isGetChapterReward = self:isChapterRewardGain(chapterId, index)

	if isGetChapterReward then
		return false
	else
		local num = self:_getRewardNeedPerfectStageNum(chapterId, index + 1)

		return (self:_isChapterFinishSomeStage(chapterId, num))
	end
end

function CopyInfo:_getRewardNeedPerfectStageNum(chapterId, index)
	local cfgChapter = CopyConfig.instance:getChapter(chapterId)

	if not cfgChapter or cfgChapter.progressReward == 0 then
		return 0
	end

	local cfgStrategys = CopyConfig.instance:getRewardStrategys(cfgChapter.progressReward)

	for k, v in ipairs(cfgStrategys) do
		if k == index then
			return v.condition
		end
	end

	return 0
end

function CopyInfo:isChapterPassed(chapterId)
	return (self:_isChapterFinished(chapterId))
end

function CopyInfo:getChapterPerfectPassedList(chapterId)
	local result = {}
	local chapterProgress = self:_getChapterProgress(chapterId)

	if chapterProgress ~= nil then
		local stagePerfectPassBit = chapterProgress.stagePerfectPassBit
		local cfgs = CopyConfig.instance:getStages(chapterId)

		for i = 1, #cfgs do
			local isPerfect = GameUtil.isBitOpenByDigit(stagePerfectPassBit, i)

			table.insert(result, isPerfect)
		end
	end

	return result
end

function CopyInfo:isStagePassed(chapterId, stageId)
	local v = self._chapterProgressMap[chapterId]

	if v then
		if stageId < v.curStageId then
			return true
		elseif stageId == v.curStageId then
			local cfg = CopyConfig.instance:getStageById(chapterId, stageId)

			if not cfg then
				return false
			end

			return true
		end
	end

	return false
end

function CopyInfo:_updateChapterProgress(msg)
	self:_updateChapterProgressByParam(msg.isWin, msg.curStageProgress)
end

function CopyInfo:_updateChapterProgressByParam(isWin, curStageProgress)
	if isWin then
		local progress = self._chapterProgressRes.progressList

		for k, v in ipairs(progress) do
			if curStageProgress.chapterId == v.chapterId then
				if curStageProgress.curStageId > v.curStageId then
					v.curStageId = curStageProgress.curStageId
					v.hasGainPrize = curStageProgress.hasGainPrize
					v.stagePerfectPassBit = curStageProgress.stagePerfectPassBit

					printInfo("plot 关卡记录比旧记录新，更新记录old:new = ", v.chapterId, v.curStageId, v.hasGainPrize, v.stagePerfectPassBit, "：", curStageProgress.chapterId, curStageProgress.curStageId, curStageProgress.hasGainPrize, curStageProgress.stagePerfectPassBit)
					GlobalDispatcher:dispatch(GlobalNotify.CopyInfoChange)

					return
				end

				if curStageProgress.curStageId <= v.curStageId then
					v.hasGainPrize = curStageProgress.hasGainPrize
					v.stagePerfectPassBit = curStageProgress.stagePerfectPassBit

					printInfo("plot 当前操作的关卡小于等于最大记录关卡，更新记录old:new = ", v.chapterId, v.curStageId, v.hasGainPrize, v.stagePerfectPassBit, "：", curStageProgress.chapterId, curStageProgress.curStageId, curStageProgress.hasGainPrize, curStageProgress.stagePerfectPassBit)
					GlobalDispatcher:dispatch(GlobalNotify.CopyInfoChange)

					return
				end
			end
		end

		local newProgress = {}

		newProgress.chapterId = curStageProgress.chapterId
		newProgress.curStageId = curStageProgress.curStageId
		newProgress.hasGainPrize = curStageProgress.hasGainPrize
		newProgress.stagePerfectPassBit = curStageProgress.stagePerfectPassBit

		table.insert(self._chapterProgressRes.progressList, newProgress)

		for i, v in ipairs(self._chapterProgressRes.progressList) do
			self._chapterProgressMap[v.chapterId] = v
		end

		printInfo("plot 没有旧记录，以新记录的形式存储，更新记录old:new = nil", "：", curStageProgress.chapterId, curStageProgress.curStageId, curStageProgress.hasGainPrize, curStageProgress.stagePerfectPassBit)
		GlobalDispatcher:dispatch(GlobalNotify.CopyInfoChange)

		return
	end
end

function CopyInfo:_getChapterProgress(chapterId)
	local chapterProgresses = self._chapterProgressRes.progressList

	for k, v in pairs(chapterProgresses) do
		if v.chapterId == chapterId then
			return v
		end
	end

	return nil
end

function CopyInfo:curOpenStageNum(chapterId)
	if not self:isChapterUnlock(chapterId) then
		return 0
	end

	local curProgress = self:_getChapterProgress(chapterId)

	if curProgress then
		local stages = CopyConfig.instance:getStages(curProgress.chapterId)

		return curProgress.curStageId == #stages and #stages or curProgress.curStageId + 1
	else
		return 1
	end
end

function CopyInfo:_isChapterFinished(chapterId)
	local curFinishCount, chapterTotalCount = self:getStageFinishCount(chapterId)

	if curFinishCount ~= 0 and curFinishCount == chapterTotalCount then
		return true
	else
		return false
	end
end

function CopyInfo:_isChapterFinishSomeStage(chapterId, num)
	local curPerfectFinishCount = self:getPerfectFinishCount(chapterId)

	return num <= curPerfectFinishCount
end

function CopyInfo:getStageFinishCount(chapterId)
	local chapterProgress = self:_getChapterProgress(chapterId)
	local stageCfgs = CopyConfig.instance:getStages(chapterId)
	local curFinishCount = 0
	local chapterTotalCount = #stageCfgs

	if chapterProgress == nil then
		return curFinishCount, chapterTotalCount
	end

	if chapterProgress.curStageId == #stageCfgs then
		curFinishCount = chapterTotalCount

		return chapterTotalCount, chapterTotalCount
	else
		for i = 1, chapterTotalCount do
			if stageCfgs[i].stageId == chapterProgress.curStageId then
				curFinishCount = chapterProgress.curStageId

				return chapterProgress.curStageId, chapterTotalCount
			end
		end

		return curFinishCount, chapterTotalCount
	end
end

function CopyInfo:getPerfectFinishCount(chapterId)
	local chapterProgress = self:_getChapterProgress(chapterId)
	local curFinishCount, chapterTotalCount = self:getStageFinishCount(chapterId)
	local cfgs = CopyConfig.instance:getStages(chapterId)
	local curPerfectCount = 0
	local totalPerfectCount = 0

	for i, v in ipairs(cfgs) do
		if chapterProgress and GameUtil.isBitOpenByDigit(chapterProgress.stagePerfectPassBit, v.stageId) and curFinishCount >= v.stageId and not v.purePlot then
			curPerfectCount = curPerfectCount + 1
		end

		if chapterTotalCount >= v.stageId and not v.purePlot then
			totalPerfectCount = totalPerfectCount + 1
		end
	end

	return curPerfectCount, totalPerfectCount
end

function CopyInfo:getStageFinishCountExceptPurePlot(chapterId)
	local chapterProgress = self:_getChapterProgress(chapterId)
	local stageCfgs = CopyConfig.instance:getStages(chapterId)
	local curFinishCount = 0
	local chapterTotalCount = #stageCfgs
	local purePlotCount = 0

	for i, v in ipairs(stageCfgs) do
		if v.purePlot then
			purePlotCount = purePlotCount + 1
		end
	end

	local chapterTotalCount = chapterTotalCount - purePlotCount

	if chapterProgress == nil then
		return curFinishCount, chapterTotalCount
	end

	if chapterProgress.curStageId == #stageCfgs then
		curFinishCount = chapterTotalCount

		return chapterTotalCount, chapterTotalCount
	else
		local finishStageId = chapterProgress.curStageId
		local finishPureCount = 0

		for i, v in ipairs(stageCfgs) do
			if finishStageId >= v.stageId and v.purePlot then
				finishPureCount = finishPureCount + 1
			end
		end

		curFinishCount = finishStageId - finishPureCount

		return finishStageId - finishPureCount, chapterTotalCount
	end
end

function CopyInfo:getCurMaxProgress()
	local chapterProgresses = self._chapterProgressRes.progressList

	if not chapterProgresses or #chapterProgresses == 0 then
		local cfgStages = CopyConfig.instance:getAllPlotChallengeState()

		return cfgStages[1].chapterId, cfgStages[1].stageId
	else
		local maxProgress = chapterProgresses[#chapterProgresses]

		return maxProgress.chapterId, maxProgress.curStageId
	end
end

return CopyInfo
