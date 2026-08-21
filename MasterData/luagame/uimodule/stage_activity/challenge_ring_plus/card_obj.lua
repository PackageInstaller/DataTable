local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local EffectStatus = TypeEffectStatus
local commonDef = require("cs_share.common_define")
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local CURSE_CARD_TYPE = commonDef.CURSE_CARD_TYPE
local REMOVE_EFFECT = "Fx_UI_Card_eliminate"
local ADD_CURSE_TYPE = curse_com_def.ADD_CURSE_TYPE

function ui:ui_finish_load()
  self.v_canvas_group_com = self.v_uiobjects.Main:GetComponent("CanvasGroup")
end

function ui:ui_on_show()
  self.v_fail_effect = {}
  self:reset_main_alpha()
  if self.v_uiobjects.Fx_UI_Card_door then
    self.v_door_card_trans = self.v_uiobjects.Fx_UI_Card_door.transform
  end
end

function ui:ui_on_destroy()
  self.v_canvas_group_com = nil
end

function ui:check_door_card_show_state(is_on)
  local z = is_on and -1 or 1
  local scale = is_on and 1 or 0.5
  self.v_door_card_trans:SetActive(is_on)
  self.v_door_card_trans:SetLocalPositionA(0, 0, z)
  self.v_door_card_trans:SetLocalScaleA(scale, scale, scale)
end

function ui:set_data(data, is_only_show, card_cfg, is_not_click)
  if is_only_show then
    self.v_card_cfg = card_cfg
    self:set_card_icon()
    if not is_not_click then
      self:set_button_listener(Util.get_button(nil, self.v_object), function()
        self.v_parent_ui:on_click_card(self.v_card_cfg)
      end)
    end
    return
  end
  self.v_card_index = data.card_index
  self.v_is_can_click = data.is_can_click
  self.v_card_cfg = ChallengeRingPlusMgr:get_card_cfg_info(data.card_index)
  local type = self.v_card_cfg.Type
  self.v_curse_val = self.v_card_cfg.CurseValue or 0
  self:check_door_card_show_state(type == CURSE_CARD_TYPE.DOOR)
  local add_val = self.v_card_cfg.CurseValue
  self.v_uiobjects.Curse:SetActive(0 ~= add_val)
  if add_val > 0 then
    add_val = "<color=#E0212C>+" .. add_val .. "</color>"
  elseif 0 == add_val then
    add_val = ""
  else
    add_val = "<color=#ffffff>" .. add_val .. "</color>"
  end
  self.v_uicompents.CurseAdd_txt.text = add_val
  self:set_card_icon()
  self:set_button_listener(Util.get_button(nil, self.v_object), function()
    self:add_click_card(data.card_index)
  end)
end

function ui:get_card_index()
  return self.v_card_index
end

function ui:set_card_icon()
  local type = self.v_card_cfg.Type or self.v_card_cfg.TypeID
  local card_type_cfg = ShareRes.get_curse_ring_card_type_cfg(type)
  local icon = card_type_cfg.Icon
  local type_icon = card_type_cfg.TypeIcon
  local name = card_type_cfg.Name
  local bg = card_type_cfg.Bg
  local desc = card_type_cfg.Desc
  ResMgr:load_set_icon(self.v_uicompents.CardIcon_img, icon, nil, true, self)
  ResMgr:load_set_icon(self.v_uicompents.CardType_img, type_icon, nil, true, self)
  ResMgr:load_set_icon(self.v_uicompents.Bg_img, bg, nil, true, self)
  self.v_uicompents.Title_txt.text = name
  self.v_uicompents.Desc_txt.text = desc
end

function ui:ui_on_hide()
  self:release()
  self.v_door_card_trans = nil
end

function ui:release()
  if self.v_tween then
    self.v_tween:Kill(false)
    self.v_tween = nil
  end
  if self.v_remove_anim_seq then
    self.v_remove_anim_seq:Kill()
    self.v_remove_anim_seq = nil
  end
  if self.v_create_anim_seq then
    self.v_create_anim_seq:Kill()
    self.v_create_anim_seq = nil
  end
  if self.v_door_large_seq then
    self.v_door_large_seq:Kill()
    self.v_door_large_seq = nil
  end
  if self.v_boss_effect_dot then
    self.v_boss_effect_dot:Kill()
    self.v_boss_effect_dot = nil
  end
  if self.v_group_com_tween then
    self.v_group_com_tween:Kill()
    self.v_group_com_tween = nil
  end
  if self.v_select_effect then
    ResMgr:destroy_gameobj(self.v_select_effect)
    self.v_select_effect = nil
  end
  if self.v_suc_effect then
    ResMgr:destroy_gameobj(self.v_suc_effect)
    self.v_suc_effect = nil
  end
  if self.v_remove_effect then
    ResMgr:destroy_gameobj(self.v_remove_effect)
    self.v_remove_effect = nil
  end
  if self.v_create_effect then
    ResMgr:destroy_gameobj(self.v_create_effect)
    self.v_create_effect = nil
  end
  for _, effect in pairs(self.v_fail_effect) do
    ResMgr:destroy_gameobj(effect)
  end
  if self.v_boss_effect then
    ResMgr:destroy_gameobj(self.v_boss_effect)
    self.v_boss_effect = nil
  end
  if self.v_can_click_effect then
    ResMgr:destroy_gameobj(self.v_can_click_effect)
    self.v_can_click_effect = nil
  end
  if self.v_card_suc_timer then
    Timer:remove_timer(self.v_card_suc_timer)
    self.v_card_suc_timer = nil
  end
  if self.v_break_card_timer then
    Timer:remove_timer(self.v_break_card_timer)
    self.v_break_card_timer = nil
  end
  if self.v_remove_card_timer then
    self.v_uicompents.Ani_Fx_UI_Card_break_pd:ResetPD()
    Timer:remove_timer(self.v_remove_card_timer)
    self.v_remove_card_timer = nil
  end
  if self.v_boss_card_show_effect_timer then
    Timer:remove_timer(self.v_boss_card_show_effect_timer)
    self.v_boss_card_show_effect_timer = nil
  end
  self.v_fail_effect = {}
