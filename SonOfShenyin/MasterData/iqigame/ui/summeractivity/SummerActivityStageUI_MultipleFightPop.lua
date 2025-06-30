-- chunkname: @IQIGame\\UI\\SummerActivity\\SummerActivityStageUI_MultipleFightPop.lua

local MultipleFightPopupView = require("IQIGame/UI/Chapter/MultipleFightPopupView")
local m = Clone(MultipleFightPopupView)

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:Show(chapterType, chapterCfg, dupPOD)
	LuaUtility.SetGameObjectShow(self.gameObject, true)

	self.chapterType = chapterType
	self.chapterConfig = chapterCfg

	local stageCost = 0
	local enterCost = 0

	stageCost = self.chapterConfig.PassCost ~= nil and self.chapterConfig.PassCost[2] or 0
	enterCost = self.chapterConfig.EnterCost ~= nil and self.chapterConfig.EnterCost[2] or 0
	self.unitCostPower = stageCost + enterCost
	self.freeCount = 0

	if dupPOD and dupPOD.costFree then
		self.freeCount = dupPOD.costFree
	end

	local playerPower = WarehouseModule.GetPlayerStrengthNum()

	self.fightCount = 1
	self.maxFightCount, _ = math.modf(playerPower / self.unitCostPower) + self.freeCount

	local cfgMaxCount = CfgDiscreteDataTable[115].Data[1]

	if chapterCfg.ChallengeCount and chapterCfg.ChallengeCount > 0 then
		cfgMaxCount = math.min(cfgMaxCount, chapterCfg.ChallengeCount)
	end

	if cfgMaxCount < self.maxFightCount then
		self.maxFightCount = cfgMaxCount
	end

	if self.maxFightCount <= self.fightCount then
		self.maxFightCount = self.fightCount + 1
	end

	self:__UpdateFightCount(self.fightCount)
end

return m
