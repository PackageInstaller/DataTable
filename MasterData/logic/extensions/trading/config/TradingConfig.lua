-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/config/TradingConfig.lua

module("logic.extensions.trading.config.TradingConfig", package.seeall)

local M = class("TradingConfig", BaseConfig)

function M:ctor()
	M.super.ctor(self)

	self._const = {}
	self._orderDetail = {}
	self._house = {}
	self._info = {}
end

function M:reset()
	return
end

function M:getNames()
	return {
		ConfigName.TradeHouse,
		ConfigName.TradeOrderDetail,
		ConfigName.TradeConst,
		ConfigName.TradeInfo
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.TradeHouse then
		self._house = content
	elseif name == ConfigName.TradeConst then
		self._const = content
	elseif name == ConfigName.TradeOrderDetail then
		self._orderDetail = content
	elseif name == ConfigName.TradeInfo then
		for k, v in pairs(content.dataList or {}) do
			if not self._info[v.type] then
				self._info[v.type] = {}
			end

			table.insert(self._info[v.type], v)
		end
	end
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg and cfg[key] then
		return cfg[key]
	end

	printError(string.format("could not found [%s] in [t_%s]", key, cfgName))

	return nil
end

function M:getTradeHouseConfigData()
	return self._house.dataList
end

function M:getHouseCoByLevel(level)
	return self._house[level]
end

function M:getConstCoByKey(key)
	return self._const[key]
end

function M:getOrderDetailById(id)
	return self._orderDetail[id]
end

function M:getTradeInfoLstByTyp(typ)
	return self._info[typ] or {}
end

function M:getSpeedUpItemTime()
	if not self._speedUpItemTime then
		self._speedUpItemTime = self:getConstCoByKey("OrderSpeedUpMinute").numValue
	end

	return self._speedUpItemTime
end

M.instance = M.New()

return M
