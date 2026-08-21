local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local _tinsert = table.insert
ui.game_fsm = {
  INIT_GAME = {
    into_func = "game_fsm_INIT_GAME_into_func",
    update_func = "game_fsm_INIT_GAME_update_func",
    out_func = nil,
    target_fsm_name = nil
  },
  IN_GAME = {
    into_func = "game_fsm_IN_GAME_into_func",
    update_func = "game_fsm_IN_GAME_update_func",
    out_func = nil,
    target_fsm_name = nil
  },
  PASUE_GAME = {
    into_func = "game_fsm_PAUSE_GAME_into_func",
    update_func = nil,
    out_func = "game_fsm_PAUSE_GAME_out_func",
    target_fsm_name = nil
  },
  END_GAME = {
    into_func = "game_fsm_END_GAME_into_func",
    update_func = nil,
    out_func = nil,
    target_fsm_name = nil
  },
  FSM_STATE_SAVE = {cur_fsm = "INIT_GAME", first_fsm = "INIT_GAME"}
}
ui.fish_fsm = {
  FISH_WAIT = {
    into_func = "fish_fsm_FISH_WAIT_into_func",
    update_func = "fish_fsm_FISH_WAIT_update_func",
    out_func = "fish_fsm_FISH_WAIT_out_func",
    target_fsm_name = nil
  },
  FISH_DOWN = {
    into_func = "fish_fsm_FISH_DOWN_into_func",
    update_func = "fish_fsm_FISH_DOWN_update_func",
    out_func = nil,
    target_fsm_name = nil
  },
  FISH_UP = {
    into_func = "fish_fsm_FISH_UP_into_func",
    update_func = "fish_fsm_FISH_UP_update_func",
    out_func = nil,
    target_fsm_name = nil
  },
  FISH_PAUSE = {
    into_func = nil,
    update_func = nil,
    out_func = nil,
    target_fsm_name = nil
  },
  FISH_END = {
    into_func = nil,
    update_func = nil,
    out_func = nil,
    target_fsm_name = nil
  },
  FSM_STATE_SAVE = {cur_fsm = "FISH_WAIT", first_fsm = "FISH_WAIT"}
}
ui.fsm_list = {
  game_fsm = ui.game_fsm,
  fish_fsm = ui.fish_fsm
}
ui.fsm_sequence = {
  [1] = "game_fsm",
  [2] = "fish_fsm"
}
ui.fsm_sequence2 = {
  [1] = "fish_fsm",
  [2] = "game_fsm"
}
ui.all_cfg_save = {
  fishing_rod_cfg = nil,
  cur_use_fishing_rod_cfg = nil,
  item_cfg = nil,
  stage_cfg = nil,
  emj_cfg = nil,
  con_star_cfg = nil
}
ui.all_item_list = {}
ui.control_param_save = {
  fishing_rod_rot = 0,
  fishing_rod_rot_lerp = 0.5,
  fishing_rod_ori_height = 1,
  fishing_rod_cur_height = 1,
  fishing_rod_start_height = 1,
  fish_rod_rot_lerp_timeoffset = 0,
  fish_rod_rot_lerp_timetemp = 0,
  fish_down_up_time = 0,
  fish_wait_time = 0,
  fish_wait_slerp = 1,
  no_fish_count = 0,
  have_fish = false,
  fish_up_weight = 1,
  use_time_offset = 0,
  fish_emj_time = 0,
  fish_emj_state = nil,
  fish_emj_time_out = true,
  pre_game_state = "IN_GAME",
  pre_fish_state = "FISH_WAIT",
  cur_count = 0,
  cur_get_fish = 0,
  cur_get_fish_time = 0,
  cur_get_fish_show = false,
  cur_fish_all_count = {},
  cur_fish_count = {},
  cur_use_time = 0,
  cur_fish_notouch_count = {},
  is_success = false,
  con_star = {
    false,
    false,
    false
  },
  show_dash_line = false,
  wait_time = 0
}
local UI_FISH_GAME_TEM_KEY = "UI_FISH_GAME_TEM_KEY"
local item_state = {
  NoObjState = 0,
  NoramalState = 1,
  UpState = 2,
  GetState = 3,
  IdleState = 4,
  BomState = 5
}
local EFFECT_TYPE = {NORMAL_TYPE = 1, EXPLODE_TYPE = 2}
local START_EFF_TIME = 1.5
local EMJ_STATE = {
  Emoji1 = 1,
  Emoji2 = 2,
  Emoji3 = 3
}
local START_USE_ICON = {
  [1] = false,
  [2] = false,
  [3] = true,
  [4] = false,
  [5] = true
}
local normal_color = Util.get_unity_color_by_hex(tonumber("1d578c", 16))
local red_color = Util.get_unity_color_by_hex(tonumber("ff0000", 16))
local normal_con_color = Util.get_unity_color_by_hex(tonumber("292929", 16))
local rev_con_color = Util.get_unity_color_by_hex(tonumber("476dbb", 16))
local Ease = CS.DG.Tweening.Ease

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:on_click_ret()
  end)
  self:set_button("ClickButton", function()
    self:on_click_start_fish()
  end)
  self:set_button("BtnContinue", function()
    self:on_click_continue()
  end)
  self:set_button("BtnExit", function()
    self:on_click_exit()
  end)
  self:set_button("BtnReStart", function()
    self:on_click_restart()
  end)
  self:set_button("UnfoldBtn", function()
    if self.v_uiobjects.IntegralGroup.activeSelf then
      self.v_uiobjects.IntegralGroup:SetActive(false)
      self.v_uiobjects.TitleText:SetActive(true)
      self.v_uiobjects.Ani_Mask_In:SetActive(false)
      self.v_uiobjects.Ani_Mask_Out:SetActive(false)
      self.v_uiobjects.Ani_Mask_In:SetActive(true)
    else
      self.v_uiobjects.IntegralGroup:SetActive(true)
      self.v_uiobjects.TitleText:SetActive(false)
      self.v_uiobjects.Ani_Mask_In:SetActive(false)
      self.v_uiobjects.Ani_Mask_Out:SetActive(false)
      self.v_uiobjects.Ani_Mask_Out:SetActive(true)
    end
  end)
  self.v_uiobjects.ShrinkBtn:SetActive(false)
  self.v_hool = {}
  local judge_area = self.v_uiobjects.Hool
  if nil ~= judge_area then
    local chirld_len = judge_area.transform.childCount
    for i = 0, chirld_len - 1 do
      local item_obj = judge_area.transform:GetChild(i)
      _tinsert(self.v_hool, self:get_rect_transform(nil, item_obj))
    end
  end
  self:register_exist_auto_template(UI_FISH_GAME_TEM_KEY, self.v_uiobjects.Item, self.v_uiobjects.ItemSource)
end

function ui:ui_on_show(data, data_list, data_index)
  self.v_stage_data = data
  self.v_stage_list = data_list
  self.v_stage_index = data_index
  self:first_fsm()
end

