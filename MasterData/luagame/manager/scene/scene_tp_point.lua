local M = Util.create_class()
local TP_POINT_CFG = require("manager.scene.tp_point_cfg")
local CSFollower = CS.Game.MoveFollower
local PREFAB_NAME = TP_POINT_CFG.PREFAB_NAME
local TP_POINT_STATE = TP_POINT_CFG.TP_POINT_STATE
local ARDER_IDLE = TP_POINT_STATE.ARDER_IDLE
local OPEN = TP_POINT_STATE.OPEN
local CLOSE = TP_POINT_STATE.CLOSE
local IDLE = TP_POINT_STATE.IDLE
local TRANSMIT = TP_POINT_STATE.TRANSMIT
local EFFECTS = TP_POINT_CFG.EFFECTS
local EffectStatusType = TypeEffectStatus
local AnimatorType = TypeUnityAnimator
local UI_POINT_NAME = "AttachPoint"
local START_POINT_NAME = "StartPoint"
local END_POINT_NAME = "EndPoint"

function M:_init(tp_init_data)
  self.v_name = tp_init_data.name
  self.v_index = tp_init_data.idx
  local range = tp_init_data.range
  self.v_range2 = range * range
  self.v_far_range2 = (range + 1) * (range + 1)
  self.v_is_locked = tp_init_data.lock
  self.v_tp_type = tp_init_data.logic_type or 1
  self.v_dir_y = tp_init_data.look_dir
  self.v_height = tp_init_data.height
  self.v_prefab_name = tp_init_data.prefab_name
  self.v_range3 = self.v_range2 * 0.1
  self.v_height_difference = 3
  local position = tp_init_data.position
  self.v_px = position.X
  self.v_pz = position.Z
  self:load_tp_point_gameobj()
end

function M:get_tp_name()
  local tp_name
  if self.v_prefab_name then
    tp_name = self.v_prefab_name
  else
    tp_name = PREFAB_NAME[self.v_tp_type]
  end
  if self.v_is_locked then
    tp_name = tp_name .. "_lock"
  end
  return tp_name
end

function M:born()
  if self.v_is_locked then
    return
  end
  local EFFECTT_TB = EFFECTS[self.v_tp_type]
  for k, v in pairs(EFFECTT_TB) do
    self:_set_effect(k, false)
  end
  self:_set_effect(ARDER_IDLE, true)
end

function M:get_can_tp()
  if self.v_is_locked then
    return false
  end
  return true
end

function M:open()
  if not (not self.v_is_busy and not self.v_is_open and self.v_gameobj_loaded) or self:is_destroy() then
    return
  end
  if self.v_is_locked then
    return
  end
  self:_set_effect(ARDER_IDLE, false)
  self:_play_anim(OPEN, function()
    self.v_is_open = true
    self:_set_effect(IDLE, true)
  end, 1)
end

function M:is_open()
  return self.v_is_open
end

function M:close()
  if not (not self.v_is_busy and self.v_is_open and self.v_gameobj_loaded) or self:is_destroy() then
    return
  end
  self:_set_effect(IDLE, false)
  self:_play_anim(CLOSE, function()
    self.v_is_open = false
    self:_set_effect(ARDER_IDLE, true)
  end, 1.2)
end

function M:die()
end

function M:_play_anim(state_name, cb, delay)
  self:_set_effect(state_name, true)
  if not self.v_animator or self.v_animator:IsNull() then
    if cb then
      cb()
    end
    return
  end
  local anim_name_map = TP_POINT_CFG.STATE2ANIM_NAME[self.v_tp_type]
  if anim_name_map then
    local anim_name = anim_name_map[state_name]
    if anim_name then
      self.v_animator:CrossFadeInFixedTime(anim_name, 0.1)
    end
  end
  self.v_is_busy = true
  if self.v_effect_timer then
    Timer:remove_timer(self.v_effect_timer)
    self.v_effect_timer = nil
  end
  if state_name == TRANSMIT then
    if cb then
      cb()
    end
  else
    self.v_effect_timer = Timer:add_timer("effect", delay, function()
      if state_name ~= TRANSMIT then
        self:_set_effect(state_name, false)
        self.v_is_busy = false
      end
      if cb then
        cb()
      end
    end)
  end
