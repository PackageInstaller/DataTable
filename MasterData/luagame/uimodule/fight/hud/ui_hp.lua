local M = Util.create_class()
local WEAK_ITEM_CLASS = require("uimodule.fight.bar.weakness_tem")
local BUFF_ITEM_CLASS = require("uimodule.fight.bar.bar_buff_item")
local CommDefine = require("cs_share.common_define")
local FightConfig = require("uimodule.fight.fight_config")
local NPC_KIND = CommDefine.NPC_KIND
local TEMP_UNITY_VEC2 = UnityVector2()
local _ceil = math.ceil
local _tinsert = table.insert
local UI_POINT_NAME = "attachpoint"
local HP_BG_DISAPPEAR_TIME = 0.8
local FightDefine = require("cs_share.fight_define")
local ATTR_TYPE = FightDefine.ATTR_TYPE
local HP_TXT_SHOW_TIME = 5
local prefab_name = "UI_Hp"
local Ease = CS.DG.Tweening.Ease
local HP_WIDTH = 99
local HP_EFFECT_INIT_X = 11.9
local RECOVER_TIME = 0.8
local RECOVER_GREEN_TIME = RECOVER_TIME / 2
local HIT_EFFECT_NAME = "Fx_UI_Common_HP_1"
local OBJNAME_2_VARNAME = {
  CommonHPNode = "v_common_hp_node",
  EffectBar1 = "v_hp_bar_effect_obj",
  LineNode1 = "v_hp_line_node_obj",
  LineEffect1 = "v_hp_line_effect_obj",
  Enemy_energy = "v_energy_obj",
  BuffEnemyList = "v_buff_list_obj",
  BuffTem = "v_buff_tem",
  Blood_Hp = "v_hp_img_obj",
  BloodShield = "v_hp_shield_obj",
  FriendlyBloodShield = "v_fhp_shield_obj",
  WeaknessList = "v_weak_ness_list",
  WeaknessTem = "v_weak_ness_tem",
  EffectPool = "v_effect_pool",
  WeakEffectRoot = "WeakEffectRoot",
  BloodGreen = "v_blood_green",
  LineParentNode = "v_line_parent_node",
  Blood_HpFriendly = "v_fhp_img_obj"
}
local COMNAME_2_VARNAME = {
  Blood_Hp_img = "v_hp_img",
  Blood_HpFriendly_img = "v_fhp_img",
  Decorate_right_rect = "v_energy_righ_tf",
  Super_Armor_now_img = "v_energy_fill_img",
  Blood_Dong_img = "v_hp_dong_img",
  BloodShield_rect = "v_hp_shield_rect",
  FriendlyBloodShield_rect = "v_fhp_shield_rect",
  Blood_Hp_rect = "v_hp_bg",
  Blood_HpFriendly_rect = "v_fhp_bg",
  Blood_Dong_rect = "v_hp_dong_rect",
  CommonHPNode_rect = "v_common_hp_rect",
  BloodGreen_img = "v_blood_green_img"
}

function M:_init(dynamic_ui)
  self.v_is_destroy = false
  self.v_buff_obj_list = {}
  self.v_dynamic_ui = dynamic_ui
  self.v_visible_record = {}
  self.v_weak_item_list = self.v_weak_item_list or {}
  self.v_weak_item_obj_list = self.v_weak_item_obj_list or {}
  self.v_abnormal_item_list = {}
  self.v_element_effect_map = {}
end

local temp_list_name, temp_list_count, temp_list_comp_name, temp_list_comp_count

