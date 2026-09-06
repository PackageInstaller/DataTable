-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/config/TongBattleConfig.lua

module("logic.extensions.tongbattle.config.TongBattleConfig", package.seeall)

local TongBattleConfig = class("TongBattleConfig", BaseConfig)

function TongBattleConfig:onInit()
	TongBattleConfig.super.onInit(self)

	self._battleBaseCfgs = nil
	self._battleTypeCfgs = nil
	self._masterTeamCfgs = nil
	self._masterCreepsCfgs = nil
	self._buyTimesCfgs = nil
end

function TongBattleConfig:getNames()
	return {
		"pupil_challenge",
		"pupil_challenge_type",
		"pupil_challenge_stage",
		"pupil_challenge_creeps",
		"pupil_challenge_buy_times"
	}
end

function TongBattleConfig:handleConfig(name, content)
	if name == "pupil_challenge" then
		self._battleBaseCfgs = content
	elseif name == "pupil_challenge_type" then
		self._battleTypeCfgs = content
	elseif name == "pupil_challenge_stage" then
		self._masterTeamCfgs = content
	elseif name == "pupil_challenge_creeps" then
		self._masterCreepsCfgs = content
	elseif name == "pupil_challenge_buy_times" then
		self._buyTimesCfgs = content
	end
end

function TongBattleConfig:getBattleBaseCfg(chalId)
	chalId = checknumber(chalId)

	if self._battleBaseCfgs == nil or self._battleBaseCfgs[chalId] == nil then
		return nil
	end

	return self._battleBaseCfgs[chalId]
end

function TongBattleConfig:getBattleTypeCfg(chalType)
	chalType = checknumber(chalType)

	if self._battleTypeCfgs == nil or self._battleTypeCfgs[chalType] == nil then
		return nil
	end

	return self._battleTypeCfgs[chalType]
end

function TongBattleConfig:getMasterTeamCfg(planId, chalType, chalId)
	planId = checknumber(planId)

	if self._masterTeamCfgs == nil or self._masterTeamCfgs[planId] == nil then
		return nil
	end

	local list = self._masterTeamCfgs[planId]

	chalType = checknumber(chalType)
	chalId = checknumber(chalId)

	if list[chalType] == nil or list[chalType][chalId] == nil then
		return nil
	end

	return list[chalType][chalId]
end

function TongBattleConfig:getMasterCreepsCfg(masterId)
	masterId = checknumber(masterId)

	if self._masterCreepsCfgs == nil or self._masterCreepsCfgs[masterId] == nil then
		return nil
	end

	return self._masterCreepsCfgs[masterId]
end

function TongBattleConfig:getAllBuyTimesCfgs(planId)
	planId = checknumber(planId)

	if self._buyTimesCfgs == nil or self._buyTimesCfgs[planId] == nil then
		return
	end

	return self._buyTimesCfgs[planId]
end

function TongBattleConfig:getBuyTimesCfg(planId, num)
	planId = checknumber(planId)

	if self._buyTimesCfgs == nil or self._buyTimesCfgs[planId] == nil then
		return
	end

	num = num or 1

	return self._buyTimesCfgs[planId][num]
end

TongBattleConfig.instance = TongBattleConfig.New()

return TongBattleConfig
