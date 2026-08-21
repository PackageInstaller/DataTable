local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  set_npc_status(npc, 1, true)
  set_npc_status(npc, 2, true)
  set_npc_status(npc, 3, true)
  set_can_searched(npc, false)
  time_scale_immune(npc, true)
  enable_shadow(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 4032905, 1)
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 40321891, 1)
  cast_magic(npc, npc, 2010050117, 1)
  cast_magic(npc, npc, 2010050113, 1)
  npc.search = {}
  monster.finish = false
  monster.OrbFX = {
    [30010840201] = true,
    [30010840203] = true,
    [30010840204] = true,
    [30010840205] = false,
    [30010840206] = true,
    [30010840207] = true,
    [30010840208] = true,
    [30010840209] = true,
    [30010840210] = true
  }
  monster.SelfOrbFX = {
    [30010840201] = 30010860301,
    [30010840203] = 30010860302,
    [30010840204] = 30010860303,
    [30010840205] = 30010860304,
    [30010840206] = 30010860305,
    [30010840207] = 30010860306,
    [30010840208] = 30010860307,
    [30010840209] = 30010860308,
    [30010840210] = 30010860309
  }
  monster.Current_FxOrb_id = 30010860301
  monster.selfDestoryTimer = 0
  monster.CompleteFX_id = 30010860201
  local skills = {
    open = {300108601, 0},
    Complete = {300108602, 0}
  }
  local nodes = {}
  local actMoves = {}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  do
    local _ENV = monster.states
    _ENV.active(_ENV.open, _ENV.Complete)
  end
  local states = monster.states
  
  function states.Complete.start(Complete)
    Complete.base.start(Complete)
    Complete.monster.selfDestoryTimer = os.time()
    cast_magic(Complete.monster.npc, Complete.monster.npc, 300108601, 1)
  end
  
  function states.Complete.tick(Complete)
    Complete.base.tick(Complete)
    if os.time() >= Complete.monster.selfDestoryTimer + 2 then
      remove_missile_by_id(monster.CompleteFX_id, monster.npc, false)
      remove_missile_by_id(monster.Current_FxOrb_id, monster.npc, false)
      
      local function remove()
        remove_npc(Complete.monster.npc)
      end
      
      monster:doAfter(remove, 0.5)
    end
  end
end

function monster.OrbHit(monster, missile_cfg)
  if monster.OrbFX[missile_cfg.Id] ~= nil and monster.finish == false then
    if nil ~= get_sync_var("youxu") then
      if missile_cfg.Id == 30010840204 and get_npc_id(monster.npc) == 30010862 then
        monster.tree:transState(monster.states.Complete)
        local spawnPos = get_npc_pos(monster.npc)
        monster.Current_FxOrb_id = monster.SelfOrbFX[missile_cfg.Id]
        cast_missile_new(monster.npc, monster.npc, spawnPos.x, spawnPos.z, monster.Current_FxOrb_id, 1, nil, nil, nil, nil)
        monster.finish = true
        call_scene_logic_custom_event("30010862Complete")
      elseif missile_cfg.Id == 30010840205 and get_npc_id(monster.npc) == 30010861 then
        monster.tree:transState(monster.states.Complete)
        local spawnPos = get_npc_pos(monster.npc)
        monster.Current_FxOrb_id = monster.SelfOrbFX[missile_cfg.Id]
        cast_missile_new(monster.npc, monster.npc, spawnPos.x, spawnPos.z, monster.Current_FxOrb_id, 1, nil, nil, nil, nil)
        monster.finish = true
        call_scene_logic_custom_event("30010861Complete")
      elseif get_npc_id(monster.npc) == 30010862 then
        call_scene_logic_custom_event("SunWrong")
      end
      call_scene_logic_custom_event("ObjComplete" .. get_npc_id(monster.npc))
    else
      monster.tree:transState(monster.states.Complete)
      local spawnPos = get_npc_pos(monster.npc)
      monster.Current_FxOrb_id = monster.SelfOrbFX[missile_cfg.Id]
      cast_missile_new(monster.npc, monster.npc, spawnPos.x, spawnPos.z, monster.Current_FxOrb_id, 1, nil, nil, nil, nil)
      monster.finish = true
      if nil ~= get_sync_var("shunxukaiqi") then
        call_scene_logic_custom_event("ObjComplete" .. get_npc_id(monster.npc))
        set_sync_var("dangqianwancheng", get_sync_var("dangqianwancheng") + 1)
        call_scene_logic_custom_event("Finish" .. string.format("%u", tostring(get_sync_var("dangqianwancheng"))))
        if get_sync_var("dangqianwancheng") >= get_sync_var("shunxukaiqi") and nil == get_sync_var("Complete") then
          set_sync_var("3001086Complete", true)
        end
      else
        set_sync_var("3001086Complete", true)
      end
    end
  end
end

return monster
