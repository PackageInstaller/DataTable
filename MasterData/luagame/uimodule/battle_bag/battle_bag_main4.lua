local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CommonDef = require("cs_share.common_define")
local ITEM_ICON_PATH = "Icon/BattleItem/%s"
local bagConfig = require("gamelogic.character.fight_bag_configs")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local BAG4_TOG_KEY = "BAG4_TOG_KEY"
local NOT_PROGRESS_BATTLE_TYPE = Config.NOT_PROGRESS_BATTLE_TYPE
local TOG_INDEX = {
  RUNE = 1,
  BAG = 2,
  SKILL = 3,
  SOUVENIR = 4,
  ORNAMENT = 5,
  ABILITY = 6,
  STAGE_INFO = 7,
  STAGE_SKILL = 8,
  EQUATION = 9,
  SKILL_LIST = 10
}
local EXIT_FUNC = {
  [CommonDef.CHALLENGE_TYPE.LONG_CHAPTER] = "long_chapter_exit",
  [CommonDef.CHALLENGE_TYPE.CHAPTER] = "chapter_exit"
}
local NO_CONTINUE_TYPE = {
  [CommonDef.CHALLENGE_TYPE.LONG_CHAPTER] = true,
  [CommonDef.CHALLENGE_TYPE.CHAPTER] = true,
  [CommonDef.CHALLENGE_TYPE.INDEPENDENT] = true,
  [CommonDef.CHALLENGE_TYPE.LINEAR] = true,
  [CommonDef.CHALLENGE_TYPE.CLIMBING_TOWER] = true,
  [CommonDef.CHALLENGE_TYPE.PROBATION_BUDDY] = true,
  [CommonDef.CHALLENGE_TYPE.BOSS] = true,
  [CommonDef.CHALLENGE_TYPE.ACTIVITY_MINI_GAME] = true,
  [CommonDef.CHALLENGE_TYPE.ACTIVITY_MINESWEEPER] = true,
  [CommonDef.CHALLENGE_TYPE.VERSION_EPISODE] = true,
  [CommonDef.CHALLENGE_TYPE.ACTIVITY_PONDER] = true
}
local TOG_OPEN_FUNC = {
  [TOG_INDEX.STAGE_SKILL] = function()
    if not TowerMgr or not TowerMgr:get_tower() then
      return false
    end
    local fight_type = TowerMgr and TowerMgr:get_fight_type()
    local progress_type = TowerMgr and TowerMgr:get_tower_progress().challenge_type
    local tower_type = 0 ~= fight_type and fight_type or progress_type
    if tower_type == CommonDef.CHALLENGE_TYPE.CHAPTER or tower_type == CommonDef.CHALLENGE_TYPE.LONG_CHAPTER then
      return false
    end
    if not TowerMgr:check_enable_god_skill() then
      return false
    end
    local god_npc = SceneMgr:get_god_npc()
    if not god_npc then
      return false
    end
    local char_id = SceneMgr:get_god_npc_id()
    if not char_id then
      local tower = TowerMgr:get_tower()
      local tower_id = tower:get_tower_id()
      local tower_cfg = ShareRes.create("tower.tower", tower_id)
      char_id = tower_cfg.TowerCharId
    end
    if not char_id or 0 == char_id then
      return false
    end
    local scene_skill_data = TowerMgr:get_scene_skill_data()
    if not scene_skill_data then
      return false
    end
    return true
  end
}
local COMMON_EXIT_FUNC = "common_exit"

