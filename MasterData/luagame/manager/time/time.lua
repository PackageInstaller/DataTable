local Base = require("obj.base_component")
local _tinsert = table.insert
local _tremove = table.remove
local TimeScale = Util.create_child_mt(Base)

local function _sort_time_scale_func(a, b)
  local a_effect_type, b_effect_type = a:get_effect_type(), b:get_effect_type()
  local a_add_order_num, b_add_order_num = a:get_effect_type(), b:get_effect_type()
  if a_effect_type ~= b_effect_type then
    return a_effect_type < b_effect_type
  elseif a_add_order_num ~= b_add_order_num then
    return a_add_order_num < b_add_order_num
  else
    return false
  end
end

function TimeScale:_init(scale, duration, add_order_num, scale_data)
  local ignoral_missile = scale_data.ignoral_missile
  local impact_sound_type = scale_data.impact_sound_type
  if Global.enable_time_scale_debug then
    self.idx = Util.get_index()
  end
  self.v_target_scale = scale
  self.v_ease_in = scale_data.ease_in or 0
  self.v_ease_out = scale_data.ease_out or 0
  self:set_start_scale(scale_data.start_scale)
  self.v_global_scale_index = scale_data.global_scale_index
  self.v_elapse = 0
  self.v_duration = duration
  self.v_ignoral_missile = nil ~= ignoral_missile and ignoral_missile > 0 or false
  self.v_impact_sound_type = nil ~= impact_sound_type and impact_sound_type or 0
  self.v_impact_sound_volume = scale_data.impact_sound_volume
  self.v_igonre_move = scale_data.ignore_move or false
  self.v_global_time_scale = false
  self.v_effect_type = scale_data.effect_type or Config.TIME_SCALE_EFFECT_TYPE.NORMAL
  self.magic_id = scale_data.magic_id
  self.v_add_order_num = add_order_num
end

function TimeScale:update()
  self.v_elapse = self.v_elapse + Global.delta_time
end

function TimeScale:get_scale()
  if self.v_elapse < self.v_ease_in then
    return self.v_start_scale + self.v_elapse * self.v_target_sub_start / self.v_ease_in
  elseif self.v_elapse + self.v_ease_out > self.v_duration then
    local percent_ease_out = (self.v_elapse - (self.v_duration - self.v_ease_out)) / self.v_ease_out
    return self.v_target_scale + percent_ease_out * -self.v_target_sub_start
  else
    return self.v_target_scale
  end
end

function TimeScale:is_end()
  return self.v_elapse >= self.v_duration
end

function TimeScale:get_is_ignoral_missile()
  return self.v_ignoral_missile
end

function TimeScale:set_global_scale()
  self.v_global_time_scale = true
end

function TimeScale:get_is_global_scale()
  return self.v_global_time_scale
end

function TimeScale:set_global_scale_index(global_scale_index)
  self.v_global_scale_index = global_scale_index
end

function TimeScale:get_global_scale_index()
  return self.v_global_scale_index
end

function TimeScale:get_impact_sound_type()
  return self.v_impact_sound_type, self.v_impact_sound_volume
end

function TimeScale:get_is_ignore_move()
  return self.v_igonre_move
end

function TimeScale:get_effect_type()
  return self.v_effect_type
end

function TimeScale:set_start_scale(start_scale)
  self.v_start_scale = start_scale
  self.v_target_sub_start = self.v_target_scale - self.v_start_scale
end

function TimeScale:on_destroy()
  self.v_target_scale = nil
  self.v_ease_in = nil
  self.v_ease_out = nil
  self.v_start_scale = nil
  self.v_target_sub_start = nil
  self.v_elapse = nil
  self.v_duration = nil
  self.v_ignoral_missile = nil
  self.v_impact_sound_type = nil
  self.v_impact_sound_volume = nil
  self.v_igonre_move = nil
  self.v_global_time_scale = nil
  self.v_effect_type = nil
  self.magic_id = nil
  self.v_add_order_num = nil
  self.v_global_scale_index = nil
end

local function get_scale_info_uri(scale_info)
  if not scale_info then
    return "nil|nil"
  end
  local magic = tostring(scale_info.magic_id)
  local scale = scale_info.v_target_scale
  scale = scale and string.format("%.3f", scale) or "nil"
  local ret = magic .. "|" .. scale
  return string.format("%-20s", ret)
end

local M = Util.create_child_mt(Base)
local GLOBAL_STATE = {
  NONE = 1,
  ADD = 2,
  REMOVE = 3
}
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local TIME_SCALE_PARAM_POOL = LuaObjPoolMgr.get_pool("time_scale_param") or LuaObjPoolMgr.register("time_scale_param", 50, TimeScale)