function ui:ui_on_update(delta_time)
  self:update_fsm(delta_time)
end

function ui:first_fsm()
  for idx, fsm_name in ipairs(self.fsm_sequence) do
    local fsm = self.fsm_list[fsm_name]
    self:switch_fsm(fsm, nil, fsm.FSM_STATE_SAVE.first_fsm)
  end
end

function ui:update_fsm(delta_time)
  for idx, fsm_name in ipairs(self.fsm_sequence) do
    local fsm = self.fsm_list[fsm_name]
    local cur_fsm = fsm[fsm.FSM_STATE_SAVE.cur_fsm]
    if cur_fsm.update_func ~= nil then
      self[cur_fsm.update_func](self, delta_time)
    end
  end
end

function ui:switch_fsm(fsm, cur_fsm_name, target_fsm_name, not_into)
  fsm.FSM_STATE_SAVE.cur_fsm = target_fsm_name
  if cur_fsm_name then
    local cur_fsm = fsm[cur_fsm_name]
    if cur_fsm.out_func ~= nil then
      self[cur_fsm.out_func](self)
    end
  end
  local target_fsm = fsm[target_fsm_name]
  if nil ~= target_fsm.into_func and not not_into then
    self[target_fsm.into_func](self)
  end
end

function ui:ui_on_hide()
  local stage_ui = UIMgr:try_get_visible_ui("fish_game_stage")
  if stage_ui then
    stage_ui:check_close()
  end
end

function ui:ui_on_destroy()
end

function ui:lerp_value(a_min, b_max, t)
  t = math.max(0, math.min(1, t))
  return (b_max - a_min) * t + a_min
end

function ui:pinpong_value(start_time, duration, offset)
  offset = offset or 0
  local elapsed = Global.real_time - start_time + offset
  local t = elapsed % (duration * 2) / duration
  return 1.0 - math.abs(t - 1.0), elapsed
end

function ui:to_value(start_val, end_val, duration, start_time)
  local elapsed = Global.real_time - start_time
  local t = elapsed / duration
  local lerp_val = math.min(t, 1.0)
  return self:lerp_value(start_val, end_val, lerp_val)
end

function ui:on_click_ret()
  if self.game_fsm.FSM_STATE_SAVE.cur_fsm == "END_GAME" then
    return
  end
  self.control_param_save.pre_fish_state = self.fish_fsm.FSM_STATE_SAVE.cur_fsm
  self.control_param_save.pre_game_state = self.game_fsm.FSM_STATE_SAVE.cur_fsm
  self:switch_fsm(self.game_fsm, self.game_fsm.FSM_STATE_SAVE.cur_fsm, "PASUE_GAME")
  self:switch_fsm(self.fish_fsm, self.fish_fsm.FSM_STATE_SAVE.cur_fsm, "FISH_PAUSE")
  self.v_uiobjects.Pause:SetActive(true)
end

function ui:on_click_start_fish()
  if self.game_fsm.FSM_STATE_SAVE.cur_fsm == "IN_GAME" and self.fish_fsm.FSM_STATE_SAVE.cur_fsm == "FISH_WAIT" and Global.real_time - self.control_param_save.wait_time > 0.1 then
    self:switch_fsm(self.fish_fsm, self.fish_fsm.FSM_STATE_SAVE.cur_fsm, "FISH_DOWN")
  end
end

function ui:on_click_continue()
  self:switch_fsm(self.game_fsm, self.game_fsm.FSM_STATE_SAVE.cur_fsm, self.control_param_save.pre_game_state, true)
  local not_into = true
  if self.control_param_save.pre_fish_state == "FISH_WAIT" then
    not_into = false
  end
  self:switch_fsm(self.fish_fsm, self.fish_fsm.FSM_STATE_SAVE.cur_fsm, self.control_param_save.pre_fish_state, not_into)
end

function ui:on_click_exit()
  self.v_uiobjects.Pause:SetActive(false)
  self.v_uicompents.Line_rect:SetSizeDeltaHeightA(self.control_param_save.fishing_rod_start_height)
  self:switch_fsm(self.fish_fsm, self.fish_fsm.FSM_STATE_SAVE.cur_fsm, "FISH_END")
  self:switch_fsm(self.game_fsm, self.game_fsm.FSM_STATE_SAVE.cur_fsm, "END_GAME", true)
  self:ui_hide()
end

function ui:on_click_restart()
  self:give_back_auto_cache(UI_FISH_GAME_TEM_KEY)
  self.v_uicompents.Line_rect:SetSizeDeltaHeightA(self.control_param_save.fishing_rod_start_height)
  self:first_fsm()
end

function ui:on_click_BtnNext()
  local next_stage_cfg, stage_next_index = self:get_next_stage()
  if nil == next_stage_cfg then
    return
  end
  self.v_stage_data = next_stage_cfg
  self.v_stage_index = stage_next_index
  self:on_click_restart()
end

function ui:close_all_chirld(obj)
  if Util.is_nil(obj) then
    return
  end
  local chirld_len = obj.gameObject.transform.childCount
  for i = 0, chirld_len - 1 do
    local item_obj = obj.gameObject.transform:GetChild(i)
    item_obj:SetActive(false)
  end
end

function ui:all_cfg_save_INIT_FUNC()
  self.all_cfg_save.fishing_rod_cfg = ShareRes.get_fish_game_fishtool()
  self.all_cfg_save.cur_use_fishing_rod_cfg = self.all_cfg_save.fishing_rod_cfg[self.v_stage_data.PosIdList]
  self.all_cfg_save.item_cfg = ShareRes.get_fish_game_item()
  self.all_cfg_save.emj_cfg = ShareRes.get_fish_game_emj_cfg()
  local stage_cfg_temp = ShareRes.get_fish_game_stage_item_cfg()
  self.all_cfg_save.stage_cfg = {}
  for idx, data in pairs(stage_cfg_temp) do
    if self.v_stage_data.Id == data.EpisodeId then
      _tinsert(self.all_cfg_save.stage_cfg, data)
    end
  end
  self.all_cfg_save.con_star_cfg = {}
  for star_con_idx, star_con_id in ipairs(self.v_stage_data.StarScore) do
    self.all_cfg_save.con_star_cfg[star_con_idx] = ShareRes.get_fish_game_cond_cfg(star_con_id)
  end
end

function ui:all_item_list_INIT_FUNC()
  self.all_item_list = {}
  for idx, data in pairs(self.all_cfg_save.stage_cfg) do
    local item_detail = self.all_cfg_save.item_cfg[data.IconId]
    local cfg = {
      item_cfg = data,
      item_detail = item_detail,
      cur_state = item_state.NoObjState,
      cur_item_gameObject = nil,
      cur_item_rect = nil,
      cur_use_item = nil,
      cur_use_item_rect = nil,
      cur_use_judge = nil,
      cur_bom_judge = nil,
      cur_pos = nil,
      cur_use_icon = nil,
      cur_use_icon_img = nil,
      gen_start_time = 0,
      cur_get_icon = nil,
      bom_start_time = nil,
      value_start_time = nil,
      value_item = nil,
      value_show_state = true,
      bom_sequence = nil,
      cur_item_cvs = nil
    }
    _tinsert(self.all_item_list, cfg)
  end
