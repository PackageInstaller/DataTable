local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local MAX_ANGLR = 90
local TimingOfLinkSystemsCheck = ShareRes.get_comm_string_value("TimingOfLinkSystemsCheck")
local TimingOfLinkSystemsCheckLimit = ShareRes.get_comm_string_value("TimingOfLinkSystemsCheckLimit")
local CURRENT_ATTR_ID = Config.FightDefine.ATTR_TYPE.COMBINE_ENERGY
local FightConfig = require("uimodule.fight.fight_config")
local Math = require("base.mathx")
local MAX_ATTR_ID = Config.FightDefine.ATTR_TYPE.COMBINE_ENERGY_MAX
local TWEEN_TYPE = {
  FILL_TWEEN = 1,
  POINTER_TWEEN = 2,
  RESTART_FILL = 3,
  RESTART_POINTER = 4
}
local RECT_STR = "%s_rect"
local STAGE1_EFFECT_MAP = {
  Fx_UI_Handle_Glow1 = "HandleEffect"
}
local STAGE2_EFFECT_MAP = {
  Fx_UI_Handle_Glow2 = "HandleEffect"
}
local FILL_EFFECT = {
  Fx_UI_Fill_1 = "Stage1Fill",
  Fx_UI_Fill_2 = "UI_FillCacheRoot"
}
local DAMAGE_EFFECT_NAME = FightConfig.FIGHT_UI_EFFECT.Fx_UI_Damage
local SKILL_LINK_STAGE = FightConfig.SKILL_LINK_STAGE
local SKILL_LINK_CHARGE_STAGE = FightConfig.SKILL_LINK_CHARGE_STAGE
local SKILL_LINK_TIMER_SET_TYPE = FightConfig.SKILL_LINK_TIMER_SET_TYPE
local ULT_SKILL_STAGE = require("uimodule.fight.child.ult_skill_stage")

function ui:on_hero_go_backgroup()
  local open = FightDataMgr:is_record_damage_trigger_open()
  if open then
    self:set_damage_txt()
  end
end

function ui:on_god_attr_change(msg)
  if msg.mm_x == CURRENT_ATTR_ID or msg.mm_x == MAX_ATTR_ID then
    self:refresh_energy_slider()
  end
end

function ui:on_game_pase(msg)
  local pause = msg.mm_x
  if pause then
    self.v_tween_acitve_map = {}
    for tween_name, tween in pairs(self.v_tween_map) do
      if tween:IsPlaying() then
        tween:Pause()
        self.v_tween_acitve_map[tween_name] = true
      end
    end
  elseif self.v_tween_acitve_map then
    for tween_name, active in pairs(self.v_tween_acitve_map) do
      if self.v_tween_map[tween_name] then
        self.v_tween_map[tween_name]:Play()
      end
    end
    self.v_tween_acitve_map = nil
  end
  local pause_sound = pause or self.v_timer_type == SKILL_LINK_TIMER_SET_TYPE.PAUSE
  Global.sound_mgr:pause_effect_sound_by_effect_name("Fx_Link_CamEffect", pause_sound)
  self.v_uiobjects.Bg:SetActive(not pause)
end

function ui:init_data()
  self:init_skill_link_effect()
  self:change_cur_show_stage()
end

function ui:on_pre_tp_room()
  if not self.v_effect_map then
    return
  end
  self.v_effect_visible_map = {}
  for key, effect in pairs(self.v_effect_map) do
    self.v_effect_visible_map[key] = effect.gameObject.activeSelf
    effect.gameObject:SetActive(false)
  end
end

function ui:on_pre_tp_room()
  if not self.v_effect_map then
    return
  end
  self.v_effect_visible_map = {}
  for key, effect in pairs(self.v_effect_map) do
    if Util.is_nil(effect) then
      self.v_effect_map[key] = nil
    else
      self.v_effect_visible_map[key] = effect.gameObject.activeSelf
      effect.gameObject:SetActive(false)
    end
  end
end

