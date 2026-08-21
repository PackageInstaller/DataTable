local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local rogueMgr = import("common.rogueManager")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  if not monster.summoner then
    monster.summoner = get_come_on_hero()
  end
  if not monster.chaopin then
    monster.chaopin = false
  end
  local COPY_ATTR_MAP = {
    [4] = 10000,
    [20] = 10000,
    [23] = 10000,
    [26] = 10000,
    [34] = 10000,
    [40] = 10000,
    [76] = 10000,
    [78] = 10000,
    [115] = 10000,
    [122] = 10000,
    [123] = 10000,
    [124] = 10000,
    [125] = 10000,
    [126] = 10000,
    [127] = 10000,
    [128] = 10000,
    [129] = 10000,
    [130] = 10000,
    [131] = 10000,
    [132] = 10000,
    [152] = 10000
  }
  copy_attr_to_npc(get_come_on_hero(), npc, COPY_ATTR_MAP)
  local skills = {
    atk = {617089601, 0}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  cast_magic(npc, npc, 399001, 1)
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.atk, _ENV.stand)
  end
  local states = monster.states
  
  function states.atk.isReady()
    return true
  end
  
  function states.atk.finTrans(atk)
    return atk.monster.states.stand
  end
  
  function monster.states.stand.tickTrans(stand)
    return
  end
  
  function states.stand.tick(stand)
    if rogueMgr.heal_magic then
      local CD = 6
      if not monster.heal_timer then
        monster.heal_timer = 0
      end
      if get_npc_time(monster.npc) > monster.heal_timer + CD then
        rogueMgr.level_6170836 = rogueMgr.level_6170836 or 1
        cast_missile3(monster.npc, monster.npc, nil, nil, 61708920202, rogueMgr.level_6170836)
        monster.heal_timer = get_npc_time(monster.npc)
      end
    end
  end
end

function monster.on_self_skill_hit_A1(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 61708960101 and (2 == get_role_kind(hit_target) or 3 == get_role_kind(hit_target) or 4 == get_role_kind(hit_target)) then
    cast_missile3(monster.summoner, hit_target, nil, nil, 61708960201)
  end
end

function monster.on_missile_collide_A2(monster, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m1_cfg.Id == 61708960101 and m2_cfg.Id == 61709910101 or m2_cfg.Id == 61708960101 and m1_cfg.Id == 61709910103 then
    print("114514")
    local pos = {}
    pos = get_missile_pos(m2)
    local hero = get_come_on_hero()
    cast_missile3(hero, nil, pos.x, pos.z, 61708960202)
    cast_missile3(hero, nil, pos.x, pos.z, 61708960203)
    cast_missile3(hero, nil, pos.x, pos.z, 61708960204)
  end
end

function monster.on_self_missile_begin_pos_B1(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 61708960101 then
    local magic_list = {
      617089611,
      617089612,
      617089613,
      617089617
    }
    change_missile_config(missile_cfg.Id, "magic", magic_list, 0)
  end
end

function monster.before_damage_target_B1(monster, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if 617089617 == magic_id then
    for i = 2, 6 do
      if check_element_ab_state(target, i) then
        cast_magic(monster.npc, monster.npc, 617089618)
        change_abnormal_flag_count(target, 2, 1)
      end
    end
  end
end

function monster.before_damage_target_B2(monster, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if 617089617 == magic_id then
    for i = 2, 6 do
      if check_element_ab_state(target, i) then
        cast_magic(monster.npc, monster.npc, 617089618)
        cast_magic(monster.summoner, target, 61706251)
      end
    end
    if check_magic(target, rogueMgr.baojin) then
      cast_magic(monster.npc, monster.npc, rogueMgr.jiaguangchen10)
    end
  end
end

function monster.on_self_missile_end_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 61708960101 then
    cast_magic(monster.npc, monster.npc, 10001001)
  end
end

function monster.on_self_missile_end_pos_B2(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 61708960101 then
    cast_missile3(monster.npc, monster.npc, nil, nil, 61708960102)
  end
  if missile_cfg.Id == 61708960102 then
    cast_magic(monster.npc, monster.npc, 10001001)
  end
end

function monster.on_room_change(monster, npc)
  monster.update_fangcheng_jindu(monster)
end

function monster.on_start(monster)
  monster.base.on_start(monster)
  monster.update_fangcheng_jindu(monster)
end

function monster.update_fangcheng_jindu(monster)
  local branch_id, branch_level = get_equation_branch_info(13)
  if not branch_id then
    return
  end
  if 1301 == branch_id and 1 == branch_level then
    monster.on_self_skill_hit = monster.on_self_skill_hit_A1
  elseif 1301 == branch_id and 2 == branch_level then
    monster.on_missile_collide = monster.on_missile_collide_A2
    monster.on_self_skill_hit = monster.on_self_skill_hit_A1
  elseif 1302 == branch_id and 1 == branch_level then
    monster.on_self_missile_begin_pos = monster.on_self_missile_begin_pos_B1
    monster.before_damage_target = monster.before_damage_target_B1
  elseif 1302 == branch_id and 2 == branch_level then
    monster.on_self_missile_begin_pos = monster.on_self_missile_begin_pos_B1
    monster.before_damage_target = monster.before_damage_target_B2
    monster.on_self_missile_end_pos = monster.on_self_missile_end_pos_B2
  end
end

return monster
