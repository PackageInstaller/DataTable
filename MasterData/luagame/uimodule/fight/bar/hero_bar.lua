local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local FightDefine = require("cs_share.fight_define")
local BUFF_ITEM_CLASS = require("uimodule.fight.bar.bar_buff_item")
local ShimmerRedPercent = ShareRes.get_comm_value("ShimmerRedPercent")
local TEMP_UNITY_VEC2 = UnityVector2()
local ATTR_TYPE = FightDefine.ATTR_TYPE
local HP_BG_DISAPPEAR_TIME = 0.8
local RECOVER_TIME = 0.8
local RECOVER_GREEN_TIME = RECOVER_TIME / 2
local Ease = CS.DG.Tweening.Ease
local LINE_BAR_MAX_WIDTH = 399
local LINE_BAR_MIN_WIDTH = 20
local LINE_BAR_RANGE = LINE_BAR_MAX_WIDTH - LINE_BAR_MIN_WIDTH
local HP_WIDTH = 380
local HP_BAR_MAX_WIDTH = 380
local HP_BAR_MIN_WIDTH = 0
local HP_BAR_RANGE = HP_BAR_MAX_WIDTH - HP_BAR_MIN_WIDTH
local MAX_ENERGY_POINT = 9
local SHIELD_OFFSET = 16.5
local Vec2 = require("base.vec2")
local TEMP_VEC2 = Vec2.New()
local Math = require("base.mathx")
local ENERGY_POINT_TEMPLETE_KEY = "ENERGY_POINT_TEMPLETE_KEY"
local HERO_BAR_BUFF_ITEM_TEMPLETE_KEY = "HERO_BAR_BUFF_ITEM_TEMPLETE_KEY"
local bar_style_enum = {dot = 2, line = 1}
local ATTR_CHANGE_FUNCS = {
  [ATTR_TYPE.CHAR_HP] = function(self, msg)
    self:update_hero_hp()
  end,
  [ATTR_TYPE.CHAR_HP_MAX] = function(self, msg)
    self:update_hero_hp()
  end,
  [ATTR_TYPE.CHAR_SP] = function(self, msg)
    self:on_hero_sp_change(msg)
  end,
  [ATTR_TYPE.CHAR_FIGHT_LINE_BAR] = function(self, msg)
    self:set_line_bar()
  end,
  [ATTR_TYPE.CHAR_FIGHT_LINE_BAR_MAX] = function(self, msg)
    self:set_line_bar()
  end
}

function ui:on_set_uiobject_visible(object_name, visible)
  if "SpecialBar" == object_name then
    local data = self.v_parent_ui:get_special_bar_data()
    data.visible = visible
  end
  if self.v_uiobjects[object_name] then
    self.v_uiobjects[object_name]:SetActive(visible)
  end
end

function ui:on_update_hero_attr(msg)
  if msg.mm_obj.uuid == Global.hero_uuid and ATTR_CHANGE_FUNCS[msg.mm_x] then
    ATTR_CHANGE_FUNCS[msg.mm_x](self, msg)
  end
end

function ui:on_hero_sp_change(msg)
  if not msg or UtilTable.is_empty(self.v_energy_point_list) then
    return
  end
  self:update_energy_point_progress()
end

function ui:on_hero_sp_point_count_change(msg)
  if Global.hero_uuid == msg.mm_x or UtilTable.is_empty(self.v_energy_point_list) then
    local last_count = msg.mm_y
    local cur_count = msg.mm_obj
    if last_count and cur_count and last_count > cur_count then
      local change_point_count = last_count - cur_count
      for index = last_count, cur_count, -1 do
        if change_point_count > 0 then
          if self.v_energy_point_list[index] then
            self:play_expend_particle(index)
            change_point_count = change_point_count - 1
          end
        else
          break
        end
      end
    end
  end
end

