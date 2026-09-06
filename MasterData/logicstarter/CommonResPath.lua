-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicstarter/starter/preload/CommonResPath.lua

module("logicstarter.starter.preload.CommonResPath", package.seeall)

local CommonResPath = {}

CommonResPath.FloatItem = "ui/skinlib/float_item.prefab"
CommonResPath.WaitingView = "ui/skinlib/waiting_view.prefab"
CommonResPath.PhotoMat_Additive = "ui/skinlib/ui_photo_additive.mat"
CommonResPath.VipPrivilegeTips = "ui/views/components/vipprivilege.prefab"
CommonResPath.RoleActions = "ui/views/roleactions/roleactionsview.prefab"
CommonResPath.SpineSkeletonGraphicMat = "ui/skinlib/ui_spine_skeletongraphic.mat"
CommonResPath.GrayMat = "ui/skinlib/ui_gray.mat"
CommonResPath.GrayTransitionMat = "ui/skinlib/ui_gray_transition.mat"
CommonResPath.JianYingMat = "ui/skinlib/ui_jianying.mat"
CommonResPath.NormalImageMat = "ui/skinlib/ui_image_additive.mat"
CommonResPath.loginViewPath = "ui/views/login/loginview.prefab"
CommonResPath.loginAnimTakePath = "storyconfig/animations/loginviewanimation.txt"
CommonResPath.AudioMixer = "audio/audiomixer.mixer"
CommonResPath.LoadingView = "ui/views/loading/loading.prefab"
CommonResPath.CharacterShadow = "effect/prefabs/common/shadow/character_shadow_p.prefab"
CommonResPath.MainPlayerShadow = "ui/skinlib/mainplayershadow/mainplayer_shadow_p.prefab"
CommonResPath.NpcSelectedSign = "effect/prefabs/ui/ui_npcbiaoshi_p.prefab"
CommonResPath.PlayerWalkTrace = "effect/prefabs/ui/20251219/vip10/xingzou/fx_ui_xingzou.prefab"
CommonResPath.UIBlackScreen = "ui/views/story/blackscreen.prefab"
CommonResPath.UIStoryMask = "ui/views/story/story_mask.prefab"
CommonResPath.UIStoryBkg = "ui/views/story/story_background.prefab"
CommonResPath.UIStory = "ui/views/story/story.prefab"
CommonResPath.UITaskCompelete = "ui/views/task/task_compelete.prefab"
CommonResPath.UIVideoPlaying = "ui/views/video/videoview.prefab"
CommonResPath.UIAnimationPlaying = "ui/views/video/animationplayingview.prefab"
CommonResPath.BattleUnitUIRoot = "ui/views/battle/battleunitui_root.prefab"
CommonResPath.BattleUnitUIPath = "ui/views/battle/battleunitui.prefab"
CommonResPath.BattleUnitUIPath_Enemy = "ui/views/battle/battleunitui_enemy.prefab"
CommonResPath.BattleUIDamageTxtPath = "ui/views/battle/battleunitui_damage_txt.prefab"
CommonResPath.BattleUITotalDamageTxtPath = "ui/views/battle/battleunitui_total_damage_txt.prefab"
CommonResPath.BattleUIShieldTxtPath = "ui/views/battle/battleunitui_shield_txt.prefab"
CommonResPath.BattleUISkillTextPath = "ui/views/battle/battleunitui_skill.prefab"
CommonResPath.BattleUIBuffDamage = "ui/views/battle/battleunitui_damage_text_txt.prefab"
CommonResPath.BattleDamages = "ui/views/battle/battle_damages.prefab"
CommonResPath.VigourMaxEffPath = "fx_ui_manqishi/100009_manqishitiao.prefab"
CommonResPath.VigoutMaxBuffEff = "effect/prefabs/ui/fx_ui_manqishi/100008_manqishi.prefab"
CommonResPath.BattleBuffText = "effect/prefabs/ui/fx_ui_buff/fx_ui_tisheng.prefab"
CommonResPath.BattleDebuffText = "effect/prefabs/ui/fx_ui_buff/fx_ui_xiajiang.prefab"
CommonResPath.BattleBuffVigourText = "ui/views/battle/battleunitui_vigour_txt.prefab"
CommonResPath.BattleMain = "ui/views/battle/battlemainview.prefab"
CommonResPath.BattleStart = "ui/views/battle/battlestartview.prefab"
CommonResPath.BattleDragParent = "ui/views/battle/battledragparent.prefab"
CommonResPath.BattleFaimilyBoss = "ui/views/battle/battlefamilyboss.prefab"
CommonResPath.BattleWorldBoss = "ui/views/battle/battleworldboss.prefab"
CommonResPath.BattleHeroTrial = "ui/views/battle/battleherotrial.prefab"
CommonResPath.BattleFamilyHoudingClgView = "ui/views/battle/battlefamilyhoudingclgview.prefab"
CommonResPath.BattleTimeLimitedChallenge = "ui/views/timelimitedchallenge/battlehpview.prefab"
CommonResPath.BattleStartAnim = "storyconfig/animations/ui_zhandoukaichang.txt"
CommonResPath.BattleUtlUIEff = "fx_ui_zhandou/fx_ui_chaosha.prefab"
CommonResPath.SceneTransitionFade = "scene/misc/prefabs/scene_transition_fade_p.prefab"
CommonResPath.SceneTransitionOutEff = "effect/prefabs/scene/fx_scene_tiaozhuan_sheng.prefab"
CommonResPath.SceneTransitionInEff = "effect/prefabs/scene/fx_scene_tiaozhuan_jiang.prefab"
CommonResPath.AvatarBoyP = "avatars/skeletons/70000_aoqinan_luomo/70000_aoqinan_luomo_p.prefab"
CommonResPath.AvatarGirlP = "avatars/skeletons/70003_aoqinv_luomo/70003_aoqinv_luomo_p.prefab"
CommonResPath.skinlib = {
	CommonResPath.FloatItem,
	CommonResPath.WaitingView,
	CommonResPath.PhotoMat_Additive,
	CommonResPath.SpineSkeletonGraphicMat,
	CommonResPath.GrayMat,
	CommonResPath.GrayTransitionMat,
	CommonResPath.JianYingMat,
	CommonResPath.AvatarBoyP,
	CommonResPath.AvatarGirlP
}
CommonResPath.battle = {
	CommonResPath.BattleUnitUIRoot,
	CommonResPath.BattleUnitUIPath,
	CommonResPath.BattleUnitUIPath_Enemy,
	CommonResPath.BattleUIDamageTxtPath,
	CommonResPath.BattleUISkillTextPath,
	CommonResPath.BattleUIBuffDamage,
	CommonResPath.BattleUITotalDamageTxtPath,
	CommonResPath.BattleDamages,
	CommonResPath.BattleBuffVigourText,
	CommonResPath.BattleBuffText,
	CommonResPath.BattleDebuffText,
	CommonResPath.BattleMain,
	CommonResPath.BattleDragParent,
	CommonResPath.BattleStart,
	CommonResPath.BattleFaimilyBoss,
	CommonResPath.BattleWorldBoss,
	"effect/prefabs/ui/fx_ui_kaizhan/spine_kaizhan/fx_kanzhan_spine.prefab",
	"effect/prefabs/ui/fx_ui_kaizhan/fx_kanzhan_fx.prefab",
	"effect/prefabs/ui/fx_ui_kaizhan/fx_kanzhan_xian.prefab",
	"effect/prefabs/ui/fx_ui_kaizhan/fx_kanzhan_yumao.prefab",
	"storyconfig/ui_anim_camera_dont_clear_topmost_create.prefab",
	"effect/prefabs/ui/fx_ui_zhandou/fx_ui_huihe_you.prefab",
	"effect/prefabs/ui/fx_ui_zhandou/fx_ui_huihe_zuo.prefab",
	"effect/prefabs/ui/fx_ui_zhandou/fx_ui_huihe.prefab",
	"effect/prefabs/ui/" .. CommonResPath.VigourMaxEffPath,
	"effect/prefabs/ui/" .. CommonResPath.BattleUtlUIEff,
	CommonResPath.VigoutMaxBuffEff,
	CommonResPath.BattleUIShieldTxtPath
}
CommonResPath.sceneHuds = {
	"scene/misc/prefabs/task_npc_wenhao.prefab",
	"scene/misc/prefabs/task_npc_tanhao.prefab",
	"scene/misc/prefabs/hudplayer.prefab",
	"scene/misc/prefabs/hudothersplayer.prefab",
	"scene/misc/prefabs/hudnpc.prefab",
	"scene/misc/prefabs/hud_transpoint.prefab",
	"scene/misc/prefabs/hudtalk.prefab"
}
CommonResPath.airwalls = {
	"scene/elements/prefabs/scene_air_wall_p.prefab",
	"scene/elements/prefabs/scene_air_wall_circle_p.prefab",
	"scene/elements/prefabs/scene_air_wall_capsule_p.prefab"
}
CommonResPath.sceneMisc = {
	CommonResPath.SceneTransitionFade,
	CommonResPath.SceneTransitionOutEff,
	CommonResPath.SceneTransitionInEff
}
CommonResPath.config = {
	"config/forbidden_words.txt",
	"config/forbidden_name_words.txt",
	"config/chinese_dict.txt",
	"config/event2bank_dict.txt",
	"config/tilingmap_counter.txt"
}
CommonResPath.basicForAb = {
	"shaders",
	"ui/skinlib",
	"config",
	"skillconfig",
	"storyconfig"
}
CommonResPath.basic = {
	CommonResPath.LoadingView,
	CommonResPath.CharacterShadow,
	CommonResPath.UIBlackScreen,
	CommonResPath.UIStoryMask,
	CommonResPath.UITaskCompelete,
	CommonResPath.UIStoryBkg,
	CommonResPath.UIStory,
	CommonResPath.UIVideoPlaying,
	CommonResPath.UIAnimationPlaying,
	CommonResPath.VipPrivilegeTips,
	CommonResPath.RoleActions
}
CommonResPath.additional = {}
CommonResPath.loginviewAssets = {
	CommonResPath.loginViewPath
}
CommonResPath.unLoadForMemory = {
	ViewName.ItemGet,
	ViewName.TaskCompelete,
	ViewName.PlayerStrength,
	ViewName.PetIntroductionView,
	ViewName.PlotCopyView,
	ViewName.PlotChapterView,
	ViewName.PlotStageView,
	ViewName.CopyMissionView,
	ViewName.BulletScreen,
	ViewName.BattleSettlementSuccess,
	ViewName.BattleSettlementFailSimple,
	ViewName.PayShopMainView,
	ViewName.PetView,
	ViewName.Collection,
	ViewName.bonus,
	ViewName.chat,
	ViewName.PetShowView,
	ViewName.PetShowInfo,
	ViewName.PetTalent,
	ViewName.PetAwakeView,
	ViewName.PetEquip,
	ViewName.Story,
	ViewName.StoryMask,
	ViewName.Popupwindow,
	ViewName.PlayerAutoPath,
	ViewName.Lottery,
	ViewName.FormationView,
	ViewName.MyCardView
}
CommonResPath.frequentViews = {
	ViewName.VirtualJoystick,
	ViewName.MainUI,
	ViewName.MainTopGoldView,
	ViewName.HorseLanternView,
	ViewName.ItemFly,
	ViewName.ItemGet,
	ViewName.TaskCompelete,
	ViewName.PlayerStrength,
	ViewName.PetIntroductionView,
	ViewName.PlotCopyView,
	ViewName.PlotChapterView,
	ViewName.PlotStageView,
	ViewName.CopyMissionView,
	ViewName.Battle,
	ViewName.BattleStart,
	ViewName.BulletScreen,
	ViewName.BattleSettlementSuccess,
	ViewName.BattleSettlementFailSimple,
	ViewName.PayShopMainView,
	ViewName.PetView,
	ViewName.Collection,
	ViewName.bonus,
	ViewName.chat,
	ViewName.PetShowView,
	ViewName.PetShowInfo,
	ViewName.PetTalent,
	ViewName.PetAwakeView,
	ViewName.PetEquip
}
CommonResPath.frequentViewsNotBuildUI = {
	ViewName.ItemGet,
	ViewName.TaskCompelete,
	ViewName.PlayerStrength,
	ViewName.PetIntroductionView,
	ViewName.PlotCopyView,
	ViewName.PlotChapterView,
	ViewName.PlotStageView,
	ViewName.CopyMissionView,
	ViewName.Battle,
	ViewName.BattleStart,
	ViewName.BulletScreen,
	ViewName.BattleSettlementSuccess,
	ViewName.BattleSettlementFailSimple,
	ViewName.PayShopMainView,
	ViewName.PetView,
	ViewName.Collection,
	ViewName.bonus,
	ViewName.chat,
	ViewName.PetShowView,
	ViewName.PetShowInfo,
	ViewName.PetTalent,
	ViewName.PetAwakeView,
	ViewName.PetEquip
}
CommonResPath.stillViews = {
	ViewName.Story,
	ViewName.StoryMask,
	ViewName.Popupwindow,
	ViewName.PlayerAutoPath,
	ViewName.GuideHighLight,
	ViewName.GuideHeadView,
	ViewName.Lottery,
	ViewName.FormationView,
	ViewName.MyCardView,
	ViewName.DebugView,
	ViewName.GMView,
	ViewName.DebugViewBtl,
	ViewName.YearCardMain2022View
}
CommonResPath.shaders = {
	"shaders/scene/unlit_nofog_opaque.shader",
	"shaders/ui/ui_blur_scene.shader",
	"shaders/spine/spine_skeleton.shader",
	"shaders/spine/spine_skeleton_fill.shader",
	"shaders/spine/skeletongraphic.shader",
	"shaders/spine/spine_skeleton_graphic_fill.shader",
	"shaders/ui/ui_static_blur.shader",
	"shaders/ui/ui_outline.shader",
	"shaders/scene/unlit_nofog_transparent_outline.shader",
	"shaders/scene/unlit_nofog_transparent.shader",
	"shaders/ui/ui_texoffset.shader",
	"shaders/ui/ui_color_hsv.shader",
	"shaders/character/character_toon.shader",
	"shaders/particle04/toonblooms/toonblooms.shader",
	"shaders/scene/unlit_commonshadow.shader",
	"shaders/scene/unlit_scene_createrole.shader",
	"shaders/spine/hui_guang.shader"
}

return CommonResPath
