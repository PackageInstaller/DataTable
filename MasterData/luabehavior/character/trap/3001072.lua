local M = Util.create_class()

function M:_init(npc)
  set_npc_floating_text_hud_visible(npc, false)
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  self.skillCD = 2
  self.skillTimer = self.skillCD
  set_npc_status(npc, 1, true)
  set_npc_status(npc, 2, true)
  set_npc_status(npc, 3, true)
end

function M:on_frame()
  if get_sync_var("StopFallenStone") then
    return
  end
  if get_npc_time(self.npc) < self.skillTimer then
    return
  end
  self.skillTimer = get_npc_time(self.npc) + 0.1 * math.random(5, 10 * self.skillCD)
  local hero = get_come_on_hero()
  local src_pos = get_npc_pos(hero)
  local tar_pos = get_npc_pos(hero)
  local pos
  local isWalkablePos = false
  local loopTime = 0
  while not isWalkablePos do
    loopTime = loopTime + 1
    if loopTime > 20 then
      return
    end
    tar_pos.x = tar_pos.x + 0.1 * math.random(-50, 50)
    tar_pos.z = tar_pos.z + 0.1 * math.random(-50, 50)
    isWalkablePos, pos = get_nearest_walkable_pos(src_pos, tar_pos, 0.3, 3)
  end
  self.skillType = math.random(1, 3)
  if 1 == self.skillType then
    cast_missile(self.npc, nil, pos.x, pos.z, 30010720101, 0, pos.x, pos.z, pos.y, pos.y, pos.x, pos.z, pos.y)
    cast_missile(self.npc, nil, pos.x, pos.z, 30010720102, 0, pos.x, pos.z, pos.y, pos.y, pos.x, pos.z, pos.y)
    cast_missile(self.npc, nil, pos.x, pos.z, 30010720103, 0, pos.x, pos.z, pos.y, pos.y, pos.x, pos.z, pos.y)
  end
  if 2 == self.skillType then
    cast_missile(self.npc, nil, pos.x, pos.z, 30010720201, 0, pos.x, pos.z, pos.y, pos.y, pos.x, pos.z, pos.y)
    cast_missile(self.npc, nil, pos.x, pos.z, 30010720202, 0, pos.x, pos.z, pos.y, pos.y, pos.x, pos.z, pos.y)
    cast_missile(self.npc, nil, pos.x, pos.z, 30010720203, 0, pos.x, pos.z, pos.y, pos.y, pos.x, pos.z, pos.y)
  end
  if 3 == self.skillType then
    cast_missile(self.npc, nil, pos.x, pos.z, 30010720301, 0, pos.x, pos.z, pos.y, pos.y, pos.x, pos.z, pos.y)
    cast_missile(self.npc, nil, pos.x, pos.z, 30010720302, 0, pos.x, pos.z, pos.y, pos.y, pos.x, pos.z, pos.y)
    cast_missile(self.npc, nil, pos.x, pos.z, 30010720303, 0, pos.x, pos.z, pos.y, pos.y, pos.x, pos.z, pos.y)
  end
  cast_magic(self.npc, self.npc, 3001072001)
end

return M
