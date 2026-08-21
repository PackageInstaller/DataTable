local M = Util.create_class()

function M:_init(npc)
  set_npc_floating_text_hud_visible(npc, false)
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  set_npc_status(npc, 1, true)
  set_npc_status(npc, 2, true)
  set_npc_status(npc, 3, true)
end

function M:on_start()
  cast_skill(self.npc, self.npc, 300107301)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 300107301 ~= skill_id then
    return
  end
  if hit_target ~= get_come_on_hero() then
    return
  end
  set_sync_var("luoshi_hit", true)
end

function M:on_frame()
  if get_sync_var("TL_luoshi_end") then
    abort_skill(self.npc)
  end
end

return M