end

function ui:game_fsm_INIT_GAME_into_func()
  self.v_start_time = Global.real_time
  self.v_start_game_time = nil
  local width = -1
  width, self.control_param_save.fishing_rod_start_height = self.v_uicompents.Line_rect:GetSizeDeltaA()
  self:all_cfg_save_INIT_FUNC()
  self:all_item_list_INIT_FUNC()
  self.control_param_save.fishing_rod_rot = self.all_cfg_save.cur_use_fishing_rod_cfg.Angle
  CSHelper.SetRectTransLocalRot(self.v_uicompents.Line_rect, 0, 0, self.control_param_save.fishing_rod_rot)
  self.control_param_save.fish_rod_rot_lerp_timeoffset = self.all_cfg_save.cur_use_fishing_rod_cfg.RotationSpeed
  self.control_param_save.fishing_rod_cur_height = self.control_param_save.fishing_rod_start_height
  self.v_uiobjects.StarTips:SetActive(true)
  self.v_uicompents.CountDownText_txt.text = string.format("%ss", self.v_stage_data.Duration)
  self.v_uiobjects.Pause:SetActive(false)
  self.v_uiobjects.EmojiGroup:SetActive(false)
  self.control_param_save.no_fish_count = 0
  self.control_param_save.show_dash_line = false
  self.control_param_save.cur_count = 0
  self.control_param_save.is_success = false
  self.control_param_save.cur_fish_count = {}
  self.control_param_save.cur_fish_all_count = {}
  self.control_param_save.cur_fish_notouch_count = {}
  self.control_param_save.con_star = {
    false,
    false,
    false
  }
  self:set_cond_start()
  self.v_uiobjects.UnfoldBtn:SetActive(true)
  self.v_uiobjects.ShrinkBtn:SetActive(false)
  self.v_uiobjects.Bg:SetActive(true)
  self.v_uiobjects.TargetContent:SetActive(true)
  self.v_uiobjects.IntegralGroup:SetActive(false)
  self.v_uiobjects.TitleText:SetActive(true)
  self.v_uicompents.CurrentStar_txt.text = self.control_param_save.cur_count
  self.v_uiobjects.IntegralTips:SetActive(false)
  self.v_uiobjects.Ani_Mask_In:SetActive(false)
  self.v_uiobjects.Ani_Mask_Out:SetActive(false)
  self.v_uiobjects.Ani_Mask_In:SetActive(true)
  self.v_uicompents.CountDownText_txt.color = normal_color
  self.v_uiobjects.Ani_CountDownText_Red:SetActive(false)
  self.v_uiobjects.Fx_CharGlow:SetActive(false)
  self.v_score_tipx, self.v_score_tipy = self.v_uicompents.IntegralTips_rect:GetAnchoredPositionA()
  self.control_param_save.wait_time = Global.real_time
  self.v_uicompents.CountDownText_rect:SetLocalScaleA(1, 1, 1)
  local ACT_ID = NoviceMgr:get_fish_game_act_id()
  NoviceMgr:set_fish_game_red(ACT_ID, self.v_stage_data.Id)
end

function ui:game_fsm_INIT_GAME_update_func()
  if Global.real_time - self.v_start_time > START_EFF_TIME then
    self.v_uiobjects.StarTips:SetActive(false)
    self:switch_fsm(self.game_fsm, self.game_fsm.FSM_STATE_SAVE.cur_fsm, "IN_GAME")
  end
end

function ui:game_fsm_IN_GAME_into_func()
  self.v_start_game_time = Global.real_time
end

function ui:game_fsm_IN_GAME_update_func(delta_time)
  self:update_fish_emj()
  self:update_items(delta_time)
  self:gen_items()
  self:fish_judging()
  self:time_judging()
  self:item_judging()
  self:update_cond_start()
  self:update_get_sorce()
  self:update_value_sorce()
end

function ui:game_fsm_END_GAME_into_func()
  UIMgr:get_ui("fish_game_battle_settle"):ui_show(self)
end

function ui:game_fsm_PAUSE_GAME_into_func()
  self.v_start_pause_time = Global.real_time
end

function ui:game_fsm_PAUSE_GAME_out_func()
  if self.v_start_game_time then
    self.v_start_game_time = self.v_start_game_time + Global.real_time - self.v_start_pause_time
    self.control_param_save.use_time_offset = self.control_param_save.use_time_offset + Global.real_time - self.v_start_pause_time
  end
  self.v_uiobjects.Pause:SetActive(false)
end

function ui:fish_fsm_FISH_WAIT_into_func()
  self.control_param_save.fish_wait_time = Global.real_time
  if self.control_param_save.have_fish then
    self.control_param_save.cur_get_fish_time = Global.real_time
  end
  if self.control_param_save.no_fish_count >= self.all_cfg_save.cur_use_fishing_rod_cfg.Hint or self.control_param_save.show_dash_line then
    self.control_param_save.show_dash_line = true
    self.v_uiobjects.Dashed_Line:SetActive(true)
  else
    self.v_uiobjects.Dashed_Line:SetActive(false)
  end
end

function ui:fish_fsm_FISH_WAIT_update_func(delta_time)
  self.control_param_save.fishing_rod_rot_lerp, self.control_param_save.fish_rod_rot_lerp_timetemp = self:pinpong_value(self.control_param_save.fish_wait_time, self.all_cfg_save.cur_use_fishing_rod_cfg.RotationSpeed, self.control_param_save.fish_rod_rot_lerp_timeoffset)
  self.control_param_save.fishing_rod_rot = self:lerp_value(self.all_cfg_save.cur_use_fishing_rod_cfg.AngleMin, self.all_cfg_save.cur_use_fishing_rod_cfg.AngleMax, self.control_param_save.fishing_rod_rot_lerp)
  CSHelper.SetRectTransLocalRot(self.v_uicompents.Line_rect, 0, 0, self.control_param_save.fishing_rod_rot)
end

function ui:fish_fsm_FISH_WAIT_out_func()
  self.control_param_save.fish_rod_rot_lerp_timeoffset = self.control_param_save.fish_rod_rot_lerp_timetemp
end

function ui:fish_fsm_FISH_DOWN_into_func()
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_fish_game_down_UI_SOUND)
  self.v_uiobjects.Fx_CharGlow:SetActive(false)
  self.v_uiobjects.Fx_CharGlow:SetActive(true)
  self.v_uiobjects.Dashed_Line:SetActive(false)
  local width = -1
  width, self.control_param_save.fishing_rod_ori_height = self.v_uicompents.Line_rect:GetSizeDeltaA()
  self.control_param_save.fish_down_up_time = Global.real_time
  self.control_param_save.have_fish = false
end

