local CommonRole = import("common.role")
local M = Util.create_class()

function M:_init(npc)
  self.is_boom = true
  self.hero = get_come_on_hero()
  self.hero2 = get_scene_hero_by_poskey(21)
  self.hero3 = get_scene_hero_by_poskey(22)
end

function M:on_start()
  if not check_magic(self.npc, 6070080) then
    cast_magic(self.npc, self.npc, 6070080, 1)
    switch_ui_image("fight", "SpSldBg", "UIFight/new/Fight_energy_Fill4_")
    switch_ui_image("fight", "SpSldFill", "UIFight/new/Fight_energy_Fill4_")
  end
end

function M:logic(now_hp)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if 3 == m1_cfg.MissileTypeTag and m1_owner == self.npc and m2_owner ~= self.npc and not check_magic(m1_owner, 1999125) and not check_magic(m1_owner, 1999126) and not check_magic(m1_owner, 6070081) then
    cast_magic(m1_owner, m1_owner, 6070081, 1)
  end
end

function M:on_frame()
  self:logic()
end

function M:disenagement_from_battle()
  if not is_in_challenge() then
    self.blood = 0
  end
  if is_pass_room() then
    self.blood = 0
  end
end

return M
