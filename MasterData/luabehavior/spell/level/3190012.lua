local M = Util.create_class()

function M:_init()
  self.god = get_god_npc()
end

function M:on_start()
  if check_magic(self.god, 3190011) == true then
    abort_magic_by_id(self.god, 3190011, 1)
  end
  set_ui_object_visible("fight", "Btn_skillTower", true)
  set_ui_object_visible("fight", "Btn_skill1", true)
  set_ui_object_visible("fight", "Btn_skill7", true)
  set_ui_object_visible("fight", "Btn_skill3", true)
  set_ui_object_visible("fight", "Btn_skill4", true)
  set_ui_object_visible("fight", "Btn_skill5", true)
  set_ui_object_visible("fight", "JoystickContent", true)
end

return M