function M:_init_uicontainer(go)
  if self.v_is_init_uicontainer then
    return
  end
  local ui_container = go.gameObject:GetComponent(typeof(CS.UIContainer))
  if not ui_container then
    return
  end
  local has_cache_info = true
  if nil == temp_list_name then
    has_cache_info = false
    temp_list_name = {}
    temp_list_comp_name = {}
  end
  local list_name = has_cache_info and temp_list_name or ui_container.ListName
  local list_count = has_cache_info and temp_list_count or list_name.Count
  temp_list_count = list_count
  local list_objects = ui_container.ListObj
  local list_comp_name = has_cache_info and temp_list_comp_name or ui_container.ListCompName
  local list_comp_count = has_cache_info and temp_list_comp_count or list_comp_name.Count
  temp_list_comp_count = list_comp_count
  local list_comp_objects = ui_container.ListComponent
  self.v_uiobjects = {}
  self.v_uicompents = {}
  for i = 0, temp_list_count - 1 do
    local name = list_name[i]
    local var_name = name and OBJNAME_2_VARNAME[name]
    if var_name then
      local object = list_objects[i]
      self.v_uiobjects[name] = object
      self[var_name] = object
      if not has_cache_info then
        temp_list_name[i] = name
      end
    end
  end
  for i = 0, temp_list_comp_count - 1 do
    local name = list_comp_name[i]
    local var_name = name and COMNAME_2_VARNAME[name]
    if var_name then
      local component = list_comp_objects[i]
      self.v_uicompents[name] = component
      self[var_name] = component
      if not has_cache_info then
        temp_list_comp_name[i] = name
      end
    end
  end
  self.v_is_init_uicontainer = true
end

function M:bind_mq()
  Util.bind_msg(self, Const.MSG_ON_ELEMENT_TIMER_START, self._on_element_timer_start, self)
  Util.bind_msg(self, Const.MSG_ON_ELEMENT_TIMER_REMOVE, self._on_element_timer_remove, self)
  Util.bind_msg(self, Const.MSG_ON_ELEMENT_STATE_CHANGE, self._on_element_state_change, self)
  Util.bind_msg(self, Const.MSG_NPC_ELEMENT_VALUE_CHANGE, self._on_element_value_change, self)
  Util.bind_msg(self, Const.MSG_ON_ROLE_HEAL, self._on_role_heal, self)
  Util.bind_msg(self, Const.MSG_TOUGHNESS_CHANGE, self._on_toughness_change, self)
  Util.bind_msg(self, Const.MSG_ON_ROLE_SHIELD_CHANGE, self._role_shield_change, self)
  Util.bind_msg(self, Const.MSG_ON_ABNORMAL_FLAG_CHANGE, self._on_abnormal_flag_change, self)
  Util.bind_msg(self, Const.MSG_ON_GAME_PAUSE, self._on_game_pause_state_change, self)
end

function M:_init_bindings()
  local hp_bar_type = self.v_char:get_hp_bar_type()
  local show_ui_hp = Util.check_show_hp_bar_type(hp_bar_type)
  if not show_ui_hp then
    return
  end
  if not self.v_dynamic_ui then
    return
  end
  self.v_ui_rect_size_x = self.v_dynamic_ui:get_rect_size_delta_x()
  self.v_ui_rect_size_y = self.v_dynamic_ui:get_rect_size_delta_y()
  self.v_canvas_scale_x = self.v_ui_rect_size_x / Global.screen_width
  self.v_canvas_scale_y = self.v_ui_rect_size_y / Global.screen_height
  if not Util.is_nil(self.v_hp_obj) then
    self:_init_uicontainer(self.v_hp_obj)
    self:init_ui_hp()
    self:_init_char_info()
  else
    self.v_is_init_uicontainer = false
    ResPoolMgr:get_ui_effect_async(prefab_name, function(go)
      self:finish_load(go)
      self:_init_char_info()
    end)
  end
end

function M:finish_load(go)
  self.v_hp_obj = go
  self.v_rect_tf = Util.get_rect_transform(nil, go)
  self:_init_uicontainer(go)
  self:init_dynamic_effect()
  self.v_hp_transform = self.v_hp_obj.transform
  local _, init_y = self.v_common_hp_rect:GetAnchoredPositionA()
  self.v_effect_init_y = init_y
  self:init_ui_hp()
end

function M:init_ui_hp()
  self.v_use_hp_img = self.v_hp_img
  self.v_use_hp_img_obj = self.v_hp_img_obj
  self.v_use_hp_bg = self.v_hp_bg
  self.v_use_hp_shield_rect = self.v_hp_shield_rect
  self:set_effect_bar_show(false)
  self.v_weak_ness_tem:SetActive(false)
  self.v_hp_transform:SetParent(self.v_dynamic_ui:get_hp_root_trans())
  self.v_hp_obj:ResetAttr()
  self.v_hp_transform:SetLocalPositionA(9999, 9999, -1)
  if self.v_buff_list_obj then
    self.v_buff_tem:SetActive(false)
  end
  self.v_use_hp_bg:SetSizeDeltaWidthA(HP_WIDTH)
  self.v_hp_width = HP_WIDTH