function ui:fish_fsm_FISH_DOWN_update_func(delta_time)
  local set_value = self.control_param_save.fishing_rod_cur_height + delta_time * self.all_cfg_save.cur_use_fishing_rod_cfg.LaunchSpeed * 10
  self.v_uicompents.Line_rect:SetSizeDeltaHeightA(set_value)
  self.control_param_save.fishing_rod_cur_height = set_value
  CSHelper.SetRectTransLocalRot(self.v_uicompents.Wheel_rect, 0, 0, set_value)
  if not CSHelper.RectOverlapJudge(self.v_uicompents.BoundaryArea_rect, self.v_uicompents.Hool_rect) or set_value > self.all_cfg_save.cur_use_fishing_rod_cfg.MaximumDistance then
    self:switch_fsm(self.fish_fsm, self.fish_fsm.FSM_STATE_SAVE.cur_fsm, "FISH_UP")
  end
end

function ui:fish_fsm_FISH_UP_into_func()
  self.control_param_save.fishing_rod_ori_height = self.control_param_save.fishing_rod_cur_height
  self.control_param_save.fish_down_up_time = Global.real_time
  if not self.control_param_save.have_fish then
    self.control_param_save.no_fish_count = self.control_param_save.no_fish_count + 1
    self.control_param_save.fish_up_weight = 1
  else
    self.control_param_save.no_fish_count = 0
  end
  local temp_dict = {}
  for idx, data in pairs(self.all_item_list) do
    if data.cur_state == item_state.NoramalState and not temp_dict[data.item_detail.ItemType] then
      self.control_param_save.cur_fish_notouch_count[data.item_detail.ItemType] = self.control_param_save.cur_fish_notouch_count[data.item_detail.ItemType] or 0
      self.control_param_save.cur_fish_notouch_count[data.item_detail.ItemType] = self.control_param_save.cur_fish_notouch_count[data.item_detail.ItemType] + 1
      temp_dict[data.item_detail.ItemType] = true
    end
    if data.cur_state == item_state.UpState then
      self.control_param_save.cur_fish_notouch_count[data.item_detail.ItemType] = 0
    end
  end
end

function ui:fish_fsm_FISH_UP_update_func(delta_time)
  local set_value = self.control_param_save.fishing_rod_cur_height - delta_time * (self.all_cfg_save.cur_use_fishing_rod_cfg.RecyclingSpeed / self.control_param_save.fish_up_weight) * 10
  self.v_uicompents.Line_rect:SetSizeDeltaHeightA(set_value)
  self.control_param_save.fishing_rod_cur_height = set_value
  CSHelper.SetRectTransLocalRot(self.v_uicompents.Wheel_rect, 0, 0, set_value)
  if set_value <= self.control_param_save.fishing_rod_start_height then
    self:switch_fsm(self.fish_fsm, self.fish_fsm.FSM_STATE_SAVE.cur_fsm, "FISH_WAIT")
    self.control_param_save.wait_time = Global.real_time
  end
end

function ui:gen_items()
  for idx, data in pairs(self.all_item_list) do
    local gen_time
    local start_time = self.v_start_game_time
    if data.cur_state == item_state.NoObjState then
      gen_time = data.item_cfg.StarTime
    elseif data.cur_state == item_state.IdleState then
      gen_time = data.item_cfg.Interval
      start_time = data.gen_start_time
    end
    if nil ~= gen_time and gen_time <= Global.real_time - start_time then
      data.cur_item_gameObject = self:get_auto_cache(UI_FISH_GAME_TEM_KEY)
      data.cur_item_rect = self:get_rect_transform(nil, data.cur_item_gameObject)
      data.cur_item_rect:SetAnchoredPositionA(0, 0)
      data.value_start_time = Global.real_time
      data.value_show_state = true
      self:set_item(data.cur_item_gameObject, data)
      data.cur_state = item_state.NoramalState
    end
  end
end

function ui:set_item(target_obj, data)
  self:close_all_chirld(target_obj)
  local use_item = Util.get_child_gameobj(data.item_detail.ItemTem, target_obj)
  local use_item_rect = self:get_rect_transform(nil, use_item)
  local use_item_num = Util.get_text("Bg/IntegralNum", use_item)
  local Bg = Util.get_child_gameobj("Bg", use_item)
  use_item:SetActive(true)
  data.cur_use_item = use_item
  data.cur_use_item_rect = use_item_rect
  CSHelper.SetRectTransLocalRot(data.cur_item_rect, 0, 0, 0)
  CSHelper.SetRectTransLocalRot(data.cur_use_item_rect, 0, 0, 0)
  data.value_item = Bg
  data.cur_use_judge = {}
  local judge_area = Util.get_child_gameobj("Icon/JudgeArea", use_item)
  if nil ~= judge_area then
    local chirld_len = judge_area.transform.childCount
    for i = 0, chirld_len - 1 do
      local item_obj = judge_area.transform:GetChild(i)
      _tinsert(data.cur_use_judge, self:get_rect_transform(nil, item_obj))
    end
  else
    data.cur_use_judge = nil
  end
  data.cur_bom_judge = {}
  local cur_bom_judge = Util.get_child_gameobj("BomArea", use_item)
  if nil ~= cur_bom_judge then
    local chirld_len = cur_bom_judge.transform.childCount
    for i = 0, chirld_len - 1 do
      local item_obj = cur_bom_judge.transform:GetChild(i)
      _tinsert(data.cur_bom_judge, self:get_rect_transform(nil, item_obj))
    end
  else
    data.cur_bom_judge = nil
  end
  local eff = Util.get_child_gameobj("Fx_BomGlow", data.cur_use_item)
  if eff then
    eff:SetActive(false)
  end
  local eff2 = Util.get_child_gameobj("Fx_BomGlowLoop", data.cur_use_item)
  if eff2 then
    eff2:SetActive(true)
  end
  local eff3 = Util.get_child_gameobj("Fx_BirdGlow", data.cur_use_item)
  if eff3 then
    eff3:SetActive(true)
  end
  local tips_obj = self:get_rect_transform("IntegralIconTips", target_obj)
  if tips_obj then
    tips_obj:SetActive(false)
    tips_obj:SetAnchoredPositionA(0, 0)
  end
  local cur_use_icon = self:get_rect_transform("Icon", use_item)
  if nil ~= data.cur_pos and nil ~= data.cur_pos.init_scale_x then
    cur_use_icon:SetLocalScaleA(data.cur_pos.init_scale_x or 1, data.cur_pos.init_scale_y or 1, data.cur_pos.init_scale_z or 1)
  end
  local init_scale_x, init_scale_y, init_scale_z = cur_use_icon:GetLocalScaleA3()
  data.cur_use_icon = cur_use_icon
  local cur_get_icon = self:get_rect_transform("Icon/GetIcon", use_item)
  data.cur_get_icon = cur_get_icon
  if cur_get_icon then
    cur_get_icon:SetActive(false)
  end
  local cur_use_icon_img = self:get_image("Icon", use_item)
  data.cur_use_icon_img = cur_use_icon_img
  cur_use_icon_img.enabled = true
  use_item_rect:SetAnchoredPositionA(data.item_cfg.PosIdList[1], data.item_cfg.PosIdList[2])
  if nil ~= use_item_num then
    if data.item_detail.EffectType == EFFECT_TYPE.NORMAL_TYPE and nil ~= data.item_detail.DurationTime then
      use_item_num.text = data.item_detail.ItemEffect[1]
      Bg:SetActive(true)
    else
      use_item_num.text = ""
      Bg:SetActive(false)
    end
  end
  local set_scale = data.item_detail.IconSize
  use_item_rect:SetLocalScaleA(set_scale, set_scale, set_scale)
  if data.item_detail.MoveSpeed > 0 then
    use_item_rect:SetAnchoredPositionA(data.item_detail.MoveArea[1], data.item_cfg.PosIdList[2])
    local speed = 0
    if data.item_detail.MoveArea[1] < data.item_detail.MoveArea[2] then
      speed = 1
    else
      speed = -1
    end
    data.cur_pos = {
      x = data.item_detail.MoveArea[1],
      y = data.item_cfg.PosIdList[2],
      speed = speed,
      init_speed = speed,
      init_scale_x = init_scale_x,
      init_scale_y = init_scale_y,
      init_scale_z = init_scale_z
    }
    if speed > 0 then
      cur_use_icon:SetLocalScaleA(data.cur_pos.init_scale_x, data.cur_pos.init_scale_y, data.cur_pos.init_scale_z)
    else
      cur_use_icon:SetLocalScaleA(data.cur_pos.init_scale_x * -1, data.cur_pos.init_scale_y, data.cur_pos.init_scale_z)
    end
  else
    data.cur_pos = {
      x = data.item_cfg.PosIdList[1],
      y = data.item_cfg.PosIdList[2],
      speed = nil,
      init_speed = nil,
      init_scale_x = init_scale_x,
      init_scale_y = init_scale_y,
      init_scale_z = init_scale_z
    }
  end
  data.cur_item_cvs = self:get_canvas_group(nil, data.cur_use_item)
  data.cur_item_cvs.alpha = 1
