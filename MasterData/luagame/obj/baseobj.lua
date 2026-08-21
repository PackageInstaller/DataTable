local ResPool = Global.res_pool_mgr
local ShareRes = require("utils.share_res")
local Util = require("utils.util")
local Vec3 = require("base.vec3")
local Vec2 = require("base.vec2")
local Math = require("base.mathx")
local Layer = require("utils.layer")
local NPCColliderLayer = Layer.Layer.NPCCollider
local LAND_LAYER = Layer.LayerMask.Terrain
local _cos, _sin = math.cos, math.sin
local _rad = math.rad
local _get_vec2_angle = Math.get_vec2_angle
local _max = math.max
local _min = math.min
local _floor = math.floor
local RAY_START_Y = ShareRes.get_comm_value("RoleRayCheckStartY")
local SyncTransforms = UnityEngine.Physics.SyncTransforms
local SCALE_SPEED = 0.5
local CSChangeLayer = CSHelper.ChangeLayerRecursively
local CSChangeLayerExcept = CSHelper.ChangeLayerExceptRecursively
local CompExtensions = _ENV.CompExtensions
local M = Util.create_class()
local MAX_COLLIDER_LEVEL = 999
local MAX_OUT_LENGTH = 5
local STATIC_8_DIR = {
  1,
  0,
  0.707,
  0.707,
  0,
  1,
  -0.707,
  0.707,
  -1,
  0,
  -0.707,
  -0.707,
  0,
  -1,
  0.707,
  -0.707
}

function M:_init()
  self.v_is_ignore_sync = true
  self.v_base_scale = 1
  self.v_scale_addition_percent = 1
  self.v_target_scale = 1
  self.v_current_scale = 1
  self.v_dir_y = 0
  self.v_enable_count = 1
  self.v_position = Vec3.New(0, 0, 0)
  self.v_change_dir_enabled = true
  self.v_grid_pos = Vec2.New(0, 0)
  self.v_next_pos_sync_time = 0
  self.v_sync_pos_dirty = false
  self.v_area_mask = 0
  self.v_need_check_area = false
  self.v_cache_move = Vec3.New(0, 0, 0)
  self.v_squeeze_cache_dir = {}
  self.v_grabed_obj = {}
  self.v_last_canuse_pos = Vec3.New()
  self.v_is_ghost = false
  self.v_is_air = false
  self.v_is_super_ghost = false
  self.v_is_overlap = false
  self.v_overlap_obj = nil
  self.v_has_parent_trans = false
  self.v_gameobj_active = true
  self.v_speed_ratio = 1
  self.v_final_speed_ratio = 1
  self.v_speed_inertial_scale = 1
  self.radius = 1
  self.components = self.components or {}
  self.v_component_msg_handles = self.v_component_msg_handles or {}
  self.update_land_height_block = {}
  self.v_loaded_cb = {}
  self.v_plat_cid = -1
  self.v_belong_plat = nil
  self.v_is_follow_plat = false
  self.v_is_set_die_state = false
  self.v_land_ray_dis = 0
  self.v_is_destroy = false
  self.v_cur_action_missile_id = nil
  self:refresh_ray_max_dis()
end

function M:set_layer(layer)
  self.v_layer = layer
  CSChangeLayer(self.transform, layer)
end

function M:set_layer_except(new_layer, except_layer)
  self.v_layer = new_layer
  CSChangeLayerExcept(self.transform, new_layer, except_layer)
end

function M:get_layer()
  return self.v_layer
end

function M:get_create_frame()
  return self.v_create_frame or Global.frame_id
end

function M:init_gameobj(cid, gameobj, transform)
  if self.gameobj then
    if self:is_on_recreate_gameobj() then
      self:on_recreate_gameobj(gameobj)
      ResPool:release(self.gameobj)
    elseif self.v_is_empty_obj then
      ResPool:release(self.gameobj)
    end
  end
  self.v_create_fixed_frame = Global.fixed_frame_id
  self.v_create_frame = Global.frame_id
  self.cid = cid
  self.gameobj = gameobj
  self.transform = transform
  self:init_animator()
  self:set_finish_init_gameobj(true)
  self.v_loading_gameobj = false
  self.v_need_loading_obj = false
  if self.character_cfg then
    self.collider_level = self.character_cfg.CollisionPriority
    self.be_clamped = false
  end
  self.collider_level = self.collider_level or MAX_COLLIDER_LEVEL
  self:update_scale()
  self:update_pos()
  self.transform:ResetAttr()
  self.transform:SetPositionA(self.v_position.x, self.v_position.y, self.v_position.z)
  if self.v_status_id then
    self:set_status_id(self.v_status_id, true)
  end
  self:broadcast("on_char_gameobj_loaded")
  self:on_init_gameobj(cid, gameobj, transform)
  self:set_target_dir(self:get_init_dir(), true)
  self:on_enable()
  self.gameobj:SetActiveEx(self.v_gameobj_active)
  for cb, _ in pairs(self.v_loaded_cb) do
    cb()
  end
  UtilTable.clear_map(self.v_loaded_cb)
  self:born_ok()
end

function M:born_ok()
  self:on_recreate_gameobj_try_action()
end

function M:is_loaded()
  return self.gameobj and not self.gameobj:IsNull()
end

function M:add_loaded_cb(cb)
  if self:is_loaded() then
    cb()
  else
    self.v_loaded_cb[cb] = true
  end
end

function M:init_animator()
  if self.runtime_animator and (not self.animator or self:is_on_recreate_gameobj()) then
    local animator = self.gameobj:GetComponent(TypeUnityAnimator)
    animator.runtimeAnimatorController = self.runtime_animator
    self.animator = animator
    self.animator.speed = 1
    local bip_trans
    bip_trans = self.transform:Find("Bip001 Pelvis")
    bip_trans = bip_trans or self.transform:Find("Bip001")
    if not bip_trans then
      return
    end
    self.bip_trans = bip_trans
    local x, y, z = self.bip_trans:GetLocalPositionA3()
    self.bip_trans_origin_pos_x, self.bip_trans_origin_pos_y, self.bip_trans_origin_pos_z = x, y, z
  end
end

function M:enable_grab_mode(graber, attach_transform)
  if not self.bip_trans then
    return
  end
  self.v_graber = graber
  self.bip_trans:SetLocalPositionA(self.bip_trans_origin_pos_x, self.bip_trans_origin_pos_y, self.bip_trans_origin_pos_z)
  self.bip_trans:AttachTo(attach_transform, false)
  self.is_in_puppet_mode = true
  self.be_grabed = true
  self.bip_trans:SetActive(true)
  self.v_last_grab_pos = {
    x = self.v_position.x,
    y = self.v_position.y,
    z = self.v_position.z
  }
  self.state_manager:try_action(Config.ACT_DEFINE.Hoverhit)
  NextFrameMgr:add(function()
    if not self:is_destroy() and self:get_is_graber_exist() then
      self.animator.enabled = false
    else
      self:disable_grab_mode()
    end
  end)
end

function M:get_is_graber_exist()
  return self.v_graber and not self.v_graber:is_destroy() and self.v_graber:is_hero() and not self.v_graber.in_background
end

function M:change_grab_mode(speed_factor, fly_time)
  if not self.is_in_puppet_mode then
    self.bip_trans:SetParent(self.transform)
    self.bip_trans:SetLocalPositionA(self.bip_trans_origin_pos_x, self.bip_trans_origin_pos_y, self.bip_trans_origin_pos_z)
    return
  end
  self.bip_trans:DetachTrans()
  self.bip_trans:SetParent(self.transform)
  self.bip_trans:SetLocalPositionA(self.bip_trans_origin_pos_x, self.bip_trans_origin_pos_y, self.bip_trans_origin_pos_z)
  speed_factor = speed_factor or 0.35
  fly_time = fly_time or 1
  local last_pos = self.v_last_grab_pos
  local cur_pos = self.v_position
  self.v_throw_speed = {
    x = (cur_pos.x - last_pos.x) * speed_factor,
    y = cur_pos.y - last_pos.y,
    z = (cur_pos.z - last_pos.z) * speed_factor
  }
  if self.v_throw_speed.x >= 0.7 then
    self.v_throw_speed.x = 0.7
  end
  if self.v_throw_speed.z >= 0.7 then
    self.v_throw_speed.z = 0.7
  end
  self.v_throw_time = fly_time
  self.v_throw_acl = {
    x = -self.v_throw_speed.x * Config.LOGIC_FRAME,
    z = -self.v_throw_speed.z * Config.LOGIC_FRAME
  }
  self.animator.enabled = true
  self.be_grabed = false
  self.be_throwd = true
