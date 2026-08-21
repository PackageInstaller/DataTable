local M = Util.create_class()
local atime, btime

function M._init(M, npc)
  M.npc = npc
  cast_magic(get_come_on_hero(), get_come_on_hero(), 1080410201, 1, 1)
  atime = get_npc_time(get_come_on_hero())
end

function M.on_frame()
  btime = get_npc_time(get_come_on_hero())
  if btime > atime + 0.6 then
    call_scene_logic_custom_event("found")
  end
end

function M:on_target_self_magic_begin(npc, magic_id, magic_level, magic_kind, magic_type)
end

function M:on_target_self_magic_end(npc, magic_id, magic_kind, magic_type, is_break)
end

return M
