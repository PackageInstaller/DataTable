local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_target_self_magic_begin(npc, magic_id, magic_level, magic_kind, magic_type)
  if self.npc ~= get_come_on_hero() then
    return
  end
  local level = get_ability_level(40015) or 1
  if 1 == level then
    return
  end
  if magic_id == rogueMgr.kuangnu and get_magic_num(self.npc, 61707241) < 8 then
    cast_magic(self.npc, self.npc, 61707241)
  end
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:deemSkill() then
    local cur_hp = get_npc_attr(self.npc, 1)
    local max_hp = get_npc_attr(self.npc, 4)
    local percent = cur_hp / max_hp
    if percent >= 0.5 then
      cast_magic(self.npc, self.npc, 61707242)
      if get_magic_num(self.npc, rogueMgr.kuangnu) < 8 then
        cast_magic(self.npc, self.npc, rogueMgr.kuangnu)
      end
    end
  end
end

function M:on_start()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

return M
