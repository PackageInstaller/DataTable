local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local AssetBarView = require("ui.asset_bar.asset_bar")
local MONKEY_LAYOUT_ITEM_CLASS = require("uimodule.activity.monkey_typer.monkey_layout_item")
local MONKEY_UPGRADE_ITEM_CLASS = require("uimodule.activity.monkey_typer.monkey_upgrade_item")
local MONKEY_BUBBLE_ITEM_CLASS = require("uimodule.activity.monkey_typer.monkey_bubble_item")
local BUBBLECONTENT_BUBBLETEM_TEMP_KEY = "BUBBLECONTENT_BUBBLETEM_TEMP_KEY"
local EFFICIENCYUPLAYOUT_EFFICIENCYUPTEM_TEMP_KEY = "EFFICIENCYUPLAYOUT_EFFICIENCYUPTEM_TEMP_KEY"
local QUESTION_STATU = Config.CommonDefine.MONKEY_TYPEWRITER_QUESTION_STATE
local UPGRADE_TYPE = Config.CommonDefine.MONKEY_TYPEWRITER_UPGRADE_TYPE
local MONKEY_UPGRADE_TYPE = {
  UPGRADE_TYPE.MONKEY_COUNT,
  UPGRADE_TYPE.MONKEY_VELOCITY
}
local TYPER_UPGRADE_TYPE = {
  UPGRADE_TYPE.TYPE_WRITER_HOT,
  UPGRADE_TYPE.TYPE_WRITER_VELOCITY,
  UPGRADE_TYPE.TYPE_WRITER_CLICK,
  UPGRADE_TYPE.COIN_OUTPUT
}
local UPGRADE_TYPE_LIST = {
  [1] = MONKEY_UPGRADE_TYPE,
  [2] = TYPER_UPGRADE_TYPE
}

function ui:on_click_BtnRet1()
  if self.v_uiobjects.Main.activeSelf or not self.v_uiobjects.EfficiencyUp.activeSelf then
    self:ui_hide()
  else
    self.v_uiobjects.Ani_Machine_Fix:SetActive(false)
    self.v_uiobjects.Main:SetActive(true)
    self.v_uiobjects.EfficiencyUp:SetActive(false)
    self:refresh_upgrade_btn_selected(0)
  end
end

function ui:on_click_BtnQuestion()
  UIMgr:get_ui("monkey_typer_question_panel"):ui_show(self.v_activity_id, self.v_question_id)
end

function ui:on_click_BtnAward()
  UIMgr:get_ui("monkey_typer_task_panel"):ui_show(self.v_activity_id)
end

function ui:on_click_Normal()
  if self.v_typer_click_cold_down then
    return
  end
  self.v_typer_click_cold_down = true
  self:clear_timer()
  self.v_delay_enter_chapter_timer = Timer:add_timer("monkey_typer_cold_timer", 0.2, function()
    self.v_typer_click_cold_down = false
  end)
  MonkeyTyperMgr:req_click_typer(self.v_activity_id, function(ok)
    if ok then
      self:play_click_bubble()
    end
  end)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.monkey_typer_click_machine_UI_SOUND)
end

function ui:on_click_OverHeat()
  MonkeyTyperMgr:req_reset_overheat_typer(self.v_activity_id)
  self.v_uiobjects.Ani_Machine_Fix:SetActiveEx(false)
  self.v_uiobjects.Ani_Machine_Fix:SetActiveEx(true)
  self.v_uiobjects.Ani_UIMonkeyMain_Loop:SetActiveEx(true)
end

function ui:on_click_BtnMachineUp()
  if self.v_uiobjects.BtnMachineUpSelect.activeSelf then
    return
  end
  self.v_uiobjects.Main:SetActiveEx(false)
  self.v_uiobjects.EfficiencyUp:SetActiveEx(true)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.monkey_typer_machine_up_UI_SOUND)
  self:show_upgrade_view(2)
end

function ui:on_click_BtnMonkeyUp()
  if self.v_uiobjects.BtnMonkeyUpSelect.activeSelf then
    return
  end
  self.v_uiobjects.Main:SetActiveEx(false)
  self.v_uiobjects.EfficiencyUp:SetActiveEx(true)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.monkey_typer_monkey_up_UI_SOUND)
  self:show_upgrade_view(1)
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_activity_id
end

