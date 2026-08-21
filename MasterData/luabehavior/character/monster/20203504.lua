local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill02 = {
    2020350401,
    7,
    3,
    0,
    2,
    get_skill_cfg(20100902).CastTime,
    get_skill_cfg(20100902).AfterTime,
    0
  }
  self.skill01 = {
    2020350402,
    1,
    1.5,
    0,
    2,
    get_skill_cfg(20100901).CastTime,
    get_skill_cfg(20100901).AfterTime,
    0
  }
  self.camp_skill_list = {
    self.skill01,
    self.skill02
  }
  self.counter_reatk_skill = self.skill01
  self.monster_type = 1
  self.control = 0
  self.target = nil
  self.stun_info = {set = false, time = 0}
end

function M:on_skill_end(npc, skill_id)
  Base.on_skill_end(self, npc, skill_id)
  if npc == self.npc and skill_id ~= self.born_skill then
    self.stun_info.set = true
    self.stun_info.time = get_npc_time(self.npc) + 1
    self.wander_state = 0
    self.control = 99
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  local now_time = get_npc_time(self.npc)
  local pos = get_npc_pos(npc)
  local offse = get_dir_offset(self.npc, pos.x, pos.z)
  if offse <= 90 then
    cast_skill(self.npc, self.target, self.skill01[1])
    self.skill01[3] = now_time + self.skill01[2]
  end
end

function M:skill_cast()
  local now_time = get_npc_time(self.npc)
  local ran_interval = math.random() * 2.5 + 1.5
  if check_npc_distance(self.npc, self.target, self.skill02[5], false) and not check_npc_distance(self.npc, self.target, self.skill02[4], false) then
    cast_skill(self.npc, self.target, self.skill02[1])
    self.control = 1
  end
end

function M:skill_main_logic()
  if CommonMonster.skill_main_condition(self) then
    return
  end
  if get_target_angel(self.npc, self.target, true) <= -60 and get_target_angel(self.npc, self.target, true) >= 60 then
    return
  end
  if not self:skill_cast(self.skill01) then
  end
end

function M:on_frame()
  CommonMonster.search_target(self, 30, 4)
  CommonMonster.monster_on_frame(self)
  CommonMonster.wander_main_logic(self, 1.5, 2.5, 1)
  self:skill_main_logic()
  CommonMonster.Hit_wall(self)
  CommonMonster.platform_move(self)
end

return M