function ui:ui_finish_load()
  self:init_tog_name_list()
  self:set_button("BtnRet1", function()
    if not self:get_is_can_back() then
      return
    end
    self:ui_hide()
  end)
  self:set_button("CloseOrntipsBtn", function()
    self.v_panels.orn_view:click_close_orntips_btn()
  end)
  self:set_button("BtnSet", function()
    if not self:get_is_can_back() then
      return
    end
    UIMgr:get_ui("battle_setting"):ui_show()
  end)
  self:set_button("BtnQuit", function()
    self:_onclick_quit_btn()
  end)
  self:set_button("BtnReFight", function()
    if not self:get_is_can_back() then
      return
    end
    
    local function sure_callback()
      self.v_is_can_back = false
      local fight_type = TowerMgr:get_fight_type()
      local fight_info = TowerMgr:get_fight_info()
      local node_id
      if fight_info and fight_info.node_id and fight_type == CommonDef.CHALLENGE_TYPE.LONG_CHAPTER then
        node_id = fight_info.node_id
      end
      if fight_type == Config.CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
        TowerMgr:on_exit_tower(function()
          TowerMgr:restart_tower(nil, nil, nil, node_id, true, true)
        end, true)
      else
        TowerMgr:get_fight_reward(function()
          TowerMgr:restart_tower(nil, nil, nil, node_id, true)
        end, true)
      end
    end
    
    UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, "是否重新挑战？")
  end)
  self:set_button("BtnOutOfStuck", function()
    if not self:get_is_can_back() then
      return
    end
    
    local function sure_callback()
      self.v_is_can_back = false
      SceneMgr:global_hero_out_of_stuck()
      if self:visible() then
        self:ui_hide()
      end
    end
    
    UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, "是否需要脱离卡死？")
  end)
  self.v_tog_panels = {
    [TOG_INDEX.RUNE] = self.v_panels.rune_bag_view,
    [TOG_INDEX.BAG] = self.v_panels.item_bag_view,
    [TOG_INDEX.SKILL] = self.v_panels.skill_bag_view,
    [TOG_INDEX.SOUVENIR] = self.v_panels.souvenir_view,
    [TOG_INDEX.ORNAMENT] = self.v_panels.orn_view,
    [TOG_INDEX.ABILITY] = self.v_panels.ability_view,
    [TOG_INDEX.STAGE_INFO] = self.v_panels.stage_view,
    [TOG_INDEX.STAGE_SKILL] = self.v_panels.stage_skill_view,
    [TOG_INDEX.EQUATION] = self.v_panels.equation_view,
    [TOG_INDEX.SKILL_LIST] = self.v_panels.skill_list_view
  }
  self.v_bag_fun_tog_list = {}
  self.v_canvas = self.v_object:GetComponent(typeof(UnityEngine.Canvas))
  self:register_exist_auto_template(BAG4_TOG_KEY, self.v_uiobjects.FunTog1, self.v_uiobjects.FunctionList)
  self.v_skip_sort_order = false
end

function ui:init_tog_name_list()
  self.v_tog_name_list = {
    [TOG_INDEX.RUNE] = "符文",
    [TOG_INDEX.BAG] = "背包",
    [TOG_INDEX.SKILL] = "技能介绍",
    [TOG_INDEX.SOUVENIR] = "纪念品",
    [TOG_INDEX.ORNAMENT] = "奇珍",
    [TOG_INDEX.ABILITY] = "片语",
    [TOG_INDEX.STAGE_INFO] = "关卡信息",
    [TOG_INDEX.STAGE_SKILL] = "关卡技能",
    [TOG_INDEX.EQUATION] = "融合片段",
    [TOG_INDEX.SKILL_LIST] = "出招表"
  }
end

function ui:get_is_can_back()
  if not self.v_is_can_back then
    Util.show_message_tip(2776)
  end
  return self.v_is_can_back
end

function ui:refresh_tog_list()
  local fight_type = TowerMgr and TowerMgr:get_fight_type()
  if not fight_type then
    return
  end
  self:give_back_auto_cache(BAG4_TOG_KEY)
  local tog_index_list = Config.PAUSE_FUN_TOG_SHOW_LIST[fight_type] or {
    7,
    3,
    10
  }
  local _, default_index = next(tog_index_list)
  if fight_type == Config.CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH then
    local stage_cfg = TowerMgr:get_stage_info()
    local teach_stage_cfg = ShareRes.get_buddy_teach_cfg_by_point_id(stage_cfg.Id)
    if teach_stage_cfg.BuddyID then
      default_index = 10
    else
      default_index = 7
    end
  end
  for _, index in ipairs(tog_index_list) do
    if not TOG_OPEN_FUNC[index] or TOG_OPEN_FUNC[index]() then
      local item_ui = self:get_auto_cache(BAG4_TOG_KEY)
      local tog = self:get_toggle(nil, item_ui)
      local text = self:get_text("PageName", item_ui)
      text.text = self.v_tog_name_list[index]
      self.v_bag_fun_tog_list[index] = tog
      self:set_toggle_listener(tog, function(is_on)
        self.v_bag_fun_tog_list[index].interactable = not is_on
        self:_on_click_bag_tog(is_on, index)
      end)
    end
  end
  if default_index then
    self:switch_to_target_panel(default_index)
  end
