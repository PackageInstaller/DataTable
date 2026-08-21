local Layer = require("utils.layer")
local Input = UnityEngine.Input
local CSInput = UnityEngine.Input
local TouchPhase = UnityEngine.TouchPhase
local Vec2 = require("base.vec2")
local UnityVector2 = _ENV.UnityVector2
local CSHelper = _ENV.CSHelper
local UnityFind = _ENV.UnityFind
local TypeSceneContainer = typeof(CS.Game.SceneContainer)
local TYPE_EFFECT_STATUS = TypeEffectStatus
local ScaleListenerType = typeof(CS.ScaleListener)
local EFF_AUDIO_ID_LIST = Config.EFF_AUDIO_ID_LIST
local _abs = math.abs
local _floor = math.floor
local Math = require("base.mathx")
local _lerp = Math.lerp_number
local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_skip = {
    "BtnSkip",
    BIND_TYPE.BUTTON
  },
  v_center_root = {
    "CenterRoot",
    BIND_TYPE.OBJECT
  },
  v_tips = {
    "Tips",
    BIND_TYPE.IMAGE
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnSkip", function()
    self:do_skip()
  end)
  self:set_button("BtnDone", function()
    self:do_skip()
  end)
  self.v_scale_listener = self.v_uiobjects.ScaleListener:GetComponent(ScaleListenerType)
  self.v_animation_root = self:get_child_gameobj("Animation", self.v_object)
  self.v_animation_root:SetActive(false)
end

function ui:do_skip()
  if self.v_star_audio_id then
    Global.sound_mgr:stop_sound_by_id_ex(self.v_star_audio_id)
  end
  if self.v_audio_level then
    Global.sound_mgr:stop_sound_by_id_ex(EFF_AUDIO_ID_LIST[self.v_audio_level][2])
  end
  local do_skip = true
  local suc = DrawCardMgr:try_show_movie(do_skip)
  if suc then
    UIMgr:remove_stace_by_ui_name("uidrawcard_trigger_panel")
  else
    self:ui_hide()
  end
end

function ui:ui_on_show()
  self.v_max_speed = self.v_scale_listener.TuochSpeed
  self.v_max_angle = self.v_scale_listener.Max
  self.v_eff_speed = 1
  self.v_touch_protect = true
  self.v_uiobjects.Tips:SetActive(false)
  self.v_uiobjects.CenterRoot:SetActive(false)
  self.v_uiobjects.BtnSkip:SetActive(false)
  self.v_animation_root:SetActive(false)
  self:clear_timer()
  self.v_timer = Timer:add_timer("uidrawcard_trigger_panel_timer", 1.5, function()
    self.v_uiobjects.Tips:SetActive(true)
    self.v_uiobjects.CenterRoot:SetActive(true)
    self.v_uiobjects.BtnSkip:SetActive(true)
    self.v_animation_root:SetActive(true)
    self.v_touch_protect = false
  end)
  self.v_uiobjects.BtnDone:SetActive(false)
  self.v_is_dragging = false
  self.v_minute_hand = nil
  self.v_hour_hand = nil
  self.v_center_pos = nil
  self.v_angle_offset = nil
  self.v_touch_pos = Vec2.New()
  self.v_uimain = UIMgr:get_ui("uimain")
  self:init_container()
end

function ui:ui_on_hide()
  self:clear_timer()
end

function ui:clear_timer()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
  if self.v_end_timer then
    Timer:remove_timer(self.v_end_timer)
    self.v_end_timer = nil
  end
end

function ui:ui_on_destroy()
end

