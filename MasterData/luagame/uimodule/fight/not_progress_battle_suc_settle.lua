local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ITEM_OBJ_COM = require("uimodule.item.item_obj_com")
local TEMPLATE_KEY_AWARD = "TEMPLATE_KEY_AWARD"
local TEMPLATE_KEY_TARGET = "TEMPLATE_KEY_TARGET"
local CommonDef = require("cs_share.common_define")
local CommonDefine = require("cs_share.common_define")
local Char_Helper = require("uimodule.character.char_helper")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local Item_Helper = require("utils.item_helper")
local Jump_Helper = require("gamelogic.sys_open.jump_helper")
local MAX_CHAR_ITEM_COUNT = Config.MAX_CHAR_ITEM_COUNT
local Condition_Type = Config.Condition_Type
local check_function_btn_time = ShareRes.get_comm_value("SettlementWinCheckFunctionBtnTime") or 5

local function sort(a, b)
  if a.pos ~= b.pos then
    return a.pos < b.pos
  else
    return false
  end
end

function ui:ui_finish_load()
  self.v_item_list = {}
  self:register_exist_auto_template(TEMPLATE_KEY_AWARD, self.v_uiobjects.ItemObjCom1, self.v_uiobjects.AwardContent)
  self:register_exist_auto_template(TEMPLATE_KEY_TARGET, self.v_uiobjects.TaskItem, self.v_uiobjects.TargetContent)
  if self.v_uiobjects.AssetBar then
    self.v_uiobjects.AssetBar:SetActive(false)
  end
  self:set_button("BtnContinue", function()
    if self.v_is_sweep_mode then
      self:ui_hide()
      return
    end
    if not self:check_btn_can_click() then
      return
    end
    if not SceneMgr:check_main_scene() and self.v_is_long_chapter and self.v_next_main_line_node_cfg then
      local need_cost = self.v_next_main_line_node_cfg.Cost
      local cur_cost = BagMgr:get_item_num(Config.PLAYER_SP_ITEMID)
      if need_cost <= cur_cost then
        self:on_click_continue_button()
      else
        UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("体力不足"))
      end
    else
      self:on_click_continue_button()
    end
    AssistMgr:try_hide_add_assist_friend_tips()
  end)
  self:set_button("BtnLeft", function()
    if not self:check_btn_can_click() then
      return
    end
    if self:is_need_show_left_btn_with_fight_type() then
      if not self:check_fight_cost() then
        self.v_is_can_click_btn = true
        self:remove_click_btn_timer()
        return
      end
      TowerMgr:restart_tower(self.next_epi_id, self.next_epi_param, self.v_is_need_refresh_red)
    elseif self:is_buddy_teach_need_tp_next_floor() then
      SceneMgr:check_continue_tp_room()
      self:ui_hide()
    else
      self.v_no_close_detail_view = SceneMgr:check_main_scene()
      self:on_click_left_btn()
      AssistMgr:try_hide_add_assist_friend_tips()
    end
  end)
  self:set_button("BtnQuickFight", function()
    if not self:check_btn_can_click() then
      return
    end
    if self:is_need_show_left_btn_with_fight_type() then
      TowerMgr:restart_tower(self.next_epi_id, self.next_epi_param, self.v_is_need_refresh_red)
    elseif self:is_buddy_teach_need_tp_next_floor() then
      SceneMgr:check_continue_tp_room()
      self:ui_hide()
    else
      self.v_no_close_detail_view = SceneMgr:check_main_scene()
      self:on_click_left_btn()
      AssistMgr:try_hide_add_assist_friend_tips()
    end
    ChapterMaterialMgr:set_restore_sweep_data(self.v_restore_material_id)
  end)
  self:set_button("SpineBtn", function()
    if self.v_anim_data.record_data.play_start then
      if self.v_anim_data.record_data.play_interrupt then
        SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
      end
    else
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
    end
  end)
  self:set_button("BtnDamage", function()
    UIMgr:get_ui("damage_detail"):ui_show(self.v_tower_progress, self.v_siname_text)
  end)
  self:set_button("BtnReFight", function()
    if TowerMgr:get_tower() == nil then
      TowerMgr:restart_tower()
    else
      TowerMgr:get_fight_reward(function()
        TowerMgr:restart_tower()
      end)
    end
  end)
  if self.v_uicompents.SynthesisBtn_btn then
    self:set_button("SynthesisBtn", function()
      if not self:check_btn_can_click() then
        return
      end
      self:on_click_synthesis_btn()
    end)
  end
  self.v_safe_area_cg = self:get_canvas_group("SafeArea")
  local x, y, _ = self.v_uicompents.SpineRaw_rect:GetLocalPositionA3()
  local scale, _, _ = self.v_uicompents.SpineRaw_rect:GetLocalScaleA3()
  self.v_default_raw_img_offset = {
    x,
    y,
    scale
  }
  x, y, _ = self.v_uicompents.Char_rect:GetLocalPositionA3()
  scale, _, _ = self.v_uicompents.Char_rect:GetLocalScaleA3()
  self.v_default_img_offset = {
    x,
    y,
    scale
  }
end

function ui:check_fight_cost()
  local is_enough = true
  if self.v_fight_type == CommonDef.CHALLENGE_TYPE.VERSION_EPISODE then
    local fight_cost = TimeLimitedActMgr:get_fight_cost(self.v_episode_id)
    is_enough = BagMgr:get_cost_enough(Config.PLAYER_SP_ITEMID, fight_cost)
  end
  if not is_enough then
    Util.show_message_tip("明度不足")
  end
  return is_enough
