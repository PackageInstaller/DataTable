local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:_init(npc)
end

function M:on_magic_begin(npc, target, magic_id, magic_level, magic_kind, magic_type)
  if target ~= get_come_on_hero() then
    return
  end
  if magic_id ~= rogueMgr.fragment_magic then
    return
  end
  self.fragment_num = self.fragment_num + 1
  if self.fragment_num >= 3 then
    if 1 == self.level then
      cast_magic(target, target, rogueMgr.jiaguangchen2)
      print("114514")
    else
      cast_magic(target, target, rogueMgr.jiaguangchen5)
    end
    self.fragment_num = 0
  end
  print(self.fragment_num)
end

function M:on_room_change(npc)
  self:get_level()
end

function M:on_start()
  self:get_level()
  self.fragment_num = 0
end

function M:get_level()
  self.level = get_ability_level(70015)
end

return M