end

function M:disable_grab_mode()
  if not self.is_in_puppet_mode then
    return
  end
  self.animator.enabled = true
  self.is_in_puppet_mode = false
  self.bip_trans:DetachTrans()
  self.bip_trans:SetParent(self.transform)
  self.bip_trans:SetActive(false)
  self.bip_trans:SetLocalPositionA(self.bip_trans_origin_pos_x, self.bip_trans_origin_pos_y, self.bip_trans_origin_pos_z)
  self.be_grabed = nil
  self.be_throwd = nil
  self.v_graber = nil
  self.v_last_grab_pos = nil
end

function M:grab_obj(attach_point, tar, is_weapon)
  local attach_transform
  if is_weapon then
    if is_weapon and self.weapon_mgr then
      attach_transform = self.weapon_mgr:get_attach_point_obj(attach_point)
    end
  else
    attach_transform = self:get_setting_point(attach_point)
  end
  attach_transform = attach_transform or self.transform
  tar:enable_grab_mode(self, attach_transform)
  self.v_grabed_obj[attach_point] = tar
end

function M:get_grabed_obj(attach_point)
  return self.v_grabed_obj[attach_point]
end

function M:throw_obj(attach_point, speed_factor, fly_time)
  local tar = self.v_grabed_obj[attach_point]
  if not tar or not tar.is_in_puppet_mode then
    if tar then
      tar:disable_grab_mode()
    end
    return
  end
  if tar:is_destroy() then
    self.v_grabed_obj[attach_point] = nil
    return
  end
  tar:change_grab_mode(speed_factor, fly_time)
  self.v_grabed_obj[attach_point] = nil
end

function M:_update_final_speed_ratio()
  self.v_final_speed_ratio = self.v_speed_ratio * self.v_speed_inertial_scale
end

function M:set_speed_ratio(ratio)
  self.v_speed_ratio = ratio * 1.0E-4
  self:_update_final_speed_ratio()
  self:refresh_anim_speed()
end

function M:refresh_anim_speed()
  if self.animator then
    self.animator:SetFloat("RunSpeed", self.v_final_speed_ratio * (1 / self.model_scale))
    self.animator:SetFloat("WalkSpeed", self.v_final_speed_ratio * (1 / self.model_scale))
  end
end

function M:set_speed_inertial_scale(ratio)
  self.v_speed_inertial_scale = ratio
  self:_update_final_speed_ratio()
  self:refresh_anim_speed()
end

function M:get_speed_inertial_scale()
  return self.v_speed_inertial_scale
end

function M:get_speed_ratio()
  return self.v_final_speed_ratio
end

function M:refresh_run_angle(val)
  if self.animator and self.motion_cfg.run_lean_l and self.motion_cfg.run_lean_r then
    self.animator:SetFloat("RunAngle", val)
  end
end

function M:get_animator()
  return self.animator
end

function M:before_load_gameobj(...)
  self.v_loading_gameobj = true
  self.v_need_loading_obj = true
  self:set_finish_init_gameobj(false)
end

function M:destroy_loading_gameobj()
  self.v_need_loading_obj = false
end

function M:on_init_gameobj(...)
end

function M:check_transparent()
end

function M:destroy_component(name)
  if not self.components then
    if not self:is_missile() and not self:is_destroy() then
      Log.Error("尝试销毁未setup对象", tostring(self.id), tostring(self.uuid), debug.traceback())
    end
    return
  end
  local class = self.components[name]
  if class then
    class:on_destroy()
    class:on_destroy_gameobj()
    self.components[name] = nil
    self[name] = nil
  end
end

function M:on_destroy_luaobj()
  UtilTable.clear_map(self.v_loaded_cb)
  self.v_is_destroy = true
  if self.state_manager then
    self.state_manager:on_destroy_luaobj()
  end
  if self.act_effect_ctrl then
    self.act_effect_ctrl:stop_all()
  end
  self:destroy_component("buff_mgr")
  if self.components then
    for name, _ in pairs(self.components) do
      self:destroy_component(name)
    end
  elseif not self:is_missile() then
    Log.Error("尝试销毁未setup对象", tostring(self.id), tostring(self.uuid), self:is_destroy(), debug.traceback())
  end
  self.v_has_presetup = false
  self.v_has_setup = false
  self:set_finish_init_gameobj(false)
  self.v_loading_gameobj = false
  self.v_need_loading_obj = false
  self.v_component_msg_handles = nil
  self.v_is_set_die_state = false
  self:clear_overlap()
  Util.unbind_all_msg(self)
end

function M:on_destroy_gameobj()
  if self.is_in_puppet_mode then
    self:disable_grab_mode()
  end
  if not self:is_missile() then
    ResPoolMgr:on_destroy_logicobj(self.cid)
  end
  if Global.sound_mgr then
    Global.sound_mgr:clear_sound_obj(self)
  end
  self:set_finish_init_gameobj(false)
  self.v_loading_gameobj = false
  self.v_need_loading_obj = false
  self.gameobj = nil
  self.transform = nil
  self.cid = nil
  self.attach_point = nil
  self.attach_point_caches = nil
  self.animator = nil
  self.animator_info = nil
  self:broadcast("on_destroy_gameobj")
end

function M:on_destroy()
  self.components = nil
  self.v_change_go_info = nil
  self.v_is_destroy = true
  self.v_is_pre_destroy = false
  self.is_load_behavior = false
  BehaviorMgr:call_event_fun("on_destroy_obj", self)
end

function M:on_pre_destroy()
  self.v_is_destroy = true
  self.v_is_pre_destroy = true
end

function M:is_pre_destroy()
  return self.v_is_pre_destroy
end

function M:presetup()
  if self.v_has_presetup then
    for name, class in pairs(self.components) do
      class:on_destroy()
      self[name] = nil
    end
    self.components = {}
  end
  self.v_has_presetup = true
end

function M:setup(...)
end

function M:aftersetup()
  self.v_has_setup = true
end

function M:is_setup()
  return self.v_has_setup
end

function M:clear_setup()
  self.v_has_setup = nil
end

function M:set_enable(enable)
  local count = self.v_enable_count
  local new_count = count + (enable and 1 or -1)
  self.v_enable_count = new_count
  if new_count > 0 and count <= 0 or new_count <= 0 and count > 0 then
    self:refresh_enable()
  end
end

function M:refresh_enable()
  if self.v_enable_count > 0 then
    self:on_enable()
  else
    self:on_disable()
  end
end

function M:get_enable()
  return self.v_enable_count > 0
end

function M:set_obj_enable(enable)
  self.v_gameobj_active = enable
  if self.gameobj then
    self.gameobj:SetActiveEx(enable)
  end
end

function M:set_mesh_enable(enable)
  local rds = self.transform:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)
  if rds then
    for i = 0, rds.Length - 1 do
      rds[i].gameObject:SetActiveEx(enable)
    end
  end
end

function M:on_enable()
  if self.v_finish_init_gameobj then
    self.gameobj:SetActive(true)
    if self.uicomponent then
      self.uicomponent:on_enable()
    end
  end
end

function M:on_disable()
  if self.v_finish_init_gameobj then
    self.gameobj:SetActive(false)
    if self.uicomponent then
      self.uicomponent:on_disable()
    end
    if Global.hero then
      Global.hero:on_scene_remove_obj(self)
    end
  end
end

local possible_cache_dir = {
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
}