function ui:on_tp_toom_finish()
  if not self.v_effect_map or not self.v_effect_visible_map then
    return
  end
  for key, visible in pairs(self.v_effect_visible_map) do
    if not Util.is_nil(self.v_effect_map[key]) then
      self.v_effect_map[key].gameObject:SetActive(visible)
    end
  end
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_RECORD_DAMAGE_CHANGE, self.set_damage_txt, self)
  self:bind_auto_mq(Const.MSG_RECORD_STATE_CHANGE, self.set_damage_visible, self)
  self:bind_auto_mq(Const.MSG_GOD_ATTR_CHANGE, self.on_god_attr_change, self)
  self:bind_auto_mq(Const.MSG_HERO_GO_BACKGORUND, self.on_hero_go_backgroup, self)
  self:bind_auto_mq(Const.MSG_ON_GAME_PAUSE, self.on_game_pase, self)
  self:bind_auto_mq(Const.MSG_GOD_BORN, self.refresh_energy_slider, self)
  self:bind_auto_mq(Const.MSG_SCENE_RELOAD_END, self.init_data, self)
  self:bind_auto_mq(Const.MSG_PRE_TP_ROOM, self.on_pre_tp_room, self)
  self:bind_auto_mq(Const.MSG_TP_ROOM_FINISH, self.on_tp_toom_finish, self)
end

function ui:burst_on_complete()
  if self.v_close_burst then
    self.v_close_burst = nil
    self.v_uiobjects.Burst:SetActive(false)
  end
end

function ui:create_dotween()
  self.v_burst_show_dot = self.v_uicompents.Burst_cg:DOFade(1, 0.6)
  self.v_burst_show_dot:ChangeStartValue(0)
  self.v_burst_show_dot:SetAutoKill(false)
  self.v_burst_show_dot:Pause()
  self.v_burst_show_dot:OnRewind(function()
    if self:visible() and not self:is_destroy() then
      self:burst_on_complete()
    end
  end)
  self.v_slider1_dot = self.v_uicompents.StageSlider1_cg:DOFade(0.35, 0.2)
  self.v_slider1_dot:ChangeStartValue(1)
  self.v_slider1_dot:SetAutoKill(false)
  self.v_slider1_dot:Pause()
end

function ui:ui_finish_load()
  self:create_dotween()
  self.v_ult_stage = SKILL_LINK_STAGE.ONE
  self.v_tween_map = {}
  self.v_effect_map = {}
  self.v_tweens = {}
  self.v_stage1 = ULT_SKILL_STAGE:ui_wrap_ex(self, self.v_uiobjects.Stage1, false)
  self.v_stage2 = ULT_SKILL_STAGE:ui_wrap_ex(self, self.v_uiobjects.Stage2, false)
  self.v_cur_show_stage = self.v_stage1
  self.v_main_cg = self:get_canvas_group()
  self.v_damage_tmp = Util.get_component(nil, self.v_uiobjects.DamegeNum, typeof(CS.TMPro.TextMeshProUGUI))
  self.v_stage1_energy_percent = ShareRes.get_comm_value("LinkStageEnergy")
  self.v_stage2_energy_percent = 1 - self.v_stage1_energy_percent
end

function ui:ui_on_show()
  self.v_slider2_visible = self.v_uiobjects.StageSlider2.activeSelf
  self.v_state_change_value = {}
  self:init_skill_link_effect()
  self:_regist_client_event()
  self:set_damage_visible()
  self:refresh_energy_slider()
end

function ui:ui_on_hide()
  self:release_effect()
  self:clear_all_tween()
end

function ui:ui_on_destroy()
  self.v_stage1:ui_hide()
  self.v_stage2:ui_hide()
  self.v_stage1:ui_destroy()
  self.v_stage2:ui_destroy()
  if self.v_burst_show_dot then
    self.v_burst_show_dot:Kill(false)
    self.v_burst_show_dot = nil
  end
  if self.v_slider1_dot then
    self.v_slider1_dot:Kill(false)
    self.v_slider1_dot = nil
  end
end

