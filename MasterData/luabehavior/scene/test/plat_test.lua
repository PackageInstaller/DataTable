local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.room_type = self:get_room_type()
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = self:get_tower_monster_level("MonLevel2")
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
  self.plat1_move = 0
  self.plat2_move = 0
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:set_scene_camera(9901)
  self:fight_end(true)
  self:open_all_transmit()
  self:set_plat_active("plat1", true)
  self:set_plat_active("plat2", true)
  self.settleTime = os.time()
  self.settleTime2 = os.time()
end

function M:plat1_wander()
  if 0 == self.plat1_move and self.settleTime and os.time() - self.settleTime >= 10 then
    self:move_plat_to_pos("plat1", "plat1go1", 3)
    self.plat1_move = 1
    self.settleTime = os.time()
  elseif 1 == self.plat1_move and self.settleTime and os.time() - self.settleTime >= 10 then
    self:move_plat_to_pos("plat1", "plat1go2", 3)
    self.plat1_move = 0
    self.settleTime = os.time()
  end
end

function M:plat2_wander()
  if 0 == self.plat2_move and self.settleTime2 and os.time() - self.settleTime2 >= 5 then
    self:move_plat_to_pos("plat2", "plat2go2", 3)
    self.plat2_move = 1
    self.settleTime2 = os.time()
  elseif 1 == self.plat2_move and self.settleTime2 and os.time() - self.settleTime2 >= 5 then
    self:move_plat_to_pos("plat2", "plat2go1", 3)
    self.plat2_move = 0
    self.settleTime2 = os.time()
  end
end

function M:on_npc_dead(npc)
end

function M:on_frame()
  self:plat1_wander()
  self:plat2_wander()
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  self:judge_all_tp(area)
end

function M:on_leave_area(npc, area)
end

function M:on_save()
end

function M:on_load(data)
end

return M
