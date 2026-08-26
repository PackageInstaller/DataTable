-- chunkname: @modules/logic/room/model/map/RoomProductionLineMO.lua

module("modules.logic.room.model.map.RoomProductionLineMO", package.seeall)

local RoomProductionLineMO = pureTable("RoomProductionLineMO")

function RoomProductionLineMO:init(id)
	self.id = id
	self.config = RoomConfig.instance:getProductionLineConfig(self.id)
	self.finishCount = 0
	self.reserve = self.config.reserve
	self.useReserve = 0
	self.level = 0

	if self.config.levelGroup > 0 then
		self.levelGroupCO = RoomConfig.instance:getProductionLineLevelGroupIdConfig(self.config.levelGroup)
	end

	self:updateMaxLevel()
end

function RoomProductionLineMO:updateMaxLevel()
	local roomLevel = RoomModel.instance:getRoomLevel()

	self.maxLevel = 0
	self.maxConfigLevel = 0

	if self.config.levelGroup > 0 and self.levelGroupCO then
		for i, levelGroupConfig in ipairs(self.levelGroupCO) do
			if roomLevel >= levelGroupConfig.needRoomLevel then
				self.maxLevel = math.max(levelGroupConfig.id, self.maxLevel)
			end

			self.maxConfigLevel = math.max(levelGroupConfig.id, self.maxConfigLevel)
		end
	end
end

function RoomProductionLineMO:updateInfo(info)
	self.formulaId = info.formulaId
	self.finishCount = info.finishCount or 0
	self.nextFinishTime = info.nextFinishTime
	self.pauseTime = info.pauseTime
	self.reserve = self.config.reserve
	self.useReserve = 0

	self:updateLevel(info.level or 1)
end

function RoomProductionLineMO:updateLevel(level)
	self.level = level

	if self.config.levelGroup > 0 then
		self.levelCO = RoomConfig.instance:getProductionLineLevelConfig(self.config.levelGroup, self.level)

		local arr = GameUtil.splitString2(self.levelCO.effect, true)
		local totalDecRate = 0

		if arr then
			for i, v in ipairs(arr) do
				if v[1] == RoomBuildingEnum.EffectType.Reserve then
					self.reserve = self.reserve + v[2]
				elseif v[1] == RoomBuildingEnum.EffectType.Time then
					totalDecRate = totalDecRate + v[2]
				end
			end
		end

		self.formulaCO = RoomConfig.instance:getFormulaConfig(self.formulaId)

		if not self.formulaCO then
			return
		end

		self.useReserve = self.formulaCO.costReserve * self.finishCount

		local remainRate = math.max(0, 1000 - totalDecRate)

		self.costTime = math.floor(self.formulaCO.costTime * remainRate / 1000)

		local produceArr = string.splitToNumber(self.formulaCO.produce, "#")

		self.produceSpeed = produceArr[3]

		local leftCount = self.reserve - (self.useReserve + self.formulaCO.costReserve)

		self.allFinishTime = self.nextFinishTime

		if leftCount > 0 then
			self.allFinishTime = self.allFinishTime + math.ceil(leftCount / self.formulaCO.costReserve) * self.costTime
		elseif leftCount < 0 then
			self.allFinishTime = 0
		end
	end
end

function RoomProductionLineMO:isCanGain()
	return self.useReserve > 0
end

function RoomProductionLineMO:isLock()
	return self.level == 0
end

function RoomProductionLineMO:isRoomLevelUnLockNext()
	local roomLevel = RoomModel.instance:getRoomLevel()

	return self.config.needRoomLevel == roomLevel + 1
end

function RoomProductionLineMO:isPause()
	return self.pauseTime and self.pauseTime > 0
end

function RoomProductionLineMO:getReservePer()
	local per = self.useReserve / self.reserve

	per = math.min(1, per)

	return per, (per ~= 0 or nil) and math.max(1, math.floor(per * 100))
end

function RoomProductionLineMO:isFull()
	return self.useReserve >= self.reserve
end

function RoomProductionLineMO:isIdle()
	return not self.formulaId or self.formulaId <= 0
end

function RoomProductionLineMO:getGathericon()
	local formulaId = self.formulaId
	local produceItemParam = RoomProductionHelper.getFormulaProduceItem(formulaId)

	if produceItemParam then
		local icon

		if produceItemParam.type == MaterialEnum.MaterialType.Currency then
			local currencyname = CurrencyConfig.instance:getCurrencyCo(produceItemParam.id).icon

			icon = ResUrl.getCurrencyItemIcon(currencyname .. "_room")
		else
			icon = ResUrl.getCurrencyItemIcon(produceItemParam.id .. "_room")
		end

		return icon
	end
end

return RoomProductionLineMO
