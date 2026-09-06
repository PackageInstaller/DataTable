-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/config/TianYanMatchConfig.lua

module("logic.extensions.timecapsule.config.TianYanMatchConfig", package.seeall)

local TianYanMatchConfig = class("TianYanMatchConfig", BaseConfig)

function TianYanMatchConfig:onInit()
	TianYanMatchConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function TianYanMatchConfig:getNames()
	return {
		"tian_yan_match_rank_prize",
		"tian_yan_match_toy",
		"tian_yan_match_activity",
		"tian_yan_match_special_match",
		"tian_yan_match_manual_prize",
		"tian_yan_match_manual_type"
	}
end

function TianYanMatchConfig:handleConfig(name, content)
	if name == "tian_yan_match_rank_prize" then
		self._tian_yan_match_rank_prize = content
	elseif name == "tian_yan_match_toy" then
		self._tian_yan_match_toy = content
	elseif name == "tian_yan_match_activity" then
		self._tian_yan_match_activity = content
	elseif name == "tian_yan_match_special_match" then
		self._tian_yan_match_special_match = content
	elseif name == "tian_yan_match_manual_prize" then
		self._tian_yan_match_manual_prize = content

		self:_handerManualCfgs(content)
	elseif name == "tian_yan_match_manual_type" then
		self._tian_yan_match_manual_type = content
	end
end

function TianYanMatchConfig:getActivityCfg(activityId)
	return self._tian_yan_match_activity[activityId]
end

function TianYanMatchConfig:getToyCfg(activityId, toyId)
	if self._tian_yan_match_toy[activityId] then
		return self._tian_yan_match_toy[activityId][toyId]
	end
end

function TianYanMatchConfig:getToyCfgs(activityId)
	return self._tian_yan_match_toy[activityId]
end

function TianYanMatchConfig:_handerManualCfgs(content)
	self._manualTypeCfgList = {}

	for i, v in ipairs(content.dataList) do
		self._manualTypeCfgList[v.activityId] = self._manualTypeCfgList[v.activityId] or {}
		self._manualTypeCfgList[v.activityId][v.manualType] = self._manualTypeCfgList[v.activityId][v.manualType] or {}

		table.insert(self._manualTypeCfgList[v.activityId][v.manualType], v)
	end
end

function TianYanMatchConfig:getManualByTypeCfgList(activityId, manualType)
	if self._manualTypeCfgList[activityId] then
		return self._manualTypeCfgList[activityId][manualType]
	end
end

function TianYanMatchConfig:getManualTypeCfgs(activityId)
	return self._tian_yan_match_manual_type[activityId]
end

function TianYanMatchConfig:getManualCfgs(activityId)
	return self._tian_yan_match_manual_prize[activityId]
end

function TianYanMatchConfig:getSpecialMatchCfgs(activityId)
	return self._tian_yan_match_special_match[activityId]
end

function TianYanMatchConfig:getRankPrizeCfgs(activityId)
	return self._tian_yan_match_rank_prize[activityId]
end

TianYanMatchConfig.instance = TianYanMatchConfig.New()

return TianYanMatchConfig
