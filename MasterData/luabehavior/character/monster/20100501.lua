local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local monsterTool = import("common.monster_tool")
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
monster.tool:bornMagicToTeam(2010050123, 1, get_come_on_hero(), 1)

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
  local skills = {
    atk = {2010050101, 0}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 2010050113, 1)
  cast_magic(npc, npc, 2010050117, 1)
  cast_magic(npc, npc, 2010050112, 1)
  cast_magic(npc, npc, 30010050101, 1)
  cast_magic(npc, npc, 300100501012, 1)
  cast_magic(npc, npc, 300100501013, 1)
  set_npc_hp_visible(npc, false)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, 201005010101, monster.on_water_catch_npc, monster)
  monster.effectNum = math.random(1, 2)
  if 1 == monster.effectNum then
    cast_magic(npc, npc, 2010050120, 1)
  end
  if 2 == monster.effectNum then
    cast_magic(npc, npc, 2010050121, 1)
  end
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.atk, _ENV.stand)
  end
  
  function states.atk.finTrans(atk)
    return atk
  end
  
  function states.atk.start(atk)
    atk.base.start(atk)
  end
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201005010101 then
    monster.tool.blueWaters = monsterTool.blueWaters or {}
    missile.movetoNum = 0
    missile.drinkNum = 0
    missile.drinkDis = 2
    missile.drinkNum_Max = 1
    missile.permission = true
    monster.tool.blueWaters[missile] = missile
    monster.WaterMissle = missile
    waterpos = {
      missile,
      pos_x,
      pos_z
    }
    monster.selfcastmissileID = missile
  end
end

function monster.on_water_catch_npc(monster, owner, target_npc, missile_cfg, missile)
  if target_npc == get_come_on_hero() and owner == monster.npc and not check_magic(target_npc, 2010050111) then
    if not check_magic(target_npc, 2010050123) then
      cast_magic(monster.npc, target_npc, 2010050123, 1)
    end
    cast_magic(monster.npc, target_npc, 2010050111, 1)
    cast_magic(monster.npc, target_npc, 2010050114, 1)
    cast_magic(monster.npc, target_npc, 2010050115, 1)
  end
end

function monster.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
  monster.base.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
  if 2010050124 == magic_id then
    monster.tool.blueWaters[monster.WaterMissle].permission = false
  end
end

function monster.on_self_magic_end(monster, target, magic_id, magic_kind, magic_type, is_break)
  monster.base.on_self_magic_end(monster, target, magic_id, magic_kind, magic_type, is_break)
  if 2010050124 == magic_id then
    monster.tool.blueWaters[monster.WaterMissle].permission = true
  end
end

function monster.on_remove(monster)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, monster.npc, 201005010101, monster)
end

return monster
