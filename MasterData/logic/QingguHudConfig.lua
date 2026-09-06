-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qingguhud/config/QingguHudConfig.lua

module("logic.extensions.qingguhud.QingguHudConfig", package.seeall)

local QingguHudConfig = class("QingguHudConfig", BaseConfig)

function QingguHudConfig:onInit()
	QingguHudConfig.super.onInit(self)
end

function QingguHudConfig:getNames()
	return {
		"qing_gu_hud"
	}
end

function QingguHudConfig:handleConfig(name, content)
	if name == "qing_gu_hud" then
		self._qing_gu_hud = content
	end
end

function QingguHudConfig:getHudCfg(id)
	return self._qing_gu_hud[id]
end

QingguHudConfig.instance = QingguHudConfig.New()

return QingguHudConfig
