-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonPassPortModel.lua

module("logic.extensions.season.model.SeasonPassPortModel", package.seeall)

local SeasonPassPortModel = class("SeasonPassPortModel", BaseModel)

SeasonPassPortModel.SEASON_PASS_ENERGY_GOODS_ID = 1216

function SeasonPassPortModel:ctor()
	return
end

function SeasonPassPortModel:onInit()
	self:onReset()
end

function SeasonPassPortModel:onReset()
	self._seasonPassRewardData = nil
	self._seasonPassTaskData = nil
end

function SeasonPassPortModel:GetSeasonPassPortViewData()
	if self._seasonPassRewardData then
		return self._seasonPassRewardData
	end

	SeasonModeWarOrderController.instance:sendRequestSeasonInfo()

	return nil
end

function SeasonPassPortModel:GetSeasonPassPortEnergyViewData()
	if self._seasonPassTaskData then
		return self._seasonPassTaskData
	end

	SeasonModeWarOrderController.instance:sendRequestSeasonTaskInfo()

	return nil
end

function SeasonPassPortModel:getPassMainViewData(seasonId)
	local data = {}
	local cfg = SeasonConfig.instance:getSeasonConfigBySeasonId(seasonId)
	local startTimeText = GameUtil.formatTimeString("%m.%d %H:%M", cfg.startTime)
	local endTimeText = GameUtil.formatTimeString("%m.%d %H:%M", cfg.endTime)

	data.timeTxt = "活动时间:" .. startTimeText .. "~" .. endTimeText

	return data
end

function SeasonPassPortModel:refreshSeasonPassRewardData(msg)
	if not self._seasonPassRewardData then
		local data = {}

		data.curseasonid = msg.curSeasonId
		data.nowEnergy = msg.energy

		local gainnormalprizeids = msg.gainNormalPrizeIds
		local gainsuperprizeids = msg.gainSuperPrizeIds

		data.hasPay = msg.isBuy
		data.recoverdays = msg.recoverDays
		data.buylevels = msg.buyLevels
		data.hasgainfinalprize = msg.hasGainFinalPrize
		data.isKillBoss = msg.isKillBoss
		data.finishChallenge = msg.isKillBoss

		local baseCfg = SeasonConfig.instance:getSeasonPassBaseConfig(data.curseasonid)
		local levelCfg = SeasonConfig.instance:getSeasonPassLevelConfig(baseCfg.levelPlan)
		local normalRewardCfg = SeasonConfig.instance:getSeasonPassRewardConfig(baseCfg.normalPrizePlan)
		local superRewardCfg = SeasonConfig.instance:getSeasonPassRewardConfig(baseCfg.superPrizePlan)

		data.baseCfg = baseCfg
		data.maxLevel = #levelCfg
		data.nowUnlockLevel = 0
		data.maxLevelEnerg = 0

		self:_setSeasonPassLevelOtherData(data)

		data.raceId = baseCfg.showSpiritId
		data.skinId = baseCfg.showSpiritMatId

		if data.raceId ~= 0 then
			data.raceName = MaterialMgr.getMaterialsName(MatType.PET_SKIN, data.raceId)
		end

		if data.skinId ~= 0 then
			data.skinName = PetSkinConfig.instance:getPetSkinCfg(data.skinId).skinName
		end

		data.seasonTxt = "S" .. data.curseasonid .. "赛季"
		data.rewardData = {}

		for id = 1, #levelCfg do
			local param = {
				id = id,
				freeisReceive = self:_existIdByMsgArray(id, gainnormalprizeids),
				payedisReceive = self:_existIdByMsgArray(id, gainsuperprizeids)
			}

			if normalRewardCfg[id] then
				param.freeReward = normalRewardCfg[id].prize
			end

			if superRewardCfg[id] then
				param.payedReward = superRewardCfg[id].prize
			end

			table.insert(data.rewardData, param)
		end

		table.insert(data.rewardData, {
			isLast = true
		})

		self._seasonPassRewardData = data

		GlobalDispatcher:dispatch(GlobalNotify.SeasonPassPortUpdate, data)
	end
end

function SeasonPassPortModel:_existIdByMsgArray(id, data)
	for _, v in ipairs(data) do
		if v == id then
			return true
		end
	end

	return false
end

