-- chunkname: @modules/logic/versionactivity2_8/activity2nd/define/Activity2ndEnum.lua

module("modules.logic.versionactivity2_8.activity2nd.define.Activity2ndEnum", package.seeall)

local Activity2ndEnum = _M

Activity2ndEnum.ActivityId = {
	V2a8_PVPopupReward = 12881,
	SkinCuffActivity = 12867,
	ActiveActivity = 12864,
	MailActivty = 12866,
	TakePhotosActivity = 12865,
	AnnualReview = 12879,
	welfareActivity = 12863
}
Activity2ndEnum.ActivityOrder = {
	Activity2ndEnum.ActivityId.AnnualReview,
	Activity2ndEnum.ActivityId.SkinCuffActivity,
	Activity2ndEnum.ActivityId.TakePhotosActivity,
	Activity2ndEnum.ActivityId.welfareActivity,
	Activity2ndEnum.ActivityId.ActiveActivity
}
Activity2ndEnum.ShowTipsType = {
	Error = "anniversary_typingtips_5",
	HeroName = "anniversary_typingtips_2",
	DungeonName = "anniversary_typingtips_3",
	FirstEnter = "anniversary_typingtips_1",
	SocialMedia = "anniversary_typingtips_4",
	HasGetReward = "anniversary_typingtips_6"
}
Activity2ndEnum.RandomType = {
	Activity2ndEnum.ShowTipsType.FirstEnter,
	Activity2ndEnum.ShowTipsType.HeroName,
	Activity2ndEnum.ShowTipsType.DungeonName,
	Activity2ndEnum.ShowTipsType.SocialMedia
}
Activity2ndEnum.StatButtonName = {
	[Activity2ndEnum.ActivityId.MailActivty] = "act_yearly_letter",
	[Activity2ndEnum.ActivityId.AnnualReview] = "act_yearly_report",
	[Activity2ndEnum.ActivityId.SkinCuffActivity] = "act_skin_collection",
	[Activity2ndEnum.ActivityId.TakePhotosActivity] = "act_shooting",
	[Activity2ndEnum.ActivityId.welfareActivity] = "act_free_role",
	[Activity2ndEnum.ActivityId.ActiveActivity] = "act_28summon"
}
Activity2ndEnum.ActivityViewName = {
	ViewName.Activity2ndMailView,
	ViewName.Activity2ndTakePhotosView,
	ViewName.Activity197View,
	ViewName.V2a8_SelfSelectCharacterView,
	ViewName.Activity2ndShowSkinView
}
Activity2ndEnum.DISPLAY_SKIN_COUNT = 4
Activity2ndEnum.Index2GoodsId = {
	nil,
	5102801,
	5102802,
	5102803
}
Activity2ndEnum.ShowSkin4 = 304002

return Activity2ndEnum
