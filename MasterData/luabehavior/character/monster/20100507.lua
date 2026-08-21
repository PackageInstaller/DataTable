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
    atk = {2010050701, 0}
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
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, 201005070101, monster.on_water_catch_npc, monster)
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
  if missile_cfg.Id == 201005070101 then
    monster.tool.blueWaters = monsterTool.blueWaters or {}
    missile.movetoNum = 0
    missile.drinkNum = 0
    missile.drinkDis = 6
    missile.drinkNum_Max = 5
    monster.tool.blueWaters[missile] = missile
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

function monster.on_start(monster)
end

function monster.on_remove(monster)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, monster.npc, 201005070101, monster)
end

return monster
