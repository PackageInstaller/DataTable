-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wushenshou/config/WuShenConfig.lua

module("logic.extensions.wushenshou.config.WuShenConfig", package.seeall)

local WuShenConfig = class("WuShenConfig", BaseConfig)

WuShenConfig.HAS_GUIDE_UI = {
	1,
	2,
	3
}
WuShenConfig.NEED_CLEAR = {
	[1] = true
}

function WuShenConfig:onInit()
	WuShenConfig.super.onInit(self)

	self._cofignameCfg = nil
	self._fuliwushenshouCfg = nil
end

function WuShenConfig:getNames()
	return {
		"plot_challenge_creeps",
		"fuli_wushenshou_config",
		"plot_challenge_team"
	}
end

function WuShenConfig:handleConfig(name, content)
	if name == "plot_challenge_creeps" then
		self._cofignameCfg = content
	elseif name == "fuli_wushenshou_config" then
		self._fuliwushenshouCfg = content
	elseif name == "plot_challenge_team" then
		self._master = content
	end
end

function WuShenConfig:getCfgById(id)
	return self._cofignameCfg[id]
end

function WuShenConfig:getMasterCoById(id)
	return self._master[id]
end

function WuShenConfig:getfuliwushenshouCfgs()
	return self._fuliwushenshouCfg
end

function WuShenConfig:checkGuideUI(id)
	print(">>>>>>>>>>>尝试打开 战斗ID", id)

	return table.indexof(WuShenConfig.HAS_GUIDE_UI, id) ~= false
end

WuShenConfig.instance = WuShenConfig.New()

return WuShenConfig
