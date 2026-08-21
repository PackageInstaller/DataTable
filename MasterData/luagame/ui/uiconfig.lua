local config = {}
config.uiroot = "UIRootCamera"
local order_cfg = require("config").UI_SORT_ORDER
local CACHE_LONG = 500
local CACHE_MID = 200
local CACHE_SHORT = 100
local CACHE_NONE = 1000000
config.ui_width = 1080
config.ui_height = 1920
local group_cfg = require("config").UI_GROUPS
local type_cfg = require("config").UI_VIEW_LEVEL
config.ui = {
  loading = {
    resource = "prefab/UILoading1.prefab",
    class = "loading.loading",
    no_destroy = true,
    sync_load = true,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    not_calc_match = true,
    destroy_on_hide = true
  },
  battle_loading = {
    resource = "prefab/loading/battleLoading.prefab",
    class = "loading.battle_loading",
    no_destroy = true,
    sync_load = true,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    not_calc_match = true
  },
  joystick = {
    resource = "prefab/uijoystick.prefab",
    class = "joystick.joystick",
    sort_order = order_cfg.MainView
  },
  uimain = {
    resource = "prefab/UIMain1.prefab",
    class = "uimain.uimain",
    sync_load = true,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    cache = CACHE_LONG,
    high_update = true,
    panels = {
      {
        name = "signboard_girl",
        root = "SignBoard_View",
        class = "uimain.signboard_girl",
        initshow = false
      },
      {
        name = "more_entry_panel",
        root = "ButtonPanel",
        class = "uimain.more_entry_panel",
        initshow = false
      }
    }
  },
  uimain_close = {
    resource = "prefab/UIMainClose.prefab",
    class = "uimain.uimain_close",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    high_update = true,
    panels = {
      {
        name = "signboard_girl",
        root = "SignBoard_View",
        class = "uimain.signboard_girl",
        initshow = false
      },
      {
        name = "signboard_gift_list",
        root = "GiftRoot",
        class = "uimain.signboard_gift_list",
        initshow = false
      }
    }
  },
  uimain_close_new = {
    resource = "prefab/UIMainClose1.prefab",
    class = "uimain.uimain_close_new",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    high_update = true,
    panels = {}
  },
  uimain_photo = {
    resource = "prefab/UIMainDIY.prefab",
    class = "uimain.uimain_photo",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    high_update = true
  },
  ui_favor_award_tips = {
    resource = "prefab/Tips/UIFavorAwardTips.prefab",
    class = "uimain.ui_favor_award_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  uimain_player_journey = {
    resource = "prefab/UIPlayerLvAward.prefab",
    class = "uimain.uimain_player_journey",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  char_spine_display = {
    resource = "prefab/Archive/UICharSpineDisplay.prefab",
    class = "character.archives.char_spine_display",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    high_update = true,
    sync_load = false
  },
  char_archive = {
    resource = "prefab/Char/Archives/UICharFileMain.prefab",
    class = "character.archives.char_archive",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    high_update = true,
    panels = {
      {
        name = "char_archive_voice",
        root = "VoicePnl",
        class = "character.archives.char_archive_voice",
        initshow = false
      }
    }
  },
  dia_exchange = {
    resource = "prefab/UIDiaRecharg.prefab",
    class = "uimain.dia_exchange",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true
  },
  fate_exchange = {
    resource = "prefab/UIDiaRecharg.prefab",
    class = "uimain.fate_exchange",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true
  },
  uiforcerecharg = {
    resource = "prefab/UIForceRecharg.prefab",
    class = "uimain.uiforcerecharg",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true,
    high_update = true
  },
  uigm = {
    resource = "prefab/UIGM.prefab",
    class = "gm.uigm",
    sync_load = false,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL
  },
  uigmSkill = {
    resource = "prefab/UIGMSkill.prefab",
    class = "gm.uigm_skill",
    sync_load = false,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL
  },
  uigm_scene = {
    resource = "prefab/UIGMScene.prefab",
    class = "gm.uigm_scene",
    sync_load = false,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL
  },
  uidebug_skill = {
    resource = "prefab/UIDebugSkill.prefab",
    class = "gm.uidebug_skill",
    sync_load = false,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL
  },
  uitower = {
    resource = "prefab/UITower.prefab",
    class = "uimain.uitower",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL
  },
  uilogin = {
    resource = "prefab/UILogin.prefab",
    class = "login.login",
    sync_load = true,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    keep_stack_show = true,
    destroy_on_hide = true
  },
  uiloginlogo = {
    resource = "prefab/UIloginLogo.prefab",
    class = "login.loginlogo",
    sync_load = false,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL,
    high_update = true,
    destroy_on_hide = true
  },
  uifightdebugfilter = {
    resource = "prefab/debug/UIFightDebugFilter.prefab",
    class = "fight_journal.fight_journal_filter",
    sync_load = false,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL
  },
  uiskilljournal = {
    resource = "prefab/debug/UISkillJournal.prefab",
    class = "fight_journal.uiskilljournal",
    sync_load = false,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL
  },
  uihurtjournal = {
    resource = "prefab/debug/UIHurtJournal.prefab",
    class = "fight_journal.uihurtjournal",
    sync_load = false,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL
  },
  uiabnormaljournal = {
    resource = "prefab/debug/UIAbnormalJournal.prefab",
    class = "fight_journal.uiabnormaljournal",
    sync_load = false,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL
  },
  uidebugmissileinfo = {
    resource = "prefab/debug/UIDebugMissileInfo.prefab",
    class = "fight_journal.uidebugmissileinfo",
    sync_load = false,
    sort_order = order_cfg.Alert,
    normal_update = true,
    group = group_cfg.GROUP_NORMAL
  },
  uifightstatejournal = {
    resource = "prefab/debug/UIFightStateJournal.prefab",
    class = "fight_journal.uifightstatejournal",
    sync_load = false,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  ui_server_list = {
    resource = "prefab/UIServerList.prefab",
    class = "login.ui_server_list",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    not_full_screen = true
  },
  character_enter = {
    resource = "prefab/Char/UIChar_Enter3.prefab",
    class = "character.char_enter_view",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    high_update = true
  },
  character_voice_language = {
    resource = "prefab/UISetCharLanguage.prefab",
    class = "character.character_voice_language",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    high_update = true
  },
  char_rune_detail = {
    resource = "prefab/Char/UICharRuneDetail.prefab",
    class = "character.char_rune_detail",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true
  },
  character = {
    resource = "prefab/UIChar1.prefab",
    class = "character.character",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    panels = {
      {
        name = "char_list",
        root = "CharList",
        class = "character.character_inside_list",
        initshow = false
      },
      {
        name = "char_main",
        root = "CharMain",
        class = "character.character_main",
        initshow = true
      },
      {
        name = "char_attr",
        root = "CharaAttr",
        class = "character.character_attr",
        initshow = true
      },
      {
        name = "weapon_attr",
        root = "WeaponAttrNew",
        class = "character.weapon_attr",
        initshow = false
      },
      {
        name = "potential",
        root = "Char_Advance",
        class = "character.potential_new",
        initshow = false
      },
      {
        name = "skill",
        root = "Char_Skill",
        class = "character.char_skill_new",
        initshow = false
      },
      {
        name = "puzzle",
        root = "Char_Plugins",
        class = "character.puzzle.char_puzzle",
        initshow = false
      }
    },
    high_update = true,
    view_level = type_cfg.MAIN_VIEW,
    show_model_camera_ui = "character_enter"
  },
  break_preview = {
    resource = "prefab/Char/UICharBreakPreview.prefab",
    class = "character.break_preview",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    not_full_screen = true
  },
  player_hero = {
    resource = "prefab/UIChar1.prefab",
    class = "friend.player_hero_info.player_hero",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    panels = {
      {
        name = "player_hero_main",
        root = "CharMain",
        class = "friend.player_hero_info.player_hero_main",
        initshow = true
      },
      {
        name = "player_hero_attr",
        root = "CharaAttr",
        class = "friend.player_hero_info.player_hero_attr",
        initshow = true
      },
      {
        name = "player_weapon_attr",
        root = "WeaponAttrNew",
        class = "friend.player_hero_info.player_weapon_attr",
        initshow = false
      },
      {
        name = "player_hero_potential",
        root = "Char_Advance",
        class = "friend.player_hero_info.player_hero_potential_new",
        initshow = false
      },
      {
        name = "player_hero_skill",
        root = "Char_Skill",
        class = "friend.player_hero_info.player_hero_skill_new",
        initshow = false
      },
      {
        name = "player_hero_puzzle",
        root = "Char_Plugins",
        class = "friend.player_hero_info.player_hero_puzzle",
        initshow = false
      }
    },
    high_update = true,
    view_level = type_cfg.MAIN_VIEW
  },
  char_skill_suc_pnl = {
    resource = "prefab/Char/UISkillLvUpDetail.prefab",
    class = "character.char_skill_suc_pnl",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true
  },
  char_advance_suc_pnl = {
    resource = "prefab/UICharAdvanceSucPnl.prefab",
    class = "character.char_advance_suc_pnl",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true
  },
  buddy_break_detil = {
    resource = "prefab/UIBuddyBreakDetail.prefab",
    class = "character.buddy_break_detil",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true
  },
  equip_break_detil = {
    resource = "prefab/UIEquipBreakDetail.prefab",
    class = "character.equip_break_detil",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true
  },
  char_attr_detail = {
    resource = "prefab/UIChar_attribute.prefab",
    class = "character.char_attr_detail",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  char_skill_task = {
    resource = "prefab/UIChar_skill_task2.prefab",
    class = "character.char_skill_task",
    panels = {
      {
        name = "skill",
        root = "NorTaskObj",
        class = "character.char_skill_task_nor_task",
        initshow = true
      },
      {
        name = "rune",
        root = "RuneObj",
        class = "character.char_skill_task_rune"
      }
    },
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true
  },
  char_skill_mastery = {
    resource = "prefab/Char/UICharSkillMastery.prefab",
    class = "character.char_skill_mastery",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  char_skill_upgrade = {
    resource = "prefab/UIChar_skill_upgrade.prefab",
    class = "character.char_skill_upgrade",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  ui_explain = {
    resource = "prefab/UIExplain.prefab",
    class = "tip.ui_explain",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  char_weapon_select = {
    resource = "prefab/UIChar_weapon_select.prefab",
    class = "character.weapon_select",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW,
    high_update = true
  },
  weapon_tongtiao_finish = {
    resource = "prefab/Char/UIWeapon_HomologySucPnl.prefab",
    class = "character.weapon_tongtiao_finish",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  weapon_detail = {
    resource = "prefab/UIChar_weapon_Detail.prefab",
    class = "weapon.weapon_detail",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    sync_load = false,
    high_update = true,
    panels = {
      {
        name = "base_panel",
        root = "Basic",
        class = "weapon.weapon_detail_base",
        initshow = false
      },
      {
        name = "tongtiao_panel",
        root = "Tongtiaonew",
        class = "weapon.weapon_detail_tongtiao",
        initshow = false
      }
    }
  },
  source_filter_tips = {
    resource = "prefab/Tips/UISourceScreenTips.prefab",
    class = "weapon.source_filter_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  source_item_tips = {
    resource = "prefab/Char/SourceItemTips.prefab",
    class = "weapon.source_item_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  char_weapon = {
    resource = "prefab/UIChar_weapon.prefab",
    class = "character.weapon",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW,
    high_update = true
  },
  char_weapon_levelup_box = {
    resource = "prefab/Char/UIChar_LevelUp.prefab",
    class = "character.char_weapon_levelup_box",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  char_levelup_box = {
    resource = "prefab/Char/UIChar_LevelUp.prefab",
    class = "character.character_levelup_box",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  char_advance_skill_detail = {
    resource = "prefab/UIChar_advance_skill_detil.prefab",
    class = "character.advance_skill_detil",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "character",
    view_level = type_cfg.MAIN_VIEW
  },
  char_assist = {
    resource = "prefab/Char/UIAssist.prefab",
    class = "character.Assist.char_assist",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  assist_info = {
    resource = "prefab/Char/UIAssistInfo.prefab",
    class = "character.Assist.assist_info",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  chapter = {
    resource = "prefab/ChapterNew/UIChapter1.prefab",
    class = "chapter.chapter",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  chapter_mainline = {
    resource = "prefab/ChapterNew/UIChapPage_Mainline.prefab",
    class = "chapter.sub_panels.chapter_mainline",
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "chapter",
    sync_load = true
  },
  chapter_material = {
    resource = "prefab/ChapterNew/UIChapPage_Material.prefab",
    class = "chapter.sub_panels.chapter_material",
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "chapter",
    sync_load = false
  },
  material_stage = {
    resource = "prefab/ChapterNew/UIStage_Material.prefab",
    class = "chapter.sub_panels.material_stage",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  chapter_challenge = {
    resource = "prefab/ChapterNew/UIChapPage_Challenge.prefab",
    class = "chapter.sub_panels.chapter_challenge",
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "chapter",
    sync_load = true
  },
  chapter_weekly_act = {
    resource = "prefab/ChapterNew/UIChapPage_Weekly.prefab",
    class = "chapter.sub_panels.chapter_weekly_act",
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "chapter",
    panels = {
      {
        name = "weekly_act",
        root = "WeekAct1_Panel",
        class = "chapter.sub_panels.weekly_act_1"
      },
      {
        name = "ring",
        root = "ChalRing_Panel",
        class = "chapter.sub_panels.weekly_act_ring"
      },
      {
        name = "climbing_tower",
        root = "Tower_Panel",
        class = "chapter.sub_panels.climbing_tower"
      }
    },
    sync_load = true
  },
  point_detail = {
    resource = "prefab/StageInfo.prefab",
    class = "chapter.point_detail",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    not_full_screen = true
  },
  team = {
    resource = "prefab/UITeam.prefab",
    class = "team.team",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    keep_stack_show = true,
    high_update = true,
    run_ui_hide_during_cleanup = true,
    need_pause_game = true,
    disable_camera_on_show = true,
    skip_init_common_widget = true,
    panels = {
      {
        name = "inside_list",
        root = "QuickTeamList",
        class = "team.team_inside_list"
      }
    }
  },
  ui_jump_team = {
    resource = "prefab/UIJumpTeam.prefab",
    class = "team.ui_jump_team",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    keep_stack_show = true,
    view_level = type_cfg.MAIN_VIEW
  },
  screen_buddy_tips = {
    resource = "prefab/Tips/UIBuddyScreenTips.prefab",
    class = "character.screen_buddy_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  sort_buddy_tips = {
    resource = "prefab/Tips/UIScreenRuleTips.prefab",
    class = "character.sort_buddy_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  uiteam_preset_tips = {
    resource = "prefab/Tips/UITeamPreset1.prefab",
    class = "team.team_preset_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  ui_debug_info = {
    resource = "prefab/UIDebugInfo.prefab",
    class = "ui_debug_info.ui_debug_info",
    high_update = true,
    sort_order = order_cfg.Alert
  },
  fight = {
    resource = "prefab/uifight.prefab",
    class = "fight.fight",
    sort_order = order_cfg.MainView,
    panels = {
      {
        name = "fight_tips",
        root = "TipsFight",
        class = "fight.fight_tips_view",
        initshow = true
      },
      {
        name = "fight_npc",
        root = "NpcView",
        class = "fight.fight_npc_view",
        initshow = false
      },
      {
        name = "fight_quantum",
        root = "QuantumCondition",
        class = "fight.fight_quantum_view",
        initshow = false
      },
      {
        name = "fight_DBM",
        root = "DBMList",
        class = "fight.fight_dbm_view",
        initshow = false
      },
      {
        name = "enemy_bar",
        root = "EnemyBarList",
        class = "fight.bar.enemy_bar_view",
        initshow = true
      },
      {
        name = "hero_bar",
        root = "HeroBlood",
        class = "fight.bar.hero_bar",
        initshow = true
      },
      {
        name = "drop_tips",
        root = "TipsObj",
        class = "fight.drop_tips",
        initshow = false
      },
      {
        name = "hero_head_view",
        root = "TeamHeads",
        class = "fight.hero_head_view",
        initshow = true
      },
      {
        name = "ult_skill_view",
        root = "UltInfo",
        class = "fight.child.ult_skill_view",
        initshow = true
      }
    },
    high_update = true,
    normal_update = true,
    not_calc_match = true,
    preload_type = true,
    cache = CACHE_LONG,
    not_full_screen = true
  },
  pop_text_tip = {
    resource = "prefab/UIPopText.prefab",
    class = "pop_text_tip.pop_text_tip",
    sort_order = order_cfg.Alert
  },
  scene_skill_detail = {
    resource = "prefab/tips/StageSkillTips.prefab",
    class = "fight.scene_skill_detail",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  uilooptask = {
    resource = "prefab/uitask2.prefab",
    class = "task.uilooptask",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  ui_task_new = {
    resource = "prefab/UITask.prefab",
    class = "task.ui_task_new",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW,
    panels = {
      {
        name = "task_active",
        root = "Task",
        class = "task.task_active_main",
        initshow = false
      },
      {
        name = "task_experience",
        root = "SPTask",
        class = "task.task_experience_main",
        initshow = false
      }
    }
  },
  uibag = {
    resource = "prefab/UIBag.prefab",
    class = "uibag.uibag",
    sync_load = false,
    normal_update = true,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    panels = {
      {
        name = "puzzle_sub_panel",
        root = "PluginRoot",
        class = "character.puzzle.puzzle_bag_panel",
        initshow = false
      }
    }
  },
  marquee = {
    resource = "prefab/Tips/UIMarquee.prefab",
    class = "tip.marquee",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    background_blur = false,
    normal_update = true
  },
  uidrawcard = {
    resource = "prefab/uidrawcard.prefab",
    class = "ui_draw_card.uidrawcard",
    sync_load = true,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  uidrawcard_trigger_panel = {
    resource = "prefab/Drawcards/UIDraw_Trigger.prefab",
    class = "ui_draw_card.uidrawcard_trigger_panel",
    sync_load = true,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    high_update = true
  },
  uidrawcard_movie_panel = {
    resource = "prefab/Drawcards/UIDraw_movie.prefab",
    class = "ui_draw_card.uidrawcard_movie_panel",
    sync_load = true,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    high_update = true
  },
  uidrawcard_select_panel = {
    resource = "prefab/Drawcards/UIDraw_WeapenChoose.prefab",
    class = "ui_draw_card.uidrawcard_select_panel",
    sync_load = true,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  uidrawcard_select_panel_char = {
    resource = "prefab/Drawcards/UIDrawcard_ChooseChar.prefab",
    class = "ui_draw_card.uidrawcard_select_panel_char",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  uidrawcard_movie = {
    resource = "prefab/uidrawcard_movie.prefab",
    class = "ui_draw_card.uidrawcard_movie",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  uidrawcard_movie2 = {
    resource = "prefab/uidrawcard_movie.prefab",
    class = "ui_draw_card.uidrawcard_movie",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  uidrawcard_multi_rlt = {
    resource = "prefab/uidrawcard_multi_rlt.prefab",
    class = "ui_draw_card.uidrawcard_multi_rlt",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  uidrawcard_rule = {
    resource = "prefab/uidrawcard_rule.prefab",
    class = "ui_draw_card.uidrawcard_rule",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    panels = {
      {
        name = "page1",
        root = "Page1",
        class = "ui_draw_card.drawcard_rule_base",
        initshow = false
      },
      {
        name = "page2",
        root = "Page2",
        class = "ui_draw_card.drawcard_rule_drop",
        initshow = false
      },
      {
        name = "page3",
        root = "Page3",
        class = "ui_draw_card.drawcard_rule_history",
        initshow = false
      }
    }
  },
  uidrawcard_recharge = {
    resource = "prefab/UIDrawCard_Recharge.prefab",
    class = "ui_draw_card.uidrawcard_recharge",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    not_full_screen = true
  },
  uidrawcard_choose_award = {
    resource = "prefab/Drawcards/UIDrawCardAward.prefab",
    class = "ui_draw_card.uidrawcard_choose_award",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  battle_equip = {
    resource = "prefab/uiequip.prefab",
    class = "battle_equip.battle_equip_main",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    panels = {
      {
        name = "change_char",
        root = "WinCharChang",
        class = "battle_equip.pan_change_char",
        initshow = false
      },
      {
        name = "comb_succ",
        root = "WinHeComplete",
        class = "battle_equip.pan_comb_succ",
        initshow = false
      },
      {
        name = "confirm",
        root = "WinConfirm",
        class = "battle_equip.pan_confirm",
        initshow = false
      },
      {
        name = "equip_tree",
        root = "EqTree",
        class = "battle_equip.pan_equip_tree",
        initshow = false
      },
      {
        name = "equip_list",
        root = "EqList",
        class = "battle_equip.pan_equip_list",
        initshow = true
      }
    },
    view_level = type_cfg.MAIN_VIEW
  },
  uinotice_tips = {
    resource = "prefab/tips/noticetips.prefab",
    class = "tip.notice_tips",
    sync_load = true,
    sort_order = order_cfg.Alert,
    cache = CACHE_NONE
  },
  ui_award_notice_tips = {
    resource = "prefab/home/uihomeawardhint.prefab",
    class = "tip.ui_award_notice_tips",
    sync_load = true,
    sort_order = order_cfg.Tip,
    cache = CACHE_NONE
  },
  ui_input_listener = {
    resource = "prefab/tips/UISetBtnTips.prefab",
    class = "tip.input_listener",
    sync_load = true,
    sort_order = order_cfg.Tip,
    cache = CACHE_NONE,
    high_update = true
  },
  ui_custom_button_tip = {
    resource = "prefab/tips/UISetBtnTips.prefab",
    class = "tip.custom_button_tip",
    sync_load = true,
    sort_order = order_cfg.Tip,
    cache = CACHE_NONE
  },
  ui_month_card_random_award_tips = {
    resource = "prefab/Shop/UIMonthCardRandomTips.prefab",
    class = "shop.recommond_shop.month_card_random_award_tip",
    sync_load = true,
    sort_order = order_cfg.Tip,
    cache = CACHE_NONE
  },
  ui_award_tips_com = {
    resource = "prefab/tips/UIAwardTipsCom.prefab",
    class = "tip.notice_award_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  lua_error = {
    resource = "prefab/tips/luaerror.prefab",
    class = "hint.ui_lua_error",
    sync_load = false,
    sort_order = order_cfg.Alert
  },
  uistory = {
    resource = "prefab/uistory.prefab",
    class = "story.story",
    sort_order = order_cfg.Special,
    view_level = type_cfg.MAIN_VIEW,
    panels = {
      {
        name = "story_review",
        root = "Review",
        class = "story.story_review",
        initshow = false
      }
    },
    normal_update = true,
    sync_load = true,
    cache_on_destory = true
  },
  uistory_change_name = {
    resource = "prefab/tips/UIFirstSetName.prefab",
    class = "story.story_change_name",
    sort_order = order_cfg.Special,
    view_level = type_cfg.MAIN_VIEW
  },
  uistory_player_setting = {
    resource = "prefab/UI_InitialSet.prefab",
    class = "story.story_player_setting",
    sort_order = order_cfg.Special,
    view_level = type_cfg.MAIN_VIEW,
    normal_update = true
  },
  uimessagetip = {
    resource = "prefab/Tips/uimessagetip.prefab",
    class = "tip.messagetip",
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL
  },
  uivideo_skip = {
    resource = "prefab/UIVideoSkip.prefab",
    class = "video.video_skip",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    is_not_set_space_camera_render = true
  },
  uibanner_tip = {
    resource = "prefab/UIBannerNotice.prefab",
    class = "tip.banner_tip",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  award_show_panel = {
    resource = "prefab/Tips/Award_show.prefab",
    class = "tip.award_show_panel",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true
  },
  battle_award_show_panel = {
    resource = "prefab/UIBattleAwardTips.prefab",
    class = "tip.battle_award_show_panel",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  side_pop_item_tips = {
    resource = "prefab/Tips/SidePopItemTis.prefab",
    class = "tip.side_pop_item_tips",
    sort_order = order_cfg.Dialog,
    group = group_cfg.GROUP_NORMAL
  },
  uimail = {
    resource = "prefab/uimail.prefab",
    class = "mail.mail",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  uibattle_shop = {
    resource = "prefab/uiFightShop.prefab",
    class = "battle_shop.battle_shop_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    sync_load = false
  },
  uiitem_sell_select = {
    resource = "prefab/tips/ItemSellSelect.prefab",
    class = "tip.item_sell_select",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true
  },
  uibattle_talent = {
    resource = "prefab/UITalent2.prefab",
    class = "battle_talent.battle_talent_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  fight_bag = {
    resource = "prefab/uifightpause2.prefab",
    class = "fight_bag.fight_bag_main",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    panels = {
      {
        name = "bag_view",
        root = "BagPanel",
        class = "fight_bag.bag_view",
        initshow = true
      },
      {
        name = "item_tip_view",
        root = "ItemInfo",
        class = "fight_bag.bag_item_tips_view",
        initshow = false
      }
    },
    keep_stack_show = true,
    is_end_joystick = true
  },
  battle_bag4 = {
    resource = "prefab/uifightpause5.prefab",
    class = "battle_bag.battle_bag_main4",
    sync_load = true,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    normal_update = true,
    need_pause_game = true,
    panels = {
      {
        name = "skill_bag_view",
        root = "SkillContent",
        class = "battle_bag.skill_bag_view",
        initshow = false
      },
      {
        name = "orn_view",
        root = "OrnContent",
        class = "battle_bag.orn_view",
        initshow = false
      },
      {
        name = "ability_view",
        root = "TalentContent",
        class = "battle_bag.ability_view",
        initshow = false
      },
      {
        name = "stage_view",
        root = "StageContent",
        class = "battle_bag.stage_view",
        initshow = false
      },
      {
        name = "stage_skill_view",
        root = "StageSkillContent",
        class = "battle_bag.stage_skill_view",
        initshow = false
      },
      {
        name = "equation_view",
        root = "EquationContent",
        class = "battle_bag.equation_view",
        initshow = false
      },
      {
        name = "skill_list_view",
        root = "SkillContent2",
        class = "battle_bag.skill_list_view",
        initshow = false
      }
    },
    use_low_render_frame = true,
    disable_camera_on_show = true,
    no_remove_between_ui = true
  },
  ui_rune_set = {
    resource = "prefab/UISetRune2.prefab",
    class = "battle_rune.rune2_set_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    is_end_joystick = true,
    need_pause_game = true,
    background_blur = true
  },
  ui_rune_set_suc = {
    resource = "prefab/UISetRuneSuc.prefab",
    class = "battle_rune.rune_set_suc_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    is_end_joystick = true,
    need_pause_game = true,
    background_blur = true
  },
  ui_rune_buff_tip = {
    resource = "prefab/Tips/UIRuneBuffTips.prefab",
    class = "battle_rune.rune_buff_tip_view",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  battle_orn_tips = {
    resource = "prefab/Tips/UIBattleOrnTips.prefab",
    class = "battle_orn.battle_orn_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_rune_cast = {
    resource = "prefab/ChallengeRing/UIStrengRoom.prefab",
    class = "battle_rune.rune_cast_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    is_end_joystick = true,
    need_pause_game = true
  },
  reconnecting = {
    resource = "prefab/uireconnect.prefab",
    class = "tip.reconnecting",
    sync_load = true,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  waiting = {
    resource = "prefab/uiwaiting.prefab",
    class = "tip.ui_waiting",
    sync_load = true,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    cache = CACHE_NONE,
    normal_update = true
  },
  uisign_in = {
    resource = "prefab/UISignIn.prefab",
    class = "sign_in.sign_in_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    not_full_screen = true
  },
  uifightdebug = {
    resource = "prefab/debug/uifightdebug.prefab",
    class = "fight_debug.fight_debug_main",
    sync_load = false,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL,
    panels = {
      {
        name = "create_npc",
        root = "CreateMosterPanel",
        class = "fight_debug.create_npc_view",
        initshow = true
      },
      {
        name = "add_magic",
        root = "AddMagicPanel",
        class = "fight_debug.add_magic_view",
        initshow = false
      }
    }
  },
  debug_fight_timer = {
    resource = "prefab/debug/uifightdebugtimer.prefab",
    class = "fight_debug.debug_fight_timer",
    sync_load = false,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  uichangeattr = {
    resource = "prefab/uichangeattr.prefab",
    class = "fight_debug.change_attr_panel",
    sync_load = false,
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL
  },
  uinotice = {
    resource = "prefab/UINotice.prefab",
    class = "notice.notice_main",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    not_full_screen = true,
    no_push_stack = true
  },
  ui_notice_login = {
    resource = "prefab/UINotice.prefab",
    class = "notice.notice_login_main",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    not_full_screen = true,
    no_push_stack = true
  },
  uiplayer = {
    resource = "prefab/UIPlayer.prefab",
    class = "player.player",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true,
    panels = {
      {
        name = "titles",
        root = "SetTitle",
        class = "player.player_title",
        initshow = false
      }
    }
  },
  uiplayer_new = {
    resource = "prefab/UIPlayer1.prefab",
    class = "player.player_new",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true,
    high_update = true,
    panels = {
      {
        name = "titles",
        root = "SetTitle",
        class = "player.player_title",
        initshow = false
      }
    }
  },
  uiplayer_new_endlesstips = {
    resource = "prefab/tips/UIPlayerRecordTips.prefab",
    class = "player.player_new_endlesstips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  uiplayer_new_bosschaltips = {
    resource = "prefab/tips/UIPlayerRecordTips.prefab",
    class = "player.player_new_bosschaltips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    not_full_screen = true,
    no_push_stack = true
  },
  uiplayer_new_spine_change = {
    resource = "prefab/UISignBoard_Girl_ChangeL.prefab",
    class = "player.player_new_spine_change",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    not_full_screen = true
  },
  ui_player_new_info = {
    resource = "prefab/UIPlayer1.prefab",
    class = "friend.player_new_info",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    sync_load = false,
    panels = {
      {
        name = "titles",
        root = "ShowTitle",
        class = "friend.friend_title",
        initshow = false
      }
    }
  },
  player_char_set = {
    resource = "prefab/UISetPlayerInfo.prefab",
    class = "player.player_char_set",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  player_avatar_choose = {
    resource = "prefab/UIPlayer_AvatarChoose.prefab",
    class = "player.avatar_choose_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "uiplayer_new",
    view_level = type_cfg.MAIN_VIEW
  },
  player_exchange_code = {
    resource = "prefab/UIPlayer_ExchangeCode.prefab",
    class = "player.exchange_code_view",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  player_change_name = {
    resource = "prefab/UIPlayer_ChangeName.prefab",
    class = "player.change_name_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "uiplayer_new",
    view_level = type_cfg.MAIN_VIEW
  },
  player_change_born = {
    resource = "prefab/UIPlayer_ChangeBorn.prefab",
    class = "player.change_born_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "uiplayer_new",
    view_level = type_cfg.MAIN_VIEW
  },
  shop = {
    resource = "prefab/Shop/UIShopNew.prefab",
    class = "shop.shop_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  shopexchange = {
    resource = "prefab/Shop/UIShop_exchangeNew.prefab",
    class = "shop.exchange_shop.shop_exchange",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "shop",
    view_level = type_cfg.MAIN_VIEW
  },
  token_exchange = {
    resource = "prefab/Shop/UIShop_exchangeNew.prefab",
    class = "shop.exchange_shop.token_exchange",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "shop",
    view_level = type_cfg.MAIN_VIEW
  },
  uifriend = {
    resource = "prefab/UIFriendNew.prefab",
    class = "friend.friend_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    panels = {
      {
        name = "search_player",
        root = "SearchContent",
        class = "friend.search_player",
        initshow = true
      }
    },
    normal_update = true
  },
  ui_player_info = {
    resource = "prefab/UIPlayerinfo.prefab",
    class = "friend.player_info",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    panels = {
      {
        name = "titles",
        root = "ShowTitle",
        class = "friend.friend_title",
        initshow = false
      }
    }
  },
  ui_remark_tip = {
    resource = "prefab/tips/RemarkTips.prefab",
    class = "friend.remark_tip",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true
  },
  friend_black_list = {
    resource = "prefab/UIBlacklist.prefab",
    class = "friend.friend_black_list",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  itemTip = {
    resource = "prefab/tips/itemtips.prefab",
    class = "tip.item_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    panels = {
      {
        name = "item_use_view",
        root = "UseMode",
        class = "tip.item_use_view",
        initshow = false
      }
    }
  },
  shop_item_tips = {
    resource = "prefab/tips/shopitemtips.prefab",
    class = "tip.shop_item_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    panels = {
      {
        name = "shop_buy_view",
        root = "BuyMode",
        class = "tip.shop_buy_view",
        initshow = false
      }
    },
    background_blur = true
  },
  expand_stock_tips = {
    resource = "prefab/tips/stocktips.prefab",
    class = "shop.exchange_shop.expand_stock_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true
  },
  break_mat_tips = {
    resource = "prefab/tips/breachtips.prefab",
    class = "tip.break_mat_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true
  },
  chapter_task = {
    resource = "prefab/ChapTask.prefab",
    class = "chapter.chapter_task",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  uimid_tips = {
    resource = "prefab/tips/UIMidTips.prefab",
    class = "tip.middle_screen_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  uitreasure = {
    resource = "prefab/ChallengeRing/UICRTreasure.prefab",
    class = "battle_treasure.battle_treasure_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  uitreasure_box = {
    resource = "prefab/UITreasure.prefab",
    class = "battle_treasure.battle_treasure_box_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    is_end_joystick = true,
    need_pause_game = true
  },
  uiheropassive = {
    resource = "prefab/UIHeroPassive.prefab",
    class = "tip.hero_passive_panel",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  uinpc_dialog = {
    resource = "prefab/UIDialog.prefab",
    class = "dialog.dialog_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  sys_open_tips = {
    resource = "prefab/Tips/UISysOpenNotice.prefab",
    class = "uimain.sys_open_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true
  },
  ui_fashionable_dress = {
    resource = "prefab/UIFashion.prefab",
    class = "ui_fashionable_dress.ui_fashionable_dress",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    high_update = true
  },
  ui_fashionable_dress_shop = {
    resource = "prefab/UIFashion.prefab",
    class = "ui_fashionable_dress.ui_fashionable_dress_shop",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    high_update = true
  },
  ui_brand_tip = {
    resource = "prefab/Tips/UIBrandTips.prefab",
    class = "ui_fashionable_dress.ui_fashion_brand_tip",
    sort_order = order_cfg.Dialog,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  material_stage_info = {
    resource = "prefab/ChapterNew/UIStageInfoNew.prefab",
    class = "chapter.material.material_stage_info",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    high_update = true,
    not_full_screen = true
  },
  material_stage_start_tips = {
    resource = "prefab/tips/UIStageStartTips.prefab",
    class = "chapter.material.material_stage_start_tips",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  material_select_drop_tips = {
    resource = "prefab/tips/UISelectDropTips.prefab",
    class = "chapter.material.material_select_drop_tips",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  scene_event_main = {
    resource = "prefab/UIEvent.prefab",
    class = "scene_event.scene_event_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  chapter_material_reward = {
    resource = "prefab/UIDataPreview_reward.prefab",
    class = "chapter.chapter_material_reward",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "chapter_material_record"
  },
  chapter_material_record = {
    resource = "prefab/UIDataPreview.prefab",
    class = "chapter.chapter_material_record",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  uifight_skill_select = {
    resource = "prefab/UISkillBook.prefab",
    class = "battle_skill.skill_book_select",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    is_end_joystick = true,
    need_pause_game = true
  },
  uifight_skill_show = {
    resource = "prefab/UISkillShow.prefab",
    class = "battle_skill.skill_book_show",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  uichat = {
    resource = "prefab/UIChannel.prefab",
    class = "chat.uichat",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    not_full_screen = true,
    normal_update = true
  },
  fight_item_tips = {
    resource = "prefab/Tips/FightItemTips.prefab",
    class = "tip.fight_item_tips",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  debug_msg_tips = {
    resource = "prefab/Tips/UIDebugMsg.prefab",
    class = "tip.ui_debug_msg",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  novice_task = {
    resource = "prefab/UINoviceTask.prefab",
    class = "novice.ui_novice_task",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    panels = {
      {
        name = "ui_sign_in_task",
        root = "Mode_signin",
        class = "novice.ui_sign_in_task",
        initshow = false
      },
      {
        name = "ui_daily_task",
        root = "Mode_task",
        class = "novice.ui_daily_task",
        initshow = false
      }
    },
    not_full_screen = true
  },
  systeminfo = {
    resource = "prefab/UISystemInfo.prefab",
    class = "gm.systeminfo",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  floor_settle = {
    resource = "prefab/UIFloor_settle.prefab",
    class = "fight.ui_floor_settle",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    need_pause_game = true
  },
  ui_guide = {
    resource = "prefab/tips/GuideTips.prefab",
    class = "guide.ui_guide",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    high_update = true,
    sync_load = true,
    panels = {
      {
        name = "normal_guide",
        root = "Frame",
        class = "guide.normal_guide",
        initshow = false
      },
      {
        name = "long_guide",
        root = "Frame",
        class = "guide.long_guide",
        initshow = false
      },
      {
        name = "notify_guide",
        root = "Frame",
        class = "guide.notify_guide",
        initshow = false
      },
      {
        name = "story_guide",
        root = "Frame",
        class = "guide.story_guide",
        initshow = false
      }
    }
  },
  battle_setting = {
    resource = "prefab/UISetting.prefab",
    class = "battle_setting.battle_setting_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    need_pause_game = true,
    keep_stack_show = true
  },
  battle_btn_setting = {
    resource = "prefab/UISetting_button.prefab",
    class = "fight.custom_button.fight_layout_setting",
    panels = {
      {
        name = "fight_panel",
        root = "UIFight",
        class = "fight.custom_button.fight_layout",
        initshow = false
      },
      {
        name = "change_name",
        root = "ChangeName",
        class = "fight.custom_button.fight_layout_change_name",
        initshow = false
      },
      {
        name = "control_content",
        root = "ControlContent",
        class = "fight.custom_button.control_content",
        initshow = false
      },
      {
        name = "detail_content",
        root = "SingleControl",
        class = "fight.custom_button.detail_content",
        initshow = false
      }
    },
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  battle_challenge_task = {
    resource = "prefab/UIFightTask.prefab",
    class = "fight_task.ui_battle_task",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  graphic_guide = {
    resource = "prefab/UIteaching.prefab",
    class = "graphic_guide.graphic_guide_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true,
    is_end_joystick = true,
    need_pause_game = true,
    high_update = true,
    open_default_ui = true
  },
  ui_introduce = {
    resource = "prefab/UIteaching.prefab",
    class = "tip.ui_introduce_new",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true,
    sync_load = false,
    not_full_screen = true,
    high_update = true
  },
  teaching = {
    resource = "prefab/UITeachingOutside.prefab",
    class = "character.teaching",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true,
    is_end_joystick = true
  },
  signboard_change = {
    resource = "prefab/UISignBoard_Girl_Change.prefab",
    class = "uimain.signboard_girl_change",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    not_full_screen = true
  },
  repair_game_tip = {
    resource = "prefab/tips/UIFixGameTip.prefab",
    class = "tip.repair_game_tip",
    sync_load = true,
    sort_order = order_cfg.Tip,
    normal_update = true
  },
  no_fight_game = {
    resource = "prefab/UINoFightGame.prefab",
    class = "no_fight_game.no_fight_game_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true
  },
  top_version_main = {
    resource = "prefab/TopVersion/UITopVersionMain.prefab",
    class = "stage_activity.top_version.top_version_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  challenge_ring_enter_view = {
    resource = "prefab/ChallengeRing/UIChallengeRingMain.prefab",
    class = "stage_activity.challenge_ring.challenge_ring_act_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    keep_stack_show = true
  },
  top_ver_task = {
    resource = "prefab/TopVersion/UITopVersionTask.prefab",
    class = "stage_activity.top_version.top_ver_task",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  top_ver_prepare = {
    resource = "prefab/TopVersion/UITopVersionPrepare.prefab",
    class = "stage_activity.top_version.top_ver_prepare",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  top_ver_team = {
    resource = "prefab/TopVersion/UITopVersionTeam.prefab",
    class = "stage_activity.top_version.top_ver_team",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    keep_stack_show = true
  },
  top_ver_settlement = {
    resource = "prefab/TopVersion/UITopVersionSettle.prefab",
    class = "stage_activity.top_version.top_ver_settlement",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true,
    need_pause_game = true,
    is_settle_ui = true
  },
  uidrop_show = {
    resource = "prefab/UIDropShow.prefab",
    class = "drop_show.drop_show_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    is_end_joystick = true,
    need_pause_game = true
  },
  ui_timeline = {
    resource = "prefab/UITimeline.prefab",
    class = "ui_timeline.timeline_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_battle_item = {
    resource = "prefab/Tips/BattleItemInfo.prefab",
    class = "tip.battle_item_info",
    sort_order = order_cfg.Dialog,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    not_full_screen = true
  },
  uidebug_mode_setting = {
    resource = "prefab/UIEditorDebugSetting.prefab",
    class = "debug_setting.debug_setting_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    no_push_stack = true
  },
  ui_login_wait = {
    resource = "prefab/UIConnect_Login.prefab",
    class = "tip.ui_login_wait",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    normal_update = true
  },
  ui_challenge_ring = {
    resource = "prefab/ChallengeRing/UIChallengeRing.prefab",
    class = "stage_activity.challenge_ring.challenge_ring_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    panels = {
      {
        name = "pause_view",
        root = "UICRPause",
        class = "stage_activity.challenge_ring.cr_pause_view",
        initshow = false
      },
      {
        name = "answer_view",
        root = "UICRAnswerTip",
        class = "stage_activity.challenge_ring.cr_answer_tip",
        initshow = false
      }
    },
    use_low_render_frame = true
  },
  ui_cr_card_deck = {
    resource = "prefab/ChallengeRing/UICardDeck.prefab",
    class = "stage_activity.challenge_ring.card_deck_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_WORLD,
    normal_update = true,
    sync_load = false,
    world = true,
    parent_ui = "ui_challenge_ring"
  },
  local_cr_card_deck = {
    resource = "prefab/ChallengeRing/UICardDeck.prefab",
    class = "stage_activity.challenge_ring.local_card_deck_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_WORLD,
    sync_load = false,
    world = true,
    high_update = true
  },
  battle_bag = {
    resource = "prefab/ChallengeRing/uifightpause3.prefab",
    class = "battle_bag.battle_bag_main",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    panels = {
      {
        name = "collect_bag_view",
        root = "CollectView",
        class = "battle_bag.collect_bag_view",
        initshow = true
      },
      {
        name = "rune_bag_view",
        root = "RuneView",
        class = "battle_bag.rune_bag_view",
        initshow = true
      },
      {
        name = "item_bag_view",
        root = "ItemView",
        class = "battle_bag.item_bag_view",
        initshow = true
      },
      {
        name = "equip_bag_view",
        root = "EquipView",
        class = "battle_bag.equip_bag_view",
        initshow = true
      },
      {
        name = "item_tips",
        root = "ItemTips",
        class = "battle_bag.item_tips",
        initshow = false
      }
    },
    normal_update = true
  },
  fight_pause_common = {
    resource = "prefab/UIBattlePauseCom.prefab",
    class = "fight.fight_pause_common",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    need_pause_game = true,
    is_end_joystick = true,
    disable_camera_on_show = true
  },
  fight_pause_common_v2 = {
    resource = "prefab/UIBattlePauseCom1.prefab",
    class = "fight.fight_pause_common_v2",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    need_pause_game = true,
    is_end_joystick = true,
    disable_camera_on_show = true
  },
  ring_skill = {
    resource = "prefab/UIRingSkill.prefab",
    class = "battle_bag.ring_skill_main",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    need_pause_game = true
  },
  rune_tips = {
    resource = "prefab/tips/UIRuneTips.prefab",
    class = "battle_bag.rune_tips",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  rune_upgrade_tips = {
    resource = "prefab/tips/UIRuneUpgradeTips.prefab",
    class = "battle_bag.rune_upgrade_tips",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  ui_cr_treasure_box = {
    resource = "prefab/ChallengeRing/UICRTreasure.prefab",
    class = "stage_activity.challenge_ring.cr_treasure_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    is_end_joystick = true,
    need_pause_game = true
  },
  ui_cr_shop = {
    resource = "prefab/ChallengeRing/UICRShop.prefab",
    class = "stage_activity.challenge_ring.cr_shop_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  uidynamic_canvas = {
    resource = "prefab/UIDynamicCanvas.prefab",
    class = "fight.hud.ui_dynamic_canvas",
    sync_load = true,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "fight",
    not_full_screen = true,
    high_update = true,
    preload_type = true
  },
  uifight_story = {
    resource = "prefab/UIFightStory.prefab",
    class = "fight.fight_story",
    sync_load = true,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    is_end_joystick = true
  },
  fight_settlement = {
    resource = "prefab/ChallengeRing/UICRSettle.prefab",
    class = "fight.fight_settlement_new",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    use_low_render_frame = true,
    is_end_joystick = true,
    need_pause_game = true,
    is_settle_ui = true
  },
  test_show_prefab = {
    resource = "prefab/UITestShowModel.prefab",
    class = "character.test_show_prefab",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    high_update = true,
    sync_load = false
  },
  fly_notice = {
    resource = "prefab/UIFlyNotice.prefab",
    class = "tip.fly_notice",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_init_box = {
    resource = "prefab/UIOriginalBox.prefab",
    class = "init_box.init_box_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true
  },
  battle_item_tips = {
    resource = "prefab/tips/UIBattleItemTips.prefab",
    class = "battle_bag.battle_item_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true,
    is_end_joystick = true
  },
  battle_task_main = {
    resource = "prefab/UIBattleTaskMain.prefab",
    class = "fight_task.battle_task_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    sync_load = false,
    background_blur = true,
    need_pause_game = true
  },
  banner_tip = {
    resource = "prefab/UIBannerTip.prefab",
    class = "fight.banner_tip",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  hero_skill_teach = {
    resource = "prefab/HeroTeaching/UISkillTeachMain.prefab",
    class = "stage_activity.skill_teach.hero_skill_teach",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  teach_chapter_point = {
    resource = "prefab/HeroTeaching/UISkillTeachStage.prefab",
    class = "stage_activity.skill_teach.teach_chapter_point",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    keep_stack_show = false
  },
  skill_teach_main = {
    resource = "prefab/HeroTeaching/UIHeroTeaching.prefab",
    class = "stage_activity.skill_teach.skill_teach_main",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    not_full_screen = true
  },
  skill_teach_tips = {
    resource = "prefab/HeroTeaching/UISkillTeachTips.prefab",
    class = "stage_activity.skill_teach.skill_teach_tips",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    is_end_joystick = true,
    background_blur = true,
    need_pause_game = true
  },
  skill_teach_pause_main = {
    resource = "prefab/HeroTeaching/UIFightPauseTeach.prefab",
    class = "stage_activity.skill_teach.skill_teach_pause_main",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    need_pause_game = true
  },
  skill_teach_failure = {
    resource = "prefab/HeroTeaching/HeroTeachFail.prefab",
    class = "stage_activity.skill_teach.skill_teach_failure",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    need_pause_game = true
  },
  archive_enter = {
    resource = "prefab/Archive/UIArchiveEnter.prefab",
    class = "archives.archive_enter",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  char_map = {
    resource = "prefab/Archive/UIArchiveHero.prefab",
    class = "archives.char_map",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    keep_stack_show = true,
    panels = {
      {
        name = "archive_char_main",
        root = "CharMain",
        class = "archives.archive_char_main",
        initshow = false
      },
      {
        name = "archive_basic_info",
        root = "BasicInfo",
        class = "archives.archive_basic_info",
        initshow = false
      },
      {
        name = "archive_char_voice",
        root = "Char_Voice",
        class = "archives.archive_char_voice",
        initshow = false
      },
      {
        name = "archive_char_story",
        root = "Char_Story",
        class = "archives.archive_char_story",
        initshow = false
      },
      {
        name = "archive_char_skill",
        root = "Char_Skill",
        class = "archives.archive_char_skill",
        initshow = false
      },
      {
        name = "archive_char_advance",
        root = "Char_Advance",
        class = "archives.archive_char_advance",
        initshow = false
      }
    },
    view_level = type_cfg.MAIN_VIEW,
    high_update = true
  },
  world_map = {
    resource = "prefab/Archive/UIWorldMap.prefab",
    class = "archives.world_map",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  world_dic = {
    resource = "prefab/Archive/UIWorldDictionary1.prefab",
    class = "archives.world_dic",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  world_dic_for_story = {
    resource = "prefab/Archive/UIWorldDictionaryBattle.prefab",
    class = "archives.world_dic",
    sort_order = order_cfg.Special,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  fashion_book = {
    resource = "prefab/Archive/UIFashionBook.prefab",
    class = "archives.fasion_book",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_archive_equip = {
    resource = "prefab/Archive/UIArchiveEquip.prefab",
    class = "archives.archive_equip",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    panels = {
      {
        name = "equip_view",
        root = "EquipView",
        class = "archives.archive_equip_sub_view_equip",
        initshow = false
      },
      {
        name = "puzzle_view",
        root = "PluginView",
        class = "archives.archive_equip_sub_view_puzzle",
        initshow = false
      }
    }
  },
  enemy_info_sys = {
    resource = "prefab/Archive/UIEnemyInforList.prefab",
    class = "archives.enemy_info_sys",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  archive_story = {
    resource = "prefab/Archive/UIArchiveStory1.prefab",
    class = "archives.archive_story",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  archive_story_main = {
    resource = "prefab/Archive/UIArchiveStoryMain1.prefab",
    class = "archives.archive_story_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  online_battle_point = {
    resource = "prefab/JointOperations/UIJointOperationsMain.prefab",
    class = "stage_activity.online_battle.online_battle_point",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    keep_stack_show = true
  },
  online_battle_point_detail = {
    resource = "prefab/JointOperations/JointStageInfo.prefab",
    class = "stage_activity.online_battle.online_battle_point_detail",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    not_full_screen = true
  },
  online_create_room_tips = {
    resource = "prefab/JointOperations/JointCreateRoomTips.prefab",
    class = "stage_activity.online_battle.online_create_room_tips",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  online_battle_match_tips = {
    resource = "prefab/JointOperations/UIJointMatchTips.prefab",
    class = "stage_activity.online_battle.online_battle_match_tips",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  online_battle_tips = {
    resource = "prefab/JointOperations/JointTips.prefab",
    class = "stage_activity.online_battle.online_battle_tips",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  online_team = {
    resource = "prefab/JointOperations/UIJointTeam.prefab",
    class = "stage_activity.online_battle.online_team",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    keep_stack_show = true
  },
  enemy_info = {
    resource = "prefab/Archive/UIEnemyInfo.prefab",
    class = "archives.enemy_info",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  enemy_info_tips = {
    resource = "prefab/Tips/UIEnemyInfoTips.prefab",
    class = "tip.enemy_info_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  info_tips = {
    resource = "prefab/Tips/InfoTips.prefab",
    class = "tip.info_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  archive_photo = {
    resource = "prefab/Archive/UIArchivePhoto1.prefab",
    class = "archives.archive_photo",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  recharge_shop = {
    resource = "prefab/Shop/UIShop_Recharge.prefab",
    class = "shop.recharge_shop.recharge_shop",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "shop",
    view_level = type_cfg.MAIN_VIEW
  },
  recommond_shop = {
    resource = "prefab/Shop/UIShop_Recommond.prefab",
    class = "shop.recommond_shop.recommond_shop",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "shop",
    view_level = type_cfg.MAIN_VIEW,
    panels = {
      {
        name = "card_shop",
        root = "MonthCardShow_Copy",
        class = "shop.recommond_shop.month_card_shop",
        initshow = false
      },
      {
        name = "first_recharge_view",
        root = "FirstCharge",
        class = "shop.recommond_shop.first_recharge_view",
        initshow = false
      },
      {
        name = "order_view",
        root = "OrderObj",
        class = "shop.recommond_shop.order_view",
        initshow = false
      }
    },
    normal_update = true
  },
  gift_shop = {
    resource = "prefab/Shop/UIShop_GiftNew.prefab",
    class = "shop.gift_shop.gift_shop",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "shop",
    view_level = type_cfg.MAIN_VIEW
  },
  gift_shop_tips = {
    resource = "prefab/Shop/UIShopGiftTipsNew.prefab",
    class = "shop.gift_shop.gift_shop_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    panels = {
      {
        name = "gift_goods_detail",
        root = "GiftDetail",
        class = "shop.gift_shop.gift_goods_detail",
        initshow = false
      },
      {
        name = "skin_gift_short",
        root = "SkinShort",
        class = "shop.gift_shop.skin_gift_short",
        initshow = false
      }
    },
    background_blur = true
  },
  skin_shop = {
    resource = "prefab/Shop/UIShop_FashionNew.prefab",
    class = "shop.skin_shop.skin_shop",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "shop",
    view_level = type_cfg.MAIN_VIEW
  },
  ui_buy_fashion_tips = {
    resource = "prefab/Tips/UIBuyFashionTips.prefab",
    class = "shop.skin_shop.ui_buy_fashion_tips",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  ui_fashion_show = {
    resource = "prefab/UIFashionShow.prefab",
    class = "shop.skin_shop.ui_fashion_show",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  treasure_chest = {
    resource = "prefab/UITreasureBox.prefab",
    class = "treasure_chest.treasure_chest",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  card_pack = {
    resource = "prefab/ChallengeRing/Plus/UITreasureBox2.prefab",
    class = "card_pack.card_pack",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  challenge_ring_floor_settle = {
    resource = "prefab/ChallengeRing/Plus/UIFloorSettle.prefab",
    class = "stage_activity.challenge_ring_plus.challenge_ring_floor_settle",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  flip_card = {
    resource = "prefab/UIFlipCard.prefab",
    class = "stage_activity.challenge_ring_plus.flip_card",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true,
    sync_load = false
  },
  flip_card_award = {
    resource = "prefab/UIFlipCardAward.prefab",
    class = "stage_activity.challenge_ring_plus.flip_card_award",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  card_pack_tips = {
    resource = "prefab/ChallengeRing/Plus/UICardBoxTips.prefab",
    class = "stage_activity.challenge_ring_plus.card_pack_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true
  },
  battle_drop_tips = {
    resource = "prefab/Tips/UIBattleDropTips.prefab",
    class = "gecao.battle_drop_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    show_after_panel = "gecao_pause",
    is_set_player_control_off = true,
    is_end_joystick = true
  },
  card_pack_detail = {
    resource = "prefab/ChallengeRing/Plus/UICardBagDetail.prefab",
    class = "card_pack.card_pack_detail",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  right_age_tips = {
    resource = "prefab/Tips/UIAgeTips.prefab",
    class = "tip.right_age_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    not_full_screen = true
  },
  fly_mark_main = {
    resource = "prefab/UIFlyMark.prefab",
    class = "tip.fly_mark_main",
    sort_order = order_cfg.Alert + 30,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    not_full_screen = true
  },
  union_main = {
    resource = "prefab/Union/UIUnion.prefab",
    class = "union.union_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  union_search = {
    resource = "prefab/union/UISearchUnion.prefab",
    class = "union.union_search.union_search",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "union_main",
    panels = {
      {
        name = "union_search_info",
        root = "UnionBaseInfo",
        class = "union.union_search.union_search_info",
        initshow = false
      }
    }
  },
  union_create = {
    resource = "prefab/union/UICreateUnion.prefab",
    class = "union.union_create",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "union_main"
  },
  union_invite_message = {
    resource = "prefab/union/UIInvitationMessage.prefab",
    class = "union.invite_message.union_invite_message",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "union_main"
  },
  union_lobby = {
    resource = "prefab/union/UIUnionLobby.prefab",
    class = "union.union_lobby.union_lobby",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "union_main",
    panels = {
      {
        name = "union_change_name",
        root = "ChangeNameTips",
        class = "union.union_lobby.change_name_tips",
        initshow = false
      },
      {
        name = "union_change_profile",
        root = "ChangeProfileTips",
        class = "union.union_lobby.change_profile_tips",
        initshow = false
      },
      {
        name = "union_change_slogan",
        root = "ChangeSloganTips",
        class = "union.union_lobby.change_slogan_tips",
        initshow = false
      }
    }
  },
  union_memeber = {
    resource = "prefab/union/UIUnionMember.prefab",
    class = "union.union_member.union_member",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "union_lobby",
    normal_update = true,
    panels = {
      {
        name = "union_memebr_info_tips",
        root = "MemberInfoTips",
        class = "union.union_member.member_info_tips",
        initshow = false
      }
    }
  },
  union_invite = {
    resource = "prefab/union/UIUnionInvite.prefab",
    class = "union.union_invite.union_invite",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "union_lobby"
  },
  union_application = {
    resource = "prefab/union/UIUnionApplication.prefab",
    class = "union.union_apply.union_application",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "union_lobby"
  },
  union_chat = {
    resource = "prefab/UIChannel.prefab",
    class = "chat.uichat",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent_ui = "union_lobby",
    normal_update = true
  },
  desc_story = {
    resource = "prefab/UIDescStory.prefab",
    class = "story.desc_story",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  infinite_main = {
    resource = "prefab/Endless/UIStageEndless.prefab",
    class = "chapter.infinite.infinite_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  infinite_point = {
    resource = "prefab/Endless/UIEndlessPoint.prefab",
    class = "chapter.infinite.infinite_point",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  infinite_task = {
    resource = "prefab/Endless/UIEndlessTask.prefab",
    class = "chapter.infinite.infinite_task",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  infinite_privilege = {
    resource = "prefab/Endless/UIEndlessPrivilege.prefab",
    class = "chapter.infinite.infinite_privilege",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  infinite_reward = {
    resource = "prefab/Endless/UIEndlessRewardPoint.prefab",
    class = "chapter.infinite.infinite_reward",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  infinite_rank = {
    resource = "prefab/Endless/UIEndlessRank.prefab",
    class = "chapter.infinite.infinite_rank",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  endless_main = {
    resource = "prefab/endless/new/uiendlessmain.prefab",
    class = "chapter.endless.endless_main",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  endless_prewar = {
    resource = "prefab/endless/new/uiendlessprefight.prefab",
    class = "chapter.endless.endless_prewar",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  endless_tp_floor = {
    resource = "prefab/endless/new/uiendlessfloor.prefab",
    class = "chapter.endless.endless_tp_floor",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    need_pause_game = true,
    background_blur = true
  },
  endless_settle = {
    resource = "prefab/endless/new/uiendlesssettle.prefab",
    class = "chapter.endless.endless_settle",
    is_end_joystick = true,
    is_settle_ui = true,
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    need_pause_game = true,
    background_blur = true,
    normal_update = true
  },
  endless_rank = {
    resource = "prefab/endless/new/uiendlessrank.prefab",
    class = "chapter.endless.endless_rank",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  challenge_ring_plus = {
    resource = "prefab/fatebook/uifatebookbattle.prefab",
    class = "stage_activity.challenge_ring_plus.challenge_ring_plus",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    disable_camera_on_show = true,
    need_pause_game = true
  },
  curse_ring_card = {
    resource = "prefab/ChallengeRing/Plus/UIRingCardNew.prefab",
    class = "stage_activity.challenge_ring_plus.ring_card_new",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_WORLD,
    normal_update = true,
    sync_load = true,
    world = true,
    parent_ui = "challenge_ring_plus",
    need_pause_game = true
  },
  curse_ring_quit = {
    resource = "prefab/ChallengeRing/Plus/UICRPause.prefab",
    class = "stage_activity.challenge_ring_plus.curse_ring_quit",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    need_pause_game = true,
    disable_camera_on_show = true
  },
  curse_ring_floor = {
    resource = "prefab/ChallengeRing/Plus/ChalRingFloor.prefab",
    class = "stage_activity.challenge_ring_plus.curse_ring_floor",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  curse_blood_room = {
    resource = "prefab/ChallengeRing/Plus/CRBoodRoom.prefab",
    class = "stage_activity.challenge_ring_plus.curse_blood_room",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true
  },
  curse_task_room = {
    resource = "prefab/fatebook/fatebooktask.prefab",
    class = "stage_activity.challenge_ring_plus.curse_task_room",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    need_pause_game = true
  },
  curse_activate = {
    resource = "prefab/fatebook/uicurseactivate.prefab",
    class = "stage_activity.challenge_ring_plus.curse_activate",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true
  },
  curse_task_comlete = {
    resource = "prefab/ChallengeRing/Plus/CRTaskComplete.prefab",
    class = "stage_activity.challenge_ring_plus.curse_task_comlete",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  curse_ring_hero_tip = {
    resource = "prefab/ChallengeRing/Plus/UIHeroTips.prefab",
    class = "stage_activity.challenge_ring_plus.curse_ring_hero_tip",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    parent = "challenge_ring_plus",
    no_push_stack = true
  },
  challenge_ring_plus_main = {
    resource = "prefab/ChallengeRing/Plus/UIChalRingMain.prefab",
    class = "stage_activity.challenge_ring_plus.challenge_ring_plus_main",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  challenge_ring_plus_difficulty = {
    resource = "prefab/ChallengeRing/Plus/UIChalRingDifficulty.prefab",
    class = "stage_activity.challenge_ring_plus.challenge_ring_plus_difficulty",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  challenge_ring_plus_contribute_shop = {
    resource = "prefab/ChallengeRing/Plus/UIChalRingContriShop.prefab",
    class = "stage_activity.challenge_ring_plus.challenge_ring_plus_contribute_shop",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  chal_ring_plus_contri_shop_item_tips = {
    resource = "prefab/tips/shopitemtips.prefab",
    class = "stage_activity.challenge_ring_plus.chal_ring_plus_contri_shop_item_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    panels = {
      {
        name = "contribute_shop_buy_view",
        root = "BuyMode",
        class = "stage_activity.challenge_ring_plus.contribute_shop_buy_view",
        initshow = false
      }
    },
    background_blur = true
  },
  challenge_ring_plus_blessing_view = {
    resource = "prefab/ChallengeRing/Plus/UICRBlessing.prefab",
    class = "stage_activity.challenge_ring_plus.challenge_ring_plus_blessing_view",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  challenge_ring_plus_shop_room = {
    resource = "prefab/ChallengeRing/Plus/CRShopRoom.prefab",
    class = "stage_activity.challenge_ring_plus.challenge_ring_plus_shop_room",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    is_end_joystick = true,
    need_pause_game = true
  },
  challenge_ring_plus_rune_forge_room = {
    resource = "prefab/ChallengeRing/Plus/CRRuneForgeRoom.prefab",
    class = "stage_activity.challenge_ring_plus.challenge_ring_plus_rune_forge_room",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    is_end_joystick = true,
    need_pause_game = true
  },
  curse_ring_ornaments_dorp = {
    resource = "prefab/ChallengeRing/Plus/CROrnamentsDropOp.prefab",
    class = "stage_activity.challenge_ring_plus.curse_ring_ornaments_dorp",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  curse_ring_tips = {
    resource = "prefab/ChallengeRing/Plus/ChalRingTips.prefab",
    class = "stage_activity.challenge_ring_plus.curse_ring_tips",
    sync_load = false,
    sort_order = order_cfg.Dialog,
    group = group_cfg.GROUP_NORMAL
  },
  curse_ring_settlement = {
    resource = "prefab/challengering/plus/uichalringsettle.prefab.prefab",
    class = "stage_activity.challenge_ring_plus.curse_ring_settlement",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    is_end_joystick = true,
    need_pause_game = true,
    is_settle_ui = true
  },
  fate_book_skill_tree = {
    resource = "prefab/fatebook/uifatebookskilltree.prefab",
    class = "stage_activity.fate_book.fate_book_skill_tree",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  fate_book_main = {
    resource = "prefab/fatebook/uifatebook.prefab",
    class = "stage_activity.fate_book.fate_book_main",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  fate_book_point_detail = {
    resource = "prefab/fatebook/uifatebookstage.prefab",
    class = "stage_activity.fate_book.fate_book_point_detail",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  fate_book_course_main = {
    resource = "prefab/fatebook/uifatebookcoursemain.prefab",
    class = "stage_activity.fate_book.fate_book_course_main",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  fate_book_course = {
    resource = "prefab/fatebook/uifatebookcourse.prefab",
    class = "stage_activity.fate_book.fate_book_course",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  fate_book_illustrated = {
    resource = "prefab/fatebook/uifatebookhandbook.prefab",
    class = "stage_activity.fate_book.fate_book_illustrated",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  fate_book_illustrated_orn = {
    resource = "prefab/fatebook/uifb_ornhandbook.prefab",
    class = "stage_activity.fate_book.fate_book_illustrated_orn",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  fate_book_illustrated_event = {
    resource = "prefab/fatebook/uifb_eventhandbook.prefab",
    class = "stage_activity.fate_book.fate_book_illustrated_event",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  fate_book_illustrated_ability = {
    resource = "prefab/fatebook/fatebooktalent.prefab",
    class = "stage_activity.fate_book.fate_book_illustrated_ability",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  fate_book_illustrated_equation = {
    resource = "prefab/fatebook/uifb_equationhandbook.prefab",
    class = "stage_activity.fate_book.fate_book_illustrated_equation",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW
  },
  fate_book_event_card = {
    resource = "prefab/fatebook/uifatebookevent.prefab",
    class = "stage_activity.fate_book.fate_book_event_card",
    sync_load = true,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    normal_update = true,
    need_pause_game = true
  },
  fate_book_shop_card = {
    resource = "prefab/fatebook/uifatebookshop.prefab",
    class = "stage_activity.fate_book.fate_book_shop_card",
    sync_load = true,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    need_pause_game = true
  },
  fate_book_settle = {
    resource = "prefab/fatebook/uifatebooksettle.prefab",
    class = "stage_activity.fate_book.fate_book_settle",
    is_end_joystick = true,
    is_settle_ui = true,
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    need_pause_game = true,
    background_blur = true,
    normal_update = true
  },
  fate_book_floor = {
    resource = "prefab/fatebook/fatebookfloor.prefab",
    class = "stage_activity.fate_book.fate_book_floor",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    need_pause_game = true
  },
  fate_book_task = {
    resource = "prefab/fatebook/fatebook_task.prefab",
    class = "stage_activity.fate_book.fate_book_task",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  fate_book_initial_option = {
    resource = "prefab/fatebook/uifatebookinitialaward.prefab",
    class = "stage_activity.fate_book.fate_book_initial_option",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    need_pause_game = true
  },
  fate_book_level_tips = {
    resource = "prefab/fatebook/uifatelvtips.prefab",
    class = "stage_activity.fate_book.fate_book_level_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    need_pause_game = true
  },
  fate_book_mini_game_clear = {
    resource = "prefab/fatebook/uifbgameclear.prefab",
    class = "stage_activity.fate_book.fate_book_mini_game_clear",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    need_pause_game = true
  },
  choose_equation_view = {
    resource = "prefab/fatebook/uifb_equation.prefab",
    class = "stage_activity.fate_book.choose_equation_view",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    need_pause_game = true
  },
  fate_book_quick_view = {
    resource = "prefab/fatebook/uifb_quickview.prefab",
    class = "stage_activity.fate_book.fate_book_quick_view",
    sort_order = order_cfg.SeniorTip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  equation_condition_tips = {
    resource = "prefab/fatebook/uifb_talentconditiontips.prefab",
    class = "stage_activity.fate_book.equation_condition_tips",
    sort_order = order_cfg.SeniorTip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  equation_show_tips = {
    resource = "prefab/fatebook/uiequationshow.prefab",
    class = "stage_activity.fate_book.equation_show_tips",
    sort_order = order_cfg.SeniorTip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_finger_guide = {
    resource = "prefab/UIFingerScaling.prefab",
    class = "guide.ui_finger_guide",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    not_full_screen = true,
    normal_update = true
  },
  curse_ring_view = {
    resource = "prefab/ChallengeRing/Plus/UIChalRingBattle.prefab",
    class = "fight.curse_ring_view",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    not_calc_match = true,
    preload_type = true,
    no_push_stack = true
  },
  item_synthesis = {
    resource = "prefab/UIItemSynthesis.prefab",
    class = "uibag.ui_item_synthesis",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  item_synthesis_tips = {
    resource = "prefab/Tips/UISynthesisTips.prefab",
    class = "uibag.item_synthesis_tips",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  gecao_main = {
    resource = "prefab/GeCao/UIGeCao.prefab",
    class = "gecao.gecao_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW,
    normal_update = true,
    keep_stack_show = true
  },
  gecao_settle = {
    resource = "prefab/GeCao/GeCaoSettle.prefab",
    class = "gecao.gecao_settle",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    use_low_render_frame = true,
    is_end_joystick = true,
    need_pause_game = true,
    is_settle_ui = true
  },
  gecao_pause = {
    resource = "prefab/GeCao/GeCaoPause.prefab",
    class = "gecao.gecao_pause",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    use_low_render_frame = true,
    is_end_joystick = true,
    need_pause_game = true
  },
  gecao_award_tip = {
    resource = "prefab/GeCao/UIGeCaoAwardTips.prefab",
    class = "gecao.gecao_award_tip",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  gecao_stage_info = {
    resource = "prefab/GeCao/GeCaoStageInfo.prefab",
    class = "gecao.gecao_stage_info",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    high_update = true,
    not_full_screen = true
  },
  gecao_battle = {
    resource = "prefab/GeCao/UIGeCaoBattle.prefab",
    class = "gecao.gecao_battle",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    not_calc_match = true,
    preload_type = true,
    not_full_screen = true,
    no_push_stack = true
  },
  collection_main = {
    resource = "prefab/ChapterNew/UICollection1.prefab",
    class = "collection.collection_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  collection_tip = {
    resource = "prefab/Tips/UICollectionTips.prefab",
    class = "collection.collection_tip",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    need_pause_game = true
  },
  not_progress_battle_suc_settle = {
    resource = "prefab/UISettleSuc.prefab",
    class = "fight.not_progress_battle_suc_settle",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    is_set_player_control_off = true,
    is_end_joystick = true,
    is_settle_ui = true,
    normal_update = true,
    need_pause_game = true
  },
  not_progress_battle_def_settle = {
    resource = "prefab/UISettleDef.prefab",
    class = "fight.not_progress_battle_def_settle",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    need_pause_game = true,
    is_settle_ui = true
  },
  damage_detail = {
    resource = "prefab/tips/uidamagedetail.prefab",
    class = "fight.tips.damage_detail",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true
  },
  challenge_ring_card_atlas = {
    resource = "prefab/ChallengeRing/Plus/UICRCardAtlas.prefab",
    class = "stage_activity.challenge_ring_plus.challenge_ring_card_atlas",
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_click_effect = {
    resource = "prefab/UIClickEffect.prefab",
    class = "ui_click_effect.ui_click_effect",
    sort_order = order_cfg.Click,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    high_update = true
  },
  achievement_group = {
    resource = "prefab/Achivement/UIAchievement.prefab",
    class = "achievement.achievement_group",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  achievement_detail = {
    resource = "prefab/Achivement/UIAchievementDetail.prefab",
    class = "achievement.achievement_detail",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    need_pause_game = true
  },
  achiev_pre_award_tip = {
    resource = "prefab/Achivement/UIAchievPreAward.prefab",
    class = "achievement.achiev_pre_award_tip",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  task_reward_tips = {
    resource = "prefab/Tips/TaskRewardTips.prefab",
    class = "task.task_reward_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  common_battle_tips = {
    resource = "prefab/Tips/CommonBattleTips.prefab",
    class = "achievement.common_battle_tips",
    sort_order = order_cfg.SeniorTip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  fight_room_delay_add_magic = {
    resource = "prefab/UIBattleDelayAddMagic.prefab",
    class = "fight.fight_room_delay_add_magic",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    no_push_stack = true
  },
  ui_blackfade = {
    resource = "prefab/uiblack.prefab",
    class = "tip.ui_blackfade",
    sync_load = true,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  ui_ornaments = {
    resource = "prefab/UIOrnaments.prefab",
    class = "ornaments.ui_ornaments",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  weekly_select = {
    resource = "prefab/WeekAct1/WeekAct1_StageList.prefab",
    class = "weekly.weekly_select_panel",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    high_update = true
  },
  weekly_battle_detail = {
    resource = "prefab/WeekAct1/WeekAct1_StageInfo.prefab",
    class = "weekly.weekly_battle_detail",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  weekly_stage_award = {
    resource = "prefab/WeekAct1/WeekAct1_StageAward.prefab",
    class = "weekly.weekly_stage_award",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  weekly_rule = {
    resource = "prefab/WeekAct1/WeekAct1_RuleDetail.prefab",
    class = "weekly.weekly_rule",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true
  },
  weekly_pvp_detail_stage1 = {
    resource = "prefab/WeekAct1/WeekAct1_PVP.prefab",
    class = "weekly.weekly_pvp_detail_stage1",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  weekly_pvp_stage_tip = {
    resource = "prefab/WeekAct1/UIWeekAct1_EffectTips.prefab",
    class = "weekly.weekly_pvp_stage_tip",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  weekly_pvp_difficulty_choose = {
    resource = "prefab/WeekAct1/UIWeekAct1_RankChoose.prefab",
    class = "weekly.weekly_pvp_difficulty_choose",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  weekly_pvp_difficulty_award = {
    resource = "prefab/WeekAct1/WeekAct1_RankAward.prefab",
    class = "weekly.weekly_pvp_difficulty_award",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  weekly_pvp_star_award = {
    resource = "prefab/WeekAct1/WeekAct1_StarAward.prefab",
    class = "weekly.weekly_pvp_star_award",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  weekly_pvp_shop = {
    resource = "prefab/WeekAct1/WeekAct1_Shop.prefab",
    class = "weekly.weekly_pvp_shop",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  weekly_pvp_top_rank = {
    resource = "prefab/WeekAct1/WeekAct1_TopRank.prefab",
    class = "weekly.weekly_pvp_top_rank",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  weekly_pvp_rank_settle = {
    resource = "prefab/WeekAct1/WeekAct1_RankSettle.prefab",
    class = "weekly.weekly_pvp_rank_settle",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true
  },
  weekly_fight_settle = {
    resource = "prefab/weekact1/weekact1_settle.prefab",
    class = "weekly.weekly_fight_settle",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    need_pause_game = true,
    is_settle_ui = true,
    background_blur = true,
    normal_update = true
  },
  weekly_pvp_fight_tip = {
    resource = "prefab/UIBannerNotice.prefab",
    class = "weekly.weekly_pvp_fight_tip",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  weekly_pvp_stage = {
    resource = "prefab/weekact1/UIWeekAct1_PVPStage1.prefab",
    class = "weekly.weekly_pvp_stage",
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL
  },
  weekly_new_season = {
    resource = "prefab/weekact1/UIWeekAct1_SeasonReset.prefab",
    class = "weekly.weekly_new_season",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  weekly_skip_stage = {
    resource = "prefab/weekact1/UIWeekAct1_SkipStage.prefab",
    class = "weekly.weekly_skip_stage",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  archive_detail_pop = {
    resource = "prefab/Char/Archives/UIArchivePop.prefab",
    class = "character.archives.archive_detail_pop",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  archive_detail_pop_new = {
    resource = "prefab/Char/Archives/UIFileStory.prefab",
    class = "character.archives.archive_detail_pop_new",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  ui_ct_timer = {
    resource = "prefab/InGame/InGameCTTimer.prefab",
    class = "fight.in_game.ui_ct_timer",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    not_full_screen = true,
    no_push_stack = true
  },
  cur_monster_wave = {
    resource = "prefab/InGame/CurMonsterWave.prefab",
    class = "fight.in_game.cur_monster_wave",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    not_full_screen = true,
    no_push_stack = true
  },
  exp_up_tips = {
    resource = "prefab/Tips/UIExpUp.prefab",
    class = "tip.exp_up_tips",
    sync_load = false,
    sort_order = order_cfg.SeniorTip,
    group = group_cfg.GROUP_NORMAL
  },
  ui_activity = {
    resource = "prefab/activity/uiactivity.prefab",
    class = "activity.ui_activity",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    show_waiting = true,
    normal_update = true
  },
  ui_monthtask = {
    resource = "prefab/MonthTask/UIOrder.prefab",
    class = "monthtask.ui_monthtask",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    show_waiting = true,
    normal_update = true
  },
  ui_monthtask_buy = {
    resource = "prefab/MonthTask/UIOrderBuy.prefab",
    class = "monthtask.ui_monthtask_buy",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  ui_monthtask_buy_lv_tips = {
    resource = "prefab/Tips/UIOrderBuyLvTips.prefab",
    class = "monthtask.ui_monthtask_buy_lv_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  ui_monthtask_final_award_tips = {
    resource = "prefab/tips/UIAwardTipsCom.prefab",
    class = "monthtask.ui_monthtask_final_award_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  ui_monthtask_award_choice = {
    resource = "prefab/MonthTask/UIOrderAwardChoose.prefab",
    class = "monthtask.ui_monthtask_award_choice",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  ui_monthtask_enter = {
    resource = "prefab/MonthTask/UIOrderEnter.prefab",
    class = "monthtask.ui_monthtask_enter",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  ui_monthtask_award_show_panel = {
    resource = "prefab/MonthTask/UIOrderAward.prefab",
    class = "monthtask.ui_monthtask_award_show_panel",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true
  },
  ui_novice_signin_0 = {
    resource = "prefab/activity/uinovicesignin.prefab",
    class = "activity.ui_novice_signin",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true
  },
  ui_novice_signin_1 = {
    resource = "prefab/activity/uinovicesignin_01.prefab",
    class = "activity.ui_seven_signin",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true
  },
  ui_novice_signin_2 = {
    resource = "prefab/activity/uinovicesignin_02.prefab",
    class = "activity.ui_seven_signin",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true
  },
  ui_novice_signin_3 = {
    resource = "prefab/activity/uinovicesignin_03.prefab",
    class = "activity.ui_seven_signin",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true
  },
  ui_novice_signin_4 = {
    resource = "prefab/activity/uinovicesignin_04.prefab",
    class = "activity.ui_seven_signin",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true
  },
  ui_novice_signin_popup_1 = {
    resource = "prefab/tips/UISignInTips1.prefab",
    class = "pop_up_widget.ui_novice_signin_popup",
    sync_load = false,
    sort_order = order_cfg.PopUpWindow,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  ui_novice_signin_popup_2 = {
    resource = "prefab/tips/UISignInTips2.prefab",
    class = "pop_up_widget.ui_novice_signin_popup",
    sync_load = false,
    sort_order = order_cfg.PopUpWindow,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  ui_novice_signin_popup_3 = {
    resource = "prefab/tips/UISignInTips3.prefab",
    class = "pop_up_widget.ui_novice_signin_popup",
    sync_load = false,
    sort_order = order_cfg.PopUpWindow,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  ui_novice_signin_popup_4 = {
    resource = "prefab/tips/UISignInTips4.prefab",
    class = "pop_up_widget.ui_novice_signin_popup",
    sync_load = false,
    sort_order = order_cfg.PopUpWindow,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  ui_normal_popup_1 = {
    resource = "prefab/tips/UIJumpTips1.prefab",
    class = "pop_up_widget.ui_normal_popup",
    sync_load = false,
    sort_order = order_cfg.PopUpWindow,
    group = group_cfg.GROUP_NORMAL
  },
  ui_normal_popup_2 = {
    resource = "prefab/tips/UIJumpTips2.prefab",
    class = "pop_up_widget.ui_normal_popup",
    sync_load = false,
    sort_order = order_cfg.PopUpWindow,
    group = group_cfg.GROUP_NORMAL
  },
  ui_normal_popup_3 = {
    resource = "prefab/tips/UIJumpTips3.prefab",
    class = "pop_up_widget.ui_normal_popup",
    sync_load = false,
    sort_order = order_cfg.PopUpWindow,
    group = group_cfg.GROUP_NORMAL
  },
  ui_normal_popup_4 = {
    resource = "prefab/tips/UIJumpTips4.prefab",
    class = "pop_up_widget.ui_normal_popup",
    sync_load = false,
    sort_order = order_cfg.PopUpWindow,
    group = group_cfg.GROUP_NORMAL
  },
  ui_capsule_toy_popup = {
    resource = "prefab/shop/UIMonthCardRecive.prefab",
    class = "pop_up_widget.ui_capsule_toy_popup",
    sync_load = false,
    sort_order = order_cfg.PopUpWindow,
    normal_update = true,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true
  },
  ui_first_charge_popup = {
    resource = "prefab/Tips/UIFirstChargeTips.prefab",
    class = "pop_up_widget.ui_first_charge_popup",
    sync_load = false,
    sort_order = order_cfg.PopUpWindow,
    group = group_cfg.GROUP_NORMAL
  },
  ui_sdk_popup_holder = {
    resource = "prefab/Tips/UISDKPopupHolder.prefab",
    class = "pop_up_widget.ui_sdk_popup_holder",
    sync_load = false,
    sort_order = order_cfg.PopUpWindow,
    group = group_cfg.GROUP_NORMAL
  },
  ui_novice_task2 = {
    resource = "prefab/activity/UINoviceTask1.prefab",
    class = "activity.ui_novice_task2",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    show_waiting = true,
    normal_update = true
  },
  ui_novice_privilege = {
    resource = "prefab/activity/uinoviceprivilege.prefab",
    class = "activity.ui_novice_privilege",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  ui_novice_course_award = {
    resource = "prefab/activity/UICourseAward.prefab",
    class = "activity.ui_novice_course_award",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  ui_recharge_welfare = {
    resource = "prefab/activity/UIActCZFL.prefab",
    class = "activity.ui_recharge_welfare",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    show_waiting = true
  },
  ui_level_welfare = {
    resource = "prefab/activity/ActicityLvAward.prefab",
    class = "activity.ui_level_welfare",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    show_waiting = true
  },
  ui_weapon_reduction = {
    resource = "prefab/activity/uiweaponreduction.prefab",
    class = "activity.ui_weapon_reduction",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true
  },
  ui_buddy_tryout = {
    resource = "prefab/Activity/UICharTryout.prefab",
    class = "buddy_tryout.ui_buddy_tryout",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  ui_skin_tryout = {
    resource = "prefab/Activity/UIActTryFashion.prefab",
    class = "activity.ui_skin_tryout",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  ui_skin_tryout_1 = {
    resource = "prefab/Activity/UIActTryFashion1.prefab",
    class = "activity.ui_skin_tryout",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  ui_skin_tryout_2 = {
    resource = "prefab/Activity/UIActTryFashion2.prefab",
    class = "activity.ui_skin_tryout",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  ui_skin_tryout_3 = {
    resource = "prefab/Activity/UIActTryFashion3.prefab",
    class = "activity.ui_skin_tryout",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  ui_buddy_draw_activity = {
    resource = "prefab/Activity/UIActDraw.prefab",
    class = "activity.buddy_draw.ui_buddy_draw_activity",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  ui_task_activity_1 = {
    resource = "prefab/Activity/UIAct_Fatebook.prefab",
    class = "activity.ui_task_activity1",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  ui_task_activity_2 = {
    resource = "prefab/Activity/UIAct_Weekact1.prefab",
    class = "activity.ui_task_activity2",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  ui_task_activity3 = {
    resource = "prefab/activity/uiactnewpuzzle.prefab",
    class = "activity.ui_task_activity3",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  ui_catch_cat_activity = {
    resource = "prefab/Activity/UIActEnjiEscape.prefab",
    class = "activity.catch_cat.ui_catch_cat_activity",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  ui_material_double_activity = {
    resource = "prefab/Activity/UIActMaterialDouble.prefab",
    class = "activity.ui_material_double_activity",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  ui_fatebook_double_activity = {
    resource = "prefab/Activity/UIActFBDouble.prefab",
    class = "activity.ui_fatebook_double_activity",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  catch_cat_stage_panel = {
    resource = "prefab/Activity/UIEnjiEscapeStage.prefab",
    class = "activity.catch_cat.catch_cat_stage_panel",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  catch_cat_battle_panel = {
    resource = "prefab/Activity/UIEnjiEscapeBattle.prefab",
    class = "activity.catch_cat.catch_cat_battle_panel",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  catch_cat_result_tips = {
    resource = "prefab/Activity/UIEnjiEscapeSettle.prefab",
    class = "activity.catch_cat.catch_cat_result_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  ui_monkey_typer_activity = {
    resource = "prefab/Activity/UIActMonkey.prefab",
    class = "activity.monkey_typer.ui_monkey_typer_activity",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  monkey_typer_panel = {
    resource = "prefab/Activity/ActMonkey/UIMonkeyMain.prefab",
    class = "activity.monkey_typer.monkey_typer_panel",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  monkey_typer_question_panel = {
    resource = "prefab/Activity/ActMonkey/UIMonkeyQuestion.prefab",
    class = "activity.monkey_typer.monkey_typer_question_panel",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  monkey_typer_question_tips = {
    resource = "prefab/Activity/ActMonkey/UIMonkeyQuestionTips.prefab",
    class = "activity.monkey_typer.monkey_typer_question_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  monkey_typer_task_panel = {
    resource = "prefab/Activity/ActMonkey/UIMonkeyTask.prefab",
    class = "activity.monkey_typer.monkey_typer_task_panel",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_weapon_activity_select = {
    resource = "prefab/Activity/ActWeapon/UIActWeaponSelect.prefab",
    class = "activity.ui_weapon_activity_select",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    show_waiting = true
  },
  ui_weapon_activity_task = {
    resource = "prefab/Activity/ActWeapon/UIActWeaponTask.prefab",
    class = "activity.ui_weapon_activity_task",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    show_waiting = true
  },
  ui_weapon_activity = {
    resource = "prefab/Activity/ActWeapon/UIActWeapon.prefab",
    class = "activity.ui_weapon_activity",
    sync_load = true,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  ui_compensate_activity = {
    resource = "prefab/Activity/UIActMakeUp.prefab",
    class = "activity.ui_compensate_activity",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  cmpnstDailyAwardTip = {
    resource = "prefab/tips/UIMakeUpAwardTips.prefab",
    class = "tip.compensate_dailyaward_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  add_friend_tips = {
    resource = "prefab/Tips/UIAddFriendTips.prefab",
    class = "tip.add_friend_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  choose_genres_view = {
    resource = "prefab/fatebook/uifbsectselect_.prefab",
    class = "stage_activity.challenge_ring_plus.choose_genres_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  choose_ability_view = {
    resource = "prefab/fatebook/uifbtalentselect.prefab",
    class = "stage_activity.challenge_ring_plus.choose_ability_view",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true,
    sync_load = true,
    need_pause_game = true
  },
  scene_skill_lv_up_tips = {
    resource = "prefab/fatebook/uifbstageskilllvup.prefab",
    class = "fight.tips.scene_skill_lv_up_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    need_pause_game = true
  },
  use_select_item_tips = {
    resource = "prefab/tips/uiuseitemtips1_.prefab",
    class = "tip.use_select_item_tips",
    sort_order = order_cfg.Special,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  use_ramdom_item_tips = {
    resource = "prefab/tips/uiuseitemtips2_.prefab",
    class = "tip.use_ramdom_item_tips",
    sort_order = order_cfg.Special,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  recultivate_tips = {
    resource = "prefab/UIBagResetPanel.prefab",
    class = "recultivate.recultivate_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  recultivate_select_list_char = {
    resource = "prefab/UIBagSelectPanel_Char.prefab",
    class = "recultivate.recultivate_select_list_char",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  recultivate_select_list_weapon = {
    resource = "prefab/UIBagSelectPanel_Weapon.prefab",
    class = "recultivate.recultivate_select_list_weapon",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  item_tips_small = {
    resource = "prefab/tips/ItemTipsSmall.prefab",
    class = "tip.item_tips_small",
    sort_order = order_cfg.Special,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  new_ui_item_synthesis = {
    resource = "prefab/uiitemsynthesis1.prefab",
    class = "uibag.new_ui_item_synthesis",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  new_ui_synthesis_tips = {
    resource = "prefab/tips/uisynthesistips1.prefab",
    class = "uibag.new_ui_synthesis_tips",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  puzzle_game_stage_panel = {
    resource = "prefab/Activity/ActPuzzle/ActPuzzleStage.prefab",
    class = "activity.puzzle_game.puzzle_game_stage_panel",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  puzzle_game_battle_panel = {
    resource = "prefab/Activity/ActPuzzle/UIPuzzleMain.prefab",
    class = "activity.puzzle_game.puzzle_game_battle_panel",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  puzzle_game_result_tips = {
    resource = "prefab/Activity/ActPuzzle/ActPuzzleSettle.prefab",
    class = "activity.puzzle_game.puzzle_game_result_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  puzzle_game_task = {
    resource = "prefab/Activity/ActPuzzle/ActPuzzleTask.prefab",
    class = "activity.puzzle_game.puzzle_game_task",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  music_game_main_panel = {
    resource = "prefab/Activity/ActMusicGame/ActMusicGameMain.prefab",
    class = "activity.music_game.music_game_main_panel",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  music_game_battle_panel = {
    resource = "prefab/Activity/ActMusicGame/ActMusicGameBattle.prefab",
    class = "activity.music_game.music_game_battle_panel",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  music_game_result_tips = {
    resource = "prefab/Activity/ActMusicGame/ActMusicGameSettle.prefab",
    class = "activity.music_game.music_game_result_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  music_game_task = {
    resource = "prefab/Activity/ActMusicGame/ActMusicGameTask.prefab",
    class = "activity.music_game.music_game_task",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL
  },
  barbecue_game_main_panel = {
    resource = "prefab/ActivitySummer/ActivityGrill/ActivityGrillGame.prefab",
    class = "activity.barbecue_game.barbecue_game_main_panel",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  barbecue_game_stage_panel = {
    resource = "prefab/ActivitySummer/ActivityGrill/ActivityGrillStage.prefab",
    class = "activity.barbecue_game.barbecue_game_stage_panel",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  barbecue_game_result_tips = {
    resource = "prefab/ActivitySummer/ActivityGrill/ActivityGrillSettle.prefab",
    class = "activity.barbecue_game.barbecue_game_result_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  barbecue_game_pause_tips = {
    resource = "prefab/ActivitySummer/ActivityGrill/ActivityGrillPause.prefab",
    class = "activity.barbecue_game.barbecue_game_pause_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  barbecue_game_start_tips = {
    resource = "prefab/ActivitySummer/ActivityGrill/ActivityGrillStar.prefab",
    class = "activity.barbecue_game.barbecue_game_start_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  barbecue_game_task = {
    resource = "prefab/ActivitySummer/ActivityGrill/ActivityGrillTask.prefab",
    class = "activity.barbecue_game.barbecue_game_task",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  barbecue_game_upgrade = {
    resource = "prefab/ActivitySummer/ActivityGrill/ActivityGrillUpgrade.prefab",
    class = "activity.barbecue_game.barbecue_game_upgrade",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  uigm_spine = {
    resource = "prefab/UIGMSpine.prefab",
    class = "gm.uigm_spine",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  curse_recuperation_room = {
    resource = "prefab/fatebook/fbprepareroom1.prefab",
    class = "stage_activity.challenge_ring_plus.curse_recuperation_room",
    sync_load = true,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    need_pause_game = true
  },
  curse_ability_upgrade = {
    resource = "prefab/fatebook/fatebooktalent.prefab",
    class = "stage_activity.challenge_ring_plus.curse_ability_upgrade",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    need_pause_game = true
  },
  fate_book_cure_func = {
    resource = "prefab/fatebook/uifbcure.prefab",
    class = "stage_activity.fate_book.fate_book_cure_func",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true,
    need_pause_game = true
  },
  curse_get_award_tips = {
    resource = "prefab/fatebook/uifbitemshow.prefab",
    class = "stage_activity.challenge_ring_plus.curse_get_award_tips",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    background_blur = true,
    need_pause_game = true
  },
  fate_book_file = {
    resource = "prefab/fatebook/uifatebookfile.prefab",
    class = "stage_activity.fate_book.fate_book_file",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    need_pause_game = true
  },
  fate_book_file_preview = {
    resource = "prefab/fatebook/uifbfilepreview.prefab",
    class = "stage_activity.fate_book.fate_book_file_preview",
    sync_load = false,
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    view_level = type_cfg.MAIN_VIEW,
    normal_update = true,
    need_pause_game = true,
    panels = {
      {
        name = "orn_view",
        root = "OrnContent",
        class = "battle_bag.orn_view",
        initshow = false
      },
      {
        name = "ability_view",
        root = "TalentContent",
        class = "battle_bag.ability_view",
        initshow = false
      },
      {
        name = "equation_view",
        root = "EquationContent",
        class = "battle_bag.equation_view",
        initshow = false
      }
    },
    use_low_render_frame = true,
    disable_camera_on_show = true,
    no_remove_between_ui = true
  },
  fate_book_select_drop_tips = {
    resource = "prefab/fatebook/uifbawardchoose.prefab",
    class = "stage_activity.fate_book.fate_book_select_drop_tips",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  ui_chapter_detail = {
    resource = "prefab/chapternew/uistagenew.prefab",
    class = "chapter.chapter_detail.ui_chapter_detail",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    normal_update = true
  },
  ui_chapter_detail_info = {
    resource = "prefab/chapternew/uistageinfonew.prefab",
    class = "chapter.chapter_detail.ui_chapter_detail_info",
    sort_order = order_cfg.LowTip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    is_set_player_control_off = true,
    is_end_joystick = true,
    is_settle_ui = true
  },
  ui_linear_main = {
    resource = "prefab/ChapterNew/UIPendantMain.prefab",
    class = "linear.ui_linear_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  ui_linear_stage = {
    resource = "prefab/ChapterNew/UIPendantStage.prefab",
    class = "linear.ui_linear_stage",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    keep_stack_show = true
  },
  ui_linear_award = {
    resource = "prefab/Tips/UIPendantAwardTips.prefab",
    class = "linear.ui_linear_award",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_climbing_tower_main = {
    resource = "prefab/Tower/UITowerMain.prefab",
    class = "climbing_tower.ui_climbing_tower_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  ui_climbing_tower_stage = {
    resource = "prefab/Tower/UITowerStage.prefab",
    class = "climbing_tower.ui_climbing_tower_stage",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_water_pipe = {
    resource = "prefab/BattleGame/UIBattleGame1.prefab",
    class = "mini_game.water_pipe.ui_water_pipe",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true
  },
  ui_water_pipe_sp = {
    resource = "prefab/BattleGame/UIBattleGame1SP.prefab",
    class = "mini_game.water_pipe_special.ui_water_pipe_sp",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    background_blur = true
  },
  mini_game_insert_needle = {
    resource = "prefab/BattleGame/UIBattleGame2.prefab",
    class = "mini_game.insert_needle.mini_game_insert_needle",
    sort_order = order_cfg.Special,
    view_level = type_cfg.MAIN_VIEW,
    high_update = true,
    background_blur = true
  },
  element_job_tips = {
    resource = "prefab/Tips/UIEleJobTips.prefab",
    class = "character.element_job_tips",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  keyword_tips = {
    resource = "prefab/Tips/KeywordTips.prefab",
    class = "tip.keyword_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  keyword_tips_v2 = {
    resource = "prefab/tips/uikeywordtips2.prefab",
    class = "tip.keyword_tips_v2",
    sort_order = order_cfg.Special + 6,
    group = group_cfg.GROUP_NORMAL
  },
  ui_barrage = {
    resource = "prefab/Tips/UIBarrage.prefab",
    class = "ui_barrage.ui_barrage",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW,
    normal_update = true
  },
  chapter_story_preheat = {
    resource = "prefab/uipreviewstory.prefab",
    class = "chapter.chapter_detail.chapter_story_preheat",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  puzzle_panel = {
    resource = "prefab/Char/UIChar_Plugins.prefab",
    class = "character.puzzle.puzzle_panel",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    panels = {
      {
        name = "puzzle_operate_view",
        root = "SetPluginsObj",
        class = "character.puzzle.puzzle_operate_view",
        initshow = false
      },
      {
        name = "puzzle_decompose_view",
        root = "DecomposeObj",
        class = "character.puzzle.puzzle_decompose_view",
        initshow = false
      },
      {
        name = "puzzle_up_lv_view",
        root = "RankUpObj",
        class = "character.puzzle.puzzle_up_lv_view",
        initshow = false
      },
      {
        name = "puzzle_filter_view",
        root = "Screen",
        class = "character.puzzle.puzzle_filter_view",
        initshow = false
      },
      {
        name = "puzzle_refine_view",
        root = "RefineObj",
        class = "character.puzzle.puzzle_refine_view",
        initshow = false
      }
    }
  },
  puzzle_batch_decompose_panel = {
    resource = "prefab/Char/UIPluginsDec.prefab",
    class = "character.puzzle.puzzle_batch_decompose_panel",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  puzzle_item_tips = {
    resource = "prefab/Tips/PuzzleItemTips.prefab",
    class = "character.puzzle.puzzle_item_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW,
    high_update = true
  },
  puzzle_addition_tips = {
    resource = "prefab/Tips/PuzzleAdditionTips.prefab",
    class = "character.puzzle.puzzle_addition_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  puzzle_recommend_tips = {
    resource = "prefab/Tips/PuzzleRecommendTips.prefab",
    class = "character.puzzle.puzzle_recommend_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  puzzle_recommend_suit_tips = {
    resource = "prefab/Char/UIPluginsRecommend.prefab",
    class = "character.puzzle.puzzle_recommend_suit_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  puzzle_attr_pop_tips = {
    resource = "prefab/Tips/PuzzleAttrPopTips.prefab",
    class = "character.puzzle.puzzle_attr_pop_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  puzzle_filter_tips = {
    resource = "prefab/Tips/UIPluginsScreenTips.prefab",
    class = "character.puzzle.puzzle_filter_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  puzzle_filter_tips_shop = {
    resource = "prefab/Tips/UIPluginsScreenTips.prefab",
    class = "character.puzzle.puzzle_filter_tips_shop",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  puzzle_single_filter_tips = {
    resource = "prefab/Tips/UIPluginsScreen.prefab",
    class = "character.puzzle.puzzle_single_filter_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  puzzle_refine_attr_select_tips = {
    resource = "prefab/Char/UIAttrScreenTips.prefab",
    class = "character.puzzle.puzzle_refine_attr_select_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  puzzle_up_grade_tips = {
    resource = "prefab/Char/UIPluginsRankUpDetail.prefab",
    class = "character.puzzle.puzzle_up_grade_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  building_factory_room = {
    resource = "prefab/home/uiproductroom.prefab",
    class = "building.factory.building_factory_room",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  building_factory_select_tips = {
    resource = "prefab/home/uiproducttips.prefab",
    class = "building.factory.building_factory_select_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  building_factory_fast_tips = {
    resource = "prefab/home/uiquickentips.prefab",
    class = "building.factory.building_factory_fast_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  building_adventrue_room = {
    resource = "prefab/home/uihometask.prefab",
    class = "building.adventrue.building_adventrue_room",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  building_adventrue_main = {
    resource = "prefab/home/UIHomeTaskMain.prefab",
    class = "building.adventrue.building_adventrue_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  building_adventrue_clue_tips = {
    resource = "prefab/home/uihometaskcluetips.prefab",
    class = "building.adventrue.building_adventrue_clue_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  building_adventrue_add_clue_tips = {
    resource = "prefab/home/uihometaskaddclue.prefab",
    class = "building.adventrue.building_adventrue_add_clue_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  building_adventrue_select_clue_tips = {
    resource = "prefab/home/uihometaskclueselect.prefab",
    class = "building.adventrue.building_adventrue_select_clue_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  building_tower_view = {
    resource = "prefab/home/uihomelvup.prefab",
    class = "building.tower.building_tower_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW,
    panels = {
      {
        name = "level_up_view",
        root = "LvUpTips",
        class = "building.tower.building_level_up_view",
        initshow = false
      },
      {
        name = "level_up_suc_view",
        root = "LvUpSucTips",
        class = "building.tower.building_level_up_suc_view",
        initshow = false
      }
    }
  },
  building_main = {
    resource = "prefab/home/uihomemain.prefab",
    class = "building.building_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW,
    high_update = true
  },
  building_batch_tips = {
    resource = "prefab/home/uihomebirdtasktips.prefab",
    class = "building.adventrue.building_batch_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  building_one_key_dispatch_tips = {
    resource = "prefab/home/uihomeonekeydispatch.prefab",
    class = "building.adventrue.building_one_key_dispatch_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  building_one_key_get_award_tips = {
    resource = "prefab/home/uihomedispatchend.prefab",
    class = "building.adventrue.building_one_key_get_award_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  building_main_unlock_tips = {
    resource = "prefab/home/uihomebuildunlockpop.prefab",
    class = "building.adventrue.building_main_unlock_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  boss_challenge_main = {
    resource = "prefab/uibosschal/uibosschalmain.prefab",
    class = "stage_activity.boss_challenge.boss_challenge_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  boss_challenge_point_detail = {
    resource = "prefab/uibosschal/uibosschalstage.prefab",
    class = "stage_activity.boss_challenge.boss_challenge_point_detail",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    view_level = type_cfg.MAIN_VIEW
  },
  ui_boss_reset_tip = {
    resource = "prefab/uibosschal/UIBossResetTips.prefab",
    class = "stage_activity.boss_challenge.ui_boss_reset_tip",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  egg_tips = {
    resource = "prefab/tips/uieggtips.prefab",
    class = "tip.egg_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true
  },
  use_item_preview = {
    resource = "prefab/tips/UIUseItemPreview_.prefab",
    class = "tip.use_item_preview",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_quantum_main = {
    resource = "prefab/UIQuantum/UIQuantumMain.prefab",
    class = "quantum.ui_quantum_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    high_update = true
  },
  ui_quantum_capture = {
    resource = "prefab/UIQuantum/UIQuantumPhotograph.prefab",
    class = "quantum.ui_quantum_capture",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true
  },
  ui_quantum_capture_list = {
    resource = "prefab/UIQuantum/UIQuantumPhotographList.prefab",
    class = "quantum.ui_quantum_capture_list",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true
  },
  ui_capture_main = {
    resource = "prefab/UIQuantum/UIQuantumMain.prefab",
    class = "capture.ui_capture_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    high_update = true
  },
  ui_capture = {
    resource = "prefab/UIQuantum/UIQuantumPhotograph.prefab",
    class = "capture.ui_capture",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true
  },
  ui_capture_list = {
    resource = "prefab/UIQuantum/UIQuantumPhotographList.prefab",
    class = "capture.ui_capture_list",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true
  },
  ui_main_clock_guide = {
    resource = "prefab/Tips/UIMainClockGuide.prefab",
    class = "uimain.ui_main_clock_guide",
    sync_load = true,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    high_update = true
  },
  ui_treasure_chest_handbook = {
    resource = "prefab/ChapterNew/UIStageBoxCodex.prefab",
    class = "treasure_chest.ui_treasure_chest_handbook",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true
  },
  ui_treasure_chest_preview = {
    resource = "prefab/ChapterNew/UIStageBoxPreview.prefab",
    class = "treasure_chest.ui_treasure_chest_preview",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true
  },
  ui_treasure_chest_award = {
    resource = "prefab/Home/UIHomeBoxExploreFail.prefab",
    class = "treasure_chest.ui_treasure_chest_award",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  ui_return_activity_pop = {
    resource = "prefab/Activity/ActReturn/UIActReturnMain.prefab",
    class = "activity.ui_return_activity_pop",
    sort_order = order_cfg.PopUpWindow,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true
  },
  ui_return_activity_main = {
    resource = "prefab/Activity/ActReturn/UIActReturnMain.prefab",
    class = "activity.ui_return_activity_main",
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    sync_load = false,
    no_push_stack = true
  },
  ui_return_activity_sign = {
    resource = "prefab/Activity/ActReturn/UIActReturnSignIn.prefab",
    class = "activity.ui_return_activity_sign",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  ui_return_activity_task = {
    resource = "prefab/Activity/ActReturn/ActReturnTask.prefab",
    class = "activity.ui_return_activity_task",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_return_activity_gift = {
    resource = "prefab/Activity/ActReturn/UIActReturnGift.prefab",
    class = "activity.ui_return_activity_gift",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_return_activity_new = {
    resource = "prefab/Activity/ActReturn/UIActReutrnNew.prefab",
    class = "activity.ui_return_activity_new",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  ui_act_battle_game = {
    resource = "prefab/Activity/1_1/UIActBattleGame.prefab",
    class = "time_limited_activity.mini_game_compilation.ui_act_battle_game",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    normal_update = true
  },
  ui_act_battle_game_award = {
    resource = "prefab/Activity/1_1/ActBattleGameTask.prefab",
    class = "time_limited_activity.mini_game_compilation.ui_act_battle_game_award",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true
  },
  ui_birthday_tips = {
    resource = "prefab/Tips/UIBirthdayTips.prefab",
    class = "tip.ui_birthday_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  ui_time_limited_activity_main = {
    resource = "prefab/Activity/1_1/1_1ActMain.prefab",
    class = "time_limited_activity.ui_time_limited_activity_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    normal_update = true
  },
  ui_time_limited_activity_main_1_2 = {
    resource = "prefab/Activity/1_2ActMain.prefab",
    class = "time_limited_activity.ui_time_limited_activity_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    normal_update = true
  },
  ui_activity_summer_main = {
    resource = "prefab/ActivitySummer/ActivitySummerMain.prefab",
    class = "time_limited_activity.ui_activity_summer_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    normal_update = true
  },
  ui_activity_summer_shop = {
    resource = "prefab/ActivitySummer/ActivitySummerShop.prefab",
    class = "shop.ui_activity_summer_shop",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    normal_update = true
  },
  ui_activity_summer_stage = {
    resource = "prefab/ActivitySummer/ActivitySummerStage/ActivitySummerStage.prefab",
    class = "time_limited_activity.ui_activity_summer_stage",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    normal_update = true
  },
  ui_activity_summer_stage_info = {
    resource = "prefab/ActivitySummer/ActivitySummerStage/ActivitySummerStageInfo.prefab",
    class = "time_limited_activity.ui_activity_summer_stage_info",
    sort_order = order_cfg.LowTip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    is_set_player_control_off = true,
    is_end_joystick = true,
    is_settle_ui = true
  },
  ui_activity_summer_task = {
    resource = "prefab/ActivitySummer/ActivitySummerStage/ActivitySummerTask.prefab",
    class = "time_limited_activity.ui_activity_summer_task",
    sync_load = false,
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  },
  ui_reconnect_panel = {
    resource = "prefab/Reconnect/UIReconnectPanel.prefab",
    class = "tip.reconnecting_panel",
    sort_order = order_cfg.Alert,
    group = group_cfg.GROUP_NORMAL
  },
  ui_qrcode_login = {
    resource = "prefab/Tips/UIQRcodeTips.prefab",
    class = "login.qrcode_scan_login",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    normal_update = true
  },
  ui_activity_daily1 = {
    resource = "prefab/Activity/ActivityDaily1/UIActivityDaily1Panel.prefab",
    class = "activity.ui_activity_daily1_panel",
    sync_load = false,
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    parent_ui = "ui_activity",
    no_push_stack = true,
    normal_update = true,
    show_waiting = true
  },
  fish_game_stage = {
    resource = "prefab/ActivitySummer/ActivityFish/ActivityFishStage.prefab",
    class = "activity.fish_game.fish_game_stage",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  fish_game_task = {
    resource = "prefab/ActivitySummer/ActivityFish/ActivityFishTask.prefab",
    class = "activity.fish_game.fish_game_task",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  fish_game_battle = {
    resource = "prefab/ActivitySummer/ActivityFish/ActivityFishGame.prefab",
    class = "activity.fish_game.fish_game_battle",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    no_push_stack = true,
    normal_update = true
  },
  fish_game_battle_settle = {
    resource = "prefab/ActivitySummer/ActivityFish/ActivityFishGameSettle.prefab",
    class = "activity.fish_game.fish_game_battle_settle",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_player_exit_tip = {
    resource = "prefab/Tips/UIPlayerExitTip.prefab",
    class = "tip.player_exit_tip",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true,
    not_full_screen = true
  },
  ui_act_minesweeper = {
    resource = "prefab/Activity/ActMine/UIActMine.prefab",
    class = "activity.minesweeper.ui_act_minesweeper",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_act_minesweeper_rank = {
    resource = "prefab/Activity/ActMine/UIActMineRank.prefab",
    class = "activity.minesweeper.ui_act_minesweeper_rank",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_act_minesweeper_handbook = {
    resource = "prefab/Activity/ActMine/UIMineHandBook.prefab",
    class = "activity.minesweeper.ui_act_minesweeper_handbook",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_minesweeper_battle = {
    resource = "prefab/Activity/ActMine/UIMineBattle.prefab",
    class = "activity.minesweeper.ui_minesweeper_battle",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  ui_minesweeper_shop = {
    resource = "prefab/Activity/ActMine/UIActMineShopTips.prefab",
    class = "activity.minesweeper.ui_minesweeper_shop",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_minesweeper_buff = {
    resource = "prefab/Activity/ActMine/UIActMineBuff.prefab",
    class = "activity.minesweeper.ui_minesweeper_buff",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_minesweeper_settle = {
    resource = "prefab/Activity/ActMine/UIActMineSettle.prefab",
    class = "activity.minesweeper.ui_minesweeper_settle",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    is_settle_ui = true
  },
  ui_minesweeper_battle_suc = {
    resource = "prefab/Activity/ActMine/UIActMineBattleSuc.prefab",
    class = "activity.minesweeper.ui_minesweeper_battle_suc",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    is_settle_ui = true
  },
  ui_act_minesweeper_battle = {
    resource = "prefab/Activity/ActMine/UIActMineBattle.prefab",
    class = "activity.minesweeper.ui_act_minesweeper_battle",
    sort_order = order_cfg.MainView,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    no_push_stack = true,
    normal_update = true
  },
  ui_maze_game_main = {
    resource = "prefab/activity/actmaze/uiactmazemain.prefab",
    class = "activity.maze_game.ui_maze_game_main",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    normal_update = true
  },
  ui_maze_game_task = {
    resource = "prefab/activity/actmaze/uiactmazetask.prefab",
    class = "activity.maze_game.ui_maze_game_task",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_maze_game_start = {
    resource = "prefab/activity/actmaze/uiactmazestart.prefab",
    class = "activity.maze_game.ui_maze_game_start",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_maze_game_view = {
    resource = "prefab/activity/actmaze/uiactmazeingame.prefab",
    class = "activity.maze_game.ui_maze_game_view",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false,
    skip_init_common_widget = true
  },
  ui_maze_game_event = {
    resource = "prefab/activity/actmaze/uiactmazeevent.prefab",
    class = "activity.maze_game.ui_maze_game_event",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = true
  },
  ui_maze_game_battle_tips = {
    resource = "prefab/activity/actmaze/uiactmazebattletips.prefab",
    class = "activity.maze_game.ui_maze_game_battle_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_maze_game_settle_tips = {
    resource = "prefab/activity/actmaze/uiactmazesettle.prefab",
    class = "activity.maze_game.ui_maze_game_settle_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_maze_game_illustrated = {
    resource = "prefab/activity/actmaze/uiactmazehandbook.prefab",
    class = "activity.maze_game.ui_maze_game_illustrated",
    sort_order = order_cfg.System,
    group = group_cfg.GROUP_NORMAL,
    sync_load = false
  },
  ui_user_agreement_tips = {
    resource = "prefab/tips/UserAgreementTips.prefab",
    class = "tip.ui_user_agreement_tips",
    sort_order = order_cfg.Tip,
    group = group_cfg.GROUP_NORMAL
  }
}
config.prefab_to_ui = {
  UIWeaponReduction = "ui_weapon_reduction"
}

function config:set_sort_order_to_tip(ui)
  ui.sort_order = order_cfg.Tip
end

function config:set_sort_order_to_system(ui)
  ui.sort_order = order_cfg.System
end

return config