function ui:_update_buff_list(msg)
  if msg.mm_obj then
    local target = msg.mm_x
    if not target or target:is_destroy() then
      return
    end
    if Global.hero.uuid == target.uuid then
      self:update_buff_list()
    end
  end
end

function ui:ui_finish_load()
  self.v_buff_item = {}
  self.v_buff_count = 0
  self.v_uiobjects.BuffTem:SetActive(false)
  self.v_sp_max = ShareRes.get_attr_max(ATTR_TYPE.CHAR_SP)
  self.v_parent_tf = self.v_object.transform.parent
  self.v_energy_point_list = {}
  self.v_heal_dot = self:get_custom_dotween(nil, self.v_uiobjects.RecoverEffectGlow)
  self:register_exist_auto_template(ENERGY_POINT_TEMPLETE_KEY, self.v_uiobjects.SpSldTem, self.v_uiobjects.SpSldContent)
  self:register_exist_auto_template(HERO_BAR_BUFF_ITEM_TEMPLETE_KEY, self.v_uiobjects.BuffTem, self.v_uiobjects.BuffHeroList)
  self.v_bg2_rect = self.v_uicompents.BarFill2_rect
  self:set_bar_style(nil, true)
  self:set_point_count(nil, true)
  self:set_point_state(nil, true)
  self:init_special_bar_visible()
end

function ui:preload()
  local hero_list = SceneMgr:get_hero_list()
  if hero_list then
    local max_energy_count = 0
    local cur_count
    for _, hero in pairs(hero_list) do
      cur_count = hero:get_show_point_count()
      max_energy_count = math.max(max_energy_count, cur_count or 0)
    end
    for _ = 1, max_energy_count do
      self:get_auto_cache(ENERGY_POINT_TEMPLETE_KEY)
    end
    self:give_back_auto_cache(ENERGY_POINT_TEMPLETE_KEY)
  end
end

function ui:bind_mq()
  self:bind_auto_mq(Const.MSG_REMOVE_MAGIC, self._remove_buff, self)
  self:bind_auto_mq(Const.MSG_ADD_MAGIC, self._update_buff_list, self)
  self:bind_auto_mq(Const.MSG_HERO_ATTR_CHANGE, self.on_update_hero_attr, self)
  self:bind_auto_mq(Const.MSG_ON_ROLE_HEAL, self.on_hero_heal, self)
  self:bind_auto_mq(Const.MSG_ON_HERO_SP_POINT_COUNT_CHANGE, self.on_hero_sp_point_count_change, self)
end

function ui:ui_before_show()
  self:bind_mq()
end

function ui:ui_on_show()
  self:reset_heal_effect()
  if Global.hero and not Global.hero:is_destroy() and Global.hero.attr_mgr then
    self.v_last_sp_value = Global.hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_SP)
    self:create_dotween_seq()
    self:refresh()
  end
end

function ui:ui_on_hide()
  for key, point in pairs(self.v_energy_point_list) do
    self:update_ui_visible(point.root, false)
    self.v_energy_point_list[key] = nil
  end
  self:give_back_auto_cache(ENERGY_POINT_TEMPLETE_KEY)
  self.v_energy_point_list = {}
  self.v_last_sp_value = nil
  self:clear_all_tween()
  self:clear_buff_item()
end

function ui:refresh()
  self:update_hero_hp()
  self:set_line_bar()
  self:refresh_energy_point()
  self:clear_buff_item()
  self:update_buff_list()
  self:do_hp_deduct_anima(0, 0)
end

function ui:ui_on_update(dt)
  if Global.hero == nil or Global.hero:is_destroy() or nil == Global.camera then
    return
  end
  self:update_energy_point_progress(dt)
end