end

function ui:update_items(delta_time)
  for idx, data in pairs(self.all_item_list) do
    if data.cur_state == item_state.NoramalState then
      self:update_normalstate_item(data, delta_time)
    elseif data.cur_state == item_state.UpState then
      self:update_upstate_item(data)
    elseif data.cur_state == item_state.GetState then
      self:update_getstate_item(data)
    elseif data.cur_state == item_state.BomState then
      self:update_bomstate_item(data)
    end
  end
end

function ui:update_normalstate_item(data, delta_time)
  CSHelper.SetRectTransLocalRot(data.cur_item_rect.component, 0, 0, 0)
  CSHelper.SetRectTransLocalRot(data.cur_use_item_rect.component, 0, 0, 0)
  if data.item_detail.MoveSpeed <= 0 then
    return
  end
  local use_item_rect = data.cur_use_item_rect
  local cur_use_icon = data.cur_use_icon
  local add = -1
  local pos = data.cur_pos
  local speed = pos.speed
  if pos.init_speed > 0 then
    if pos.x <= data.item_detail.MoveArea[1] - 1 then
      speed = 1
      cur_use_icon:SetLocalScaleA(pos.init_scale_x, pos.init_scale_y, pos.init_scale_z)
    end
    if pos.x >= data.item_detail.MoveArea[2] + 1 then
      if 2 == data.item_detail.MoveType then
        speed = -1
        cur_use_icon:SetLocalScaleA(pos.init_scale_x * -1, pos.init_scale_y, pos.init_scale_z)
      else
        speed = 1
        if data.cur_use_judge ~= nil then
          local is_in_area = false
          for _, judge_obj in pairs(data.cur_use_judge) do
            if CSHelper.RectOverlapJudgeWithRot(judge_obj.component, self.v_uicompents.BoundaryArea_rect) then
              is_in_area = true
              break
            end
          end
          if not is_in_area then
            self:set_item_idle(data)
          end
        end
      end
    end
  else
    if pos.x >= data.item_detail.MoveArea[1] + 1 then
      speed = -1
      cur_use_icon:SetLocalScaleA(pos.init_scale_x * -1, pos.init_scale_y, pos.init_scale_z)
    end
    if pos.x <= data.item_detail.MoveArea[2] - 1 then
      if 2 == data.item_detail.MoveType then
        speed = 1
        cur_use_icon:SetLocalScaleA(pos.init_scale_x, pos.init_scale_y, pos.init_scale_z)
      else
        speed = -1
        if data.cur_use_judge ~= nil then
          local is_in_area = false
          for _, judge_obj in pairs(data.cur_use_judge) do
            if CSHelper.RectOverlapJudgeWithRot(judge_obj.component, self.v_uicompents.BoundaryArea_rect) then
              is_in_area = true
              break
            end
          end
          if not is_in_area then
            self:set_item_idle(data)
          end
        end
      end
    end
  end
  pos.speed = speed
  pos.x = pos.x + speed * delta_time * data.item_detail.MoveSpeed
  use_item_rect:SetAnchoredPositionA(pos.x, pos.y)
end

function ui:update_upstate_item(data)
  if self.fish_fsm.FSM_STATE_SAVE.cur_fsm == "FISH_UP" then
    if data.cur_get_icon then
      data.cur_get_icon:SetActive(true)
      data.cur_use_icon_img.enabled = false
    end
    if data.item_detail.EffectType == EFFECT_TYPE.EXPLODE_TYPE then
      data.cur_use_icon:SetActive(false)
      data.cur_state = item_state.BomState
      data.bom_start_time = Global.real_time
      self:item_explode_effect(data)
    end
  end
  if self.fish_fsm.FSM_STATE_SAVE.cur_fsm == "FISH_WAIT" then
    self:set_item_get(data)
  end
end

function ui:update_getstate_item(data)
  if self.game_fsm.FSM_STATE_SAVE.cur_fsm == "IN_GAME" then
    data.gen_start_time = Global.real_time
    data.cur_state = item_state.IdleState
    if data.item_detail.EffectType == EFFECT_TYPE.NORMAL_TYPE then
      self.control_param_save.cur_fish_count[data.item_detail.ItemType] = self.control_param_save.cur_fish_count[data.item_detail.ItemType] or 0
      self.control_param_save.cur_fish_count[data.item_detail.ItemType] = self.control_param_save.cur_fish_count[data.item_detail.ItemType] + 1
    end
    self.control_param_save.cur_fish_all_count[data.item_detail.ItemType] = self.control_param_save.cur_fish_all_count[data.item_detail.ItemType] or 0
    self.control_param_save.cur_fish_all_count[data.item_detail.ItemType] = self.control_param_save.cur_fish_all_count[data.item_detail.ItemType] + 1
  end
end

