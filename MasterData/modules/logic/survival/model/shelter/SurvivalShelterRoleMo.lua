-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterRoleMo.lua

module("modules.logic.survival.model.shelter.SurvivalShelterRoleMo", package.seeall)

local SurvivalShelterRoleMo = pureTable("SurvivalShelterRoleMo")

function SurvivalShelterRoleMo:setRoleData(roleId, roleExp)
	self.roleId = roleId

	if self:haveRole() then
		self.roleExp = roleExp
		self.level = SurvivalRoleConfig.instance:getLevelByExp(roleExp)
		self.roleDispositionType = lua_survival_role.configDict[self.roleId].dispositionType
	else
		self.roleExp = nil
		self.level = nil
		self.roleDispositionType = nil
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRoleDateChange)

	local survivalOutSideRoleModel = SurvivalModel.instance:getOutSideInfo().survivalOutSideRoleMo

	survivalOutSideRoleModel:markSelectRole(self.roleId)
end

function SurvivalShelterRoleMo:setExp(exp)
	self.roleExp = exp
	self.level = SurvivalRoleConfig.instance:getLevelByExp(self.roleExp)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRoleDateChange)

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local survivalShelterBuildingMo = weekInfo:getTechBuild()

	survivalShelterBuildingMo.survivalTechShelterMo:refreshRedDot()
end

function SurvivalShelterRoleMo:haveRole()
	return self.roleId and self.roleId > 0
end

function SurvivalShelterRoleMo:getRoleAttrValue(attrId, level)
	if level == nil then
		level = self.level
	end

	local cfg = lua_survival_role.configDict[self.roleId]

	return SurvivalRoleConfig.instance:getRoleAttrValue(cfg.dispositionType, level, attrId)
end

function SurvivalShelterRoleMo:haveAttrIncrease(attrId, oldLevel, curLevel)
	if curLevel <= 1 then
		return false
	end

	local old = self:getRoleAttrValue(attrId, oldLevel)
	local new = self:getRoleAttrValue(attrId, curLevel)

	if new ~= old then
		return true, old, new
	end
end

function SurvivalShelterRoleMo:getRoleModelRes()
	local res = SurvivalRoleConfig.instance:getRoleModelRes(self.roleId)

	if not string.nilorempty(res) then
		return res
	end

	return SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.PlayerRes)
end

function SurvivalShelterRoleMo:setLevelUpCache(level)
	self.uiShowLevel = self.uiShowLevel or level
end

function SurvivalShelterRoleMo:clearLevelUpCache()
	self.uiShowLevel = nil
end

function SurvivalShelterRoleMo:setExpCache()
	if SurvivalMapHelper.instance:isInMapScene() then
		self.isExpCache = true
	end
end

function SurvivalShelterRoleMo:clearExpCache()
	self.isExpCache = nil
end

return SurvivalShelterRoleMo
