local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local TRIGGER_SOUND_TYPE = CHARACTER_CONFIG.TRIGGER_SOUND_TYPE
local Input = UnityEngine.Input
local TouchPhase = UnityEngine.TouchPhase
local Math = require("base.mathx")
local _clamp = Math.Clamp
local RectTransformUtility = UnityEngine.RectTransformUtility

function ui:ui_finish_load()
  self.v_slider_control_area = self.v_uicompents.Slider_rect
  self.v_slider_control_area:SetActive(true)
  self.v_is_slider_interacting = false
  local slider = self.v_uicompents.Slider_sld
  self:set_slider_listener(slider, function()
    if not slider.gameObject.activeSelf then
      return
    end
    self:_set_scale_from_scrollbar(slider.value)
  end)
  Util.set_point_down(nil, self.v_uiobjects.Slider, self, function()
    self.v_is_slider_interacting = true
  end)
  Util.set_point_up(nil, self.v_uiobjects.Slider, self, function()
    self.v_is_slider_interacting = false
  end)
  self:set_button("BtnChange", function()
    local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
    if buddy_info and buddy_info.break_lv > 2 then
      self.v_is_showing_big_spine = not self.v_is_showing_big_spine
      self:refresh_ui()
    else
      Util.show_message_tip(2367)
    end
  end)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnPosReset", function()
    self:reset_pos()
    self:_set_scale_from_scrollbar(slider.value)
  end)
  self:set_button("BtnFullScreenClose", function()
    self:hide_and_try_show_break()
  end)
  self:set_button("BtnSpine", function()
    if self.v_anim_data.record_data.play_start then
      if self.v_anim_data.record_data.play_interrupt then
        SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
      end
    else
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
    end
  end)
  self.v_icon_root_rect = self.v_uicompents.ShowHeroIcon_rect
end

function ui:hide_and_try_show_break()
  self:ui_hide()
  CharacterMgr:stop_buddy_sound(TRIGGER_SOUND_TYPE.BREAK, self.v_buddy_id)
  if self.v_break_award then
    UIMgr:get_ui("buddy_break_detil"):ui_show(self.v_buddy_id, self.v_break_award)
  end
end

local default_offset = {
  0,
  0,
  1
}

function ui:ui_on_show(buddy_id, fashion_id, break_award)
  self.v_buddy_id = buddy_id
  self.v_fashion_id = fashion_id
  self.v_is_break = nil ~= break_award
  self.v_break_award = break_award
  self.v_uiobjects.ShowDialog:SetActive(false)
  self.v_uiobjects.Slider:SetActive(not self.v_is_break)
  if fashion_id then
    local fashion_cfg = ShareRes.get_fashion_cfg(fashion_id)
    self.v_show_break_chang_txt = 1 == fashion_cfg.IsBase
    self.v_is_base_fashion = 1 == fashion_cfg.IsBase
  else
    self.v_show_break_chang_txt = true
    self.v_is_base_fashion = true
  end
  self:init_data()
  self:refresh_ui()
  if self.v_is_break then
    self.v_uiobjects.ShowDialog:SetActive(true)
    local sound_index = CharacterMgr:get_trigger_sound_idx(TRIGGER_SOUND_TYPE.BREAK, self.v_buddy_id)
    self.v_uicompents.Dialog_txt.text = sound_index and CharacterMgr:get_trigger_sound_txt(sound_index)
    CharacterMgr:trigger_buddy_sound(TRIGGER_SOUND_TYPE.BREAK, self.v_buddy_id, function(time)
    end)
  end
end

function ui:init_data()
  self.v_big_spine_data = nil
  self.v_simple_spine_data = nil
  self.v_is_showing_big_spine = false
  local spine_id, is_spine, offset = UtilUI.get_hero_display_big_spine(self.v_buddy_id, self.v_fashion_id)
  if spine_id then
    self.v_big_spine_data = {
      val = spine_id,
      is_spine = is_spine,
      offset = offset or default_offset,
      show_floor = false
    }
    if self.v_is_base_fashion then
      local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
      if buddy_info and buddy_info.break_lv > 2 then
        self.v_is_showing_big_spine = true
      end
    else
      self.v_is_showing_big_spine = true
    end
  end
  if not self.v_is_break then
    spine_id, is_spine, offset = UtilUI.get_hero_display_simple_spine(self.v_buddy_id, self.v_fashion_id)
    if spine_id then
      self.v_simple_spine_data = {
        val = spine_id,
        is_spine = is_spine,
        offset = offset or default_offset,
        show_floor = true
      }
    end
  end
  local can_change = not self.v_is_break and self.v_big_spine_data ~= nil and nil ~= self.v_simple_spine_data
  self.v_uiobjects.BtnChange:SetActive(can_change)
  self.v_uiobjects.BtnRet1:SetActive(not self.v_is_break)
  self.v_uiobjects.BtnFullScreenClose:SetActive(self.v_is_break)
  self.v_uiobjects.BtnPosReset:SetActive(not self.v_is_break)
end

function ui:ui_on_hide()
  self:clear_spine_rt()
end

function ui:ui_on_destroy()
  self:clear_spine_rt()
end

function ui:reset_pos()
  self.v_icon_root_rect:SetLocalScaleA(1, 1, 1)
  self.v_icon_root_rect:SetLocalPositionA(0, 0, 0)
  self:_update_scrollbar(1)
end

