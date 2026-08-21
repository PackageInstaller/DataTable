local monster = Util.create_class()

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {}
  set_can_searched(monster.npc, false)
  set_can_searched(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  enable_shadow(npc, false)
  cast_magic(npc, npc, 399931, 1)
  cast_magic(npc, npc, 399932, 1)
  cast_magic(npc, npc, 399001, 1)
  cast_missile_new(monster.npc, monster.npc, nil, nil, 30020560101, 1)
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 1 == get_role_kind(hit_target) and missile_cfg.Id == 30020560101 then
    if get_npc_id(monster.npc) == 3002056 then
      cast_magic(get_come_on_hero(), get_come_on_hero(), 300205601, 1, 100)
    end
    if get_npc_id(monster.npc) == 3002057 then
      cast_missile_new(get_come_on_hero(), get_come_on_hero(), nil, nil, 30020570101, 1)
      cast_magic(get_come_on_hero(), get_come_on_hero(), 300205702, 1, 70)
    end
    if get_npc_id(monster.npc) == 3002067 then
      cast_magic(get_come_on_hero(), get_come_on_hero(), 300206101, 1, 1)
    end
    if get_npc_id(monster.npc) == 3002068 then
      cast_magic(get_come_on_hero(), get_come_on_hero(), 300206102, 1, 5)
    end
    remove_npc(monster.npc)
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if attacker == get_come_on_hero() and missile_cfg.Id ~= 30020570101 then
    if get_npc_id(monster.npc) == 3002056 then
      cast_magic(get_come_on_hero(), get_come_on_hero(), 300205601, 1, 100)
    end
    if get_npc_id(monster.npc) == 3002057 then
      cast_missile_new(get_come_on_hero(), get_come_on_hero(), nil, nil, 30020570101, 1)
      cast_magic(get_come_on_hero(), get_come_on_hero(), 300205702, 1, 70)
    end
    if get_npc_id(monster.npc) == 3002067 then
      cast_magic(get_come_on_hero(), get_come_on_hero(), 300206101, 1, 1)
    end
    if get_npc_id(monster.npc) == 3002068 then
      cast_magic(get_come_on_hero(), get_come_on_hero(), 300206102, 1, 5)
    end
    remove_npc(monster.npc)
    remove_missile_by_id(30020560101, monster.npc)
    remove_npc(monster.npc)
  end
end

function monster.on_self_npc_hp_zero(monster)
end

return monster
