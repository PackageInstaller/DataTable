local M = Util.create_class()
local Vec3 = require("base.vec3")
local Math = require("base.mathx")
local SCENE_ROOT = "Root"
local GROUP_CTRL_OBJ = "GroupCtrlObj"
local UnityFind = CS.UnityEngine.GameObject.Find
local Effect_fast1 = 1033010101
local Effect_fast2 = 1033010102
local Effect_mid1 = 1033010103
local Effect_mid2 = 1033010104
local Effect_long1 = 1033010105
local Effect_long2 = 1033010106
local Effect_mid11 = 1033010111

function M:_init(npc)
  self.switch_effect_cfg1_1 = {
    [1] = {
      1.5,
      1.7,
      {Effect_mid1, Effect_mid2}
    },
    [2] = {
      1.5,
      1.7,
      {Effect_mid1, Effect_mid2}
    }
  }
  self.switch_effect_cfg1_2 = {
    [1] = {
      0.5,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [2] = {
      1.5,
      1.7,
      {Effect_mid1, Effect_mid2}
    }
  }
  self.v_move_npc_group_ids = {
    7030101,
    7030102,
    7030201,
    7030202,
    50309102,
    5031011,
    5031012,
    50310102,
    50310101,
    5031021,
    5031022,
    50310201,
    50310202,
    7030601,
    7030602
  }
  self.v_born_magic_ids = {1033010107}
  self.v_born_magic_buff_ids = {}
  self.v_is_move_scene_down = true
  self.v_step_index = 1
  self.v_step_start_time = 0
  self.v_root_trans = UnityFind(SCENE_ROOT).transform
  self.v_enable_collision_stuck = true
end

function M:on_born_behavior()
  if get_cur_room_id() == 503090 or get_cur_room_id() == 503091 or get_cur_room_id() == 503111 then
    self:start_switch_scene_effect(self.switch_effect_cfg1_1, true)
  end
  if get_cur_room_id() == 503101 or get_cur_room_id() == 503102 then
    self:start_switch_scene_effect(self.switch_effect_cfg1_1, true)
  end
end

function M:on_enter_area(npc, area)
end

function M:on_play_finish(cfg)
  if cfg == self.switch_effect_cfg2_2 then
  end
end

function M:on_move_scene(is_down)
  if is_down then
    self:apply_second_scene_illumination()
  else
    self:apply_defualt_scene_illumination()
  end
end

function M:on_room_pass(roomid)
  if 103304 == roomid then
  end
end

function M:on_magic_begin(npc, target, magic_id)
  if 3001039013 == magic_id then
    self:pause_switch_scene_effect()
  end
end

function M:on_magic_end(npc, target, magic_id)
  if 3001039013 == magic_id then
    self:restart_switch_scene_effect()
  end
end

function M:on_frame()
end

function M:pause_switch_scene_effect()
  self:clear_timer()
  self.v_pause_used_time = get_npc_time(self.npc) - self.v_step_start_time
end

function M:restart_switch_scene_effect()
  self:clear_timer()
  if self.v_step_cfg == nil then
    return
  end
  self:start_switch_scene_effect(self.v_cur_cfg, self.v_is_loop, self.v_pause_used_time)
end

function M:stop_switch_scene_effect()
  self:clear_timer()
  self.v_step_index = 1
  self.v_step_cfg = nil
end

function M:start_switch_scene_effect(tb, is_loop, used_time, go_path)
  self.v_cur_cfg = tb
  self.v_is_loop = is_loop
  self:clear_timer()
  if tb then
    self.v_step_cfg = tb[self.v_step_index]
    if self.v_step_cfg then
      self.v_step_start_time = get_npc_time(self.npc)
      self.v_timer = Timer:add_timer(self.npc.uuid .. "step_timer", self.v_step_cfg[1] - (used_time or 0), function()
        for index = 1, #self.v_step_cfg[3] do
          cast_magic(self.npc, get_come_on_hero(), self.v_step_cfg[3][index], 0)
        end
        self.v_magic_timer = Timer:add_timer(self.npc.uuid .. "cast_magic_timer", self.v_step_cfg[2], function()
          play_common_sound("Sound_screen_witch")
          self.v_is_move_scene_down = not self.v_is_move_scene_down
          self.v_step_index = self.v_step_index + 1
          if self.v_step_index > #tb and is_loop then
            self.v_step_index = 1
          end
          if go_path then
            self:move_go(go_path)
          else
            self:move_scene_root()
          end
          self:move_npc()
          self:move_functional_npc()
          if self.v_enable_collision_stuck then
            self:check_hero_stuck()
          end
          self:start_switch_scene_effect(tb, is_loop, nil, go_path)
        end)
      end, nil, nil, nil, true)
    else
      self.v_step_index = 1
      self.v_step_cfg = nil
      self:on_play_finish(tb)
    end
  end
end

local group_ctrl_obj

function M:find_go_in_group_ctrl_obj(go_path)
  if not group_ctrl_obj or group_ctrl_obj:IsNull() then
    group_ctrl_obj = UnityFind(GROUP_CTRL_OBJ)
    if not group_ctrl_obj or group_ctrl_obj:IsNull() then
      return
    end
  end
  return group_ctrl_obj.transform:Find(go_path)
end

local find_go_trans_cache = {}

function M:move_go(go_path)
  local go_trans = find_go_trans_cache[go_path]
  if not go_trans or go_trans:IsNull() then
    local go = self:find_go_in_group_ctrl_obj(go_path)
    if not go then
      return
    end
    go_trans = go.transform
    find_go_trans_cache[go_path] = go_trans
  end
  local pos = go_trans.position
  go_trans:SetPositionA(pos.x, pos.y + (self.v_is_move_scene_down and -1000 or 1000), pos.z)
  self:on_move_scene(not self.v_is_move_scene_down)
end

function M:move_scene_root()
  if self.v_root_trans == nil then
    return
  end
  local pos = self.v_root_trans.position
  self.v_root_trans.position = Vec3.New(pos.x, pos.y + (self.v_is_move_scene_down and -1000 or 1000), pos.z)
  self:on_move_scene(not self.v_is_move_scene_down)
end

function M:move_npc()
  local all_npc = SceneMgr:get_all_npc()
  if not all_npc then
    return
  end
  for _, npc in pairs(all_npc) do
    local need_move = false
    for index = 1, #self.v_move_npc_group_ids do
      if self.v_move_npc_group_ids[index] == npc:get_group_id() then
        need_move = true
      end
    end
    if npc.id == 10330101 then
      need_move = true
    end
    if need_move then
      local dy = self.v_is_move_scene_down and -1000 or 1000
      npc.v_last_land_height = npc.v_last_land_height and npc.v_last_land_height + dy
      npc.v_land_height = npc.v_land_height and npc.v_land_height + dy
      npc:set_pos_by_delta(0, dy, 0)
      npc:enable_ragdoll_animator(self.v_is_move_scene_down)
    end
  end
end

function M:move_functional_npc()
  local all_func_npc = SceneMgr:get_all_functional_npc()
  for _, npc in pairs(all_func_npc) do
    npc:set_pos_by_delta(0, self.v_is_move_scene_down and -1000 or 1000, 0)
  end
end

function M:clear_timer()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
  if self.v_magic_timer then
    Timer:remove_timer(self.v_magic_timer)
    self.v_magic_timer = nil
  end
end

function M:on_remove()
  self:clear_timer()
end

local AstarHelper = CS.Game.AstarHelper

function M:check_hero_stuck()
  if not self:is_in_plat() then
    self:check_stuck_in_base_region()
  end
end

local dir_tb = {
  Vec3.right,
  Vec3.left,
  Vec3.forward,
  Vec3.back
}
local dist_tb = {
  1,
  2,
  4
}

function M:check_stuck_in_base_region()
  local hero = Global.hero
  local hero_pos = hero:get_pos_vec3()
  local offset_y = self.v_is_move_scene_down and 0 or -1000
  local map = SceneMgr:get_scene_map()
  local region = map:get_base_region()
  local gg = region:get_gg()
  local x, y, z = hero_pos.x, hero_pos.y + offset_y, hero_pos.z
  local body_size = hero.navigator_ctrl:get_body_size()
  local is_walkable = AstarHelper.IsGridSuitableForBodyOfGraph(body_size, x, y, z, gg)
  if is_walkable then
    return
  end
  local success, new_x, new_y, new_z = AstarHelper.GetNeartSuitablePosForBody(body_size, 5, x, y, z, gg)
  if success then
    hero:set_pos(new_x, new_y - offset_y, new_z)
    hero:update_pos_height()
  end
end

function M:is_in_plat()
  local hero = Global.hero
  if not hero then
    return
  end
  local x, y, z = hero:get_pos()
  local new_y = y + 1000
  local cid, plat = SceneMgr:get_plat_mgr():get_region_at_pos(x, z, new_y)
  if plat then
    return true
  end
  new_y = y - 1000
  local cid, plat = SceneMgr:get_plat_mgr():get_region_at_pos(x, z, new_y)
  if plat then
    return true
  end
end

function M:enable_collision_stuck()
  self.v_enable_collision_stuck = true
end

function M:disable_collision_stuck()
  self.v_enable_collision_stuck = false
end

function M:on_npc_born(npc)
  for i = 1, #self.v_move_npc_group_ids do
    if npc:get_group_id() == self.v_move_npc_group_ids[i] then
      for j = 1, #self.v_born_magic_ids do
        cast_magic(npc, npc, self.v_born_magic_ids[j], 0)
      end
    end
  end
  if npc:get_group_id() == 10330302 then
    abort_magic_by_id(self.npc, 1033010109, 0)
    self:start_switch_scene_effect(self.switch_effect_cfg2_4, true)
  end
end

function M:apply_defualt_scene_illumination()
  if not SceneMgr then
    return
  end
  SceneMgr:apply_defualt_scene_illumination()
end

function M:apply_second_scene_illumination()
  if not SceneMgr then
    return
  end
  SceneMgr:apply_second_scene_illumination()
end

return M
