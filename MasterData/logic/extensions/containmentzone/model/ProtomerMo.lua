-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/model/ProtomerMo.lua

module("logic.extensions.containmentzone.model.ProtomerMo", package.seeall)

local M = class("ProtomerMo")

function M:ctor()
	return
end

function M:updateFromServer(protomerData)
	self._protomerId = protomerData.protomerId
	self._pressure = protomerData.pressure
	self._productivity = protomerData.productivity
	self._touchWay = protomerData.touchWay
	self._billboard = protomerData.billboard
	self._level = protomerData.level
	self._researchPoint = protomerData.researchPoint
	self._modulePoint = protomerData.modulePoint
	self._upgradeModule = protomerData.upgradeModule
	self._intelligence = protomerData.intelligence
	self._roomId = protomerData.roomId or 0
	self._score = protomerData.score or 0
	self._scoreAdd = protomerData.scoreAdd or 0
	self._echoLevel = protomerData.echoLevel or 0

	self:_duelBillBoard()
	self:_duelUpgradeModule()
	self:_duelIntelligence()
end

function M:updateFromClient(protomerData)
	self._protomerId = protomerData:getProtomerId()
	self._pressure = protomerData:getPressure()
	self._productivity = protomerData:getProductivity()
	self._touchWay = protomerData:getTouchWay()
	self._billboard = protomerData:getBillBoard()
	self._level = protomerData:getLevel()
	self._researchPoint = protomerData:getResearchPoint()
	self._modulePoint = protomerData:getModulePoint()
	self._upgradeModule = protomerData:getUpgradeModule()
	self._intelligence = protomerData:getIntelligence()
	self._roomId = protomerData:getRoomId()
	self._score = protomerData:getScore()
	self._scoreAdd = protomerData:getScoreAdd()
	self._echoLevel = protomerData:getEchoLevel()

	self:_duelBillBoard()
	self:_duelUpgradeModule()
	self:_duelIntelligence()
	printWarn(string.format("<color=#009A61>原体[%d]信息更新</color>", self._protomerId))
end

function M:updateProtomerDiffIntelligence(intelligence)
	local binTable = self:decimal2bin(intelligence)

	if not self.unlockIntelligenceTable then
		self.unlockIntelligenceTable = {}
	end

	for i = 1, 32 do
		if binTable[i] == 1 then
			local id = 32 - i + 1

			self.unlockIntelligenceTable[id] = 1
		end
	end
end

function M:getRoomId()
	return self._roomId
end

function M:setRoomId(roomId)
	self._roomId = roomId
end

function M:getProtomerId()
	return self._protomerId
end

function M:getPressure()
	return self._pressure
end

function M:getPressureLimitCfgDefault()
	if self._presureLimitCfgDef then
		return self._presureLimitCfgDef
	end

	if self._cfgProtomer == nil then
		self._cfgProtomer = ContainmentConfig.instance:getProtomerCoById(self._protomerId)
	end

	self._presureLimitCfgDef = self._cfgProtomer.pressureRange[1]

	return self._presureLimitCfgDef
end

function M:getPressureLimitCfgMax()
	if self._presureLimitCfgMax then
		return self._presureLimitCfgMax
	end

	if self._cfgProtomer == nil then
		self._cfgProtomer = ContainmentConfig.instance:getProtomerCoById(self._protomerId)
	end

	self._presureLimitCfgMax = self._cfgProtomer.pressureRange[2]

	return self._presureLimitCfgMax
end

function M:getPressureLimitEnhance()
	return self._presureLimitEnhance
end

function M:getDmgManageLimitCfgDefault()
	if self._dmgManageLimitCfgDef then
		return self._dmgManageLimitCfgDef
	end

	if self._cfgProtomer == nil then
		self._cfgProtomer = ContainmentConfig.instance:getProtomerCoById(self._protomerId)
	end

	self._dmgManageLimitCfgDef = self._cfgProtomer.breakdownRange[1]

	return self._dmgManageLimitCfgDef
end

function M:getDmgManageLimitCfgMax()
	if self._dmgManageLimitCfgMax then
		return self._dmgManageLimitCfgMax
	end

	if self._cfgProtomer == nil then
		self._cfgProtomer = ContainmentConfig.instance:getProtomerCoById(self._protomerId)
	end

	self._dmgManageLimitCfgMax = self._cfgProtomer.breakdownRange[2]

	return self._dmgManageLimitCfgMax
end

function M:getDmgManageLimitEnhance()
	return self._dmgManageLimitEnhance
end

function M:getEchoEffLimitCfgDefault()
	if self._echoEffLimitCfgDef then
		return self._echoEffLimitCfgDef
	end

	if self._cfgProtomer == nil then
		self._cfgProtomer = ContainmentConfig.instance:getProtomerCoById(self._protomerId)
	end

	self._echoEffLimitCfgDef = self._cfgProtomer.echoRange[1]

	return self._echoEffLimitCfgDef
