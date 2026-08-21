local M = Util.create_class()

function M:_init()
end

function M:on_start()
  self.stone_lv = get_develop_level(self.npc, 6, 666301)
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if self.npc == attacker then
    if not check_magic(npc, 6663032) then
      cast_magic(attacker, npc, 6663011, self.stone_lv)
      cast_magic(attacker, npc, 6663012, self.stone_lv)
    elseif check_magic(npc, 6663032) then
      cast_magic(attacker, npc, 6663013, self.stone_lv)
      cast_magic(attacker, npc, 6663014, self.stone_lv)
    end
  end
end

return M