function SeasonPassPortModel:_setSeasonPassLevelOtherData(data)
	local levelCfg = SeasonConfig.instance:getSeasonPassLevelConfig(data.baseCfg.levelPlan)

	data.nowUnlockLevel = 0

	for _, v in ipairs(levelCfg) do
		if v.energy <= data.nowEnergy then
			data.nowUnlockLevel = v.level
		end

		data.maxLevelEnerg = data.maxLevelEnerg + v.energy
	end

	data.nowLvEnerg = 0
	data.nextLvEnerg = 0

	if levelCfg[data.nowUnlockLevel + 1] then
		data.nowLvEnerg = levelCfg[data.nowUnlockLevel].energy
		data.nextLvEnerg = levelCfg[data.nowUnlockLevel + 1].energy
	end

	data.overflowEnergy = 0

	if data.nowUnlockLevel >= data.maxLevel then
		data.overflowEnergy = data.nowEnergy - levelCfg[#levelCfg].energy
	end
end

function SeasonPassPortModel:refreshSeasonPassBuyLevelData(msg)
	local data = self._seasonPassRewardData

	data.nowEnergy = msg.energy
	data.buylevels = msg.buyLevels

	self:_setSeasonPassLevelOtherData(data)
	FloatWordMgr.instance:show("购买成功")
	GlobalDispatcher:dispatch(GlobalNotify.SeasonPassPortUpdate, data)
end

function SeasonPassPortModel:refreshSeasonPassReceiveRewardData(msg, isAll)
	local data = self._seasonPassRewardData

	if isAll then
		for k, v in pairs(data.rewardData) do
			if v.id and v.id <= data.nowUnlockLevel then
				v.freeisReceive = true

				if data.hasPay then
					v.payedisReceive = true
				end
			end
		end
	else
		for _, v in pairs(data.rewardData) do
			if v.id and v.id == msg.prizeId then
				if msg.isSuper then
					v.payedisReceive = true

					break
				end

				v.freeisReceive = true

				break
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeasonPassPortUpdate, data)
end

function SeasonPassPortModel:refreshSeasonPassLuckDrawData(msg)
	local data = self._seasonPassRewardData

	data.nowEnergy = msg.energy

	self:_setSeasonPassLevelOtherData(data)
	GlobalDispatcher:dispatch(GlobalNotify.SeasonPassPortUpdate, data)
end

function SeasonPassPortModel:refreshSeasonPassBuySuccess()
	SeasonModeWarOrderController.instance:sendRequestSeasonInfo()
	FloatWordMgr.instance:show("购买成功")
end

function SeasonPassPortModel:refreshSeasonPassGetFinalReward()
	local data = self._seasonPassRewardData

	data.hasgainfinalprize = true

	GlobalDispatcher:dispatch(GlobalNotify.SeasonPassPortUpdate, data)
end

function SeasonPassPortModel:refreshSeasonPassGetFindEnergy(msg)
	local data = self._seasonPassRewardData

	data.nowEnergy = msg.energy
	data.recoverdays = 0

	self:_setSeasonPassLevelOtherData(data)
	FloatWordMgr.instance:show("能量找回成功")
	GlobalDispatcher:dispatch(GlobalNotify.SeasonPassPortUpdate, data)
end

function SeasonPassPortModel:getSeasonPassPortBuyViewData()
	if self._seasonPassRewardData then
		local allDataRepeatCheck = {}
		local nowDataRepeatCheck = {}
		local allSortData = {}
		local nowSortData = {}
		local allData = {}
		local nowData = {}
		local nowLevel = self._seasonPassRewardData.nowUnlockLevel

		for _, v in pairs(self._seasonPassRewardData.rewardData) do
			if v.id then
				local rewards = string.split(v.payedReward, "#")

				for _, reward in pairs(rewards) do
					local type, id, num = MaterialMgr.getMatParams(reward)

					allDataRepeatCheck[type] = allDataRepeatCheck[type] or {}
					allDataRepeatCheck[type][id] = allDataRepeatCheck[type][id] or 0
					allDataRepeatCheck[type][id] = num + allDataRepeatCheck[type][id]

					if nowLevel >= v.id then
						nowDataRepeatCheck[type] = nowDataRepeatCheck[type] or {}
						nowDataRepeatCheck[type][id] = nowDataRepeatCheck[type][id] or 0
						nowDataRepeatCheck[type][id] = num + nowDataRepeatCheck[type][id]
					end
				end
			end
		end

		for type, item in pairs(allDataRepeatCheck) do
			for id, num in pairs(item) do
				local quality = MaterialMgr.getGoodsQuality(type, id)

				table.insert(allSortData, {
					type = type,
					id = id,
					num = num,
					quality = quality
				})
			end
		end

		for type, item in pairs(nowDataRepeatCheck) do
			for id, num in pairs(item) do
				local quality = MaterialMgr.getGoodsQuality(type, id)

				table.insert(nowSortData, {
					type = type,
					id = id,
					num = num,
					quality = quality
				})
			end
		end

		table.sort(allSortData, function(a, b)
			return checknumber(a.quality) > checknumber(b.quality)
		end)
		table.sort(nowSortData, function(a, b)
			return checknumber(a.quality) > checknumber(b.quality)
		end)

		for _, v in ipairs(allSortData) do
			table.insert(allData, v.type .. ":" .. v.id .. ":" .. v.num)
		end

		for _, v in ipairs(nowSortData) do
			table.insert(nowData, v.type .. ":" .. v.id .. ":" .. v.num)
		end

		local data = {}

		data.payGoodsId = self._seasonPassRewardData.baseCfg.payGoodsId
		data.subGoodsType = 45
		data.seasonId = self._seasonPassRewardData.curseasonid
		data.rewardAllData = allData
		data.rewardNowData = nowData

		return data
	end

	return nil