function M:_update_dir_cache(move_step)
  local x, y = self.v_cache_move.x, self.v_cache_move.z
  local dir = possible_cache_dir
  dir[1], dir[2] = (x - y) * 0.7071 * move_step, (x + y) * 0.7071 * move_step
  dir[3], dir[4] = (x + y) * 0.7071 * move_step, (y - x) * 0.7071 * move_step
  dir[5], dir[6] = -y * move_step, x * move_step
  dir[7], dir[8] = y * move_step, -x * move_step
end

function M:_get_nearist_valid_pos(self_x, self_z, ray_start_y)
  local dx, dz
  local len = 0.05
  while len < MAX_OUT_LENGTH do
    for i = 1, 15, 2 do
      dx = STATIC_8_DIR[i] * len
      dz = STATIC_8_DIR[i + 1] * len
      if not SceneMgr:check_all_collision(self, dx + self_x, dz + self_z) then
        local has_terrain, height = Util.raycast(self_x + dx, self_z + dz, LAND_LAYER, ray_start_y, self.v_ray_max_dis)
        if has_terrain then
          return dx, dz, height, true
        end
      end
    end
    len = len * 1.5
  end
  return 0, 0, nil, false
end

function M:_get_fixed_dir(cur_x, y, cur_z, cur_move_step, ray_start_y)
  local new_dx, new_dz
  new_dx = 0
  new_dz = cur_move_step
  new_dx, new_dz = Math.get_pos_rotation_dir(self.collide_fixed_dir, new_dx, new_dz)
  local x, z = cur_x + new_dx, cur_z + new_dz
  local co
  if self:is_ghost() and not self:is_co_scene_npc() then
    co = SceneMgr:check_wall_collision(self, x, z, y)
  else
    co = SceneMgr:check_all_collision(self, x, z, y, self:is_co_scene_npc())
  end
  if not co then
    local has_terrain, height = Util.raycast(x, z, LAND_LAYER, ray_start_y, self.v_ray_max_dis)
    if has_terrain then
      return new_dx, new_dz, height
    end
  end
  self.collide_fixed_dir = nil
end

local function _check_pos_can_walk(self, x, z, ray_start_y)
  local co
  if self:is_ghost() and not self:is_co_scene_npc() then
    co = SceneMgr:check_wall_collision(self, x, z)
  else
    co = SceneMgr:check_all_collision(self, x, z, nil, self:is_co_scene_npc())
  end
  if not co then
    local has_terrain, height = Util.raycast(x, z, LAND_LAYER, ray_start_y, self.v_ray_max_dis)
    if has_terrain then
      return true, height
    end
  end
end

local function _get_nearist_dir_by_cache(self, cur_x, cur_z, ray_start_y, index)
  local dir_list = possible_cache_dir
  local dx, dz = dir_list[index], dir_list[index + 1]
  local x, z = cur_x + dx, cur_z + dz
  local can_walk, height = _check_pos_can_walk(self, x, z, ray_start_y)
  if can_walk then
    self.v_last_ret = index
    return dx, dz, height
  end
end

local OPPOSITE_DIR = {
  [1] = 3,
  [3] = 1,
  [5] = 7,
  [7] = 5
}

function M:_get_nearist_dir(cur_x, y, cur_z, dx, dz, ray_start_y)
  local valid = false
  local co, obj, trans = SceneMgr:check_in_collision(self, cur_x, cur_z)
  if co and obj then
    self:set_overlap(obj, trans)
    return 0, 0, y, valid
  end
  if self:is_role() and self:is_in_auto_move_state() then
    Util.VEC2_TEMP:Set(dx, dz)
    local temp_x, temp_z = 0, Util.VEC2_TEMP:Magnitude()
    local x, z = cur_x + temp_x, cur_z + temp_z
    local can_walk, height = _check_pos_can_walk(self, x, z, ray_start_y)
    if can_walk then
      return temp_x, temp_z, height
    end
  end
  local dir_x, dir_z, height
  if self:is_hero() then
    self.v_last_ret = self.v_last_ret or 0
    for index = 1, 7, 2 do
      if index == OPPOSITE_DIR[self.v_last_ret] then
      else
        dir_x, dir_z, height = _get_nearist_dir_by_cache(self, cur_x, cur_z, ray_start_y, index)
      end
    end
  else
    local last_ret = self.v_last_ret
    self.v_last_ret = nil
    if last_ret then
      dir_x, dir_z, height = _get_nearist_dir_by_cache(self, cur_x, cur_z, ray_start_y, last_ret)
    end
    if not dir_x then
      for index = 1, 7, 2 do
        if index == last_ret then
        else
          dir_x, dir_z, height = _get_nearist_dir_by_cache(self, cur_x, cur_z, ray_start_y, index)
          if dir_x then
            break
          end
        end
      end
    end
  end
  if dir_x then
    valid = true
    return dir_x, dir_z, height, valid
  end
  co = SceneMgr:check_wall_collision(self, cur_x - dx, cur_z - dz)
  if co then
    if self.v_last_stuck_frame and Global.frame_id - self.v_last_stuck_frame < 3 then
      dir_x, dir_z = 0, 0
    else
      self.v_last_stuck_frame = Global.frame_id
      dir_x, dir_z, height, valid = self:_get_nearist_valid_pos(cur_x, cur_z, ray_start_y)
    end
    return dir_x, dir_z, height or y, valid
  else
    return 0, 0, y, valid
  end
end

function M:set_overlap(obj, trans)
  if self:is_ghost() or self:is_friendly_ghost() and self:get_camp() == obj:get_camp() then
    return
  end
  self.v_is_overlap = true
  self.v_overlap_obj = obj
  self.v_overlap_trans = trans
  obj.v_overlap_obj = self
end

function M:clear_overlap()
  self.v_is_overlap = false
  self.be_clamped = false
  self.v_overlap_trans = nil
  self.v_overlap_obj = nil
end

function M:_check_dir(dirx, dirz)
  local dx, dz, tempx, tempz, have_terrain
  dx, dz = dirx * Config.SQUEEZE_OUT_SPEED * Global.delta_time, dirz * Config.SQUEEZE_OUT_SPEED * Global.delta_time
  tempx, tempz = self.v_position.x + dx, self.v_position.z + dz
  if self:is_ghost() then
    have_terrain = Util.raycast(tempx, tempz, Layer.LayerMask.Terrain, self.v_position.y + 0.5, 1)
    return not have_terrain, dx, dz
  end
  local collide, missile_uuid = SceneMgr:check_wall_collision(self, tempx, tempz)
  local collide_wall = false
  if collide and not missile_uuid then
    collide_wall = true
    have_terrain = false
  else
    have_terrain = Util.raycast(tempx, tempz, Layer.LayerMask.Terrain, self.v_position.y + 0.5, 1)
  end
  local co = not have_terrain or collide_wall
  return co, dx, dz
end

function M:_get_moveble_squeeze_dt(x, y)
  local dir = self.v_squeeze_cache_dir
  dir[1], dir[2] = x, y
  dir[3], dir[4] = (x - y) * 0.707, (x + y) * 0.707
  dir[5], dir[6] = (x + y) * 0.707, (y - x) * 0.707
  dir[7], dir[8] = -y, x
  dir[9], dir[10] = y, -x
  local co, dx, dz
  for i = 1, 10, 2 do
    co, dx, dz = self:_check_dir(dir[i], dir[i + 1])
    if not co then
      return dx, dz
    end
  end
  return 0, 0
end

function M:get_collider_pos2()
  return self:get_pos2()
end

