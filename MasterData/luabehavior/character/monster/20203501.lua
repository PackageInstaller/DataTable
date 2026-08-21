local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

function monster._init(monster, npc)
  local monster = monster
  monster.npc = npc
  monster.wander = {
    minDis = 1,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 2020350103
  local skills = {
    Atk = {
      2020350101,
      1,
      1,
      0,
      30
    }
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.Atk)
    _ENV.wander(_ENV.stand)
  end
  monster.states.attack.interval = 2
  tool.NPC_1 = true
  do
    local born = monster.states.born
    
    function born.finish(born)
      local monster = born.monster
      monster.search = {minDis = 100, maxDis = 100}
      local pos_zero1 = {
        x = 188.9059,
        y = -954.397,
        z = 205.24
      }
      change_follow_target(3, monster.npc, {
        16,
        26,
        {
          x = 0,
          y = -10,
          z = -1
        },
        1,
        0.9
      })
      if 114 ~= tool.NPC_1 then
        play_DBM_ani(22)
        start_stroy(202015)
        abort_skill(monster.npc)
        set_npc_pos(monster.npc, "O3")
        cast_magic(monster.npc, monster.npc, 20203502003, 1)
        lookat_position(monster.npc, pos_zero1.x, pos_zero1.z, true)
        abort_magic_by_id(monster.npc, Const.LOCK_MASK, 1)
        abort_magic_by_id(monster.npc, 20103401037, 1)
        abort_magic_by_id(monster.npc, 20103401038, 1)
      end
    end
  end
  do
    local Atk = monster.states.Atk
    local stand = monster.states.stand
    Atk.HP = false
    
    function Atk.start(Atk)
      set_npc_hp_visible(Atk.monster.npc, true)
      Atk.HP = true
      Atk.random = math.random(1, 4)
      if 1 == Atk.random then
        set_npc_pos(npc, "O1")
        cast_magic(npc, npc, 20203502003, 1)
      end
      if 2 == Atk.random then
        set_npc_pos(npc, "O2")
        cast_magic(npc, npc, 20203502003, 1)
      end
      if 3 == Atk.random then
        set_npc_pos(npc, "O3")
        cast_magic(npc, npc, 20203502003, 1)
      end
      if 4 == Atk.random then
        set_npc_pos(npc, "O4")
        cast_magic(npc, npc, 20203502003, 1)
      end
      lookat_npc(npc, monster.target)
      Atk.base.start(Atk)
    end
    
    function stand.start(stand)
      stop_move(stand.monster.npc)
    end
  end
  do
    local dead = monster.states.dead
    dead.switch = false
    dead.delay = {fx = 0.8, remove = 2}
  end
  monster.npc:initialize_weaponattach_setting(2)
end

function monster.on_start(monster)
  set_lock_velocity(monster.npc, 100)
  set_npc_controller(monster.npc, 2)
  cast_magic(monster.npc, monster.npc, 20103401001, 1)
  cast_magic(monster.npc, monster.npc, 20203502003, 1)
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  local switch = true
  if 114 == tool.NPC_1 then
    cast_magic(monster.npc, monster.npc, 20103401034, 1)
  end
  if not is_cast_skill_time(monster.npc, 2020350101) and monster.states.Atk.HP == false then
    set_npc_hp_visible(monster.npc, false)
  end
end

function monster.on_self_npc_hp_zero(monster)
  monster.base.on_self_npc_hp_zero(monster)
  tool.NPC_1 = false
end

function monster.on_missile_collide(monster, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m1_owner == m2_owner then
    return
  end
  if m1_cfg.Id == 202035010111 then
    monster:try_red_skill_counter(m2)
  elseif m2_cfg.Id == 202035010111 then
    monster:try_red_skill_counter(m1)
  end
end

function monster.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
  monster.base.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
  remove_missile_by_id(202035010101, monster.npc)
end

function monster.after_damage_target(monster, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if 20203502001 == magic_id then
    remove_missile_by_id(202035010111, monster.npc)
  end
end

return monster
