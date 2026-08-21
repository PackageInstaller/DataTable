local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local ultTime = false
local CD = 0
local current_time = 0

function M:_init(npc)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= get_come_on_hero() then
    return
  end
  if act.role.npc ~= self.npc then
    return
  end
  if act:deemUlt() then
    ultTime = true
  end
end

function M:on_self_skill_hit(skill_id, hit_target, hit_type, missile_cfg, missile)
  if get_npc_time(self.npc) > rogueMgr.CD_6170624 + rogueMgr.currtime_6170624 and ultTime and self.npc == get_come_on_hero() then
    cast_missile(self.npc, self.npc, nil, nil, 61706910401)
    local level = get_ability_level(20015) or 1
    if level > 1 then
      cast_magic(self.npc, self.npc, rogueMgr.huisu)
    end
    rogueMgr.currtime_6170624 = get_npc_time(self.npc)
    rogueMgr.CD_6170624 = 15
    ultTime = false
  elseif get_come_on_hero() == self.npc and ultTime then
    ultTime = false
  end
end

function M:on_bless_timestop_catch_npc(owner, target_npc, missile_cfg, missile)
  if 1 ~= get_role_kind(target_npc) then
    cast_magic(self.npc, target_npc, 6170691001, 1)
  end
end

function M:on_bless_timestop_release_npc(owner, target_npc, missile_cfg, missile)
  if 1 ~= get_role_kind(target_npc) then
    abort_magic_by_id(target_npc, 6170691001)
  end
end

function M:on_start()
  rogueMgr.CD_6170624 = 0
  rogueMgr.currtime_6170624 = 0
  self.bless_time_stop_missile = 61706910401
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, self.bless_time_stop_missile, self.on_bless_timestop_catch_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, self.bless_time_stop_missile, self.on_bless_timestop_release_npc, self)
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, self.bless_time_stop_missile, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, self.bless_time_stop_missile, self)
end

return M
