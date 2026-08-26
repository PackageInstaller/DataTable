-- chunkname: @modules/logic/versionactivity2_8/act197/model/Activity197Model.lua

module("modules.logic.versionactivity2_8.act197.model.Activity197Model", package.seeall)

local Activity197Model = class("Activity197Model", BaseModel)

function Activity197Model:onInit()
	self._poolDict = {}
	self._poolList = {}
	self._gainIdsDict = {}
	self._poolGetBigList = {}
	self._currentPoolId = 1
	self._rummageTimes = 0
	self._exploreTimes = 0
	self._showBubbleVx = false
	self._currentBubbleCount = nil
end

function Activity197Model:reInit()
	self:onInit()
end

function Activity197Model:setActInfo(msg)
	self._actId = msg.activityId

	local infos = msg.hasGain

	if infos and #infos > 0 then
		for index, info in ipairs(infos) do
			table.insert(self._poolList, info.poolId)

			self._gainIdsDict[info.poolId] = info.gainIds

			self:setGetBigRewardList(info)
		end
	end

	self:_initCurrency()
end

function Activity197Model:setGetBigRewardList(info)
	local gainIds = info.gainIds

	for key, gainId in ipairs(gainIds) do
		if Activity197Enum.BigGainId == gainId then
			self._poolGetBigList[info.poolId] = true
			self._currentPoolId = gainId
		end
	end
end

function Activity197Model:checkPoolGetBigReward(poolId)
	if #self._poolGetBigList > 0 and self._poolGetBigList[poolId] then
		return true
	end

	return false
end

function Activity197Model:updatePool(poolId, gainId)
	local pool = self._gainIdsDict[poolId]

	if not pool then
		pool = {}
		self._gainIdsDict[poolId] = pool
	end

	table.insert(pool, gainId)

	if Activity197Enum.BigGainId == gainId then
		self._poolGetBigList[poolId] = true
	end

	self:_initCurrency()
	Activity197Controller.instance:dispatchEvent(Activity197Event.UpdateSingleItem, {
		poolId = poolId,
		gainId = gainId
	})
end

function Activity197Model:checkRewardReceied(poolId, gainId)
	local pool = self._gainIdsDict[poolId]

	if not pool then
		return false
	end

	for index, value in ipairs(pool) do
		if value == gainId then
			return true
		end
	end

	return false
end

function Activity197Model:checkPoolGetAllReward(poolId)
	local pool = self._gainIdsDict[poolId]

	if not pool then
		return false
	end

	local configCount = Activity197Config.instance:getPoolRewardCount(poolId)

	if configCount > #pool then
		return false
	end

	return true
end

function Activity197Model:getLastOpenPoolId()
	local idList = Activity197Config.instance:getPoolList()
	local count = 0

	for _, poolId in ipairs(idList) do
		if self:checkPoolOpen(poolId) then
			count = count + 1
		end
	end

	return count
end

function Activity197Model:checkPoolOpen(poolId)
	if poolId == 1 then
		return true
	end

	local prePoolId = poolId - 1

	if self:checkPoolGetBigReward(prePoolId) and poolId <= Activity197Config.instance:getPoolCount() then
		return true
	end

	return false
end

function Activity197Model:setCurrentPoolId(poolId)
	self._currentPoolId = poolId
end

function Activity197Model:getCurrentPoolId()
	return self._currentPoolId or 1
end

function Activity197Model:getCurrentPool()
	return self._gainIdsDict[self._currentPoolId]
end

function Activity197Model:_initCurrency()
	local currency1 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.KeyCurrency)

	if currency1 then
		if not currency1.quantity then
			local keyCount = 0
			local rummageConsume = Activity197Config.instance:getRummageConsume()

			self._rummageTimes = keyCount >= tonumber(rummageConsume) and math.floor(keyCount / tonumber(rummageConsume)) or 0

			local currency2 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.BulbCurrency)

			if currency2 then
				if not currency2.quantity then
					local bulbCount = 0

					if not self._currentBubbleCount then
						self._currentBubbleCount = bulbCount
					elseif bulbCount > self._currentBubbleCount then
						self._showBubbleVx = true
						self._currentBubbleCount = bulbCount
					end

					local exploreConsume = Activity197Config.instance:getExploreConsume()

					self._exploreTimes = bulbCount >= tonumber(exploreConsume) and math.floor(bulbCount / tonumber(exploreConsume)) or 0
				end
			end
		end
	end
end

function Activity197Model:canRummage()
	return self._rummageTimes > 0
end

function Activity197Model:canExplore()
	return self._exploreTimes > 0
end

