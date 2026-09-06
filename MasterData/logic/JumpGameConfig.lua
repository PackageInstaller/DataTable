-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/config/JumpGameConfig.lua

module("logic.extensions.jumpgame.config.JumpGameConfig", package.seeall)

local JumpGameConfig = class("JumpGameConfig", BaseConfig)

function JumpGameConfig:onInit()
	JumpGameConfig.super.onInit(self)

	self._cofigPillarCfg = nil
	self._cofigSpaceCfg = nil
	self._cofigStageCfg = nil
	self._gameInfoCfg = nil
end

function JumpGameConfig:getNames()
	return {
		"jump_pillar",
		"pillar_space",
		"jump_Stage",
		"jumpgame_info"
	}
end

function JumpGameConfig:handleConfig(name, content)
	if name == "jump_pillar" then
		self._cofigPillarCfg = content
	elseif name == "pillar_space" then
		self._cofigSpaceCfg = content
	elseif name == "jump_Stage" then
		self._cofigStageCfg = content
	elseif name == "jumpgame_info" then
		self._gameInfoCfg = content
	end
end

function JumpGameConfig:getPillarCfgById(id)
	return self._cofigPillarCfg[id]
end

function JumpGameConfig:getSpaceCfgById(id)
	return self._cofigSpaceCfg[id]
end

function JumpGameConfig:getStageCfgById(id)
	return self._cofigStageCfg[id]
end

function JumpGameConfig:getStageCfg()
	return self._cofigStageCfg
end

function JumpGameConfig:getGameInfoCfgByKey(key)
	return self._gameInfoCfg[key][2]
end

JumpGameConfig.instance = JumpGameConfig.New()

return JumpGameConfig
