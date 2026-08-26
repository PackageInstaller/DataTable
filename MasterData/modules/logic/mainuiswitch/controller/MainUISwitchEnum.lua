-- chunkname: @modules/logic/mainuiswitch/controller/MainUISwitchEnum.lua

module("modules.logic.mainuiswitch.controller.MainUISwitchEnum", package.seeall)

local MainUISwitchEnum = _M

MainUISwitchEnum.ItemTypeSelected = 1
MainUISwitchEnum.ItemTypeUnSelected = 2
MainUISwitchEnum.ItemHeight = 190
MainUISwitchEnum.ItemUnSelectedScale = 0.78
MainUISwitchEnum.ItemUnSelectedHeight = MainUISwitchEnum.ItemHeight * MainUISwitchEnum.ItemUnSelectedScale
MainUISwitchEnum.MainUIPart = {
	NormalJumpFight = 12,
	BankEffect = 13,
	Room = 5,
	NormalFight = 11,
	Storage = 3,
	Quest = 2,
	Bank = 4,
	Power = 8,
	Fight = 9,
	Mail = 1,
	ActivityFight = 10,
	CaiDan = 15,
	Role = 6,
	SkinBG = 14,
	Summon = 7
}
MainUISwitchEnum.MainUIFontMaterialPath = "font/meshpro/outline_material/mainui/mainui_font_material_%s.mat"
MainUISwitchEnum.SwitchMainUIOffsetType = {
	{
		offsetX = 138
	},
	{
		offsetX = -187
	}
}
MainUISwitchEnum.MainUIScale = 0.8
MainUISwitchEnum.Skin = {
	V3a4 = 4,
	Sp01 = 2,
	S02 = 5,
	V3a2 = 3,
	Normal = 1
}
MainUISwitchEnum.EagleLocationType = {
	C = 3,
	A = 1,
	B = 2
}
MainUISwitchEnum.EagleAnim = {
	Idle3 = "idle3",
	Fly = "fly",
	Idle2 = "idle2",
	Land = "land",
	Idle1 = "idle1",
	Scare = "scare",
	Hover = "hover"
}
MainUISwitchEnum.HeadCutTime = 15
MainUISwitchEnum.HeadCutLoadime = 0.2
MainUISwitchEnum.AnimName = {
	Out = "out",
	Switch = "switch",
	Idle = "idle",
	In = "in"
}
MainUISwitchEnum.MainUIPath = "ui/viewres/main/mainview.prefab"
MainUISwitchEnum.ChildViewType = {
	MainUIPartView = 5,
	SwitchMainActExtraDisplay = 3,
	SwitchMainUIEagleAnimView = 6,
	SwitchMainActivityEnterView = 2,
	SwitchMainUIView = 4,
	MainBirdAnimView = 7,
	SwitchMainUIShowView = 1
}
MainUISwitchEnum.ChildViewComp = {
	[MainUISwitchEnum.ChildViewType.SwitchMainUIShowView] = {
		cls = SwitchMainUIShowView
	},
	[MainUISwitchEnum.ChildViewType.SwitchMainActivityEnterView] = {
		cls = SwitchMainActivityEnterView
	},
	[MainUISwitchEnum.ChildViewType.SwitchMainActExtraDisplay] = {
		cls = SwitchMainActExtraDisplay
	},
	[MainUISwitchEnum.ChildViewType.SwitchMainUIView] = {
		cls = SwitchMainUIView
	},
	[MainUISwitchEnum.ChildViewType.MainUIPartView] = {
		cls = MainUIPartView
	},
	[MainUISwitchEnum.ChildViewType.SwitchMainUIEagleAnimView] = {
		cls = SwitchMainUIEagleAnimView,
		UIId = MainUISwitchEnum.Skin.Sp01
	},
	[MainUISwitchEnum.ChildViewType.MainBirdAnimView] = {
		cls = SwitchMainUIEagleAnimView,
		UIId = MainUISwitchEnum.Skin.V3a4
	}
}
MainUISwitchEnum.SkinAnim = {
	[MainUISwitchEnum.Skin.S02] = {
		view = MainS02AnimView
	}
}
MainUISwitchEnum.ConstId = {
	S02AnimTime = 3,
	BirdClickCount = 1,
	BirdClickSustainTime = 2
}
MainUISwitchEnum.FirstEnterMainView = "MainUISwitchEnum_FirstEnterMainView"

return MainUISwitchEnum
