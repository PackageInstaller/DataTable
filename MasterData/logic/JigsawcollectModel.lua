-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jigsawcollect/model/JigsawcollectModel.lua

module("logic.extensions.jigsawcollect.view.JigsawcollectModel", package.seeall)

local JigsawcollectModel = class("JigsawcollectModel", BaseModel)

function JigsawcollectModel:ctor()
	return
end

function JigsawcollectModel:onInit()
	self:onReset()
end

function JigsawcollectModel:onReset()
	self._actId = 0
	self._actDays = 0
	self._collectInfo = {}
	self._taskInfos = {}
	self._unlockInfos = {}
	self._needUnlockData = nil
end

function JigsawcollectModel:setActInfo(msg)
	self._actId = msg.actId
	self._actDays = msg.days

	self:_setCollectInfo(msg.collectInfo)
	self:_setTaskInfos(msg.taskInfo)
end

function JigsawcollectModel:getActId()
	return self._actId
end

function JigsawcollectModel:getActDays()
	if self._actId > 0 then
		local cfg = JigsawcollectConfig.instance:getJigsawCfg(self._actId)
		local planCfgs = JigsawcollectConfig.instance:getTaskPlanCfgs(cfg.taskPlan)

		if not planCfgs[self._actDays] then
			self._actDays = #planCfgs
		end
	end

	return self._actDays
end

function JigsawcollectModel:_setCollectInfo(info)
	self._collectInfo = info
end

function JigsawcollectModel:_addNewPiece(pieceId)
	local isHas = false

	for i, v in ipairs(self._collectInfo.collectedPieces) do
		if v.collectedPiece == pieceId then
			isHas = true

			return
		end
	end

	if isHas == false then
		local data = {
			isUnlock = false,
			collectedPiece = pieceId
		}

		table.insert(self._collectInfo.collectedPieces, data)
	end
end

function JigsawcollectModel:getCollectInfos()
	return self._collectInfo
end

function JigsawcollectModel:_setTaskInfos(infos)
	self._taskInfos = infos
end

function JigsawcollectModel:getTaskInfos()
	return self._taskInfos
end

function JigsawcollectModel:getUnlockInfos()
	return self._unlockInfos
end

function JigsawcollectModel:getTaskPrizeRes(msg)
	printInfo("领取任务奖励 actId:", msg.actId, self:getActId(), msg.taskId)

	if msg.actId == self:getActId() then
		for i, v in ipairs(self._taskInfos) do
			if v.taskId == msg.taskId then
				printInfo("移除任务 taskId：", v.taskId)
				table.remove(self._taskInfos, i)

				break
			end
		end

		self:_addNewPiece(msg.newPiece)
	end
end

function JigsawcollectModel:getTotalChipNum()
	return #self._collectInfo.collectedPieces
end

function JigsawcollectModel:getCurrActNeedChipNum()
	local actId = self:getActId()
	local cfg = JigsawcollectConfig.instance:getJigsawCfg(actId)

	if not cfg then
		return 0
	end

	local planCfgs = JigsawcollectConfig.instance:getPiecePlanCfgs(cfg.piecePlan)

	return #planCfgs
end

function JigsawcollectModel:gainJigsawCollectPrizeRes(msg)
	if msg.actId == self:getActId() then
		self._collectInfo.collectPrizeGainBits[msg.progressId] = true
	end
end

function JigsawcollectModel:unlockJigsawPieceRes(msg)
	if self._needUnlockData and self._needUnlockData.actId == self:getActId() then
		for i, v in ipairs(self._collectInfo.collectedPieces) do
			if v.collectedPiece == self._needUnlockData.pieceId then
				v.isUnlock = true

				break
			end
		end

		self._needUnlockData = nil
	end
end

function JigsawcollectModel:setNeedUnlockData(actId, pieceId)
	self._needUnlockData = {
		actId = actId,
		pieceId = pieceId
	}
end

function JigsawcollectModel:checkCollectRewardDot(actId)
	local dot = false

	if actId > 0 and actId == self:getActId() then
		local cfg = JigsawcollectConfig.instance:getJigsawCfg(actId)
		local planCfgs = JigsawcollectConfig.instance:getCollectPrizePlanCfgs(cfg.collectPrizePlan)

		for i, v in ipairs(planCfgs) do
			dot = self:checkCollectprogressRewardDot(actId, v.progressId)

			if dot then
				break
			end
		end
	end

	return dot
end

function JigsawcollectModel:checkCollectprogressRewardDot(actId, progressId)
	if actId > 0 then
		local isget = self:hasGetCollectReward(actId, progressId)

		if not isget then
			local totalNum = self:getTotalChipNum()
			local cfg = JigsawcollectConfig.instance:getJigsawCfg(actId)
			local planCfgs = JigsawcollectConfig.instance:getCollectPrizePlanCfgs(cfg.collectPrizePlan)
			local pcfg = planCfgs[progressId]

			return totalNum >= pcfg.pieceReq
		end
	end
end

function JigsawcollectModel:hasGetCollectReward(actId, progressId)
	local aid = self:getActId()

	if aid ~= actId then
		return false
	end

	return self._collectInfo.collectPrizeGainBits[progressId]
end

function JigsawcollectModel:checkTaskRewardDot(actId)
	local dot = false

	if actId > 0 and actId == self:getActId() then
		local cfg = JigsawcollectConfig.instance:getJigsawCfg(actId)
		local days = self:getActDays()
		local planCfgs = JigsawcollectConfig.instance:getTaskPlanCfgs(cfg.taskPlan)

		if planCfgs[days] then
			for i, v in ipairs(planCfgs[days]) do
				dot = self:checkTaskProgressRewardDot(actId, v.taskId)

				if dot then
					break
				end
			end
		end
	end

	return dot
end

function JigsawcollectModel:checkTaskProgressRewardDot(actId, taskId)
	if actId > 0 then
		local currProgressReq = 0

		for i, v in ipairs(self._taskInfos) do
			if v.taskId == taskId then
				currProgressReq = v.taskProgress

				break
			end
		end

		local cfg = JigsawcollectConfig.instance:getJigsawCfg(actId)
		local days = self:getActDays()
		local planCfgs = JigsawcollectConfig.instance:getTaskPlanCfgs(cfg.taskPlan)

		return ((planCfgs[days] and planCfgs[days][taskId] or nil) and planCfgs[days][taskId].progressReq) <= currProgressReq
	end
end

function JigsawcollectModel:checkPieceEnough(actId)
	local actCfg = JigsawcollectConfig.instance:getJigsawCfg(actId)
	local planCfgs = JigsawcollectConfig.instance:getPiecePlanCfgs(actCfg.piecePlan)

	return self:getTotalChipNum() >= #planCfgs
end

JigsawcollectModel.instance = JigsawcollectModel.New()

return JigsawcollectModel
