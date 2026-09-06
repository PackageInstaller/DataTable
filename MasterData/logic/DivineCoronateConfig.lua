-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinecoronate/config/DivineCoronateConfig.lua

module("logic.extensions.divinecoronate.config.DivineCoronateConfig", package.seeall)

local DivineCoronateConfig = class("DivineCoronateConfig", BaseConfig)

function DivineCoronateConfig:getNames()
	return {
		"divine_coronate_activity",
		"divine_coronate_tab"
	}
end

function DivineCoronateConfig:handleConfig(name, content)
	if name == "divine_coronate_activity" then
		self._divine_coronate_activity = content
	elseif name == "divine_coronate_tab" then
		self._divine_coronate_tab = content
	end
end

function DivineCoronateConfig:getActCfgByActId(actId)
	return self._divine_coronate_activity[actId]
end

function DivineCoronateConfig:getTabCfgsByActId(actId)
	return self._divine_coronate_tab[actId]
end

DivineCoronateConfig.instance = DivineCoronateConfig.New()

return DivineCoronateConfig
