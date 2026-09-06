-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/model/MirrorTrialModel.lua

module("logic.extensions.mirrortrial.model.MirrorTrialModel", package.seeall)

local MirrorTrialModel = class("MirrorTrialModel", BaseModel)

function MirrorTrialModel:ctor()
	return
end

function MirrorTrialModel:onInit()
	self:onReset()
end

function MirrorTrialModel:onReset()
	self._curStage = 0
	self._isPay = false
	self._freeProcess = 0
	self._payProcess = 0
	self._curBuyScore = 0
	self._dailyBuyTimes = 0
end

function MirrorTrialModel:getCurStage()
	return self._curStage
end

function MirrorTrialModel:getCurChapter()
	local curActId = self:getCurActId()

	if curActId > 0 then
		local stageCfg = MirrorTrialConfig.instance:getStageCfgsById(curActId, self._curStage + 1)

		return stageCfg and stageCfg.chapterId
	end

	return 0
end

function MirrorTrialModel:getCurChapterRes()
	local res = {}
	local curChapter = self:getCurChapter()
	local curActId = self:getCurActId()

	if curChapter > 0 and curActId > 0 then
		local curChapterCfg = MirrorTrialConfig.instance:getChapterCfgsById(curActId, curChapter)
		local curChapterStageCfgs = MirrorTrialConfig.instance:getStageCfgsByChapterId(curActId, curChapter)

		table.insert(res, string.format("ui/bigbg/copychapter/chapterbg/%s.png", curChapterCfg.nearBg))
		table.insert(res, string.format("ui/bigbg/copychapter/chapterbg/%s.png", curChapterCfg.middleBg))
		table.insert(res, string.format("ui/bigbg/copychapter/chapterbg/%s.png", curChapterCfg.farBg))

		local resMap = self:_addRes(curChapterStageCfgs)

		if not resMap then
			return res
		end

		for k, v in pairs(resMap) do
			table.insert(res, k)
		end
	end

	return res
end

function MirrorTrialModel:_addRes(cfgs)
	if cfgs and #cfgs > 0 then
		local num = 4
		local res = {}
		local temCfgs = {}

		if num >= #cfgs then
			for k, v in pairs(#cfgs) do
				table.insert(temCfgs, v)
			end
		else
			table.insert(temCfgs, cfgs[self._curStage + 1])

			local sign = 1

			while num > #temCfgs do
				local preStage = self._curStage + 1 - sign
				local nextStage = self._curStage + 1 + sign

				sign = sign + 1

				if cfgs[preStage] then
					table.insert(temCfgs, cfgs[preStage])

					if num <= #temCfgs then
						break
					end
				end

				if cfgs[nextStage] then
					table.insert(temCfgs, cfgs[nextStage])

					if num <= #temCfgs then
						break
					end
				end
			end
		end

		for i = 1, #temCfgs do
			local raceId = temCfgs[i].faceId

			if raceId ~= 0 then
				local petCo = CharacterConfig.instance:getPetCo(raceId)

				if petCo then
					local idx, spineUrl = CharacterConfig.instance:GetCharacterResIdx(checknumber(petCo.faceIds), false)

					res[spineUrl] = true
				end
			end
		end

		return res
	end
end

function MirrorTrialModel:getIsPay()
	return self._isPay
end

function MirrorTrialModel:getCurProcess()
	return self._freeProcess, self._payProcess
end

function MirrorTrialModel:getCurTotalScore()
	local totalScore = 0
	local actId = self:getCurActId()

	if actId > 0 then
		local cfgs = MirrorTrialConfig.instance:getStageCfgsById(actId)

		for i, v in ipairs(cfgs) do
			if v.stageId > self._curStage then
				return self._curBuyScore + totalScore
			end

			totalScore = totalScore + v.score
		end
	end

	return self._curBuyScore + totalScore
end

function MirrorTrialModel:getIsAbleToBuyScoreParms()
	local curActCfg = self:getCurActCfg()
	local isAbleToBuy = false
	local leftTimes = 0
	local isTimeAble = false
	local isMax = false

	if curActCfg then
		local curBaseCfg = MirrorTrialConfig.instance:getActBaseCfgById(curActCfg.activityId)

		leftTimes = curBaseCfg.dailyBuyTimeLimit - self._dailyBuyTimes
		isTimeAble = ServerTime.now() > GameUtil.string2time(curActCfg.startTime) + curBaseCfg.allowBuyRelativeDays * 86400
		isMax = self:getCurTotalScore() >= self:getCurMaxScore()
		isAbleToBuy = leftTimes > 0 and isTimeAble and not isMax
	end

	return isAbleToBuy, leftTimes, isTimeAble, isMax
end

function MirrorTrialModel:getCurMaxScore()
	local maxScore = 1
	local curActId = self:getCurActId()

	if curActId > 0 then
		local curPrizePlanCfgs = MirrorTrialConfig.instance:getPrizePlanCfgsById(curActId)

		if curPrizePlanCfgs then
			maxScore = curPrizePlanCfgs[#curPrizePlanCfgs].score
		end
	end

	return maxScore
end

function MirrorTrialModel:getCurActCfg()
	return ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.MirrorTrial)
end

function MirrorTrialModel:getCurActId()
	local cfg = self:getCurActCfg()

	return checkint(cfg and cfg.activityId)
end

function MirrorTrialModel:updateGetInfo(msg)
	self._curStage = msg.curPassedStage
	self._isPay = msg.bought
	self._freeProcess = msg.prizeProcess
	self._payProcess = msg.rechargePrizeProcess
	self._curBuyScore = msg.buyScore
	self._dailyBuyTimes = msg.dailyBuyTimes
end

function MirrorTrialModel:updateStartFight(msg)
	return
end

function MirrorTrialModel:updateGainPrize(msg)
	self._freeProcess = msg.prizeProcess
	self._payProcess = msg.rechargePrizeProcess
end

function MirrorTrialModel:updateBuyScore(msg)
	self._curBuyScore = msg.curBuyScore
	self._dailyBuyTimes = msg.curBuyTimes
end

function MirrorTrialModel:updateNotifyFight(msg)
	if msg.isWin then
		self._curStage = msg.curPassedStage
	end
end

function MirrorTrialModel:updatePaySuc(msg)
	self._isPay = true
end

function MirrorTrialModel:updateDaily()
	self._dailyBuyTimes = 0
end

MirrorTrialModel.instance = MirrorTrialModel.New()

return MirrorTrialModel