function ui:refresh_ui()
  self:reset_pos()
  local data = self.v_is_showing_big_spine and self.v_big_spine_data or self.v_simple_spine_data
  self.v_uiobjects.HeroIcon:SetActiveEx(false)
  self.v_uiobjects.HeroRawImg:SetActiveEx(false)
  self.v_uiobjects.HeroRawImg:SetActiveEx(data.is_spine == true)
  self.v_uiobjects.BtnSpine:SetActive(data.is_spine == true and not self.v_is_break)
  self.v_uiobjects.FloorBg:SetActive(true == data.show_floor)
  self.v_uicompents.TxtChange_txt.text = self.v_show_break_chang_txt and (self.v_is_showing_big_spine and "突破映像" or "初始") or "切换"
  if not data.is_spine then
    local offset = data.offset
    
    local function cb(img)
      img.gameObject:SetActive(true)
      img:SetNativeSize()
      img.transform:SetLocalPositionA(offset[1], offset[2], 0)
      img.transform:SetLocalScaleA(offset[3], offset[3], offset[3])
    end
    
    ResMgr:load_set_icon(self.v_uicompents.HeroIcon_img, data.val, cb, true)
    return
  end
  self:init_spine_data()
  self:clear_spine_rt()
  self.v_spine_id = data.val
  self.v_anim_interval = SpineHelper.get_anim_interval(self.v_spine_id)
  self.v_single_anim_delay = SpineHelper.get_single_anim_delay(self.v_spine_id)
  self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.HeroRawImg)
  SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.HeroRawImg)
  self.v_uicompents.HeroRawImg_rect:SetLocalPositionA(data.offset[1], data.offset[2], 0)
  self.v_uicompents.HeroRawImg_rect:SetLocalScaleA(data.offset[3], data.offset[3], data.offset[3])
end

function ui:init_spine_data()
  self.v_spine_id = nil
  self.v_low_update = Global.real_time
  self.v_start_time = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:ui_on_update()
  if not self.v_is_break then
    self:_check_touch()
  end
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

local AXIS = "Mouse ScrollWheel"
local PARAM = ShareRes.get_comm_string_value("CharSpineDisplayParam")
local TOUCH_SCALE_SPEED = PARAM and PARAM[1] or 1
local TOUCH_SCALE_SPEED_M = PARAM and PARAM[2] or 3
local MIN_SCALE = PARAM and PARAM[3] or 0.8
local MAX_SCALE = PARAM and PARAM[4] or 2

function ui:_check_touch()
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    local diff = Input.GetAxis(AXIS)
    if 0 ~= diff then
      self:_on_pinch(diff * TOUCH_SCALE_SPEED_M)
    elseif Input.GetMouseButton(0) then
      if not self.v_last_mouse_pos then
        self.v_last_mouse_pos = Input.mousePosition
        return
      end
      local cur_mouse_pos = Input.mousePosition
      local delta_x = cur_mouse_pos.x - self.v_last_mouse_pos.x
      local delta_y = cur_mouse_pos.y - self.v_last_mouse_pos.y
      if not self.v_is_slider_interacting then
        self:_on_drag(delta_x, delta_y)
      end
      self.v_last_mouse_pos = cur_mouse_pos
    else
      self.v_last_mouse_pos = nil
    end
  elseif 2 == Input.touchCount then
    local touch_1 = Input.GetTouch(0)
    local touch_2 = Input.GetTouch(1)
    local touch_1_pos = touch_1.position
    local touch_2_pos = touch_2.position
    if touch_2.phase == TouchPhase.Ended then
      self.v_touch_cache_distance = nil
      return
    end
    local cur_dis = UnityVector2.Distance(touch_1_pos, touch_2_pos)
    if not self.v_touch_cache_distance then
      self.v_touch_cache_distance = cur_dis
      return
    end
    local diff = cur_dis - self.v_touch_cache_distance
    self:_on_pinch(diff * TOUCH_SCALE_SPEED)
    self.v_touch_cache_distance = cur_dis
  elseif 1 == Input.touchCount then
    self.v_touch_cache_distance = nil
    local touch = Input.GetTouch(0)
    if touch.phase == TouchPhase.Moved then
      if not self.v_last_touch_pos then
        self.v_last_touch_pos = touch.position
        return
      end
      local delta_x = touch.position.x - self.v_last_touch_pos.x
      local delta_y = touch.position.y - self.v_last_touch_pos.y
      if not self.v_is_slider_interacting then
        self:_on_drag(delta_x, delta_y)
      end
      self.v_last_touch_pos = touch.position
    else
      self.v_last_touch_pos = nil
    end
  else
    self.v_touch_cache_distance = nil
  end
end

function ui:_on_pinch(diff)
  local scale = self.v_icon_root_rect:GetLocalScaleA3()
  scale = _clamp(scale + diff, MIN_SCALE, MAX_SCALE)
  self.v_icon_root_rect:SetLocalScaleA(scale, scale, scale)
  self:_update_scrollbar(scale)
end

function ui:_update_scrollbar(scale)
  local scroll_value = (scale - MIN_SCALE) / (MAX_SCALE - MIN_SCALE)
  self.v_uicompents.Slider_sld.value = scroll_value
end

function ui:_set_scale_from_scrollbar(value)
  local scale = MIN_SCALE + value * (MAX_SCALE - MIN_SCALE)
  self.v_icon_root_rect:SetLocalScaleA(scale, scale, scale)
  self:_update_scrollbar(scale)
end

function ui:_on_drag(delta_x, delta_y)
  local x, y = self.v_icon_root_rect:GetLocalPositionA3()
  x = _clamp(delta_x + x, -Global.screen_width, Global.screen_width)
  y = _clamp(delta_y + y, -Global.screen_height, Global.screen_height)
  self.v_icon_root_rect:SetLocalPositionA(x, y)
end

return ui