function M:_init(char)
  Base._init(self)
  self.v_char = char
  self.v_scales = {}
  self.v_time_scale = 1
  self.v_add_order_num = 0
  self.v_effect_count = 0
  self.v_time = 0
  self.v_add_index = 0
  self.v_ignoral_missile = false
  self.v_global_scale = false
  self.v_global_cnt = 0
  self.v_global_state = GLOBAL_STATE.NONE
  self.v_last_effect_scale = nil
end

function M:on_before_destroy()
end

function M:on_destroy()
  Base.on_destroy(self)
  self:clear_rejoin_timer_on_remove()
  self:remove_all_time_scale()
end

function M:update()
  local last_ignore_missile = self.v_ignoral_missile
  local time_scale, magic_id = self:update_scale_info()
  if time_scale ~= self.v_time_scale or last_ignore_missile ~= self.v_ignoral_missile then
    local cur_effect_scale = self.v_scales[0] or self.v_scales[1]
    if self.v_last_effect_scale and self.v_last_effect_scale ~= cur_effect_scale and cur_effect_scale and cur_effect_scale then
      cur_effect_scale:set_start_scale(time_scale)
    end
    self.v_last_effect_scale = cur_effect_scale
    self.v_char:on_time_scale(time_scale, false, self.v_impact_sound_type, self.v_impact_sound_volume)
    self.v_time_scale = time_scale
    if Global.enable_time_scale_debug and Global.ui_dynamic_canvas and self.v_char.is_role and self.v_char:is_role() then
      local is_dif_info = self.v_last_idx ~= (cur_effect_scale and cur_effect_scale.idx)
      local visible = not self.v_char.in_background
      if visible then
        local ui_item = Global.ui_dynamic_canvas:get_follow_debug_info(self.v_char)
        if ui_item then
          ui_item:set_time_scale_text(string.format("x%.3f", time_scale))
        end
      else
        Global.ui_dynamic_canvas:destroy_follow_debug_info(self.v_char)
      end
      if is_dif_info then
        local str = "%s|%s: 时停变化 "
        str = str:format(self.v_char:get_npc_id(), self.v_char.uuid)
        local oldInfoStr = tostring(self.v_last_magic_id)
        local oldScaleStr = self.v_last_target_scale
        oldScaleStr = oldScaleStr and string.format("%.3f", oldScaleStr) or "nil"
        local oldStr = oldInfoStr .. "|" .. oldScaleStr
        oldStr = string.format("%-20s", oldStr)
        Log.Error(str .. "old:" .. oldStr .. ", new:" .. get_scale_info_uri(cur_effect_scale))
      end
      self.v_last_magic_id = magic_id
      self.v_last_target_scale = cur_effect_scale and cur_effect_scale.v_target_scale
      self.v_last_idx = cur_effect_scale and cur_effect_scale.idx
    end
  end
  if self.v_global_state ~= GLOBAL_STATE.NONE and self.v_char.update_global_speed then
    self.v_char:update_global_speed()
    self.v_global_state = GLOBAL_STATE.NONE
  end
  self.v_time = self.v_time + self:get_dt_time()
  if self.time_scale_cb_timer and Global.time >= self.time_scale_cb_timer then
    self:rejoin_time_scale()
  end
end

function M:update_scale_info()
  for i = #self.v_scales, 0, -1 do
    local time_scale = self.v_scales[i]
    if not time_scale then
    else
      time_scale:update()
      if time_scale:is_end() then
        if time_scale:get_is_global_scale() then
          self:remove_global_time_scale()
        else
          self:remove_time_scale_by_index(i)
        end
      end
    end
  end
  local count = #self.v_scales
  local time_scale, maigc_id
  self.v_ignoral_missile = false
  self.v_igonre_force_move = false
  if count > 0 then
    local scale_info = self.v_scales[count]
    self:_set_special_effect(scale_info)
    local origin_scale = scale_info:get_scale()
    time_scale = self.v_global_cnt > 0 and origin_scale * GlobalTimeMgr:get_time_scale() or origin_scale
    maigc_id = scale_info.magic_id
  elseif 1 == self.v_global_cnt then
    local scale_info = self.v_scales[0]
    time_scale = scale_info:get_scale()
    maigc_id = scale_info.magic_id
    if self.v_global_caster and self.v_global_caster == self.v_char and (not self.v_char:is_hero() or not self.v_char:check_in_control()) and not scale_info:get_global_scale_index() then
      scale_info:set_global_scale_index(GlobalTimeMgr:add_global_time_scale(time_scale))
    end
  else
    time_scale = 1
  end
  return time_scale, maigc_id
