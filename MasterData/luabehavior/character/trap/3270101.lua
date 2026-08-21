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
  set_npc_floating_text_hud_visible(npc, false)
  local skills = {
    smoke = {327010101, 0}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  get_god_npc().timer_roompass = 0
  monster.timer_reborn = 0
  monster.freezeHero = false
  monster.reborn = false
  set_sync_var("jinghua_num", 0)
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.smoke)
    _ENV.active(_ENV.daze, _ENV.attack, _ENV.stand)
  end
  local states = monster.states
  
  function states.stand.start(stand)
    local npc = stand.monster.npc
    stop_move(npc)
  end
  
  function states.stand.tickTrans(stand)
    local npc = stand.monster.npc
    if get_npc_time(npc) > monster.timer_reborn and monster.reborn == true then
      if true == npc.jinghua then
        monster.timer_reborn = get_npc_time(npc) + 1
        npc.jinghua = false
        return
      end
      monster.reborn = false
      return stand.monster.states.smoke
    end
    if not get_sync_var("jinghua_room") and not get_sync_var("lantern_room") then
      return
    end
    if get_npc_time(get_god_npc()) > get_god_npc().timer_roompass and 0 == get_sync_var("jinghua_num") then
      if get_sync_var("jinghua_room") then
        set_sync_var("room_pass", true)
        set_sync_var("jinghua_num", -1)
      elseif get_sync_var("lantern_room") and get_sync_var("room_pass") == nil then
        set_sync_var("room_restart", true)
        set_sync_var("jinghua_num", -1)
      end
    end
  end
  
  function states.stand.finTrans(stand)
    return stand
  end
  
  function states.smoke.start(smoke)
    npc.D_hitted = false
    smoke.base.start(smoke)
    if get_sync_var("jinghua_room") or get_sync_var("lantern_room") then
      set_sync_var("jinghua_num", get_sync_var("jinghua_num") + 1)
    end
  end
  
  function states.smoke.finish()
    monster.timer_reborn = get_npc_time(npc) + 3
    monster.reborn = true
    if get_sync_var("jinghua_room") or get_sync_var("lantern_room") then
      set_sync_var("jinghua_num", get_sync_var("jinghua_num") - 1)
      if 0 == get_sync_var("jinghua_num") then
        get_god_npc().timer_roompass = get_npc_time(get_god_npc()) + 3.25
      end
    end
  end
  
  function states.smoke.finTrans(smoke)
    return smoke.monster.states.stand
  end
end

function monster.on_self_magic_begin(monster, target, magic_id, is_self, magic_level)
  if 3270101001 == magic_id then
    if 11 ~= get_magic_num(target, 3270101001) then
      return
    end
    if not check_magic(target, 3001064005) then
      cast_magic(monster.npc, target, 3001064005, 1)
      cast_magic(monster.npc, target, 3001064009, 1)
      cast_magic(monster.npc, target, 3001064010, 1)
      play_ui_fight_button_effect({"Skill_Guid", 3})
      monster.freezeHero = true
      cast_magic(monster.npc, target, 2010480152, 1)
      for i = 1, 8 do
        if 3 ~= i then
          set_skill_ban_use(i, true)
        end
      end
    end
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 1 == get_role_kind(hit_target) then
    cast_magic(monster.npc, hit_target, 3270101001)
  end
end

function monster.on_self_magic_end(monster, target, magic_id)
  if 3001064005 == magic_id and target == get_come_on_hero() then
    abort_magic_by_id(target, 3270101001, 10)
    abort_magic_by_id(target, 3001064009, 1)
    stop_ui_fight_button_effect({"Skill_Guid", 3})
    monster.freezeHero = false
    abort_magic_by_id(target, 3001064010, 1)
    abort_magic_by_id(target, 2010480152, 1)
    abort_magic_by_id(target, 2010480152, 1)
    for i = 1, 8 do
      if 3 ~= i then
        set_skill_ban_use(i, false)
      end
    end
  end
end

function monster.on_input(monster, input_id)
  if 18 == input_id and monster.freezeHero == true then
    local target = get_come_on_hero()
    if target.input_count == nil then
      target.input_count = 0
    end
    if check_magic(target, 3001064005) then
      cast_magic(target, target, 3001064007)
      target.input_count = target.input_count + 1
      print(target.input_count)
      if target.input_count > 5 then
        abort_magic_by_id(target, 3001064005, 1)
        target.input_count = 0
      end
    end
  end
end

function monster.on_be_absorb(monster)
  abort_skill(monster.npc)
  monster.tree:finTrans()
end

function monster.on_self_npc_hp_zero(monster)
end

function monster.on_start(monster)
  monster.base.on_start(monster)
  monster.bird = search_npc(monster.npc, 4, 50, nil, false, false, 20104605)
  local bird = monster.bird
  if bird then
    local self_pos = get_npc_pos(monster.npc)
    bird:get_behavior().Smoke_pos = {
      bool = true,
      x = self_pos.x,
      z = self_pos.z,
      target = monster.npc
    }
  end
end

return monster
