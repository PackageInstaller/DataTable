local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 2020350203
  local skills = {
    Atk1 = {
      2020350201,
      3,
      1
    },
    Atk2 = {
      2020350207,
      0,
      0,
      0,
      30
    },
    GetUp = {2020350204, 999}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.GetUp, _ENV.Atk1)
    _ENV.wander(_ENV.stand)
  end
  monster.states.attack.interval = 0.2
  tool.NPC_2 = true
  do
    local born = monster.states.born
    
    function born.tickTrans(born)
      local passive = born.passive
      set_npc_hp_visible(monster.npc, false)
      if passive:isReady() then
        return passive
      end
      if tool.NPC_1 == false then
        return monster.states.GetUp
      end
    end
  end
  do
    local GetUp = monster.states.GetUp
    local Atk2 = monster.states.Atk2
    local stand = monster.states.stand
    Atk2.num = 0
    
    function GetUp.start(GetUp)
      local center = {
        x = 198.28,
        y = -954.2557,
        z = 208.76
      }
      
      local function falsh()
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
        play_DBM_ani(21)
        start_stroy(202014)
        flash_to_pos(monster.npc, center.x, center.z)
        set_npc_hp_visible(monster.npc, true)
        cast_magic(monster.npc, monster.npc, 20203502003, 1)
        abort_magic_by_id(monster.npc, Const.LOCK_MASK, 1)
        abort_magic_by_id(monster.npc, 20102701007, 1)
        abort_magic_by_id(monster.npc, 20103401037, 1)
        GetUp.base.start(GetUp)
      end
      
      if 114 ~= tool.NPC_2 and tool.NPC_1 == false then
        monster:doAfter(falsh, 1.5)
      end
    end
    
    function Atk2.isReady(Atk2)
      if Atk2.num > 5 then
        GetUp.isReady = Const.FALSE_FUN
        return false
      end
      return true
    end
    
    function Atk2.start(Atk2)
      lookat_npc(monster.npc, monster.target, true)
      Atk2.num = Atk2.num + 1
      Atk2.base.start(Atk2)
    end
    
    function stand.start(stand)
      stop_move(stand.monster.npc)
    end
  end
  do
    local dead = monster.states.dead
    dead.switch = false
    dead.delay = {fx = 0.8, remove = 2}
    
    function dead.start(self_node)
      self_node.switch = true
      local monster = self_node.monster
      local now = get_time()
      self_node.timer.fx = now + self_node.delay.fx
      self_node.timer.remove = now + self_node.delay.remove
      enable_shadow(monster.npc, false)
      time_scale_immune(monster.npc, true)
      set_skill_end_to_idle(monster.npc, false)
      abort_skill(monster.npc, false)
      
      local function startTryRemove(inputMonster)
        if inputMonster.npc and not npc_is_destroy(inputMonster.npc) then
          local states = inputMonster.states
          states.dead.tick = states.dead.tickRemove
        end
      end
      
      set_npc_dead(monster.npc, nil, false, startTryRemove)
      local colliOff1 = 399931
      local colliOff2 = 399932
      local invulnerable = 399933
      tool.NPC_2 = false
      cast_magic(monster.npc, monster.npc, colliOff1, 0)
      cast_magic(monster.npc, monster.npc, colliOff2, 0)
      cast_magic(monster.npc, monster.npc, invulnerable, 0)
      
      function monster.states.passive.tickTrans()
      end
    end
  end
  monster.npc:initialize_weaponattach_setting(1)
end

function monster.on_start(monster)
  set_lock_velocity(monster.npc, 0.1)
  set_npc_hp_visible(monster.npc, false)
  set_npc_controller(monster.npc, 1)
  cast_magic(monster.npc, monster.npc, 20103401001, 1)
  cast_magic(monster.npc, monster.npc, 20203502003, 1)
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  local npc = monster.npc
  if 114 == tool.NPC_2 then
    cast_magic(npc, npc, 20103401034, 1)
  end
end

function monster.on_self_npc_hp_zero(monster)
  monster.base.on_self_npc_hp_zero(monster)
  tool.NPC_2 = false
end

return monster
