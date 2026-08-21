local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

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
  set_can_searched(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  enable_shadow(npc, false)
  local skills = {
    laser = {1021010301, 0},
    broken = {
      1021010303,
      0,
      0
    },
    broken_forever = {
      1021010304,
      0,
      0
    }
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  set_hud_config("10210103_bar", {
    Prefab = "UI_Hud4",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 2, 3, 6)
  cast_magic(npc, npc, 399001, 0)
  cast_magic(npc, npc, 201010302, 0)
  cast_magic(npc, npc, 201010304, 0)
  cast_magic(npc, npc, 4032905, 1)
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.laser)
    _ENV.active(_ENV.daze, _ENV.gotTarget, _ENV.noTarget, _ENV.broken, _ENV.broken_forever)
  end
  
  function states.broken.isReady()
    return false
  end
  
  function states.broken.start(broken)
    monster:setTarget()
    
    function monster.states.broken.isReady()
      return false
    end
    
    cast_magic(monster.npc, monster.npc, 201010303)
    broken.base.start(broken)
  end
  
  function states.broken.tick(broken)
    broken.base.tick(broken)
  end
  
  function states.broken.finish()
    abort_magic_by_id(monster.npc, 201010303, 99)
    active_hud(monster.npc, "10210103_bar", "Bip001 Chest", false)
  end
  
  function states.broken.finTrans(broken)
    return broken.monster.states.laser
  end
  
  function states.broken_forever.isReady()
    return false
  end
  
  function states.broken_forever.start(broken_forever)
    monster:setTarget()
    broken_forever.base.start(broken_forever)
  end
  
  function states.broken_forever.finTrans(broken_forever)
    return broken_forever
  end
  
  function states.laser.finTrans(laser)
    if monster.target then
      return laser.monster.states.laser
    else
      return laser.monster.states.noTarget
    end
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if 0 ~= hit_type and monster.state.name ~= "broken_forever" and monster.state.name ~= "broken" then
    abort_skill(monster.npc)
    cast_magic(monster.npc, monster.npc, 201010304)
    
    function monster.states.broken.isReady()
      return true
    end
    
    active_hud(monster.npc, "10210103_bar", "Bip001 Chest", true, "瘫痪")
    monster.tree:transState(monster.states.broken, true)
  end
end

function monster.on_target_self_magic_end(monster, npc, magic_id)
  if 201010303 == magic_id and is_cast_skill_time(monster.npc, 1021010303, true) then
    cast_magic(monster.npc, monster.npc, 201010303)
  end
end

function monster.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  monster.base.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  if 1021010301 == magic_id then
    abort_skill(monster.npc)
    monster.tree:transState(monster.states.broken_forever, true)
    
    function monster.states.wander.tickTrans()
      return
    end
  end
end

function monster.on_room_pass(monster, room_id)
  abort_skill(monster.npc)
  monster.tree:transState(monster.states.broken_forever, true)
  
  function monster.states.wander.tickTrans()
    return
  end
end

function monster.after_damage_self(monster, caster, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
end

function monster.on_self_npc_hp_zero(monster)
end

return monster
