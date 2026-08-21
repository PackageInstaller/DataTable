local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config5", "common")

function M:_init(...)
  Base._init(self, ...)
  self.monsternum = 0
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.normal_level = 5
  self.rare_level = 5
  self.boss_level = 5
  self.room_type = self:get_room_type()
  self.monster_list = {}
  self.is_add_npc = 0
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
end

function M:on_enter()
  if self:is_pass_room() then
    self:set_scene_camera(9901)
    local x, y = self:get_scene_map_pos_postion("center")
    self:lookat_position(Global.hero, x, y, true)
    self:open_all_transmit()
  elseif not self:is_pass_room() then
    self:set_scene_camera(9902)
    local x, y = self:get_scene_map_pos_postion("center")
    self:lookat_position(Global.hero, x, y, true)
    local random = math.random(1, 2)
    local monster_data = monster_cfg.get_monster_cfg(random, self.floor_num)
    for _, data in ipairs(monster_data) do
      local lv = self.monster_lv[data[10]]
      self:add_monster(data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8], data[9], lv)
    end
  end
end

function M:add_monster(...)
  local monster = self:add_npc_by_pos_key(...)
  table.insert(self.monster_list, monster)
end

function M:on_npc_dead(npc)
  local count = #self.monster_list
  for i = count, 1, -1 do
    local monster = self.monster_list[i]
    if monster == npc then
      table.remove(self.monster_list, i)
    end
  end
  if 0 == #self.monster_list and not self:is_pass_room() and 0 == self.monsternum then
    self.monsternum = 1
    self:fight_end(true)
    self:end_perform(self.room_type)
    self.settlementTime = os.time()
    self:open_all_transmit()
    if 0 == self.is_add_npc then
      self:add_functional_npc(1, "NPC", "tp1")
      self.is_add_npc = 1
    end
  end
end

function M:on_frame()
  if self.settlementTime and os.time() - self.settlementTime >= 2 then
    self.settlementTime = nil
    self:set_scene_camera(9901)
  end
end

function M:on_hero_dead()
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  self:judge_all_tp(area)
end

function M:on_leave_area(npc, area)
  if not self:is_pass_room() then
    self.fire_and_ice(self, area)
  end
  if not self:is_pass_room() then
    if area.Key == "fire" then
      self:timer_call_out_remove("fire_count")
    end
    if area.Key == "ice" then
      self:timer_call_out_remove("ice_count")
    end
  end
end

function M:on_save()
  local data = {
    is_add_npc = self.is_add_npc,
    num = self.airwall_control
  }
  return data
end

function M:on_load(data)
  self.is_add_npc = data.is_add_npc
  self.airwall_control = data.num or self.airwall_control
end

return M