function ui:ui_finish_load()
  self:set_button("BtnMachineUp", function()
    self:on_click_BtnMachineUp()
  end)
  self:set_button("BtnMain", function()
    self:on_click_BtnMain()
  end)
  self:set_button("BtnMonkeyUp", function()
    self:on_click_BtnMonkeyUp()
  end)
  self:set_button("BtnRet1", function()
    self:on_click_BtnRet1()
  end)
  self:set_button("BtnQuestion", function()
    self:on_click_BtnQuestion()
  end)
  self:set_button("BtnAward", function()
    self:on_click_BtnAward()
  end)
  self:set_button("Normal", function()
    self:on_click_Normal()
  end)
  self:set_button("OverHeat", function()
    self:on_click_OverHeat()
  end)
  self.v_click_bubble_obj = {
    self.v_uiobjects.ClickNumberTxt1,
    self.v_uiobjects.ClickNumberTxt2,
    self.v_uiobjects.ClickNumberTxt3
  }
  self.v_click_bubble_txt = {
    self.v_uicompents.ClickNumberTxt1_txt,
    self.v_uicompents.ClickNumberTxt2_txt,
    self.v_uicompents.ClickNumberTxt3_txt
  }
  self:register_exist_auto_template(BUBBLECONTENT_BUBBLETEM_TEMP_KEY, self.v_uiobjects.BubbleTem, self.v_uiobjects.BubbleContent)
  self:register_exist_auto_template(EFFICIENCYUPLAYOUT_EFFICIENCYUPTEM_TEMP_KEY, self.v_uiobjects.EfficiencyUpTem, self.v_uiobjects.EfficiencyUpLayout)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
end

function ui:clear_timer()
  if self.v_delay_enter_chapter_timer then
    Timer:remove_timer(self.v_delay_enter_chapter_timer)
    self.v_delay_enter_chapter_timer = nil
  end
end

function ui:ui_on_hide()
  self:clear_wrap_monkey_layout_items()
  self:clear_wrap_upgrade_items()
  self:clear_wrap_bubble_items()
  self:clear_timer()
  self.v_asset_bar:on_hide()
  UIMgr:try_hide_ui("monkey_typer_question_tips")
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:ui_on_show(activity_id)
  self.v_activity_id = activity_id
  if self:check_close(true) then
    return
  end
  self.v_uiobjects.Ani_Machine_Fix:SetActiveEx(false)
  self.v_uiobjects.Main:SetActive(true)
  self.v_uiobjects.EfficiencyUp:SetActive(false)
  self:refresh_upgrade_btn_selected(0)
  self.v_typer_click_cold_down = false
  self.v_cur_monkey_layout_idx = nil
  self:init_monkey_layout()
  self:refresh_question_info()
  MonkeyTyperMgr:req_refresh_question(self.v_activity_id)
  NoviceMgr:mark_act_daily_open(self.v_activity_id)
  self:bind_auto_mq(Const.MSG_ON_MONKEY_TYPER_QUESTION_UPDATE, self.refresh_question_info, self)
  self:bind_auto_mq(Const.MSG_ON_MONKEY_TYPER_DATA_UPDATE, self.on_data_update, self)
  self:bind_auto_mq(Const.MSG_ON_MONKEY_TYPER_SIMPLE_DATA_UPDATE, self.on_simple_data_update, self)
  self:bind_auto_mq(Const.MSG_ROLE_RES_CHANGE, self.refresh_upgrade_red, self)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.BtnAwardRed, RedEnum.MONKEY_TYPER_ACT_AWARD)
  self:_refresh_asset_bar()
end

function ui:check_close(force_close)
  return NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name, true == force_close)
end

function ui:_refresh_asset_bar()
  local coin_id = ShareRes.create("activity.monkey_typewriter_misc")[self.v_activity_id].Coin
  local config = {
    {
      item_id = coin_id,
      func = "_on_click_draw_item",
      const_event = Const.MSG_ROLE_RES_CHANGE
    }
  }
  self.v_asset_bar:reset_config(config)
  self.v_asset_bar:on_create()