end

function SeasonPassPortModel:getSeasonPassBuyLevelPopViewData()
	if self._seasonPassRewardData then
		local seasonData = self._seasonPassRewardData
		local buyLevelCfg = SeasonConfig.instance:getSeasonPassBuyLevelConfig(seasonData.baseCfg.buyPlan)
		local data = {}

		data.curseasonid = seasonData.curseasonid
		data.nowLevel = seasonData.nowUnlockLevel
		data.maxLevel = seasonData.maxLevel
		data.useBuyLevel = seasonData.buylevels
		data.maxBuyLevel = seasonData.baseCfg.maxBuyLevel
		data.buyLevelCostConfig = buyLevelCfg
		data.costCfg = buyLevelCfg[1].cost

		return data
	end

	return nil
end

function SeasonPassPortModel:getSeasonFindEnergyPopViewData()
	if self._seasonPassRewardData then
		local seasonData = self._seasonPassRewardData
		local recoverCfg = SeasonConfig.instance:getSeasonPassRecoverConfig(seasonData.baseCfg.recoverPlan)
		local data = {}

		data.curseasonid = seasonData.curseasonid
		data.canFindDay = seasonData.recoverdays
		data.maxFindDay = seasonData.baseCfg.maxRecoverDay

		if data.canFindDay > data.maxFindDay then
			data.canFindDay = data.maxFindDay
		end

		data.maxEnergy = recoverCfg[data.maxFindDay].energy

		if data.canFindDay > 0 then
			data.nowEnergy = recoverCfg[data.canFindDay].energy
			data.findCost = recoverCfg[data.canFindDay].cost
		else
			data.nowEnergy = 0
			data.findCost = 0
		end

		return data
	end

	return nil
end

function SeasonPassPortModel:refreshSeasonPassTaskData(msg)
	if not self._seasonPassTaskData then
		local data = {}

		data.curseasonid = msg.curSeasonId

		local baseCfg = SeasonConfig.instance:getSeasonPassBaseConfig(data.curseasonid)
		local taskCfg = SeasonConfig.instance:getSeasonPassTaskConfig(baseCfg.taskPlan)

		data.dailyTaskData = {}
		data.allTimeTaskData = {}
		data.baseCfg = baseCfg

		local repeatDailyTaskData = {}
		local repeatAllTimeTaskData = {}

		for k, v in ipairs(msg.taskList) do
			local config = taskCfg[checknumber(v.taskId)]
			local taskParam = {}

			taskParam.taskId = v.taskId
			taskParam.value = v.progress
			taskParam.gainPrize = v.gainPrize
			taskParam.config = config
			taskParam.isFinish = v.progress >= config.maxProgress
			taskParam.reward = MatType.Item_Fake .. ":" .. SeasonPassPortModel.SEASON_PASS_ENERGY_GOODS_ID .. ":" .. config.energy

			if config.periodType == "daily" then
				if taskParam.gainPrize or taskParam.isFinish then
					table.insert(data.dailyTaskData, taskParam)
				elseif not repeatDailyTaskData[config.pageId] then
					repeatDailyTaskData[config.pageId] = taskParam
				elseif config.maxProgress < repeatDailyTaskData[config.pageId].config.maxProgress then
					repeatDailyTaskData[config.pageId] = taskParam
				end
			elseif config.periodType == "allTime" then
				if taskParam.gainPrize or taskParam.isFinish then
					table.insert(data.allTimeTaskData, taskParam)
				elseif not repeatAllTimeTaskData[config.pageId] then
					repeatAllTimeTaskData[config.pageId] = taskParam
				elseif config.maxProgress < repeatAllTimeTaskData[config.pageId].config.maxProgress then
					repeatAllTimeTaskData[config.pageId] = taskParam
				end
			end
		end

		for _, v in pairs(repeatDailyTaskData) do
			table.insert(data.dailyTaskData, v)
		end

		for _, v in pairs(repeatAllTimeTaskData) do
			table.insert(data.allTimeTaskData, v)
		end

		self._seasonPassTaskData = data

		self:_sortTaskData()
		GlobalDispatcher:dispatch(GlobalNotify.SeasonPassPortEnergyUpdate, data)
	end