end

function ui:on_click_synthesis_btn()
  if self.v_is_sweep_mode or self.v_fight_type == CommonDef.CHALLENGE_TYPE.NEW_MATERIAL then
    AssistMgr:try_hide_add_assist_friend_tips()
    local lack_id, lack_count = ChapterMaterialMgr:try_get_lack_item()
    
    local function cb()
      local function exit_cb()
        if SceneMgr:check_main_scene() then
          Jump_Helper.jump_to_new_ui_item_synthesis(lack_id, lack_count, true)
          
          return
        end
        local combine_id = BagMgr:get_item_combine_id(lack_id)
        UIMgr:set_main_scene_after_load_ui("new_ui_item_synthesis", combine_id, lack_count, true)
        Global.scene_mgr:on_enter_main_scene()
        UIMgr:revert_cache_ui()
      end
      
      TowerMgr:on_exit_tower(exit_cb)
    end
    
    self:check_after_story(cb)
  end
end

function ui:check_btn_can_click()
  if self.v_is_can_click_btn then
    self.v_is_can_click_btn = false
    self.v_click_btn_timer = Timer:add_timer("is_can_click_btn_timer", check_function_btn_time, function()
      self.v_is_can_click_btn = true
    end)
    return true
  end
  return false
end

function ui:check_after_story(cb, skip_story)
  if not skip_story and TowerMgr:check_play_fight_story(nil, cb) then
    return
  end
  cb()
end

function ui:_on_fight_scene_click_continue()
  if self.v_next_node_cfg and self.v_next_node_cfg.NodeType == CommonDef.CHAPTER_NODE_TYPE.STORY_LINE then
    StoryMgr:play_behind_story_node(self.v_next_node_cfg.Id)
  else
    local is_tp_floor, next_main_line_node_cfg = self.v_is_tp_floor, self.v_next_main_line_node_cfg
    local is_tp_room = SceneMgr:check_continue_tp_room()
    if not is_tp_room then
      if is_tp_floor then
        local next_floor_num = next_main_line_node_cfg.FloorId
        local tower = TowerMgr:get_tower()
        tower:record_temp_formation_data(next_floor_num)
        local progress = TowerMgr:get_tower_progress()
        UIMgr:get_ui("team"):ui_show(progress.param, progress.episode_id, progress.challenge_type, nil, progress.node_id, next_floor_num)
      else
        local achievement_tip = UIMgr:get_ui("common_battle_tips")
        local show_data = {
          node_cfg = self.v_cur_save_node_cfg,
          is_first_save = true
        }
        if not achievement_tip:visible() then
          achievement_tip:ui_show(nil, nil, show_data)
        else
          achievement_tip:show_save_suc_tips(show_data)
        end
        if self.v_record_group_id then
          GraphicGuideMgr:init(self.v_record_group_id)
          self.v_record_group_id = nil
        end
      end
    else
      UIMgr:get_ui("loading"):ui_show()
      self:ui_hide()
    end
    MsgGame:mq_publish2(Const.MSG_ON_CLOSE_SETTLE_UI)
    ChapterMgr:on_chapter_node_continue(next_main_line_node_cfg.Id)
  end
end

function ui:_on_main_scene_click_continue()
  if self.v_cur_save_node_cfg and self.v_next_node_cfg then
    if self.v_next_node_cfg.NodeType == CommonDef.CHAPTER_NODE_TYPE.MAIN_LINE then
      local node_id = self.v_next_main_line_node_cfg.Id
      local point_id = self.v_next_main_line_node_cfg.EpisodeId
      local chapter_id = ChapterMgr:get_chapter_by_episode(point_id).Id
      local fight_type = CommonDef.CHALLENGE_TYPE.LONG_CHAPTER
      UIMgr:get_ui("team"):ui_show(chapter_id, point_id, fight_type, nil, node_id)
    elseif self.v_next_node_cfg.NodeType == CommonDef.CHAPTER_NODE_TYPE.STORY_LINE then
      StoryMgr:play_behind_story_node(self.v_next_node_cfg.Id)
    end
  else
    TowerMgr:long_chapter_exit(false)
  end
end

function ui:on_click_continue_button()
  local function cb()
    if self.v_is_node_save == true then
      if SceneMgr:check_main_scene() and TowerMgr then
        self:ui_hide()
        
        self:_on_main_scene_click_continue()
      else
        self:_on_fight_scene_click_continue()
        self:ui_hide()
      end
    elseif self.v_is_node_save == CHAPTER_CONFIG.POINTSTATE.complete and self.v_next_node_cfg then
      local function story_cb()
        self:on_click_left_btn(true)
      end
      
      StoryMgr:play_behind_story_node(self.v_next_node_cfg.Id, story_cb)
    else
      local function exit_cb()
        if SceneMgr:check_main_scene() then
          self:ui_hide()
          
          return
        end
        Global.scene_mgr:on_enter_main_scene()
        UIMgr:revert_cache_ui()
      end
      
      if not self.v_is_get_award and self.v_is_buddy_teach then
        TowerMgr:on_exit_tower(exit_cb)
      else
        exit_cb()
      end
    end
  end
  
  self:check_after_story(cb)
end

