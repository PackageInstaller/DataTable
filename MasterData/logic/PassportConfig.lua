-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/config/PassportConfig.lua

module("logic.extensions.passport.config.PassportConfig", package.seeall)

local PassportConfig = class("PassportConfig", BaseConfig)

function PassportConfig:onInit()
	self._passportBaseCfgs = nil
	self._periodActivityCfgs = nil
	self._permanentActivityCfgs = nil
	self._periodPrizeCfgs = nil
	self._permanentPrizeCfgs = nil
end

function PassportConfig:getNames()
	return {
		"passport_func",
		"passport_period_activity",
		"passport_period_progress_prize",
		"passport_permanent_activity",
		"passport_permanent_progress_prize",
		"passport_extra_prize"
	}
end

function PassportConfig:handleConfig(name, content)
	if name == "passport_func" then
		self._passportBaseCfgs = content
	elseif name == "passport_period_activity" then
		self._periodActivityCfgs = content
	elseif name == "passport_permanent_activity" then
		self._permanentActivityCfgs = content
	elseif name == "passport_period_progress_prize" then
		self._passport_period_progress_prize = content
		self._periodPrizeCfgs = {}

		for _, v in ipairs(content.dataList) do
			self._periodPrizeCfgs[v.actId] = self._periodPrizeCfgs[v.actId] or {}

			table.insert(self._periodPrizeCfgs[v.actId], v)
		end
	elseif name == "passport_permanent_progress_prize" then
		self._permanentPrizeCfgs = {}

		for _, v in ipairs(content.dataList) do
			self._permanentPrizeCfgs[v.actId] = self._permanentPrizeCfgs[v.actId] or {}

			table.insert(self._permanentPrizeCfgs[v.actId], v)
		end
	elseif name == "passport_extra_prize" then
		self._passportExtraCfgs = content
	end
end

function PassportConfig:getBaseCfgs()
	return self._passportBaseCfgs
end

function PassportConfig:getPassportBaseCfgById(defineId)
	if defineId == nil or self._passportBaseCfgs == nil then
		return
	end

	return self._passportBaseCfgs[defineId]
end

function PassportConfig:getPeriodActivityCfgById(defineId)
	if defineId == nil or self._periodActivityCfgs == nil then
		return
	end

	return self._periodActivityCfgs[defineId]
end

function PassportConfig:getPeriodActivityCfgList(funcId)
	local dataList = self._periodActivityCfgs.dataList
	local list = {}

	for i, v in ipairs(dataList) do
		if v.funcId == funcId then
			table.insert(list, v)
		end
	end

	return list
end

function PassportConfig:getPeriodPrizeCfgsByActId(actId)
	return self._periodPrizeCfgs[actId]
end

function PassportConfig:getPassportPeriodProgressByActId(actId)
	return self._passport_period_progress_prize[actId]
end

function PassportConfig:getPermanentActivityCfgById(defineId)
	if defineId == nil or self._permanentActivityCfgs == nil then
		return
	end

	return self._permanentActivityCfgs[defineId]
end

function PassportConfig:getPermanentPrizeCfgsByActId(actId)
	return self._permanentPrizeCfgs[actId]
end

function PassportConfig:getExtraPrizeCfgByActId(actId)
	return self._passportExtraCfgs[actId]
end

PassportConfig.instance = PassportConfig.New()

return PassportConfig
