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
  monster.Selfpos = get_npc_pos(monster.npc)
  monster.permission = false
  monster.is_player_near = false
  monster.is_hit = false
  enable_shadow(npc, false)
  local skills = {}
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  local pos = get_npc_pos(monster.npc)
  cast_magic(npc, npc, 399001, 1)
  set_npc_floating_text_hud_visible(npc, false)
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.stand)
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if 0 == hit_type then
    return
  end
  if monster.is_hit then
    return
  end
  monster.is_hit = true
  local facePos = get_npc_offset_position(monster.npc, nil, 0, 3)
  if get_npc_id(monster.npc) == 30010200 then
    create_scene_effect("FX_SC05_jingcusi_1", monster.pos, 2, nil, facePos)
  end
  if get_npc_id(monster.npc) == 30010201 then
    create_scene_effect("FX_SC05_jingcusi_2", monster.pos, 2, nil, facePos)
  end
  if get_npc_id(monster.npc) == 30010202 then
    create_scene_effect("FX_SC05_jingcusi_3", monster.pos, 2, nil, facePos)
  end
  if get_npc_id(monster.npc) == 30010203 then
    create_scene_effect("FX_SC05_jingcusi_4", monster.pos, 2, nil, facePos)
  end
  if get_npc_id(monster.npc) == 30010204 then
    create_scene_effect("FX_SC05_jingcusi_5", monster.pos, 2, nil, facePos)
  end
  if get_cur_room_id() == 4011 then
    add_task_progress(401101, 1)
    add_task_progress(401102, 1)
    add_task_progress(401103, 1)
  end
  if get_cur_room_id() == 4012 then
    add_task_progress(401201, 1)
    add_task_progress(401202, 1)
    add_task_progress(401203, 1)
  end
  if get_cur_room_id() == 4013 then
    add_task_progress(401301, 1)
    add_task_progress(401302, 1)
    add_task_progress(401303, 1)
  end
  if get_cur_room_id() == 4041 or get_cur_room_id() == 4042 or get_cur_room_id() == 4043 then
    add_task_progress(404101, -1)
    add_task_progress(404102, -1)
    add_task_progress(404103, -1)
  end
  cast_missile3(monster.npc, monster.npc, nil, nil, 30010220102, 1)
  if get_sync_var("qian_night") then
    create_scene_effect("Fx_jingcu_break_sound_7m", monster.npc:get_pos_vec3(), 2)
    remove_missile_by_id(30010192101, monster.npc, true)
  end
  
  local function delay()
    remove_npc(monster.npc)
  end
  
  monster:doAfter(delay, 0.2)
end

function monster.on_jingcu_catch_npc(monster, owner, target_npc, missile_cfg, missile)
  if monster.npc == owner and 1 == get_role_kind(target_npc) then
    monster.is_player_near = true
  end
end

function monster.on_jingcu_release_npc(monster, owner, target_npc, missile_cfg, missile)
  if monster.npc == owner and 1 == get_role_kind(target_npc) then
    monster.is_player_near = false
  end
end

function monster.on_start(monster)
  monster.base.on_start(monster)
  if get_sync_var("qian_night") then
    set_can_searched(monster.npc, true)
    monster.pos = get_npc_pos(monster.npc)
    cast_missile3(monster.npc, nil, nil, nil, 30010192101, 1)
    listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, monster.npc, 30010192101, monster.on_jingcu_release_npc, monster)
    listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, monster.npc, 30010192101, monster.on_jingcu_catch_npc, monster)
  else
    set_can_searched(monster.npc, false)
  end
end

function monster.on_npc_dead(monster, npc)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, monster.npc, 30010192101, monster)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, monster.npc, 30010192101, monster)
  remove_missile_by_id(30010192101, monster.npc, true)
  remove_scene_effect(tostring(monster))
end

function monster.on_remove(monster)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, monster.npc, 30010192101, monster)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, monster.npc, 30010192101, monster)
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  if get_sync_var("qian_night") then
    local npc = get_come_on_hero()
    if monster.is_player_near and get_target_angel(npc, monster.npc, false) < 50 and not monster.has_set_effect then
      monster.has_set_effect = true
      create_scene_effect("Fx_jingcu_warning_loop_7m", monster.pos, 9999, tostring(monster))
    elseif (not monster.is_player_near or get_target_angel(npc, monster.npc, false) >= 50) and monster.has_set_effect then
      monster.has_set_effect = false
      remove_scene_effect(tostring(monster))
    end
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  if missile_cfg.Id == 30010220102 then
    local npc = hit_target:get_behavior()
    npc.crystal = {
      Selfpos = get_npc_pos(monster.npc),
      permission = true
    }
  end
end

function monster.on_self_npc_hp_zero(monster)
end

return monster