end

function M:init_dynamic_effect()
end

function M:_load_dynamic_effect(prefab_name, root, init_active)
  local obj = ResPoolMgr:get_ui_effect(prefab_name)
  obj.transform:SetParent(root.transform)
  obj.transform:ResetAttr()
  obj.transform:SetAnchoredPositionA(0, 0)
  obj.transform:SetActive(init_active)
  return obj
end

function M:init_char_info(char, attach_trans)
  self.v_char = char
  self.v_hit_effect_key = HIT_EFFECT_NAME .. char.uuid
  self.v_attach_trans = attach_trans
  self:_init_bindings()
end

function M:_init_char_info()
  if not self.v_is_preload then
    self:set_char_friendly(not self.v_char:is_monster())
  end
  if self.v_energy_obj then
    self:update_ui_visible(self.v_energy_obj, self.v_char:is_have_tough())
  end
  self:update_hp_val()
  self:update_hp_obj_position()
  self:update_enemy_weakness()
  self:bind_mq()
  self:set_visible(true)
end

function M:update_hp_val()
  if not self.v_hp_obj then
    return
  end
  if not self.v_char.attr_mgr then
    return
  end
  if self.v_char.v_is_part_mode then
    return
  end
  local hp = self.v_char.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
  local hp_max = self.v_char.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP_MAX)
  hp = _ceil(hp)
  hp_max = _ceil(hp_max)
  self.v_last_hp = self.v_last_hp or hp
  local percent = hp / hp_max
  self:_update_hp_val(percent, hp, hp_max)
  self:update_shield()
  if not self.v_is_in_recover_green_tween then
    self:update_ui_visible(self.v_blood_green, false)
  end
end

function M:update_shield()
  local shield = self.v_char:get_shield_num()
  if 0 == shield then
    self:update_ui_visible(self.v_use_shield_obj, false)
    return
  end
  if not self.v_last_shield then
    self.v_last_shield = shield
  end
  if self.v_last_shield ~= shield then
    self.v_last_time = HP_TXT_SHOW_TIME
  end
  self.v_last_shield = shield
  self:update_ui_visible(self.v_use_shield_obj, true)
  local hp = self.v_char.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
  local hp_max = self.v_char.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP_MAX)
  local shield_rect = self.v_use_hp_shield_rect
  local hp_percent, shield_percent
  if hp_max < shield + hp then
    shield_percent = shield / (shield + hp)
    hp_percent = 1 - shield_percent
    self.v_use_hp_bg:SetSizeDeltaWidthA(hp_percent * HP_WIDTH)
  else
    shield_percent = shield / hp_max
  end
  shield_rect:SetSizeDeltaWidthA(self.v_hp_width * shield_percent)
end

function M:update_enemy_weakness()
  if not (not Util.is_destroy(self.v_char) and self.v_weak_ness_tem and self.v_weak_ness_list) or not self.v_hp_obj then
    return
  end
  for element_id, attr_id in ipairs(FightDefine.ELEMENT_TO_AB_ATTR) do
    local ab_state = self.v_char.attr_mgr:get_abnormal_status(attr_id)
    if ab_state ~= FightDefine.ABNORMAL_STATUS.CLOSE then
      local weak_item = self:get_weak_item_lua_obj(element_id)
      weak_item:set_id_info(attr_id, self.v_char.uuid)
      weak_item:set_data(true, self.v_char)
      weak_item:set_state(ab_state)
    elseif self.v_weak_item_list[element_id] then
      self.v_weak_item_list[element_id]:set_enable(false)
    end
  end
end

