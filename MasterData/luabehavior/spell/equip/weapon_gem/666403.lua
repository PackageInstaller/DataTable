local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  self.hero_three = get_come_on_hero()
end

function M:on_start()
  self.stone_lv = get_develop_level(self.npc, 6, 666403)
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if self.npc == npc and not is_showup and not check_magic(self.npc, 6664032) then
    if self.hero_one ~= nil then
      cast_magic(self.hero_one, self.hero_one, 6664031, self.stone_lv)
    end
    if nil ~= self.hero_two then
      cast_magic(self.hero_two, self.hero_two, 6664031, self.stone_lv)
    end
    if nil ~= self.hero_three then
      cast_magic(self.hero_three, self.hero_three, 6664031, self.stone_lv)
    end
    cast_magic(self.npc, self.npc, 6664032, 0)
  end
end

return M