function ui:update_bomstate_item(data)
  if data.item_detail.EffectType == EFFECT_TYPE.EXPLODE_TYPE and Global.real_time - data.bom_start_time > 1 then
    self:set_item_get(data)
    data.cur_use_icon:SetActive(true)
  end
  if data.item_detail.EffectType == EFFECT_TYPE.NORMAL_TYPE then
    if data.bom_sequence == nil then
      if data.cur_get_icon then
        data.cur_get_icon:SetActive(true)
        data.cur_use_icon_img.enabled = false
      end
      data.bom_sequence = Util.create_sequence()
      data.bom_sequence:Append(data.cur_item_rect.component:DOShakePosition(0.5, 10, 40, 50, true))
      data.bom_sequence:Join(data.cur_item_cvs.component:DOFade(0, 1.5))
      local tips_obj = self:get_rect_transform("IntegralIconTips", data.cur_item_gameObject)
      tips_obj:SetActive(true)
      local temp_x, temp_y = data.cur_use_item_rect:GetAnchoredPositionA()
      tips_obj:SetAnchoredPositionA(temp_x, temp_y)
      if tips_obj then
        data.bom_sequence:Join(tips_obj.transform:DOMove(self.v_uiobjects.UnfoldBtn.transform.position, 1):SetEase(Ease.InQuad))
      end
      data.bom_sequence:OnComplete(function()
        if data.bom_sequence then
          data.bom_sequence:Kill(false)
          data.bom_sequence = nil
        end
        if not Util.is_nil(tips_obj) then
          tips_obj:SetActive(false)
        end
      end)
    end
    if Global.real_time - data.bom_start_time > 1.5 then
      if data.bom_sequence then
        data.bom_sequence:Kill(false)
        data.bom_sequence = nil
      end
      if not Util.is_nil(tips_obj) then
        tips_obj:SetActive(false)
      end
      data.cur_state = item_state.GetState
      self:give_back_auto_cache_obj(UI_FISH_GAME_TEM_KEY, data.cur_item_gameObject)
      data.cur_item_rect:SetParent(self.v_uicompents.ItemSource_rect)
      data.cur_item_rect:SetAnchoredPositionA(0, 0)
      data.cur_use_item_rect:SetAnchoredPositionA(0, 0)
      data.cur_use_icon:SetLocalScaleA(data.cur_pos.init_scale_x, data.cur_pos.init_scale_y, data.cur_pos.init_scale_z)
      CSHelper.SetRectTransLocalRot(data.cur_item_rect, 0, 0, 0)
      CSHelper.SetRectTransLocalRot(data.cur_use_item_rect, 0, 0, 0)
    end
  end
end

function ui:set_item_get(data, rec_item)
  if data.item_detail.EffectType == EFFECT_TYPE.NORMAL_TYPE then
    self.control_param_save.cur_count = self.control_param_save.cur_count + data.item_detail.ItemEffect[1]
    self.control_param_save.cur_get_fish = self.control_param_save.cur_get_fish + data.item_detail.ItemEffect[1]
    self.control_param_save.cur_get_fish_show = false
    self.v_uicompents.CurrentStar_txt.text = self.control_param_save.cur_count
  end
  if rec_item then
    return
  end
  data.cur_state = item_state.GetState
  self:give_back_auto_cache_obj(UI_FISH_GAME_TEM_KEY, data.cur_item_gameObject)
  data.cur_item_rect:SetParent(self.v_uicompents.ItemSource_rect)
  data.cur_item_rect:SetAnchoredPositionA(0, 0)
  data.cur_use_item_rect:SetAnchoredPositionA(0, 0)
  data.cur_use_icon:SetLocalScaleA(data.cur_pos.init_scale_x, data.cur_pos.init_scale_y, data.cur_pos.init_scale_z)
  CSHelper.SetRectTransLocalRot(data.cur_item_rect, 0, 0, 0)
  CSHelper.SetRectTransLocalRot(data.cur_use_item_rect, 0, 0, 0)
end

function ui:set_item_idle(data)
  if self.game_fsm.FSM_STATE_SAVE.cur_fsm == "IN_GAME" then
    data.gen_start_time = Global.real_time
    data.cur_state = item_state.IdleState
    self:give_back_auto_cache_obj(UI_FISH_GAME_TEM_KEY, data.cur_item_gameObject)
    data.cur_item_rect:SetParent(self.v_uicompents.ItemSource_rect)
    data.cur_item_rect:SetAnchoredPositionA(0, 0)
    data.cur_use_item_rect:SetAnchoredPositionA(0, 0)
    data.cur_use_icon:SetLocalScaleA(data.cur_pos.init_scale_x, data.cur_pos.init_scale_y, data.cur_pos.init_scale_z)
    CSHelper.SetRectTransLocalRot(data.cur_item_rect, 0, 0, 0)
    CSHelper.SetRectTransLocalRot(data.cur_use_item_rect, 0, 0, 0)
  end
end

function ui:item_explode_effect(data_explode)
  if self.game_fsm.FSM_STATE_SAVE.cur_fsm == "IN_GAME" then
    local eff2 = Util.get_child_gameobj("Fx_BomGlowLoop", data_explode.cur_use_item)
    if eff2 then
      eff2:SetActive(false)
    end
    local eff = Util.get_child_gameobj("Fx_BomGlow", data_explode.cur_use_item)
    if eff then
      eff:SetActive(false)
      eff:SetActive(true)
      Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_fish_game_explode_UI_SOUND)
    end
    for idx, data in pairs(self.all_item_list) do
      if data.cur_state == item_state.NoramalState and data.item_detail.EffectType == EFFECT_TYPE.NORMAL_TYPE then
        local is_get = false
        if data.cur_use_judge ~= nil then
          for _, judge_obj in pairs(data.cur_use_judge) do
            for _, bom_obj in pairs(data_explode.cur_bom_judge) do
              if CSHelper.RectOverlapJudgeWithRot(judge_obj.component, bom_obj.component) then
                is_get = true
                break
              end
            end
            if is_get then
              break
            end
          end
        end
        if is_get then
          data.cur_state = item_state.BomState
          data.bom_start_time = Global.real_time
          self:set_item_get(data, true)
        end
      end
    end
  end
end

function ui:fish_judging()
  if self.game_fsm.FSM_STATE_SAVE.cur_fsm == "IN_GAME" and self.fish_fsm.FSM_STATE_SAVE.cur_fsm == "FISH_DOWN" then
    for idx, data in pairs(self.all_item_list) do
      if data.cur_state == item_state.NoramalState then
        local is_get = false
        if data.cur_use_judge ~= nil then
          for _, judge_obj in pairs(data.cur_use_judge) do
            for _, hool_obj in pairs(self.v_hool) do
              if CSHelper.RectOverlapJudgeWithRot(judge_obj.component, hool_obj.component) then
                is_get = true
                break
              end
            end
            if is_get then
              break
            end
          end
        end
        if is_get then
          data.cur_state = item_state.UpState
          if data.item_detail.EffectType == EFFECT_TYPE.NORMAL_TYPE then
            data.cur_item_rect:SetParent(self.v_uicompents.Hool_rect)
            Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_fish_game_get_UI_SOUND)
          end
          if nil ~= data.cur_get_icon then
            data.cur_get_icon.position = self.v_uicompents.HoolJudge3_rect.position
          end
          local eff3 = Util.get_child_gameobj("Fx_BirdGlow", data.cur_use_item)
          if eff3 then
            eff3:SetActive(false)
          end
          self.control_param_save.have_fish = true
          self.control_param_save.fish_up_weight = data.item_detail.WeightFactor
          self:switch_fsm(self.fish_fsm, self.fish_fsm.FSM_STATE_SAVE.cur_fsm, "FISH_UP")
        end
      end
    end
  end
