-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/constdef/BattleResourceName.lua

module("logic.battle.constdef.BattleResourceName", package.seeall)

local BattleResourceName = {}

BattleResourceName.CheckerBoard = "scene/checkerboard/checkerboard.prefab"
BattleResourceName.PathArrow = "scene/checkerboard/patharrow.prefab"
BattleResourceName.TerrainSign = "scene/checkerboard/focussign.prefab"
BattleResourceName.BossArea = "scene/checkerboard/boss_area.prefab"
BattleResourceName.UnitSign = GameUrl.get3dEffectUrl("scene/other/scene_feasibility_fx_a")
BattleResourceName.UnitArrowSign = GameUrl.get3dEffectUrl("scene/other/scene_feasibility_arrow")
BattleResourceName.RandomCameraAnimation = "character3d/monijingtou/battle_normal_random_anim.prefab"
BattleResourceName.SkillAreaSign = "scene/checkerboard/skill_area.prefab"
BattleResourceName.AttackForecast = "scene/checkerboard/attackforecast.prefab"
BattleResourceName.SnipingLine = "scene/checkerboard/sniping_line.prefab"
BattleResourceName.SelectableRedSign = "effect3d/prefab/scene/comm/warning_box_red.prefab"
BattleResourceName.SelectableBlueSign = "effect3d/prefab/scene/comm/warning_box_blue.prefab"
BattleResourceName.SkillAreaBlueSign = "effect3d/prefab/terrain/battle_group_cure.prefab"
BattleResourceName.SkillAreaRedSign = "effect3d/prefab/terrain/battle_group_damage.prefab"
BattleResourceName.SkillWarningSign = "scene/checkerboard/skill_area_warning.prefab"
BattleResourceName.BoundingBoxSign = "scene/checkerboard/boundingbox.prefab"
BattleResourceName.DangerAreaSign = "scene/checkerboard/dangerarea.prefab"
BattleResourceName.DangerAreaFenceSign = "scene/checkerboard/dangerarea_fence.prefab"
BattleResourceName.TransportAreaSign = "scene/checkerboard/transport_area.prefab"
BattleResourceName.CheckerBoardOpenEffect = GameUrl.get3dEffectUrl("scene/other/scene_chessboard_open")
BattleResourceName.BornAreaEmptySign = GameUrl.get3dEffectUrl("scene/other/scene_checkerboard_add_role_a")
BattleResourceName.BornAreaPlaceSign = GameUrl.get3dEffectUrl("scene/other/scene_checkerboard_add_role_b")
BattleResourceName.OperatableSign = GameUrl.get3dEffectUrl("scene/other/scene_feasibility_fx")
BattleResourceName.PerformanceVolume = GameUrl.getVolumeUrl("battleperformancevolume")
BattleResourceName.StrengthenCutIn = GameUrl.get3dEffectUrl("scene/other/cast_sanity/cast_sanity_change")
BattleResourceName.CalculateVictory = "effect3d/prefab/other/battle_calculate_hero_victory.prefab"
BattleResourceName.UIMain = "ui/views/battle/battle_main.prefab"
BattleResourceName.UIVs = "ui/views/battle/inbattle_lifebar_view.prefab"
BattleResourceName.UICalculate = "ui/views/battle/battlecalculate.prefab"
BattleResourceName.UIScenePicker = "ui/views/battle/scenepicker.prefab"
BattleResourceName.UIRoundReport = "ui/views/battle/battle_round_panel.prefab"
BattleResourceName.UIFullScreenWarn = "ui/views/battle/full_screen_warn.prefab"
BattleResourceName.UICampAdjustment = "ui/views/battle/prewar_prepare_view.prefab"
BattleResourceName.UIConditions = "ui/views/battle/battle_conditions_view.prefab"
BattleResourceName.UIUnitPropertyTop = "ui/views/battle/uifollow/unit_property.prefab"
BattleResourceName.UIUnitPropertyBottom = "ui/views/battle/uifollow/unit_property_bottom.prefab"
BattleResourceName.UIUnitPropertyCenter = "ui/views/battle/uifollow/unit_property_center.prefab"
BattleResourceName.UIUnitSigns = "ui/views/battle/uifollow/unit_adjustment_sign.prefab"
BattleResourceName.UIBossProperty = "ui/views/battle/uifollow/boss_property.prefab"
BattleResourceName.UIBossPropertyBottom = "ui/views/battle/uifollow/boss_property_bottom.prefab"
BattleResourceName.UISkillHint = "ui/views/battle/uifollow/sanity_consume_process_copy.prefab"
BattleResourceName.UISpriteAtlas = IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Battle)
BattleResourceName.UISpriteLanguageAtlas = IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Language)
BattleResourceName.UIBossBloodBar = "ui/views/battle/boos_blood_hint.prefab"
BattleResourceName.DoomForecastTitle = "ui/views/battle/battlemap/battle_badluck_fore.prefab"
BattleResourceName.UnitMessage = "ui/views/air_workshop/air_workshop_badluck_fore.prefab"
BattleResourceName.UICalculate2 = "ui/views/battle/battle_calculate_view.prefab"
BattleResourceName.UIBattleResultView = "ui/views/battle/battle_results_view.prefab"
BattleResourceName.UIUndo = "ui/views/battle/battle_repentance_chess_view.prefab"
BattleResourceName.UIUndoEffect = "effect3d/prefab/ui/vfx_camera_repentancechess_loop.prefab"
BattleResourceName.UIUndoEffectStart = "effect3d/prefab/ui/vfx_camera_repentancechess_start.prefab"
BattleResourceName.UIUndoEffectEnd = "effect3d/prefab/ui/vfx_camera_repentancechess_end.prefab"
BattleResourceName.HeroUI3dLight = "light/battle_hero_ui3d_light.prefab"
BattleResourceName.UIBuffIcon = "ui/views/battle/pool/buff_icon.prefab"
BattleResourceName.UITalentSkillIcon = "ui/views/battle/pool/talent_skill_icon.prefab"
BattleResourceName.UICarrySkillIcon = "ui/views/battle/pool/carry_icon_copy.prefab"
BattleResourceName.UIBubbleNumber = "ui/views/battle/bubble/battlenumber.prefab"
BattleResourceName.UIBubbleSkillTriggerHint = "ui/views/battle/bubble/skill_trigger_hint.prefab"
BattleResourceName.UIBubbleBuffAddHint = "ui/views/battle/bubble/buff_add_unit.prefab"
BattleResourceName.BloodBar = GameUrl.get3dEffectUrl("scene/other/scene_feasibility_xuetiao")
BattleResourceName.EnemyHaloLinks = "effect3d/prefab/scene/other/scene_halo_enemy.prefab"
BattleResourceName.FriendHaloLinks = "effect3d/prefab/scene/other/scene_halo_friend.prefab"
BattleResourceName.EliteMonsterMaterial = "materials/other/character/ma_common_body_40002.mat"
BattleResourceName.WeakpointBrokenMaterial = "materials/other/character/ma_common_body_40001.mat"
BattleResourceName.ForecastUnitMaterial = "materials/other/character/ma_common_body_11001.mat"
BattleResourceName.BossCoveredMaterial = "materials/other/character/ma_common_body_40002_red.mat"
BattleResourceName.BoxWear = "character3d/160001_xiangzi/general/160001_xiangzi-battle.prefab"
BattleResourceName.CharacterMaskMaterial = "materials/other/battle/battle_character_mask_info.mat"
BattleResourceName.CharacterPreMaskMaterial = "materials/other/battle/battle_character_mask_prewar.mat"
BattleResourceName.CharacterCompareMaskMaterial = "materials/other/battle/battle_character_mask_compare.mat"
BattleResourceName.basic = {
	BattleResourceName.CheckerBoard,
	BattleResourceName.CheckerBoardOpenEffect,
	BattleResourceName.PathArrow,
	BattleResourceName.TerrainSign,
	BattleResourceName.UnitSign,
	BattleResourceName.UnitArrowSign,
	BattleResourceName.BossArea,
	BattleResourceName.SkillAreaSign,
	BattleResourceName.AttackForecast,
	BattleResourceName.SnipingLine,
	BattleResourceName.PerformanceVolume,
	BattleResourceName.StrengthenCutIn,
	BattleResourceName.RandomCameraAnimation,
	BattleResourceName.UIMain,
	BattleResourceName.UIVs,
	BattleResourceName.UIScenePicker,
	BattleResourceName.UIUnitPropertyTop,
	BattleResourceName.UIUnitPropertyBottom,
	BattleResourceName.UIUnitPropertyCenter,
	BattleResourceName.UIUnitSigns,
	BattleResourceName.UIBossProperty,
	BattleResourceName.UIBossPropertyBottom,
	BattleResourceName.UISkillHint,
	BattleResourceName.UIRoundReport,
	BattleResourceName.UIBubbleNumber,
	BattleResourceName.UIBubbleSkillTriggerHint,
	BattleResourceName.UIBubbleBuffAddHint,
	BattleResourceName.UISpriteAtlas,
	BattleResourceName.UISpriteLanguageAtlas,
	BattleResourceName.SelectableRedSign,
	BattleResourceName.SelectableBlueSign,
	BattleResourceName.SkillAreaBlueSign,
	BattleResourceName.SkillAreaRedSign,
	BattleResourceName.SkillWarningSign,
	BattleResourceName.OperatableSign,
	BattleResourceName.BoundingBoxSign,
	BattleResourceName.DangerAreaSign,
	BattleResourceName.DangerAreaFenceSign,
	BattleResourceName.TransportAreaSign,
	BattleResourceName.BornAreaEmptySign,
	BattleResourceName.BornAreaPlaceSign,
	BattleResourceName.UIBossBloodBar,
	BattleResourceName.DoomForecastTitle,
	BattleResourceName.UnitMessage,
	BattleResourceName.UIBuffIcon,
	ViewlibResPath.SkillItem1,
	BattleResourceName.UITalentSkillIcon,
	BattleResourceName.UICarrySkillIcon,
	BattleResourceName.BloodBar,
	BattleResourceName.EnemyHaloLinks,
	BattleResourceName.FriendHaloLinks,
	BattleResourceName.WeakpointBrokenMaterial,
	BattleResourceName.CharacterMaskMaterial,
	BattleResourceName.CharacterPreMaskMaterial,
	BattleResourceName.CharacterCompareMaskMaterial
}

return BattleResourceName
