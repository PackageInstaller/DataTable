local M = Util.create_class()

function M:_init()
end

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 651110051)
  listen_attr_change_mq(self.npc, 1, self.on_hp_change, self)
end

function M:on_hp_change(npc, attr_type, change_value)
  if npc ~= self.npc then
    return
  end
  if change_value < 0 then
    cast_magic(self.npc, self.npc, 651110052, self.level)
  end
end

function M:on_remove()
  unlisten_attr_change_mq(self.npc, 1, self)
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc then
    abort_magic_by_id(self.npc, 651110052)
  end
end

return M