function M:get_weak_item_obj(index)
  if not self.v_weak_item_obj_list[index] or self.v_weak_item_obj_list[index]:IsNull() then
    local obj = ResMgr:instantiate(self.v_weak_ness_tem)
    obj.transform:SetParent(self.v_weak_ness_list.transform)
    obj:ResetAttr()
    obj:SetActive(true)
    obj.name = index
    self.v_weak_item_obj_list[index] = obj
  end
  return self.v_weak_item_obj_list[index]
end

function M:get_weak_item_lua_obj(element_id)
  if not self.v_weak_item_list[element_id] then
    local obj = self:get_weak_item_obj(element_id)
    self.v_weak_item_list[element_id] = WEAK_ITEM_CLASS:ui_wrap(nil, obj)
    self.v_weak_item_list[element_id]:set_ui_hp(self)
    self.v_weak_item_list[element_id]:set_element_info(element_id)
  end
  return self.v_weak_item_list[element_id]
end

function M:update_hp_obj_position()
  if not (not self.v_is_preload and not Util.is_nil(self.v_hp_obj) and Global.camera and self.v_char) or not self.v_char:get_hp_visible() then
    return
  end
  Util.set_ui_follow_npc(self.v_rect_tf.component, self.v_char, 0, UI_POINT_NAME)
end

function M:update_part_hp_val(attr)
  local part_attr = attr
  if not self.v_hp_obj then
    return
  end
  if not part_attr then
    return
  end
  local hp = part_attr[ATTR_TYPE.CHAR_HP]
  local hp_max = part_attr[ATTR_TYPE.CHAR_HP_MAX]
  hp = _ceil(hp)
  hp_max = _ceil(hp_max)
  self.v_last_hp = self.v_last_hp or hp
  local percent = hp / hp_max
  self:_update_hp_val(percent, hp, hp_max)
  self:update_ui_visible(self.v_use_shield_obj, false)
end

function M:_update_hp_val(percent, hp, hp_max)
  self.v_use_hp_bg:SetSizeDeltaWidthA(percent * HP_WIDTH)
  self.v_last_frame_hp = self.v_last_frame_hp or hp
  if self.v_last_frame_hp ~= hp then
    if hp < self.v_last_frame_hp then
      local effect_x = HP_WIDTH * percent + HP_EFFECT_INIT_X
      self.v_common_hp_rect:SetAnchoredPositionA(effect_x, self.v_effect_init_y)
      Util.play_auto_release_fight_ui_effect(HIT_EFFECT_NAME, self.v_hit_effect_key, self.v_common_hp_rect)
      self.v_is_in_hp_tween = true
      local last_frame_per = self.v_last_frame_hp / hp_max
      if last_frame_per - percent > 0.01 then
        if not self.v_hp_bg_fill_tween then
          self.v_hp_bg_fill_tween = self.v_hp_dong_img:DOFillAmount(percent, HP_BG_DISAPPEAR_TIME)
          self.v_hp_bg_fill_tween:ChangeStartValue(last_frame_per)
          self.v_hp_bg_fill_tween:SetAutoKill(false)
          self.v_hp_bg_fill_tween:OnComplete(function()
            self.v_is_in_hp_tween = false
          end)
        else
          self.v_hp_bg_fill_tween:ChangeStartValue(last_frame_per)
          self.v_hp_bg_fill_tween:ChangeEndValue(percent)
          self.v_hp_bg_fill_tween:Restart()
        end
      else
        self.v_is_in_hp_tween = false
        self.v_hp_dong_img.fillAmount = percent
      end
    end
    self.v_last_frame_hp = hp
  else
    self.v_is_in_hp_tween = false
    self.v_hp_dong_img.fillAmount = percent
  end
  if hp <= 0 then
    if self.v_char.set_hp_visible then
      FightDataMgr:set_hp_visible_state(self.v_char.uuid, nil, nil, false)
      self.v_char:set_hp_visible(false)
    end
    self:set_visible(false)
  end
end

function M:clear_hp_obj()
  self:clear_seq()
  if self.v_hp_obj then
    local hp_rect = self.v_use_hp_bg
    hp_rect:SetSizeDeltaWidthA(self.v_hp_width)
    ResPoolMgr:release(self.v_hp_obj)
    self.v_hp_obj = nil
    self.v_rect_tf = nil
    self.v_hp_transform = nil
    self.v_is_init_uicontainer = false
  end
  self:clear_all_tween()
