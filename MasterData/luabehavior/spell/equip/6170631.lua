local M = Util.create_class()
local tool = import("common.tool")
local time_sphere = get_god_npc()
local current_time
local timer = 11.5
local rogueMgr = import("common.rogueManager")

function M:on_self_magic_begin(target, magic_id, magic_level, magic_kind, magic_type)
  if magic_id == rogueMgr.huisu and not check_magic(self.npc, 61706311) then
    current_time = get_npc_time(self.npc)
    cast_magic(self.npc, self.npc, 61706311, 1)
  end
end

function M:on_self_magic_end(target, magic_id, magic_kind, magic_type, is_break)
  if 61706311 == magic_id and current_time + timer < get_npc_time(self.npc) then
    cast_magic(time_sphere, time_sphere, 61706312, 1)
    cast_magic(time_sphere, time_sphere, 61706313, 1)
    cast_magic(time_sphere, time_sphere, 61706314, 1)
    if check_magic(self.npc, rogueMgr.huisu) then
      cast_magic(self.npc, self.npc, 61706311, 1)
      current_time = get_npc_time(self.npc)
    end
  end
end

function M:on_frame()
  if not check_magic(self.npc, rogueMgr.huisu) and check_magic(self.npc, 61706311) then
    abort_magic_by_id(self.npc, 61706311, 1)
  end
end

function M:on_frame_background()
  if not check_magic(self.npc, rogueMgr.huisu) and check_magic(self.npc, 61706311) then
    abort_magic_by_id(self.npc, 61706311, 1)
  end
end

function M:on_start()
end

function M:_init(npc)
end

return M