end

function M:getEchoEffLimitCfgMax()
	if self._echoEffLimitCfgMax then
		return self._echoEffLimitCfgMax
	end

	if self._cfgProtomer == nil then
		self._cfgProtomer = ContainmentConfig.instance:getProtomerCoById(self._protomerId)
	end

	self._echoEffLimitCfgMax = self._cfgProtomer.echoRange[2]

	return self._echoEffLimitCfgMax
end

function M:getEchoEffLimitEnhance()
	return self._echoEffLimitEnhance
end

function M:getProductivity()
	return self._productivity
end

function M:getCfgProductivity()
	if self._productivityCfg then
		return self._productivityCfg
	end

	if self._cfgProtomer == nil then
		self._cfgProtomer = ContainmentConfig.instance:getProtomerCoById(self._protomerId)
	end

	self._productivityCfg = self._cfgProtomer.productivity

	return self._productivityCfg
end

function M:getTouchWay()
	return self._touchWay
end

function M:getBillBoard()
	return self._billboard
end

function M:setBillBoard(value)
	self._billboard = checknumber(value)
end

function M:getBillBoardBin()
	return self:byte2bin(self._billboard)
end

function M:getLevel()
	return self._level
end

function M:getResearchPoint()
	return self._researchPoint
end

function M:getResearchProcess()
	local nowlevel = self:getLevel()
	local nowResearchPoint = self:getResearchPoint()

	return self:getResearchProcessByData(nowlevel, nowResearchPoint)
end

function M:getResearchProcessByData(nowlevel, nowResearchPoint)
	if self._cfgProtomer == nil then
		self._cfgProtomer = ContainmentConfig.instance:getProtomerCoById(self._protomerId)
	end

	local researchPlanCode = self._cfgProtomer.research
	local cfgResearch = ContainmentConfig.instance:getHouseResearchCoByCodeAndLv(researchPlanCode, nowlevel)
	local needPoint = cfgResearch.point

	if nowlevel - 1 > 0 then
		local cfgPre = ContainmentConfig.instance:getHouseResearchCoByCodeAndLv(researchPlanCode, nowlevel - 1)

		needPoint = needPoint - cfgPre.point
		nowResearchPoint = nowResearchPoint - cfgPre.point
	end

	local isMaxLv = ContainmentConfig.instance:getHouseResearchCoByCodeAndLv(researchPlanCode, nowlevel + 1) == nil

	if isMaxLv then
		needPoint = 0
	end

	return nowResearchPoint, needPoint
end

function M:getProtomerCfgResearchCode()
	if self._cfgProtomer == nil then
		self._cfgProtomer = ContainmentConfig.instance:getProtomerCoById(self._protomerId)
	end

	return self._cfgProtomer.research
end

function M:setModulePoint(val)
	self._modulePoint = val
end

function M:getModulePoint()
	return self._modulePoint
end

function M:setUpgradeModule(val)
	self._upgradeModule = val
end

function M:getUpgradeModule()
	return self._upgradeModule
end

function M:getUpgradeModuleBin()
	return self:decimal2bin(self._upgradeModule)
end

function M:getUpgradeModuleTable()
	return self.upgradeModuleTable
end

function M:getIsModuleUpGrade(moduleId)
	if moduleId == 0 then
		return true
	end

	return self.upgradeModuleIdMap[moduleId] ~= nil
end

function M:getModuleUpGradeCount()
	local count = 1

	if self.upgradeModuleIdMap then
		for key, value in pairs(self.upgradeModuleIdMap or {}) do
			count = count + 1
		end
	end

	return count
end

function M:hasModuleCanUpGrade(modulePoint)
	local canUpgradeModuleIdLst = {}

	if self._cfgProtomer == nil then
		self._cfgProtomer = ContainmentConfig.instance:getProtomerCoById(self._protomerId)
	end

	local mCfg = ContainmentConfig.instance:getHouseModelCoLstByCode(self._cfgProtomer.module)

	for moduleId, mData in pairs(mCfg or {}) do
		if not self:getIsModuleUpGrade(moduleId) then
			local needModulePoint = mData.modulePoint or 0

			if needModulePoint <= modulePoint then
				local prePass = true
				local resEnough = false

				for _, pMId in ipairs(mData.preModule or {}) do
					if not self:getIsModuleUpGrade(pMId) then
						prePass = false
					end
				end

				if prePass then
					resEnough = true

					for _, item in pairs(mData.cost or {}) do
						local nowCount = ItemModel.instance:getItemCountByItemId(item.id)

						if nowCount < item.num then
							resEnough = false
						end
					end
				end

				if prePass and resEnough then
					table.insert(canUpgradeModuleIdLst, moduleId)
				end
			end
		end
	end

	return canUpgradeModuleIdLst