end

function M:low_update()
  if not (not self.v_is_preload and not Util.is_nil(self.v_hp_obj) and Global.camera) or not self.v_dynamic_ui then
    return
  end
  if self.v_is_in_recover_tween then
    self:update_recover_hp()
  end
end

local DESTROY_TYPE = {BY_ROLE = 1, BY_POOL = 2}

function M:on_destroy()
  Util.unbind_all_msg(self)
  for key, item in pairs(self.v_weak_item_list) do
    item:ui_hide()
    item:ui_destroy()
  end
  self.v_weak_item_obj_list = nil
  self.v_weak_item_list = nil
  self:clear_all_buff_obj()
  self:release_dynamic_effect()
  self:set_effect_bar_show(false)
  self:set_visible(false)
  self:clear_hp_obj()
  self.v_dynamic_ui = nil
  self.v_char = nil
  self.v_attach_trans = nil
  self.v_hit_effect_key = nil
  self.v_is_destroy = true
end

function M:release_dynamic_effect()
  self:release_element_effect()
end

function M:set_visible(is_visible)
  if not self.v_hp_obj then
    return
  end
  self:update_ui_visible(self.v_hp_obj, is_visible)
end

function M:set_effect_bar_length(length)
  if not self.v_hp_line_effect_obj then
    return
  end
  local _, scale_y, scale_z = self.v_hp_bar_effect_obj.transform:GetLocalScaleA3()
  self.v_hp_bar_effect_obj.transform:SetLocalScaleA(0.5 * length, scale_y, scale_z)
  self.v_hp_line_effect_obj.transform:GetPositionA(self.v_hp_line_node_obj.transform:GetPositionA())
end

function M:set_effect_bar_show(is_show)
  if is_show then
    if not self.v_hp_line_effect_obj then
      self.v_hp_line_effect_obj = self:_load_dynamic_effect("Fx_UI_Element_Dark_1_2", self.v_line_parent_node, false)
    end
    if not self.v_hp_bar_effect then
      self.v_hp_bar_effect = self:_load_dynamic_effect("Fx_UI_Element_Dark_1_1", self.v_hp_bar_effect_obj, true)
    end
    self.v_hp_line_effect_obj:SetActive(is_show)
    self.v_hp_bar_effect_obj:SetActive(is_show)
  else
    if self.v_hp_line_effect_obj then
      ResPoolMgr:release(self.v_hp_line_effect_obj)
      self.v_hp_line_effect_obj = nil
    end
    if self.v_hp_bar_effect then
      ResPoolMgr:release(self.v_hp_bar_effect)
      self.v_hp_bar_effect = nil
    end
  end
end

function M:is_have_effect_bar()
  return self.v_hp_line_effect_obj and self.v_hp_bar_effect_obj and not self.v_hp_line_effect_obj:IsNull() and not self.v_hp_bar_effect_obj:IsNull()
end

local MAX_RIGHT_X = 123
local MIN_RIGHT_X = 2
local INTERVAL_RIGHT_X = MAX_RIGHT_X - MIN_RIGHT_X

function M:update_tough_bar()
  local info = self.v_char:get_toughness_info()
  if info then
    local pre = info.cur_tough_value / info.max_tough_value
    self.v_energy_fill_img.fillAmount = pre
    self.v_energy_righ_tf.transform:SetAnchoredPositionX(INTERVAL_RIGHT_X * pre)
    self:update_ui_visible(self.v_energy_obj, true)
  else
    self:update_ui_visible(self.v_energy_obj, false)
  end
end

function M:is_have_enery_obj()
  return self.v_energy_obj ~= nil and not self.v_energy_obj:IsNull() and self.v_energy_obj.activeInHierarchy
end

function M:is_have_buff_list_obj()
  return false
end

