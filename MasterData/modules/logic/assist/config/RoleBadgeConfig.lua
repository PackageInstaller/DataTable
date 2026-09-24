-- chunkname: @modules/logic/assist/config/RoleBadgeConfig.lua

module("modules.logic.assist.config.RoleBadgeConfig", package.seeall)

local RoleBadgeConfig = class("RoleBadgeConfig", BaseConfig)

function RoleBadgeConfig:reqConfigNames()
	return {
		"role_badge",
		"role_badge_group"
	}
end

function RoleBadgeConfig:onConfigLoaded(configName, configTable)
	if configName == "role_badge" then
		self.groupLvlBadgeCfgMap = {}

		for _, v in ipairs(configTable.configList) do
			local groupId = v.groupId
			local level = v.level

			self.groupLvlBadgeCfgMap[groupId] = self.groupLvlBadgeCfgMap[groupId] or {}
			self.groupLvlBadgeCfgMap[groupId][level] = v
		end
	end
end

function RoleBadgeConfig:getBadgeGroupCo(groupId)
	local config = lua_role_badge_group.configDict[groupId]

	if config then
		return config
	else
		logError("角色助战勋章组表配置为空 组ID: " .. groupId)
	end
end

function RoleBadgeConfig:getBadgeCo(badgeId)
	local config = lua_role_badge.configDict[badgeId]

	if config then
		return config
	else
		logError("角色助战勋章表配置为空 勋章ID: " .. badgeId)
	end
end

function RoleBadgeConfig:getBadgeCoByLevel(group, level)
	if self.groupLvlBadgeCfgMap[group] then
		if self.groupLvlBadgeCfgMap[group] then
			return self.groupLvlBadgeCfgMap[group]
		else
			logError(string.format("角色助战勋章表配置为空勋章 组ID:%s 等级:%s", group, level))
		end
	end
end

RoleBadgeConfig.instance = RoleBadgeConfig.New()

return RoleBadgeConfig