end

function M:_duelUpgradeModule()
	local binTable = self:decimal2bin(self._upgradeModule)

	self.upgradeModuleTable = {}
	self.upgradeModuleIdMap = {}

	local index = 1

	for i = 1, 32 do
		if binTable[i] == 1 then
			self.upgradeModuleTable[index] = i
			index = index + 1
		end
	end

	self._presureLimitEnhance = self:getPressureLimitCfgDefault()
	self._dmgManageLimitEnhance = self:getDmgManageLimitCfgDefault()
	self._echoEffLimitEnhance = self:getEchoEffLimitCfgDefault()

	if #self.upgradeModuleTable > 0 then
		if self._cfgProtomer == nil then
			self._cfgProtomer = ContainmentConfig.instance:getProtomerCoById(self._protomerId)
		end

		for _, value in ipairs(self.upgradeModuleTable) do
			local moduleId = 32 - value + 1

			self.upgradeModuleIdMap[moduleId] = 1

			local mCfg = ContainmentConfig.instance:getHouseModelCoByCodeAndModule(self._cfgProtomer.module, moduleId)

			self._presureLimitEnhance = ContainmentUtil.moduleEnhanceFunc(self._presureLimitEnhance, ContainmentEnum.ModuleEnhanceEffId.PresureMaxUpGrade, mCfg.effect1, mCfg.param1)
			self._presureLimitEnhance = ContainmentUtil.moduleEnhanceFunc(self._presureLimitEnhance, ContainmentEnum.ModuleEnhanceEffId.PresureMaxUpGrade, mCfg.effect2, mCfg.param2)

			if self._presureLimitEnhance > self:getPressureLimitCfgMax() then
				printError(string.format("原体[%d]强化后[压力上限值]为[%d] > 配置上限[%d]，请检查参数", self._protomerId, self._presureLimitEnhance, self:getPressureLimitCfgMax()))
			end

			self._dmgManageLimitEnhance = ContainmentUtil.moduleEnhanceFunc(self._dmgManageLimitEnhance, ContainmentEnum.ModuleEnhanceEffId.DmgManageMaxUpGrade, mCfg.effect1, mCfg.param1)
			self._dmgManageLimitEnhance = ContainmentUtil.moduleEnhanceFunc(self._dmgManageLimitEnhance, ContainmentEnum.ModuleEnhanceEffId.DmgManageMaxUpGrade, mCfg.effect2, mCfg.param2)

			if self._dmgManageLimitEnhance > self:getEchoEffLimitCfgMax() then
				printError(string.format("原体[%d]强化后[损害管理等级]为[%d] > 配置上限[%d]，请检查参数", self._protomerId, self._dmgManageLimitEnhance, self:getEchoEffLimitCfgMax()))
			end

			self._echoEffLimitEnhance = ContainmentUtil.moduleEnhanceFunc(self._echoEffLimitEnhance, ContainmentEnum.ModuleEnhanceEffId.EchoEffMaxUpGrade, mCfg.effect1, mCfg.param1)
			self._echoEffLimitEnhance = ContainmentUtil.moduleEnhanceFunc(self._echoEffLimitEnhance, ContainmentEnum.ModuleEnhanceEffId.EchoEffMaxUpGrade, mCfg.effect2, mCfg.param2)

			if self._echoEffLimitEnhance > self:getEchoEffLimitCfgMax() then
				printError(string.format("原体[%d]强化后[损害管理等级]为[%d] > 配置上限[%d]，请检查参数", self._protomerId, self._echoEffLimitEnhance, self:getEchoEffLimitCfgMax()))
			end
		end
	end
end

function M:getIntelligence()
	return self._intelligence
end

function M:getIntelligenceBin()
	return self:decimal2bin(self._intelligence)
end

function M:_duelIntelligence()
	local binTable = self:getIntelligenceBin()

	self.unlockIntelligenceTable = {}

	for i = 1, 32 do
		if binTable[i] == 1 then
			local id = 32 - i + 1

			self.unlockIntelligenceTable[id] = 1
		end
	end
end

function M:getIntelligenceUnlockTable()
	return self.unlockIntelligenceTable
end

function M:isIntelligenceUnlock(id)
	return self.unlockIntelligenceTable[id] ~= nil
end

function M:_duelBillBoard()
	local binTable = self:decimal2bin(self._billboard)

	self.billBoardChoiceTable = {}

	local index = 1

	for i = 1, 32 do
		if binTable[i] == 1 then
			self.billBoardChoiceTable[index] = i
			index = index + 1
		end
	end
end

function M:getBillBoardActiveTable()
	return self.billBoardChoiceTable
