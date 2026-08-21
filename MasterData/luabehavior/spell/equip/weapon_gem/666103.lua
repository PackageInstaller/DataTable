local M = Util.create_class()

function M:_init()
end

function M:on_start()
  self.stone_lv = get_develop_level(self.npc, 6, 666103)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and 1 == skill_type then
    cast_magic(npc, npc, 6661031, self.stone_lv)
  end
end

return M
