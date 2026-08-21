local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local shield_missile = 61708910101
local fangcheng_jindu = 0

function M:_init(npc)
end

function M:on_start()
  self.curr_time = get_npc_time(self.npc)
  self.CD = 0
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == get_god_npc() and get_npc_time(self.npc) > self.curr_time + self.CD then
    cast_missile3(self.npc, self.npc, nil, nil, shield_missile)
    self.curr_time = get_npc_time(self.npc)
    self.CD = 15
  end
end

return M
