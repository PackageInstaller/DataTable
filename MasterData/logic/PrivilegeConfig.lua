-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/privilege/config/PrivilegeConfig.lua

module("logic.extensions.privilege.config.PrivilegeConfig", package.seeall)

local PrivilegeConfig = class("PrivilegeConfig", BaseConfig)

function PrivilegeConfig:onInit()
	self._baseCfgs = nil
	self._showCfgs = nil
	self._payGiftCfgs = nil
end

function PrivilegeConfig:getNames()
	return {
		"privilege_params",
		"privilege_gift"
	}
end

function PrivilegeConfig:handleConfig(name, content)
	if name == "privilege_params" then
		self._showCfgs = {}

		for _, v in ipairs(content.dataList) do
			table.insert(self._showCfgs, v)
		end

		self._baseCfgs = content
	elseif name == "privilege_gift" then
		self._payGiftCfgs = content
	end
end

function PrivilegeConfig:getShowCfgs()
	return self._showCfgs
end

function PrivilegeConfig:getBaseCfgById(defineId)
	if defineId == nil or self._baseCfgs == nil then
		return
	end

	return self._baseCfgs[defineId]
end

function PrivilegeConfig:getPayGiftCfgs()
	return self._payGiftCfgs
end

function PrivilegeConfig:getPayGiftCfgById(defineId)
	if defineId == nil or self._payGiftCfgs == nil then
		return
	end

	return self._payGiftCfgs[defineId]
end

PrivilegeConfig.instance = PrivilegeConfig.New()

return PrivilegeConfig
