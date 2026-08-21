local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.Skill01 = {
    20120301,
    8,
    0,
    1.5,
    3,
    get_skill_cfg(20120301).CastTime,
    get_skill_cfg(20120301).AfterTime
  }
  self.AllowCastSkill = true
  cast_magic(npc, npc, 399928, 1)
  npc.search = {}
end

function M:on_born_behavior()
  if get_sync_var("qian_night") ~= true then
    set_can_searched(self.npc, false)
    cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
  else
    abort_magic_by_id(self.npc, 399928, 0)
  end
  set_npc_hp_visible(self.npc, false)
end

function M:skill_main_logic()
  if self.AllowCastSkill == true then
    self.AllowCastSkill = false
    cast_skill(self.npc, self.target, 20120301)
  end
end

function M:on_frame()
  if get_sync_var("qian_night") then
    local npc = search_npc(self.npc, 4, 2, 0, 1)
    if npc and npc == get_come_on_hero() and not self.near_hero and get_target_angel(npc, self.npc, false) < 50 then
      self.near_hero = npc
      create_scene_effect("Fx_jingcu_warning_7m", self.npc:get_pos_vec3(), 2, "2")
      set_scene_tips(104401, true, {})
      abort_magic_by_id(self.npc, 399928, 0)
    elseif (not npc or get_target_angel(npc, self.npc, false) >= 50) and self.near_hero then
      self.near_hero = nil
      remove_scene_effect("2")
    end
  end
  self:skill_main_logic()
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    set_scene_npc_status(self.npc, 1)
  end
  if npc == self.npc then
    local near_npc = search_npc(self.npc, 6, 7, nil, false, true)
    if near_npc then
      for _, v in pairs(near_npc) do
        cast_magic(self.npc, v, 40104404, 0)
      end
    end
    if get_sync_var("qian_night") or get_sync_var("qian_dark") then
      create_scene_effect("Fx_jingcu_break_sound_7m", npc:get_pos_vec3(), 2)
      remove_scene_effect("2")
    end
    create_scene_effect("FX_SC05_jingcusi_2", npc:get_pos_vec3(), 2)
    set_npc_dead(self.npc, nil, true)
    remove_npc(self.npc)
  end
end

return M
