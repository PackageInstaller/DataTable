local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {}
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  set_can_searched(npc, false)
  cast_magic(npc, npc, 4032905, 1)
  local skills = {
    atk = {319000401, 0},
    check = {319000403, 0},
    shouqi = {319000402, 0}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  monster.zhankai = false
  monster.atk = false
  monster.can_be_hit = false
  set_hud_config("3190004_bar", {
    Prefab = "UI_Hud4",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd"
  }, 2, 3, 6)
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 201010302, 0)
  cast_magic(npc, npc, 201010304, 0)
  set_npc_floating_text_hud_visible(npc, false)
  do
    local _ENV = monster.states
    _ENV.active(_ENV.shouqi, _ENV.stand, _ENV.check, _ENV.atk)
  end
  local states = monster.states
  
  function states.shouqi.finTrans(shouqi)
    return shouqi.monster.states.stand
  end
  
  function states.stand.start(stand)
    local npc = stand.monster.npc
    stop_move(npc)
  end
  
  function states.stand.finTrans(stand)
    return stand
  end
  
  function states.check.finTrans(check)
    monster.zhankai = true
    return check.monster.states.stand
  end
  
  function states.atk.finTrans(atk)
    return atk.monster.states.stand
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if monster.zhankai == false then
    if false == monster.can_be_hit then
      monster.tree:transState(monster.states.check)
      monster.can_be_hit = true
      if get_cur_room_id() == 3190402 and false == get_sync_var("jiguan_trans") then
        set_sync_var("jiguan_trans", true)
      end
    end
  elseif false == monster.atk then
    monster.tree:transState(monster.states.atk)
    monster.atk = true
    cast_magic(monster.npc, monster.npc, 201010304)
    cast_magic(monster.npc, monster.npc, 201010303)
    active_hud(monster.npc, "3190004_bar", "attachpoint", true, "装填")
    monster.hud_start = get_npc_time(monster.npc) + 0.1
    if get_cur_room_id() == 3190402 and false == get_sync_var("jiguan_fire") then
      set_sync_var("jiguan_fire", true)
    end
  end
end

function monster.on_target_self_magic_end(monster, npc, magic_id)
  if 201010303 == magic_id then
    if get_npc_attr(monster.npc, 3) < 100 then
      cast_magic(monster.npc, monster.npc, 201010303)
      monster.hud_start = get_npc_time(monster.npc) + 0.1
    else
      monster.atk = false
      active_hud(monster.npc, "3190004_bar", "attachpoint", false)
      monster.hud_start = nil
    end
  end
end

function monster.on_target_self_magic_begin(monster, npc, magic_id, is_self, magic_level)
  if 3000001 == magic_id and monster.zhankai == false then
    monster.tree:transState(monster.states.check)
  end
end

function monster.on_self_npc_hp_zero(monster)
end

return monster