function M:refresh_abnormal_duration_item(element_id)
  if Util.is_destroy(self.v_char) then
    return
  end
  if not self.v_abnormal_item_list[element_id] then
    local obj = self:get_buff_obj(element_id)
    self.v_abnormal_item_list[element_id] = BUFF_ITEM_CLASS:ui_wrap_ex(nil, obj, true)
  end
  local time_attr_id = Config.FightDefine.AB_ATTR_TO_TIME[element_id]
  local cd_time = self.v_char.attr_mgr:get_attr(time_attr_id)
  self.v_abnormal_item_list[element_id]:set_element_buff_data(element_id, cd_time)
end

function M:remove_abnormal_duration_item(element_id)
  if self.v_abnormal_item_list[element_id] then
    self.v_abnormal_item_list[element_id]:ui_hide()
    self.v_abnormal_item_list[element_id]:ui_destroy()
    self.v_abnormal_item_list[element_id] = nil
  end
end

function M:get_buff_obj(element_id)
  if not self.v_buff_obj_list[element_id] then
    local obj = ResMgr:instantiate(self.v_buff_tem.gameObject, false)
    obj.transform:SetParent(self.v_buff_list_obj.transform)
    obj.transform:ResetAttr()
    self.v_buff_obj_list[element_id] = obj
  end
  return self.v_buff_obj_list[element_id]
end

function M:clear_all_buff_obj()
  local item
  for element_id, obj in pairs(self.v_buff_obj_list) do
    item = self.v_abnormal_item_list[element_id]
    if item then
      item:ui_hide()
      item:ui_destroy()
      self.v_abnormal_item_list[element_id] = nil
    end
    ResMgr:destroy_gameobj(obj)
    self.v_buff_obj_list[element_id] = nil
  end
end

function M:update_ui_visible(ui_obj, is_visible)
  if self.v_visible_record[ui_obj] == is_visible then
    return
  end
  self.v_visible_record[ui_obj] = is_visible
  ui_obj.gameObject:SetActive(is_visible)
end

function M:get_cache_element_effect(effect_name, callback)
  self.v_element_effect_map[effect_name] = self.v_element_effect_map[effect_name] or {}
  local effects = self.v_element_effect_map[effect_name]
  local length = #effects
  if length > 1 then
    local go = effects[length]
    effects[length] = nil
    if callback then
      callback(go)
    end
  else
    ResPoolMgr:get_ui_effect_async(effect_name, function(go)
      if Util.is_nil(go) then
        return
      end
      if callback then
        callback(go)
      end
    end)
  end
end

function M:release_element_effect()
  for key, effects in pairs(self.v_element_effect_map) do
    for index, obj in ipairs(effects) do
      ResPoolMgr:release(obj)
      effects[index] = nil
    end
  end
end

function M:get_element_effect(element_id, callback)
  local effect_name = FightConfig.ELEMENT_ICON_EFFECT_LOW[element_id]
  self:get_cache_element_effect(effect_name, callback)
end

function M:give_back_element_effect(element_id, obj)
  if Util.is_nil(obj) then
    return
  end
  local effect_name = FightConfig.ELEMENT_ICON_EFFECT_LOW[element_id]
  self.v_element_effect_map[effect_name] = self.v_element_effect_map[effect_name] or {}
  table.insert(self.v_element_effect_map[effect_name], obj)
  obj.transform:SetParent(self.WeakEffectRoot.transform)
end

function M:clear_seq()
  if self.v_hp_bg_disappear_seq then
    self.v_hp_bg_disappear_seq:Kill(false)
    self.v_hp_bg_disappear_seq = nil
  end
end

function M:_on_element_timer_remove(msg)
  if self:disabled() then
    return
  end
  local uuid, element_id = msg.mm_obj, msg.mm_x
  if not (uuid and element_id) or self.v_char.uuid ~= uuid then
    return
  end
  if self:is_weak_can_update(element_id) then
    self.v_weak_item_list[element_id]:set_data(true)
  end
end

function M:_on_element_state_change(msg)
  if self:disabled() then
    return
  end
  local uuid = msg.mm_obj
  if not uuid or self.v_char.uuid ~= uuid then
    return
  end
  self:update_enemy_weakness()
end

function M:_on_element_value_change(msg)
  if self:disabled() then
    return
  end
  local uuid = msg.mm_obj
  local element_id = msg.mm_x
  if not uuid or self.v_char.uuid ~= uuid then
    return
  end
  if self:is_weak_can_update(element_id) then
    self.v_weak_item_list[element_id]:set_data()
  end
