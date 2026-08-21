local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.time = 0
  self.control = 0
  self.nums = 0
  self.camera_change_timer = get_time() + 0.65
  self.camera_change = false
  cast_magic(npc, npc, 1999042, 0)
  if not check_magic(npc, 1999006) then
    self.camera_change = true
    cast_magic(npc, npc, Const.MONSTER_BE_HIT.SLOMO_SELF, 0)
    cast_magic(npc, npc, Const.MONSTER_BE_HIT.CAM_SHAKE, 0)
    cast_missile(npc, npc, nil, nil, 10019900304, 0)
  end
end

function M:creat_magic()
  if 0 == self.control then
    if check_magic(self.target, 6054006) then
      cast_magic(self.npc, self.npc, 60540061, 1)
      self.control = 1
    else
      cast_magic(self.npc, self.npc, 1999041, 1)
      self.control = 1
    end
  end
end

function M:on_frame()
  CommonMonster.search_target(self, 30, 8)
  if check_npc_die(self.npc) then
    return
  end
  self:creat_magic()
end

function M:on_npc_hp_zero(npc)
end

return M