function ui:on_click_left_btn(skip_story)
  local function cb()
    local function exit_cb()
      if SceneMgr:check_main_scene() then
        self:ui_hide()
      end
      if self.v_fight_type == CommonDef.CHALLENGE_TYPE.LONG_CHAPTER or self.v_fight_type == CommonDef.CHALLENGE_TYPE.CHAPTER then
        local ui_name = "ui_chapter_detail"
        UIMgr:set_main_scene_after_load_ui(ui_name, self.v_chapter_id)
      end
      Global.scene_mgr:on_enter_main_scene()
      UIMgr:revert_cache_ui()
    end
    
    if self.v_is_long_chapter then
      TowerMgr:long_chapter_exit(true, exit_cb, true)
    else
      TowerMgr:on_exit_tower(exit_cb)
    end
  end
  
  self:check_after_story(cb, skip_story)
end

function ui:check_need_tp_next_floor()
  local node_cfg = self.v_cur_save_node_cfg
  local next_node_cfg = ChapterMgr:get_next_main_line_node(node_cfg.Id)
  return nil ~= next_node_cfg and node_cfg.FloorId ~= next_node_cfg.FloorId, next_node_cfg
end

function ui:ui_on_show(is_node_save, result_list, cur_save_node_cfg, skip_get_award, sweep_param)
  self:check_room()
  self.v_is_can_click_btn = true
  self.v_low_update = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
  self.v_is_sweep_mode = sweep_param and true or false
  self.v_sweep_data = sweep_param
  if self.v_is_sweep_mode then
    self:refresh_view_in_sweep_mode()
  else
    self:fade_in(is_node_save, result_list, cur_save_node_cfg, skip_get_award)
  end
  self:refresh_re_fight_btn()
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self.refresh_award_lack, self)
end

function ui:refresh_re_fight_btn()
  self.v_uiobjects.BtnQuickFight:SetActive(false)
  self.v_uiobjects.BtnReFight:SetActive(false)
  local fight_type = TowerMgr:get_fight_type()
  if fight_type == CommonDefine.CHALLENGE_TYPE.NEW_MATERIAL then
    self.v_uiobjects.BtnReFight:SetActive(true)
  end
  local tower_progress = TowerMgr:get_tower_progress()
  if nil ~= tower_progress then
    local material_id = ShareRes.get_material_id_by_epi_id(tower_progress.episode_id)
    if nil ~= material_id then
      local can_sweep = false
      local material_server_info = ChapterMaterialMgr:get_material_server_info(material_id)
      if material_server_info then
        can_sweep = material_server_info.can_sweep
      end
      if fight_type == CommonDefine.CHALLENGE_TYPE.NEW_MATERIAL and can_sweep then
        self.v_restore_material_id = material_id
        self.v_uiobjects.BtnReFight:SetActive(false)
        self.v_uiobjects.BtnQuickFight:SetActive(true)
      end
    end
  end
end

function ui:check_room()
  if not TowerMgr then
    return
  end
  local fight_type = TowerMgr:get_fight_type()
  if fight_type ~= CommonDefine.CHALLENGE_TYPE.LINEAR or fight_type == CommonDefine.CHALLENGE_TYPE.CLIMBING_TOWER then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local room = tower:get_room()
  if not room then
    return
  end
  room:disconnect()
end

function ui:ui_on_update()
  if not self.v_spine_id then
    return
  end
  if Global.real_time - self.v_low_update < SpineHelper.UPDATE_TIME then
    return
  end
  self.v_low_update = Global.real_time
  if self.v_anim_data.record_data.play_end then
    self.v_start_time = self.v_start_time or Global.real_time
    if self.v_anim_interval and Global.real_time - self.v_start_time > self.v_anim_interval then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.INTERVAL)
    elseif self.v_single_anim_delay and Global.real_time - self.v_start_time > self.v_single_anim_delay then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.SINGLE)
      self.v_single_anim_delay = nil
    end
  else
    self.v_start_time = Global.real_time
  end
  SpineHelper.check_play_anim(self.v_spine_rt, self.v_anim_data)
end

function ui:before_fade_in(is_node_save, result_list, cur_save_node_cfg, skip_get_award)
  self.v_hide_follow_bar = false
  UIMgr:try_hide_ui("ui_battle_item")
  PlayerMgr:try_show_exp_up_tips()
  self:refresh_view(is_node_save, result_list, cur_save_node_cfg, skip_get_award)
  AssistMgr:check_show_add_assist_friend_tips()
end

function ui:refresh_view_in_sweep_mode()
  self.v_uiobjects.TimeObj:SetActive(false)
  self.v_uiobjects.BtnDamage:SetActive(false)
  local type_cfg = ShareRes.get_challenge_type_config(13)
  local episode_cfg = ShareRes.get_chapter_point_cfg(self.v_sweep_data.episode_id)
  self.v_uicompents.StageType_txt.text = type_cfg.Name
  self.v_uicompents.SiName_txt.text = episode_cfg.PointName
  self:refresh_hero_info()
  self:give_back_auto_cache(TEMPLATE_KEY_TARGET)
  local cond_list = ShareRes.get_point_star_condition(self.v_sweep_data.episode_id)
  for index, condition_id in ipairs(cond_list) do
    if condition_id > 0 then
      local item = self:get_auto_cache(TEMPLATE_KEY_TARGET)
      local cfg = ShareRes.get_point_star_condition_cfg(condition_id)
      if cfg then
        local desc_txt = Util.get_text("TargetDesc_", item)
        local temp = cfg.ConditionDesc
        local arg = cfg.Arg[1]
        if cfg.ConditionType == Condition_Type.HealthMoreThan then
          local percent_health = arg / 100
          percent_health = math.max(percent_health, 1)
          arg = string.format("%d", percent_health) .. "%"
        end
        temp = Util.format_str(temp, arg)
        desc_txt.text = temp
        local complete = ChapterMaterialMgr:is_chapter_material_epi_task_finish(self.v_sweep_data.chapter_id, index)
        local comp_img = Util.get_image("Complete_", item)
        comp_img:SetActive(complete)
        local temp_color = desc_txt.color
        temp_color.a = complete and 1 or 0.3
        desc_txt.color = temp_color
      end
    end
  end
  self:refresh_award()
  self.v_uiobjects.BtnLeft:SetActive(false)
  self.v_uiobjects.BtnContinueCost:SetActive(false)
  self.v_uiobjects.BtnContinue:SetActive(true)
  local continue_text = Util.get_text("Text", self.v_uiobjects.BtnContinue)
  continue_text.text = "继续"