function ui:set_damage_txt()
  local damage = FightDataMgr:get_skill_link_damage(Global.hero_uuid) or 0
  local damage_str = FightDataMgr:get_tmp_string(damage, 6)
  self.v_damage_tmp:SetText(damage_str)
  Util.play_auto_release_fight_ui_effect(DAMAGE_EFFECT_NAME, nil, self.v_uicompents.UltDamageTips_rect)
  self:damage_text_shake()
end

function ui:set_damage_visible()
  local open = FightDataMgr:is_record_damage_trigger_open()
  self.v_uiobjects.UltDamageTips:SetActive(open)
  if open then
    self:set_damage_txt()
  else
    self:clear_tween_by_key("damage_text_shake")
  end
end

function ui:damage_text_shake()
  local dot_rect = self.v_uicompents.DamageDotNode_rect
  if not self.v_tween_map.damage_text_shake then
    self.v_tween_map.damage_text_shake = dot_rect.transform:DOShakeAnchorPos(0.3, 20, 20, 20, true)
    self.v_tween_map.damage_text_shake:SetAutoKill(false)
  else
    dot_rect:SetAnchoredPositionX(self.v_damage_init_pos_x)
    self.v_tween_map.damage_text_shake:Restart()
  end
end

function ui:set_duration_change()
  self.v_duration_change = true
end

function ui:init_skill_link_effect()
  self:show_effect_map(FILL_EFFECT)
  local rect
  for effect_name in pairs(FILL_EFFECT) do
    if self.v_effect_map[effect_name] then
      rect = Util.get_rect_transform(nil, self.v_effect_map[effect_name])
      rect:SetAnchoredPositionA(0, 0)
    end
  end
  local Fx_UI_Fill_2 = self.v_effect_map.Fx_UI_Fill_2
  if self.v_slider2_visible then
    if Fx_UI_Fill_2 then
      Fx_UI_Fill_2.transform:SetParent(self.v_uicompents.Stage2Fill_rect)
      Fx_UI_Fill_2.transform:ResetAttr()
      Fx_UI_Fill_2.transform:SetAnchoredPositionA(0, 0)
    end
  elseif Fx_UI_Fill_2 then
    Fx_UI_Fill_2.transform:SetParent(self.v_uicompents.UI_FillCacheRoot_rect)
  end
  self.v_stage1:init_stage_data(SKILL_LINK_STAGE.ONE, SKILL_LINK_CHARGE_STAGE.CHARGING)
  self.v_stage2:init_stage_data(SKILL_LINK_STAGE.TOW, SKILL_LINK_CHARGE_STAGE.CHARGING)
end

function ui:set_skill_link_ui_state(stage, charge_stage)
  self.v_stage_change = self.v_ult_stage ~= stage
  if self.v_stage_change or self.v_ult_charge_stage ~= charge_stage then
    self.v_ult_stage = stage
    self.v_ult_charge_stage = charge_stage
    self:change_cur_show_stage()
    CSHelper.SynchronousParticleEffectsTime(self.v_effect_map.Fx_UI_Fill_1.gameObject, self.v_effect_map.Fx_UI_Fill_2.gameObject)
  end
end

function ui:change_cur_show_stage()
  local is_stage1 = self.v_ult_stage == SKILL_LINK_STAGE.ONE
  if is_stage1 then
    self:release_effect_map(STAGE2_EFFECT_MAP)
    self:show_effect_map(STAGE1_EFFECT_MAP)
    self.v_stage1:set_enable(true)
    if self.v_stage2:visible() then
      self.v_stage2:play_end_tween_and_hide()
    end
  else
    self:release_effect_map(STAGE1_EFFECT_MAP)
    self:show_effect_map(STAGE2_EFFECT_MAP)
    if self.v_stage1:visible() then
      self.v_stage1:play_end_tween_and_hide()
    end
    self.v_stage2:set_enable(true)
  end
  self.v_cur_show_stage = is_stage1 and self.v_stage1 or self.v_stage2
  self.v_cur_show_stage:set_data(self.v_ult_stage, self.v_ult_charge_stage, self.v_stage_change)
  self:create_timer_tween()
  self.v_stage_change = false