function M:_squeeze_self_out()
  if not self.v_overlap_obj or self.v_overlap_obj:is_destroy() or self:is_ghost() or self:is_friendly_ghost() and self:get_camp() == self.v_overlap_obj:get_camp() then
    M:clear_overlap()
    return
  end
  local self_x, self_z = self:get_pos2()
  local tar_x, tar_z
  if self.v_overlap_trans then
    tar_x, _, tar_z = self.v_overlap_trans:GetPositionA()
  else
    tar_x, tar_z = self.v_overlap_obj:get_pos2()
  end
  local height
  local dirx, dirz = Util.normalize2(self_x - tar_x, self_z - tar_z)
  if 0 == dirx and 0 == dirz and self.v_overlap_obj and self.v_overlap_obj:is_char() and self:is_char() then
    local is_change, x, y, z = self:get_nearest_walkable_pos()
    if is_change then
      height = y
    end
    dirx, dirz = Util.normalize2(self_x - x, self_z - z)
  end
  local dx, dz = self:_get_moveble_squeeze_dt(dirx, dirz)
  if not height then
    local ray_start_y = self.v_position.y + RAY_START_Y
    local dist = self.v_ray_max_dis + self.v_land_ray_dis
    local has_terrain, result_y
    local target_x, target_z = self.v_position.x + dx, self.v_position.z + dz
    has_terrain, result_y = Util.raycast(target_x, target_z, LAND_LAYER, ray_start_y, dist)
    if has_terrain then
      height = result_y
    end
  end
  if 0 == dx and 0 == dz then
    self.be_clamped = true
    return
  else
    self.be_clamped = false
  end
  if height then
    self.v_position.y = height
  end
  self:set_pos_by_delta(dx, 0, dz)
end

function M:is_overlap_with(other)
  if not other or other:is_destroy() then
    return false
  end
  local _, y, _ = self:get_collider_posA()
  local x, z = self:get_pos2()
  local len = Util.overlap_sphere(x, y, z, self.radius, other:is_missile())
  if len > 0 then
    for i = 0, len - 1 do
      local id = CompExtensions.GetOverlapSphereColliderID(i)
      local obj = SceneMgr:pick_by_cid(id)
      if obj == other then
        return true
      end
    end
  end
  return false
end

function M:update_overlap()
  self:set_cache_move(0, 0, 0)
  if not self.v_overlap_obj:can_update() then
    self:clear_overlap()
    return
  end
  if self.be_clamped and self.v_overlap_obj.be_clamped or self:is_ghost() then
    self:clear_overlap()
    return
  end
  if not (not self.v_overlap_obj:is_destroy() and self:is_overlap_with(self.v_overlap_obj)) or self.v_overlap_obj:is_air() then
    local co, obj, trans = SceneMgr:check_in_collision(self, self.v_position.x, self.v_position.z)
    if co and obj then
      self:set_overlap(obj, trans)
    else
      self:clear_overlap()
    end
    return
  end
  if self.be_clamped then
    self.v_overlap_obj:_squeeze_self_out()
    return
  end
  if self.collider_level > self.v_overlap_obj.collider_level then
    if not self:is_air() then
      self.v_overlap_obj:_squeeze_self_out()
    end
  elseif self.collider_level < self.v_overlap_obj.collider_level then
    self:_squeeze_self_out()
  else
    if not self:is_air() then
      self.v_overlap_obj:_squeeze_self_out()
    end
    self:_squeeze_self_out()
  end
end

function M:quit_throwed(missile_ower, missile_id)
  if not self or self:is_destroy() then
    return
  end
  if self.be_grabed and self.v_graber and missile_ower == self.v_graber then
    return
  end
  if self.be_grabed or self.be_throwd then
    Log.Info("抓状态被打断，子弹id=", missile_id)
  end
  self:disable_grab_mode()
  if not self.is_in_puppet_mode or not self.be_throwd then
    return
  end
  self.be_throwd = false
  local pos = self.v_last_canuse_pos
  self:set_pos(pos.x, pos.y, pos.z)
end

function M:_update_grab_move()
  if not self.is_in_puppet_mode then
    return
  end
  if not self.be_grabed then
    return
  end
  if not self:get_is_graber_exist() then
    self:disable_grab_mode()
    return
  end
  self.v_last_grab_pos.x = self.v_position.x
  self.v_last_grab_pos.y = self.v_position.y
  self.v_last_grab_pos.z = self.v_position.z
  local pos_x, _, pos_z = self.bip_trans:GetPositionA()
  local co = SceneMgr:check_wall_collision(self, pos_x, pos_z)
  if co then
    self:disable_grab_mode()
    return
  end
  self:set_pos2(pos_x, pos_z)
  if self.v_graber and not self.v_graber:is_destroy() then
    self:face_to_obj(self.v_graber, true)
  end
end

function M:_update_throw_move()
  if not self.is_in_puppet_mode then
    return
  end
  if not self.be_throwd then
    return
  end
  local co = SceneMgr:check_wall_collision(self)
  if co then
    self:disable_grab_mode()
    return
  end
  self.v_throw_time = self.v_throw_time - Global.delta_time
  if self.v_throw_time <= 0 or math.abs(self.v_throw_speed.x) <= 0.01 and math.abs(self.v_throw_speed.z) <= 0.01 then
    self:disable_grab_mode()
    return
  end
  self:set_cache_move(self.v_cache_move.x + self.v_throw_speed.x, self.v_cache_move.y, self.v_cache_move.z + self.v_throw_speed.z)
  self.v_throw_speed.x = self.v_throw_speed.x + self.v_throw_acl.x
  self.v_throw_speed.z = self.v_throw_speed.z + self.v_throw_acl.z
end

function M:can_slipout()
  return true
end

function M:_is_scene_has_plat()
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    local scene_map = scene_logic:get_scene_map()
    return scene_map and scene_map:has_platforms()
  end
  return false
end

function M:can_move_at_idle_switching()
  return true
end

function M:set_land_ray_dis(dis)
  self.v_land_ray_dis = dis or 0
end

function M:_check_stuck(has_move)
  if not self:is_hero() then
    return
  end
  if not SceneMgr:get_scene_logic() then
    return
  end
  if has_move then
    return
  end
  self.v_next_check_stuck_time = self.v_next_check_stuck_time or Global.real_time + 0.1
  if self.v_next_check_stuck_time > Global.real_time then
    return
  end
  self.v_next_check_stuck_time = Global.real_time + 0.1
  local x, y, z = self.v_position.x, self:get_collider_offset_y(), self.v_position.z
  local len = Util.overlap_sphere(x, y + self.radius, z, self.radius, true)
  if len > 0 then
    local is_change, new_x, new_y, new_z = self.navigator_ctrl:get_nearest_walkable_pos(x, y, z)
    if is_change then
      self:set_pos(new_x, new_y, new_z)
      self.v_need_check_area = true
    end
  end
end

function M:_check_collided(dx, dz, temp_x, temp_z, temp_y)
  local collider_info, collider_type
  self.v_collided, self.v_collided_missile_uuid, collider_info, collider_type = SceneMgr:check_wall_collision(self, temp_x, temp_z, temp_y)
  if self.v_collided then
    self:on_collide_wall(dx, dz, collider_info, collider_type)
    self:on_collide_missile()
  else
    local collide_with_npc, _
    collide_with_npc, self.v_collided_npc, _, self.v_co_scene_npc = SceneMgr:check_in_collision(self, temp_x, temp_z, temp_y, self:is_check_scene_npc())
    if collide_with_npc and (not self:is_ghost() or self:is_co_scene_npc()) and (not (self:is_friendly_ghost() and self.v_collided_npc) or self.v_collided_npc:get_camp() ~= self:get_camp()) then
      self:on_collide_npc()
      self.v_collided = true
    end
  end
end

