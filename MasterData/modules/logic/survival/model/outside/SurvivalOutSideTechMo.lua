-- chunkname: @modules/logic/survival/model/outside/SurvivalOutSideTechMo.lua

module("modules.logic.survival.model.outside.SurvivalOutSideTechMo", package.seeall)

local SurvivalOutSideTechMo = pureTable("SurvivalOutSideTechMo")

function SurvivalOutSideTechMo:ctor()
	self.techDic = {}
end

function SurvivalOutSideTechMo:setData(outSideTechBox)
	tabletool.clear(self.techDic)

	for i, v in ipairs(outSideTechBox.techs) do
		self.techDic[v.belongRoleId] = v
	end

	self:refreshRedPoint()
end

function SurvivalOutSideTechMo:onReceiveSurvivalOutSideTechUnlockReply(msg)
	local belongRoleId = msg.techInfo.belongRoleId

	self.techDic[belongRoleId] = msg.techInfo

	self:refreshRedPoint()
end

function SurvivalOutSideTechMo:onReceiveSurvivalOutSideTechResetReply(msg)
	local belongRoleId = msg.techInfo.belongRoleId

	self.techDic[belongRoleId] = msg.techInfo

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTechChange)
	self:refreshRedPoint()
end

function SurvivalOutSideTechMo:refreshRedPoint()
	local redDotInfoList = {}
	local num = 0
	local list = SurvivalTechConfig.instance:getTechTabList()

	for i, info in ipairs(list) do
		local techId = info.belongRole
		local canUp = self:haveCanUp(techId)

		if canUp then
			num = 1

			break
		end
	end

	table.insert(redDotInfoList, {
		id = RedDotEnum.DotNode.SurvivalOutSideTeach,
		value = num
	})
	RedDotRpc.instance:clientAddRedDotGroupList(redDotInfoList, true)
end

function SurvivalOutSideTechMo:getTechPoint(techId)
	local survivalOutSideTech = self.techDic[techId]

	if survivalOutSideTech then
		return survivalOutSideTech.techPoint
	end

	return 0
end

function SurvivalOutSideTechMo:haveTechPoint()
	for i, v in pairs(self.techDic) do
		if v.techPoint > 0 then
			return true
		end
	end
end

function SurvivalOutSideTechMo:haveFinish(techId)
	local survivalOutSideTech = self.techDic[techId]

	if survivalOutSideTech and #survivalOutSideTech.techId > 0 then
		return true
	end
end

function SurvivalOutSideTechMo:haveCanUp(techId)
	local techList = SurvivalTechConfig.instance:getTechList(techId)

	if techList then
		for i, cfg in ipairs(techList) do
			local isCanUp = self:isCanUp(techId, cfg.id)

			if isCanUp then
				return true
			end
		end
	end
end

function SurvivalOutSideTechMo:isFinish(techId, teachCellId)
	local survivalOutSideTech = self.techDic[techId]

	if survivalOutSideTech then
		local list = survivalOutSideTech.techId

		for i, id in ipairs(list) do
			if id == teachCellId then
				return true
			end
		end
	end
end

function SurvivalOutSideTechMo:isCanUp(techId, teachCellId)
	local isFinish = self:isFinish(techId, teachCellId)

	if isFinish then
		return false
	end

	if not self:isPreNodeSatisfy(teachCellId) then
		return false
	end

	return self:isTechPointSatisfy(techId, teachCellId)
end

function SurvivalOutSideTechMo:isPreNodeSatisfy(teachCellId)
	local cfg = lua_survival_outside_tech.configDict[teachCellId]

	if not string.nilorempty(cfg.preNodes) then
		local ids = string.splitToNumber(cfg.preNodes, "#")

		for i, id in ipairs(ids) do
			if not self:isFinish(cfg.belongRole, id) then
				return false
			end
		end
	end

	return true
end

function SurvivalOutSideTechMo:isTechPointSatisfy(techId, teachCellId)
	local cfg = lua_survival_outside_tech.configDict[teachCellId]
	local survivalOutSideTech = self.techDic[techId]

	if survivalOutSideTech then
		return survivalOutSideTech.techPoint >= cfg.cost
	end
end

return SurvivalOutSideTechMo