end

function ui:load_effect_obj(effect_res, parent)
  local effect = ResMgr:load_gameobj(Path.get_res_path(effect_res))
  effect.transform:SetParent(parent or self.v_object_transform, false)
  effect.transform:SetLocalPositionA(0, 0, 0)
  effect:SetActive(true)
  return effect
end

function ui:add_click_card(card_index)
  if not self.v_is_can_click then
    return
  end
  local curse_ui = UIMgr:try_get_loaded_ui("curse_ring_card")
  if curse_ui and curse_ui:is_play_anim() then
    return
  end
  local is_in_battle = ChallengeRingPlusMgr:is_in_curse_fighting()
  if is_in_battle then
    return
  end
  if ChallengeRingPlusMgr:is_selecting_card() then
    return
  end
  local ring_ui = UIMgr:try_get_loaded_ui("challenge_ring_plus")
  if ring_ui then
    ring_ui:set_pnl_not_click(true)
  end
  ChallengeRingPlusMgr:req_select_card(card_index)
end

function ui:play_select_effect()
  if Util.is_nil(self.v_select_effect) then
    local SELECT_EFFECT = "Fx_UI_Card_selected"
    self.v_select_effect = self:load_effect_obj(SELECT_EFFECT)
  end
  self.v_select_effect:SetActive(false)
  self.v_select_effect:SetActive(true)
end

function ui:play_select_effect()
  if Util.is_nil(self.v_select_effect) then
    local SELECT_EFFECT = "Fx_UI_Card_selected"
    self.v_select_effect = self:load_effect_obj(SELECT_EFFECT)
  end
  self.v_select_effect:SetActive(false)
  self.v_select_effect:SetActive(true)
end

function ui:play_select_card_anim(cb)
  self:release()
  self:play_select_effect()
  self.v_tween = Util.create_sequence()
  self.v_tween:Append(self.v_object_transform:DOScale(1.2, 0.2))
  self.v_tween:Append(self.v_object_transform:DOScale(1, 0.2))
  self.v_tween:OnComplete(function()
    if cb then
      cb()
    end
    local challenge_ring_plus = UIMgr:try_get_visible_ui("challenge_ring_plus")
    local old_debuff_list = challenge_ring_plus:get_curse_obj_debuff_list() or ChallengeRingPlusMgr:get_debuff()
    local old_curse_value = challenge_ring_plus:get_curse_obj_curse_value() or ChallengeRingPlusMgr:get_curse_val()
    ChallengeRingPlusMgr:record_fight_add_curse_value(ADD_CURSE_TYPE.SELECT_CARD, self.v_card_cfg.CurseValue)
    ChallengeRingPlusMgr:select_card_logic(old_curse_value, old_debuff_list)
  end)
end

function ui:play_skip_card_suc_effect(call_back)
  if self.v_curse_val <= 0 then
    if call_back then
      call_back()
    end
    return
  end
  self:release()
  local suc_effect_res = "Fx_UI_Card_escape_success"
  self.v_suc_effect = self:load_effect_obj(suc_effect_res)
  local effect_status = self.v_suc_effect:GetComponent(EffectStatus)
  local length = effect_status.LifeTime
  if self.v_card_suc_timer then
    Timer:remove_timer(self.v_card_suc_timer)
    self.v_card_suc_timer = nil
  end
  self.v_card_suc_timer = Timer:add_timer("play_skip_card_suc_effect", length, function()
    self.v_card_suc_timer = nil
    if UIMgr:try_get_loaded_ui("challenge_ring_plus") then
      if call_back then
        call_back()
      end
      self:release()
    end
  end)
end

