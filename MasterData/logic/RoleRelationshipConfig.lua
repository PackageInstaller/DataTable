-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rolerelationship/config/RoleRelationshipConfig.lua

module("logic.extensions.rolerelationship.config.RoleRelationshipConfig", package.seeall)

local RoleRelationshipConfig = class("RoleRelationshipConfig", BaseConfig)

function RoleRelationshipConfig:onInit()
	RoleRelationshipConfig.super.onInit(self)
end

function RoleRelationshipConfig:getNames()
	return {
		"role_relationship",
		"role_relationship_role",
		"role_relationship_role_archive",
		"role_relationship_role_archive_impression",
		"role_relationship_ship",
		"role_relationship_task",
		"role_relationship_progress_prize",
		"role_relationship_box",
		"role_relationship_box_ship"
	}
end

function RoleRelationshipConfig:handleConfig(name, content)
	if name == "role_relationship" then
		self._rsCfgs = content
	elseif name == "role_relationship_role" then
		self._rsRoleCfgs = content
	elseif name == "role_relationship_role_archive" then
		self._rsRoleArcCfgs = content
	elseif name == "role_relationship_role_archive_impression" then
		self._rsRoleArcImpCfgs = content
	elseif name == "role_relationship_ship" then
		self._rsShipCfgs = content
	elseif name == "role_relationship_task" then
		self._rsTaskCfgs = content
	elseif name == "role_relationship_progress_prize" then
		self._rsProPrizeCfgs = content
	elseif name == "role_relationship_box" then
		self._rsBoxCfgs = content
	elseif name == "role_relationship_box_ship" then
		self._rsBoxShipCfgs = content
	end
end

function RoleRelationshipConfig:getRsCfg(actId)
	if not self._rsCfgs[actId] then
		return self._rsCfgs[actId]
	end
end

function RoleRelationshipConfig:getRsRoleCfg(actId)
	local rsCfg = self:getRsCfg(actId)

	if not rsCfg.rolePlanId then
		if not self._rsRoleCfgs[rsCfg.rolePlanId] then
			return {}
		end
	end
end

function RoleRelationshipConfig:getRsRoleData(actId, roleId)
	local rsRoleCfg = self:getRsRoleCfg(actId)

	if not rsRoleCfg[roleId] then
		return rsRoleCfg[roleId]
	end
end

function RoleRelationshipConfig:getRsRoleArcCfg(arcPlanId)
	if not self._rsRoleArcCfgs[arcPlanId] then
		return self._rsRoleArcCfgs[arcPlanId]
	end
end

function RoleRelationshipConfig:getRsRoleArcData(arcPlanId, arcId)
	local rsRoleArcCfg = self:getRsRoleArcCfg(arcPlanId)

	if not rsRoleArcCfg[arcId] then
		return rsRoleArcCfg[arcId]
	end
end

function RoleRelationshipConfig:getRsRoleArcImpCfg(impPlanId)
	if not self._rsRoleArcImpCfgs[impPlanId] then
		return self._rsRoleArcImpCfgs[impPlanId]
	end
end

function RoleRelationshipConfig:getRsRoleArcImpData(impPlanId, impId)
	local rsRoleArcImpCfg = self:getRsRoleArcImpCfg(impPlanId)

	if not rsRoleArcImpCfg[impId] then
		return rsRoleArcImpCfg[impId]
	end
end

function RoleRelationshipConfig:getRsShipCfg(actId)
	local rsCfg = self:getRsCfg(actId)

	if not rsCfg.shipPlanId then
		if not self._rsShipCfgs[rsCfg.shipPlanId] then
			return {}
		end
	end
end

function RoleRelationshipConfig:getRsTaskCfg(actId)
	local rsCfg = self:getRsCfg(actId)

	if not rsCfg.taskPlanId then
		if not self._rsTaskCfgs[rsCfg.taskPlanId] then
			return {}
		end
	end
end

function RoleRelationshipConfig:getRsTaskData(actId, taskId)
	local rsTaskCfg = self:getRsTaskCfg(actId)

	if not rsTaskCfg[taskId] then
		return rsTaskCfg[taskId]
	end
end

function RoleRelationshipConfig:getRsProPrizeCfg(actId)
	local rsCfg = self:getRsCfg(actId)

	if not rsCfg.proPrizePlanId then
		if not self._rsProPrizeCfgs[rsCfg.proPrizePlanId] then
			return {}
		end
	end
end

function RoleRelationshipConfig:getRsBoxCfg(actId)
	local rsCfg = self:getRsCfg(actId)

	if not rsCfg.boxPlanId then
		if not self._rsBoxCfgs[rsCfg.boxPlanId] then
			return {}
		end
	end
end

function RoleRelationshipConfig:getRsBoxShipCfg(actId)
	local rsCfg = self:getRsCfg(actId)

	if not rsCfg.boxShipPlanId then
		if not self._rsBoxShipCfgs[rsCfg.boxShipPlanId] then
			return {}
		end
	end
end

RoleRelationshipConfig.instance = RoleRelationshipConfig.New()

return RoleRelationshipConfig
