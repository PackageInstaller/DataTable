local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
end

function M:on_born_behavior()
  set_npc_hp_visible(self.npc, false)
  cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
  cast_magic(self.npc, self.npc, 20120401, 1)
  cast_magic(self.npc, self.npc, 201204012, 1)
  cast_magic(self.npc, self.npc, 201204013, 1)
  cast_magic(self.npc, self.npc, 20120312, 1)
  cast_magic(self.npc, self.npc, 300106201, 1)
  cast_magic(self.npc, self.npc, 300106202, 1)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if 300106101 == skill_id then
    abort_magic_by_id(self.npc, 300106201, 1)
    abort_magic_by_id(self.npc, 300106202, 1)
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  if 300106101 == skill_id then
    cast_magic(self.npc, self.npc, 300106201, 1)
    cast_magic(self.npc, self.npc, 300106202, 1)
  end
end

function M:on_frame()
  CommonMonster.monster_on_frame(self)
  CommonMonster.platform_move(self)
end

return M
