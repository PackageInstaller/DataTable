-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zdlverify/config/ZdlVerifyConfig.lua

module("logic.extensions.zdlverify.config.ZdlVerifyConfig", package.seeall)

local ZdlVerifyConfig = class("ZdlVerifyConfig", BaseConfig)

function ZdlVerifyConfig:onInit()
	ZdlVerifyConfig.super.onInit(self)
end

function ZdlVerifyConfig:getNames()
	return {
		"zdl_verify_progress",
		"zdl_verify_activity",
		"zdl_verify_race"
	}
end

function ZdlVerifyConfig:handleConfig(name, content)
	if name == "zdl_verify_progress" then
		self._zdl_verify_progress = content
	elseif name == "zdl_verify_activity" then
		self._zdl_verify_activity = content
	elseif name == "zdl_verify_race" then
		self._zdl_verify_race = content
	end
end

function ZdlVerifyConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function ZdlVerifyConfig:getActCfgByActId(activityId)
	return self:_safeGet(self._zdl_verify_activity, activityId)
end

function ZdlVerifyConfig:getRaceCfgListByActId(activityId)
	return self:_safeGet(self._zdl_verify_race, activityId)
end

function ZdlVerifyConfig:getProgressCfgListByActId(activityId)
	return self:_safeGet(self._zdl_verify_progress, activityId)
end

function ZdlVerifyConfig:getProgressCfgByActIdAndProgressId(activityId, progressId)
	return self:_safeGet(self._zdl_verify_progress, activityId, progressId)
end

function ZdlVerifyConfig:getNextProgressCfgByActIdAndProgress(activityId, progress)
	local progressList = self:getProgressCfgListByActId(activityId)

	if progressList then
		for _, cfg in ipairs(progressList) do
			if progress < cfg.verifyRaceNum then
				return cfg
			end
		end

		return progressList[#progressList]
	end

	return nil
end

ZdlVerifyConfig.instance = ZdlVerifyConfig.New()

return ZdlVerifyConfig