end

function M:_set_special_effect(scale_info)
  self.v_ignoral_missile = scale_info:get_is_ignoral_missile()
  self.v_igonre_force_move = scale_info:get_is_ignore_move()
  self.v_impact_sound_type, self.v_impact_sound_volume = scale_info:get_impact_sound_type()
  self.v_effect_type = scale_info:get_effect_type()
  self.v_magic_id = scale_info.magic_id
end

function M:get_dt_time()
  return Global.delta_time * self.v_time_scale
end

function M:get_fixed_dt_time()
  return Global.fixed_delta_time * self.v_time_scale
end

function M:get_low_dt_time()
  return Global.low_delta_time * self.v_time_scale
end

function M:get_time_scale()
  return self.v_time_scale
end

function M:get_time()
  return self.v_time
end

function M:add_time_scale(scale, duration, scale_data)
  local magic_id, is_global
  if scale_data then
    scale_data.start_scale = self:get_time_scale()
    magic_id = scale_data.magic_id
    is_global = scale_data.is_global
    self.v_freeze_count = scale_data
    local effect_type = scale_data.effect_type
    if effect_type and effect_type ~= Config.TIME_SCALE_EFFECT_TYPE.NORMAL then
      self.v_effect_count = self.v_effect_count + 1
    end
  end
  self.v_add_order_num = self.v_add_order_num + 1
  local time_scale = TIME_SCALE_PARAM_POOL:new_obj(scale, duration, self.v_add_order_num, scale_data)
  if magic_id then
    self:remove_time_scale(magic_id)
  end
  if is_global then
    self:remove_global_time_scale()
    self.v_scales[0] = time_scale
    time_scale:set_global_scale()
    self.v_global_cnt = 1
    self.v_global_state = GLOBAL_STATE.ADD
  else
    local insert_index = #self.v_scales + 1
    self.v_scales[insert_index] = time_scale
    if 1 == insert_index then
      self:_set_special_effect(time_scale)
    elseif self.v_effect_count > 0 and insert_index > 1 then
      table.sort(self.v_scales, _sort_time_scale_func)
    end
  end
  if Global.enable_time_scale_debug and self.v_char.is_role and self.v_char:is_role() then
    Log.Error(string.format("%s|%s: 时停添加 ", self.v_char:get_npc_id(), self.v_char.uuid) .. get_scale_info_uri(time_scale))
  end
end

function M:remove_time_scale(magic_id)
  local remain_time = 0
  for k, v in pairs(self.v_scales) do
    if v.magic_id == magic_id then
      remain_time = v.v_duration - v.v_elapse
      self:remove_time_scale_by_index(k)
      break
    end
  end
  if self.rejoin_magic_id == magic_id then
    self:clear_rejoin_timer_on_remove()
  end
  return remain_time
end

function M:remove_time_scale_by_index(index)
  local time_scale = self.v_scales[index]
  if time_scale then
    local effect_type = time_scale:get_effect_type()
    if effect_type ~= Config.TIME_SCALE_EFFECT_TYPE.NORMAL then
      self.v_effect_count = self.v_effect_count - 1
    end
    if Global.enable_time_scale_debug and self.v_char.is_role and self.v_char:is_role() then
      Log.Error(string.format("%s|%s: 时停移除 ", self.v_char:get_npc_id(), self.v_char.uuid) .. get_scale_info_uri(time_scale))
    end
    TIME_SCALE_PARAM_POOL:destroy_obj(time_scale)
    _tremove(self.v_scales, index)
  end
end

function M:pause_time(pause)
  if not self.v_char then
    return
  end
  if pause then
    self.v_char:on_time_scale(0, pause)
  else
    self.v_char:on_time_scale(self.v_time_scale, pause)
  end
end

function M:get_is_ignoral_missile()
  return self.v_ignoral_missile
end

function M:get_is_global_scale()
  return self.v_global_cnt > 0
end

function M:remove_global_time_scale()
  local time_scale = self.v_scales[0]
  if time_scale and time_scale:get_is_global_scale() then
    local global_scale_index = time_scale:get_global_scale_index()
    if global_scale_index then
      GlobalTimeMgr:remove_globale_time_scale(global_scale_index)
    end
    if Global.enable_time_scale_debug and self.v_char.is_role and self.v_char:is_role() then
      Log.Error(string.format("%s|%s: 时停移除 ", self.v_char:get_npc_id(), self.v_char.uuid) .. get_scale_info_uri(time_scale))
    end
    TIME_SCALE_PARAM_POOL:destroy_obj(time_scale)
    self.v_scales[0] = nil
    self.v_global_cnt = 0
  end
  self.v_global_state = GLOBAL_STATE.REMOVE
