local monster = Util.create_class()

function monster:_init(npc)
  monster.npc = npc
  set_npc_status(monster.npc, 2, true)
  set_npc_status(monster.npc, 1, true)
  set_can_searched(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if 0 ~= hit_type then
    create_scene_effect("fx_common_monster_born", monster.npc:get_pos_vec3(), 0)
    remove_npc(monster.npc)
  end
end

return monster
