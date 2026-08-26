-- chunkname: @modules/logic/versionactivity1_3/va3chess/config/Va3ChessConfig.lua

module("modules.logic.versionactivity1_3.va3chess.config.Va3ChessConfig", package.seeall)

local Va3ChessConfig = class("Va3ChessConfig", BaseConfig)

function Va3ChessConfig:ctor()
	return
end

function Va3ChessConfig:reqConfigNames()
	return {}
end

function Va3ChessConfig:onConfigLoaded(configName, configTable)
	return
end

function Va3ChessConfig:_registerConfigIns()
	return {
		[Va3ChessEnum.ActivityId.Act120] = Activity120Config.instance,
		[Va3ChessEnum.ActivityId.Act122] = Activity122Config.instance,
		[Va3ChessEnum.ActivityId.Act142] = Activity142Config.instance
	}
end

function Va3ChessConfig:_getConfigIns(actId)
	if not self._configMap then
		self._configMap = self:_registerConfigIns()

		local funcNames = {
			"getInteractObjectCo",
			"getMapCo",
			"getEpisodeCo"
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

function Va3ChessConfig:getInteractObjectCo(actId, interactId)
	local configIns = self:_getConfigIns(actId)

	if configIns then
		if configIns.getInteractObjectCo then
			return configIns:getInteractObjectCo(actId, interactId)
		else
			logError(string.format("version activity Id[%s]注册类[%s]无 getInteractObjectCo接口", actId, configIns.__cname))
		end
	end

	return nil
end

function Va3ChessConfig:getMapCo(actId, mapId)
	local configIns = self:_getConfigIns(actId)

	if configIns then
		if configIns.getMapCo then
			return configIns:getMapCo(actId, mapId)
		else
			logError(string.format("version activity Id[%s]注册类[%s]无 getMapCo接口", actId, configIns.__cname))
		end
	end

	return nil
end

function Va3ChessConfig:getEpisodeCo(actId, episodeId)
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

function Va3ChessConfig:isStoryEpisode(actId, episodeId)
	local configIns = self:_getConfigIns(actId)

	if configIns and configIns.isStoryEpisode then
		return configIns:isStoryEpisode(actId, episodeId)
	end

	return false
end

function Va3ChessConfig:getTipsCfg(actId, tipsId)
	local configIns = self:_getConfigIns(actId)

	if configIns and configIns.getTipsCfg then
		return configIns:getTipsCfg(actId, tipsId)
	end

	return nil
end

function Va3ChessConfig:getChapterEpisodeId(actId)
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

function Va3ChessConfig:getEffectCo(actId, effectId)
	local configIns = self:_getConfigIns(actId)

	if configIns and configIns.getEffectCo then
		return configIns:getEffectCo(actId, effectId)
	end

	return nil
end

Va3ChessConfig.instance = Va3ChessConfig.New()

return Va3ChessConfig