end

function ui:refresh_view(is_node_save, result_list, cur_save_node_cfg, skip_get_award)
  self.v_record_group_id = nil
  self.v_next_node_cfg = nil
  self.v_cur_save_node_cfg = cur_save_node_cfg
  if self.v_cur_save_node_cfg and (self.v_cur_save_node_cfg.BehindNodeId or self.v_cur_save_node_cfg.BehindNodeId > 0) then
    self.v_next_node_cfg = ShareRes.get_chapter_node_cfg(self.v_cur_save_node_cfg.BehindNodeId)
    self.v_is_tp_floor, self.v_next_main_line_node_cfg = self:check_need_tp_next_floor()
  end
  self.v_is_node_save = is_node_save
  self.v_result_list = result_list
  self.v_is_in_main_scene = SceneMgr:check_main_scene()
  if self.v_is_in_main_scene then
    self.v_uiobjects.BtnLeft:SetActive(false)
    if nil == cur_save_node_cfg then
      self.v_uiobjects.Blur:SetActive(true)
      self.v_uiobjects.Black:SetActive(false)
    else
      self.v_uiobjects.Blur:SetActive(false)
      self.v_uiobjects.Black:SetActive(true)
      self:set_follow_bar_show_state(false)
    end
  else
    self.v_uiobjects.BtnLeft:SetActive(self.v_is_node_save == true)
    self.v_uiobjects.Blur:SetActive(false)
    self.v_uiobjects.Black:SetActive(false)
  end
  self.v_uiobjects.BtnDamage:SetActive(true)
  self.v_uiobjects.BBBlack:SetActive(false)
  if TowerMgr then
    self.v_tower_progress = TowerMgr:get_tower_progress()
    self.v_fight_type = self.v_tower_progress.challenge_type
    local fight_info = TowerMgr:get_fight_info()
    if self.v_tower_progress then
      self.v_episode_id = self.v_tower_progress.episode_id
    end
    if self.v_episode_id <= 0 and fight_info then
      self.v_episode_id = fight_info.point_id
    end
    if self.v_episode_id <= 0 and cur_save_node_cfg then
      self.v_episode_id = cur_save_node_cfg.EpisodeId
    end
    if self.v_fight_type <= 0 and fight_info then
      self.v_fight_type = fight_info.type
    end
    if self.v_fight_type <= 0 and cur_save_node_cfg then
      self.v_fight_type = CommonDef.CHALLENGE_TYPE.LONG_CHAPTER
    end
    local episode_cfg = ChapterMgr:get_chapter_by_episode(self.v_episode_id)
    if episode_cfg then
      self.v_chapter_id = episode_cfg.Id
    end
  end
  self.v_is_long_chapter = self.v_fight_type == CommonDef.CHALLENGE_TYPE.LONG_CHAPTER
  self.v_is_buddy_teach = self.v_fight_type == CommonDef.CHALLENGE_TYPE.BUDDY_TEACH
  if not self.v_is_long_chapter and not skip_get_award then
    self.v_is_get_award = true
    TowerMgr:get_fight_reward()
  end
  self.v_episode_cfg = ShareRes.get_chapter_point_cfg(self.v_episode_id)
  self.v_chapter_cfg = ShareRes.create("chapter.chapter", self.v_tower_progress.param)
  if not self.v_episode_cfg then
    return
  end
  self:refresh_data()
end

function ui:remove_click_btn_timer()
  if self.v_click_btn_timer then
    Timer:remove_timer(self.v_click_btn_timer)
    self.v_click_btn_timer = nil
  end
end

function ui:ui_on_hide()
  self:remove_click_btn_timer()
  self.v_uiobjects.Black:SetActive(false)
  if self.v_hide_follow_bar then
    self:set_follow_bar_show_state(true)
  end
  for key, item in pairs(self.v_item_list) do
    item:ui_hide()
    item:ui_destroy()
  end
  self.v_item_list = {}
  self.v_is_node_save = false
  self.v_result_list = {}
  local ui_chapter_detail = UIMgr:try_get_visible_ui("ui_chapter_detail")
  if ui_chapter_detail then
    if self.v_no_close_detail_view then
      ui_chapter_detail:reset_scroll()
    else
      ui_chapter_detail:ui_hide()
    end
  end
  if self.v_fade_in_timer then
    Timer:remove_timer(self.v_fade_in_timer)
    self.v_fade_in_timer = nil
  end
  if self.v_origin_width and self.v_origin_height then
    self.v_uicompents.SpineRaw_rect:SetSizeDeltaA(self.v_origin_width, self.v_origin_height)
  end
  self.v_no_close_detail_view = nil
  UIMgr:try_hide_ui("exp_up_tips")
  SceneMgr:show_npc_hp_obj()
  AssistMgr:try_hide_add_assist_friend_tips()
end

function ui:ui_on_destroy()
  self:clear_spine_rt()
  AssistMgr:try_hide_add_assist_friend_tips()
end

