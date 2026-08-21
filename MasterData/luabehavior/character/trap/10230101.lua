local M = Util.create_class()

function M:_init(npc)
  set_can_searched(npc, false)
  self.hitWall = 0
  set_npc_floating_text_hud_visible(npc, false)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target ~= self.npc then
    return
  end
  if self.hitWall > 3 and 20111402 ~= skill_id then
    return
  end
  if 3 == self.hitWall and get_sync_var("savedSEWS") ~= true and 20111402 ~= skill_id then
    start_stroy(2021204)
    self.hitWall = self.hitWall + 1
    return
  end
  if self.hitWall <= 3 and 20111402 ~= skill_id and get_cur_room_id() == 102302 then
    self.hitWall = self.hitWall + 1
  end
  if hit_target == self.npc and 20111402 == skill_id then
    if get_cur_room_id() == 102309 then
      set_sceneobj_visible_save_state("/Root/Change_/Change_bright/Level_3/T3-TL/timeline2-3gateopen", true, false)
      start_stroy(2021402)
      set_sync_var("201114_gateTwoSwitch", false)
      remove_npc(self.npc)
    end
    if get_cur_room_id() == 102303 then
      set_sceneobj_visible_save_state("/Root/Change_/Change_bright/Level_3/T3-TL/timeline2-3gateopen2", true, false)
      start_stroy(2021404)
      set_sync_var("201114_gateTwoSwitch", false)
      remove_npc(self.npc)
    end
  end
end

return M
