-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunuotongxing/config/YuNuoTongXingConfig.lua

module("logic.extensions.yunuotongxing.config.YuNuoTongXingConfig", package.seeall)

local YuNuoTongXingConfig = class("YuNuoTongXingConfig", BaseConfig)

function YuNuoTongXingConfig:getNames()
	return {
		"walk_with_noah_activity",
		"walk_with_noah_progress_prize",
		"walk_with_noah_piece"
	}
end

function YuNuoTongXingConfig:handleConfig(name, content)
	if name == "walk_with_noah_activity" then
		self._walk_with_noah_activity = content
	elseif name == "walk_with_noah_progress_prize" then
		self._walk_with_noah_progress_prize = content
	elseif name == "walk_with_noah_piece" then
		self._walk_with_noah_piece = content
	end
end

function YuNuoTongXingConfig:getActiveCfgById(id)
	return self._walk_with_noah_activity[id]
end

function YuNuoTongXingConfig:getPrizeCfgs(id)
	return self._walk_with_noah_progress_prize[id]
end

function YuNuoTongXingConfig:getPiecePlanCfgs(id)
	return self._walk_with_noah_piece[id]
end

function YuNuoTongXingConfig:getPieceCfgById(activityId, id)
	if self._walk_with_noah_piece[activityId] then
		return self._walk_with_noah_piece[activityId][id]
	end
end

YuNuoTongXingConfig.instance = YuNuoTongXingConfig.New()

return YuNuoTongXingConfig