end

function ui:refresh_energy_slider()
  local god_npc = SceneMgr:get_god_npc()
  if not god_npc then
    return
  end
  local cur_value = god_npc.attr_mgr:get_attr(CURRENT_ATTR_ID) or 0
  local max_value = god_npc.attr_mgr:get_attr(MAX_ATTR_ID) or 1
  local stage1_max = self.v_stage1_energy_percent * max_value
  local stage1_percent = cur_value / stage1_max
  self.v_uicompents.StageSlider1_sld.value = stage1_percent
  local stage2_max = self.v_stage2_energy_percent * max_value
  local stage2_percent = (cur_value - stage1_max) / stage2_max
  local show_stage2 = stage2_percent > 0
  if show_stage2 then
    self.v_uicompents.StageSlider2_sld.value = stage2_percent
  end
  if self.v_slider2_visible ~= show_stage2 then
    self.v_uiobjects.StageSlider2:SetActive(show_stage2)
    local Fx_UI_Fill_2 = self.v_effect_map.Fx_UI_Fill_2
    if show_stage2 then
      if Fx_UI_Fill_2 then
        Fx_UI_Fill_2.transform:SetParent(self.v_uicompents.Stage2Fill_rect)
        Fx_UI_Fill_2.transform:ResetAttr()
        Fx_UI_Fill_2.transform:SetAnchoredPositionA(0, 0)
      end
      self.v_slider1_dot:Restart()
    else
      if Fx_UI_Fill_2 then
        Fx_UI_Fill_2.transform:SetParent(self.v_uicompents.UI_FillCacheRoot_rect)
      end
      self.v_slider1_dot:Complete()
      self.v_slider1_dot:PlayBackwards()
    end
    self.v_slider2_visible = show_stage2
  end
end

local function _get_angle_by_percent(percent)
  local half = 0.5
  local dif = percent - half
  local sign = dif >= 0 and -1 or 1
  local angle = math.abs(dif / half) * MAX_ANGLR * sign
  return angle
end

function ui:refresh_pointer_percent(percent)
  self.v_uicompents.Fill_img.fillAmount = percent
  local angle = _get_angle_by_percent(percent)
  self.v_uicompents.Pointer1_rect:SetEuler(0, 0, angle)
end

function ui:set_timer_enable(enable)
  if enable then
    self:create_timer_tween()
    self.v_uiobjects.Burst:SetActive(true)
    self.v_close_burst = nil
    self.v_burst_show_dot.timeScale = 1
    self.v_burst_show_dot:SetDelay(0.25)
    self.v_burst_show_dot:Restart()
  else
    self:disable_timer_tween()
    self.v_close_burst = nil
    self.v_burst_show_dot:Complete()
    self.v_burst_show_dot.timeScale = 2
    self.v_burst_show_dot:SetDelay(0)
    self.v_burst_show_dot:PlayBackwards()
    self.v_close_burst = true
  end
  self.v_timer_enable = enable
end

function ui:set_link_timer_type(timer_type)
  self.v_timer_type = timer_type
  if timer_type == SKILL_LINK_TIMER_SET_TYPE.SHOW then
    self:set_timer_enable(true)
  elseif timer_type == SKILL_LINK_TIMER_SET_TYPE.HIDE then
    self:set_timer_enable(false)
  end
  if self.v_timer_enable then
    if timer_type == SKILL_LINK_TIMER_SET_TYPE.PAUSE then
      Global.sound_mgr:pause_effect_sound_by_effect_name("Fx_Link_CamEffect", true)
      self:pause_timer_tween()
    elseif timer_type == SKILL_LINK_TIMER_SET_TYPE.PLAY then
      Global.sound_mgr:pause_effect_sound_by_effect_name("Fx_Link_CamEffect", false)
      self:play_timer_tween()
    elseif timer_type == SKILL_LINK_TIMER_SET_TYPE.RESTART then
      self:restart_timer_tween()
    elseif timer_type == SKILL_LINK_TIMER_SET_TYPE.CLEAR then
      self:clear_timer_tween()
    end
  end