function M:_update_move()
  if Math.almost_zero2(self.v_cache_move.x, self.v_cache_move.z) or self.v_is_target_mode then
    return false
  end
  local len = self.v_cache_move:Magnitude()
  if self.v_collided and (not self:is_role() or not self:is_in_auto_move_state()) then
    len = len * (self.collide_move_rate or 0.5)
    self.collide_move_rate = nil
  end
  local step = 0.2
  local x, y, z = 0, self.v_position.y, 0
  local move_step = _min(step, len)
  self.v_cache_move:SetNormalize()
  self:_update_dir_cache(move_step)
  local can_slip_out = self:can_slipout()
  local ray_start_y = y + RAY_START_Y
  local valid = true
  local ray_dis = self.v_ray_max_dis + self.v_land_ray_dis
  while not (len <= 0) do
    local cur_move_step = _min(len, move_step)
    local dx, dz = self.v_cache_move.x * cur_move_step, self.v_cache_move.z * cur_move_step
    local temp_x = self.v_position.x + x + dx
    local temp_z = self.v_position.z + z + dz
    local has_terrain, height, cid = Util.raycast(temp_x, temp_z, LAND_LAYER, ray_start_y, ray_dis)
    if not self:can_move_at_idle_switching() and cid ~= self.v_plat_cid then
      break
    end
    local temp_y = self:is_role() and self.state_manager:is_in_behitfly_state() and self.v_land_height
    if has_terrain then
      self:_check_collided(dx, dz, temp_x, temp_z, temp_y)
    end
    if self.v_collided or not has_terrain then
      if not can_slip_out then
        valid = false
        break
      end
      if self.collide_move_rate and Util.almost_zero(self.collide_move_rate) and not self:is_in_auto_move_state() then
        y = has_terrain and height or y
        valid = false
        break
      end
      local cur_x, cur_z = self.v_position.x + x, self.v_position.z + z
      local new_x, new_z
      if self.collide_fixed_dir then
        new_x, new_z, height = self:_get_fixed_dir(cur_x, y, cur_z, cur_move_step, ray_start_y)
      end
      if new_x then
        y = height
      else
        new_x, new_z, y, valid = self:_get_nearist_dir(cur_x, y, cur_z, dx, dz, ray_start_y)
      end
      dx, dz = self:_adjust_len(dx, dz, new_x, new_z)
      local temp_has_terrain, _, _ = Util.raycast(cur_x + dx, cur_z + dz, LAND_LAYER, ray_start_y, ray_dis)
      if not temp_has_terrain then
        break
      end
    else
      y = height
    end
    ray_start_y = y + RAY_START_Y
    x = x + dx
    z = z + dz
    len = len - move_step
  end
  self.v_last_land_height = y
  self:set_cache_move(0, 0, 0)
  local use_y
  if self.v_enable_land_height_block then
    use_y = self.v_position.y
  else
    use_y = self.v_last_land_height
  end
  self:set_pos(self.v_position.x + x, use_y, self.v_position.z + z)
  if valid and self:is_hero() then
    FightDataMgr:cache_walkable_position(self:get_pos())
  end
  self.v_need_check_area = true
  self.collide_fixed_dir = nil
  return true
end

function M:_adjust_len(origin_x, origin_z, new_x, new_z)
  if nil == new_x or nil == new_z then
    return origin_x, origin_z
  end
  if 0 == new_x and 0 == new_z then
    return 0, 0
  end
  if new_x == origin_x and new_z == origin_z then
    return new_x, new_z
  end
  if self:is_role() and self:is_in_auto_move_state() then
    return Util.get_equal_len_vector(origin_x, origin_z, new_x, new_z)
  end
  local origin_len = Math.distance2(0, 0, origin_x, origin_z)
  local new_len = Math.distance2(0, 0, new_x, new_z)
  local rate = origin_len / new_len
  return new_x * rate, new_z * rate
end

function M:_is_ignore_sync()
  if self.v_is_ignore_sync then
    return true
  end
  local scene_logic = SceneMgr:get_scene_logic()
  if not (scene_logic and self:is_role()) or self:is_hero() and self.in_background then
    return true
  end
  if Util.is_client_only() then
    return true
  end
  if Global.gamemode:gmode_is_loadscene() then
    return true
  end
end

function M:_reset_area_mask()
  self.v_area_mask = 0
end

function M:set_area_mask(area_mask)
  self.v_area_mask = area_mask
end

function M:get_area_mask()
  return self.v_area_mask
end

function M:_check_sync_area()
  if self:_is_ignore_sync() then
    return
  end
  if TowerMgr then
    local tower = TowerMgr:get_tower()
    if tower and tower:check_is_in_tp() then
      return
    end
  end
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  local new_mask, is_dirty, enter_area_list, out_area_list = scene_logic:check_area_mask(self.v_area_mask, self.v_position)
  if is_dirty then
    self.v_area_mask = new_mask
    if enter_area_list then
      for enter_area, v in pairs(enter_area_list) do
        self:trigger_enter_area_event(enter_area)
      end
    end
    if out_area_list then
      for out_area, v in pairs(out_area_list) do
        self:trigger_leave_area_event(out_area)
      end
    end
  end
end

function M:trigger_enter_area_event(enter_area)
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_ENTER_AREA, self, enter_area)
  BehaviorMgr:call_behavior_fun(self, "on_self_enter_area", enter_area)
  if self:is_hero() then
    BehaviorMgr:call_behavior_fun(self, "on_hero_enter_area", enter_area)
  end
  BehaviorMgr:call_scene_logic_event_fun(BehaviorMgr.EVENTS.ON_ENTER_AREA, self, enter_area)
end

function M:trigger_leave_area_event(out_area)
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_LEAVE_AREA, self, out_area)
  BehaviorMgr:call_behavior_fun(self, "on_self_leave_area", out_area)
  if self:is_hero() then
    BehaviorMgr:call_behavior_fun(self, "on_hero_leave_area", out_area)
  end
  BehaviorMgr:call_scene_logic_event_fun(BehaviorMgr.EVENTS.ON_LEAVE_AREA, self, out_area)
end

function M:is_in_tp_area()
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  return scene_logic:is_in_tp_area(self.v_area_mask, self.v_position)
end

function M:is_in_move_plat()
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  local pos = self.v_position
  return scene_logic:is_in_move_plat(pos.x, pos.z)
end

function M:_after_move()
  if not self.transform or self.transform:IsNull() then
    return
  end
  local x, y, z
  if self.v_is_part_mode then
    self.transform:SetLocalPositionA(0, 0, 0)
  end
  x, y, z = self.transform:GetPositionA()
  if self.v_has_parent_trans then
    self:raw_set_pos(x, y, z)
  end
  self.v_last_canuse_pos:Set(x, y, z)
end

function M:init_canuse_pos()
  self.v_last_canuse_pos:SetA(self.v_position)
end

function M:get_belong_plat()
  return self.v_belong_plat
end

function M:_update_belong_plat()
  local plat_mgr = SceneMgr:get_plat_mgr()
  if not plat_mgr then
    return
  end
  self.v_belong_plat = plat_mgr:get_plat_by_cid(self.v_plat_cid)
end

function M:_update_move_by_plat()
  if not self:is_hero() and not self.v_is_follow_plat then
    return
  end
  if self.v_belong_plat and self.v_belong_plat:is_moving() then
    local x, y, z, old_position, now_position, old_rotation, now_rotation = self.v_belong_plat:get_movement()
    local orx, ory, orz, orw = old_rotation:Get()
    local nrx, nry, nrz, nrw = now_rotation:Get()
    local ovx, ovy, ovz = old_position:Get()
    local nvx, nvy, nvz = now_position:Get()
    self:set_pos_by_delta(x, y, z)
    local ox, oy, oz = self:get_pos()
    if old_rotation ~= now_rotation then
      local px, py, pz = CSHelper.SetObjPosWithPlatRotation(orx, ory, orz, orw, nrx, nry, nrz, nrw, ovx, ovy, ovz, nvx, nvy, nvz, ox, oy, oz, self.transform)
      self:set_pos(px, py, pz)
    end
    self.v_need_check_area = true
  end
end

function M:update()
  if not self:can_update() then
    return
  end
  if self:is_missile() then
    return
  end
  if self:is_scene_npc() then
    return
  end
  if not self:is_ghost() then
    local cx, cy = self:get_pos2()
    local co, obj, trans = SceneMgr:check_in_collision(self, cx, cy)
    if co and obj then
      self:set_overlap(obj, trans)
    end
  end
  if self.v_is_overlap then
    self:update_overlap()
    return
  end
  if self.v_current_scale ~= self.v_target_scale then
    self:update_scale()
  end
  if not self:is_functional_npc() or self:is_functional_role_npc() then
    self.v_has_move = self:_update_move()
    if self.v_has_move then
      self:_after_move()
    end
  end
  self:update_char_transmit_pos()
end

function M:low_update()
  self:_update_grab_move()
  self:_update_throw_move()
end

