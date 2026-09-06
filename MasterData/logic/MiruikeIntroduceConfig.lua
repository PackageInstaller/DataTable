-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miruikeintroduce/config/MiruikeIntroduceConfig.lua

module("logic.extensions.miruikeintroduce.config.MiruikeIntroduceConfig", package.seeall)

local MiruikeIntroduceConfig = class("MiruikeIntroduceConfig", BaseConfig)

MiruikeIntroduceConfig.isH5Online = true

function MiruikeIntroduceConfig:onInit()
	MiruikeIntroduceConfig.super.onInit(self)

	self._tabConf = nil
	self._jumpConf = nil
	self._jumpConf2 = nil
	self._commonConf = nil
	self._enterConf = nil
end

function MiruikeIntroduceConfig:getNames()
	return {
		"mi_rui_ke_hud_tab",
		"mi_rui_ke_hud_common",
		"mi_rui_ke_hud_jump",
		"mi_rui_ke_hud_enter",
		"mi_rui_ke_hud_jump2"
	}
end

function MiruikeIntroduceConfig:handleConfig(name, content)
	if name == "mi_rui_ke_hud_tab" then
		self._tabConf = content
	elseif name == "mi_rui_ke_hud_common" then
		self._commonConf = content
	elseif name == "mi_rui_ke_hud_jump" then
		self._jumpConf = content
	elseif name == "mi_rui_ke_hud_jump2" then
		self._jumpConf2 = content
	elseif name == "mi_rui_ke_hud_enter" then
		self._enterConf = content
	end
end

function MiruikeIntroduceConfig:getTabCfg()
	return self._tabConf
end

function MiruikeIntroduceConfig:getJumpConf(index)
	return self._jumpConf[index]
end

function MiruikeIntroduceConfig:getJump2Conf(index)
	return self._jumpConf2[index]
end

function MiruikeIntroduceConfig:getCfgByTab(tab)
	return self._tabConf[tab]
end

function MiruikeIntroduceConfig:getCommonValue(key)
	local conf = self._commonConf[key]

	if conf then
		return conf.value
	end

	return ""
end

function MiruikeIntroduceConfig:getEnterConfigByIndex(index)
	return self._enterConf[index]
end

MiruikeIntroduceConfig.instance = MiruikeIntroduceConfig.New()

return MiruikeIntroduceConfig
