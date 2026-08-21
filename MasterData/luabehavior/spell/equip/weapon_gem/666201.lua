local M = Util.create_class()

function M:_init()
end

function M:on_start()
  self.stone_lv = get_develop_level(self.npc, 6, 666201)
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  if 5 == damage_sign then
    if not check_magic(target, 6662031) then
      cast_magic(npc, target, 6662011, self.stone_lv)
    elseif check_magic(target, 6662031) then
      cast_magic(npc, target, 6662012, self.stone_lv)
    end
  end
end

return M
