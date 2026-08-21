local M = Util.create_class()

function M:_init()
end

function M:on_start()
  cast_magic(self.npc, self.npc, 7000021501)
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type)
  if 4 == damage_sign then
    cast_magic(self.npc, target, 7000021502)
    cast_magic(self.npc, target, 7000021503)
  end
end

return M
