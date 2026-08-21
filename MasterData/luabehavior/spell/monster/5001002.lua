local M = Util.create_class()

function M:_init()
  set_hud_config("go_mad", {
    Prefab = "UI_Hud8",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd"
  }, 2, 3, 6)
end

function M:on_npc_born(npc)
  if npc ~= self.npc then
    return
  end
  if 3 ~= get_role_kind(npc) then
    return
  end
  local monster = self.npc:get_behavior()
  if not monster then
    Util.debug_output("monster is lost")
    return
  end
  active_hud(monster.npc, "go_mad", "effectpoint_ground", true)
  cast_magic(monster.npc, monster.npc, 500100109, 1)
  cast_magic(monster.npc, monster.npc, 500100110, 1)
end

function M:on_magic_end(npc, target, magic_id, magic_kind, magic_type, magic_type)
  if npc ~= self.npc then
    return
  end
  if 3 ~= get_role_kind(npc) then
    return
  end
  if 500100110 == magic_id then
    if get_npc_attr(self.npc, 3) < 100 then
      cast_magic(self.npc, self.npc, 500100110, 1)
    elseif 100 == get_npc_attr(self.npc, 3) then
      active_hud(self.npc, "go_mad", "effectpoint_ground", false)
      local monster = self.npc:get_behavior()
      cast_magic(monster.npc, monster.npc, 500100101, 1)
      cast_magic(monster.npc, monster.npc, 500100113, 1)
      monster:go_mad()
    end
  end
end

return M
