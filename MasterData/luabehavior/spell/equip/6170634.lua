local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local is_init = false

function M.onPerfectDash(role)
  if get_magic_num(role.npc, rogueMgr.weilai) < 8 then
    local level = get_ability_level(20020) or 1
    if level > 1 then
      for i = 1, 2 do
        cast_magic(role.npc, role.npc, rogueMgr.weilai)
      end
    else
      for i = 1, 1 do
        cast_magic(role.npc, role.npc, rogueMgr.weilai)
      end
    end
  end
end

function M:listen_perfect_dash()
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  tool.insert(role, "onPdashSlomo", self.onPerfectDash)
end

function M:on_fate_book_battle_start()
  self.level = get_ability_level(20020) or 1
  if self.level > 1 then
    self.layer = 2
  else
    self.layer = 1
  end
  if not is_init then
    self:listen_perfect_dash()
    listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
    is_init = true
  end
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  tool.remove(role, "onPdashSlomo", self.onPerfectDash)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:isCounter() then
    for i = 1, self.layer do
      cast_magic(self.npc, self.npc, rogueMgr.weilai)
    end
  end
end

function M:on_room_change(npc)
  self.level = get_ability_level(20020) or 1
  if self.level > 1 then
    self.layer = 2
  else
    self.layer = 1
  end
end

function M:_init(npc)
end

return M