function ui:update_hero_hp()
  local hero = Global.hero
  if not hero or hero:is_destroy() or self.v_is_in_recover_tween then
    return
  end
  self:update_recover_hp()
  local hero_uuid = hero.uuid
  if self.v_last_hero_uuid ~= hero_uuid then
    self.v_last_frame_hp = nil
    self.v_last_hero_uuid = hero_uuid
  end
  local hp = hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
  local hp_max = hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP_MAX)
  local hp_percent = hp / hp_max
  self.v_last_frame_hp = self.v_last_frame_hp or hp
  local hp_obj = self.v_uiobjects.BloodFill1
  local shield = hero:get_shield_num()
  if 0 == shield then
    self:update_ui_visible(self.v_uiobjects.BloodShield1, false)
  else
    hp_percent = self:update_hero_shield(shield, hp, hp_max, hp_percent)
  end
  if hp_percent <= 0 then
    hp_obj:SetActive(false)
  else
    self.v_uicompents.BloodFill1_rect:SetSizeDeltaWidthA(HP_BAR_MIN_WIDTH + hp_percent * HP_BAR_RANGE)
    hp_obj:SetActive(true)
  end
  self:clear_hp_red_seq()
  if hp < self.v_last_frame_hp then
    local last_frame_per = math.min(self.v_last_frame_hp / hp_max, 1)
    self:do_hp_deduct_anima(last_frame_per, hp_percent)
  end
  self.v_last_frame_hp = hp
  self:check_shimmer_red(shield + hp / hp_max)
end

function ui:update_hero_shield(shield, hp, hp_max, hp_percent)
  self:update_ui_visible(self.v_uiobjects.BloodShield1, true)
  local width
  if hp_max >= shield + hp then
    width = HP_WIDTH * shield / hp_max
  else
    local max = shield + hp
    local shield_percent = shield / max
    width = HP_WIDTH * shield_percent
    hp_percent = 1 - shield_percent
  end
  self.v_uicompents.BloodShield1_rect:SetSizeDeltaWidthA(width)
  return hp_percent
end

function ui:change_attr(attr_id)
  local func = ATTR_CHANGE_FUNCS[attr_id]
  if func then
    func(self)
  end
end

function ui:get_attr_funcs()
  return ATTR_CHANGE_FUNCS
end

function ui:create_dotween_seq()
  if not self.v_force_img_seq then
    self.v_force_img_seq = Util.create_sequence()
    self.v_force_img_seq:SetAutoKill(false)
  end
end

function ui:clear_hp_red_seq()
  if self.v_hp_dong_seq then
    self.v_hp_dong_seq:Kill()
    self.v_hp_dong_seq = nil
  end
end

function ui:clear_dotween_seq()
  if self.v_force_img_seq then
    self.v_force_img_seq:Kill()
    self.v_force_img_seq = nil
  end
end

function ui:update_sp_sld_val()
end

function ui:set_bar_style(bar_style, is_init)
  local data = self.v_parent_ui:get_special_bar_data()
  bar_style = is_init and data.bar_style or bar_style
  if not bar_style then
    return
  end
  if bar_style == bar_style_enum.dot then
    self.v_uiobjects.Style1:SetActive(true)
    self.v_uiobjects.Style2:SetActive(false)
  elseif bar_style == bar_style_enum.line then
    self.v_uiobjects.Style1:SetActive(false)
    self.v_uiobjects.Style2:SetActive(true)
    if not is_init then
      self:set_line_bar()
    end
  end
  if not is_init then
    data.bar_style = bar_style
  end
end

function ui:set_line_bar()
  if not Global.hero.attr_mgr then
    return
  end
  local value = math.max(Global.hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_FIGHT_LINE_BAR), 0)
  local max_value = math.max(Global.hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_FIGHT_LINE_BAR_MAX), 1)
  local pre = math.max(math.min(value / max_value, 1), 0)
  self.v_bg2_rect.gameObject:SetActive(pre > 0)
  self.v_bg2_rect:SetSizeDeltaWidthA(LINE_BAR_MIN_WIDTH + pre * LINE_BAR_RANGE)
end

