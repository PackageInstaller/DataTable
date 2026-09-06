-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/config/OperationSignInConfig.lua

module("logic.extensions.operationsignin.config.OperationSignInConfig", package.seeall)

local OperationSignInConfig = class("OperationSignInConfig", BaseConfig)

function OperationSignInConfig:onInit()
	OperationSignInConfig.super.onInit(self)

	self._sign_in_Cfg = nil
	self._signContentCfg = nil
	self._signDreamCfg = nil
	self._showSignInCfgs = nil
	self.version_show_pet = nil
end

function OperationSignInConfig:getNames()
	return {
		"operation_check_in",
		"operation_content",
		"operation_dreamchat",
		"activity_signIn_show",
		"operation_check_in_extra",
		"version_show_pet"
	}
end

function OperationSignInConfig:handleConfig(name, content)
	if name == "operation_check_in" then
		self._sign_in_Cfg = content
	elseif name == "operation_content" then
		self._signContentCfg = content
	elseif name == "operation_dreamchat" then
		self._signDreamCfg = content
	elseif name == "activity_signIn_show" then
		self._showSignInCfgs = content
	elseif name == "operation_check_in_extra" then
		self._check_in_extra = content
	elseif name == "version_show_pet" then
		self.version_show_pet = content
	end
end

function OperationSignInConfig:getSignInCfgList(activityId)
	local list = {}

	for k, v in pairs(self._sign_in_Cfg[activityId]) do
		table.insert(list, v)
	end

	return list
end

function OperationSignInConfig:getSignInCfg(activityId, day)
	return self._sign_in_Cfg[activityId][day]
end

function OperationSignInConfig:getSignContentCfg(id)
	if self._signContentCfg and self._signContentCfg[id] then
		return self._signContentCfg[id]
	end
end

function OperationSignInConfig:getSignDreamCfg(id)
	if self._signDreamCfg and self._signDreamCfg[id] then
		return self._signDreamCfg[id]
	end
end

function OperationSignInConfig:getSignInShowCfgsByActId(actId)
	return self._showSignInCfgs[actId]
end

function OperationSignInConfig:getSignInExtra(actId)
	return self._check_in_extra[actId]
end

function OperationSignInConfig:getVersionShowPetCfg(activityId)
	local list = {}

	for k, v in pairs(self._sign_in_Cfg[activityId]) do
		table.insert(list, v)
	end

	return list
end

OperationSignInConfig.instance = OperationSignInConfig.New()

return OperationSignInConfig
