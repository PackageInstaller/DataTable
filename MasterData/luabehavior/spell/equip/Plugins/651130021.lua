local M = Util.create_class()

function M:_init()
end

function M:after_heal(npc, target, magic_id, heal_val)
  if npc == self.npc and target ~= self.npc and 1 == get_role_kind(target) then
    cast_magic(self.npc, target, 651130022, self.level)
    cast_magic(self.npc, target, 651130023, self.level)
  end
end

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 651130021)
end

return M
