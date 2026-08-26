-- chunkname: @modules/logic/settings/defines/SettingsEnum.lua

module("modules.logic.settings.defines.SettingsEnum", package.seeall)

local SettingsEnum = _M

SettingsEnum.ShowType = {
	Push = 4,
	LimitedRoleEffect = 2,
	Udimo = 5,
	RecordVideo = 1,
	KeyMap = 3
}
SettingsEnum.CategoryList = {
	{
		name = "key_binding",
		subname = "KEYMAP",
		id = 1,
		openIds = {},
		showIds = {
			SettingsEnum.ShowType.KeyMap
		}
	},
	{
		id = 2,
		name = "account",
		subname = "ACCOUNT",
		openIds = {}
	},
	{
		name = "graphic",
		subname = "GRAPHIC",
		id = 3,
		hideOnGamepadModle = true,
		openIds = {}
	},
	{
		id = 4,
		name = "sound",
		subname = "SOUND",
		openIds = {}
	},
	{
		name = "settings_push",
		subname = "PUSH",
		id = 5,
		openIds = {},
		showIds = {
			SettingsEnum.ShowType.Push
		}
	},
	{
		id = 6,
		name = "language",
		subname = "LANGUAGE",
		openIds = {
			OpenEnum.UnlockFunc.SettingsVoiceLang,
			OpenEnum.UnlockFunc.SettingsTxtLang,
			OpenEnum.UnlockFunc.SettingsStroyVoiceLang
		}
	},
	{
		name = "settings_game",
		subname = "GAME",
		id = 7,
		openIds = {},
		showIds = {
			SettingsEnum.ShowType.RecordVideo,
			SettingsEnum.ShowType.LimitedRoleEffect,
			SettingsEnum.ShowType.Udimo
		}
	},
	{
		id = 8,
		name = "settings_fight",
		subname = "FIGHT",
		openIds = {}
	}
}
SettingsEnum.PushType = {
	Room_Produce_Upper_Limit = 2,
	Reactivation = 1,
	Allow_Recommend = 3
}
SettingsEnum.LoginPageType = {
	Random = -1,
	LastId = 0
}
SettingsEnum.CharVoiceLangPrefsKey = "CharVoiceLang_"

return SettingsEnum
