local M = Util.create_class()

function M:_init()
  self.npc_element = nil
end

function M:on_start()
  self.stone_lv = get_develop_level(self.npc, 6, 666402)
  cast_magic(self.npc, self.npc, 6664023, self.stone_lv)
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if target == self.npc and npc ~= self.npc then
    self.npc_element = get_active_char_element(self.npc)
    if 2 == self.npc_element and not check_magic(self.npc, 6664031) and not check_magic(self.npc, 6664024) then
      cast_magic(self.npc, npc, 66640211, self.stone_lv)
      cast_magic(self.npc, self.npc, 6664024, 0)
    elseif 2 == self.npc_element and check_magic(self.npc, 6664031) and not check_magic(self.npc, 6664024) then
      cast_magic(self.npc, npc, 66640221, self.stone_lv)
      cast_magic(self.npc, self.npc, 6664024, 0)
    end
    if 3 == self.npc_element and not check_magic(self.npc, 6664031) and not check_magic(self.npc, 6664024) then
      cast_magic(self.npc, npc, 66640212, self.stone_lv)
      cast_magic(self.npc, self.npc, 6664024, 0)
    elseif 3 == self.npc_element and check_magic(self.npc, 6664031) and not check_magic(self.npc, 6664024) then
      cast_magic(self.npc, npc, 66640222, self.stone_lv)
      cast_magic(self.npc, self.npc, 6664024, 0)
    end
    if 4 == self.npc_element and not check_magic(self.npc, 6664031) and not check_magic(self.npc, 6664024) then
      cast_magic(self.npc, npc, 66640213, self.stone_lv)
      cast_magic(self.npc, self.npc, 6664024, 0)
    elseif 4 == self.npc_element and check_magic(self.npc, 6664031) and not check_magic(self.npc, 6664024) then
      cast_magic(self.npc, npc, 66640223, self.stone_lv)
      cast_magic(self.npc, self.npc, 6664024, 0)
    end
    if 5 == self.npc_element and not check_magic(self.npc, 6664031) and not check_magic(self.npc, 6664024) then
      cast_magic(self.npc, npc, 66640214, self.stone_lv)
      cast_magic(self.npc, self.npc, 6664024, 0)
    elseif 5 == self.npc_element and check_magic(self.npc, 6664031) and not check_magic(self.npc, 6664024) then
      cast_magic(self.npc, npc, 66640224, self.stone_lv)
      cast_magic(self.npc, self.npc, 6664024, 0)
    end
    if 6 == self.npc_element and not check_magic(self.npc, 6664031) and not check_magic(self.npc, 6664024) then
      cast_magic(self.npc, npc, 66640215, self.stone_lv)
      cast_magic(self.npc, self.npc, 6664024, 0)
    elseif 6 == self.npc_element and check_magic(self.npc, 6664031) and not check_magic(self.npc, 6664024) then
      cast_magic(self.npc, npc, 66640225, self.stone_lv)
      cast_magic(self.npc, self.npc, 6664024, 0)
    end
  end
end

return M
