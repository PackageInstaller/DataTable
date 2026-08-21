local M = Util.create_class()

function M:_init()
  self.lv_skill_count = 0
end

function M:on_start()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == get_god_npc() then
    self.lv_skill_count = self.lv_skill_count + 1
    if 0 ~= self.lv_skill_count then
      cast_magic(self.npc, self.npc, 66605401, self.lv_skill_count)
    end
  end
  if npc == get_come_on_hero() and skill_type <= 5 and skill_type >= 1 and 2 ~= skill_type then
    self.lv_skill_count = 0
    abort_magic_by_id(self.npc, 66605401, 1)
    if 0 ~= self.lv_skill_count then
      cast_magic(self.npc, self.npc, 66605401, self.lv_skill_count)
    end
  end
end

return M