function ui:set_point_count(max_count, is_init)
  local data = self.v_parent_ui:get_special_bar_data()
  max_count = is_init and data.max_count or max_count
  if not max_count then
    return
  end
  max_count = math.min(max_count, MAX_ENERGY_POINT)
  local root_tf = self.v_uiobjects.Style1.transform
  local childCount = root_tf.childCount
  for index = 1, childCount - 1 do
    local go = root_tf:GetChild(index).gameObject
    go:SetActive(false)
    local light = Util.get_child("Light", go)
    light:SetActive(true)
  end
  for index = 2, max_count do
    self.v_uiobjects["Style1Block" .. index]:SetActive(true)
  end
  if not is_init then
    data.max_count = max_count
  end
end

function ui:set_point_state(active_list, is_init)
  local data = self.v_parent_ui:get_special_bar_data()
  active_list = is_init and data.active_list or active_list
  if not active_list then
    return
  end
  for key, active in pairs(active_list) do
    if key <= MAX_ENERGY_POINT then
      local dot_light = Util.get_child("Light", self.v_uiobjects["Style1Block" .. key])
      dot_light:SetActive(active)
    end
  end
  if not is_init and data.active_list ~= active_list then
    data.active_list = active_list
  end
end

function ui:refresh_energy_point()
  if not Global.hero or Global.hero:is_destroy() then
    return
  end
  local hero = Global.hero
  local show_point_count = hero:get_show_point_count()
  if not show_point_count or 0 == show_point_count then
    return
  end
  local cur_count = hero:get_charged_point_count()
  for index = 1, show_point_count do
    if not self.v_energy_point_list[index] then
      local obj = self:get_auto_cache(ENERGY_POINT_TEMPLETE_KEY)
      self.v_energy_point_list[index] = {root = obj}
      local point_info = self.v_energy_point_list[index]
      local ui_container = obj:GetComponent(typeof(CS.UIContainer))
      local com_name_list = ui_container.ListCompName
      local com_obj_list = ui_container.ListComponent
      for i = 0, com_name_list.Count - 1 do
        if point_info.fill_img and point_info.max_img then
          break
        end
        if "Fill_img" == com_name_list[i] then
          point_info.fill_img = com_obj_list[i]
        end
        if "Max_img" == com_name_list[i] then
          point_info.max_img = com_obj_list[i]
        end
      end
    end
    self.v_energy_point_list[index].is_comp = index <= cur_count
  end
  self:update_energy_point_progress()
end

function ui:get_energy_effect(effect_name, parent)
  local effect_obj = ResPoolMgr:get_ui_effect(effect_name)
  effect_obj.transform:SetParent(parent.transform)
  effect_obj:ResetAttr()
  local ui_particle = self:get_particle(nil, effect_obj)
  local effect_status = self:get_effect_status(nil, effect_obj.gameObject)
  local effect_length = effect_status and effect_status.LifeTime or 0
  return effect_obj, ui_particle, effect_length
end

function ui:update_energy_point_progress()
  if SceneMgr:global_hero_is_destroyed() then
    return
  end
  local data = Global.hero:get_fake_sp_data()
  Util.update_energy_point_progress(self, self.v_energy_point_list, data.count, Global.hero:get_show_point_count(), data.differen)
end

function ui:play_expend_particle(index)
  local point_info = self.v_energy_point_list[index]
  local effect_name = "Fx_common_energy_button_redFlash"
  local effect_key = effect_name .. index
  Util.play_auto_release_fight_ui_effect(effect_name, effect_key, point_info.root.transform)
end

function ui:play_recover_particle(index)
  local point_info = self.v_energy_point_list[index]
  local effect_name = "Fx_common_energy_button_recoverFlash"
  local effect_key = effect_name .. index
  Util.play_auto_release_fight_ui_effect(effect_name, effect_key, point_info.root.transform)
end