end

function M:_set_effect(state_name, param)
  if self:is_destroy() then
    return
  end
  local effect = self.v_effects[state_name]
  if not effect then
    return
  end
  effect.gameobj:SetActive(param)
end

function M:update()
  if not self.v_gameobj_loaded then
    return
  end
  if Global.hero then
    local px, py, pz = Global.hero:get_pos()
    local dx, dz = px - self.v_px, self.v_pz - pz
    local res = dx * dx + dz * dz
    if res > self.v_far_range2 then
      self:close()
    elseif res < self.v_range2 then
      self:open()
    end
    local is_height_diff_rich = true
    if self.v_height_difference then
      is_height_diff_rich = math.abs(py - self.v_height) < self.v_height_difference
    end
    self:_trigger_door(res < self.v_range3 and is_height_diff_rich)
  end
  self:_update_forbid_position()
end

function M:on_destroy()
  self.v_destoryed = true
  self.v_gameobj_loaded = false
  self.v_animator = nil
  self.v_attach_point = nil
  self.v_start_point = nil
  self.v_end_point = nil
  self.v_notice_lab = nil
  if self.v_notice_obj then
    ResPoolMgr:release(self.v_notice_obj)
  end
  if self.v_game_obj then
    ResPoolMgr:release(self.v_game_obj)
  end
  if self.v_forbid_obj then
    ResPoolMgr:release(self.v_forbid_obj)
  end
  self.v_game_obj = nil
  self.v_notice_obj = nil
  self.v_effects = nil
end

function M:set_visible(is_visible)
  if self:is_destroy() then
    return
  end
  self.v_game_obj:SetActive(is_visible)
end

function M:_create_forbid_title(gameObj)
  local ui = UIMgr:try_get_visible_ui("uidynamic_canvas")
  ui = ui or UIMgr:get_ui("uidynamic_canvas"):ui_show()
  local prefab_name = "TP_Notice"
  ResPoolMgr:get_ui_effect_async(prefab_name, function(go)
    if not self.v_game_obj then
      ResPoolMgr:release(go)
      return
    end
    go.transform:SetParent(ui:get_object_transform())
    go:ResetAttr()
    self.v_attach_point = Util.get_child(UI_POINT_NAME, self.v_game_obj)
    self.v_start_point = Util.get_child(START_POINT_NAME, self.v_game_obj)
    self.v_end_point = Util.get_child(END_POINT_NAME, self.v_game_obj)
    self.v_notice_obj = go
    self.v_notice_lab = go.transform:Find("Label"):GetComponent(TypeUnityUIText)
    self.v_notice_obj:SetActive(false)
  end)
end

function M:_update_forbid_position()
  if not self.v_attach_point then
    return
  end
  if not self.v_is_locked then
    return
  end
  if self.v_notice_obj.activeSelf == false then
    return
  end
  if not Global.ui_dynamic_canvas then
    return
  end
  local x, y, z = self.v_attach_point.transform:GetPositionA()
  local camera = Global.camera:get_camera()
  self.v_canvas_scale_x = Global.ui_dynamic_canvas:get_canvas_scale_x()
  self.v_canvas_scale_y = Global.ui_dynamic_canvas:get_canvas_scale_y()
  CompExtensions.SetToScreenPosInCanvas(camera, self.v_notice_obj.transform, self.v_canvas_scale_x, self.v_canvas_scale_y, x, y, z)
end

