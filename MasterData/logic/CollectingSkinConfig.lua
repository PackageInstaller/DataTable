-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/config/CollectingSkinConfig.lua

module("logic.extensions.collectingskin.config.CollectingSkinConfig", package.seeall)

local CollectingSkinConfig = class("CollectingSkinConfig", BaseConfig)

function CollectingSkinConfig:onInit()
	CollectingSkinConfig.super.onInit(self)
end

function CollectingSkinConfig:getNames()
	return {
		"collecting_skin_activity",
		"collecting_skin_progress",
		"collecting_skin",
		"collecting_skin_item",
		"collecting_skin_item_progress",
		"poster_stickers_gain_activity"
	}
end

function CollectingSkinConfig:handleConfig(name, content)
	if name == "collecting_skin_activity" then
		self._actCfgs = content
	elseif name == "collecting_skin" then
		self._skinCfgs = content
	elseif name == "collecting_skin_progress" then
		self._progressCfgs = content
	elseif name == "collecting_skin_item" then
		self._itemCfgs = content
	elseif name == "collecting_skin_item_progress" then
		self._itemProgressCfgs = content
	elseif name == "poster_stickers_gain_activity" then
		self._poster_stickers_gain_activity = content
	end
end

function CollectingSkinConfig:getActCfg(actId)
	return self._actCfgs[actId]
end

function CollectingSkinConfig:getSkinCfgs(actId)
	return self._skinCfgs[actId]
end

function CollectingSkinConfig:getProgressCfgs(actId)
	return self._progressCfgs[actId]
end

function CollectingSkinConfig:getItemCfg(actId)
	return self._itemCfgs[actId]
end

function CollectingSkinConfig:getItemData(actId, id)
	if self._itemCfgs[actId] then
		return self._itemCfgs[actId][id]
	end
end

function CollectingSkinConfig:getItemProgressCfg(actId)
	return self._itemProgressCfgs[actId]
end

function CollectingSkinConfig:getItemProgressData(actId, dataBitId)
	if self._itemProgressCfgs[actId] then
		return self._itemProgressCfgs[actId][dataBitId]
	end
end

function CollectingSkinConfig:getPosterCfg(actId)
	return self._poster_stickers_gain_activity[actId]
end

CollectingSkinConfig.instance = CollectingSkinConfig.New()

return CollectingSkinConfig
