-- chunkname: @modules/logic/chessgame/config/ChessConfig.lua

module("modules.logic.chessgame.config.ChessConfig", package.seeall)

local ChessConfig = class("ChessConfig", BaseConfig)

function ChessConfig:ctor()
	return
end

function ChessConfig:reqConfigNames()
	return {}
end

function ChessConfig:onConfigLoaded(configName, configTable)
	return
end

function ChessConfig:_registerConfigIns()
	return {
		[VersionActivity2_1Enum.ActivityId.LanShouPa] = Activity164Config.instance
	}
end

function ChessConfig:_getConfigIns(actId)
	if not self._configMap then
		self._configMap = self:_registerConfigIns()

		local funcNames = {
			"getEpisodeCo",
			"getTipsCo",
			"getBubbleCo",
			"getBubbleCoByGroup"
		}

		for _, cfgCls in pairs(self._configMap) do
			for __, funName in ipairs(funcNames) do
				if not cfgCls[funName] or type(cfgCls[funName]) ~= "function" then
					logError(string.format("[%s] can not find function [%s]", cfgCls.__cname, funName))
				end
			end
		end
	end

	if not self._configMap[actId] then
		logError(string.format("version activity Id[%s] 没注册", actId))
	end

	return self._configMap[actId]
end

function ChessConfig:getMapCo(actId, mapId)
	local configIns = self:_getConfigIns(actId)

	if configIns then
		if configIns.getEpisodeCo then
			local episodeCfg = configIns:getEpisodeCo(actId, mapId)

			return (ChessGameConfig.instance:getMapCo(episodeCfg.mapIds))
		else
			logError(string.format("version activity Id[%s]注册类[%s]无 getMapCo接口", actId, configIns.__cname))
		end
	end

	return nil
end

function ChessConfig:getEpisodeCo(actId, episodeId)
	local configIns = self:_getConfigIns(actId)

	if configIns then
		if configIns.getEpisodeCo then
			return configIns:getEpisodeCo(actId, episodeId)
		else
			logError(string.format("version activity Id[%s]注册类[%s]无 getMapCo接口", actId, configIns.__cname))
		end
	end

	return nil
end

function ChessConfig:isStoryEpisode(actId, episodeId)
	local configIns = self:_getConfigIns(actId)

	if configIns and configIns.isStoryEpisode then
		return configIns:isStoryEpisode(actId, episodeId)
	end

	return false
end

function ChessConfig:getTipsCo(actId, tipsId)
	local configIns = self:_getConfigIns(actId)

	if configIns and configIns.getTipsCo then
		return configIns:getTipsCo(actId, tipsId)
	end

	return nil
end

function ChessConfig:getBubbleCoByGroup(actId, groupId)
	local configIns = self:_getConfigIns(actId)

	if configIns and configIns.getBubbleCoByGroup then
		return configIns:getBubbleCoByGroup(actId, groupId)
	end

	return nil
end

function ChessConfig:getChapterEpisodeId(actId)
	local configIns = self:_getConfigIns(actId)

	if configIns then
		if configIns.getChapterEpisodeId then
			return configIns:getChapterEpisodeId(actId)
		else
			logError(string.format("version activity Id[%s]注册类[%s]无 getChapterEpisodeId 接口", actId, configIns.__cname))
		end
	end

	return nil
end

function ChessConfig:getEffectCo(actId, effectId)
	local configIns = self:_getConfigIns(actId)

	if configIns and configIns.getEffectCo then
		return configIns:getEffectCo(actId, effectId)
	end

	return nil
end

ChessConfig.instance = ChessConfig.New()

return ChessConfig