end

function ui:on_data_update()
  MonkeyTyperMgr:req_refresh_question(self.v_activity_id)
  self:refresh_dynamic_view()
end

function ui:on_simple_data_update()
  self:refresh_dynamic_view()
end

function ui:init_monkey_layout()
  self:clear_wrap_monkey_layout_items()
  self.v_monkey_layout_items = {}
  local layout_out = self.v_uicompents.MonkeyContent_rect.childCount
  for idx = 1, layout_out do
    local obj = self.v_uiobjects["MonkeyType" .. idx]
    if obj then
      local item = MONKEY_LAYOUT_ITEM_CLASS:ui_wrap_ex(self, obj, false)
      self.v_monkey_layout_items[idx] = item
    end
  end
end

function ui:clear_wrap_monkey_layout_items()
  if self.v_monkey_layout_items then
    for idx = #self.v_monkey_layout_items, 1, -1 do
      local item = self.v_monkey_layout_items[idx]
      item:ui_hide()
      item:ui_destroy()
      self.v_monkey_layout_items[idx] = nil
    end
    self.v_monkey_layout_items = nil
  end
end

function ui:refresh_question_info()
  local question_id, question_state = MonkeyTyperMgr:get_last_question_data(self.v_activity_id)
  local question_cfg_list = MonkeyTyperMgr:get_question_cfg_list(self.v_activity_id)
  self.v_question_id = question_id
  self.v_question_state = question_state
  self:refresh_view()
  if self.v_question_id == nil then
    self:check_story_and_play_next(question_cfg_list[1])
  elseif self.v_question_state == QUESTION_STATU.COMPLETE then
    UIMgr:get_ui("monkey_typer_question_tips"):ui_show(self.v_activity_id, self.v_question_id, true)
  elseif self.v_question_state == QUESTION_STATU.GAINED_AWARD then
    self:reset_view_to_empty()
    for _, v in ipairs(question_cfg_list) do
      if v.PreQuestionId == self.v_question_id then
        self:check_story_and_play_next(v)
        return
      end
    end
    self:set_view_to_all_over()
  end
end

function ui:check_story_and_play_next(new_question_cfg)
  local story_id = new_question_cfg.PreStoryId
  local new_question_id = new_question_cfg.QuestionId
  
  local function play_next_func()
    UIMgr:get_ui("monkey_typer_question_tips"):ui_show(self.v_activity_id, new_question_id, false)
  end
  
  if story_id then
    StoryMgr:set_story_end_cb(story_id, play_next_func)
    StoryMgr:on_start(story_id)
  else
    play_next_func()
  end
end

function ui:refresh_view()
  if self.v_question_id == nil then
    self:reset_view_to_empty()
    return
  end
  self.v_uiobjects.Progress:SetActiveEx(true)
  local cfg = ShareRes.get_monkey_typer_question_cfg(self.v_activity_id, self.v_question_id)
  self.v_target_font_count = cfg.FontCount
  self.v_uicompents.QuestionDesc_txt.text = cfg.QuestionDesc
  self.v_uicompents.TargetNum_txt.text = self.v_target_font_count
  self:refresh_dynamic_view()
end

function ui:reset_view_to_empty()
  self.v_uicompents.QuestionDesc_txt.text = "???"
  self.v_uicompents.MonkeyNum_txt.text = "???"
  self.v_uicompents.EfficiencyNum_txt.text = "???"
  self.v_uicompents.AllEfficiencyNum_txt.text = "???"
  self.v_uicompents.OverHeatDesc_txt.text = ""
  self.v_uicompents.BarFill_img.fillAmount = 0
  self.v_uicompents.OverHeatSlider_sld.value = 0
  self.v_uiobjects.Progress:SetActive(false)
  self.v_uiobjects.MonkeyContent:SetActive(false)
  self.v_uiobjects.OverHeat:SetActive(false)
  self.v_uiobjects.OverHeatBar:SetActive(true)
  self.v_uiobjects.Ani_UIMonkeyMain_Loop:SetActive(true)
end

