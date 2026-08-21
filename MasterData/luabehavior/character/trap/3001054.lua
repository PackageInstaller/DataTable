local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.search = {}
  set_can_searched(npc, true)
  enable_shadow(npc, false)
  cast_magic(npc, npc, 399001, 1)
  local skills = {
    tuiren = {
      300105401,
      3,
      0
    },
    baozha = {
      300105402,
      3,
      0
    }
  }
  local nodes = {"die"}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  monster.hero_1 = get_scene_hero_by_poskey(21)
  monster.hero_2 = get_scene_hero_by_poskey(22)
  monster.hero_3 = get_come_on_hero()
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, 30010390101, monster.on_timestop_release_npc, monster)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, 30010540201, monster.on_suction_release_npc, monster)
  set_npc_floating_text_hud_visible(npc, false)
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.tuiren, _ENV.baozha(_ENV.die))
  end
  local states = monster.states
  
  function states.tuiren.tick(tuiren)
    if check_magic(monster.npc, 100103) and not monster.tips and not get_sync_var("close_tips") then
      if get_god_skill_level() <= 1 then
        set_scene_tips(100189, true, {})
        monster.tips = true
      else
        set_scene_tips(100190, true, {})
        monster.tips = true
      end
    elseif not check_magic(monster.npc, 100103) and monster.tips then
      set_scene_tips(100189, false, {})
      set_scene_tips(100190, false, {})
      monster.tips = false
    end
  end
  
  function states.tuiren.finTrans(tuiren)
    return tuiren
  end
  
  function states.die.isReady()
    return true
  end
  
  function states.die.start()
    set_npc_dead(monster.npc, nil, true)
    remove_npc(monster.npc)
  end
end

function monster.on_remove(monster)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, monster.npc, 30010390101, monster)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, monster.npc, 30010540201, monster)
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if 300103902 == skill_id then
    abort_skill(monster.npc, true)
    abort_magic_by_id(monster.npc, 3001056003)
    monster.tree:transState(monster.states.baozha, true)
  end
  if 300103901 == skill_id then
    abort_skill(monster.npc, true)
  end
end

function monster.on_timestop_release_npc(monster, owner, target_npc, missile_cfg, missile)
  if target_npc == monster.npc then
    monster.tree:transState(monster.states.tuiren, true)
    if get_cur_room_id() == 101105 then
      change_missile_config(30010540102, "SizeX", 1.5, 0)
    end
  end
end

function monster.on_npc_removed(monster, npc)
  if npc == monster.npc and monster.tips then
    set_scene_tips(100189, false, {})
    set_scene_tips(100190, false, {})
    monster.tips = false
  end
end

function monster.on_self_npc_hp_zero(monster)
end

function monster.on_self_enter_area(monster, npc, area)
  if area.Tag == "tp" and (npc == monster.hero_1 or npc == monster.hero_2 or npc == monster.hero_3) and monster.tips then
    set_scene_tips(100189, false, {})
    set_scene_tips(100190, false, {})
    monster.tips = true
  end
end

function monster.on_suction_release_npc(monster, owner, target_npc, missile_cfg, missile)
  if target_npc == monster.hero_1 or target_npc == monster.hero_2 or target_npc == monster.hero_3 then
    abort_magic_by_id(target_npc, 3001055001, 1)
  end
end

return monster
