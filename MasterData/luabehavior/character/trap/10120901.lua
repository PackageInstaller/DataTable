local M = Util.create_class()
local CommonRole = import("common.role")
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function M:_init(npc)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, 30010390101, self.on_timestop_catch_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, 30010390101, self.on_timestop_release_npc, self)
end

function M:on_remove()
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, 30010390101, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, 30010390101, self)
end

function M:on_timestop_catch_npc(owner, target_npc, missile_cfg, missile)
  set_sync_var("tips1", true)
end

function M:on_timestop_release_npc(owner, target_npc, missile_cfg, missile)
  set_sync_var("tips1", false)
end

return M
