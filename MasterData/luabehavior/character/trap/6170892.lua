local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local rogueMgr = import("common.rogueManager")
local cur_time = 0

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.search = {minDis = 10, maxDis = 10}
  monster.summoner = get_come_on_hero()
  monster.lifetime = 10
  monster.init_time = get_npc_time(monster.npc)
  monster.chaopin = false
  enable_shadow(npc, false)
  do
    local level_6170812 = 1
    if check_magic(monster.summoner, 6170812) then
      level_6170812 = get_ability_level(50010)
    end
    if level_6170812 > 1 then
      local COPY_ATTR_MAP = {
        [4] = 12000,
        [20] = 12000,
        [23] = 12000,
        [26] = 12000,
        [34] = 12000,
        [40] = 12000,
        [76] = 12000,
        [78] = 12000,
        [115] = 12000,
        [122] = 12000,
        [123] = 12000,
        [124] = 12000,
        [125] = 12000,
        [126] = 12000,
        [127] = 12000,
        [128] = 12000,
        [129] = 12000,
        [130] = 12000,
        [131] = 12000,
        [132] = 12000,
        [152] = 12000
      }
      copy_attr_to_npc(get_come_on_hero(), npc, COPY_ATTR_MAP)
    else
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
    end
  end
  local skills = {
    skill_1 = {
      617089201,
      1,
      0,
      0,
      10
    },
    skill_2 = {
      617089212,
      0,
      0,
      0,
      10
    },
    skill_3 = {
      617089213,
      0,
      0,
      0,
      10
    },
    skill_4 = {
      617089209,
      0,
      0,
      0,
      5
    },
    first_aid = {
      617089210,
      3,
      0,
      0,
      0
    },
    heal = {
      617089202,
      5,
      5,
      0,
      5
    }
  }
  local nodes = {"skill"}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  monster.trace_laser_magic = check_magic(monster.summoner, 6170812)
  monster.line_light_magic = check_magic(monster.summoner, 6170813)
  monster.baojin_magic = check_magic(monster.summoner, 6170821)
  monster.fisrt_aid_magic = check_magic(monster.summoner, 6170823)
  monster.heal_magic = check_magic(monster.summoner, 6170836)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.skill)
    _ENV.skill(_ENV.skill_1, _ENV.skill_2, _ENV.skill_3, _ENV.skill_4)
    _ENV.wander(_ENV.wanderStand)
  end
  
  function states.standIdle.isReady()
    return true
  end
  
  states.standIdle.time = 2
  
  function states.standIdle.finTrans()
    return standIdle.monster.states.standIdle
  end
  
  function states.wander.tickTrans(wander)
    local monster = wander.monster
    local states = monster.states
    if not monster.target then
      return states.noTarget
    end
    if states.attack then
      return monster.tree:chooseChildAction(states.attack)
    end
  end
  
  function states.active.tick(active)
    active.base.tick(active)
    if monster.heal_magic then
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
  
  function states.skill_1.isReady(skill_1)
    return skill_1.base.isReady(skill_1)
  end
  
  function states.skill_2.isReady(skill_2)
    return false
  end
  
  function states.skill_3.isReady(skill_3)
    return false
  end
  
  function states.skill_4.isReady(skill_4)
    return false
  end
  
  if get_god_npc().v_res_id == 6170891 and get_god_skill_level() >= 2 then
    function states.skill_1.isReady(skill_1)
      return false
    end
    
    function states.skill_2.isReady(skill_2)
      return skill_2.base.isReady(skill_2)
    end
  end
  if rogueMgr.add_paotai_magic then
    function states.skill_1.isReady(skill_1)
      return false
    end
    
    function states.skill_2.isReady(skill_2)
      return false
    end
    
    function states.skill_3.isReady(skill_3)
      return skill_3.base.isReady(skill_3)
    end
  end
  states.attack.interval = 0
end

function monster.on_room_change(monster, npc)
  monster.base.on_room_change(monster, npc)
  if npc == get_come_on_hero() then
    remove_npc(monster.npc)
  end
end

function monster.before_damage_target(monster, target, magic_id, damage_sign)
  if not monster.chaopin then
    return
  end
  if 3 == get_role_kind(target) or 4 == get_role_kind(target) then
    cast_magic(monster.npc, monster.npc, 617089236)
  end
end

function monster.after_damage_target(monster, target, magic_id, damage_sign, damage_type, is_crit)
  if 3 == get_role_kind(target) or 4 == get_role_kind(target) then
    rogueMgr:device_add_money(monster.summoner)
    rogueMgr:device_add_baojin(monster.npc, target)
    if rogueMgr.toughness_damage_up and check_npc_status(target, 14) then
      monster.init_time = get_npc_time(monster.npc)
    end
  end
end

function monster.on_start(monster)
  monster.base.on_start(monster)
  if rogueMgr.beam_connection_magic then
    rogueMgr:beam_connection(monster.npc)
  end
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  monster.base.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 61708921203 or missile_cfg.Id == 61708921303 or missile_cfg.Id == 61708921305 or missile_cfg.Id == 61708921306 then
    local function trace_end()
      if missile then
        change_linetype(missile, 1, {15, 0.5})
      end
    end
    
    monster:doAfter(trace_end, 1.2)
  end
end

function monster.on_target_self_magic_begin(monster, npc, magic_id, magic_level, magic_kind, magic_type)
  monster.base.on_target_self_magic_begin(monster, npc, magic_id, magic_level, magic_kind, magic_type)
  if 617080110 == magic_id then
    monster.chaopin = true
  end
  if 61708015 == magic_id then
    monster.delay_lifetime = monster.lifetime + monster.init_time - get_npc_time(monster.npc)
    monster.lifetime = 99999
  end
end

function monster.on_target_self_magic_end(monster, npc, magic_id, magic_kind, magic_type)
  monster.base.on_target_self_magic_end(monster, npc, magic_id, magic_kind)
  if 617080110 == magic_id then
    monster.chaopin = false
  end
  if 61708015 == magic_id then
    monster.init_time = get_npc_time(monster.npc)
    monster.lifetime = monster.delay_lifetime
  end
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  rogueMgr.device_kill_themselves(rogueMgr, monster)
end

return monster
