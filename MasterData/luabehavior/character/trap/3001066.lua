local M = Util.create_class()

function M:_init(npc)
  enable_shadow(npc, false)
  set_can_searched(npc, false)
  self.skill1_1 = 300106601
  self.skill1_2 = 300106602
  self.skill1_3 = 300106604
  self.magic_reduce_injury = 40104409
end

function M:after_damage(npc, target)
  if target == self.npc then
    abort_skill(self.npc)
    cast_skill(self.npc, nil, self.skill1_3)
    cast_magic(self.npc, self.npc, 399933, 0)
    self.stop_search = true
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  if npc == self.npc and 300106604 == skill_id then
    abort_skill(self.npc)
    cast_skill(self.npc, nil, 300106603)
  end
end

function M:on_frame()
  local blow_up = search_npc(self.npc, 6, 1.75, 0, 1)
  if blow_up and 5 ~= get_role_kind(blow_up) then
    self.blow = blow_up
  else
    self.blow = nil
  end
  if not self.stop_search then
    local npc = search_npc(self.npc, 6, 4, 0, 1)
    if npc and 5 ~= get_role_kind(npc) then
      self.near_npc = npc
    else
      self.near_npc = nil
    end
  end
  if not self.target and self.near_npc then
    self.target = self.near_npc
    abort_skill(self.npc)
    cast_skill(self.npc, nil, self.skill1_1)
  elseif self.target and not self.near_npc then
    abort_skill(self.npc)
    cast_skill(self.npc, nil, self.skill1_2)
    self.target = nil
  end
  if self.blow and not self.stop_search then
    self.stop_search = true
    abort_skill(self.npc)
    cast_skill(self.npc, nil, self.skill1_3)
    cast_magic(self.npc, self.npc, 399933, 0)
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
  if npc == self.npc and 1 == get_role_kind(target) then
    cast_magic(self.npc, self.npc, self.magic_reduce_injury, 1)
  end
end

return M