function ui:set_view_to_all_over()
  self.v_uicompents.QuestionDesc_txt.text = "恭喜你，已经解决了所有问题"
  self:refresh_effi()
  self.v_uicompents.BarFill_img.fillAmount = 1
  self.v_uiobjects.Progress:SetActive(false)
  self.v_uiobjects.OverHeatBar:SetActive(false)
end

function ui:refresh_dynamic_view()
  self:real_time_refresh_font_progress()
  self:refresh_effi()
  self:refresh_overheat()
end

function ui:real_time_refresh_font_progress()
  self.v_target_font_count = self.v_target_font_count or 1
  local cur_font_count
  if self.v_question_state == QUESTION_STATU.COMPLETE then
    cur_font_count = self.v_target_font_count
  else
    cur_font_count = MonkeyTyperMgr:get_font_count(self.v_activity_id) or 0
  end
  self.v_uicompents.CurNum_txt.text = cur_font_count
  self.v_uicompents.BarFill_img.fillAmount = cur_font_count / self.v_target_font_count
end

function ui:refresh_effi()
  local monkey_count, monkey_layout_idx = MonkeyTyperMgr:get_upgrade_value_by_type(self.v_activity_id, UPGRADE_TYPE.MONKEY_COUNT)
  local monkey_speed = MonkeyTyperMgr:get_upgrade_value_by_type(self.v_activity_id, UPGRADE_TYPE.MONKEY_VELOCITY)
  local typer_addition = MonkeyTyperMgr:get_upgrade_value_by_type(self.v_activity_id, UPGRADE_TYPE.TYPE_WRITER_VELOCITY) / 10000
  local click_output = MonkeyTyperMgr:get_upgrade_value_by_type(self.v_activity_id, UPGRADE_TYPE.TYPE_WRITER_CLICK)
  self.v_uicompents.MonkeyNum_txt.text = monkey_count
  self.v_uicompents.EfficiencyNum_txt.text = monkey_speed
  self.v_uicompents.AllEfficiencyNum_txt.text = math.floor(monkey_count * monkey_speed * (1 + typer_addition))
  for _, txt in ipairs(self.v_click_bubble_txt) do
    txt.text = click_output
  end
  if self.v_monkey_layout_items then
    self.v_uiobjects.MonkeyContent:SetActive(true)
    for idx, monkey_layout_item in ipairs(self.v_monkey_layout_items) do
      monkey_layout_item:set_enable(monkey_layout_idx == idx)
    end
    if self.v_cur_monkey_layout_idx ~= monkey_layout_idx then
      self:refresh_bubble_item()
      self:init_bubble_data()
    end
  end
  self.v_cur_monkey_layout_idx = monkey_layout_idx
  self.v_max_count_unit_times = MonkeyTyperMgr:get_upgrade_value_by_type(self.v_activity_id, UPGRADE_TYPE.TYPE_WRITER_HOT)
  self:refresh_upgrade_red()
end

function ui:refresh_overheat()
  local counted_unit_times = MonkeyTyperMgr:get_counted_unit_times(self.v_activity_id)
  local val = counted_unit_times / self.v_max_count_unit_times
  self.v_is_overheat = val >= 1
  self.v_uiobjects.OverHeatBar:SetActive(true)
  self.v_uiobjects.OverHeat:SetActive(self.v_is_overheat)
  self.v_uiobjects.Ani_UIMonkeyMain_Loop:SetActive(not self.v_is_overheat)
  self.v_uicompents.OverHeatSlider_sld.value = val
  local overheat_type = self:get_overheat_type(val)
  for idx = 1, 3 do
    self.v_uiobjects["Fill" .. idx]:SetActiveEx(idx == overheat_type)
  end
  if self.v_is_overheat then
    self.v_uicompents.OverHeatDesc_txt.text = Util.format_str("过热停止工作")
  else
    local min = self.v_max_count_unit_times - counted_unit_times
    min = min < 0 and 1 or min
    local hour = math.floor(min / 60)
    min = min % 60
    hour = hour > 0 and hour or 0
    self.v_uicompents.OverHeatDesc_txt.text = Util.format_str("距离过热：{1}时{2}分", hour, min)
  end
end

function ui:get_overheat_type(progress)
  if progress < 0.5 then
    return 1
  elseif progress < 0.8 then
    return 2
  else
    return 3
  end
