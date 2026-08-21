local M = Util.create_class()

function M:_init()
  self.magic_set = nil
end

function M:on_start()
  local npc_list = {
    get_come_on_hero(),
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22)
  }
  for i, npc in ipairs(npc_list) do
    if npc then
      set_ui_object_visible("fight", "Btn_skill6", false)
      set_ui_object_visible("fight", "Btn_skill3", true)
      if not check_magic(self.npc, 1001305) then
        set_ui_object_visible("fight", "Btn_skill4", true)
      end
      set_ui_object_visible("fight", "Btn_skill5", true)
      set_ui_object_visible("fight", "Btn_skill1", true)
      cast_magic(self.npc, self.npc, 399963, 1)
      cast_magic(self.npc, self.npc, 4031032, 1)
      abort_magic_by_id(npc, 4031027, 1)
    end
  end
  self.magic_set = 1
end

function M:on_frame()
  if 1 == self.magic_set then
    self.magic_set = 2
    abort_magic_by_id(self.npc, 4031028, 1)
  end
end

return M
