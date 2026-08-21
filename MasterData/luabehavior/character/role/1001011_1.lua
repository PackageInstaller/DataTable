local CommonRole = import("common.role")
local Base = import("character.base.base_role")
local M = Util.create_child_mt(Base)
local skill_abort_level = 0
local atk_soul_missile = {
  [1] = 10010110801,
  [2] = 10010110802,
  [3] = 10010110803,
  [4] = 10010110804,
  [5] = 10010110805
}
local atk_soul_magic = {
  [1] = 101196,
  [2] = 101195
}

function M:_init(npc)
  Base._init(self, npc)
  CommonRole.role_common_init(self)
  self.soul_monster = nil
  self.soul_monster_pos = nil
  self.soul_break_missile = nil
  self.ranged_atk = {
    [1] = 100101105,
    [2] = 100101106,
    [3] = 100101107
  }
end

function M:npc_show(staty)
  set_npc_hp_visible(self.npc, staty)
  enable_shadow(self.npc, staty)
end

function M:on_start()
  self.soul_monster = search_npc(self.npc, 4, 100, atk_soul_magic[2], 1)
  if self.soul_monster then
    lookat_npc(self.npc, self.soul_monster)
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
end

function M:on_magic_begin(npc, target, magic_id)
end

function M:on_frame()
  if self.soul_monster then
    lookat_npc(self.npc, self.soul_monster, false)
  end
end

return M
