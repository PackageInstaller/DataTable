local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
  cast_magic(self.npc, self.npc, 65002705, 0)
  switch_ui_image("fight", "SpSldBg", "UIFight/new/Fight_energy_Fill5_")
  switch_ui_image("fight", "SpSldFill", "UIFight/new/Fight_energy_Fill5_")
end

function M:on_frame()
end

return M