function ui:on_hero_heal(msg)
  if msg.mm_x ~= Global.hero_uuid then
    return
  end
  self.v_uiobjects.RecoverEffectGlow:SetActive(true)
  self.v_heal_dot:Restart()
  local before_hp, now_hp = msg.mm_y, msg.mm_obj
  local hp_max = Global.hero.attr_mgr:get_attr(Config.CHAR_ATTR_TYPE.CHAR_HP_MAX)
  local init_percent, final_percent = before_hp / hp_max, now_hp / hp_max
  local shield = Global.hero:get_shield_num()
  if hp_max < shield + now_hp then
    local shield_percent = shield / hp_max
    final_percent = 1 - shield_percent
  end
  if init_percent >= final_percent then
    return
  end
  self:do_recover_anima(init_percent, final_percent)
end

function ui:reset_heal_effect()
  self.v_uiobjects.RecoverEffectGlow:SetActive(false)
end

function ui:init_special_bar_visible()
  local data = self.v_parent_ui:get_special_bar_data()
  local visible = data.visible == true
  self.v_uiobjects.SpecialBar:SetActive(visible)
end

function ui:ui_on_low_update()
  if not Global.hero then
    return
  end
  self:update_buff_duration()
  if self.v_is_in_recover_tween then
    self:update_recover_hp()
  end
end

function ui:update_buff_duration()
  for index, item in pairs(self.v_buff_item) do
    local magic = item:get_magic()
    if not magic or not magic.cfg then
      self:remove_buff(index)
    elseif magic.cfg.each_frame_update then
      item:update_fillamount(magic.left_duration / magic.duration)
    end
  end
end

function ui:update_buff_list()
  if not Global.hero or not Global.hero.magic_mgr then
    return
  end
  local list = Global.hero.magic_mgr:get_visible_magic_list()
  for magic_id, magic in pairs(list) do
    if not self.v_buff_item[magic_id] then
      local obj = self:get_auto_cache(HERO_BAR_BUFF_ITEM_TEMPLETE_KEY)
      local item = BUFF_ITEM_CLASS:ui_wrap_ex(self, obj, true)
      item:set_data(magic)
      self.v_buff_item[magic_id] = item
    elseif self.v_buff_item[magic_id]:get_magic() ~= magic then
      self.v_buff_item[magic_id]:set_data(magic)
    else
      self.v_buff_item[magic_id]:update_level()
    end
  end
end

function ui:_remove_buff(msg)
  if msg.mm_obj then
    local target = msg.mm_x
    if not target or target:is_destroy() then
      return
    end
    local magic_id = msg.mm_y
    self:remove_buff(magic_id)
    self:update_buff_list()
  end
end

function ui:remove_buff(index, force)
  if self.v_buff_item[index] then
    if not Util.is_destroy(Global.hero) and Global.hero.magic_mgr:get_magic_num(index) > 0 and not force then
      local magic_id = self.v_buff_item[index]:get_magic_id()
      local magic_cfg = ShareRes.get_magic_cfg(magic_id)
      if magic_cfg.logic.UpdateType ~= Config.MagicDefine.UPDATE_TYPE.SeparateTime then
        local magic = Global.hero.magic_mgr:get_magic_by_id(magic_id)
        if magic then
          self.v_buff_item[index]:set_data(magic)
          return
        end
      else
        self.v_buff_item[index]:update_level()
        return
      end
    end
    local item = self.v_buff_item[index]
    self.v_buff_item[index] = nil
    item:ui_hide()
    item:ui_destroy()
    local obj = item:get_lua_object()
    if self.v_auto_cache_to_key[obj] then
      self:give_back_auto_cache_obj(HERO_BAR_BUFF_ITEM_TEMPLETE_KEY, obj)
    end
  end
end

function ui:clear_buff_item()
  for index, item in pairs(self.v_buff_item) do
    self:remove_buff(index, true)
  end
end

function ui:ui_on_destroy()
end

