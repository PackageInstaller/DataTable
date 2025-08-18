-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/DesignerScript\\UIMiscConfig.lua

local UIMiscConfig = {}

UIMiscConfig.ROLE_HEAD_LIST = {
	1,
	2,
	3,
	4
}
UIMiscConfig.MAIN_DLG_SHOWTIME = 0.9
UIMiscConfig.MAIN_STAGE_SHOWTIME = 0.1
UIMiscConfig.MAIN_DLG_TRANSFER_CUEID = 10005006
UIMiscConfig.MAIN_DLG_REWARD_TIME1 = 10
UIMiscConfig.MAIN_DLG_REWARD_TIME2 = 3600
UIMiscConfig.MAIN_DLG_REWARD_TIME3 = 14400
UIMiscConfig.STAGE_HOOK_BOX_UPDATE_CD = 5
UIMiscConfig.PREDICT_AWARD_APPEAR_ANI_CD = 180
UIMiscConfig.FADE_BGM_DURATION = 0.2
UIMiscConfig.FLY_ICON_SPLIT = {
	{
		1,
		1
	},
	{
		2,
		1
	},
	{
		3,
		1
	},
	{
		4,
		1
	},
	{
		5,
		1
	},
	{
		9,
		2
	},
	{
		50,
		3
	},
	{
		1000,
		5
	}
}

function UIMiscConfig.getFlyIconSplit(num)
	if not num then
		return 1
	end

	local splitInfo = UIMiscConfig.FLY_ICON_SPLIT

	for i, kvList in ipairs(splitInfo) do
		local lvNum = kvList[1]

		if num <= lvNum then
			return kvList[2]
		end

		if i == #splitInfo then
			return kvList[2]
		end
	end
end

UIMiscConfig.MAIL_TITLE_CLIP_LENGTH = 18
UIMiscConfig.SPECIAL_SHOW_MIN_THRESHOLD = 15
UIMiscConfig.SPECIAL_SHOW_MAX_THRESHOLD = 30

function UIMiscConfig.HeroUnlockSpecialIdle(heroInfo)
	local prop = heroInfo.step

	if prop >= 1 then
		return true
	else
		return false
	end
end

UIMiscConfig.HINT_HERO_SELL_COUNT = 10
UIMiscConfig.PERFORM_MUTE_AUDIOS = {
	"Audios/SFX/UI/ui_goldfall.ogg",
	"Audios/SFX/UI/ui_hook_golddrop.ogg",
	"Audios/SFX/UI/ui_map_cut.ogg"
}
UIMiscConfig.GIFT_NOTICE_SHOW_TIME = 10
UIMiscConfig.FIRST_RECHARGE_JUMP_INFO = {
	{
		2,
		11,
		"mallDlg",
		36
	},
	{
		3,
		30,
		"mallDlg",
		14
	},
	{
		2,
		40,
		"mallDlg",
		47
	}
}
UIMiscConfig.VOCAL_ID_FIRST_RECHARGE = 3
UIMiscConfig.VOCAL_ID_PUSH_GIFT = 6
UIMiscConfig.VOCAL_ID_FIRST_REC_JUMP = 1495
UIMiscConfig.VOCAL_ID_VIP_RECHARGE = 8
UIMiscConfig.FIRST_RECHARGE_UI_ID = 9999
UIMiscConfig.VIP_UI_ID = 8888
UIMiscConfig.ACTGIFT_IN_MALL_TIME_TIP = {
	{
		Lang.get(48650)
	},
	[2001] = {
		Lang.get(48651)
	},
	[2003] = {
		Lang.get(48652)
	}
}
UIMiscConfig.SKIN_DEFAULT_ATTRTYPE_SKIN = {
	12,
	14
}
UIMiscConfig.SKIN_DEFAULT_ATTRTYPE_BASE = {
	19,
	20
}
UIMiscConfig.NO_GROUP_ACTIVITY_CONFIG = {
	template_path = "ActivityContent33",
	template_type = "ActivityMainBannerPage",
	icon_path = "NoAlpha/Activity",
	front_icon = "TxtFrontPage33",
	front_icon_path = "NoAlpha/Activity",
	icon = "TxtFrontPage33",
	desc = "",
	age_desc = Lang.get(77961)
}

return UIMiscConfig
