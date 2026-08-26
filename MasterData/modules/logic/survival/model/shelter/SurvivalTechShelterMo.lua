-- chunkname: @modules/logic/survival/model/shelter/SurvivalTechShelterMo.lua

module("modules.logic.survival.model.shelter.SurvivalTechShelterMo", package.seeall)

local SurvivalTechShelterMo = pureTable("SurvivalTechShelterMo")

function SurvivalTechShelterMo:setData(insideTechProp)
	self.insideTechProp = insideTechProp
	self.techIds = insideTechProp.techIds

	self:refreshRedDot()
end

function SurvivalTechShelterMo:onReceiveSurvivalUnlockInsideTechReply(msg)
	table.insert(self.techIds, msg.id)
	self:refreshRedDot()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnReceiveSurvivalUnlockInsideTechReply, msg)
end

function SurvivalTechShelterMo:refreshRedDot()
	local redDotType = RedDotEnum.DotNode.SurvivalTeach
	local redDotInfoList = {}
	local techList = SurvivalTechConfig.instance:getInsideTechList()
	local redDotNum = 0

	for i, cfg in ipairs(techList) do
		if self:isCanUp(cfg.id) then
			redDotNum = 1

			break
		end
	end

	table.insert(redDotInfoList, {
		id = redDotType,
		value = redDotNum
	})
	RedDotRpc.instance:clientAddRedDotGroupList(redDotInfoList, true)
end

function SurvivalTechShelterMo:getTeachPoint()
	local itemId = SurvivalEnum.CurrencyType.Gold
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	return (weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):getItemCountPlus(itemId))
end

function SurvivalTechShelterMo:getCost(teachCellId)
	return SurvivalTechConfig.instance:getTechInsideCost(teachCellId)
end

function SurvivalTechShelterMo:isFinish(teachCellId)
	if self.techIds then
		for i, id in ipairs(self.techIds) do
			if id == teachCellId then
				return true
			end
		end
	end
end

function SurvivalTechShelterMo:isCanUp(teachCellId)
	if self:isFinish(teachCellId) then
		return false
	end

	if not self:isLevelSatisfy(teachCellId) then
		return false
	end

	if not self:isPreNodeSatisfy(teachCellId) then
		return false
	end

	return self:isTechPointSatisfy(teachCellId)
end

function SurvivalTechShelterMo:isLevelSatisfy(teachCellId)
	local cfg = lua_survival_inside_tech.configDict[teachCellId]
	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo

	return survivalShelterRoleMo.level >= cfg.needLv, cfg.needLv
end

function SurvivalTechShelterMo:isPreNodeSatisfy(teachCellId)
	local cfg = lua_survival_inside_tech.configDict[teachCellId]

	if not string.nilorempty(cfg.preNodes) then
		local ids = string.splitToNumber(cfg.preNodes, "#")

		for i, id in ipairs(ids) do
			if not self:isFinish(id) then
				return false
			end
		end
	end

	return true
end

function SurvivalTechShelterMo:isTechPointSatisfy(teachCellId)
	local cost = self:getCost(teachCellId)

	return cost <= self:getTeachPoint()
end

return SurvivalTechShelterMo
