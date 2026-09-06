-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/minigamecollection/config/MiniGameCollectionConfig.lua

module("logic.extensions.minigamecollection.config.MiniGameCollectionConfig", package.seeall)

local MiniGameCollectionConfig = class("MiniGameCollectionConfig", BaseConfig)

function MiniGameCollectionConfig:onInit()
	MiniGameCollectionConfig.super.onInit(self)

	self._baseGameCfgs = nil
	self._gameParamsCfgs = nil
end

function MiniGameCollectionConfig:getNames()
	return {
		"game_collection",
		"game_collection_params",
		"ancient_fossil_site_period",
		"ancient_fossil_site_score_prize"
	}
end

function MiniGameCollectionConfig:handleConfig(name, content)
	if name == "game_collection" then
		self._baseGameCfgs = content
	elseif name == "game_collection_params" then
		self._gameParamsCfgs = content
	elseif name == "ancient_fossil_site_period" then
		self.ancient_fossil_site_periodCfg = content
	elseif name == "ancient_fossil_site_score_prize" then
		self.ancient_fossil_site_score_prizeCfg = content
	end
end

function MiniGameCollectionConfig:getBasePeriodConfig(id)
	return self.ancient_fossil_site_periodCfg[id]
end

function MiniGameCollectionConfig:getPrizeCfgs(id)
	return self.ancient_fossil_site_score_prizeCfg[id]
end

function MiniGameCollectionConfig:getBaseCfgById(id)
	return self._baseGameCfgs[id]
end

function MiniGameCollectionConfig:getBaseCfgs()
	return self._baseGameCfgs
end

function MiniGameCollectionConfig:getCoinCount(GameType, Score)
	local cfg = self:getBaseCfgById(checkint(GameType))

	if cfg then
		local inputSocre = math.min(checknumber(Score), checknumber(cfg.maxScore))
		local ratioParams = string.split(cfg.prizeRatio, ":")

		if checknumber(ratioParams[1]) == 0 then
			return 0
		end

		return (math.floor(inputSocre * checknumber(ratioParams[2]) / checknumber(ratioParams[1])))
	end

	return 0
end

function MiniGameCollectionConfig:getParamValueByKey(key)
	return self._gameParamsCfgs[key].value
end

function MiniGameCollectionConfig:getMaxBuyTimes()
	return checknumber(self:getParamValueByKey("DAILY_MAX_BUY_TIMES"))
end

MiniGameCollectionConfig.instance = MiniGameCollectionConfig.New()

return MiniGameCollectionConfig