function M:load_tp_point_gameobj()
  local tp_name = self:get_tp_name()
  self.v_effects = {}
  ResPoolMgr:get_world_model_async(tp_name, function(game_object)
    game_object.transform:SetPositionA(self.v_px, self.v_height, self.v_pz)
    game_object.transform:SetEulerY(self.v_dir_y)
    local root = UnityFind("tp_fx_root")
    CSFollower.FollowOnce(game_object.gameObject)
    game_object.transform:SetParent(root.transform, true)
    local EFFECTT_TB = EFFECTS[self.v_tp_type]
    for k, v in pairs(EFFECTT_TB) do
      local effect_obj = Util.get_child_gameobj(v, game_object)
      local effect_status = effect_obj:GetComponent(EffectStatusType)
      self.v_effects[k] = {
        name = k,
        gameobj = effect_obj,
        effect_status = effect_status
      }
    end
    self.v_animator = Util.get_component(nil, game_object, AnimatorType)
    self.v_gameobj_loaded = true
    self.v_game_obj = game_object
    local scene_logic = SceneMgr:get_scene_logic()
    local invisible = scene_logic and scene_logic:get_tp_invisible_cache(self.v_index)
    self:set_visible(not invisible)
    self:_create_forbid_title(game_object)
    self:_set_effect_visible()
    self:born()
    self.v_destoryed = false
  end)
end

function M:set_tp_lock(islock)
  local last_lock = self.v_is_locked
  self.v_is_locked = islock
  self:_set_effect_visible()
  if true == last_lock and false == islock then
    self:on_destroy()
    self:load_tp_point_gameobj()
  end
end

function M:_set_effect_visible()
  if self:is_destroy() then
    return
  end
  for _, v in pairs(self.v_effects) do
    v.gameobj:SetActive(not self.v_is_locked)
  end
end

function M:_trigger_door(is_in)
  if not self.v_is_locked then
    return
  end
  if self.v_last_state ~= nil and self.v_last_state == is_in then
    return
  end
  self.v_last_state = is_in
  local msg = MsgGame:mq_publish2(Const.MSG_TRIGGER_TRANSMIT_DOOR)
  msg.mm_x = is_in
  msg.mm_y = self.v_is_locked
  msg.mm_obj = self.v_index
end

function M:show_tp_lock_notice(notice_str)
  if not self.v_notice_obj then
    return
  end
  UIMgr:try_hide_ui("fly_notice")
  local start_pos = self.v_start_point.transform.position
  self.v_attach_point.transform:SetPositionA(start_pos.x, start_pos.y, start_pos.z)
  local end_pos = self.v_end_point.transform.position
  local actions = {
    [1] = {
      action = "do_move",
      param = {
        tween_obj = self.v_attach_point,
        dir = 2,
        target = end_pos.y,
        interval = 1
      }
    },
    [2] = {
      action = "do_inverval",
      param = {interval = 4}
    },
    [3] = {
      action = "do_fade",
      param = {
        tween_obj = self.v_notice_obj,
        target = 0,
        interval = 0.5
      }
    }
  }
  local param = {desc = notice_str, actions = actions}
  self.v_notice_lab.text = LanguageMgr:get_code_text(notice_str)
  UIMgr:get_ui("fly_notice"):ui_show(param)
end

function M:_get_view_position(position)
  local new_pos = Global.camera:get_camera():WorldToScreenPoint(position)
  local delta_x = Global.ui_dynamic_canvas:get_rect_size_delta_x()
  local delta_y = Global.ui_dynamic_canvas:get_rect_size_delta_y()
  local canvas_scale_x = delta_x / Global.screen_width
  local canvas_scale_y = delta_y / Global.screen_height
  new_pos.x = (new_pos.x - Global.screen_width * 0.5) * canvas_scale_x
  new_pos.y = (new_pos.y - Global.screen_height * 0.5) * canvas_scale_y
  return new_pos
end

function M:get_tp_is_locked()
  return self.v_is_locked
end

function M:transmit(cb)
  if not self.v_gameobj_loaded or self:is_destroy() then
    if cb then
      cb()
    end
    return
  end
  if self.v_is_transmit then
    Log.Info("is_transmit", self.v_is_transmit)
    return
  end
  if self.v_is_locked then
    Log.Info("is_locked", self.v_is_locked)
    return
  end
  self:_play_anim(TRANSMIT, function()
    self.v_is_transmit = true
    if cb then
      cb()
    end
  end, 0.2)
end

function M:get_game_obj()
  return self.v_game_obj
end

function M:is_destroy()
  return self.v_destoryed
end

return M