function ui:refresh_data()
  self:refresh_title()
  self:refresh_target()
  self:refresh_award()
  self:refresh_button()
  self:refresh_button_new()
  self:refresh_hero_info()
  self:refresh_fight_time()
end

function ui:refresh_button()
  local uiobj = self.v_uiobjects
  if self.v_is_long_chapter then
    if self.v_cur_save_node_cfg then
      if self.v_cur_save_node_cfg.NodeType == CommonDef.CHAPTER_NODE_TYPE.BRANCH_LINE then
        local tower_id = self.v_tower_progress.tower_id
        local passed_floor = TowerMgr:get_tower_history_floor_num(tower_id) >= self.v_cur_save_node_cfg.FloorId
        uiobj.BtnContinue:SetActive(true)
        uiobj.BtnLeft:SetActive(passed_floor)
        self:set_cost_show(false)
      elseif self.v_next_node_cfg then
        if self.v_is_in_main_scene then
          if not self.v_next_node_cfg.ExploreNode or self.v_next_node_cfg.ExploreNode ~= self.v_next_node_cfg.Id then
            uiobj.BtnLeft:SetActive(true)
            uiobj.BtnContinue:SetActive(false)
          else
            uiobj.BtnLeft:SetActive(true)
            uiobj.BtnContinue:SetActive(true)
            self:set_cost_show(true)
          end
        else
          uiobj.BtnContinue:SetActive(true)
          uiobj.BtnLeft:SetActive(true)
          self:set_cost_show(true)
        end
      else
        uiobj.BtnLeft:SetActive(true)
        uiobj.BtnContinue:SetActive(false)
      end
    else
      uiobj.BtnLeft:SetActive(not self.v_is_in_main_scene)
      uiobj.BtnContinue:SetActive(self.v_is_in_main_scene)
      self:set_cost_show(false)
    end
  else
    uiobj.BtnContinue:SetActive(true)
    uiobj.BtnLeft:SetActive(false)
    self:set_cost_show(false)
  end
  if self.v_fight_type == CommonDef.CHALLENGE_TYPE.NEW_MATERIAL then
    self:set_cost_show(false)
  end
end

function ui:refresh_button_new()
  local btn_left = self.v_uiobjects.BtnLeft
  local btn_continue = self.v_uiobjects.BtnContinue
  local left_text = Util.get_text("Text", btn_left)
  local continue_text = Util.get_text("Text", btn_continue)
  local is_need_show_left_btn, next_epi_id, next_param = self:is_need_show_left_btn_with_fight_type()
  local is_buddy_teach = self:is_buddy_teach_need_tp_next_floor()
  self.v_is_need_refresh_red = false
  if is_need_show_left_btn then
    btn_left:SetActive(true)
    if 0 == next_epi_id then
      left_text.text = "重新挑战"
      if self.v_fight_type == CommonDefine.CHALLENGE_TYPE.VERSION_EPISODE then
        left_text.text = "再次挑战"
      end
    else
      self.v_is_need_refresh_red = true
      left_text.text = "挑战下一关"
    end
    self.next_epi_id = next_epi_id
    self.next_epi_param = next_param
  elseif is_buddy_teach then
    btn_left:SetActive(true)
    left_text.text = "挑战下一关"
  else
    left_text.text = "结算"
  end
  continue_text.text = "退出关卡"
end

function ui:refresh_hero_info()
  local hero_list = self.v_is_sweep_mode and self.v_sweep_data.hero_list or self.v_tower_progress.battle_buddy_data
  if not hero_list then
    for index = 1, MAX_CHAR_ITEM_COUNT do
      self.v_uiobjects["Char" .. index]:SetActive(false)
    end
    return
  end
  local main_pos
  if not SceneMgr:check_main_scene() and not SceneMgr:global_hero_is_destroyed() then
    main_pos = Global.hero:get_team_pos()
  end
  table.sort(hero_list, sort)
  local role_cfg, role_id, icon_path, qual_val, data, main_role, fashion_id, zhanli_txt
  local FORMATION_BUDDY_STATUS = Config.CommonDefine.FORMATION_BUDDY_STATUS
  for index = 1, MAX_CHAR_ITEM_COUNT do
    data = hero_list[index]
    if data then
      self.v_uiobjects["Char" .. index]:SetActive(true)
      if main_pos and main_pos == data.pos or data.is_main then
        main_role = data
      end
      role_id = data.buddy_id
      fashion_id = data.fashion
      role_cfg = ShareRes.create("buddy.buddy", role_id)
      icon_path = UtilUI.get_hero_images(role_id, 2, fashion_id)
      ResMgr:load_set_icon(self.v_uicompents["CharIcon" .. index .. "_img"], icon_path)
      icon_path = Char_Helper.get_char_select_quality_icon(role_id)
      ResMgr:load_set_icon(self.v_uicompents["QualityBg" .. index .. "_img"], icon_path)
      qual_val = role_cfg.Quality
      icon_path = Char_Helper.get_char_line_quality_icon(qual_val)
      ResMgr:load_set_icon(self.v_uicompents["QualityLine" .. index .. "_img"], icon_path)
      self.v_uiobjects["Trial" .. index]:SetActive(data.status == FORMATION_BUDDY_STATUS.FIXED_BUDDY)
      self.v_uiobjects["AssistTip" .. index]:SetActive(data.status == FORMATION_BUDDY_STATUS.HELP_FIGHT)
      zhanli_txt = self.v_uicompents["ZhanliNum" .. index .. "_txt"]
      if data.status == FORMATION_BUDDY_STATUS.MYSELF then
        zhanli_txt.text = data.power
        zhanli_txt.gameObject:SetActive(true)
      else
        zhanli_txt.gameObject:SetActive(false)
      end
    else
      self.v_uiobjects["Char" .. index]:SetActive(false)
    end
  end
  fashion_id = main_role.fashion
  local spine_id, is_spine, offset = UtilUI.get_hero_settle_spine(main_role.buddy_id, fashion_id)
  self.v_uiobjects.SpineRaw:SetActive(is_spine)
  self.v_uiobjects.Char:SetActive(not is_spine)
  if is_spine then
    self:clear_spine_rt()
    self.v_spine_id = spine_id
    self.v_anim_interval = SpineHelper.get_anim_interval(self.v_spine_id)
    self.v_single_anim_delay = SpineHelper.get_single_anim_delay(self.v_spine_id)
    if UNITY_EDITOR or UNITY_STANDALONE_WIN then
      if not self.v_origin_width and not self.v_origin_height then
        self.v_origin_width, self.v_origin_height = self.v_uicompents.SpineRaw_rect:GetSizeDeltaA()
      end
      self.v_uicompents.SpineRaw_rect:SetSizeDeltaA(self.v_origin_width * offset[3], self.v_origin_height * offset[3])
    else
      self.v_uicompents.SpineRaw_rect:SetLocalScaleA(offset[3], offset[3], offset[3])
    end
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.SpineRaw)
    SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.SpineRaw)
    offset = offset or self.v_default_raw_img_offset
    self.v_uicompents.SpineRaw_rect:SetLocalPositionA(offset[1], offset[2], 0)
  else
    self.v_spine_id = nil
    icon_path = spine_id
    ResMgr:load_set_icon(self.v_uicompents.Char_img, icon_path, nil, true, self)
    offset = offset or self.v_default_img_offset
    self.v_uicompents.Char_rect:SetLocalPositionA(offset[1], offset[2], 0)
    self.v_uicompents.Char_rect:SetLocalScaleA(offset[3], offset[3], offset[3])
  end
