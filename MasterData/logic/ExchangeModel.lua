-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchange/model/ExchangeModel.lua

module("logic.extensions.exchange.model.ExchangeModel", package.seeall)

local ExchangeModel = class("ExchangeModel", BaseModel)

ExchangeModel.TAB_FAMILY = 1
ExchangeModel.TAB_ARENA = 2
ExchangeModel.TAB_PAIWEI = 3
ExchangeModel.TAB_TIMEWHEEL = 4
ExchangeModel.TAB_XIAONUOBIAN = 5
ExchangeModel.TAB_LEGEND = 6
ExchangeModel.TAB_EXPEDITION = 7
ExchangeModel.TAB_RUNE = 8

function ExchangeModel:ctor()
	ExchangeModel.super.ctor(self)
end

function ExchangeModel:onInit()
	self:onReset()
end

function ExchangeModel:onReset()
	self:resetInited()
end

function ExchangeModel:resetInited()
	self.tabItemsPool = {}
	self._jumpPageTabTypes = false
	self._tabIds = {}
end

function ExchangeModel:setTabItems(tabId, tabInfo)
	self.tabItemsPool[tabId] = self.tabItemsPool[tabId] or {}

	local info = ExchangeTabInfoMo.New(tabId)

	info:setData(tabInfo)

	self.tabItemsPool[tabId] = info
end

function ExchangeModel:getTabItems(tabId)
	return self.tabItemsPool[tabId]
end

function ExchangeModel:setTabItemHasExchagne(tabId, posId, num)
	local info = self.tabItemsPool[tabId]

	if info then
		info:addHasExchange(posId, num)

		self.tabItemsPool[tabId] = info
	end
end

function ExchangeModel:recordJumpPageParam(jumpPageTabTypes)
	self._jumpPageTabTypes = jumpPageTabTypes
end

function ExchangeModel:getJumpPageParam()
	return self._jumpPageTabTypes
end

function ExchangeModel:getLevel1TabCfgs()
	local tempCfgs = ExchangeConfig.instance:getLevel1TabCfgs()
	local data = {}

	for i, v in ipairs(tempCfgs) do
		local isPass = self:_checkLevel1TabOpen(v.type)

		if isPass then
			table.insert(data, v)
		end
	end

	table.sort(data, function(a, b)
		return a.rank < b.rank
	end)

	return data
end

function ExchangeModel:getLevel2TabCfgs(typeId)
	local data = {}
	local level2TabCfgs = ExchangeConfig.instance:getLevel2TabCfgs(typeId)

	if level2TabCfgs then
		for k, v in pairs(level2TabCfgs) do
			isOpen = self:_checkLevel2TabOpen(typeId, v.id) and self:_checkConditionHandlerParams(v.param)

			if isOpen then
				table.insert(data, v)
			end
		end
	end

	table.sort(data, function(a, b)
		return a.rank < b.rank
	end)

	return data
end

function ExchangeModel:getLevel3TabCfgs(typeId, leve2Id)
	local data = {}
	local level3TabCfgs = ExchangeConfig.instance:getLevel3TabCfgs(typeId, leve2Id)

	if level3TabCfgs then
		for k, v in pairs(level3TabCfgs) do
			isOpen = self:_checkLevel3TabOpen(typeId, leve2Id, v.id) and self:_checkConditionHandlerParams(v.param)

			if isOpen then
				table.insert(data, v)
			end
		end
	end

	table.sort(data, function(a, b)
		return a.rank < b.rank
	end)

	return data
end

function ExchangeModel:_checkLevel1TabOpen(typeId)
	local cfg = ExchangeConfig.instance:getLevel1TabCfg(typeId)
	local isOpen = self:_checkOneTabCfgCommonCondition(cfg)

	if isOpen then
		local level2TabCfgs = ExchangeConfig.instance:getLevel2TabCfgs(typeId)

		if level2TabCfgs then
			for k, v in pairs(level2TabCfgs) do
				isOpen = self:_checkLevel2TabOpen(typeId, v.id)

				if isOpen then
					break
				end
			end
		end
	end

	return isOpen
end

function ExchangeModel:_checkLevel2TabOpen(typeId, id)
	local cfg = ExchangeConfig.instance:getLevel2TabCfg(typeId, id)
	local isOpen = self:_checkOneTabCfgCommonCondition(cfg)

	if isOpen then
		local level3TabCfgs = ExchangeConfig.instance:getLevel3TabCfgs(typeId, id)

		if level3TabCfgs then
			for k, v in pairs(level3TabCfgs) do
				isOpen = self:_checkLevel3TabOpen(typeId, id, v.id)

				if isOpen then
					break
				end
			end
		end
	end

	return isOpen
end

function ExchangeModel:_checkLevel3TabOpen(typeId, leve2Id, id)
	local cfg = ExchangeConfig.instance:getLevel3TabCfg(typeId, leve2Id, id)

	return (self:_checkOneTabCfgCommonCondition(cfg))
end

function ExchangeModel:_checkTabCfgCommonCondition(cfgs)
	local data = {}

	for i, cfg in pairs(cfgs) do
		local isPass = self:_checkOneTabCfgCommonCondition(cfg)

		if isPass then
			table.insert(data, cfg)
		end
	end

	return data
end

function ExchangeModel:_checkOneTabCfgCommonCondition(cfg, ignorePreview)
	local isPass = false
	local isFuncOpen = cfg.funcId <= 0 or FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)

	if cfg.funcId == 93 then
		local fcfg = FuncOpenConfig.instance:getFunctionOpenById(cfg.funcId)

		isFuncOpen = FuncOpenController.instance:getConditionReached(fcfg.openCondition, fcfg.openTime) and FuncOpenController.instance:getTimeReached(fcfg.activityType)
	end

	if isFuncOpen and cfg.funcId > 0 and cfg.funcId == GameEnum.FuncType.Family then
		isFuncOpen = FamilyController.instance:getFamilyLv() > 0
	end

	local isTabCabPreview = not ignorePreview and cfg.preview

	if isFuncOpen or isTabCabPreview then
		if string.nilorempty(cfg.startTime) and string.nilorempty(cfg.endTime) and true or GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) then
			if cfg.activityType <= 0 then
				isPass = true
			else
				local isActivityOpen = FuncOpenController.instance:getTimeReached(cfg.activityType, cfg.activityIds)

				if isActivityOpen then
					isPass = true
				end
			end
		end
	end

	if isPass and not isTabCabPreview then
		isPass = self:_checkTabOpSpecialCondition(isPass, cfg.checkOpParam)
	end

	return isPass
end

function ExchangeModel:_checkTabOpSpecialCondition(isPass, checkOpParam)
	if isPass and not string.nilorempty(checkOpParam) then
		if string.find(checkOpParam, "challengeCardOffLine") then
			local isOffline = self:_checkMonthcardOffline(4)

			isPass = not isOffline
		elseif string.find(checkOpParam, "mengxinCardOffLine") then
			local isOffline = self:_checkMonthcardOffline(5)

			isPass = not isOffline
		end
	end

	return isPass
end

function ExchangeModel:_checkConditionHandlerParams(tabId)
	if #self._tabIds > 0 then
		for _, v in pairs(self._tabIds) do
			if checknumber(tabId) == v then
				return true
			end
		end
	end

	return false
end

function ExchangeModel:setAllOpenedTabIds(tabIds)
	self._tabIds = tabIds
end

ExchangeModel.instance = ExchangeModel.New()

return ExchangeModel
