-- chunkname: @modules/logic/playercard/config/PlayerCardConfig.lua

module("modules.logic.playercard.config.PlayerCardConfig", package.seeall)

local PlayerCardConfig = class("PlayerCardConfig", BaseConfig)

function PlayerCardConfig:ctor()
	return
end

function PlayerCardConfig:reqConfigNames()
	return {
		"playercard",
		"player_newspaper",
		"playercard_badge",
		"playercard_const"
	}
end

function PlayerCardConfig:onConfigLoaded(configName, configTable)
	if configName == "playercard" then
		self.playcardBaseInfoConfig = configTable
	elseif configName == "player_newspaper" then
		self.playcardProgressConfig = configTable
	end
end

function PlayerCardConfig:getCardBaseInfoList()
	return self.playcardBaseInfoConfig.configList
end

function PlayerCardConfig:getCardBaseInfoById(id)
	return self.playcardBaseInfoConfig.configList[id]
end

function PlayerCardConfig:getCardProgressList()
	return self.playcardProgressConfig.configList
end

function PlayerCardConfig:getCardProgressById(id)
	return self.playcardProgressConfig.configList[id]
end

function PlayerCardConfig:getBageCoById(id)
	return lua_playercard_badge.configDict[id]
end

function PlayerCardConfig:getBgPath(name)
	if not name then
		return "ui/viewres/player/playercard/playercardview_bg.prefab"
	else
		return string.format("ui/viewres/player/playercard/playercardview_bg_%s.prefab", name)
	end
end

function PlayerCardConfig:getTopEffectPath(name)
	if not name then
		return "ui/viewres/player/playercard/playercardview_effect.prefab"
	else
		return string.format("ui/viewres/player/playercard/playercardview_playercardview_effect_%s.prefab", name)
	end
end

PlayerCardConfig.instance = PlayerCardConfig.New()

return PlayerCardConfig
