-- chunkname: @modules/logic/room/config/RoomTradeConfig.lua

module("modules.logic.room.config.RoomTradeConfig", package.seeall)

local RoomTradeConfig = class("RoomTradeConfig", BaseConfig)

function RoomTradeConfig:ctor()
	self._constConfig = nil
	self._qualityConfig = nil
	self._refreshConfig = nil
	self._barrageConfig = nil
	self._taskConfig = nil
	self._supportBonusConfig = nil
	self._levelUnlockConfig = nil
	self._levelConfig = nil
	self._qualityDic = nil
	self._refreshDic = nil
	self._barrageDic = nil
	self._taskDic = nil
end

function RoomTradeConfig:reqConfigNames()
	return {
		"room_order_const",
		"room_order_quality",
		"room_order_refresh",
		"room_trade_barrage",
		"trade_task",
		"trade_support_bonus",
		"trade_level_unlock",
		"trade_level"
	}
end

function RoomTradeConfig:onConfigLoaded(configName, configTable)
	if configName == "room_order_const" then
		self._constConfig = configTable
	elseif configName == "room_order_quality" then
		self._qualityConfig = configTable

		self:_initOrderQualityCo()
	elseif configName == "room_order_refresh" then
		self._refreshConfig = configTable

		self:_initOrderRefreshCo()
	elseif configName == "room_trade_barrage" then
		self._barrageConfig = configTable

		self:_initBarrageCo()
	elseif configName == "trade_task" then
		self._taskConfig = configTable

		self:_initTaskCo()
	elseif configName == "trade_support_bonus" then
		self._supportBonusConfig = configTable
	elseif configName == "trade_level_unlock" then
		self._levelUnlockConfig = configTable
	elseif configName == "trade_level" then
		self._levelConfig = configTable
	end
end

function RoomTradeConfig:getConstValue(constId, isNumber)
	if self._constConfig then
		if self._constConfig then
			if isNumber then
				return tonumber(self._constConfig.value)
			end

			return self._constConfig.value
		end
	end
end

function RoomTradeConfig:_initOrderRefreshCo()
	self._refreshDic = {}

	for _, co in pairs(self._refreshConfig.configList) do
		local info = {}

		info.daily = GameUtil.splitString2(co.qualityWeight, true)
		info.wholesale = GameUtil.splitString2(co.wholesaleGoodsWeight, true)
		info.co = co

		table.insert(self._refreshDic, info)
	end
end

function RoomTradeConfig:getOrderRefreshInfo(level)
	return self._refreshDic[level]
end

function RoomTradeConfig:_initOrderQualityCo()
	self._qualityDic = {}

	for _, co in pairs(self._qualityConfig.configList) do
		local info = {}

		info.co = co
		info.goodsWeight = GameUtil.splitString2(co.goodsWeight, true)
		info.typeCount = string.split(co.typeCount, "|")

		table.insert(self._qualityDic, info)
	end
end

function RoomTradeConfig:getOrderQualityInfo(orderId)
	return self._qualityDic[orderId]
end

function RoomTradeConfig:_initBarrageCo()
	self._barrageDic = self._barrageDic or {}
	self._barrageTypeCount = self._barrageTypeCount or {}

	for _, co in ipairs(self._barrageConfig.configList) do
		local type = co.type
		local cos = self._barrageDic[type]

		if not cos then
			cos = {}
			self._barrageDic[type] = cos
		end

		table.insert(cos, co)
	end

	for _, type in pairs(RoomTradeEnum.BarrageType) do
		self._barrageTypeCount[type] = self._barrageDic[type] and #self._barrageDic[type]
	end
end

function RoomTradeConfig:getBarrageCosByType(type)
	local coList = {}

	if not self._barrageDic then
		return coList
	end

	coList = self._barrageDic[type]

	return self._barrageDic[type]
end

function RoomTradeConfig:getBarrageCoByTypeIndex(type, index)
	if not self._barrageDic or not self._barrageDic[type] then
		return
	end

	return self._barrageDic[type][index]
end

function RoomTradeConfig:getBarrageTypeCount(type)
	return self._barrageTypeCount[type] or 0
end

function RoomTradeConfig:_initTaskCo()
	self._taskDic = {}
	self._taskMaxLevel = 0

	for _, co in ipairs(self._taskConfig.configList) do
		local tradeLevel = co.tradeLevel
		local cos = self._taskDic[tradeLevel]

		if not cos then
			cos = {}
			self._taskDic[tradeLevel] = cos
		end

		self._taskMaxLevel = math.max(self._taskMaxLevel, tradeLevel)

		table.insert(cos, co)
	end
end

function RoomTradeConfig:getTaskCosByLevel(level)
	return self._taskDic[level]
end

function RoomTradeConfig:getTaskCoById(id)
	return self._taskConfig.configDict[id]
end

function RoomTradeConfig:getSupportBonusById(level)
	return self._supportBonusConfig.configDict[level]
end

function RoomTradeConfig:getSupportBonusConfig()
	return self._supportBonusConfig.configList
end

function RoomTradeConfig:getTaskMaxLevel()
	return self._taskMaxLevel
end

function RoomTradeConfig:getLevelUnlockCo(id)
	return self._levelUnlockConfig.configDict[id]
end

function RoomTradeConfig:getLevelCo(level)
	return self._levelConfig.configDict[level]
end

function RoomTradeConfig:getMaxLevel()
	local max = 0

	for _, co in ipairs(self._levelConfig.configList) do
		max = math.max(max, co.level)
	end

	return max
end

RoomTradeConfig.instance = RoomTradeConfig.New()

return RoomTradeConfig
