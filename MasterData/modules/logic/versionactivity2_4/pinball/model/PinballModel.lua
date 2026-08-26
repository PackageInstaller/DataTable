-- chunkname: @modules/logic/versionactivity2_4/pinball/model/PinballModel.lua

module("modules.logic.versionactivity2_4.pinball.model.PinballModel", package.seeall)

local PinballModel = class("PinballModel", BaseModel)

function PinballModel:onInit()
	self._buildingInfo = {}
	self._resInfo = {}
	self._unlockTalents = {}
	self.day = 0
	self.restCdDay = 0
	self.maxProsperity = 0
	self.isGuideAddGrain = false
	self.gameAddResDict = {}
	self.leftEpisodeId = 0
	self.marblesLvDict = {}
	self._gmball = 0
	self._gmUnlockAll = false
	self._gmkey = false
	self._talentRedDict = {}
	self.guideHole = 1
end

function PinballModel:reInit()
	self._buildingInfo = {}
	self._resInfo = {}
	self._unlockTalents = {}
	self.day = 0
	self.gameAddResDict = {}
end

function PinballModel:isOpen()
	return ActivityHelper.getActivityStatus(VersionActivity2_4Enum.ActivityId.Pinball, true) == ActivityEnum.ActivityStatus.Normal
end

function PinballModel:initData(msg)
	self.day = msg.day
	self.oper = msg.oper
	self.restCdDay = msg.restCdDay
	self.maxProsperity = msg.maxProsperity
	self.isGuideAddGrain = msg.isGuideAddGrain
	self._buildingInfo = {}
	self._resInfo = {}
	self._unlockTalents = {}
	self.gameAddResDict = {}

	for _, info in ipairs(msg.buildings) do
		self._buildingInfo[info.index] = PinballBuildingMo.New()

		self._buildingInfo[info.index]:init(info)
	end

	for _, info in ipairs(msg.currencys) do
		self._resInfo[info.type] = PinballCurrencyMo.New()

		self._resInfo[info.type]:init(info)
	end

	for _, talentId in ipairs(msg.talentIds) do
		local talentMo = PinballTalentMo.New()

		talentMo:init(talentId)

		self._unlockTalents[talentId] = talentMo
	end

	self:checkTalentRed()
	PinballController.instance:dispatchEvent(PinballEvent.DataInited)
end

function PinballModel:unlockTalent(talentId)
	local talentMo = PinballTalentMo.New()

	talentMo:init(talentId)

	self._unlockTalents[talentId] = talentMo

	self:checkTalentRed()
end

function PinballModel:getTalentMo(talentId)
	return self._unlockTalents[talentId]
end

function PinballModel:getBuildingNum(id)
	local num = 0

	for _, buildingMo in pairs(self._buildingInfo) do
		if buildingMo.baseCo.id == id then
			num = num + 1
		end
	end

	return num
end

function PinballModel:onCurrencyChange(currencys)
	for _, info in ipairs(currencys) do
		self._resInfo[info.type] = self._resInfo[info.type] or PinballCurrencyMo.New()

		self._resInfo[info.type]:init(info)
	end

	self:checkTalentRed()
end

function PinballModel:getScoreLevel()
	local score = self:getResNum(PinballEnum.ResType.Score)

	return PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, score)
end

function PinballModel:setCurrency(data)
	self._resInfo[data.type] = self._resInfo[data.type] or PinballCurrencyMo.New()

	self._resInfo[data.type]:init(data)
end

function PinballModel:getResNum(resType)
	if not self._resInfo[resType] then
		return 0, 0
	end

	return self._resInfo[resType].num, self._resInfo[resType].changeNum
end

function PinballModel:getTotalFoodCost()
	local num = 0

	for _, buildingMo in pairs(self._buildingInfo) do
		num = num + buildingMo:getFoodCost()
	end

	return num
end

function PinballModel:getTotalPlayDemand()
	local num = 0

	for _, buildingMo in pairs(self._buildingInfo) do
		num = num + buildingMo:getPlayDemand()
	end

	num = num - self:getPlayDec()
	num = math.max(0, num)

	return num
end

function PinballModel:getCostDec()
	local val = 0

	for _, talentMo in pairs(self._unlockTalents) do
		val = val + talentMo:getCostDec()
	end

	return val
end

function PinballModel:getResAdd(resType)
	local val = 0

	for _, talentMo in pairs(self._unlockTalents) do
		val = val + talentMo:getResAdd(resType)
	end

	return val
end

function PinballModel:checkTalentRed()
	self._talentRedDict = {}

	for _, buildingMo in pairs(self._buildingInfo) do
		if buildingMo.baseCo.type == PinballEnum.BuildingType.Talent then
			local level = buildingMo.level
			local type = 1
			local effectDict = GameUtil.splitString2(buildingMo.baseCo.effect, true) or {}

			for _, arr in pairs(effectDict) do
				if arr[1] == PinballEnum.BuildingEffectType.UnlockTalent then
					type = arr[2]

					break
				end
			end

			local talentCos = PinballConfig.instance:getTalentCoByRoot(VersionActivity2_4Enum.ActivityId.Pinball, type)

			for k, talentCo in pairs(talentCos) do
				local needLv = talentCo.needLv

				if not self:getTalentMo(talentCo.id) and needLv <= level then
					local conditionArr = string.splitToNumber(talentCo.condition, "#") or {}
					local canLearn = true

					for _, id in pairs(conditionArr) do
						if not self:getTalentMo(id) then
							canLearn = false

							break
						end
					end

					if canLearn then
						local cost = talentCo.cost

						if not string.nilorempty(cost) then
							local dict = GameUtil.splitString2(cost, true)

							for _, arr in pairs(dict) do
								if arr[2] > self:getResNum(arr[1]) then
									canLearn = false

									break
								end
							end
						end
					end

					if canLearn then
						self._talentRedDict[buildingMo.baseCo.id] = true

						break
					end
				end
			end
		end
	end

	PinballController.instance:dispatchEvent(PinballEvent.TalentRedChange)