end

function M:getBillBoardActiveTableFake()
	local tr = {}

	tr[1] = 23
	tr[2] = 24

	return tr
end

function M:getProtomerName()
	if self._protomerName then
		return self._protomerName
	end

	self._protomerName = ContainmentUtil.getProtomerName(self._protomerId)

	return self._protomerName
end

function M:getProtomerIcon()
	if self._protomerIcon then
		return self._protomerIcon
	end

	if self._cfgBackPack == nil then
		self._cfgBackPack = ContainmentConfig.instance:getProtomerBackpackCfg(self._protomerId)
	end

	self._protomerIcon = self._cfgBackPack.icon

	return self._protomerIcon
end

function M:getProtomerDesc()
	if self._protomerDesc then
		return self._protomerDesc
	end

	if self._cfgBackPack == nil then
		self._cfgBackPack = ContainmentConfig.instance:getProtomerBackpackCfg(self._protomerId)
	end

	self._protomerDesc = self._cfgBackPack.desc

	return self._protomerDesc
end

function M:getProtomerUseDesc()
	if self._protomerUseDesc then
		return self._protomerUseDesc
	end

	if self._cfgBackPack == nil then
		self._cfgBackPack = ContainmentConfig.instance:getProtomerBackpackCfg(self._protomerId)
	end

	self._protomerUseDesc = self._cfgBackPack.useDesc

	return self._protomerUseDesc
end

function M:getProtomerSerialNumShow()
	if self._protomerSerialNumStr then
		return self._protomerSerialNumStr
	end

	self._protomerSerialNumStr = ContainmentUtil.getProtomerSerialNumShow(self._protomerId)

	return self._protomerSerialNumStr
end

function M:getCfgInfo()
	if self._cfgInfo == nil then
		self._cfgInfo = ContainmentConfig.instance:getProtomerInfoById(self._protomerId)
	end

	return self._cfgInfo
end

function M:getProtomerCfgUnlockCode()
	local cfgInfo = self:getCfgInfo()

	return cfgInfo.unlock
end

function M:getProtomerPrototypeTableLst()
	if self._protomerPrototypeTable then
		return self._protomerPrototypeTable
	end

	self._protomerPrototypeTable = ContainmentConfig.instance:getProtomerPrototypeCoLstByProtomerId(self._protomerId)

	return self._protomerPrototypeTable
end

function M:decimal2bin(n)
	return ContainmentModel.instance:decimal2bin(n)
end

function M:getScore()
	return self._score
end

function M:getScoreAdd()
	return self._scoreAdd
end

function M:getEchoLevel()
	return self._echoLevel
end

function M:getHoldEfficient()
	if not self._maxEvaluateKey then
		if self._cfgProtomer == nil then
			self._cfgProtomer = ContainmentConfig.instance:getProtomerCoById(self._protomerId)
		end

		local cfgLst = ContainmentConfig.instance:getEvaluateLst(self._cfgProtomer.evaluate)

		self._maxEvaluateKey = cfgLst[1].key
	end

	local value = math.floor(self:getScoreAdd() * 10 / self._maxEvaluateKey * 6)

	return value
end

function M:getReportEvaluatePredict()
	if not self._reportEvaluatePredict then
		self._reportEvaluatePredict = {}
	end

	local FullEvaluateSchedule = ContainmentConfig.instance:getConstByKey("FullEvaluateSchedule")
	local remainCount = math.min(self:getProductivity() / (self:getCfgProductivity() / FullEvaluateSchedule), FullEvaluateSchedule)

	remainCount = FullEvaluateSchedule - math.floor(remainCount)

	local predictScore = self:getScore() + remainCount * self:getScoreAdd()

	if self._cfgProtomer == nil then
		self._cfgProtomer = ContainmentConfig.instance:getProtomerCoById(self._protomerId)
	end

	local cfgLst = ContainmentConfig.instance:getEvaluateLst(self._cfgProtomer.evaluate)
	local finalCfg

	for index, cfg in ipairs(cfgLst) do
		if predictScore >= cfg.key then
			finalCfg = cfg

			break
		end
	end

	local totalWeight = finalCfg.s + finalCfg.a + finalCfg.b + finalCfg.c

	self._reportEvaluatePredict[2] = math.floor(finalCfg.b / totalWeight * 1000) / 10
	self._reportEvaluatePredict[3] = math.floor(finalCfg.a / totalWeight * 1000) / 10
	self._reportEvaluatePredict[4] = math.floor(finalCfg.s / totalWeight * 1000) / 10
	self._reportEvaluatePredict[1] = 100 - self._reportEvaluatePredict[2] - self._reportEvaluatePredict[3] - self._reportEvaluatePredict[4]

	return self._reportEvaluatePredict
end

return M
