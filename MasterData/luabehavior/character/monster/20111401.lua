local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local vec3 = require("base.vec3")

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {minDis = 100, maxDis = 999}
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.hud_start = 0
  cast_magic(monster.npc, monster.npc, 201010305)
  cast_magic(monster.npc, monster.npc, 201010304)
  set_hud_config("xulibar", {
    Prefab = "UI_Hud3",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 2, 3, 6)
  monster.arrive_S2 = false
  monster.arrive_S1 = false
  monster.arrive_M16 = false
  local skills = {
    Skill01 = {
      20111401,
      3,
      1,
      0,
      3
    },
    Skill02 = {
      20111402,
      10,
      10,
      0,
      3
    },
    Skill02_notarget = {20111402},
    Skill02_notarget2 = {20111402}
  }
  local nodes = {
    "story_point"
  }
  local actMoves = {
    "move_to_S2",
    "move_to_S1",
    "move_to_M16",
    "charge",
    "move_to_item1"
  }
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.Skill01, _ENV.Skill02)
    _ENV.noTarget(_ENV.idle, _ENV.move_to_S2, _ENV.move_to_S1, _ENV.move_to_M16, _ENV.move_to_item1)
    _ENV.active(_ENV.daze, _ENV.gotTarget, _ENV.noTarget, _ENV.charge, _ENV.Skill02_notarget, _ENV.Skill02_notarget2)
  end
  local states = monster.states
  cast_magic(monster.npc, monster.npc, 20111401001)
  
  function states.idle.tickTrans(idle)
    local room = get_cur_room_id()
    if 102309 == room then
      if not monster.arrive_S2 then
        monster.tree:transState(monster.states.move_to_S2, true)
      elseif not monster.arrive_S1 then
        monster.tree:transState(monster.states.move_to_S1, true)
      else
        return
      end
    elseif 102303 == room and not monster.arrive_M16 then
      monster.tree:transState(monster.states.move_to_M16, true)
    end
  end
  
  function states.move_to_S2.start(move_to_S2)
    monster.S2_x, monster.S2_y, monster.S2_z = get_area_pos("S2")
    local S2_Pos = vec3.New(monster.S2_x, monster.S2_y, monster.S2_z)
    switch_move_type(monster.npc, 1)
    move_to_pos(monster.npc, S2_Pos)
  end
  
  function states.move_to_S2.tick(move_to_S2)
    if monster.arrive_S2 then
      return
    end
    if check_npc_distance_to_pos(monster.npc, monster.S2_x, monster.S2_z, 0.5, false) and check_npc_status(monster.npc, 0) then
      monster.arrive_S2 = true
    end
    if true == get_sync_var("S2ARRIVE") then
      if not check_npc_distance_to_pos(monster.npc, monster.S2_x, monster.S2_z, 4, false) then
        flash_to_pos(npc, monster.S2_x, monster.S2_z, monster.S2_y, true)
      end
      monster.search = {}
      monster.arrive_S2 = true
    end
  end
  
  function states.move_to_S2.tickTrans(move_to_S2)
    if get_sync_var("S2ARRIVE") == true and monster.arrive_S2 then
      return states.move_to_S1
    end
  end
  
  function states.move_to_S1.start(move_to_S1)
    monster.S1_x, monster.S1_y, monster.S1_z = get_area_pos("S1")
    local S1_Pos = vec3.New(monster.S1_x, monster.S1_y, monster.S1_z)
    switch_move_type(monster.npc, 1)
    move_to_pos(monster.npc, S1_Pos)
  end
  
  function states.move_to_S1.tick(move_to_S1)
    if monster.arrive_S1 then
      return
    end
    if check_npc_distance_to_pos(monster.npc, monster.S1_x, monster.S1_z, 1, false) and check_npc_status(monster.npc, 0) then
      monster.arrive_S1 = true
      monster.tree:transState(monster.states.Skill02_notarget, true)
    end
  end
  
  function states.move_to_M16.start(move_to_M16)
    monster.search = {}
    monster.M16_x, monster.M16_y, monster.M16_z = get_area_pos("M16")
    local M16_Pos = vec3.New(monster.M16_x, monster.M16_y, monster.M16_z)
    switch_move_type(monster.npc, 1)
    move_to_pos(monster.npc, M16_Pos)
  end
  
  function states.move_to_M16.tick(move_to_M16)
    if monster.arrive_M16 then
      return
    end
    if check_npc_distance_to_pos(monster.npc, monster.M16_x, monster.M16_z, 0.5, false) and check_npc_status(monster.npc, 0) and get_sync_var("201114_xuli") == true then
      monster.arrive_M16 = true
      monster.tree:transState(monster.states.charge, true)
    end
  end
  
  function states.Skill02_notarget.finTrans(Skill02_notarget)
    return monster.states.idle
  end
  
  function states.charge.start(charge)
    monster.search = {}
    monster:setTarget()
    monster.target = nil
    set_sync_var("201114_xuli", false)
    cast_magic(monster.npc, monster.npc, 201010304)
    active_hud(monster.npc, "xulibar", "attachpoint", true, "蓄力")
    monster.hud_start = get_npc_time(monster.npc) + 0.1
  end
  
  function states.charge.tick(charge)
    if monster.hud_start and get_npc_time(monster.npc) > monster.hud_start and get_npc_attr(monster.npc, 3) < get_npc_attr(monster.npc, 6) then
      cast_magic(monster.npc, monster.npc, 201010303)
      monster.hud_start = get_npc_time(monster.npc) + 0.1
    end
  end
  
  function states.charge.tickTrans(charge)
    if get_npc_attr(monster.npc, 3) == get_npc_attr(monster.npc, 6) and monster.hud_start > 0 then
      cast_magic(monster.npc, monster.npc, 201010304)
      active_hud(monster.npc, "xulibar", "attachpoint", false)
      set_sync_var("DOOROPEN", true)
      monster.hud_start = nil
      monster.tree:transState(monster.states.Skill02_notarget2, true)
    end
  end
  
  function states.Skill02_notarget2.finTrans(Skill02_notarget2)
    return states.move_to_item1
  end
  
  function states.move_to_item1.start(move_to_item1)
    monster.item1_x, monster.item1_y, monster.item1_z = get_area_pos("item1")
    local item1_Pos = vec3.New(monster.item1_x, monster.item1_y, monster.item1_z)
    switch_move_type(monster.npc, 1)
    move_to_pos(monster.npc, item1_Pos)
  end
end

function monster.after_damage_self(monster, npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if monster.states.charge:isRunning() == true then
    cast_magic(monster.npc, monster.npc, 201010306)
    return
  end
  monster.base.after_damage_self(monster, npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
end

return monster