end

function M:_on_element_timer_start(msg)
  if self:disabled() then
    return
  end
  local uuid, element_id = msg.mm_obj, msg.mm_x
  if not (uuid and element_id) or self.v_char.uuid ~= uuid then
    return
  end
  if self:is_weak_can_update(element_id) then
    self.v_weak_item_list[element_id]:show_effect()
  end
end

function M:_on_toughness_change()
  if self:disabled() then
    return
  end
  self:update_tough_bar()
end

function M:_role_shield_change(msg)
  if Util.is_destroy(self.v_char) then
    return
  end
  local is_hero = msg.mm_x
  if is_hero then
    return
  end
  local uuid = msg.mm_obj
  if uuid ~= self.v_char.uuid then
    return
  end
  self:update_hp_val()
end

function M:_on_abnormal_flag_change(msg)
  if Util.is_destroy(self.v_char) then
    return
  end
  local uuid, element_id = msg.mm_obj, msg.mm_x
  if not (uuid and element_id) or self.v_char.uuid ~= uuid then
    return
  end
  if self:is_weak_can_update(element_id) then
    self.v_weak_item_list[element_id]:set_data(true)
  end
end

function M:_on_game_pause_state_change(msg)
  for key, item in pairs(self.v_abnormal_item_list) do
    item:on_game_pause_state_change(msg.mm_x)
  end
end

function M:update_recover_hp()
  local hp_percent = self.v_char.attr_mgr:get_hp_percent()
  local x, _ = self.v_use_hp_bg:GetSizeDeltaA()
  local cur_per = x / HP_WIDTH
  if hp_percent <= cur_per then
    self:pause_recover_anima()
  end
  if self.v_is_in_recover_green_tween then
    local fillAmount = self.v_blood_green_img.fillAmount
    if hp_percent <= fillAmount then
      self:pause_recover_green_anima()
    end
  end
end

function M:do_recover_anima(init_percent, final_percent)
  local recover_per = final_percent - init_percent
  if recover_per > 0.01 then
    self.v_is_in_recover_tween = true
    self.v_use_hp_bg:SetSizeDeltaWidthA(init_percent * HP_WIDTH)
    local _, sy = self.v_use_hp_bg:GetSizeDeltaA()
    if not self.v_hp_rect_tween then
      self.v_hp_rect_tween = self.v_use_hp_bg:DOSizeDeltaA(final_percent * HP_WIDTH, sy, RECOVER_TIME, init_percent * HP_WIDTH, sy)
      self.v_hp_rect_tween:SetAutoKill(false)
      self.v_hp_rect_tween:SetEase(Ease.OutExpo)
      self.v_hp_rect_tween:OnComplete(function()
        self.v_is_in_recover_tween = false
        self:update_hp_val()
      end)
    else
      self.v_hp_rect_tween:ChangeStartValueVec2A(init_percent * HP_WIDTH, sy)
      self.v_hp_rect_tween:ChangeEndValueVec2A(final_percent * HP_WIDTH, sy)
      self.v_hp_rect_tween:Restart()
    end
    self:update_ui_visible(self.v_blood_green, true)
    if recover_per > 0.15 then
      self.v_is_in_recover_green_tween = true
      if not self.v_recover_green_tween then
        self.v_recover_green_tween = self.v_blood_green_img:DOFillAmount(final_percent, RECOVER_GREEN_TIME)
        self.v_recover_green_tween:ChangeStartValue(init_percent)
        self.v_recover_green_tween:SetAutoKill(false)
        self.v_recover_green_tween:SetEase(Ease.OutExpo)
        self.v_recover_green_tween:OnComplete(function()
          self.v_is_in_recover_green_tween = false
        end)
      else
        self.v_recover_green_tween:ChangeStartValue(init_percent)
        self.v_recover_green_tween:ChangeEndValue(final_percent)
        self.v_recover_green_tween:Restart()
      end
    else
      self.v_is_in_recover_green_tween = false
      self.v_blood_green_img.fillAmount = final_percent
    end
  else
    self.v_use_hp_bg:SetSizeDeltaWidthA(final_percent * HP_WIDTH)
    self:pause_recover_anima()
  end
