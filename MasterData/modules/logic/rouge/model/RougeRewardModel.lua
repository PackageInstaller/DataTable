-- chunkname: @modules/logic/rouge/model/RougeRewardModel.lua

module("modules.logic.rouge.model.RougeRewardModel", package.seeall)

local RougeRewardModel = class("RougeRewardModel", BaseModel)

function RougeRewardModel:onInit()
	return
end

function RougeRewardModel:reInit()
	return
end

function RougeRewardModel:setReward(msg)
	self._season = self._season or RougeOutsideModel.instance:season()

	if msg.point then
		self.point = msg.point
	end

	if msg.bonus then
		if #msg.bonus.bonusStages > 0 then
			local bonusstages = msg.bonus.bonusStages

			self:_initStageInfo(bonusstages)
		end

		self._isNewStage = msg.bonus.isNewStage
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeRewardInfo)
end

function RougeRewardModel:updateReward(stageInfo)
	if stageInfo and next(stageInfo) then
		self:_updateStageInfo(stageInfo)
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeRewardInfo)
end

function RougeRewardModel:_initStageInfo(stageInfos)
	self._stageInfo = self._stageInfo or {}

	for _, stageInfo in ipairs(stageInfos) do
		self:_updateStageInfo(stageInfo)
	end
end

function RougeRewardModel:_updateStageInfo(stageInfo)
	self._stageInfo = self._stageInfo or {}
	self._stageInfo[stageInfo.stage] = self._stageInfo[stageInfo.stage] or {}
	self._stageInfo[stageInfo.stage] = stageInfo.bonusIds
end

function RougeRewardModel:checkCanGetBigReward(stage)
	local needNum = RougeRewardConfig.instance:getNeedUnlockNum(stage)
	local idCounter = self:getLastRewardCounter(stage)

	if idCounter < needNum then
		return false
	end

	return true
end

function RougeRewardModel:getRewardPoint()
	return self.point or 0
end

function RougeRewardModel:checkIsNewStage()
	return self._isNewStage
end

function RougeRewardModel:setNewStage(stage)
	self._isNewStage = stage
end

function RougeRewardModel:checkRewardCanGet(stage, id)
	if not self:isStageUnLock(stage) then
		return
	end

	local co = RougeRewardConfig.instance:getConfigById(self._season, id)

	if co.type == 3 then
		return true
	end

	local preId = co.preId

	if not self:checkRewardGot(stage, preId) then
		return false
	end

	return true
end

function RougeRewardModel:checkRewardGot(stage, bonusId)
	if not self._stageInfo or not next(self._stageInfo) then
		return
	end

	if not self:isStageUnLock(stage) then
		return false
	end

	local stageInfo = self._stageInfo[stage]

	if stageInfo then
		for _, id in ipairs(stageInfo) do
			if bonusId == id then
				return true
			end
		end
	end

	return false
end

function RougeRewardModel:getHadConsumeRewardPoint()
	local count = 0

	if not self._stageInfo or #self._stageInfo == 0 then
		return 0
	end

	for stage, info in ipairs(self._stageInfo) do
		local isGetBigReward = not not self:checkBigRewardGot(stage)

		if info and #info > 0 then
			count = count + #info
		end

		if isGetBigReward and count > 0 then
			count = count - 1
		end
	end

	return count
end

function RougeRewardModel:getHadGetRewardPoint()
	local hadConsume = self:getHadConsumeRewardPoint()
	local count = hadConsume
	local maxStage = self:getLastOpenStage()
	local maxRewardpoint = RougeRewardConfig.instance:getPointLimitByStage(self._season, maxStage)

	if self.point then
		local temp = hadConsume + self.point

		count = maxRewardpoint < temp and maxRewardpoint or temp
	end

	return count
end

function RougeRewardModel:isStageOpen(stage)
	if stage == 1 or stage == 2 then
		return true
	end

	self._season = self._season or RougeOutsideModel.instance:season()

	local config = RougeRewardConfig.instance:getStageRewardConfigById(self._season, stage)
	local serverTime = ServerTime.now()

	if not string.nilorempty(config.openTime) then
		local opentime = TimeUtil.stringToTimestamp(config.openTime) - ServerTime.clientToServerOffset()

		return opentime <= serverTime
	end

	return false