end

function ui:is_buddy_teach_need_tp_next_floor()
  if self.v_is_buddy_teach then
    return SceneMgr:check_need_continue_tp_room()
  end
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:is_need_show_left_btn_with_fight_type()
  local is_need_show_left_btn = false
  local next_epi_id = 0
  local next_epi_param
  if self.v_fight_type == CommonDefine.CHALLENGE_TYPE.LINEAR then
    is_need_show_left_btn = true
    local is_max_star, next_id, next_param = LinearMgr:get_is_reach_max_star_and_next_epi_id(self.v_episode_id)
    if is_max_star or self.v_all_condition_finished then
      next_epi_id = next_id
      next_epi_param = next_param
    end
  elseif self.v_fight_type == CommonDefine.CHALLENGE_TYPE.CLIMBING_TOWER then
    is_need_show_left_btn = true
    local is_max_star, next_id, next_param = ClimbingTowerMgr:get_is_reach_max_star_and_next_epi_id(self.v_episode_id)
    if is_max_star or self.v_all_condition_finished then
      next_epi_id = next_id
      next_epi_param = next_param
    end
    if is_max_star and (not next_id or 0 == next_id) then
      is_need_show_left_btn = false
    end
  elseif self.v_fight_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI or self.v_fight_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    local next_id = WeeklyMgr:get_next_epi_id(self.v_fight_type, self.v_tower_progress.episode_id)
    if self.v_all_condition_finished and 0 ~= next_id then
      is_need_show_left_btn = true
      next_epi_id = next_id
    end
  elseif self.v_fight_type == CommonDefine.CHALLENGE_TYPE.VERSION_EPISODE then
    is_need_show_left_btn = true
    next_epi_id = 0
  end
  return is_need_show_left_btn, next_epi_id, next_epi_param
end

function ui:refresh_title()
  if self.v_cur_save_node_cfg and self.v_is_long_chapter then
    self.v_uicompents.SiNum_txt.text = self.v_cur_save_node_cfg.TagNumName
    self.v_uiobjects.SiNumBg:SetActive(not Util.is_empty(self.v_cur_save_node_cfg.TagNumName))
    self.v_siname_text = self.v_cur_save_node_cfg.MainName
  else
    self.v_uicompents.SiNum_txt.text = self.v_episode_cfg.SerialNum
    self.v_uiobjects.SiNumBg:SetActive(not Util.is_empty(self.v_episode_cfg.SerialNum))
    self.v_siname_text = self.v_episode_cfg.PointName
  end
  local type_cfg = ShareRes.get_challenge_type_config(self.v_fight_type)
  self.v_uicompents.SiName_txt.text = self.v_siname_text
  self.v_uicompents.StageType_txt.text = type_cfg and type_cfg.Name
end

function ui:_change_alpha(target, a)
  local color = target.color
  color.a = a
  target.color = color
end

function ui:refresh_target()
  local fight_progress = self.v_tower_progress
  if not self.v_chapter_cfg then
    if fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.NEW_MATERIAL or fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.LINEAR or fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.CLIMBING_TOWER or fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI or fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI or fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.ACTIVITY_MINI_GAME then
      self:show_normal_target(fight_progress)
    else
      self.v_uiobjects.TargetObj:SetActive(false)
    end
    return
  end
  if self.v_fight_type == CommonDefine.CHALLENGE_TYPE.CHAPTER or fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI or fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    self:show_normal_target(fight_progress)
  else
    local cond_list = ShareRes.get_point_star_condition(self.v_episode_id)
    self.v_uiobjects.TargetObj:SetActive(not UtilTable.is_empty(cond_list))
  end
