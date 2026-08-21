local M = Util.create_class()
local tool = import("common.tool")
local kuangnu = 61707311

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local curr_energy = get_npc_attr(self.npc, 2)
  local max_energy = get_npc_attr(self.npc, 5)
  if max_energy - curr_energy <= 1 and not check_magic(self.npc, 61707371) then
    cast_magic(self.npc, self.npc, 61707371)
    local level = get_ability_level(40023) or 1
    if level > 1 then
      cast_magic(self.npc, self.npc, 61707373)
    end
  end
end

function M:_init(npc)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:deemAtk() then
    cast_magic(self.npc, self.npc, 61707372)
    self.is_pugong = true
  end
end

function M:on_start()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break, behavior_abort)
  if npc ~= self.npc then
    return
  end
  if self.is_pugong then
    abort_magic_by_id(self.npc, 61707372)
    self.is_pugong = false
  end
end

return M
