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
  monster.search = {}
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  local skills = {}
  local nodes = {}
  local actMoves = {"dark", "light"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  monster.hit_count = 0
  monster.switch = true
  set_npc_floating_text_hud_visible(npc, false)
  set_sync_var("statue_count", 0)
  set_hud_config("3001077_bar", {
    Prefab = "UI_Hud4",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 2, 1, 4)
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.dark, _ENV.light)
  end
  
  function states.dark.start(dark)
    cast_magic(monster.npc, monster.npc, 399933, 1)
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 30010630301 and monster.state.name == "dark" then
    monster.hit_count = monster.hit_count + 1
    cast_magic(monster.npc, monster.npc, 300107700 + monster.hit_count, 1)
    if 1 == monster.hit_count then
      set_sync_var("Stone_state", 1)
    end
    if 3 == monster.hit_count then
      print("结晶状态二阶")
      set_sync_var("Stone_state", 2)
    end
    if 5 == monster.hit_count then
      print("结晶状态二阶")
      set_sync_var("Stone_state", 3)
    end
  end
end

function monster.on_self_npc_hp_zero(monster)
  local facePos = get_npc_offset_position(monster.npc, nil, 0, 3)
  create_scene_effect("FX_SC05_hugejingcusi_5", monster.npc:get_pos_vec3(), 2, nil, facePos)
  set_sync_var("over", true)
  set_npc_dead(monster.npc, nil, true)
  remove_npc(monster.npc)
end

function monster.on_start(monster)
  monster.base.on_start(monster)
  if 2 == monster.tool.Execution then
    active_hud(monster.npc, "3001077_bar", "HitCase", true, "完整度")
  end
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  if 0 == get_sync_var("Stone_state") and monster.switch == true then
    monster.switch = false
    active_hud(monster.npc, "3001077_bar", "HitCase", true, "完整度")
  end
  if true == monster.tool.Stone_switch then
    monster:Switch_Hud()
  end
end

function monster.Switch_Hud(monster)
  monster.tool.Stone_switch = false
  active_hud(monster.npc, "3001077_bar", "HitCase", false, "完整度")
  
  local function delay()
    active_hud(monster.npc, "3001077_bar", "HitCase", true, "完整度")
  end
  
  monster:doAfter(delay, 2)
end

return monster