end

function ui:time_judging()
  local use_time = Global.real_time - self.v_start_game_time
  self.control_param_save.cur_use_time = use_time
  local have_time = self.v_stage_data.Duration - use_time
  if have_time <= 0 and self.game_fsm.FSM_STATE_SAVE.cur_fsm == "IN_GAME" then
    self.v_uiobjects.Ani_CountDownText_Red:SetActive(false)
    self.v_uicompents.CountDownText_rect:SetLocalScaleA(1, 1, 1)
    self:switch_fsm(self.fish_fsm, self.fish_fsm.FSM_STATE_SAVE.cur_fsm, "FISH_END")
    self:switch_fsm(self.game_fsm, self.game_fsm.FSM_STATE_SAVE.cur_fsm, "END_GAME")
  end
  have_time = math.max(0, math.ceil(have_time))
  self.v_uicompents.CountDownText_txt.text = string.format("%ss", have_time)
  if have_time <= 10 and self.game_fsm.FSM_STATE_SAVE.cur_fsm == "IN_GAME" then
    self.v_uicompents.CountDownText_txt.color = red_color
    self.v_uiobjects.Ani_CountDownText_Red:SetActive(true)
  end
end

function ui:item_judging()
  if self.game_fsm.FSM_STATE_SAVE.cur_fsm == "IN_GAME" then
    local cur_count = 0
    for idx, data in pairs(self.all_item_list) do
      if data.cur_state ~= item_state.IdleState and data.cur_state ~= item_state.NoObjState then
        cur_count = cur_count + 1
      end
    end
    if cur_count <= 0 then
      self.v_uiobjects.Ani_CountDownText_Red:SetActive(false)
      self.v_uicompents.CountDownText_rect:SetLocalScaleA(1, 1, 1)
      self:switch_fsm(self.fish_fsm, self.fish_fsm.FSM_STATE_SAVE.cur_fsm, "FISH_END")
      self:switch_fsm(self.game_fsm, self.game_fsm.FSM_STATE_SAVE.cur_fsm, "END_GAME")
    end
  end
end

function ui:update_fish_emj()
  local cur_fsm = self.game_fsm.FSM_STATE_SAVE.cur_fsm
  local cur_fish_fsm = self.fish_fsm.FSM_STATE_SAVE.cur_fsm
  if "IN_GAME" == cur_fsm then
    local emj
    if "FISH_DOWN" == cur_fish_fsm then
      emj = EMJ_STATE.Emoji1
    elseif "FISH_UP" == cur_fish_fsm then
      if self.control_param_save.have_fish then
        emj = EMJ_STATE.Emoji2
      else
        emj = EMJ_STATE.Emoji3
      end
    end
    if self.control_param_save.fish_emj_state ~= emj then
      self.v_uiobjects.EmojiGroup:SetActive(true)
      self.v_uiobjects.Emoji1:SetActive(emj == EMJ_STATE.Emoji1)
      self.v_uiobjects.Emoji2:SetActive(emj == EMJ_STATE.Emoji2)
      self.v_uiobjects.Emoji3:SetActive(emj == EMJ_STATE.Emoji3)
      self.control_param_save.fish_emj_state = emj
      self.control_param_save.fish_emj_time_out = false
      self.control_param_save.fish_emj_time = Global.real_time
    end
    if not self.control_param_save.fish_emj_time_out then
      local use_time = Global.real_time - self.control_param_save.fish_emj_time
      if self.control_param_save.fish_emj_state == nil or use_time > self.all_cfg_save.emj_cfg[self.control_param_save.fish_emj_state].StarTime then
        self.control_param_save.fish_emj_time_out = true
        self.v_uiobjects.Emoji1:SetActive(false)
        self.v_uiobjects.Emoji2:SetActive(false)
        self.v_uiobjects.Emoji3:SetActive(false)
        self.v_uiobjects.EmojiGroup:SetActive(false)
      end
    end
  end
end

function ui:update_get_sorce()
  local cur_fish_fsm = self.fish_fsm.FSM_STATE_SAVE.cur_fsm
  if ("FISH_WAIT" == cur_fish_fsm or "FISH_DOWN" == cur_fish_fsm) and self.control_param_save.cur_get_fish > 0 then
    local show_time = Global.real_time - self.control_param_save.cur_get_fish_time
    if not self.control_param_save.cur_get_fish_show then
      Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_fish_game_get_sorce_UI_SOUND)
      self.control_param_save.cur_get_fish_show = true
      self.v_uiobjects.IntegralTips:SetActive(true)
      self.v_uicompents.IntegralNum_txt.text = "+" .. self.control_param_save.cur_get_fish
      self.v_uiobjects.Ani_IntegralTips_Out:SetActive(false)
      self.v_uiobjects.Ani_IntegralTips_In:SetActive(false)
      self.v_uiobjects.Ani_IntegralTips_In:SetActive(true)
    end
    if show_time > 1 then
      self.v_uiobjects.Ani_IntegralTips_Out:SetActive(true)
      self.v_uicompents.IntegralTips_rect:SetAnchoredPositionA(self.v_score_tipx, self.v_score_tipy)
      self.control_param_save.cur_get_fish = 0
      self.control_param_save.cur_get_fish_show = false
    end
  end
end

function ui:update_value_sorce()
  for idx, data in pairs(self.all_item_list) do
    if data.item_detail.DurationTime then
      if data.cur_state == item_state.NoramalState then
        if data.value_show_state and Global.real_time - data.value_start_time > data.item_detail.DurationTime then
          data.value_item:SetActive(false)
          data.value_show_state = false
          data.value_start_time = Global.real_time
        end
        if not data.value_show_state and Global.real_time - data.value_start_time > data.item_detail.DurationAgainTime then
          data.value_item:SetActive(true)
          data.value_show_state = true
          data.value_start_time = Global.real_time
        end
      elseif data.cur_state == item_state.UpState then
        if data.value_show_state then
          data.value_item:SetActive(false)
        end
      elseif data.cur_state == item_state.GetState then
        if data.value_show_state then
          data.value_item:SetActive(false)
        end
      elseif data.cur_state == item_state.BomState then
        if data.value_show_state then
          data.value_item:SetActive(false)
        end
      elseif data.cur_state == item_state.IdleState and data.value_show_state then
        data.value_item:SetActive(false)
      end
    end
  end
