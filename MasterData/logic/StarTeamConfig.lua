-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starteam/config/StarTeamConfig.lua

module("logic.extensions.starteam.config.StarTeamConfig", package.seeall)

local StarTeamConfig = class("StarTeamConfig", BaseConfig)

function StarTeamConfig:onInit()
	StarTeamConfig.super.onInit(self)
end

function StarTeamConfig:getNames()
	return {
		"star_team_prize",
		"star_team_common_config"
	}
end

function StarTeamConfig:handleConfig(name, content)
	if name == "star_team_prize" then
		self.starTeamPrize = content
	elseif name == "star_team_common_config" then
		self.commonConfig = content
	end
end

function StarTeamConfig:getPrizeCfgById(id)
	return self.starTeamPrize[id]
end

function StarTeamConfig:getPrizeList()
	return self.starTeamPrize.dataList
end

function StarTeamConfig:getCommonCfgById(id)
	if self.commonConfig[id] then
		return self.commonConfig[id].value
	end
end

StarTeamConfig.instance = StarTeamConfig.New()

return StarTeamConfig