function ui:update_recover_hp()
  local hero = Global.hero
  if not hero or hero:is_destroy() then
    return
  end
  local hp_percent = Global.hero.attr_mgr:get_hp_percent()
  local x, _ = self.v_uicompents.BloodFill1_rect:GetSizeDeltaA()
  local cur_per = (x - HP_BAR_MIN_WIDTH) / HP_BAR_RANGE
  if hp_percent <= cur_per then
    self:pause_recover_anima()
  end
  if self.v_is_in_recover_green_tween then
    local fillAmount = self.v_uicompents.BloodGreen_img.fillAmount
    if hp_percent <= fillAmount then
      self:pause_recover_green_anima()
    end
  end
end

function ui:do_recover_anima(init_percent, final_percent)
  local recover_per = final_percent - init_percent
  if recover_per > 0.01 then
    local _, size_y = self.v_uicompents.BloodFill1_rect:GetSizeDeltaA()
    local size_x
    self.v_is_in_recover_tween = true
    if not self.v_hp_size_delta_tween then
      size_x = HP_BAR_MIN_WIDTH + final_percent * HP_BAR_RANGE
      self.v_hp_size_delta_tween = self.v_uicompents.BloodFill1_rect:DOSizeDeltaA(size_x, size_y, RECOVER_TIME)
      size_x = HP_BAR_MIN_WIDTH + init_percent * HP_BAR_RANGE
      self.v_hp_size_delta_tween:ChangeStartValueVec2A(size_x, size_y)
      self.v_hp_size_delta_tween:SetAutoKill(false)
      self.v_hp_size_delta_tween:SetEase(Ease.OutExpo)
      self.v_hp_size_delta_tween:OnComplete(function()
        self.v_is_in_recover_tween = false
        self:update_hero_hp()
        self:pause_recover_green_anima()
      end)
    else
      size_x = HP_BAR_MIN_WIDTH + init_percent * HP_BAR_RANGE
      self.v_hp_size_delta_tween:ChangeStartValueVec2A(size_x, size_y)
      size_x = HP_BAR_MIN_WIDTH + final_percent * HP_BAR_RANGE
      self.v_hp_size_delta_tween:ChangeEndValueVec2A(size_x, size_y)
      self.v_hp_size_delta_tween:Restart()
    end
    self.v_uiobjects.BloodGreen:SetActive(true)
    if recover_per > 0.15 then
      self.v_is_in_recover_green_tween = true
      if not self.v_recover_green_tween then
        self.v_recover_green_tween = self.v_uicompents.BloodGreen_img:DOFillAmount(final_percent, RECOVER_GREEN_TIME)
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
      self.v_uicompents.BloodGreen_img.fillAmount = final_percent
    end
  else
    self.v_uicompents.BloodFill1_rect:SetSizeDeltaWidthA(HP_BAR_MIN_WIDTH + final_percent * HP_BAR_RANGE)
    self:pause_recover_anima()
  end
end

function ui:pause_recover_anima()
  self.v_is_in_recover_tween = false
  if self.v_hp_size_delta_tween and self.v_hp_size_delta_tween:IsPlaying() then
    self.v_hp_size_delta_tween:Pause()
  end
  self:pause_recover_green_anima()
end

function ui:pause_recover_green_anima()
  self.v_is_in_recover_green_tween = false
  self.v_uiobjects.BloodGreen:SetActive(false)
  if self.v_recover_green_tween and self.v_recover_green_tween:IsPlaying() then
    self.v_recover_green_tween:Pause()
  end
end

function ui:clear_all_tween()
  if self.v_hp_size_delta_tween then
    self.v_hp_size_delta_tween:Kill(false)
    self.v_hp_size_delta_tween = nil
  end
  if self.v_recover_green_tween then
    self.v_recover_green_tween:Kill(false)
    self.v_recover_green_tween = nil
  end
  if self.v_hp_bg_size_delta_tween then
    self.v_hp_bg_size_delta_tween:Kill(false)
    self.v_hp_bg_size_delta_tween = nil
  end
  if self.v_shimmer_red_tween then
    self.v_shimmer_red_tween:Kill(false)
    self.v_shimmer_red_tween = nil
  end
  self.v_is_in_hp_tween = false
  self.v_is_in_recover_tween = false
  self.v_is_in_recover_green_tween = false
