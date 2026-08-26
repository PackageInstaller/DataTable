-- chunkname: @modules/logic/survival/config/SurvivalRoleConfig.lua

module("modules.logic.survival.config.SurvivalRoleConfig", package.seeall)

local SurvivalRoleConfig = class("SurvivalRoleConfig", BaseConfig)

function SurvivalRoleConfig:ctor()
	return
end

function SurvivalRoleConfig:reqConfigNames()
	return {
		"survival_role",
		"survival_disposition",
		"survival_level",
		"survival_role_skill"
	}
end

function SurvivalRoleConfig:onConfigLoaded(configName, configTable)
	if configName == "" then
		-- block empty
	end
end

function SurvivalRoleConfig:haveRole(roleId)
	return lua_survival_role.configDict[roleId]
end

function SurvivalRoleConfig:getRoleAttrIds()
	if self.roleAttrIds == nil then
		self.roleAttrIds = {}

		local cfg = lua_survival_disposition.configList[1]

		for i = 1, 100 do
			local key = string.format("attribute%s", i)

			if cfg[key] then
				table.insert(self.roleAttrIds, i)
			else
				break
			end
		end
	end

	return self.roleAttrIds
end

function SurvivalRoleConfig:getRoleAttrValue(type, level, attrId)
	if self.roleAttrValue == nil then
		self:parseDispositionCfg()
	end

	if self.roleAttrValue[type] and self.roleAttrValue[type][level] then
		return self.roleAttrValue[type][level][attrId]
	else
		return -1
	end
end

function SurvivalRoleConfig:parseDispositionCfg()
	self.roleAttrValue = {}

	local list = lua_survival_disposition.configList

	for i, cfg in ipairs(list) do
		if self.roleAttrValue[cfg.type] == nil then
			self.roleAttrValue[cfg.type] = {}
		end

		if self.roleAttrValue[cfg.type][cfg.level] == nil then
			self.roleAttrValue[cfg.type][cfg.level] = {}
		end

		local attrIds = self:getRoleAttrIds()

		for j, id in ipairs(attrIds) do
			local key = string.format("attribute%s", id)

			self.roleAttrValue[cfg.type][cfg.level][id] = cfg[key]
		end
	end
end

function SurvivalRoleConfig:getLevelByExp(exp)
	local level
	local list = lua_survival_level.configList

	for i, cfg in ipairs(list) do
		if exp >= cfg.exp then
			level = cfg.id
		else
			break
		end
	end

	return level
end

function SurvivalRoleConfig:isMaxLevel(level)
	if level >= self:getRoleMaxLevel() then
		return true
	end
end

function SurvivalRoleConfig:getRoleMaxLevel()
	return #lua_survival_level.configList
end

function SurvivalRoleConfig:getLevelNeedExp(level)
	return lua_survival_level.configDict[level].exp
end

function SurvivalRoleConfig:getUnlockCondition(roleId)
	local str = lua_survival_role.configDict[roleId].conditions

	return (string.split(str, "#"))
end

function SurvivalRoleConfig:getRoleCardImage(roleId)
	return lua_survival_role.configDict[roleId].pic
end

function SurvivalRoleConfig:getRoleChessImage(roleId)
	return lua_survival_role.configDict[roleId].chessPic
end

function SurvivalRoleConfig:getRoleHeadImage(roleId)
	return lua_survival_role.configDict[roleId].head
end

function SurvivalRoleConfig:getRoleModelRes(roleId)
	if roleId then
		return lua_survival_role.configDict[roleId].resource
	end
end

function SurvivalRoleConfig:getRoleInitAttrTips(roleId, attrId)
	local key = string.format("SurvivalRoleInitAttrTip_%s", attrId)

	return luaLang(key)
end

function SurvivalRoleConfig:getRoleCfgByTechId(techId)
	local belongRole

	for i, cfg in ipairs(lua_survival_role.configList) do
		if cfg.id == techId then
			belongRole = cfg.id

			break
		end
	end

	return lua_survival_role.configDict[belongRole]
end

function SurvivalRoleConfig:getSkillDesc(roleId)
	local id = lua_survival_role.configDict[roleId].skill
	local skillCfg = lua_survival_role_skill.configDict[id]
	local skillId = skillCfg.id
	local param

	if not string.nilorempty(skillCfg.effect1) then
		local infos = string.splitToNumber(skillCfg.effect1, "#")

		if skillId == 2 then
			param = {
				infos[2],
				infos[3]
			}
		elseif skillId == 3 or skillId == 4 or skillId == 5 then
			param = {
				infos[2]
			}
		elseif skillId == 6 then
			param = {
				infos[3]
			}
		end
	end

	if param then
		return GameUtil.getSubPlaceholderLuaLang(skillCfg.desc, param)
	else
		return skillCfg.desc
	end
end

function SurvivalRoleConfig:getDefaultRoleId()
	return 999
end

function SurvivalRoleConfig:getDefaultRoleIdSwitch()
	return 4
end

SurvivalRoleConfig.instance = SurvivalRoleConfig.New()

return SurvivalRoleConfig