end

function ui:create_restart_tween()
  if not self.v_tween_map[TWEEN_TYPE.RESTART_FILL] then
    self:clear_tween_by_key(TWEEN_TYPE.RESTART_FILL)
    local tween = self.v_uicompents.Fill_img:DOFillAmount(1, 0.3)
    tween:ChangeStartValue(0)
    tween:OnComplete(function()
      if self:visible() and not self:is_destroy() then
        local effect_name = FightConfig.FIGHT_UI_EFFECT.Fx_Pointer_1
        local effect_parent = self.v_uicompents.Pointer1_rect
        Util.play_auto_release_fight_ui_effect(effect_name, effect_name, effect_parent)
        if self.v_ult_stage ~= SKILL_LINK_STAGE.ONE then
          effect_name = FightConfig.FIGHT_UI_EFFECT.Fx_Pointer_2
          effect_parent = self.v_uicompents.Fill_rect
          Util.play_auto_release_fight_ui_effect(effect_name, effect_name, effect_parent)
        end
      end
    end)
    self:add_tween(TWEEN_TYPE.RESTART_FILL, tween)
  end
  if not self.v_tween_map[TWEEN_TYPE.RESTART_POINTER] then
    self:clear_tween_by_key(TWEEN_TYPE.RESTART_POINTER)
    Util.VEC3_TEMP:Set(0, 0, -MAX_ANGLR)
    local tween = self.v_uicompents.Pointer1_rect:DOLocalRotateA(0, 0, -MAX_ANGLR, 0.1, 0, 0, MAX_ANGLR)
    self:add_tween(TWEEN_TYPE.RESTART_POINTER, tween)
  end
end

function ui:_get_cur_stage_timer_percent()
  local stage = self.v_ult_stage
  local duration_list = FightDataMgr:get_link_duration_list()
  local time = stage and duration_list[stage] or duration_list[1]
  local percent = 1 == stage and 0.66 or 1
  return percent, time
end

function ui:create_timer_tween()
  local timer_percent, time = self:_get_cur_stage_timer_percent()
  if not self.v_tween_map[TWEEN_TYPE.FILL_TWEEN] then
    local tween = self.v_uicompents.Fill_img:DOFillAmount(0, time)
    self:add_tween(TWEEN_TYPE.FILL_TWEEN, tween)
    tween:ChangeStartValue(timer_percent)
    tween:OnComplete(function()
      if self:visible() and not self:is_destroy() then
        BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_SKILL_LINK_TIMER_END, self.v_ult_stage)
      end
    end)
  elseif self.v_stage_change or self.v_duration_change then
    self.v_tween_map[TWEEN_TYPE.FILL_TWEEN]:ChangeValues(timer_percent, 0, time)
  end
  if not self.v_tween_map[TWEEN_TYPE.POINTER_TWEEN] then
    local angle = _get_angle_by_percent(timer_percent)
    local tween = self.v_uicompents.Pointer1_rect:DOLocalRotateA(0, 0, MAX_ANGLR - 0.01, time, 0, 0, angle)
    self:add_tween(TWEEN_TYPE.POINTER_TWEEN, tween)
  elseif self.v_stage_change or self.v_duration_change then
    local angle = _get_angle_by_percent(timer_percent)
    self.v_tween_map[TWEEN_TYPE.POINTER_TWEEN]:ChangeValuesVec3A(0, 0, angle, 0, 0, MAX_ANGLR - 0.01, time)
  end
  self.v_duration_change = false
end

function ui:disable_timer_tween()
  if self.v_tween_map[TWEEN_TYPE.FILL_TWEEN] then
    local tween = self.v_tween_map[TWEEN_TYPE.FILL_TWEEN]
    tween:Pause()
  end
  if self.v_tween_map[TWEEN_TYPE.POINTER_TWEEN] then
    local tween = self.v_tween_map[TWEEN_TYPE.POINTER_TWEEN]
    tween:Pause()
  end
end

function ui:pause_timer_tween()
  self:disable_timer_tween()
end

