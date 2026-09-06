-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleactions/config/RoleActionsConfig.lua

module("logic.extensions.roleactions.config.RoleActionsConfig", package.seeall)

local RoleActionsConfig = class("RoleActionsConfig", BaseConfig)

function RoleActionsConfig:getNames()
	return {
		"roleactions"
	}
end

function RoleActionsConfig:handleConfig(name, content)
	if name == "roleactions" then
		self._cfgs = content
	end
end

function RoleActionsConfig:getRoleActionCo(id)
	if self._cfgs then
		return self._cfgs[id]
	end

	return nil
end

function RoleActionsConfig:getRoleActions()
	return self._cfgs.dataList
end

RoleActionsConfig.instance = RoleActionsConfig.New()

return RoleActionsConfig