function ui:init_container()
  local root_gameobj = UnityFind("Root")
  if not root_gameobj or root_gameobj:IsNull() then
    return
  end
  Cinemachine:update_settings(0, 0)
  self.v_container = root_gameobj:GetComponent(TypeSceneContainer)
  self.v_container:Get("Drawcard").transform:SetActive(false)
  self.v_minute_hand = self.v_container:Get("MinuteHand").transform
  self.v_hour_hand = self.v_container:Get("HourHand").transform
  self.v_angle_count = 0
  local _, _, angle_z = self.v_minute_hand:GetLocalEulerAnglesA3()
  self.v_uicompents.CenterRoot_rect:SetLocalEuler(0, 0, -angle_z)
  self.v_vcamera_control = self.v_container:Get("VirtualCamera_Control")
  local vcamera_control = self.v_vcamera_control
  local draw_card_pd_name = FashionMgr:get_curr_fashion_draw_card_pd_name()
  FashionMgr:show_fashion_draw_card_pd(draw_card_pd_name, self.v_vcamera_control)
  self.v_draw_card_pd_go = Util.get_child_gameobj(draw_card_pd_name, vcamera_control)
  self.v_eff2 = Util.get_component("FocusOnClock/Fx_Chouka_2", self.v_draw_card_pd_go, TYPE_EFFECT_STATUS)
  self.v_eff3 = Util.get_component("FocusOnClock/Fx_Chouka_3", self.v_draw_card_pd_go, TYPE_EFFECT_STATUS)
  self.v_eff2:SetSpeed(1)
  self.v_eff3:SetSpeed(1)
  self:load_stars()
  self.v_ani_step_eff = Util.get_child_gameobj("FocusOnClock", self.v_draw_card_pd_go):GetComponent(TypeUnityAnimator)
  self.v_ani_step_camera = Util.get_child_gameobj("CM_vcam", vcamera_control):GetComponent(TypeUnityAnimator)
  self.v_ani_step_clock = self.v_container:Get("Clock"):GetComponent(TypeUnityAnimator)
  self.v_ani_step_eff.speed = 0
  self.v_ani_step_camera.speed = 0
  self.v_ani_step_clock.speed = 0
end

function ui:get_anim_clip(animator, clip_name)
  local clips = animator.runtimeAnimatorController.animationClips
  if clips.Length > 0 then
    for i = 0, clips.Length - 1 do
      if clips[i].name == clip_name then
        return clips[i]
      end
    end
  end
  return nil
end

function ui:load_stars()
  local result_list = DrawCardMgr:get_draw_result()
  local max_quality = 1
  if result_list then
    for i, item in ipairs(result_list) do
      local type_config = Util.get_item_type_cfg(item.id)
      local item_type = type_config.AwardType
      local quality
      if item_type == Config.AWARD_TYPE.ITEM then
        quality = ShareRes.get_item_quality(item.id)
      elseif item_type == Config.AWARD_TYPE.CHARA then
        quality = ShareRes.get_buddy_cfg(item.id).Quality
      elseif item_type == Config.AWARD_TYPE.EQUIP then
        quality = ShareRes.get_equip_quality(item.id)
      end
      max_quality = max_quality > quality and max_quality or quality
    end
  end
  self.v_star_audio_id = max_quality >= 5 and Config.HIGH_QUALITY_AUDIO_ID or Config.NORMAL_QUALITY_AUDIO_ID
  local shuttle_position = Util.get_child_gameobj("CloseToClock/Chongdong", self.v_draw_card_pd_go)
  for q, name in pairs(Config.DRAW_RESULT_QUALITY2_EFFECT_NAME) do
    Util.get_child_gameobj(name, shuttle_position):SetActive(max_quality == q)
  end
end

local vec2_pos = Vec2.New()

function ui:ui_update()
  if not (not self.v_touch_protect and self.v_uimain) or not self.v_minute_hand then
    return
  end
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    if CSInput.GetMouseButtonDown(0) then
      self:check_touch_obj(Input.mousePosition)
    elseif CSInput.GetMouseButton(0) then
      self:check_move_obj(Input.mousePosition)
    elseif CSInput.GetMouseButtonUp(0) then
      self:check_move_end()
    end
  elseif CSInput.touchCount > 0 then
    local touch_1 = CSInput.GetTouch(0)
    if touch_1.phase == TouchPhase.Began then
      self:check_touch_obj(touch_1.position)
    elseif touch_1.phase == TouchPhase.Moved then
      self:check_move_obj(touch_1.position)
    elseif touch_1.phase == TouchPhase.Ended or touch_1.phase == TouchPhase.Canceled then
      self:check_move_end()
    end
  end
end

function ui:check_touch_obj(position)
  position = UtilUI.convert_to_resolution_pos(position)
  self.v_touch_pos.x = position.x
  self.v_touch_pos.y = position.y
  local ray = self.v_uimain:screen_point_to_ray(self.v_touch_pos)
  local dir = ray.direction
  local org = ray.origin
  local max_ray_len = 100
  local layer = Layer.LayerMask.SceneCollider
  local is_hit, obj = CSHelper.RayCastGameObject(org.x, org.y, org.z, dir.x, dir.y, dir.z, max_ray_len, layer)
  if is_hit and nil ~= obj and obj.name == "MinuteHand_" then
    local x, y, z = self.v_minute_hand:GetPositionA()
    local screen_pos_x, screen_pos_y = self.v_uimain:world_to_screen_pos(x, y, z, true)
    self.v_center_pos = Vec2.New(screen_pos_x, screen_pos_y)
    self.v_is_dragging = true
    SignBoardGirlMgr:set_clock_update(false)
    local _, _, hour_angle_z = self.v_hour_hand:GetLocalEulerAnglesA3()
    self.v_hour_start_angle = hour_angle_z
    self.v_last_angle = nil
    self.v_uiobjects.Tips:SetActive(false)
    self.v_uiobjects.CenterRoot:SetActive(false)
  end
