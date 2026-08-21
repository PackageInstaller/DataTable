local M = Util.create_class()
local Aten

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
end

function M:on_start()
end

function M:on_frame()
  if 1 == get_sync_var("ring_mob1") then
    set_ui_object_visible("fight", "Btn_skill6", true)
    set_skill_btn_icon(61, "UI_H1001006_exskill")
  end
  if 2 == get_sync_var("ring_mob1") and 0 == self.magic_set then
    set_ui_object_visible("fight", "Btn_skill6", false)
    cast_magic(self.npc, self.npc, 4031004, 1)
    cast_magic(self.npc, self.npc, 4031008, 1)
    self.magic_set = 1
  end
  if 3 == get_sync_var("ring_mob1") and 1 == self.magic_set then
    cast_magic(self.npc, self.npc, 4031011, 1)
    abort_magic_by_id(self.npc, 4031008)
    self.magic_set = 2
  end
  if not get_sync_var("ring_mob1") or 4 == get_sync_var("ring_mob1") then
    set_ui_object_visible("fight", "Btn_skill6", false)
    cast_magic(self.npc, self.npc, 4031010, 1)
    cast_magic(self.npc, self.npc, 4031011, 1)
    abort_magic_by_id(self.npc, 4031007, 1)
  end
end

function M:on_input(input_id)
  if 61 == input_id and 1 == get_sync_var("ring_mob1") then
    set_sync_var("ring_mob1", 2)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target ~= self.npc then
    return
  end
  if 2 == get_sync_var("ring_mob1") and 1 == self.magic_set then
    local monster_pos = get_npc_pos(self.npc)
    create_scene_effect("Fx_Common_Death", monster_pos, 10, "podun")
    cast_magic(self.npc, self.npc, 1999132, 0)
    cast_magic(self.npc, self.npc, 1999133, 0)
    cast_magic(self.npc, self.npc, 1999172, 0)
    set_sync_var("ring_mob1", 3)
  end
end

return M