end

function ui:get_upgrade_show_list(idx)
  local type_list = UPGRADE_TYPE_LIST[idx]
  local upgrade_type_list = {}
  for _, type in ipairs(type_list) do
    local all_lv_cfg = ShareRes.get_monkey_typer_upgrade_cfg(self.v_activity_id, type)
    local cur_lv = MonkeyTyperMgr:get_level_by_type(self.v_activity_id, type)
    if all_lv_cfg[cur_lv + 1] then
      upgrade_type_list[#upgrade_type_list + 1] = {type = type, cur_lv = cur_lv}
    end
  end
  return upgrade_type_list
end

function ui:show_upgrade_view(idx)
  self:refresh_upgrade_btn_selected(idx)
  local upgrade_type_list = self:get_upgrade_show_list(idx)
  self:clear_wrap_upgrade_items()
  self.v_upgrade_item_list = {}
  self:give_back_auto_cache(EFFICIENCYUPLAYOUT_EFFICIENCYUPTEM_TEMP_KEY)
  for _, v in ipairs(upgrade_type_list) do
    local obj = self:get_auto_cache(EFFICIENCYUPLAYOUT_EFFICIENCYUPTEM_TEMP_KEY)
    local item = MONKEY_UPGRADE_ITEM_CLASS:ui_wrap_ex(self, obj, true)
    item:set_data(self.v_activity_id, v.type, true)
    self.v_upgrade_item_list[#self.v_upgrade_item_list + 1] = item
  end
end

function ui:clear_wrap_upgrade_items()
  if self.v_upgrade_item_list then
    for idx = #self.v_upgrade_item_list, 1, -1 do
      local item = self.v_upgrade_item_list[idx]
      item:ui_hide()
      item:ui_destroy()
      self.v_upgrade_item_list[idx] = nil
    end
    self.v_upgrade_item_list = nil
  end
end

function ui:refresh_upgrade_red()
  self.v_uiobjects.BtnMonkeyUpRed:SetActiveEx(self:check_can_upgrade(1))
  self.v_uiobjects.BtnMachineUpRed:SetActiveEx(self:check_can_upgrade(2))
end

function ui:refresh_upgrade_btn_selected(idx)
  self.v_uiobjects.BtnMonkeyUpSelect:SetActiveEx(1 == idx)
  self.v_uiobjects.BtnMachineUpSelect:SetActiveEx(2 == idx)
end

function ui:check_can_upgrade(idx)
  local coin_id = ShareRes.create("activity.monkey_typewriter_misc")[self.v_activity_id].Coin
  local upgrade_type_list = self:get_upgrade_show_list(idx)
  for _, v in ipairs(upgrade_type_list) do
    local all_lv_cfg = ShareRes.get_monkey_typer_upgrade_cfg(self.v_activity_id, v.type)
    local max_lv = #all_lv_cfg - 1
    local next_lv = v.cur_lv + 1
    if max_lv < next_lv then
    else
      local next_lv_cfg = all_lv_cfg[next_lv]
      local can_upgrade
      if next_lv_cfg.Condition then
        can_upgrade = Condition:check_condition(next_lv_cfg.Condition)
      else
        local own_num = BagMgr:get_item_num(coin_id)
        can_upgrade = own_num >= next_lv_cfg.ConsumeItemCount
      end
      if can_upgrade then
        return true
      end
    end
  end
  return false
end

function ui:init_bubble_data()
  self.v_hold_duration, self.v_interval_min, self.v_interval_max = self:get_bubble_hold_param()
  self.v_random_monkey_range = self:get_bubble_length()
  if not self.v_current_timer then
    self.v_current_timer = 0
  end
  if not self.v_next_random_interval then
    self.v_next_random_interval = math.random(self.v_interval_min, self.v_interval_max) / 10
  end
  self.v_holding_numbers = {}
  for i = 1, self.v_random_monkey_range do
    self.v_holding_numbers[i] = false
  end
  self.v_hold_times = {}
end

function ui:ui_update(delta_time)
  if not self.v_random_monkey_range or 0 == self.v_random_monkey_range then
    return
  end
  self:update_hold_times(delta_time)
  self.v_current_timer = self.v_current_timer + delta_time
  if self.v_current_timer >= self.v_next_random_interval then
    self.v_current_timer = 0
    local random_number = self:get_random_number()
    if random_number then
      self:hold_number(random_number)
    else
      print("No available numbers to hold.")
    end
    self.v_next_random_interval = math.random(self.v_interval_min, self.v_interval_max) / 10
  end
end

function ui:get_random_number()
  local available_numbers = {}
  for i = 1, self.v_random_monkey_range do
    if not self.v_holding_numbers[i] then
      table.insert(available_numbers, i)
    end
  end
  if #available_numbers > 0 then
    return available_numbers[math.random(1, #available_numbers)]
  else
    return nil
  end
end

function ui:hold_number(num)
  self.v_holding_numbers[num] = true
  self.v_hold_times[num] = 0
  self:play_bubble(num)
end

function ui:update_hold_times(deltaTime)
  for num, hold_time in pairs(self.v_hold_times) do
    self.v_hold_times[num] = hold_time + deltaTime
    if self.v_hold_times[num] >= self.v_hold_duration then
      self.v_holding_numbers[num] = false
      self.v_hold_times[num] = nil
      self:release_bubble(num)
    end
  end
end

function ui:refresh_bubble_item()
  local _, monkey_layout_idx = MonkeyTyperMgr:get_upgrade_value_by_type(self.v_activity_id, UPGRADE_TYPE.MONKEY_COUNT)
  self:give_back_auto_cache(BUBBLECONTENT_BUBBLETEM_TEMP_KEY)
  local layout_item = self.v_monkey_layout_items[monkey_layout_idx]
  local monkey_obj_count = self.v_uicompents["MonkeyType" .. monkey_layout_idx .. "_rect"].childCount
  self.v_monkey_layout_idx = monkey_layout_idx
  self:clear_wrap_bubble_items()
  self.v_bubble_item_list = {}
  for index = 1, monkey_obj_count do
    local bubble_root_trans = layout_item:get_bubble_root(index)
    if bubble_root_trans then
      local obj = self:get_auto_cache(BUBBLECONTENT_BUBBLETEM_TEMP_KEY)
      obj.transform.position = bubble_root_trans.position
      local item = MONKEY_BUBBLE_ITEM_CLASS:ui_wrap_ex(self, obj, false)
      item:set_data(self.v_activity_id, index)
      self.v_bubble_item_list[#self.v_bubble_item_list + 1] = item
    end
  end
end

function ui:get_bubble_hold_param()
  local lv = MonkeyTyperMgr:get_level_by_type(self.v_activity_id, UPGRADE_TYPE.MONKEY_COUNT)
  local cfg = ShareRes.create("activity.monkey_typewriter_random")[lv]
  if not cfg then
    return 1, 100, 100
  end
  return cfg.Duration / 10, cfg.MinInterval, cfg.MaxInterval
end

function ui:get_bubble_length()
  if self.v_bubble_item_list then
    return #self.v_bubble_item_list
  end
  return 0
end

function ui:play_bubble(idx)
  if not self.v_is_overheat and self.v_bubble_item_list and self.v_bubble_item_list[idx] then
    self.v_bubble_item_list[idx]:do_play()
    self.v_monkey_layout_items[self.v_monkey_layout_idx]:shake_monkey(idx)
  end
end

function ui:release_bubble(idx)
  if self.v_bubble_item_list and self.v_bubble_item_list[idx] then
    self.v_bubble_item_list[idx]:set_enable(false)
  end
end

function ui:clear_wrap_bubble_items()
  if self.v_bubble_item_list then
    for idx = #self.v_bubble_item_list, 1, -1 do
      local item = self.v_bubble_item_list[idx]
      item:ui_hide()
      item:ui_destroy()
      self.v_bubble_item_list[idx] = nil
    end
    self.v_bubble_item_list = nil
  end
end

function ui:play_click_bubble()
  for index = 1, 3 do
    if not self.v_click_bubble_obj[index].activeSelf then
      self.v_click_bubble_obj[index]:SetActive(true)
      return
    end
  end
end

return ui
