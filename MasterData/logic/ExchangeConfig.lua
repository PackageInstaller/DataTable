-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchange/config/ExchangeConfig.lua

module("logic.extensions.exchange.config.ExchangeConfig", package.seeall)

local ExchangeConfig = class("ExchangeConfig", BaseConfig)

function ExchangeConfig:onInit()
	ExchangeConfig.super.onInit(self)

	self._easyJumpParams = {}
	self._tabConfigFinishCount = 0
end

function ExchangeConfig:getNames()
	return {
		"exchange_tab",
		"exchange_reset",
		"exchange_commodity",
		"exchange_level1tab_define",
		"exchange_level2tab_define",
		"exchange_level3tab_define",
		"exchange_plan"
	}
end

function ExchangeConfig:handleConfig(name, content)
	if name == "exchange_tab" then
		self.exchangeTabCfg = content
	elseif name == "exchange_reset" then
		self.exchangeResetCfg = content
	elseif name == "exchange_commodity" then
		self.exchangeCommodityCfg = content

		self:_handleCommodity(content.dataList)
	elseif name == "exchange_level1tab_define" then
		self._exchange_level1tab_define = content

		self:_tabConfigLoaded(1, content.dataList)
	elseif name == "exchange_level2tab_define" then
		self._exchange_level2tab_define = content

		self:_tabConfigLoaded(2, content.dataList)
	elseif name == "exchange_level3tab_define" then
		self._exchange_level3tab_define = content

		self:_tabConfigLoaded(3, content.dataList)
	elseif name == "exchange_plan" then
		self._exchange_plan = content

		self:_handleExchangePlan(content.dataList)
	end
end

function ExchangeConfig:getAllTab()
	return self.exchangeTabCfg.dataList
end

function ExchangeConfig:getTabById(id)
	return self.exchangeTabCfg[id]
end

function ExchangeConfig:getItemById(commodityId)
	return self.exchangeCommodityCfg[commodityId]
end

function ExchangeConfig:getResetTotalCount(tabId)
	local cfg = self:getTabById(tabId)

	return #self.exchangeResetCfg[cfg.resetProgram]
end

function ExchangeConfig:getCostByTimes(tabId, times)
	local cfg = self:getTabById(tabId)

	return self.exchangeResetCfg[cfg.resetProgram][times]
end

function ExchangeConfig:_setEaseJumpParam(tabType, jumpInTag, errorKey, level1Id, level2Id, level3Id)
	if not string.nilorempty(jumpInTag) then
		if self._easyJumpParams[jumpInTag] then
			local content = string.format("jumpInTag重复了：%s 当前类型：%s 当前id：%s ,冲突类型：%s 冲突id：%s", jumpInTag, tabType, errorKey, self._easyJumpParams[jumpInTag].tabType, self._easyJumpParams[jumpInTag].errorKey)

			printError(content)
		else
			self._easyJumpParams[jumpInTag] = {
				tabType = tabType,
				errorKey = errorKey,
				jumpParam = {
					level1Id,
					level2Id,
					level3Id
				}
			}
		end
	end
end

function ExchangeConfig:_tabConfigLoaded(tabType, dataList)
	self._tabConfigFinishCount = self._tabConfigFinishCount + 1

	if self._tabConfigFinishCount == 3 then
		local lv1cfgs = self:getLevel1TabCfgs()

		for _, lv1 in pairs(lv1cfgs) do
			self:_setEaseJumpParam(1, lv1.jumpInTag, lv1.type, false, false)

			local lv2cfgs = self:getLevel2TabCfgs(lv1.type)

			if lv2cfgs then
				for _, lv2 in pairs(lv2cfgs) do
					self:_setEaseJumpParam(2, lv2.jumpInTag, lv1.type .. "@" .. lv2.id, lv1.type, lv2.id, false)

					local lv3cfgs = self:getLevel3TabCfgs(lv1.type, lv2.id)

					if lv3cfgs then
						for _, lv3 in pairs(lv3cfgs) do
							self:_setEaseJumpParam(3, lv3.jumpInTag, lv1.type .. "@" .. lv2.id .. "@" .. lv3.id, lv1.type, lv2.id, lv3.id)
						end
					end
				end
			end
		end
	end
end

function ExchangeConfig:getJumpInParam(jumpInTag)
	if self._easyJumpParams[jumpInTag] then
		if enableDebug and not self._easyJumpParams[jumpInTag] then
			printError(string.format("缺少%s跳转配置", jumpInTag))
		end

		return self._easyJumpParams[jumpInTag]
	end
end

function ExchangeConfig:getLevel1TabCfgs()
	if not self._bottomTabCfgs then
		self._bottomTabCfgs = {}

		for k, v in ipairs(self._exchange_level1tab_define.dataList) do
			table.insert(self._bottomTabCfgs, v)
		end

		table.sort(self._bottomTabCfgs, function(a, b)
			return a.rank < b.rank
		end)
	end

	return self._bottomTabCfgs
end

function ExchangeConfig:getLevel1TabCfg(typeId)
	return self._exchange_level1tab_define[typeId]
end

function ExchangeConfig:getLevel2TabCfgs(typeId)
	return self._exchange_level2tab_define[typeId]
end

function ExchangeConfig:getLevel2TabCfg(typeId, id)
	return self._exchange_level2tab_define[typeId][id]
end

function ExchangeConfig:getLevel3TabCfgs(typeId, id)
	if self._exchange_level3tab_define[typeId] then
		return self._exchange_level3tab_define[typeId][id]
	else
		return nil
	end
end

function ExchangeConfig:getLevel3TabCfg(typeId, level2Id, id)
	return self._exchange_level3tab_define[typeId][level2Id][id]
end

function ExchangeConfig:getJumpPageCfgs()
	return {}
end

function ExchangeConfig:getJumpPageCfg(id)
	return false
end

function ExchangeConfig:_handleExchangePlan(dataList)
	self._exchange_plan_fundIdKey = {}
	self._commodityProgramKey = {}

	for i, v in ipairs(dataList) do
		self._exchange_plan_fundIdKey[v.funId] = self._exchange_plan_fundIdKey[v.funId] or {}

		table.insert(self._exchange_plan_fundIdKey[v.funId], v)

		self._commodityProgramKey[v.commodityProgram] = v
	end
end

function ExchangeConfig:_handleCommodity(dataList)
	self._exchage_commodity_commodityProgramIdkey = {}

	for i, v in ipairs(dataList) do
		self._exchage_commodity_commodityProgramIdkey[v.commodityProgramId] = self._exchage_commodity_commodityProgramIdkey[v.commodityProgramId] or {}

		table.insert(self._exchage_commodity_commodityProgramIdkey[v.commodityProgramId], v)
	end
end

function ExchangeConfig:getCommodityIdsByTabId(tabId)
	local commodityIds = {}
	local cfgs = self._exchange_plan_fundIdKey[tabId]

	for i, v in ipairs(cfgs) do
		local ccfgs = self._exchage_commodity_commodityProgramIdkey[v.commodityProgram]

		for i, v in ipairs(ccfgs) do
			table.insert(commodityIds, v.id)
		end
	end

	return commodityIds
end

function ExchangeConfig:getPlanCfgByCommodityProgram(commodityProgram)
	return self._commodityProgramKey[commodityProgram]
end

ExchangeConfig.instance = ExchangeConfig.New()

return ExchangeConfig
