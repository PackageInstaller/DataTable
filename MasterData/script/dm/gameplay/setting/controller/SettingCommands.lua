-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/controller/SettingCommands.lua

EVT_ENTER_LAUNCH_SCENE = "EVT_ENTER_LAUNCH_SCENE"
InitSettingsCommand = class("InitSettingsCommand", legs.Command, _M)

function InitSettingsCommand:execute(event)
	local settingSystem = self:getInjector():getInstance(SettingSystem)

	settingSystem:updateMusicAndEffectVolume()
end