end

function ui:check_move_obj(position)
  if self.v_is_dragging then
    position = UtilUI.convert_to_resolution_pos(position)
    self.v_touch_pos.x = position.x
    self.v_touch_pos.y = position.y
    vec2_pos = self.v_touch_pos - self.v_center_pos
    local angle = -UnityVector2.SignedAngle(UnityVector2.up, vec2_pos)
    if angle < 0 then
      angle = angle + 360
    end
    if not self.v_angle_offset then
      local _, _, angle_z = self.v_minute_hand:GetEulerAnglesA3()
      self.v_angle_offset = angle_z - angle
    end
    self.v_minute_hand:SetEuler(0, 0, angle + self.v_angle_offset)
    if not self.v_last_angle then
      self.v_last_angle = angle
      return
    end
    if angle > self.v_last_angle then
      if angle - self.v_last_angle > 180 then
        self.v_angle_count = self.v_angle_count + angle - self.v_last_angle - 360
      else
        self.v_angle_count = self.v_angle_count + angle - self.v_last_angle
      end
    elseif self.v_last_angle - angle < 180 then
      self.v_angle_count = self.v_angle_count + angle - self.v_last_angle
    else
      self.v_angle_count = self.v_angle_count + angle - self.v_last_angle + 360
    end
    self.v_last_angle = angle
    self.v_hour_angle = self.v_hour_start_angle + self.v_angle_count / 12
    self.v_hour_hand:SetEuler(0, 0, self.v_hour_angle)
    self:change_effect_speed(_abs(self.v_angle_count))
  end
end

function ui:change_effect_speed(angle_count)
  local ratio = angle_count / self.v_max_angle
  local speed = _floor(ratio * self.v_max_speed)
  if speed < 1 then
    speed = 1
  elseif speed > self.v_max_speed then
    speed = self.v_max_speed
  end
  self.v_eff2:SetSpeed(speed)
  self.v_eff3:SetSpeed(speed)
  self.v_ani_step_eff:Play("FocusOnClock", -1, ratio)
  self.v_ani_step_camera:Play("FocusOnClock_camera", -1, ratio)
  self.v_ani_step_clock:Play(FashionMgr:get_curr_fashion_clock_anim_name(), -1, ratio)
  local lv = 1
  for i, t in ipairs(EFF_AUDIO_ID_LIST) do
    if ratio >= (i - 1) / 3 then
      lv = i
    end
  end
  if self.v_audio_level ~= lv then
    if self.v_audio_level then
      Global.sound_mgr:stop_sound_by_id_ex(EFF_AUDIO_ID_LIST[self.v_audio_level][2])
    end
    Global.sound_mgr:play_sound_by_id(EFF_AUDIO_ID_LIST[lv][1])
    Global.sound_mgr:play_sound_by_id(EFF_AUDIO_ID_LIST[lv][2])
    self.v_audio_level = lv
  end
end

function ui:check_move_end()
  if self.v_is_dragging then
    self.v_is_dragging = false
    self.v_touch_protect = true
    self.v_uimain:close_to_clock(function()
      self.v_ani_step_eff:Play("FocusOnClock", -1, 0)
      self.v_ani_step_camera:Play("FocusOnClock_camera", -1, 0)
      self.v_ani_step_clock:Play(FashionMgr:get_curr_fashion_clock_anim_name(), -1, 0)
    end)
    if self.v_audio_level then
      Global.sound_mgr:stop_sound_by_id_ex(EFF_AUDIO_ID_LIST[self.v_audio_level][2])
    end
    Global.sound_mgr:play_sound_by_id(self.v_star_audio_id)
    self:clear_timer()
    self.v_end_timer = Timer:add_timer("uidrawcard_trigger_panel_end_timer", 4.3, function()
      self.v_touch_protect = false
      DrawCardMgr:try_show_movie()
      UIMgr:remove_stace_by_ui_name("uidrawcard_trigger_panel")
    end)
  end
end

function ui:response_click_escape()
  return UIMgr.RESPONCE_ESCAPE_TYPE.ESCAPE_CUSTOM
end

return ui
