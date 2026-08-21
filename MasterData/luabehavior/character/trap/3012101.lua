local M = Util.create_class()

function M:_init(npc)
  set_can_searched(npc, false)
  time_scale_immune(npc, true)
  enable_shadow(npc, true)
  switch_move_type(npc, 1)
  set_strength_visible(false)
  self.hero = get_come_on_hero()
  self.dropcount = 0
  self.maxdropcount = 6
  self.dropdone = false
  self.blockdsitance = 10
  self.X = 37
  self.Z = 115
  self.stuning = false
  self.bornpoint = {
    x = 36,
    y = 163,
    z = 111
  }
  self.onpoint = true
  self.rounding = false
  self.slowtime = false
  self.storycount = 3
  self.storyon = false
  self.storyid = 3212103
end

local function isSamePos(pos1, pos2, tollerance)
  return tollerance >= (pos1.x - pos2.x) * (pos1.x - pos2.x) + (pos1.z - pos2.z) * (pos1.z - pos2.z)
end

function M:on_frame()
  if get_sync_var("is_save") then
    self.dropcount = 0
    stop_move(self.npc)
    self.dropdone = true
    cast_skill(self.npc, self.npc, 301210101, nil, nil)
    if true ~= self.slowtime then
      cast_magic(self.npc, self.npc, 3012101014)
      self.slowtime = true
    end
  end
  if self.dropcount >= self.maxdropcount and self.dropdone == false then
    start_stroy(2212107)
    self.dropcount = 0
    self.dropdone = true
    return
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if target == self.npc then
    self.dropcount = self.dropcount + 1
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and 3012101012 == skill_id then
    self.stuning = true
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  if npc == self.npc and 3012101012 == skill_id then
    self.stuning = false
  end
end

return M
