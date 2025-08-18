-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/DesignerScript\\AvgConfig.lua

local AvgConfig = {}

AvgConfig.PLAYER_NPC_ID = 300
AvgConfig.DEFAULT_SHADOW_DISTANCE = 50
AvgConfig.DEFAULT_NEAR_PLANE = 1
AvgConfig.DEFAULT_FAR_PLANE = 2000
AvgConfig.DEFAULT_FONT_SIZE = 34
AvgConfig.CONTANT_FONT_COLOR = {
	0.21568627450980393,
	0.21568627450980393,
	0.21568627450980393,
	1
}
AvgConfig.ASIDE_FONT_COLOR = {
	0.8117647058823529,
	0.8117647058823529,
	0.8117647058823529,
	1
}
AvgConfig.LOADING_TIMEOUT = 2
AvgConfig.SKIP_TEXT_RUNNING_CD = 0.24
AvgConfig.SKIP_TIP_CD = 3
AvgConfig.LABEL_JUMP_INTERVAL = 0.03
AvgConfig.AUTO_NEXT_PAGE_CD = 2
AvgConfig.ROLE_INTRO_LENGTH = 3
AvgConfig.ROLE_INTRO_CLICKCD = 1
AvgConfig.ROLE_IDCARD_CLICKCD = 1
AvgConfig.ROLE_TERMINAL_CD = 3
AvgConfig.LAST_BG_FADEOUT = 0.5
AvgConfig.CUR_BG_FADEIN = 0.8
AvgConfig.DEF_DURATION = 0.5
AvgConfig.EFF_EMOJI_DEF_POS = {
	70,
	400
}
AvgConfig.ROLE_GRAY_COLOR = {
	120,
	120,
	120
}
AvgConfig.BULLET_REQUEST_CD = 2
AvgConfig.BULLET_UPDATE_CD = 3
AvgConfig.BULLET_LIMIT = 20
AvgConfig.BULLET_PAGE_LIMIT = 80
AvgConfig.AUTO_TIMER_SHOWALL = 1
AvgConfig.AUTO_TIMER_NEXTPAGE = 2
AvgConfig.AUTO_TIMER_INTROROLE = 3
AvgConfig.AUTO_TIMER_IDCARD = 4
AvgConfig.AUTO_TIMER_TERMINAL = 5
AvgConfig.BG_EFX_MAP = {
	nil,
	nil,
	"System/AVG/AVGLongStoryPanel",
	"System/AVG/AVGClockPanel1",
	"System/AVG/AVGClockPanel2",
	"System/AVG/AVGClockPanel3"
}
AvgConfig.AVG_LIVE_MAP = {
	[9] = "System/AVG/AvgLivePanel3",
	[8] = "System/AVG/AvgLivePanel2",
	[7] = "System/AVG/AvgLivePanel"
}
AvgConfig.AVG_TALK_SPECIAL_EFFECT = {
	{
		end_mat = "UI/GUIRes/Material/UITransGray.mat",
		duration = 2,
		start_shader = "AntManShader/UI/FadeInGray",
		start_mat = "UI/GUIRes/Material/UIFadeInGray.mat"
	},
	{
		end_mat = "UI/GUIRes/Material/UITransSquare.mat",
		duration = 2,
		start_shader = "AntManShader/UI/FadeOutGray",
		start_mat = "UI/GUIRes/Material/UIFadeOutGray.mat"
	}
}
AvgConfig.MODEL_STAGE_POS = {
	["ModelStage/AVGModelStage_1207"] = 100,
	["ModelStage/AVGModelStage_shop"] = 101
}
AvgConfig.TIMELINE_ANCHOR = {
	"Anchor01",
	"Anchor02",
	"Anchor03",
	"Anchor04",
	"Anchor05"
}

return AvgConfig