end

function PinballModel:getTalentRed(buildingId)
	return self._talentRedDict[buildingId] or false
end

function PinballModel:getPlayDec()
	local val = 0

	for _, talentMo in pairs(self._unlockTalents) do
		val = val + talentMo:getPlayDec()
	end

	return val
end

function PinballModel:getMarblesLv(marblesId)
	local val = 1

	for _, talentMo in pairs(self._unlockTalents) do
		val = math.max(talentMo:getMarblesLv(marblesId), val)
	end

	return val
end

function PinballModel:getMarblesIsUnlock(marblesId)
	for _, talentMo in pairs(self._unlockTalents) do
		if talentMo:getIsUnlockMarbles(marblesId) then
			return true
		end
	end

	return false
end

function PinballModel:getAllMarblesNum()
	local dict = {}
	local lvDict = {}
	local holeNum = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.DefaultMarblesHoleNum)
	local _, defaultMarbles = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.DefaultMarblesNum)
	local arr = GameUtil.splitString2(defaultMarbles, true) or {}

	for _, info in pairs(arr) do
		dict[info[1]] = info[2]
	end

	for i = 1, 5 do
		dict[i] = dict[i] or 0

		if self:getMarblesIsUnlock(i) then
			local lv = self:getMarblesLv(i)

			lvDict[i] = lv

			local co = lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][i]
			local useNums = string.splitToNumber(co.limit, "#") or {}

			dict[i] = dict[i] + ((not useNums[lv] or nil) and (useNums[#useNums] or 0))
		end
	end

	if self._gmUnlockAll then
		for i = 1, 5 do
			dict[i] = 5
			lvDict[i] = 4
		end
	end

	local rawNum = holeNum
	local cur = PinballModel.instance:getResNum(PinballEnum.ResType.Complaint)

	if cur >= PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintLimit) then
		holeNum = holeNum - PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintMaxSubHoleNum)
	elseif cur >= PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThreshold) then
		holeNum = holeNum - PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThresholdSubHoleNum)
	end

	self.marblesLvDict = lvDict

	return dict, holeNum, rawNum
end

function PinballModel:getMarblesLvCache(marblesId)
	return self.marblesLvDict[marblesId] or 1
end

function PinballModel:addGameRes(resType, num)
	self.gameAddResDict[resType] = self.gameAddResDict[resType] or 0
	self.gameAddResDict[resType] = self.gameAddResDict[resType] + num

	PinballController.instance:dispatchEvent(PinballEvent.GameResChange)
end

function PinballModel:getGameRes(resType)
	local val = 0

	if not resType or resType == 0 then
		for _, value in pairs(self.gameAddResDict) do
			val = val + value
		end
	else
		val = self.gameAddResDict[resType] or 0
	end

	return val
end

function PinballModel:clearGameRes()
	self.gameAddResDict = {}
end

function PinballModel:getBuildingInfo(index)
	return self._buildingInfo[index]
end

function PinballModel:getBuildingInfoById(id)
	for _, buildingMo in pairs(self._buildingInfo) do
		if buildingMo.baseCo.id == id then
			return buildingMo
		end
	end
end

function PinballModel:getAllTalentBuildingId()
	local ids = {}

	for _, buildingMo in pairs(self._buildingInfo) do
		if buildingMo.baseCo.type == PinballEnum.BuildingType.Talent then
			table.insert(ids, buildingMo.baseCo.id)
		end
	end

	table.sort(ids)

	return ids
end

function PinballModel:addBuilding(configId, index)
	if self._buildingInfo[index] then
		logError("建筑已存在？？" .. index)
	end

	local data = {
		food = 0,
		interact = 0,
		level = 1,
		configId = configId,
		index = index
	}

	self._buildingInfo[index] = PinballBuildingMo.New()

	self._buildingInfo[index]:init(data)
	self:checkTalentRed()
	PinballController.instance:dispatchEvent(PinballEvent.AddBuilding, index)
end

function PinballModel:upgradeBuilding(index)
	if not self._buildingInfo[index] then
		logError("建筑不存在？？" .. index)

		return
	end

	self._buildingInfo[index]:upgrade()
	self:checkTalentRed()
	PinballController.instance:dispatchEvent(PinballEvent.UpgradeBuilding, index)
end

function PinballModel:removeBuilding(index)
	if not self._buildingInfo[index] then
		logError("建筑不存在？？" .. index)
	end

	self._buildingInfo[index] = nil

	PinballController.instance:dispatchEvent(PinballEvent.RemoveBuilding, index)
end

PinballModel.instance = PinballModel.New()

return PinballModel