function M:late_update()
  if not self:can_update() then
    return
  end
  if self:is_hero() and self:check_background() then
    return
  end
  if not self.v_has_move and self:is_role() and self.act_ctrl:check_motion_pos() then
    self:_check_collided_on_root_motion()
  end
  self.v_last_land_height = self.v_land_height
  self.v_land_height = nil
  self:_update_move_by_plat()
  self:_update_land_height()
  self:_update_belong_plat()
  if self.v_need_check_area then
    self:_check_sync_area()
    self.v_need_check_area = false
  end
end

function M:_check_collided_on_root_motion()
  self:sync_lua_position()
  if self:is_hero() and (self.skill_mgr:is_in_born_skill() or self.skill_mgr:is_in_fight_end_skill()) then
    FightDataMgr:cache_walkable_position(self:get_pos())
    return
  end
  local valid = true
  local x, y, z = self:get_pos()
  local ray_start_y = y + RAY_START_Y
  local temp_y = self:is_role() and self.state_manager:is_in_behitfly_state() and self.v_land_height
  local ray_dis = self.v_ray_max_dis
  local has_terrain, height, cid = Util.raycast(x, z, LAND_LAYER, ray_start_y, ray_dis)
  if self:can_move_at_idle_switching() or cid == self.v_plat_cid then
    if has_terrain then
      self:_check_collided(0, 0, x, z, temp_y)
    end
    if not has_terrain or self.v_collided then
      local dx, dz, fix_y
      dx, dz, fix_y, valid = self:_get_nearist_dir(x, y, z, 0, 0, ray_start_y)
      fix_y = fix_y or has_terrain and height or y
      self:set_pos(x + dx, fix_y, z + dz)
    end
  end
  if valid and self:is_hero() then
    FightDataMgr:cache_walkable_position(self:get_pos())
  end
end

function M:set_parent_tans(trans, world_pos_stay)
  self.v_has_parent_trans = true
  self.transform:SetParent(trans, world_pos_stay)
end

function M:active_update()
  local dist = Global.hero:get_distance_without_radius(self)
  local is_in_dist = dist < MAX_VISIBLE_DISTANCE
  return dist, is_in_dist
end

function M:get_camera_focal_transform()
  return self.transform, Config.CAMERA_DEFAULT_OFFSET
end

function M:get_gameobj()
  return self.gameobj
end

function M:get_cid()
  return not (not self.v_is_ui_model or Util.is_nil(self.gameobj)) and self.gameobj:GetInstanceID() or self.cid
end

function M:get_transform()
  return self.transform
end

function M:get_pos_vec3()
  return self.v_position
end

function M:get_pos()
  return self.v_position.x, self.v_position.y, self.v_position.z
end

function M:get_pos2()
  return self.v_position.x, self.v_position.z
end

function M:get_radius_offset_pos()
  local offset_pos = self.character_cfg.RadiusOffset
  if not offset_pos then
    return 0, 0
  end
  return offset_pos[1], offset_pos[2]
end

local function _need_sync_transforms(self)
  return not self:is_missile() and not self:is_functional_npc() and not self:is_scene_npc() and not self:is_simple_npc() and not self.in_background
end

function M:raw_set_pos(x, y, z)
  self.v_position.x = x
  self.v_position.y = y
  self.v_position.z = z
  if self.transform then
    self.transform:SetPositionA(x, y, z)
    if _need_sync_transforms(self) then
      SyncTransforms()
    end
  end
end

function M:set_pos_vec(pos)
  local x, y, z = pos.x, pos.y, pos.z
  self:raw_set_pos(x, y, z)
end

function M:set_pos_by_delta(dtx, dty, dtz)
  local x = self.v_position.x + dtx
  local y = self.v_position.y + dty
  local z = self.v_position.z + dtz
  self:set_pos(x, y, z)
end

function M:set_pos(x, y, z)
  self:raw_set_pos(x, y, z)
end

function M:set_transform_scale(x, y, z)
  self.transform:SetLocalScaleA(x, y, z)
end

function M:set_pos2(x, z)
  self:raw_set_pos(x, self.v_position.y, z)
end

function M:move(x, z)
  if self.is_in_puppet_mode then
    return
  end
  self:set_cache_move(self.v_cache_move.x + x, self.v_cache_move.y, self.v_cache_move.z + z)
end

function M:get_pos_height()
  return self.v_position.y
end

function M:set_pos_height(height)
  self.v_position.y = height
end

function M:set_is_follow_plat(v)
  self.v_is_follow_plat = v
end

function M:is_need_land_height()
  return true
end

function M:_update_land_height()
  local is_need = self:is_need_land_height()
  if not self.v_land_height and is_need then
    local has_plat = self:_is_scene_has_plat()
    local ret, height
    local ray_start_y = self.v_position.y + RAY_START_Y
    if has_plat and self.v_belong_plat then
      ret, height, self.v_plat_cid = Util.raycast_with_prefer_id(self.v_position.x, ray_start_y, self.v_position.z, self.v_ray_max_dis, LAND_LAYER, self.v_plat_cid)
    else
      ret, height, self.v_plat_cid = Util.raycast(self.v_position.x, self.v_position.z, LAND_LAYER, ray_start_y, self.v_ray_max_dis)
    end
    if ret then
      if height and self.v_last_land_height and not Math.almost_equal_number(height, self.v_last_land_height) and (not self:is_role() or not self.state_manager:is_in_behitfly_state()) then
        self:set_pos_height(height)
        FightDataMgr:update_walkable_position_y(height)
      end
      self.v_land_height = height
      self.v_last_land_height = height
    else
      self.v_land_height = self.v_last_land_height or 0
    end
  end
end

function M:get_air_height()
  self:_update_land_height()
  return self.v_position.y - (self.v_land_height or 0)
end

function M:add_pos_height(height)
  if self:can_update() then
    self:set_pos_by_delta(0, height, 0)
  end
  return self.v_position.y
end

function M:update_pos()
  if self:can_update() then
    self:_sync_cache_move()
  end
end

function M:update_pos_height()
  local x, z = self.v_position.x, self.v_position.z
  local ret, height = Util.raycast_by_role(self, x, z)
  self:set_pos(x, height, z)
end

function M:get_euler_angles()
  return self.transform:GetEulerAnglesA3()
end

function M:get_init_dir()
  return self.v_dir_y
end

function M:get_dir()
  return self.v_dir_y
end

function M:set_turn_speed(speed)
  self.orienter:set_turn_speed(speed)
end

function M:set_target_dir(dir, force)
  if self:can_update() then
    if self.orienter and self.orienter:is_setup() then
      self.orienter:set_target_dir(dir, force)
    elseif self.v_char:is_missile() then
      self.transform:SetEulerY2(dir)
    else
      self.transform:SetEulerY(dir)
    end
  end
  self.v_dir_y = dir
end

function M:sync_dir()
  local dir = self.transform:GetEulerY()
  self:set_target_dir(dir, true)
end

function M:set_dir(dir)
  self.v_dir_y = dir
end

function M:get_pos_dir_offset(px, pz)
  local x, _, z = self.transform:GetForwardA()
  local selfx, selfz = self:get_pos2()
  return _get_vec2_angle(selfx, selfz, x + selfx, z + selfz, px, pz)
end

function M:keep_cur_dir()
  self:set_target_dir(self:get_dir())
end

function M:face_to_obj(obj, force)
  local x, z = obj:get_pos2()
  self:face_to_pos(x, z, force)
end

function M:face_dir(dir, force, enter_point)
  self:set_target_dir(dir, force)
  if enter_point then
    self.enter_point_dir = dir
    Global.camera:init_scene_camera_euler_y(dir)
  end
end

function M:face_to_pos(x, z, force, enter_point)
  local dir = Math.get_lookat_dir(self.v_position.x, self.v_position.z, x, z)
  self:set_target_dir(dir, force)
  if enter_point then
    self.enter_point_dir = dir
    Global.camera:init_scene_camera_euler_y(dir)
  end
end

function M:face_to_pos_by_angle(angle, force, enter_point)
  self:set_target_dir(angle, force)
  if enter_point then
    self.enter_point_dir = angle
    Global.camera:init_scene_camera_euler_y(angle)
  end