end

function ui:switch_to_target_panel(index)
  self.v_bag_fun_tog_list[index].isOn = false
  self.v_bag_fun_tog_list[index].isOn = true
end

function ui:response_click_hero_item(msg)
  if not msg then
    return
  end
  local select_hero = msg.mm_obj
  self.v_hero = select_hero
end

function ui:ui_on_show()
  StoryMgr:pause_captions_talk(true)
  if self.v_skip_sort_order then
    self.v_canvas.sortingOrder = Config.UI_SORT_ORDER.Special + 5
  end
  self.v_hero = Global.hero
  self:refresh_tog_list()
  self:_refresh_currency()
  self:register_event()
  UIMgr:refresh_barrage_alpha(true)
  self:refresh_quit_visible()
  self:refresh_re_fight_btn()
  self.v_is_can_back = true
end

function ui:refresh_re_fight_btn()
  self.v_uiobjects.BtnReFight:SetActive(TowerMgr:is_need_show_re_fight_btn())
end

function ui:refresh_quit_visible()
  local fight_info = TowerMgr:get_fight_info()
  local is_visible = not fight_info or fight_info.type ~= CommonDef.CHALLENGE_TYPE.NEWBIE_TOWER
  self.v_uiobjects.BtnQuit:SetActive(is_visible)
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DIAMOND_UPDATE, self._refresh_currency, self)
  self:bind_auto_mq(Const.MSG_ON_SELECT_RUNE_HERO_ITEM, self.response_click_hero_item, self)
end

function ui:ui_on_hide()
  StoryMgr:pause_captions_talk(false)
  self.v_skip_sort_order = false
  self.v_hero = nil
  for k, v in pairs(self.v_tog_panels) do
    v:ui_hide()
    v:set_enable_ex(false)
  end
  self.v_tog_idx = nil
  self.v_hide_curse_ring_view = false
  UIMgr:refresh_barrage_alpha()
end

function ui:ui_on_destroy()
end

function ui:_refresh_currency()
  local currency_obj = self.v_uiobjects.Asset_Item
  local moneyId = Config.CURSE_GOLD
  local cfg = UtilUI.get_item_cfg(moneyId)
  local moneyIcon = Util.get_image("Label", currency_obj)
  ResMgr:load_set_icon(moneyIcon, string.format(ITEM_ICON_PATH, cfg.Icon))
  local moneyTxt = Util.get_text("Aomunt", currency_obj)
  moneyTxt.text = BagMgr:get_item_num(moneyId)
end

function ui:_on_click_bag_tog(is_on, idx)
  if idx == self.v_tog_idx and is_on then
    return
  end
  self.v_tog_idx = idx
  for k, v in pairs(self.v_tog_panels) do
    local data
    if idx == TOG_INDEX.SKILL or idx == TOG_INDEX.SKILL_LIST then
      data = self.v_hero
    end
    v:set_enable_ex(is_on and idx == k, data)
  end
end

function ui:cache_ui()
  return true
end

function ui:set_skip_sort_order(skip_sort_order)
  self.v_skip_sort_order = skip_sort_order
end

function ui:skip_sort_order()
  return self.v_skip_sort_order
end

function ui:_onclick_quit_btn()
  if not self:get_is_can_back() then
    return
  end
  local fight_info = TowerMgr:get_fight_info()
  local fight_type = fight_info and fight_info.type
  if fight_type == CommonDef.CHALLENGE_TYPE.BEST_CONF then
    self:_exit_top_ver_tower()
  else
    self:_exit_tower(fight_type)
  end
end

function ui:_exit_top_ver_tower()
  local tip = Util.format_str("是否立即退出关卡")
  local sure_btn = Util.format_str("退出")
  
  local function sure_callback()
    self.v_is_can_back = false
    UIMgr:get_ui("top_ver_settlement"):ui_show()
  end
  
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, tip, sure_btn)
  UIMgr:get_ui("uinotice_tips"):enable_bg_click(true)
end

