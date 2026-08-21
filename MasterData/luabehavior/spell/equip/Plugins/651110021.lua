local M = Util.create_class()

function M:_init()
  self.hero = get_come_on_hero()
  self.kill_count = 0
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local target_kind = get_role_kind(target)
  if 2 ~= target_kind and 3 ~= target_kind and 4 ~= target_kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct:isAtkInput() and get_magic_num(self.npc, 651110022) < 3 then
    cast_magic(self.npc, self.npc, 651110022, self.level)
  end
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:isSkillInput() and check_magic(self.npc, 651110022) then
    abort_magic_by_id(self.npc, 651110022)
  end
end

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 651110021)
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

return M