end

function ui:show_normal_target(fight_progress)
  local cond_list = ShareRes.get_point_star_condition(self.v_episode_id)
  if not cond_list or not next(cond_list) then
    self.v_uiobjects.TargetObj:SetActive(false)
    return
  end
  local show = false
  self.v_all_condition_finished = true
  self:give_back_auto_cache(TEMPLATE_KEY_TARGET)
  for index, condition_id in ipairs(cond_list) do
    if condition_id > 0 then
      local item = self:get_auto_cache(TEMPLATE_KEY_TARGET)
      local cfg = ShareRes.get_point_star_condition_cfg(condition_id)
      if cfg then
        local desc_txt = Util.get_text("TargetDesc_", item)
        local temp = cfg.ConditionDesc
        local arg = cfg.Arg[1]
        if cfg.ConditionType == Condition_Type.HealthMoreThan then
          local percent_health = arg / 100
          percent_health = math.max(percent_health, 1)
          arg = string.format("%d", percent_health) .. "%"
        end
        temp = Util.format_str(temp, arg)
        desc_txt.text = temp
        local complete = false
        if fight_progress and fight_progress.tower_task and fight_progress.tower_task[index] then
          complete = fight_progress.tower_task[index].status
        end
        if not complete then
          complete = self:check_history_finish_status(fight_progress.challenge_type, self.v_episode_id, index)
          self.v_all_condition_finished = false
        end
        local comp_img = Util.get_image("Complete_", item)
        comp_img:SetActive(complete)
        local temp_color = desc_txt.color
        temp_color.a = complete and 1 or 0.3
        desc_txt.color = temp_color
        show = true
      end
    end
  end
  self.v_uiobjects.TargetObj:SetActive(show)
end

function ui:check_history_finish_status(challenge_type, epi_id, index)
  local complete = false
  if challenge_type == CommonDefine.CHALLENGE_TYPE.LINEAR then
    complete = LinearMgr:get_condition_is_finish_with_point_id(epi_id, index)
  elseif challenge_type == CommonDefine.CHALLENGE_TYPE.CLIMBING_TOWER then
    complete = ClimbingTowerMgr:get_condition_is_finish_with_point_id(epi_id, index)
  end
  return complete
end

function ui:refresh_award(force)
  if self.v_fight_type == CommonDef.CHALLENGE_TYPE.ACTIVITY_MINI_GAME then
    self.v_uiobjects.AwardObj:SetActiveEx(false)
    self:refresh_award_lack()
    return
  else
    self.v_uiobjects.AwardObj:SetActiveEx(true)
  end
  local award_list
  if self.v_is_sweep_mode then
    award_list = self.v_sweep_data.award_list
  elseif self.v_fight_type ~= CommonDef.CHALLENGE_TYPE.LONG_CHAPTER and not self.v_is_buddy_teach and self.v_tower_progress then
    award_list = UtilTable.copy_table(self.v_tower_progress.award_list)
  else
    if not self.v_result_list or force then
      local temp_list = TowerMgr:get_node_result_list()
      self.v_result_list = temp_list
    end
    award_list = self.v_result_list
  end
  local award_temp_list = {}
  if award_list then
    local is_need_sort = true
    for i, v in pairs(award_list) do
      local item_cfg = Item_Helper.get_item_cfg(v.id)
      if nil == item_cfg or nil == item_cfg.Quality then
        is_need_sort = false
        break
      end
      v.Quality = item_cfg.Quality
      table.insert(award_temp_list, v)
    end
    if is_need_sort then
      table.sort(award_temp_list, function(a, b)
        return a.Quality > b.Quality
      end)
    else
      award_temp_list = award_list
    end
  end
  self:give_back_auto_cache(TEMPLATE_KEY_AWARD)
  local BG_STR = "Bg"
  local str, bg_obj
  for index = 1, 4 do
    str = BG_STR .. index
    bg_obj = self:get_child_gameobj(str, self.v_uiobjects.AwardContent)
    if bg_obj then
      bg_obj.gameObject:SetActive(nil == award_temp_list or nil == award_temp_list[index])
    end
  end
  if award_temp_list then
    for index, award in ipairs(award_temp_list) do
      if index < 4 then
      end
      
      function award.cb()
        UIMgr:get_ui("itemTip"):ui_show({
          item_id = award.id,
          is_hide_get_way = true
        })
      end
      
      local item = self:get_auto_cache(TEMPLATE_KEY_AWARD)
      self.v_item_list[award.id] = ITEM_OBJ_COM:ui_wrap(self, item)
      self.v_item_list[award.id]:set_data(award)
    end
    if Global.sound_mgr then
      Global.sound_mgr:play_reward_victory_sound()
    end
  end
  self:refresh_award_lack()
end

local format_str_lack = "<color=#ff5e5e>%s</color>/%s"
local format_str_enough = "%s/%s"

function ui:refresh_award_lack()
  if not self.v_uiobjects.ItemNeedObj then
    return
  end
  local lack_id, lack_count
  if self.v_is_sweep_mode or self.v_fight_type == CommonDef.CHALLENGE_TYPE.NEW_MATERIAL then
    lack_id, lack_count = ChapterMaterialMgr:try_get_lack_item()
  end
  local show_lack_info = nil ~= lack_id and 0 ~= lack_count
  self.v_uiobjects.ItemNeedObj:SetActiveEx(show_lack_info)
  if not show_lack_info then
    return
  end
  local own_count = BagMgr:get_item_num(lack_id)
  local synthesis_count = BagMgr:cal_can_synthesis_count(lack_id)
  local total = own_count + synthesis_count
  self.v_uiobjects.SynthesisTips:SetActive(synthesis_count > 0 and lack_count <= total)
  self.v_uicompents.NeedItemName_txt.text = ShareRes.get_item_name(lack_id)
  self.v_uicompents.NeedItemNum_txt.text = string.format(lack_count <= total and format_str_enough or format_str_lack, total, lack_count)