function ui:_exit_tower(fight_type)
  local tip = Util.format_str("是否退出关卡")
  local cancal_return = false
  local sure_btn, cancel_btn, one_btn
  if NO_CONTINUE_TYPE[fight_type] then
    cancal_return = true
    cancel_btn = Util.format_str("否")
    sure_btn = Util.format_str("是")
  elseif fight_type == CommonDef.CHALLENGE_TYPE.CURSE_CIRCLE then
    local point_id = TowerMgr:get_cur_point_id()
    local ring_id = ShareRes.get_ring_id_by_point_id(point_id)
    local ring_cfg = ShareRes.get_curse_ring_config(ring_id)
    local is_mask = ring_cfg.IsQuickFight or SceneMgr:check_all_hero_hp_zero()
    if is_mask then
      cancal_return = true
      cancel_btn = Util.format_str("否")
      sure_btn = Util.format_str("是")
    else
      sure_btn = Util.format_str("中继保存")
      cancel_btn = Util.format_str("直接结算")
    end
  else
    sure_btn = Util.format_str("中继保存")
    cancel_btn = Util.format_str("直接结算")
  end
  
  local function sure_callback()
    self.v_is_can_back = false
    local is_long_chapter = fight_type == Config.CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER
    local is_chapter = fight_type == Config.CommonDefine.CHALLENGE_TYPE.CHAPTER
    if is_long_chapter or is_chapter then
      local progress = TowerMgr:get_tower_progress()
      local chapter_id = progress.param
      local param = is_long_chapter and progress.node_id or progress.episode_id
      ChapterMgr:set_record_select_chapter_id(chapter_id)
      ChapterMgr:set_record_select_param_id(param)
    end
    local fun = EXIT_FUNC[fight_type] or COMMON_EXIT_FUNC
    if self[fun] then
      self[fun](self)
    end
  end
  
  local function cancel_callback()
    if cancal_return then
      return
    elseif NOT_PROGRESS_BATTLE_TYPE[fight_type] then
      UIMgr:get_ui("not_progress_battle_def_settle"):ui_show()
    elseif fight_type == CommonDef.CHALLENGE_TYPE.INFINITE then
      local ui_name
      local tower = TowerMgr:get_tower()
      if tower and tower:get_floor_num() <= 1 and not tower:get_room():is_fight_end() then
        ui_name = "not_progress_battle_def_settle"
      else
        ui_name = "endless_settle"
      end
      UIMgr:get_ui(ui_name):ui_show(CHAPTER_CONFIG.POINTSTATE.quit)
    elseif fight_type == CommonDef.CHALLENGE_TYPE.CURSE_CIRCLE then
      ChallengeRingPlusMgr:show_sellte_ui()
    else
      UIMgr:get_ui("not_progress_battle_def_settle"):ui_show(CHAPTER_CONFIG.POINTSTATE.quit)
    end
  end
  
  if fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI or fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    sure_btn = Util.format_str("是")
    cancel_btn = Util.format_str("否")
    sure_callback = cancel_callback
    
    function cancel_callback()
      self:ui_hide()
    end
  end
  if fight_type == CommonDef.CHALLENGE_TYPE.BUDDY_TEACH or fight_type == CommonDef.CHALLENGE_TYPE.NEW_MATERIAL then
    sure_btn = Util.format_str("是")
    cancel_btn = Util.format_str("否")
    tip = Util.format_str("是否退出关卡")
    one_btn = nil
    
    function sure_callback()
      self.v_is_can_back = false
      self:common_exit()
    end
    
    function cancel_callback()
    end
  end
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, cancel_callback, tip, sure_btn, cancel_btn, nil, one_btn, nil, nil, function()
  end)
  UIMgr:get_ui("uinotice_tips"):enable_bg_click(true)
end

function ui:check_weekly_fight(fight_type)
  if fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI or fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    return true
  end
  return false
end

function ui:common_exit()
  local function cb()
    Global.scene_mgr:on_enter_main_scene()
    
    UIMgr:revert_cache_ui()
  end
  
  if TowerMgr then
    TowerMgr:on_exit_tower(cb)
  end
end

function ui:long_chapter_exit()
  local function cb()
    Global.scene_mgr:on_enter_main_scene()
    
    UIMgr:revert_cache_ui()
  end
  
  TowerMgr:long_chapter_exit(true, cb, true)
end

function ui:chapter_exit()
  UIMgr:get_ui("not_progress_battle_def_settle"):ui_show()
end

function ui:response_click_escape()
  self:ui_hide()
  return UIMgr.RESPONCE_ESCAPE_TYPE.ESCAPE_CUSTOM
end

return ui
