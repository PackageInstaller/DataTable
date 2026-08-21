local M = Util.create_class()
local Vec3 = require("base.vec3")
local Math = require("base.mathx")
local SCENE_ROOT = "Root"
local UnityFind = CS.UnityEngine.GameObject.Find
local Effect_fast1 = 1033010101
local Effect_fast2 = 1033010102
local Effect_mid1 = 1033010103
local Effect_mid2 = 1033010104
local Effect_long1 = 1033010105
local Effect_long2 = 1033010106
local Effect_mid11 = 1033010111

function M:_init(npc)
  self.switch_effect_cfg0 = {
    [1] = {
      8.5,
      1.7,
      {Effect_mid1, Effect_mid2}
    }
  }
  self.switch_effect_cfg0_1 = {
    [1] = {
      0,
      2.5,
      {Effect_long1, Effect_long2}
    },
    [2] = {
      0,
      2.5,
      {Effect_long1, Effect_long2}
    }
  }
  self.switch_effect_cfg1 = {
    [1] = {
      0,
      1.7,
      {Effect_mid1, Effect_mid2}
    }
  }
  self.switch_effect_cfg1_1 = {
    [1] = {
      1,
      0.5,
      {Effect_mid11}
    }
  }
  self.switch_effect_cfg1_5 = {
    [1] = {
      1,
      2.5,
      {Effect_long1}
    }
  }
  self.switch_effect_cfg1_9 = {
    [1] = {
      0,
      0,
      {}
    }
  }
  self.switch_effect_cfg1_2 = {
    [1] = {
      0,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [2] = {
      0.5,
      0,
      {Effect_fast1, Effect_fast2}
    }
  }
  self.switch_effect_cfg1_3 = {
    [1] = {
      0,
      2.5,
      {Effect_long1, Effect_long2}
    },
    [2] = {
      1.5,
      0,
      {Effect_fast1, Effect_fast2}
    }
  }
  self.switch_effect_cfg2_1 = {
    [1] = {
      1,
      1.7,
      {Effect_mid1, Effect_mid1}
    }
  }
  self.switch_effect_cfg2_2 = {
    [1] = {
      0,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [2] = {
      1,
      1.7,
      {Effect_mid1, Effect_mid1}
    },
    [3] = {
      0.5,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [4] = {
      1,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [5] = {
      0.5,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [6] = {
      1,
      1.7,
      {Effect_mid1, Effect_mid2}
    },
    [7] = {
      0.5,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [8] = {
      1,
      1.7,
      {Effect_mid1, Effect_mid2}
    }
  }
  self.switch_effect_cfg2_3 = {
    [1] = {
      3,
      4.7,
      {Effect_mid1, Effect_mid1}
    }
  }
  self.switch_effect_cfg2_4 = {
    [1] = {
      1.5,
      0.5,
      {Effect_mid11}
    },
    [2] = {
      1,
      0,
      {Effect_fast1, Effect_fast2}
    }
  }
  self.switch_effect_cfg3_1 = {
    [1] = {
      1.5,
      0.5,
      {Effect_mid11}
    },
    [2] = {
      1.5,
      0.5,
      {Effect_mid11}
    }
  }
  self.switch_effect_cfg3_2 = {
    [1] = {
      0.3,
      0.5,
      {Effect_mid11}
    }
  }
  self.switch_effect_cfg3_3 = {
    [1] = {
      0.5,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [2] = {
      1.5,
      0.5,
      {Effect_mid11}
    }
  }
  self.switch_effect_cfg4_1 = {
    [1] = {
      0.5,
      0,
      {Effect_fast1}
    },
    [2] = {
      1.5,
      0.5,
      {Effect_mid11}
    },
    [3] = {
      1.5,
      0.5,
      {Effect_mid11}
    },
    [4] = {
      1,
      0,
      {Effect_fast1}
    }
  }
  self.switch_effect_cfg4_2 = {
    [1] = {
      1.5,
      0.5,
      {Effect_mid11}
    }
  }
  self.switch_effect_cfg4_3 = {
    [1] = {
      5,
      0.5,
      {Effect_mid11}
    },
    [2] = {
      0.2,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [3] = {
      1,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [4] = {
      0.5,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [5] = {
      1,
      0.5,
      {Effect_mid11}
    }
  }
  self.switch_effect_cfg4_4 = {
    [1] = {
      2.8,
      0,
      {Effect_fast1}
    },
    [2] = {
      0.2,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [3] = {
      1.8,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [4] = {
      0.2,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [5] = {
      1,
      2.5,
      {Effect_long1, Effect_long2}
    }
  }
  self.v_move_npc_group_ids = {
    10330201,
    10330401,
    10330402
  }
  self.v_born_magic_ids = {1033010107}
  self.v_is_move_scene_down = true
  self.v_step_index = 1
  self.v_step_start_time = 0
  self.v_root_trans = UnityFind(SCENE_ROOT).transform
  self.v_enable_collision_stuck = true
  self.npc = npc
  local room_id = get_cur_room_id()
  if 1324 == room_id then
    self:start_switch_scene_effect(self.switch_effect_cfg1_9, false)
  end
end

function M:on_story_finish(story_id)
end

function M:on_enter_area(npc, area)
  if npc == get_come_on_hero() then
    if area.Key == "W2" then
      self:start_switch_scene_effect(self.switch_effect_cfg1_2, false)
      remove_area("W2", "")
    end
    if area.Key == "SC5" then
      self:start_switch_scene_effect(self.switch_effect_cfg1_2, false)
      remove_area("SC5", "")
    end
  end
end

function M:on_magic_begin(npc, target, magic_id)
  if 4032098 == magic_id then
    self:pause_switch_scene_effect()
  end
end

function M:on_play_finish(cfg)
  if cfg == self.switch_effect_cfg2_2 then
    set_scene_camera(111)
    start_stroy(103302)
    cast_magic(self.npc, self.npc, 1033010109, 0)
  end
end

function M:on_enter_room(room_id, is_first_enter)
  if 1324 == room_id then
    self:start_switch_scene_effect(self.switch_effect_cfg1_5, false)
  end
end

function M:on_room_pass(roomid)
  if 12 == roomid then
    self:clear_timer()
    abort_magic_by_id(self.npc, 1033010109, 0)
    self:start_switch_scene_effect(self.switch_effect_cfg3_3, true)
  end
end

function M:on_frame()
  if get_sync_var("BBBBB") and self.v_is_move_scene_down then
    set_sync_var("BBBBB", false)
    self:start_switch_scene_effect(self.switch_effect_cfg4_4, false)
  end
  if get_sync_var("story_end") then
    set_sync_var("story_end", false)
    self:start_switch_scene_effect(self.switch_effect_cfg4_3, false)
  end
  if get_sync_var("2031101") then
    set_sync_var("2031101", false)
    self:start_switch_scene_effect(self.switch_effect_cfg4_4, false)
  end
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

function M:start_switch_scene_effect(tb, is_loop, used_time)
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
          self:move_scene_root()
          self:move_npc()
          self:move_functional_npc()
          self:start_switch_scene_effect(tb, is_loop)
        end)
      end, nil, nil, nil, true)
    else
      self.v_step_index = 1
      self.v_step_cfg = nil
      self:on_play_finish(tb)
    end
  end
end

function M:move_scene_root()
  if self.v_root_trans == nil then
    return
  end
  local pos = self.v_root_trans.position
  self.v_root_trans.position = Vec3.New(pos.x, pos.y + (self.v_is_move_scene_down and -1000 or 1000), pos.z)
  self:on_move_scene(not self.v_is_move_scene_down)
end

function M:on_move_scene(is_down)
  if is_down then
    self:apply_second_scene_illumination()
  else
    self:apply_defualt_scene_illumination()
  end
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
local AstarHelper = CS.Game.AstarHelper

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
  if npc:get_group_id() == 10330202 then
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