end

function M:set_global_caster(caster)
  self.v_global_caster = caster
end

function M:get_igonre_forece_move()
  return self.v_igonre_force_move
end

function M:get_effect_type()
  return self.v_effect_type
end

function M:is_in_freeze()
  return self.v_effect_type == Config.TIME_SCALE_EFFECT_TYPE.FREEZE
end

function M:remove_time_scale_on_be_hit()
  if Util.is_destroy(self.v_char) or not self.v_char:is_npc() then
    return
  end
  local scale_info, magic_id, magic_cfg, logic_cfg
  if self.rejoin_magic_id then
    magic_cfg = ShareRes.get_magic_cfg(self.rejoin_magic_id)
    if magic_cfg then
      logic_cfg = magic_cfg.logic
      if logic_cfg and logic_cfg.type == Config.MagicDefine.MAGIC_TYPE.ChangeTimeScale then
        self:_create_rejoin_timer(self.rejoin_magic_id, self.last_remain_time)
        return
      end
    end
  end
  for index = #self.v_scales, 1, -1 do
    scale_info = self.v_scales[index]
    magic_id = scale_info.magic_id
    magic_cfg = ShareRes.get_magic_cfg(magic_id)
    if magic_cfg then
      logic_cfg = magic_cfg.logic
      if logic_cfg and logic_cfg.type == Config.MagicDefine.MAGIC_TYPE.ChangeTimeScale and logic_cfg[10] then
        self:_create_rejoin_timer(magic_id, scale_info.v_duration - scale_info.v_elapse)
        self:remove_time_scale_by_index(index)
        return
      end
    end
  end
end

function M:_create_rejoin_timer(magic_id, remain_time)
  local magic_cfg = ShareRes.get_magic_cfg(magic_id)
  local logic_cfg = magic_cfg.logic
  local rejoin_time = logic_cfg[10]
  local last_remain_time = remain_time or 0
  self.v_rejoin_time_scale_data = self.v_rejoin_time_scale_data or {}
  local elapsed_time = self.elapsed_time and Global.time - self.elapsed_time or 0
  local duration = last_remain_time + remain_time - rejoin_time - elapsed_time
  if duration <= 0.1 then
    return
  end
  local rejoin_data = self.v_rejoin_time_scale_data
  local scale = logic_cfg[1]
  self.v_target_type = logic_cfg[5]
  local ignoral_missile = logic_cfg[6]
  local impact_sound_type = logic_cfg[7]
  local impact_sound_volume = logic_cfg[8]
  local ignore_move = logic_cfg[9]
  rejoin_data.magic_id = magic_id
  rejoin_data.ignoral_missile = ignoral_missile
  rejoin_data.impact_sound_type = impact_sound_type
  rejoin_data.impact_sound_volume = impact_sound_volume
  rejoin_data.ignore_move = ignore_move
  rejoin_data.duration = duration
  rejoin_data.scale = scale
  rejoin_data.rejoin_time = rejoin_time
  self.time_scale_cb_timer = Global.time + rejoin_time
  self.last_remain_time = remain_time
  self.elapsed_time = Global.time
  self.rejoin_magic_id = magic_id
end

function M:rejoin_time_scale()
  if Util.is_destroy(self.v_char) then
    self:clear_rejoin_timer_on_remove()
    return
  end
  if not self.v_rejoin_time_scale_data then
    return
  end
  local scale, duration = self.v_rejoin_time_scale_data.scale, self.v_rejoin_time_scale_data.duration
  local scale_data = self.v_rejoin_time_scale_data
  scale_data.scale = nil
  scale_data.duration = nil
  self:add_time_scale(scale, duration, scale_data)
  self:clear_rejoin_timer_on_remove()
end

function M:clear_rejoin_timer_on_remove()
  self.v_rejoin_time_scale_data = nil
  self.time_scale_cb_timer = nil
  self.elapsed_time = nil
  self.last_remain_time = nil
  self.rejoin_magic_id = nil
end

function M:remove_all_time_scale()
  for index = #self.v_scales, 0, -1 do
    self:remove_time_scale_by_index(index)
  end
end

function M:on_role_exit_control()
  if self.v_global_caster and self.v_global_caster == self.v_char then
    GlobalTimeMgr:set_time_scale(1)
  end
end

return M