function ui:play_skip_card_fail_effect(call_back)
  if self.v_curse_val <= 0 then
    if call_back then
      call_back()
    end
    return
  end
  self:release()
  local fail_effect_res = "Fx_UI_Card_selected_negative"
  local effect = self:load_effect_obj(fail_effect_res)
  table.insert(self.v_fail_effect, effect)
  fail_effect_res = "Fx_UI_Card_escape_failure"
  effect = self:load_effect_obj(fail_effect_res)
  table.insert(self.v_fail_effect, effect)
  self.v_tween = Util.create_sequence()
  self.v_tween:Append(self.v_object_transform:DOScale(1.2, 0.2))
  self.v_tween:Append(self.v_object_transform:DOScale(1, 0.2))
  self.v_tween:OnComplete(function()
    if call_back then
      call_back()
    end
    self:release()
  end)
end

function ui:play_remove_card_effect(call_back, deduct_time)
  self:release()
  self.v_uicompents.Ani_Fx_UI_Card_break_pd:Play()
  local duration = self.v_uicompents.Ani_Fx_UI_Card_break_pd.duration
  if deduct_time then
    duration = duration - deduct_time
  end
  Global.sound_mgr:play_common_sound("Sound_card_disappear")
  if self.v_card_cfg ~= nil and self.v_card_cfg.Type == CURSE_CARD_TYPE.BOSS then
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.card_boss_UI_SOUND)
  end
  if call_back then
    self.v_remove_card_timer = Timer:add_timer("remove_card_timer", duration, function()
      self.v_remove_card_timer = nil
      if UIMgr:try_get_loaded_ui("challenge_ring_plus") and call_back then
        call_back()
      end
    end)
  end
end

function ui:play_boss_card_show_effect(callback)
  self:release()
  Global.sound_mgr:play_common_sound("Sound_bosscard")
  local effect_name = "Fx_UI_Card_Boss"
  self.v_boss_effect = self:load_effect_obj(effect_name)
  local old_index = self.v_uiobjects.Main.transform:GetSiblingIndex()
  self.v_boss_effect.transform:SetSiblingIndex(old_index > 1 and old_index - 1 or 1)
  local effect_status = self.v_boss_effect:GetComponent(EffectStatus)
  local length = effect_status.LifeTime
  self.v_canvas_group_com.alpha = 0
  local hide_main_time = 1.05
  local show_main_time = length - hide_main_time
  self.v_boss_card_show_effect_timer = Timer:add_timer("boss_card_show_effect_timer", hide_main_time, function()
    self.v_boss_card_show_effect_timer = nil
    if UIMgr:try_get_loaded_ui("challenge_ring_plus") then
      self.v_group_com_tween = self.v_canvas_group_com:DOFade(1, show_main_time)
      self.v_group_com_tween:OnComplete(function()
        if UIMgr:try_get_loaded_ui("challenge_ring_plus") then
          if self.v_boss_effect then
            self.v_boss_effect.gameObject:SetActive(false)
          end
          if callback then
            callback()
          end
        end
      end)
    end
  end)
end

function ui:play_remove_create_door_card_effect(call_back)
  if not self.v_door_card_trans then
    if call_back then
      call_back()
    end
    return
  end
  self:release()
  local break_res = "Fx_UI_Card_eliminate"
  self.v_door_card_trans:SetActive(true)
  self.v_remove_effect = self:load_effect_obj(break_res)
  local effect_status = self.v_remove_effect:GetComponent(EffectStatus)
  local length = effect_status.LifeTime
  self:reset_main_alpha()
  self.v_remove_anim_seq = Util.create_sequence()
  self.v_remove_anim_seq:Append(self.v_canvas_group_com:DOFade(0, length))
  if self.v_break_card_timer then
    Timer:remove_timer(self.v_break_card_timer)
    self.v_break_card_timer = nil
  end
  self.v_break_card_timer = Timer:add_timer("play_break_card_effect", length - 0.3, function()
    self.v_break_card_timer = nil
    if UIMgr:try_get_loaded_ui("challenge_ring_plus") then
      self.v_door_card_trans:SetLocalPositionA(0, 0, -1)
      self.v_door_large_seq = Util.create_sequence()
      self.v_door_large_seq:Append(self.v_door_card_trans:DOScale(1, length))
      self.v_door_large_seq:OnComplete(function()
        if call_back then
          call_back()
        end
      end)
    end
  end)
end

function ui:set_can_click_effect_active(is_active)
  if not Util.is_nil(self.v_can_click_effect) then
    self.v_can_click_effect:SetActive(is_active)
  elseif is_active then
    local SELECT_EFFECT = "Fx_Ani_ChalRingCard_tips"
    self.v_can_click_effect = self:load_effect_obj(SELECT_EFFECT)
    self.v_can_click_effect:SetActive(is_active)
  end
end

function ui:change_click_state(is_on)
  self.v_is_can_click = is_on
  local btn = Util.get_button(nil, self.v_object)
  if btn then
    btn.interactable = self.v_is_can_click
  end
  self:set_can_click_effect_active(is_on)
end

function ui:get_key_pos()
  return self.v_uiobjects.CardType.transform.position
end

function ui:get_card_cfg()
  return self.v_card_cfg
end

function ui:reset_main_alpha()
  self.v_canvas_group_com.alpha = 1
end

return ui