end

function ui:do_hp_deduct_anima(last_frame_per, percent)
  if last_frame_per - percent > 0.01 then
    Util.change_component_alpha2(self.v_uicompents.BloodRed_img, 1)
    self.v_is_in_hp_tween = true
    TEMP_UNITY_VEC2:Set(self.v_uicompents.BloodRed_rect:GetSizeDeltaA())
    local _, size_y = self.v_uicompents.BloodRed_rect:GetSizeDeltaA()
    local size_x
    if not self.v_hp_bg_size_delta_tween then
      self.v_uicompents.BloodRed_rect:SetSizeDeltaWidthA(HP_BAR_MIN_WIDTH + last_frame_per * HP_BAR_RANGE)
      size_x = HP_BAR_MIN_WIDTH + percent * HP_BAR_RANGE
      self.v_hp_bg_size_delta_tween = self.v_uicompents.BloodRed_rect:DOSizeDeltaA(size_x, size_y, HP_BG_DISAPPEAR_TIME)
      self.v_hp_bg_size_delta_tween:SetAutoKill(false)
      self.v_hp_bg_size_delta_tween:OnComplete(function()
        self.v_is_in_hp_tween = false
        Util.change_component_alpha2(self.v_uicompents.BloodRed_img, 0)
      end)
    else
      size_x = HP_BAR_MIN_WIDTH + last_frame_per * HP_BAR_RANGE
      self.v_hp_bg_size_delta_tween:ChangeStartValueVec2A(size_x, size_y)
      size_x = HP_BAR_MIN_WIDTH + percent * HP_BAR_RANGE
      self.v_hp_bg_size_delta_tween:ChangeEndValueVec2A(size_x, size_y)
      self.v_hp_bg_size_delta_tween:Restart()
    end
  else
    self.v_is_in_hp_tween = false
    self.v_uicompents.BloodRed_rect:SetSizeDeltaWidthA(HP_BAR_MIN_WIDTH + percent * HP_BAR_RANGE)
    if self.v_hp_bg_size_delta_tween and self.v_hp_bg_size_delta_tween:IsPlaying() then
      self.v_hp_bg_size_delta_tween:Pause()
    end
    Util.change_component_alpha2(self.v_uicompents.BloodRed_img, 0)
  end
end

function ui:check_shimmer_red(hp_percent)
  if hp_percent <= ShimmerRedPercent then
    if self.v_shimmer_red_tween and self.v_shimmer_red_tween:IsPlaying() then
      return
    end
    local color_string = "FF0005"
    Util.set_color(self.v_uicompents.BloodFill1_img, color_string, 1)
    Util.set_color(self.v_uicompents.LightLeft_img, color_string, 1)
    Util.set_color(self.v_uicompents.LightRight_img, color_string, 1)
    if not self.v_shimmer_red_tween then
      self.v_shimmer_red_tween = self.v_uicompents.BloodFill1_img:DOFade(0.4, HP_BG_DISAPPEAR_TIME)
      self.v_shimmer_red_tween:SetLoops(-1, CS.DG.Tweening.LoopType.Yoyo)
      self.v_shimmer_red_tween:SetAutoKill(false)
    else
      self.v_shimmer_red_tween:Restart()
    end
  else
    local color_string = "FFFFFF"
    Util.set_color(self.v_uicompents.BloodFill1_img, color_string, 1)
    Util.set_color(self.v_uicompents.LightLeft_img, color_string, 1)
    Util.set_color(self.v_uicompents.LightRight_img, color_string, 1)
    if self.v_shimmer_red_tween and self.v_shimmer_red_tween:IsPlaying() then
      self.v_shimmer_red_tween:Pause()
    end
  end
end

return ui
