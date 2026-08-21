local M = Util.create_class()

function M:_init()
  self.is_enhance_condition = 0
  self.bonus_set = 0
  self.now_time = 0
  self.bonus_time = 0
  self.now_magic_id = 6021012
  self.target = nil
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 12, nil, 1)
end

function M:on_frame()
  self:search_target()
  if 0 == self.is_enhance_condition and self.target then
    self.is_enhance_condition = 1
    self.bonus_set = 0
    self.now_magic_id = 6021012
    self.bonus_time = get_npc_time(self.npc)
  end
  if self.bonus_set > 3 or 0 == self.is_enhance_condition then
    return
  end
  self.now_time = get_npc_time(self.npc)
  if self.now_time - self.bonus_time - self.bonus_set * 5 > 0 then
    cast_magic(self.npc, self.npc, self.now_magic_id, 1)
    self.bonus_set = self.bonus_set + 1
    self.now_magic_id = self.now_magic_id + 1
  end
end

function M:on_room_change(npc)
  if npc == self.npc then
    self.is_enhance_condition = 0
  end
end

function M:on_hero_showup_or_back(npc, is_showup)
  if npc ~= self.npc then
    return
  end
  if true == is_showup then
    self.is_enhance_condition = 1
    self.bonus_set = 0
    self.now_magic_id = 6021012
    self.bonus_time = get_npc_time(self.npc)
  else
    self.is_enhance_condition = 0
    cast_magic(self.npc, self.npc, 6021049, 1)
  end
end

return M
