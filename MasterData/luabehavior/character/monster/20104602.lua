local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.Skill01 = {
    2010460201,
    8,
    0,
    1.5,
    3,
    get_skill_cfg(2010460201).CastTime,
    get_skill_cfg(2010460201).AfterTime
  }
  self.Skill02 = {
    2010460202,
    8,
    0,
    1.5,
    3,
    get_skill_cfg(2010460202).CastTime,
    get_skill_cfg(2010460202).AfterTime
  }
  self.AllowCastSkill = true
  self.target = nil
  self.AllowSelfDestory = false
  self.selfdestory = 5
  self.IsSelfDestory = false
  self.Confirmtime = 0
end

function M:on_born_behavior()
  cast_magic(self.npc, self.npc, 2010460202, 1)
  enable_shadow(self.npc, false)
  set_npc_hp_visible(self.npc, false)
  cast_magic(self.npc, self.npc, 30010050101, 1)
  cast_magic(self.npc, self.npc, 300100501012, 1)
  cast_magic(self.npc, self.npc, 300100501013, 1)
  set_can_searched(self.npc, false)
end

function M:CheckDistance()
  local distance = get_npc_distance(self.npc, 1, self.target, false)
  if distance <= 12 and self.AllowSelfDestory == false then
    self.Confirmtime = get_npc_time(self.npc) + self.selfdestory
    self.AllowSelfDestory = true
  end
end

function M:CheckSelfDestory()
  if get_npc_time(self.npc) > self.Confirmtime and self.IsSelfDestory == false then
    self.IsSelfDestory = true
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.npc, 2010460202)
  end
end

function M:skill_main_logic()
  if self.AllowCastSkill == true then
    self.AllowCastSkill = false
    self.FindPlayerPos = get_npc_pos(self.target)
    lookat_npc(self.npc, self.target, false)
    cast_skill(self.npc, self.target, 2010460201, self.FindPlayerPos.x, self.FindPlayerPos.z)
  end
end

function M:on_frame()
  CommonMonster.search_target(self, 100, 8)
  self:CheckDistance()
  if self.AllowSelfDestory == true then
    self:skill_main_logic()
    self:CheckSelfDestory()
  end
  CommonMonster.monster_on_frame(self)
  CommonMonster.platform_move(self)
end

return M
