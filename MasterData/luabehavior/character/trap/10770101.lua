local CommonRole = import("common.role")
local Base = import("character.base.base_role")
local M = Util.create_class()

function M:_init(npc)
  set_can_searched(npc, false)
  time_scale_immune(npc, true)
  enable_shadow(npc, false)
  switch_move_type(npc, 1)
  set_strength_visible(false)
  self.hero = get_come_on_hero()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  self.god_npc = get_god_npc()
  self.missile = 30010630201
  self.mark = 3000001
  self.mark2 = 3000002
  self.loop = true
  self.on = true
end

function M:on_start()
  cast_magic(self.npc, self.npc, 2010050117, 1)
  cast_magic(self.npc, self.npc, 2010050113, 1)
  cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc and missile.missile_id == self.missile then
    if get_cur_room_id() == 1070202 and self.on then
      self.on = false
      if check_magic(self.npc, self.mark) then
        on_scene_object_list_pause("R3", true)
        on_scene_object_list_pause("P3", true)
      else
        on_scene_object_list_pause("P2", true)
        on_scene_object_list_pause("R2", true)
      end
    elseif get_cur_room_id() == 1070202 and self.on == false then
      self.on = true
      if check_magic(self.npc, self.mark) then
        on_scene_object_list_pause("R3", false)
        on_scene_object_list_pause("P3", false)
      else
        on_scene_object_list_pause("R2", false)
        on_scene_object_list_pause("P2", false)
      end
    end
  end
end

return M