end

function ui:record_group_id(group_id)
  self.v_record_group_id = group_id
end

function ui:on_long_chapter_fight_complete()
  local tower = TowerMgr:get_tower()
  local room_id = tower:get_cur_room_id()
  local node_cfg = ShareRes.get_chapter_node_cfg(self.v_tower_progress.node_id)
  if node_cfg and node_cfg.BehindNodeId then
    local behinde_node_cfg = ShareRes.get_chapter_node_cfg(node_cfg.BehindNodeId)
    if behinde_node_cfg and behinde_node_cfg.NodeType == CommonDef.CHAPTER_NODE_TYPE.STORY_LINE then
      self.v_cur_save_node_cfg = node_cfg
      self.v_next_node_cfg = behinde_node_cfg
    end
  end
end

function ui:set_follow_bar_show_state(is_show)
  local fight = UIMgr:try_get_visible_ui("fight")
  if fight then
    fight:set_hp_visible(is_show)
    self.v_hide_follow_bar = not is_show
  else
    self.v_hide_follow_bar = false
  end
end

function ui:fade_in(is_node_save, result_list, cur_save_node_cfg, skip_get_award)
  self:before_fade_in(is_node_save, result_list, cur_save_node_cfg, skip_get_award)
  local need_fade = TowerMgr and TowerMgr:is_long_chapter() and not SceneMgr:check_main_scene() and not SceneMgr:check_need_continue_tp_room() and self.v_next_main_line_node_cfg and not self.v_is_tp_floor
  if need_fade then
    if self.v_fade_in_timer then
      Timer:remove_timer(self.v_fade_in_timer)
      self.v_fade_in_timer = nil
    end
    self.v_safe_area_cg.alpha = 0
    local duraiton = 2
    self.v_fade_in_timer = Timer:add_timer("fade_in", duraiton, function()
      self.v_safe_area_cg.alpha = 1
      self.v_uicompents.InPd_pd:Stop()
      self.v_uicompents.InPd_pd:Play()
      self:try_destory_story()
      self:check_ui_chapter_detail()
      self.v_fade_in_timer = nil
    end)
  else
    self:try_destory_story()
    self.v_safe_area_cg.alpha = 1
    self.v_uicompents.InPd_pd:Stop()
    self.v_uicompents.InPd_pd:Play()
    self:check_ui_chapter_detail()
  end
end

function ui:check_ui_chapter_detail()
  local is_chapter = self.v_fight_type == CommonDef.CHALLENGE_TYPE.CHAPTER
  local show_detail = false
  if self.v_is_long_chapter or is_chapter then
    local chapter_id = self.v_chapter_id
    local pass_param = {}
    if self.v_is_long_chapter then
      if self.v_is_node_save == CHAPTER_CONFIG.POINTSTATE.complete then
        self:on_long_chapter_fight_complete()
      end
      if self.v_cur_save_node_cfg then
        pass_param.pass_id = self.v_cur_save_node_cfg.Id
      else
        pass_param.pass_id = self.v_tower_progress.node_id
      end
    else
      pass_param.pass_id = self.v_episode_id
      chapter_id = ChapterMgr:get_chapter_by_hard_chapter_id(chapter_id)
    end
    local area_gather = ShareRes.get_chapter_area_gather(chapter_id)
    if area_gather then
      pass_param.is_hard = is_chapter
      local ui_chapter_detail = UIMgr:get_ui("ui_chapter_detail", true)
      if not ui_chapter_detail:visible() then
        SceneMgr:hide_npc_hp_obj()
        ui_chapter_detail:ui_show(chapter_id, pass_param)
      else
        ui_chapter_detail:on_pass_node(pass_param)
      end
      show_detail = true
    end
  end
  local a = (show_detail or self.v_cur_save_node_cfg) and 0 or 1
  self:_change_alpha(self.v_uicompents.FullScreenBackground_img, a)
end

function ui:try_destory_story()
  if not StoryMgr:is_playing_story() then
    UIMgr:try_destory_ui("uistory")
    UIMgr:try_destory_ui("ui_blackfade")
  end
  TimeLineSeqPlayer.after_enter_settle()
end

function ui:set_cost_show(show)
  if show then
    if self.v_next_node_cfg.Cost > 0 then
      self.v_uiobjects.BtnContinueCost:SetActive(true)
      self.v_uicompents.BtnContinueCostTxt_txt.text = self.v_next_node_cfg.Cost
      ResMgr:load_set_icon(self.v_uicompents.BtnContinueCostImg_img, UtilUI.get_item_icon(Config.PLAYER_SP_ITEMID))
    else
      self.v_uiobjects.BtnContinueCost:SetActive(false)
    end
  else
    self.v_uiobjects.BtnContinueCost:SetActive(false)
  end
end

function ui:refresh_fight_time()
  local fight_time = self.v_tower_progress.fight_time
  if nil ~= fight_time then
    self.v_uiobjects.TimeObj:SetActive(true)
    local str = Date.get_time_formate_4(fight_time, true)
    self.v_uicompents.TimeNum_txt.text = str
  else
    self.v_uiobjects.TimeObj:SetActive(false)
  end
end

return ui
