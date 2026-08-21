local M = Util.create_class()

function M:_init(magic_list, effect_time)
  self:add_magic(magic_list, effect_time)
end

function M:on_destroy()
  self:clear_magic()
end

function M:add_magic(magic_id, effect_time)
  self.magic_list = self.magic_list or {}
  self.magic_effect_time_map = self.magic_effect_time_map or {}
  self.magic_effect_time_map[magic_id] = effect_time or 1
  self.magic_list[#self.magic_list + 1] = magic_id
end

function M:remove_magic(magic_id)
  self.magic_effect_time_map[magic_id] = nil
  local remain_count = UtilTable.list_delete_by_value(self.magic_list, magic_id)
  if remain_count <= 0 then
    FightDataMgr:release_sub_magic_list(magic_id)
  end
end

function M:clear_magic()
  local len = #self.magic_list
  for i = 1, len do
    self.magic_list[i] = nil
  end
end

function M:on_use_magic(magic_id)
  if self.magic_effect_time_map[magic_id] < 0 then
    return
  end
  self.magic_effect_time_map[magic_id] = self.magic_effect_time_map[magic_id] - 1
  if self.magic_effect_time_map[magic_id] <= 0 then
    FightDataMgr:add_invalid_magic(magic_id)
    self.magic_effect_time_map[magic_id] = nil
  end
end

function M:get_magic_count()
  return self.magic_list and #self.magic_list or 0
end

return M
