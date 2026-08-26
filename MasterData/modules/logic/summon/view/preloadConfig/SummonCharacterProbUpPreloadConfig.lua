-- chunkname: @modules/logic/summon/view/preloadConfig/SummonCharacterProbUpPreloadConfig.lua

module("modules.logic.summon.view.preloadConfig.SummonCharacterProbUpPreloadConfig", package.seeall)

local SummonCharacterProbUpPreloadConfig = class("SummonCharacterProbUpPreloadConfig")

SummonCharacterProbUpPreloadConfig.preloadLists = {}
SummonCharacterProbUpPreloadConfig.characterItemCounts = {}

function SummonCharacterProbUpPreloadConfig.getPreLoadListByName(name)
	return SummonCharacterProbUpPreloadConfig.preloadLists[name] or nil
end

function SummonCharacterProbUpPreloadConfig.getCharacterItemCountByName(name)
	return SummonCharacterProbUpPreloadConfig.characterItemCounts[name] or 1
end

SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer381 = {
	"singlebg/summon/heroversion_3_8/v3a8_dianjishi/v3a8_dianjishi_role.png",
	"singlebg/summon/heroversion_3_8/v3a8_dianjishi/v3a8_dianjishi_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer383 = {
	"singlebg/summon/heroversion_3_8/v3a8_falangyan/v3a8_falangyan_role.png",
	"singlebg/summon/heroversion_3_8/v3a8_falangyan/v3a8_falangyan_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonStrongOneCustomPick38 = {
	"singlebg/characterdestiny/character_destiny_new_fullbg01.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_reshapefullbg.png",
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role1.png",
	"singlebg/summon/heroversion_3_8/v3a8_selfselectsix/v3a8_selfselectsix_role.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer384 = {
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_dec4.png",
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_role1.png",
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer382 = {
	"singlebg/summon/heroversion_3_4/v3a4_lusijian/v3a4_lusijian_dec04.png",
	"singlebg/summon/heroversion_3_4/v3a4_lusijian/v3a4_lusijian_rolefront_bg.png",
	"singlebg/summon/heroversion_3_4/v3a4_lusijian/v3a4_lusijian_role.png",
	"singlebg/summon/heroversion_3_5/v3a5_luolunzi/v3a5_luolunzi_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer380 = {
	"singlebg/summon/heroversion_3_8/v3a8_huishengyao/v3a8_huishengyao_roel.png",
	"singlebg/summon/heroversion_3_8/v3a8_huishengyao/v3a8_huishengyao_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer3852 = {
	"singlebg/summon/heroversion_3_0/v3a0_malianna/v3a0_malianna_role.png",
	"singlebg/summon/heroversion_3_0/v3a0_malianna/v3a0_malianna_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonStrongOneCustomPick385 = {
	"singlebg/characterdestiny/character_destiny_new_fullbg01.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_reshapefullbg.png",
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role1.png",
	"singlebg/summon/heroversion_sp02/sp02_selfselectsix/sp02_selfselectsix_role.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer371 = {
	"singlebg/summon/heroversion_3_7/v3a7_xiaoruian/v3a7_xiaoruian_dec01.png",
	"singlebg/summon/heroversion_3_7/v3a7_xiaoruian/v3a7_xiaoruian_dec04.png",
	"singlebg/summon/heroversion_3_7/v3a7_xiaoruian/v3a7_xiaoruian_mask.png",
	"singlebg/summon/heroversion_3_7/v3a7_xiaoruian/v3a7_xiaoruian_role.png",
	"singlebg/summon/heroversion_3_7/v3a7_xiaoruian/v3a7_xiaoruian_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer363 = {
	"singlebg/summon/heroversion_3_6/v3a6_yami/v3a6_yami_role.png",
	"singlebg/summon/heroversion_3_6/v3a6_yami/v3a6_yami_mask.png",
	"singlebg/summon/heroversion_3_6/v3a6_yami/v3a6_yami_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer372 = {
	"singlebg/summon/heroversion_3_7/v3a7_wumingzhe/v3a7_wumingzhe_role.png",
	"singlebg/summon/heroversion_3_7/v3a7_wumingzhe/v3a7_wumingzhe_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonOneCustomPickView = {
	"singlebg/summon/heroversion_1_9/selfselectsix/v1a9_selfselectsix_summon_frontbg.png",
	"singlebg/summon/heroversion_2_2/selfselectsix/v2a2_selfselectsix_summon_line.png",
	"singlebg/summon/heroversion_3_7/v3a7_selfselect2/v3a7_selfselect2_rolebg.png",
	"singlebg/summon/heroversion_2_8/v2a8_selfselect2/v2a8_selfselect2_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer376 = {
	"singlebg/summon/heroversion_2_8/v2a8_nuodika/v2a8_summon_nuodika_rolebg.png",
	"singlebg/summon/heroversion_2_8/v2a8_nuodika/v2a8_summon_nuodika_decbg.png",
	"singlebg/summon/heroversion_2_8/v2a8_nuodika/v2a8_summon_nuodika_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer375 = {
	"singlebg/summon/heroversion_2_8/v2a8_molideer/v2a8_summon_molideer_fontbg.png",
	"singlebg/summon/heroversion_3_3/v3a3_yigeer/v3a3_yigerer_role1.png",
	"singlebg/summon/heroversion_3_3/v3a3_yigeer/v3a3_yigerer_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer374 = {
	"singlebg/summon/heroversion_2_4/v2a4_tutushizi/v2a4_summon_tutushizi_role1.png",
	"singlebg/summon/heroversion_2_4/v2a4_tutushizi/v2a4_summon_tutushizi_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer373 = {
	"singlebg/summon/heroversion_3_0/v3a0_malianna/v3a0_malianna_role.png",
	"singlebg/summon/heroversion_3_0/v3a0_malianna/v3a0_malianna_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonStrongOneCustomPick37 = {
	"singlebg/characterdestiny/character_destiny_new_fullbg01.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_reshapefullbg.png",
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role1.png",
	"singlebg/summon/heroversion_3_7/v3a7_selfselectsix/v3a7_selfselectsi_role.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer339 = {
	"singlebg/summon/heroversion_3_4/v3a4_cengheguang/v3a4_cengheguang_dec02.png",
	"singlebg/summon/heroversion_3_4/v3a4_cengheguang/v3a4_cengheguang_role1.png",
	"singlebg/summon/heroversion_3_4/v3a4_cengheguang/v3a4_cengheguang_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer338 = {
	"singlebg/summon/heroversion_2_7/v2a7_coopergarland/v2a7_summon_coopergarland_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer337 = {
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_dec4.png",
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_role1.png",
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer336 = {
	"singlebg/summon/heroversion_3_1/v3a1_gaosiniao/v3a1_gaosiniao_light.png",
	"singlebg/summon/heroversion_3_1/v3a1_yeshumei/v3a1_yeshumei_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer335 = {
	"singlebg/summon/heroversion_3_4/v3a4_lusijian/v3a4_lusijian_dec02.png",
	"singlebg/summon/heroversion_3_4/v3a4_lusijian/v3a4_lusijian_dec01.png",
	"singlebg/summon/heroversion_3_4/v3a4_lusijian/v3a4_lusijian_dec04.png",
	"singlebg/summon/heroversion_3_4/v3a4_lusijian/v3a4_lusijian_role.png",
	"singlebg/summon/heroversion_3_4/v3a4_lusijian/v3a4_lusijian_role_outline.png",
	"singlebg/summon/heroversion_3_4/v3a4_lusijian/v3a4_lusijian_rolefront_bg.png",
	"singlebg/summon/heroversion_3_4/v3a4_lusijian/v3a4_lusijian_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists[" SummonCharacterProbUpVer334"] = {
	"singlebg/summon/heroversion_2_8/v2a8_molideer/v2a8_summon_molideer_fontbg.png",
	"singlebg/summon/heroversion_3_3/v3a3_yigeer/v3a3_yigerer_role1.png",
	"singlebg/summon/heroversion_3_3/v3a3_yigeer/v3a3_yigerer_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer333 = {
	"singlebg/summon/heroversion_2_8/v2a8_molideer/v2a8_summon_molideer_fontbg.png",
	"singlebg/summon/heroversion_3_3/v3a3_maersha/v3a3_maersha_role2.png",
	"singlebg/summon/heroversion_3_3/v3a3_maersha/v3a3_maerhsa_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonStrongOneCustomPick33 = {
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role1.png",
	"singlebg/summon/heroversion_3_3/v3a3_selfselectsix_role.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer331 = {
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_decbg1.png",
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_role1.png",
	"singlebg/summon/heroversion_2_5/v2a5_feilinshiduo/v2a5_summon_feilinshiduo_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer330 = {
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_decbg.png",
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_rolebg.png",
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer332 = {
	"singlebg/summon/heroversion_2_8/v2a8_molideer/v2a8_summon_molideer_fontbg.png",
	"singlebg/summon/heroversion_2_8/v2a8_molideer/v2a8_summon_molideer_role.png",
	"singlebg/summon/heroversion_2_8/v2a8_molideer/v2a8_summon_molideer_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer323 = {
	"singlebg/summon/heroversion_3_0/v3a0_malianna/v3a0_malianna_role.png",
	"singlebg/summon/heroversion_3_0/v3a0_malianna/v3a0_malianna_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer327 = {
	"singlebg/summon/heroversion_3_2/v3a2_huidiaolan/v3a2_summonhuidiaolan_role1.png",
	"singlebg/summon/heroversion_3_2/v3a2_huidiaolan/v3a2_summonhuidiaolan_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonStrongOneCustomPick32 = {
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role1.png",
	"singlebg/summon/heroversion_3_2/v3a2_selfselectsix_role.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer326 = {
	"singlebg/summon/heroversion_2_2/selfselectsix/v2a2_selfselectsix_summon_line4_2.png",
	"singlebg/summon/heroversion_2_2/selfselectsix/v2a2_selfselectsix_summon_line4_1.png",
	"singlebg/summon/heroversion_2_2/selfselectsix/v2a2_selfselectsix_summon_fullbg2.png",
	"singlebg/summon/heroversion_2_2/selfselectsix/v2a2_selfselectsix_summon_line.png",
	"singlebg/summon/heroversion_3_2/v3a2_selfselectnine/v3a2_selfselectnine_rolemask.png",
	"singlebg/summon/heroversion_2_2/selfselectsix/v2a2_selfselectsix_summon_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer328 = {
	"singlebg/summon/heroversion_3_2/v3a2_beilier/v3a2_beilier_role.png",
	"singlebg/summon/heroversion_3_2/v3a2_beilier/v3a2_beilier_dec4.png",
	"singlebg/summon/heroversion_3_2/v3a2_beilier/v3a2_beilier_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer325 = {
	"singlebg/summon/heroversion_3_0/v3a0_karong/v3a0_karong_role.png",
	"singlebg/summon/heroversion_3_2/v3a2_wuerlixi/v3a2_summon_wuerlixi_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer307 = {
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_dec2.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_dec1.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_role.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer315 = {
	"singlebg/summon/heroversion_3_1/v3a1_gaosiniao/v3a1_gaosiniao_role1.png",
	"singlebg/summon/heroversion_3_1/v3a1_gaosiniao/v3a1_gaosiniao_light.png",
	"singlebg/summon/heroversion_3_1/v3a1_gaosiniao/v3a1_gaosiniao_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer314 = {
	"singlebg/summon/heroversion_3_1/v3a1_gaosiniao/v3a1_gaosiniao_light.png",
	"singlebg/summon/heroversion_3_1/v3a1_yeshumei/v3a1_yeshumei_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer313 = {
	"singlebg/summon/heroversion_1_9/kakaniya/v1a9_kakaniya_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer312 = {
	"singlebg/summon/heroversion_2_6/dicehero/v2a6_dicehero_summon_role4.png",
	"singlebg/summon/heroversion_2_6/dicehero/v2a6_dicehero_summon_role3.png",
	"singlebg/summon/heroversion_2_6/dicehero/v2a6_dicehero_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer311 = {
	"singlebg/summon/heroversion_2_7/v2a7_coopergarland/v2a7_summon_coopergarland_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer306 = {
	"singlebg/summon/heroversion_2_6/dicehero/v2a6_dicehero_summon_role3.png",
	"singlebg/summon/heroversion_2_7/v2a7_hissabeth/v2a7_summon_hissabeth_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer305 = {
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_dec4.png",
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_role1.png",
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer304 = {
	"singlebg/summon/heroversion_1_4/role37/v1a4_role37_bottombg.png",
	"singlebg/summon/heroversion_1_4/role37/v1a4_role37_summon_37.png",
	"singlebg/summon/heroversion_1_7/37/full/v1a7_37_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonStrongOneCustomPick31 = {
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role1.png",
	"singlebg/summon/heroversion_3_1/v3a1_selfselectsix_role.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonStrongOneCustomPick29 = {
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role1.png",
	"singlebg/summon/heroversion_2_9/v2a9_selfselectsix_role.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer303 = {
	"singlebg/summon/heroversion_2_6/xugouji/v2a6_xugouji_fontbg2.png",
	"singlebg/summon/heroversion_2_6/xugouji/v2a6_xugouji_role.png",
	"singlebg/summon/heroversion_2_6/xugouji/v2a6_xugouji_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer302 = {
	"singlebg/summon/heroversion_3_0/v3a0_malianna/v3a0_malianna_role.png",
	"singlebg/summon/heroversion_3_0/v3a0_malianna/v3a0_malianna_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonStrongOneCustomPick30 = {
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role1.png",
	"singlebg/summon/heroversion_3_0/v3a0_selfselectsix_role.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer301 = {
	"singlebg/summon/heroversion_2_8/v2a8_molideer/v2a8_summon_molideer_role.png",
	"singlebg/summon/heroversion_3_0/v3a0_karong/v3a0_karong_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer286 = {
	"singlebg/summon/heroversion_2_0/joe/v2a0_joe_role1.png",
	"singlebg/summon/heroversion_2_0/joe/full/v2a0_joe_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer285 = {
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_decbg1.png",
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_role1.png",
	"singlebg/summon/heroversion_2_5/v2a5_feilinshiduo/v2a5_summon_feilinshiduo_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer284 = {
	"singlebg/summon/heroversion_2_0/mercury/v2a0_mercury_role1.png",
	"singlebg/summon/heroversion_2_0/mercury/full/v2a0_mercury_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer283 = {
	"singlebg/summon/heroversion_2_8/v2a8_molideer/v2a8_summon_molideer_fontbg.png",
	"singlebg/summon/heroversion_2_8/v2a8_molideer/v2a8_summon_molideer_role.png",
	"singlebg/summon/heroversion_2_8/v2a8_molideer/v2a8_summon_molideer_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer282 = {
	"singlebg/summon/heroversion_2_8/v2a8_nuodika/v2a8_summon_nuodika_rolebg.png",
	"singlebg/summon/heroversion_2_8/v2a8_nuodika/v2a8_summon_nuodika_decbg.png",
	"singlebg/summon/heroversion_2_8/v2a8_nuodika/v2a8_summon_nuodika_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonStrongOneCustomPick28 = {
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role1.png",
	"singlebg/summon/heroversion_2_8/v2a8_selfselectsix_role.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer281 = {
	"singlebg/summon/heroversion_1_9/lucy/v1a9_lucy_decbg2.png",
	"singlebg/summon/heroversion_1_9/lucy/v1a9_lucy_rolebg.png",
	"singlebg/summon/heroversion_1_9/lucy/v1a9_lucy_decbg1.png",
	"singlebg/summon/heroversion_1_9/lucy/v1a9_lucy_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer265 = {
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_dec4.png",
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_role1.png",
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer274 = {
	"singlebg/summon/heroversion_2_6/dicehero/v2a6_dicehero_summon_role4.png",
	"singlebg/summon/heroversion_2_6/dicehero/v2a6_dicehero_summon_role3.png",
	"singlebg/summon/heroversion_2_7/v2a7_hissabeth/v2a7_summon_hissabeth_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer275 = {
	"singlebg/summon/heroversion_2_6/dicehero/v2a6_dicehero_summon_role4.png",
	"singlebg/summon/heroversion_2_6/dicehero/v2a6_dicehero_summon_role3.png",
	"singlebg/summon/heroversion_2_7/v2a7_coopergarland/v2a7_summon_coopergarland_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer264 = {
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_decbg.png",
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_rolebg.png",
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer273 = {
	"singlebg/summon/heroversion_2_1/tuesday/v2a1_tuesday_frontbg1.png",
	"singlebg/summon/heroversion_2_1/tuesday/v2a1_tuesday_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer271 = {
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_decbg1.png",
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_role1.png",
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer272 = {
	"singlebg/summon/heroversion_2_4/v2a4_tutushizi/v2a4_summon_tutushizi_role1.png",
	"singlebg/summon/heroversion_2_4/v2a4_tutushizi/v2a4_summon_tutushizi_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonStrongOneCustomPick27 = {
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role1.png",
	"singlebg/summon/heroversion_2_7/v2a7_selfselectsix_role.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer263 = {
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_dec2.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_dec1.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_role.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer262 = {
	"singlebg/summon/heroversion_2_6/dicehero/v2a6_dicehero_summon_role4.png",
	"singlebg/summon/heroversion_2_6/dicehero/v2a6_dicehero_summon_role3.png",
	"singlebg/summon/heroversion_2_6/dicehero/v2a6_dicehero_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer261 = {
	"singlebg/summon/heroversion_2_6/xugouji/v2a6_xugouji_fontbg2.png",
	"singlebg/summon/heroversion_2_6/xugouji/v2a6_xugouji_role.png",
	"singlebg/summon/heroversion_2_6/xugouji/v2a6_xugouji_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonStrongOneCustomPick24 = {
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png",
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role1.png",
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role2.png",
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role3.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonStrongOneCustomPick25 = {
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png",
	"singlebg/summon/heroversion_2_5/v2a5_selfselectsix2/v2a5_selfselectsix_role.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonStrongOneCustomPick26 = {
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png",
	"singlebg/summon/heroversion_2_6/v2a6_selfselectsix_role.png",
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role1.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer251 = {
	"singlebg/summon/heroversion_2_5/v2a5_liangyue/v2a5_summon_liangyue_fontbg.png",
	"singlebg/summon/heroversion_2_5/v2a5_liangyue/v2a5_summon_liangyue_role.png",
	"singlebg/summon/heroversion_2_5/v2a5_liangyue/v2a5_summon_liangyue_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer111 = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg"),
	ResUrl.getSummonCoverBg("heroversion_1_1/bg_zsz")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer112 = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg1"),
	ResUrl.getSummonCoverBg("heroversion_1_1/fg")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer113 = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg_hnj"),
	ResUrl.getSummonCoverBg("heroversion_1_1/hongnujian/img_role_hongnujian")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer114 = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg_bfz"),
	ResUrl.getSummonCoverBg("heroversion_1_1/baifuzhang/img_role_baifuzhang")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer115 = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg_xt"),
	ResUrl.getSummonCoverBg("heroversion_1_1/xingti/img_role_xingti")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer116 = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg_fjs")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer121 = {
	ResUrl.getSummonCoverBg("heroversion_1_2/wenni/full/img_bg")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer122 = {
	ResUrl.getSummonCoverBg("heroversion_1_2/xinbabieta/full/img_bg")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer123 = {
	ResUrl.getSummonCoverBg("heroversion_1_2/yuanlv/full/img_bg")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer124 = {
	ResUrl.getSummonCoverBg("heroversion_1_2/jiaxika/full/bg"),
	ResUrl.getSummonCoverBg("heroversion_1_2/jiaxika/full/img_qianjing")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer125 = {
	ResUrl.getSummonCoverBg("heroversion_1_2/yaxian/full/img_bg"),
	ResUrl.getSummonCoverBg("heroversion_1_2/yaxian/img_qianjing")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer126 = {
	ResUrl.getSummonCoverBg("heroversion_1_2/nimengdishi/full/bg_da"),
	ResUrl.getSummonCoverBg("heroversion_1_2/nimengdishi/bg_zhezhao")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer131 = {
	ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/full/v1a3_rabbit_bg")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer132 = {
	ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/full/v1a3_zongmaoshali_bg_full"),
	ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/full/v1a3_zongmaoshali_bg_light"),
	ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/full/v1a3_zongmaoshali_bg_middle")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer133 = {
	ResUrl.getSummonCoverBg("heroversion_1_3/galapona/full/v1a3_galapona_bg"),
	ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_bg1"),
	ResUrl.getSummonCoverBg("heroversion_1_3/galapona/full/v1a3_galapona_dec")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer141 = {
	"singlebg/summon/heroversion_1_4/fourroles/full/v1a4_fourroles_summon_bg.png",
	"singlebg/summon/heroversion_1_4/fourroles/v1a4_fourroles_bottombg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer142 = {
	ResUrl.getSummonCoverBg("heroversion_1_4/role37/full/v1a4_role37_summon_bg")
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer143 = {
	"singlebg/summon/heroversion_1_4/role6/full/v1a4_role6_summon_bg.png",
	"singlebg/summon/heroversion_1_4/role6/v1a4_role6_summon_6.png",
	"singlebg/summon/heroversion_1_4/role6/v1a4_role6_bottombg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer144 = {
	"singlebg/summon/heroversion_1_1/full/bg_xt.png",
	"singlebg/summon/heroversion_1_1/xingti/img_role_xingti.png",
	"singlebg/summon/hero/bg_1.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer145 = {
	"singlebg/summon/hero/full/bg111.png",
	"singlebg/summon/hero/role3.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer146 = {
	"singlebg/summon/heroversion_1_1/full/bg_fjs.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer151 = {
	"singlebg/summon/heroversion_1_5/rolekerandian/full/v1a5_rolekerandian_summon_bg.png",
	"singlebg/summon/heroversion_1_5/rolekerandian/v1a5_kerandian_middlebg.png",
	"singlebg/summon/heroversion_1_5/rolekerandian/v1a5_rolekerandian_summon_role1.png",
	"singlebg/summon/heroversion_1_5/rolekerandian/v1a5_kerandian_fontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer152 = {
	"singlebg/summon/heroversion_1_5/v1a5_yaxian/v1a5_yaxian_summon_fullbg.png",
	"singlebg/summon/heroversion_1_5/v1a5_yaxian/v1a5_yaxian_summon_role2.png",
	"singlebg/summon/heroversion_1_5/v1a5_yaxian/v1a5_yaxian_summon_fontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer153 = {
	"singlebg/summon/heroversion_1_5/v1a5_baifuzhang/v1a5_baifuzhang_summon_fullbg.png",
	"singlebg/summon/heroversion_1_1/baifuzhang/img_role_baifuzhang.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer154 = {
	"singlebg/summon/heroversion_1_5/aizila/full/v1a5_roleaizila_summon_fullbg.png",
	"singlebg/summon/heroversion_1_5/aizila/v1a5_roleaizila_summon_role3.png",
	"singlebg/summon/heroversion_1_5/aizila/v1a5_aizila_fontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer155 = {
	"singlebg/summon/heroversion_1_5/v1a5_weixiukai/v1a5_weixiukai_summon_fullbg.png",
	"singlebg/summon/heroversion_1_5/v1a5_weixiukai/v1a5_weixiukai_summon_frontbg.png",
	"singlebg/summon/heroversion_1_5/v1a5_weixiukai/v1a5_roleweixiukai_summon_role1.png",
	"singlebg/summon/hero/full/mask.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer161 = {
	"singlebg/summon/heroversion_1_6/getian/full/v1a6_getian_summon_fullbg.png",
	"singlebg/summon/heroversion_1_6/getian/v1a6_getian_summon_role1.png",
	"singlebg/summon/heroversion_1_6/getian/v1a6_getian_summon_fontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer162 = {
	"singlebg/summon/heroversion_1_6/quniang/full/v1a6_quniang_summon_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer163 = {
	"singlebg/summon/heroversion_1_6/v1a6_meilanni/v1a6_rolemeilanni_summon_fullbg.png",
	"singlebg/summon/heroversion_1_1/bg_zsz.png",
	"singlebg/summon/heroversion_1_6/v1a6_meilanni/v1a6_rolemeilanni_summon_role1.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer164 = {
	"singlebg/summon/heroversion_1_6/v1a6_pikelesi/v1a6_pikelesi_summon_fullbg.png",
	"singlebg/summon/heroversion_1_6/v1a6_pikelesi/v1a6_pikelesi_summon_caidaibg.png",
	"singlebg/summon/heroversion_1_6/v1a6_pikelesi/v1a6_rolepikelesi_summon_role1.png",
	"singlebg/summon/heroversion_1_6/v1a6_pikelesi/v1a6_pikelesi_summon_frontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer165 = {
	"singlebg/summon/heroversion_1_6/v1a6_zongmaoshali/v1a6_zongmaoshali_fullbg.png",
	"singlebg/summon/heroversion_1_6/v1a6_zongmaoshali/v1a6_zongmaoshali_role1.png",
	"singlebg/summon/heroversion_1_6/v1a6_zongmaoshali/v1a6_zongmaoshali_middlebg.png",
	"singlebg/summon/heroversion_1_6/v1a6_zongmaoshali/v1a6_zongmaoshali_lightbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer171 = {
	"singlebg/summon/heroversion_1_7/yisuerde/full/bg.png",
	"singlebg/summon/heroversion_1_7/yisuerde/yisuoerde.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer172 = {
	"singlebg/summon/heroversion_1_7/makusi/full/v1a7_makusi_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer173 = {
	"singlebg/summon/heroversion_1_7/37/full/v1a7_37_fullbg.png",
	"singlebg/summon/heroversion_1_4/role37/v1a4_role37_summon_37.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer174 = {
	"singlebg/summon/heroversion_1_7/jiexika/full/v1a7_jiexika_fullbg.png",
	"singlebg/summon/heroversion_1_7/jiexika/v1a7_rolejiexika.png",
	"singlebg/summon/heroversion_1_7/jiexika/full/v1a7_jiexika_frontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer175 = {
	"singlebg/summon/heroversion_1_7/v1a7_role6/v1a7_role6_summon_fullbg.png",
	"singlebg/summon/heroversion_1_4/role6/v1a4_role6_summon_6.png",
	"singlebg/summon/heroversion_1_4/role6/v1a4_role6_bottombg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer181 = {
	"singlebg/summon/heroversion_1_3/galapona/full/v1a3_galapona_bg.png",
	"singlebg/summon/heroversion_1_8/v1a8_jialabona/v1a8_jialabona_summon_dec2.png",
	"singlebg/summon/heroversion_1_8/v1a8_jialabona/v1a8_jialabona_summon_dec1.png",
	"singlebg/summon/heroversion_1_3/galapona/v1a3_galapona_role1.png",
	"singlebg/summon/heroversion_1_3/galapona/full/v1a3_galapona_dec.png",
	"singlebg/summon/heroversion_1_3/galapona/v1a3_galapona_line1.png",
	"singlebg/summon/heroversion_1_3/galapona/v1a3_galapona_line3.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer182 = {
	"singlebg/summon/heroversion_1_8/v1a8_role6/v1a8_role6_summon_fullbg.png",
	"singlebg/summon/heroversion_1_4/role6/v1a4_role6_summon_6.png",
	"singlebg/summon/heroversion_1_4/role6/v1a4_role6_bottombg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer183 = {
	"singlebg/summon/heroversion_1_1/full/bg_xt.png",
	"singlebg/summon/hero/3025.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer184 = {
	"singlebg/summon/heroversion_1_8/v1a8_windsong/v1a8_windsong_summon_fullbg.png",
	"singlebg/summon/heroversion_1_8/v1a8_windsong/v1a8_windsong_summon_role1.png",
	"singlebg/summon/heroversion_1_8/v1a8_windsong/v1a8_windsong_summon_dec2.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer185 = {
	"singlebg/summon/heroversion_1_8/v1a8_weila/v1a8_weila_fullbg.png",
	"singlebg/summon/heroversion_1_8/v1a8_weila/v1a8_weila_role1.png",
	"singlebg/summon/heroversion_1_8/v1a8_weila/v1a8_weila_frontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer186 = {
	"singlebg/summon/heroversion_1_5/rolekerandian/full/v1a5_rolekerandian_summon_bg.png",
	"singlebg/summon/heroversion_1_5/rolekerandian/v1a5_kerandian_middlebg.png",
	"singlebg/summon/heroversion_1_5/rolekerandian/v1a5_rolekerandian_summon_role1.png",
	"singlebg/summon/heroversion_1_5/rolekerandian/v1a5_kerandian_fontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer191 = {
	"singlebg/summon/heroversion_1_9/kakaniya/v1a9_kakaniya_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer192 = {
	"singlebg/summon/heroversion_1_9/lucy/v1a9_lucy_fullbg.png",
	"singlebg/summon/heroversion_1_9/lucy/v1a9_lucy_decbg1.png",
	"singlebg/summon/heroversion_1_9/lucy/v1a9_lucy_rolebg.png",
	"singlebg/summon/heroversion_1_9/lucy/v1a9_lucy_decbg2.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer193 = {
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_fullbg.png",
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_role1.png",
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_fontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer194 = {
	"singlebg/summon/heroversion_1_9/yaxian/v1a9_yaxian_summon_fullbg.png",
	"singlebg/summon/heroversion_1_9/yaxian/v1a9_yaxian_summon_role1.png",
	"singlebg/summon/heroversion_1_9/yaxian/v1a9_yaxian_summon_fontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer195 = {
	"singlebg/summon/heroversion_1_9/yuanlv/v1a9_yuanlv_summon_fullbg.png",
	"singlebg/summon/heroversion_1_9/yuanlv/v1a9_yuanlv_summon_role1.png",
	"singlebg/summon/heroversion_1_9/yuanlv/v1a9_yuanlv_summon_mask.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer201 = {
	"singlebg/summon/heroversion_2_0/joe/full/v2a0_joe_fullbg.png",
	"singlebg/summon/heroversion_2_0/joe/v2a0_joe_role1.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer202 = {
	"singlebg/summon/heroversion_2_0/mercury/full/v2a0_mercury_fullbg.png",
	"singlebg/summon/heroversion_2_0/mercury/v2a0_mercury_role1.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer203 = {
	"singlebg/summon/heroversion_2_0/yisuerde/full/v2a0_yisuoerde_fullbg.png",
	"singlebg/summon/heroversion_2_0/yisuerde/v2a0_yisuoerde_role1.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer204 = {
	"singlebg/summon/heroversion_2_0/galapona/full/v2a0_galapona_bg.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec2.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec2.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec1.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec1.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_role1.png",
	"singlebg/summon/heroversion_2_0/galapona/full/v2a0_galapona_dec.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_line1.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_line3.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer205 = {
	"singlebg/summon/heroversion_2_0/aizila/full/v2a0_roleaizila_summon_fullbg.png",
	"singlebg/summon/heroversion_2_0/aizila/v2a0_roleaizila_summon_role3.png",
	"singlebg/summon/heroversion_2_0/aizila/v2a0_aizila_fontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer211 = {
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_fullbg.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_role1.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_frontbg1.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_frontbg2.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer212 = {
	"singlebg/summon/heroversion_2_1/windsong/v2a1_windsong_summon_fullbg.png",
	"singlebg/summon/heroversion_2_1/windsong/v2a1_windsong_summon_role1.png",
	"singlebg/summon/heroversion_2_1/windsong/v2a1_windsong_summon_dec2.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer213 = {
	"singlebg/summon/heroversion_2_1/makusi/full/v2a1_makusi_fullbg.png",
	"singlebg/summon/heroversion_2_1/makusi/v2a1_makusi_role3.png",
	"singlebg/summon/heroversion_2_1/makusi/v2a1_makusi_middlebg.png",
	"singlebg/summon/heroversion_2_1/makusi/v2a1_makusi_frontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer214 = {
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_fullbg.png",
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_role1.png",
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_frontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer215 = {
	"singlebg/summon/heroversion_2_1/tuesday/v2a1_tuesday_fullbg.png",
	"singlebg/summon/heroversion_2_1/tuesday/v2a1_tuesday_frontbg1.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer221 = {
	"singlebg/summon/heroversion_2_2/v2a2_tianshinana/v2a2_tianshinana_fullbg.png",
	"singlebg/summon/heroversion_2_2/v2a2_tianshinana/v2a2_tianshinana_rolebg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer222 = {
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_fullbg.png",
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_rolebg.png",
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_decbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer223 = {
	"singlebg/summon/heroversion_2_2/v2a2_yisuerde/full/v2a2_yisuoerde_fullbg.png",
	"singlebg/summon/heroversion_2_2/v2a2_yisuerde/v2a2_yisuoerde_role1.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer224 = {
	"singlebg/summon/heroversion_2_2/v2a2_role6/v2a2_role6_summon_fullbg.png",
	"singlebg/summon/heroversion_2_2/v2a2_role6/v2a2_role6_summon_6.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer225 = {
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_fullbg.png",
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_role1.png",
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_fontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer231 = {
	"singlebg/summon/heroversion_1_9/kakaniya/v1a9_kakaniya_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer232 = {
	"singlebg/summon/heroversion_2_0/joe/full/v2a0_joe_fullbg.png",
	"singlebg/summon/heroversion_2_0/joe/v2a0_joe_role1.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer233 = {
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_fullbg.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_role.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_dec1.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_dec2.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer234 = {
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_fullbg.png",
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_role1.png",
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_dec4.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer235 = {
	"singlebg/summon/heroversion_2_0/mercury/full/v2a0_mercury_fullbg.png",
	"singlebg/summon/heroversion_2_0/mercury/v2a0_mercury_role1.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer241 = {
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_fullbg.png",
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_role1.png",
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_decbg1.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer242 = {
	"singlebg/summon/heroversion_2_4/v2a4_tutushizi/v2a4_summon_tutushizi_fullbg.png",
	"singlebg/summon/heroversion_2_4/v2a4_tutushizi/v2a4_summon_tutushizi_role1.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer243 = {
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_fullbg.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_role1.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_frontbg1.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_frontbg2.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer244 = {
	"singlebg/summon/heroversion_2_1/windsong/v2a1_windsong_summon_fullbg.png",
	"singlebg/summon/heroversion_2_1/windsong/v2a1_windsong_summon_role1.png",
	"singlebg/summon/heroversion_2_1/windsong/v2a1_windsong_summon_dec2.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer252 = {
	"singlebg/summon/heroversion_2_5/v2a5_feilinshiduo/v2a5_summon_feilinshiduo_fullbg.png",
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_role1.png",
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_decbg1.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer253 = {
	"singlebg/summon/heroversion_1_6/quniang/full/v1a6_quniang_summon_fullbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer254 = {
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_fullbg.png",
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_role1.png",
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_frontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer255 = {
	"singlebg/summon/heroversion_2_1/tuesday/v2a1_tuesday_fullbg.png",
	"singlebg/summon/heroversion_2_1/tuesday/v2a1_tuesday_frontbg1.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVer256 = {
	"singlebg/summon/heroversion_2_1/makusi/full/v2a1_makusi_fullbg.png",
	"singlebg/summon/heroversion_2_1/makusi/v2a1_makusi_role3.png",
	"singlebg/summon/heroversion_2_1/makusi/v2a1_makusi_middlebg.png",
	"singlebg/summon/heroversion_2_1/makusi/v2a1_makusi_frontbg.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterCoBranding291 = {
	"singlebg/summon/heroversion_2_9/v2a9_kashandela/v2a9_summon_kashandela_fullbg.png",
	"singlebg/summon/heroversion_2_9/v2a9_kashandela/v2a9_summon_kashandela_role.png",
	"singlebg_lang/txt_summon_version_2_9/v2a9_kashandela/v2a9_summon_kashandela_title.png",
	"singlebg_lang/txt_summon_version_2_9/v2a9_kashandela/v2a9_summon_kashandela_logo.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterCoBranding292 = {
	"singlebg/summon/heroversion_2_9/v2a9_azio/v2a9_summon_azio_fullbg.png",
	"singlebg/summon/heroversion_2_9/v2a9_azio/v2a9_summon_azio_rolebg.png",
	"singlebg_lang/txt_summon_version_2_9/v2a9_azio/v2a9_summon_azio_title.png",
	"singlebg_lang/txt_summon_version_2_9/v2a9_azio/v2a9_summon_azio_logo.png"
}
SummonCharacterProbUpPreloadConfig.preloadLists.SummonCharacterProbUpVerBeta1 = {
	ResUrl.getSummonCoverBg("hero/full/bg2"),
	ResUrl.getSummonCoverBg("hero/full/mask"),
	ResUrl.getSummonCoverBg("hero/leftdown"),
	ResUrl.getSummonCoverBg("hero/rightup")
}
SummonCharacterProbUpPreloadConfig.characterItemCounts.SummonCharacterProbUpVer274 = 2
SummonCharacterProbUpPreloadConfig.characterItemCounts.SummonCharacterProbUpVer112 = 2
SummonCharacterProbUpPreloadConfig.characterItemCounts.SummonCharacterProbUpVer124 = 2
SummonCharacterProbUpPreloadConfig.characterItemCounts.SummonCharacterProbUpVer125 = 2
SummonCharacterProbUpPreloadConfig.characterItemCounts.SummonCharacterProbUpVer132 = 2
SummonCharacterProbUpPreloadConfig.characterItemCounts.SummonCharacterProbUpVer141 = 4
SummonCharacterProbUpPreloadConfig.characterItemCounts.SummonCharacterProbUpVer151 = 2
SummonCharacterProbUpPreloadConfig.characterItemCounts.SummonCharacterProbUpVer154 = 2
SummonCharacterProbUpPreloadConfig.characterItemCounts.SummonCharacterProbUpVer185 = 2
SummonCharacterProbUpPreloadConfig.characterItemCounts.SummonCharacterProbUpVer215 = 2
SummonCharacterProbUpPreloadConfig.characterItemCounts.SummonCharacterProbUpVer234 = 2

return SummonCharacterProbUpPreloadConfig