end

function M:get_enter_point_dir()
  return self.enter_point_dir or 0
end

function M:get_distance(another_obj)
  local target_pos = another_obj:get_pos_vec3()
  local pos3 = self.v_position
  return Vec3.Distance(pos3, target_pos)
end

function M.get_dt()
  return Global.delta_time
end

function M.get_low_dt()
  return Global.low_delta_time
end

function M:get_square_dist(another_obj)
  local target_pos = another_obj:get_pos_vec3()
  local pos3 = self.v_position
  return Vec3.SquareDistance(pos3, target_pos)
end

function M:get_square_distance(another_obj)
  local x, y, z = another_obj:get_pos()
  return Math.square_distance(x, y, z, self.v_position.x, self.v_position.y, self.v_position.z)
end

function M:get_pos_diff_dir(another_obj)
  local x, z = another_obj:get_pos2()
  return x - self.v_position.x, z - self.v_position.z
end

function M:set_scale(scale)
  if not scale or self.v_base_scale == scale then
    return
  end
  self.v_base_scale = scale
  self:_update_target_scale()
end

function M:set_addition_scale(scale_value)
  self.v_scale_addition_percent = self.v_scale_addition_percent + scale_value
  self:_update_target_scale()
end

function M:get_real_scale()
  return self.v_target_scale
end

function M:get_base_scale()
  return self.v_base_scale
end

function M:get_addition_scale()
  return self.v_scale_addition_percent
end

function M:update_scale()
  if self:can_update() then
    local factor = self.v_current_scale - self.v_target_scale > 0 and -1 or 1
    self.v_current_scale = self.v_current_scale + SCALE_SPEED * factor * Global.elapsed
    if (self.v_target_scale - self.v_current_scale) * factor <= 0 then
      self.v_current_scale = self.v_target_scale
      if self:is_selected() then
        MsgGame:mq_publish2(Const.MSG_LOKC_SCALE_CHANGE)
      end
    end
    self.transform:SetLocalScaleA(self.v_current_scale)
    if self.uicomponent then
      self.uicomponent:update_headbar_height()
    end
  end
end

function M:_sync_cache_move()
  self:set_pos_by_delta(self.v_cache_move.x, 0, self.v_cache_move.z)
  self:set_cache_move(0, 0, 0)
end

function M:destroy()
  assert(nil)
end

function M:can_update()
  return self.v_finish_init_gameobj and self.v_enable_count > 0
end

function M:is_real_finish_init()
  return self.v_finish_init_gameobj
end

function M:will_init_gameobj()
  return self.v_finish_init_gameobj or self.v_loading_gameobj
end

function M:is_in_battle()
end

function M:set_stun(is_stun)
  self.v_is_stun = is_stun
end

function M:is_stun()
  return self.v_is_stun
end

function M:is_empty_obj()
  return self.v_is_empty_obj
end

function M:is_destroy()
  return self.v_is_destroy
end

function M:can_destroy_gameobj()
  return true
end

function M:need_load_gameobj()
  return true
end

function M:is_die()
  return false
end

function M:is_monster()
  return false
end

function M:is_com_monster()
  return false
end

function M:is_missile()
  return false
end

function M:is_boss()
  return false
end

function M:is_player()
  return false
end

function M:is_hero()
  return false
end

function M:is_hero_or_player()
  return false
end

function M:is_npc()
  return false
end

function M:is_role()
  return false
end

function M:is_god()
  return false
end

function M:is_functional_npc()
  return false
end

function M:is_functional_role_npc()
  return false
end

function M:is_char()
  return false
end

function M:is_scene_obj()
  return false
end

function M:is_scene_npc()
  return false
end

function M:is_break_obj()
  return false
end

function M:is_summons()
  return false
end

function M:is_simple_npc()
  return false
end

function M:on_click()
end

function M:broadcast(msg)
  for k, component in pairs(self.components) do
    if component[msg] then
      component[msg](component)
    end
  end
end

function M:add_component(name, class, override_old_component, dont_destroy_old_com)
  assert(nil == self[name] or override_old_component, "duplicate module added " .. name)
  if not class.is_component or not class:is_component() then
    Log.Error(name .. "没有调用base_component 的初始化函数")
  end
  if not dont_destroy_old_com and self.components[name] then
    self.components[name]:on_destroy()
  end
  self.components[name] = class
  self[name] = class
  class:after_add_component()
  return class
end

function M:unregister_comp_message(component, msg)
  local components = self.v_component_msg_handles[msg]
  if components then
    component[component] = nil
  end
end

function M:register_comp_message(component, msg)
  local components = self.v_component_msg_handles[msg]
  if not components then
    components = {}
    self.v_component_msg_handles[msg] = components
  end
  components[component] = true
end

function M:notify_comp_message(msg, ...)
  local components = self.v_component_msg_handles[msg]
  if components then
    for component, _ in pairs(components) do
      component[msg](component, ...)
    end
  end
end

function M:remove_component(name)
  local component = self.components[name]
  if component then
    component:on_destroy()
    self[name] = nil
    self.components[name] = nil
    for _, components in pairs(self.v_component_msg_handles) do
      components[component] = nil
    end
  end
end

function M:selected()
  self.v_selected = true
end

function M:unselected()
  self.v_selected = false
end

function M:is_selected()
  return self.v_selected == true
end

function M:get_move_speed(...)
  return nil
end

function M:set_status_id(id, is_born)
  self.v_status_id = id
  if id then
    local status_cfg = ShareRes.create("status_action", id)
    if self.state_manager then
      self.state_manager:try_action(status_cfg.anim, is_born and 1.0 or 0.0)
    end
  end
end

function M:get_config()
end

function M:on_reload_anim()
end

function M:set_is_air(status)
  if self.v_is_air ~= status then
    self.v_is_air = status
  end
end

function M:set_is_friendly_air(status)
  if self.v_is_friendly_air ~= status then
    self.v_is_friendly_air = status
  end
end

function M:set_is_ghost(status)
  if self.v_is_ghost ~= status then
    self.v_is_ghost = status
    self:check_need_set_overlap()
  end
end

function M:set_is_friendly_ghost(status)
  if self.v_is_friendly_ghost ~= status then
    self.v_is_friendly_ghost = status
  end
end

function M:set_is_super_ghost(status)
  if self.v_is_super_ghost ~= status then
    self.v_is_super_ghost = status
    self:check_need_set_overlap()
  end
end

function M:check_need_set_overlap()
  if not self.v_is_ghost and not self.v_is_super_ghost then
    local co, obj, trans = SceneMgr:check_in_collision(self, self.v_position.x, self.v_position.z)
    if co and obj then
      self:set_overlap(obj, trans)
    end
  end
end

function M:is_air()
  return self.v_is_air or self.is_in_puppet_mode
end

function M:is_friendly_air()
  return self.v_is_friendly_air
end

function M:is_ghost()
  return self:is_super_ghost() or self.v_is_ghost
end

function M:is_friendly_ghost()
  return self.v_is_friendly_ghost
end

function M:is_super_ghost()
  return self.v_is_super_ghost
end

function M:is_co_scene_npc()
  return self.v_co_scene_npc and not self.v_is_super_ghost
end

function M:is_check_scene_npc()
  return self:is_hero() and not self.v_is_super_ghost and (self.v_is_ghost or not self.v_is_air)
end

function M:_update_target_scale()
  self.v_target_scale = _max(self.v_base_scale * self.v_scale_addition_percent, 0.01)
end

function M:has_part()
  return false
end

function M:on_collide_wall(dx, dz)
end

function M:on_collide_missile()
  if self.v_collided_missile_uuid then
    local missile = SceneMgr:get_missile_by_id(self.v_collided_missile_uuid)
    if Util.is_destroy(missile) then
      self.v_collided_missile_uuid = nil
    else
      self:set_overlap(missile, missile.transform)
    end
  end
end

function M:on_collide_npc()
end