end

function ui:set_cond_start()
  for idx = 1, 3 do
    local cfg = self.all_cfg_save.con_star_cfg[idx]
    local star_obj = self.v_uiobjects["Star" .. idx]
    local star_icon_obj = self.v_uiobjects["TargetMask" .. idx]
    local star_icon_cmp = self.v_uicompents["TargetMask" .. idx .. "_img"]
    local star_text = self.v_uicompents["Name" .. idx .. "_txt"]
    local star_num_text1 = self.v_uicompents["CurrentStar" .. idx .. "_txt"]
    local star_num_text2 = self.v_uicompents["StarConditionTxt" .. idx .. "_txt"]
    local star_con = self.v_uicompents["Con" .. idx .. "_txt"]
    star_num_text1.color = normal_con_color
    star_num_text2.color = normal_con_color
    star_con.color = normal_con_color
    star_text.text = cfg.Desc
    star_icon_obj:SetActive(true)
    if cfg.Icon and cfg.Icon ~= "" then
      star_icon_cmp.enabled = true
      ResMgr:load_set_icon(star_icon_cmp, cfg.Icon)
    else
      star_icon_cmp.enabled = false
    end
    self:set_con_start_num(star_num_text1, star_num_text2, star_obj, cfg, idx, star_con)
  end
end

function ui:set_con_start_num(star_num_text1, star_num_text2, star_obj, cfg, idx, star_con, is_settle)
  local item_id = 0
  local item_num = 0
  local cur_cont = 0
  if 1 == cfg.Type then
    star_num_text1.text = self.control_param_save.cur_count
    star_num_text2.text = cfg.Param[1]
  elseif 2 == cfg.Type then
    item_num = cfg.Param[1]
    for _, temp_num in pairs(self.control_param_save.cur_fish_count) do
      cur_cont = cur_cont + temp_num
    end
    star_num_text1.text = cur_cont
    star_num_text2.text = item_num
  elseif 3 == cfg.Type then
    item_id = cfg.Param[1]
    item_num = cfg.Param[2]
    cur_cont = self.control_param_save.cur_fish_all_count[item_id] or 0
    star_num_text1.text = cur_cont
    star_num_text2.text = item_num
  elseif 4 == cfg.Type then
    local time_param = cfg.Param[1]
    star_num_text1.text = math.floor(self.control_param_save.cur_use_time)
    star_num_text2.text = time_param
  elseif 5 == cfg.Type then
    item_id = cfg.Param[1]
    item_num = cfg.Param[2]
    cur_cont = self.control_param_save.cur_fish_notouch_count[item_id] or 0
    star_num_text1.text = cur_cont
    star_num_text2.text = item_num
  end
  if is_settle then
    return
  end
  local arr = self["conditiontype_" .. cfg.Type](self, cfg)
  star_obj:SetActive(arr)
  self.control_param_save.con_star[idx] = arr
  if arr then
    star_num_text1.color = rev_con_color
    star_num_text2.color = rev_con_color
    star_con.color = rev_con_color
  else
    star_num_text1.color = normal_con_color
    star_num_text2.color = normal_con_color
    star_con.color = normal_con_color
  end
end

function ui:update_cond_start()
  if self.game_fsm.FSM_STATE_SAVE.cur_fsm == "IN_GAME" then
    for idx = 1, 3 do
      local cfg = self.all_cfg_save.con_star_cfg[idx]
      local star_obj = self.v_uiobjects["Star" .. idx]
      local star_num_text1 = self.v_uicompents["CurrentStar" .. idx .. "_txt"]
      local star_num_text2 = self.v_uicompents["StarConditionTxt" .. idx .. "_txt"]
      local star_con = self.v_uicompents["Con" .. idx .. "_txt"]
      self:set_con_start_num(star_num_text1, star_num_text2, star_obj, cfg, idx, star_con)
    end
  end
end

function ui:get_cond_value(cond_id)
  return ShareRes.get_fish_game_cond_cfg(cond_id)
end

function ui:conditiontype_1(cfg)
  return self.control_param_save.cur_count >= cfg.Param[1]
end

function ui:conditiontype_2(cfg)
  local item_num = cfg.Param[1]
  local cont = 0
  for _, temp_num in pairs(self.control_param_save.cur_fish_count) do
    cont = cont + temp_num
  end
  return item_num <= cont
end

function ui:conditiontype_3(cfg)
  local item_id = cfg.Param[1]
  local item_num = cfg.Param[2]
  local cur_cont = self.control_param_save.cur_fish_all_count[item_id] or 0
  return item_num <= cur_cont
end

function ui:conditiontype_4(cfg)
  local time_param = cfg.Param[1]
  return time_param >= math.floor(self.control_param_save.cur_use_time)
end

function ui:conditiontype_5(cfg)
  local item_id = cfg.Param[1]
  local item_num = cfg.Param[2]
  local cur_cont = self.control_param_save.cur_fish_notouch_count[item_id] or 0
  return item_num <= cur_cont
end

function ui:get_is_suc()
  local star_cnt = 0
  for idx, star in pairs(self.control_param_save.con_star) do
    if star then
      self.control_param_save.is_success = true
      star_cnt = star_cnt + 1
    end
  end
  return self.control_param_save.is_success, star_cnt, self.control_param_save.cur_count, self.control_param_save.con_star, self.all_cfg_save.con_star_cfg, self.control_param_save.cur_use_time
end

function ui:get_star_icon_show(con_type)
  return START_USE_ICON[con_type]
end

function ui:get_fish_episode_id()
  return self.v_stage_data.Id
end

function ui:get_next_stage()
  local stage_next_index = self.v_stage_index + 1
  local stage_cfg = self.v_stage_list[stage_next_index]
  if nil == stage_cfg then
    return
  end
  local count_down_time = -1
  if stage_cfg.StartTime then
    count_down_time = Date.get_time_stamp_by_scheme_id(stage_cfg.StartTime) - Date.server_time()
  end
  if count_down_time > 0 then
    return
  end
  local ACT_ID = NoviceMgr:get_fish_game_act_id()
  local activity_cfg = ShareRes.get_activity_cfg(ACT_ID)
  local act_end_time = activity_cfg.PlayStopTime and Date.get_time_stamp_by_scheme_id(activity_cfg.PlayStopTime) or 0
  local has_time = act_end_time > 0
  local total_sec = act_end_time - Date.server_time()
  if not has_time then
    return
  end
  if total_sec <= 0 then
    return
  end
  local is_pre_pass = true
  if stage_cfg.FrontEpisodeId then
    local cur_id = self:get_fish_episode_id()
    is_pre_pass = NoviceMgr:get_fish_game_data(stage_cfg.FrontEpisodeId).is_pass or stage_cfg.FrontEpisodeId == cur_id
  end
  if not is_pre_pass then
    return
  end
  return stage_cfg, stage_next_index
end

return ui