end

function SeasonPassPortModel:_sortTaskData()
	if self._seasonPassTaskData then
		local function comp(a, b)
			if a.isFinish ~= b.isFinish then
				if a.gainPrize ~= b.gainPrize then
					return b.gainPrize
				end

				return a.isFinish
			elseif a.gainPrize ~= b.gainPrize then
				return b.gainPrize
			end

			return a.taskId < b.taskId
		end

		table.sort(self._seasonPassTaskData.dailyTaskData, comp)
		table.sort(self._seasonPassTaskData.allTimeTaskData, comp)
	end
end

function SeasonPassPortModel:refreshSeasonPassReceiveTaskData(msg)
	if msg.taskId == -1 then
		SeasonModeWarOrderController.instance:sendRequestSeasonInfo()
		SeasonModeWarOrderController.instance:sendRequestSeasonTaskInfo()

		if msg.addEnergy > 0 then
			FloatWordMgr.instance:show("异界能量+" .. msg.addEnergy)
		end

		return
	end

	local data = self._seasonPassTaskData
	local addEnergy = 0

	for _, v in pairs(data.dailyTaskData) do
		if v.taskId == msg.taskId then
			addEnergy = v.config.energy
			v.gainPrize = true

			break
		end
	end

	for _, v in pairs(data.allTimeTaskData) do
		if v.taskId == msg.taskId then
			addEnergy = v.config.energy
			v.gainPrize = true

			break
		end
	end

	self:_sortTaskData()

	if addEnergy > 0 then
		FloatWordMgr.instance:show("异界能量+" .. addEnergy)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeasonPassPortEnergyUpdate, data)

	local passRewardData = self._seasonPassRewardData

	passRewardData.nowEnergy = passRewardData.nowEnergy + addEnergy

	self:_setSeasonPassLevelOtherData(passRewardData)
	GlobalDispatcher:dispatch(GlobalNotify.SeasonPassPortUpdate, passRewardData)
end

function SeasonPassPortModel:canFindEnergy()
	if self._seasonPassRewardData then
		return self._seasonPassRewardData.recoverdays > 0
	end

	return false
end

function SeasonPassPortModel:canReceiveFinalReward()
	if self._seasonPassRewardData then
		return self._seasonPassRewardData.isKillBoss and self._seasonPassRewardData.nowUnlockLevel >= self._seasonPassRewardData.maxLevel and not self._seasonPassRewardData.hasgainfinalprize
	end

	return false
end

function SeasonPassPortModel:canReceiveOneKey()
	if self._seasonPassRewardData then
		for _, v in pairs(self._seasonPassRewardData.rewardData) do
			if v.id and v.id <= self._seasonPassRewardData.nowUnlockLevel and (not v.freeisReceive or self._seasonPassRewardData.hasPay and not v.payedisReceive) then
				return true
			end
		end
	end

	return false
end

function SeasonPassPortModel:canReceiveTask()
	if self._seasonPassTaskData then
		for _, v in pairs(self._seasonPassTaskData.dailyTaskData) do
			if v.isFinish and not v.gainPrize then
				return true
			end
		end

		for _, v in pairs(self._seasonPassTaskData.allTimeTaskData) do
			if v.isFinish and not v.gainPrize then
				return true
			end
		end
	end

	return false
end

SeasonPassPortModel.instance = SeasonPassPortModel.New()

return SeasonPassPortModel