end

function M:clear_all_tween()
  if self.v_hp_bg_fill_tween then
    self.v_hp_bg_fill_tween:Kill(false)
    self.v_hp_bg_fill_tween = nil
  end
  if self.v_hp_rect_tween then
    self.v_hp_rect_tween:Kill(false)
    self.v_hp_rect_tween = nil
  end
  if self.v_recover_green_tween then
    self.v_recover_green_tween:Kill(false)
    self.v_recover_green_tween = nil
  end
  self.v_is_in_hp_tween = false
  self.v_is_in_recover_tween = false
  self.v_is_in_recover_green_tween = false
end

function M:pause_recover_anima()
  self.v_is_in_recover_tween = false
  if self.v_recover_tween and self.v_recover_tween:IsPlaying() then
    self.v_recover_tween:Pause()
  end
  self:pause_recover_green_anima()
  self:update_hp_val()
end

function M:pause_recover_green_anima()
  if not self.v_is_in_recover_green_tween then
    return
  end
  self.v_is_in_recover_green_tween = false
  self:update_ui_visible(self.v_blood_green, false)
  if self.v_recover_green_tween and self.v_recover_green_tween:IsPlaying() then
    self.v_recover_green_tween:Pause()
  end
end

function M:_on_role_heal(msg)
  if Util.is_destroy(self.v_char) or self.v_char:is_die() or self.v_char.uuid ~= msg.mm_x or self.v_is_preload then
    return
  end
  local before_hp, now_hp = msg.mm_y, msg.mm_obj
  local hp_max = self.v_char.attr_mgr:get_attr(Config.CHAR_ATTR_TYPE.CHAR_HP_MAX)
  local init_percent, final_percent = before_hp / hp_max, now_hp / hp_max
  local shield = self.v_char:get_shield_num()
  if hp_max < shield + now_hp then
    local shield_percent = shield / hp_max
    final_percent = 1 - shield_percent
  end
  if init_percent >= final_percent then
    return
  end
  self:do_recover_anima(init_percent, final_percent)
end

function M:preload()
  if not Util.is_nil(self.v_hp_obj) then
    return
  end
  self.v_is_preload = true
  local go = ResPoolMgr:get_ui_effect(prefab_name)
  self:finish_load(go)
  self:set_visible(false)
  for element_id = 2, 6 do
    self:get_weak_item_lua_obj(element_id)
  end
  self.v_is_preload = false
end

function M:disabled()
  return Util.is_destroy(self.v_char) or self.v_is_destroy or self.v_is_preload or Util.is_nil(self.v_hp_obj)
end

function M:set_char_friendly(is_friendly)
  self.v_is_friendly = is_friendly
  if self.v_is_friendly then
    self:update_ui_visible(self.v_fhp_img_obj, true)
    self:update_ui_visible(self.v_hp_img_obj, false)
    self.v_use_hp_img = self.v_fhp_img
    self.v_use_hp_img_obj = self.v_fhp_img_obj
    self.v_use_hp_bg = self.v_fhp_bg
    self.v_use_shield_obj = self.v_fhp_shield_obj
    self.v_use_hp_shield_rect = self.v_fhp_shield_rect
  else
    self:update_ui_visible(self.v_hp_img_obj, true)
    self:update_ui_visible(self.v_fhp_img_obj, false)
    self.v_use_hp_img = self.v_hp_img
    self.v_use_hp_img_obj = self.v_hp_img_obj
    self.v_use_hp_bg = self.v_hp_bg
    self.v_use_shield_obj = self.v_hp_shield_obj
    self.v_use_hp_shield_rect = self.v_hp_shield_rect
  end
end

function M:is_weak_can_update(element_id)
  if element_id and self.v_weak_item_list[element_id] then
    local attr_id = Config.FightDefine.ELEMENT_TO_AB_ATTR[element_id]
    local ab_state = self.v_char.attr_mgr:get_abnormal_status(attr_id)
    return ab_state ~= FightDefine.ABNORMAL_STATUS.CLOSE
  end
end

return M
