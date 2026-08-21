local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local timer_magic = 61706132
local speed_up_magic = {
  [1] = 61706131,
  [2] = 61706133,
  [3] = 61706134,
  [4] = 61706135,
  [5] = 61706136,
  [6] = 61706137
}
local cd = 0.5

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct:isAtk() and check_magic(self.npc, timer_magic) then
    local timer_magic_num = get_magic_num(self.npc, timer_magic)
    if 6 == timer_magic_num and get_npc_time(self.npc) > self.curr_time_atk + cd then
      local level = get_ability_level(20010) or 1
      if 1 ~= level then
        cast_magic(self.npc, self.npc, rogueMgr.weilai)
      end
      cast_magic(self.npc, self.npc, rogueMgr.weilai)
      self.curr_time_atk = get_npc_time(self.npc)
    end
  end
  if skAct and skAct:isSkill() and get_npc_time(self.npc) > self.curr_time_skill + cd then
    cast_magic(self.npc, self.npc, timer_magic)
    self.curr_time_skill = get_npc_time(self.npc)
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break, behavior_abort)
  if npc ~= self.npc then
    return
  end
  if self.isAtk == true then
    self.isAtk = false
    abort_magic_by_id(self.npc, 61706131)
    abort_magic_by_id(self.npc, 61706133)
    abort_magic_by_id(self.npc, 61706134)
    abort_magic_by_id(self.npc, 61706135)
    abort_magic_by_id(self.npc, 61706136)
    abort_magic_by_id(self.npc, 61706137)
  end
end

function M:on_start()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
  self.curr_time_atk = 0
  self.curr_time_skill = 0
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:isAtk() then
    self.isAtk = true
  end
  local timer_magic_num = get_magic_num(self.npc, timer_magic)
  if speed_up_magic[timer_magic_num] then
    cast_magic(self.npc, self.npc, speed_up_magic[timer_magic_num], 1)
  end
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

function M:_init(npc)
end

return M
