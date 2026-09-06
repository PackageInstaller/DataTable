-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/config/VipConfig.lua

module("logic.extensions.vip.VipConfig", package.seeall)

local VipConfig = class("VipConfig", BaseConfig)

function VipConfig:onInit()
	self:onReset()
end

function VipConfig:onReset()
	self._baseCfgs = nil
	self._privilegeCfgs = nil
	self._bonusCfgs = nil
	self._privilegeIconCfgs = nil
end

function VipConfig:getNames()
	return {
		"vip_define",
		"vip_privilege",
		"vip_bonus",
		"vip_params",
		"vip_client_params"
	}
end

function VipConfig:handleConfig(name, content)
	if name == "vip_define" then
		self._baseCfgs = content
	elseif name == "vip_privilege" then
		self._privilegeCfgs = {}

		for _, v in ipairs(content.dataList) do
			self._privilegeCfgs[v.vipLv] = self._privilegeCfgs[v.vipLv] or {}
			self._privilegeCfgs[v.vipLv][v.privilegeType] = v
		end

		self._vip_privilege = content
	elseif name == "vip_bonus" then
		self._bonusCfgs = {}

		for _, v in ipairs(content.dataList) do
			self._bonusCfgs[v.vipLv] = self._bonusCfgs[v.vipLv] or {}
			self._bonusCfgs[v.vipLv][v.bonusId] = v
		end
	elseif name == "vip_params" then
		self._vipParams = content
	elseif name == "vip_client_params" then
		self._vipClientParams = content
	end
end

function VipConfig:getParamInt(key)
	local val = self:getParamString(key)

	return checknumber(val)
end

function VipConfig:getParamString(key)
	local val = self._vipParams[key]

	val = val or self._vipClientParams[key]

	if val then
		return val.value
	end
end

function VipConfig:getBaseCfgs()
	return self._baseCfgs.dataList
end

function VipConfig:getBaseCfgById(lv)
	if lv == nil or self._baseCfgs == nil then
		return
	end

	return self._baseCfgs[lv]
end

function VipConfig:getPrivilegeIconCfgById(typeId)
	if typeId == nil or self._privilegeIconCfgs == nil then
		printError(1)

		return
	end

	return self._privilegeIconCfgs[typeId]
end

function VipConfig:getPrivilegeCfgs()
	if self._privilegeCfgs == nil then
		return
	end

	return self._privilegeCfgs
end

function VipConfig:getPrivilegeCfgsByLv(lv)
	if lv == nil or self._privilegeCfgs == nil then
		return
	end

	return self._privilegeCfgs[lv]
end

function VipConfig:getBonusCfgsByLv(lv)
	if lv == nil or self._bonusCfgs == nil then
		return
	end

	return self._bonusCfgs[lv]
end

function VipConfig:getPrivilegeCfgList()
	return self._vip_privilege.dataList
end

VipConfig.instance = VipConfig.New()

return VipConfig