end

function RougeRewardModel:setNextUnlockStage()
	local coList = RougeRewardConfig.instance:getBigRewardToStage()

	for _, cos in ipairs(coList) do
		for _, co in ipairs(cos) do
			if not self:isStageOpen(co.stage) then
				self.nextstage = co.stage

				break
			end
		end
	end
end

function RougeRewardModel:isShowNextStageTag(stage)
	if stage == self.nextstage then
		return true
	end

	return false
end

function RougeRewardModel:isStageUnLock(stage)
	self._season = self._season or RougeOutsideModel.instance:season()

	if stage == 1 then
		return true
	end

	if not self:isStageOpen(stage) then
		return false
	end

	local config = RougeRewardConfig.instance:getStageRewardConfigById(self._season, stage)
	local preStage = config.preStage

	if self:isStageClear(preStage) then
		return true
	else
		return false
	end
end

function RougeRewardModel:isStageClear(stage)
	if not self._stageInfo or #self._stageInfo == 0 then
		return
	end

	local stageInfo = self._stageInfo[stage]

	if not stageInfo then
		return false
	end

	local stageNum = RougeRewardConfig.instance:getRewardStageDictNum(stage)

	if stageNum > #stageInfo then
		return false
	end

	return true
end

function RougeRewardModel:getLastOpenStage()
	local season = RougeOutsideModel.instance:season()
	local stagenum = RougeRewardConfig.instance:getStageRewardCount(season)
	local index = 1

	for i = 1, stagenum do
		if self:isStageOpen(i) then
			index = i
		else
			return index
		end
	end

	return index
end

function RougeRewardModel:getLastUnlockStage()
	local season = RougeOutsideModel.instance:season()
	local stagenum = RougeRewardConfig.instance:getStageRewardCount(season)
	local index = 1

	for i = 1, stagenum do
		if self:isStageUnLock(i) then
			index = i
		else
			return index
		end
	end

	return index
end

function RougeRewardModel:checkOpenStage(bigRewardId)
	local coList = RougeRewardConfig.instance:getBigRewardToStageConfigById(bigRewardId)
	local canOpen = false
	local stage

	if bigRewardId == 1 then
		for _, co in pairs(coList) do
			if self:isStageUnLock(co.stage) then
				canOpen = true
				stage = co.stage
			end
		end
	else
		for _, co in pairs(coList) do
			if self:isStageOpen(co.stage) then
				canOpen = true
				stage = co.stage
			end
		end
	end

	if canOpen then
		return stage
	end
end

function RougeRewardModel:getLastRewardCounter(stage)
	local idCounter = 0

	if not self._stageInfo or #self._stageInfo == 0 then
		return idCounter
	end

	local stageInfo = self._stageInfo[stage]

	if not stageInfo then
		return idCounter
	end

	local coList = RougeRewardConfig.instance:getConfigByStage(stage)

	for _, id in ipairs(stageInfo) do
		for _, co in ipairs(coList) do
			if co.id == id and co.type == 2 then
				idCounter = idCounter + 1
			end
		end
	end

	return idCounter
end

function RougeRewardModel:checShowBigRewardGot(bigRewardId)
	local coList = RougeRewardConfig.instance:getBigRewardToStageConfigById(bigRewardId)
	local checknum = 0

	for _, co in ipairs(coList) do
		if self:checkBigRewardGot(co.stage) then
			checknum = checknum + 1
		end
	end

	if #coList == checknum then
		return true
	end

	return false
end

function RougeRewardModel:checkBigRewardGot(stage)
	if not self._stageInfo or #self._stageInfo == 0 then
		return false
	end

	local stageinfo = self._stageInfo[stage]

	if not stageinfo then
		return false
	end

	for _, id in ipairs(stageinfo) do
		local co = RougeRewardConfig.instance:getConfigById(self._season, id)

		if co.type == 1 then
			return true
		end
	end

	return false
end

RougeRewardModel.instance = RougeRewardModel.New()

return RougeRewardModel
