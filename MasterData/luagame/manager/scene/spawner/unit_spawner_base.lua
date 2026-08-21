local M = Util.create_class()
local default_radius = 0.65
local Vec3 = require("base.vec3")
local Math = require("base.mathx")
local BornPosType = {RandomQuadrant = 1, SequenceQuadrant = 2}

function M:_init(logic_runner, action_cfg)
  self.v_logic_runner = logic_runner
  self.v_action_cfg = action_cfg
  self.v_spawn_type = self.v_action_cfg.SpawnType
  self.v_max_active_unit_count = self.v_action_cfg.MaxActiveUnitCount
  self.v_ai_difficulty_tag = self.v_action_cfg.AIDifficultyTag
  self.v_end_event_name = self.v_action_cfg.EventName
  self.v_min_create_radius = self.v_action_cfg.MinCreateRadius
  self.v_max_create_radius = self.v_action_cfg.MaxCreateRadius
  self.v_born_pos_type = self.v_action_cfg.BornPosType
  self.v_cur_active_count = 0
  self.v_remain_spawn_count = 0
  if self.v_born_pos_type == BornPosType.SequenceQuadrant then
    self.v_quadrant_index = 1
  end
  self.v_radius_interval = self.v_max_create_radius - self.v_min_create_radius
  self.v_npc_uuid_map = {}
  self.v_npc_born_pos_map = {}
  self.v_remove_event_name = self.v_action_cfg.EventName
  self.v_auto_remove_self = true
  Util.bind_msg(self, Const.MSG_ON_NPC_BIRTH, self.on_npc_born, self)
  Util.bind_msg(self, Const.MSG_ROLE_DEAD, self.on_npc_dead, self)
  Util.bind_msg(self, Const.MSG_OBJ_LEAVE, self.on_obj_leave, self)
end

local TEMP_MILTI = {
  1,
  1,
  -1,
  -1,
  1
}

local function get_random_pos(quadrant, x, z, min_radius, interval)
  local milti_x, milti_z = TEMP_MILTI[quadrant], TEMP_MILTI[quadrant + 1]
  local radius_x, radius_z = math.random() * interval + min_radius, math.random() * interval + min_radius
  local random_x, random_z = radius_x * milti_x, radius_z * milti_z
  return x + random_x, z + random_z
end

function M:get_unit_born_position(uuid)
  local hx, hy, hz = Global.hero:get_pos()
  local x, z
  local use_pos = Vec3.New()
  for _ = 1, 5 do
    local quadrant
    if self.v_born_pos_type == BornPosType.RandomQuadrant then
      quadrant = math.random(1, 4)
    elseif self.v_born_pos_type == BornPosType.SequenceQuadrant then
      quadrant = self.v_quadrant_index
      self.v_quadrant_index = self.v_quadrant_index + 1
      self.v_quadrant_index = self.v_quadrant_index <= 4 and self.v_quadrant_index or 1
    end
    x, z = get_random_pos(quadrant, hx, hz, self.v_min_create_radius, self.v_radius_interval)
    local pos_can_use = true
    for _, pos in pairs(self.v_npc_born_pos_map) do
      if Math.distance2(pos.x, pos.z, x, z) < default_radius * 2 then
        pos_can_use = false
        break
      end
    end
    use_pos:Set(x, hy, z)
    if pos_can_use then
      local _
      _, use_pos = SceneMgr:get_nearest_walkable_pos(Global.hero:get_pos_vec3(), use_pos, default_radius)
      break
    end
  end
  self.v_npc_born_pos_map[uuid] = use_pos
  return self.v_npc_born_pos_map[uuid]
end

local OrientationType = {
  LookAtPlayer = 1,
  Random = 2,
  BackOnToPlayer = 3
}

function M:get_unit_born_dir(born_x, born_z, dir_type)
  local hx, hz = Global.hero:get_pos2()
  if dir_type == OrientationType.LookAtPlayer then
    return Math.get_lookat_dir(hx, hz, born_x, born_z)
  elseif dir_type == OrientationType.Random then
    return math.random(0, 360)
  elseif dir_type == OrientationType.BackOnToPlayer then
    return Math.get_positibe_angle(Math.get_lookat_dir(hx, hz, born_x, born_z) + 180)
  end
end

function M:on_npc_born(msg)
  local npc = msg.mm_obj
  if self.v_npc_born_pos_map[npc.uuid] then
    self.v_npc_born_pos_map[npc.uuid] = nil
  end
end

function M:on_npc_dead(msg)
  local uuid = msg.mm_obj.uuid
  self:remove_npc_tag(uuid)
end

function M:on_obj_leave(msg)
  local uuid = msg.mm_obj
  self:remove_npc_tag(uuid)
end

function M:add_npc_tag(uuid)
  self.v_npc_uuid_map[uuid] = true
  self.v_remain_spawn_count = self.v_remain_spawn_count - 1
  self.v_cur_active_count = self.v_cur_active_count + 1
end

function M:remove_npc_tag(uuid)
  if self.v_npc_uuid_map[uuid] then
    self.v_cur_active_count = self.v_cur_active_count - 1
    self.v_npc_uuid_map[uuid] = nil
    if self.v_remain_spawn_count > 0 then
      self:spawn_unit()
    elseif self.v_cur_active_count <= 0 then
      self:on_spawner_unit_clear()
    end
  end
end

function M:on_spawner_unit_clear()
  if not Util.is_empty(self.v_remove_event_name) then
    self.v_logic_runner:on_spawner_unit_clear(self.v_remove_event_name)
  end
  self.v_logic_runner:remove_spawner_behavior(self)
end

function M:on_destroy()
  self:clear_all_npc()
  self.v_logic_runner = nil
  self.v_action_cfg = nil
  self.v_spawn_type = nil
  self.v_max_active_unit_count = nil
  self.v_ai_difficulty_tag = nil
  self.v_end_event_name = nil
  self.v_min_create_radius = nil
  self.v_max_create_radius = nil
  self.v_quadrant_index = nil
  self.v_remove_event_name = nil
  Util.unbind_all_msg(self)
end

function M:clear_all_npc()
  for uuid in pairs(self.v_npc_uuid_map) do
    local npc = SceneMgr:pick_by_uuid(uuid)
    if not Util.is_destroy(npc) then
      SceneMgr:remove_npc2(npc)
    end
    self.v_npc_uuid_map[uuid] = nil
  end
end

return M
