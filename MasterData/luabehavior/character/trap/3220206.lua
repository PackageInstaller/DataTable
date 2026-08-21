local M = Util.create_class()

function M:_init(npc)
  npc.search = {}
  enable_shadow(npc, false)
  open = 322020601
end

function M:on_npc_born(npc)
  if npc == self.npc then
    cast_skill(self.npc, nil, open)
  end
end

function M:on_self_npc_hp_zero(attacker, magic_id, missile_id, missile)
  if get_cur_room_id() == 3220201 then
    if get_sync_var("12w") == false and false == get_sync_var("34w") and false == get_sync_var("5w") then
      on_level_counter_add("1w", 0)
    elseif get_sync_var("12w") == true and false == get_sync_var("34w") and false == get_sync_var("5w") then
      on_level_counter_add("2w", 0)
    elseif get_sync_var("12w") == false and get_sync_var("34w") == true and false == get_sync_var("5w") then
      on_level_counter_add("3w", 0)
    elseif get_sync_var("12w") == true and get_sync_var("34w") == true and false == get_sync_var("5w") then
      on_level_counter_add("4w", 0)
    elseif get_sync_var("12w") == false and get_sync_var("34w") == true and get_sync_var("5w") == true then
      on_level_counter_add("5w", 0)
    end
  end
  set_npc_dead(self.npc, nil, true)
  remove_npc(self.npc)
end

function M:on_self_npc_dead()
  remove_npc(self.npc)
end

return M