function Activity197Model:getExploreTimes()
	return self._exploreTimes
end

function Activity197Model:getOnceExploreKeyCount()
	return self._exploreTimes * Activity197Config.instance:getExploreGetCount()
end

function Activity197Model:checkStageOpen(actId)
	local co = Activity197Config.instance:getStageConfig(actId, 1)

	if co then
		if not co.startTime then
			local startTime = 0

			if co then
				if not co.endTime then
					local endTime = 0

					startTime = TimeUtil.stringToTimestamp(startTime)
					endTime = TimeUtil.stringToTimestamp(endTime)

					local nowTime = ServerTime.now()

					return startTime <= nowTime and nowTime <= endTime
				end
			end
		end
	end
end

function Activity197Model:checkBigRewardHasGet()
	local co = Activity197Config.instance:getStageConfig(self._actId, 1)

	if co then
		if not co.globalTaskId then
			local globalTaskId = 0
			local globalTaskMo = TaskModel.instance:getTaskById(globalTaskId)

			return globalTaskMo and globalTaskMo:isClaimed()
		end
	end
end

function Activity197Model:checkBigRewardCanGet()
	local co = Activity197Config.instance:getStageConfig(self._actId, 1)

	if co then
		if not co.globalTaskId then
			local globalTaskId = 0
			local globalTaskMo = TaskModel.instance:getTaskById(globalTaskId)

			return globalTaskMo and globalTaskMo:isClaimable()
		end
	end
end

function Activity197Model:isTaskReceive(taskMo)
	if not taskMo then
		return false
	end

	return taskMo.finishCount > 0 and taskMo.progress >= taskMo.config.maxProgress
end

function Activity197Model:getStageProgress(actId)
	local co = Activity197Config.instance:getStageConfig(actId, 1)

	if co then
		if not co.globalTaskActivityId then
			local globalActId = 0

			if co then
				if not co.globalTaskId then
					local globalTaskId = 0
					local globalTaskMo = TaskModel.instance:getTaskById(globalTaskId)

					if globalTaskMo then
						if not globalTaskMo.progress then
							local progress = 0
							local stageConfig = Activity173Config.instance:getGlobalVisibleTaskStagesByActId(globalActId)

							if stageConfig then
								if not #stageConfig then
									local visibleStageCount = 0
									local fillAmount = 0
									local perStageFillAmount = 1 / (visibleStageCount - 1)
									local preStageCo

									for i = 1, visibleStageCount do
										local curStageCo = stageConfig[i]
										local curStageEndVal = curStageCo.endValue

										preStageCo = stageConfig[i - 1] or curStageCo

										if preStageCo then
											if not preStageCo.endValue then
												local preStageEndVal = 0
												local curStageVal = progress - preStageEndVal
												local curStageRangeVal = curStageEndVal - preStageEndVal
												local curStageProgress = curStageRangeVal ~= 0 and GameUtil.clamp(curStageVal / curStageRangeVal, 0, 1) or 0

												fillAmount = fillAmount + curStageProgress * perStageFillAmount
											end
										end
									end

									return fillAmount
								end
							end
						end
					end
				end
			end
		end
	end
end

function Activity197Model:getLastStageEndTime(actId)
	local co = Activity197Config.instance:getStageConfig(actId, 1)

	if co then
		if not co.globalTaskActivityId then
			local globalActId = 0

			if co then
				if not co.globalTaskId then
					local globalTaskId = 0
					local globalTaskMo = TaskModel.instance:getTaskById(globalTaskId)

					if globalTaskMo then
						if not globalTaskMo.progress then
							local progress = 0
							local stageConfig = Activity173Config.instance:getGlobalVisibleTaskStagesByActId(globalActId)

							if stageConfig then
								if not #stageConfig then
									local visibleStageCount = 0
									local stageEndTime = 0

									for i = 1, visibleStageCount do
										local curStageCo = stageConfig[i]

										if progress < curStageCo.endValue then
											stageEndTime = curStageCo.endTime
										end
									end

									return TimeUtil.stringToTimestamp(stageEndTime)
								end
							end
						end
					end
				end
			end
		end
	end
end

function Activity197Model:getShowBubbleVx()
	return self._showBubbleVx
end

function Activity197Model:resetShowBubbleVx()
	self._showBubbleVx = false
end

function Activity197Model:checkAllPoolRewardGet()
	local poolIdList = Activity197Config.instance:getPoolList()

	for index, poolId in ipairs(poolIdList) do
		if not self:checkPoolGetAllReward(poolId) then
			return false
		end
	end

	return true
end

Activity197Model.instance = Activity197Model.New()

return Activity197Model