function M:on_transmit_pos(target_pos_key, face_pos_key, transition)
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  local target_posx, target_posy, target_posz = scene_logic:get_pos_key_position(target_pos_key)
  local face_posx, face_posy, face_posz = scene_logic:get_pos_key_position(face_pos_key)
  local is_lerp = transition and transition > 0
  if not is_lerp then
    self:set_pos(target_posx, target_posy, target_posz)
    self:face_to_pos(face_posx, face_posz, true)
  else
    local time = self:get_dt()
    local lerp_val = time * transition
    self.v_transmit_data = {
      start_pos = self.v_position,
      target_pos = Vec3.New(target_posx, target_posy, target_posz),
      face_pos = Vec3.New(face_posx, face_posy, face_posz),
      lerp_Val = lerp_val
    }
    self:update_char_transmit_pos()
  end
end

function M:on_transmit_pos_new(target_pos_key, face_angle, transition)
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  local target_posx, target_posy, target_posz = scene_logic:get_pos_key_position(target_pos_key)
  local is_lerp = transition and transition > 0
  if not is_lerp then
    self:set_pos(target_posx, target_posy, target_posz)
    self:face_to_pos_by_angle(face_angle, true)
  else
    local time = self:get_dt()
    local lerp_val = time * transition
    self.v_transmit_data = {
      start_pos = self.v_position,
      target_pos = Vec3.New(target_posx, target_posy, target_posz),
      face_pos = Vec3.New(0, face_angle, 0),
      lerp_Val = lerp_val
    }
    self:update_char_transmit_pos()
  end
end

function M:update_char_transmit_pos()
  if not self.v_transmit_data then
    return
  end
  local transmit_data = self.v_transmit_data
  local start_pos = transmit_data.start_pos
  local target_pos = transmit_data.target_pos
  local lerp_val = transmit_data.lerp_Val
  local face_pos = transmit_data.face_pos
  local distance = Vec3.Distance(start_pos, target_pos)
  if distance <= 0.01 then
    self.v_transmit_data = nil
    self:set_pos(target_pos.x, target_pos.y, target_pos.z)
    if UNITY_EDITOR and Global.debug then
      Log.Info("传送插值已完成")
    end
  else
    local pos_x, pos_y, pos_z = Vec3.LerpB(start_pos, target_pos, lerp_val)
    self:set_pos(pos_x, pos_y, pos_z)
  end
  self:face_to_pos(face_pos.x, face_pos.z, true)
end

function M:check_transmit()
  return self.v_transmit_data
end

function M:remove_area(key, tag)
  if not SceneMgr then
    return
  end
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:remove_area(key, tag)
  end
end

function M:set_is_set_die_state(is_set)
  self.v_is_set_die_state = is_set
end

function M:get_is_set_die_state()
  return self.v_is_set_die_state
end

function M:get_nearest_walkable_pos()
  local is_change, new_x, new_y, new_z = self.navigator_ctrl:get_nearest_walkable_pos(self.v_position.x, self.v_position.y, self.v_position.z)
  return is_change, new_x, new_y, new_z
end

function M:is_have_tough()
  return false
end

function M:set_ignore_sync(is_ignore)
  self.v_is_ignore_sync = is_ignore
end

function M:set_cur_action_missile_id(id)
  self.v_cur_action_missile_id = id
end

function M:get_cur_action_missile_id()
  return self.v_cur_action_missile_id
end

function M:get_gameobj_active()
  return self.v_gameobj_active
end

function M:change_gameobj(prefab_index, save_vfx)
  if not (self.character_cfg and self.character_cfg.ModelIdList) or not self.character_cfg.ModelIdList[prefab_index] then
    Log.Error("切换预制失败，请检查配置", debug.traceback())
    return
  end
  if self.v_change_go_info then
    Log.Error("正在切换预制中，不可重复切换", debug.traceback())
    return
  end
  self.v_change_go_info = {
    prefab_index = prefab_index,
    model_id = self.character_cfg.ModelIdList[prefab_index],
    save_vfx = save_vfx,
    on_recreate = true
  }
  if self.act_ctrl then
    self.v_change_go_info.cur_action = self.act_ctrl:get_cur_action()
  end
  self.model_cfg = ShareRes.create("character.character_model", self.v_change_go_info.model_id)
  if self.model_cfg and self.model_cfg.ControllerPath then
    SceneMgr:load_model_animator(self)
  else
    SceneMgr:load_gameobj_async(self)
  end
end

function M:on_recreate_gameobj(gameobj)
  if self.cid then
    SceneMgr:remove_client_obj(self.cid)
  end
  if self.act_effect_ctrl then
    if self.v_change_go_info.save_vfx then
      self.act_effect_ctrl:set_new_effect_owner_go(gameobj)
    else
      self.act_effect_ctrl:clear_effect_on_change_go()
    end
  end
end

function M:on_recreate_gameobj_try_action()
  if self:is_on_recreate_gameobj() and self.act_ctrl and self.v_change_go_info.cur_action then
    self:obj_try_ation(self.v_change_go_info.cur_action)
    self.v_change_go_info.cur_action = nil
  end
end

function M:on_recreate_go_suc()
  if self:is_on_recreate_gameobj() then
    self.v_change_go_info.on_recreate = false
  end
end

function M:get_change_gameobj_info()
  return self.v_change_go_info
end

function M:clear_change_go_info()
  self.v_change_go_info = nil
end

function M:is_on_recreate_gameobj()
  return self.v_change_go_info and self.v_change_go_info.on_recreate
end

function M:obj_try_ation(action_name)
  if not self.act_ctrl then
    return
  end
  
  local function pass_cb()
    self.act_ctrl:try_action(action_name, 0)
  end
  
  self:check_motion_config(action_name, pass_cb)
end

function M:check_motion_config(action_name, pass_cb)
  if self.motion_cfg and self.motion_cfg[action_name] then
    if pass_cb then
      pass_cb()
    end
    return true
  else
    Log.Error("角色", self.character_cfg.NpcId, "motion无", action_name, "配置", debug.traceback())
    return false
  end
end

function M:is_after_behitfly_die()
  return false
end

function M:get_cur_action()
  if not self.act_ctrl then
    return nil
  end
  return self.act_ctrl:get_cur_action()
end

function M:refresh_ray_max_dis()
  self.v_init_ray_max_dis = ShareRes.get_comm_value("RoleRayCheckMaxY")
  if TowerMgr and self:is_hero() then
    local curr_room_id = TowerMgr:get_cur_room_id()
    local room_cfg = ShareRes.create("tower.tower_room", curr_room_id)
    if room_cfg and room_cfg.RoleRayCheckMaxY then
      self.v_init_ray_max_dis = room_cfg.RoleRayCheckMaxY
    end
  end
  self.v_ray_max_dis = self.v_init_ray_max_dis
end

function M:is_ui_model()
  return self.v_is_ui_model
end

function M:set_finish_init_gameobj(is_finish)
  self.v_finish_init_gameobj = is_finish
end

function M:set_local_name(name)
  self.v_npc_local_name = name
end

function M:get_local_name()
  return self.v_npc_local_name
end

function M:refresh_lock_info(lock_enemy_list)
  self.v_lock_npc_list = nil
  if not lock_enemy_list then
    return
  end
  self.v_lock_npc_list = {}
  for i, info in ipairs(lock_enemy_list) do
    local key = info.Target
    local npc_id = tonumber(info.Target)
    if npc_id then
      key = npc_id
    end
    local npc_info = {}
    npc_info.be_hit = info.Behit
    npc_info.weight = info.Weight
    npc_info.ignore_distance = info.IgnoreDistance
    self.v_lock_npc_list[key] = npc_info
  end
end

function M:get_monster_search_config()
  return self.v_lock_npc_list
end

function M:sync_lua_position()
  local x, y, z = self.transform:GetPositionA()
  self.v_position:Set(x, y, z)
end

function M:set_cache_move(x, y, z)
  self.v_cache_move.x = x
  self.v_cache_move.y = y
  self.v_cache_move.z = z
end

function M:set_update_land_height_block(state_name, block_enable)
  self.update_land_height_block[state_name] = block_enable
  self.v_enable_land_height_block = next(self.update_land_height_block) ~= nil
end

return M
