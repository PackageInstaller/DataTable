local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and get_skill_cfg(skill_id).BattleResCost > 0 then
    cast_magic(self.npc, self.npc, 4033560101, 1)
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and not is_showup then
    abort_magic_by_id(self.npc, 4033560101)
  end
end

function M:on_frame()
end

return M