function ui:play_timer_tween()
  self:create_timer_tween()
  local fill_tween = self.v_tween_map[TWEEN_TYPE.FILL_TWEEN]
  local pointer_tween = self.v_tween_map[TWEEN_TYPE.POINTER_TWEEN]
  if self.v_need_restart then
    fill_tween:Restart()
    pointer_tween:Restart()
    self.v_need_restart = nil
  else
    fill_tween:Play()
    pointer_tween:Play()
  end
  if self.v_tween_map[TWEEN_TYPE.RESTART_FILL] then
    self.v_tween_map[TWEEN_TYPE.RESTART_FILL]:Pause()
    self.v_tween_map[TWEEN_TYPE.RESTART_POINTER]:Pause()
  end
end

function ui:restart_timer_tween()
  self:create_timer_tween()
  self:create_restart_tween()
  local start_fill = self.v_uicompents.Fill_img.fillAmount
  local x, y, z = self.v_uicompents.Pointer1_rect:GetLocalEulerAnglesA3()
  self.v_need_restart = true
  local timer_percent = self:_get_cur_stage_timer_percent()
  local angle = _get_angle_by_percent(timer_percent)
  if self.v_last_timer_percent ~= timer_percent then
    self.v_tween_map[TWEEN_TYPE.RESTART_FILL]:ChangeStartValue(start_fill)
    self.v_tween_map[TWEEN_TYPE.RESTART_FILL]:ChangeEndValue(timer_percent)
    self.v_tween_map[TWEEN_TYPE.RESTART_POINTER]:ChangeValuesVec3A(x, y, z, x, y, angle, 0.3)
    self.v_tween_map[TWEEN_TYPE.FILL_TWEEN]:ChangeStartValue(timer_percent)
    self.v_tween_map[TWEEN_TYPE.POINTER_TWEEN]:ChangeStartValueVec3A(x, y, angle)
  end
  if timer_percent - start_fill > 0.05 then
    self.v_tween_map[TWEEN_TYPE.RESTART_FILL]:Restart()
    self.v_tween_map[TWEEN_TYPE.RESTART_POINTER]:Restart()
  else
    self:refresh_pointer_percent(timer_percent)
  end
  self.v_last_timer_percent = timer_percent
end

function ui:clear_timer_tween()
  self:disable_timer_tween()
  self:refresh_pointer_percent(0)
end

function ui:show_effect_map(effect_map, coms)
  local effect, parent, parent_name
  coms = coms or self.v_uicompents
  for effect_name, parent_str in pairs(effect_map) do
    if not self.v_effect_map[effect_name] then
      self.v_effect_map[effect_name] = Util.get_fight_ui_effect(nil, effect_name)
    end
    effect = self.v_effect_map[effect_name]
    if effect then
      parent_name = string.format(RECT_STR, parent_str)
      parent = coms[parent_name]
      if parent and effect then
        effect.transform:SetParent(parent)
        effect.transform:ResetAttr()
        effect.gameObject:SetActive(true)
      end
    end
  end
end

function ui:release_effect_map(effect_map)
  if not effect_map then
    return
  end
  for effect_name in pairs(effect_map) do
    if self.v_effect_map[effect_name] then
      Util.release_fight_ui_effect(effect_name)
      self.v_effect_map[effect_name] = nil
    end
  end
end

function ui:release_all_stage_effect()
  self:release_effect_map(self.v_effect_map)
end

function ui:release_effect()
  self:release_all_stage_effect()
end

function ui:add_tween(index, tween)
  local Ease = CS.DG.Tweening.Ease
  if not self.v_tween_map[index] then
    tween:Pause()
    tween:SetEase(Ease.Linear)
    tween:SetAutoKill(false)
    self.v_tween_map[index] = tween
  end
end

function ui:clear_all_tween()
  for _, tween in pairs(self.v_tween_map) do
    tween:Kill()
  end
  self.v_tween_map = {}
end

function ui:clear_tween_by_key(key)
  if self.v_tween_map[key] then
    self.v_tween_map[key]:Kill()
    self.v_tween_map[key] = nil
  end
end

return ui
