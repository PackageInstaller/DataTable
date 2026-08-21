local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.5,
    maxDis = 4,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    skill01 = {
      2010360202,
      3,
      3,
      0,
      4,
      -60,
      60
    },
    skill02 = {
      2010360201,
      8,
      20,
      0,
      10,
      -90,
      90
    },
    skill03 = {
      2010360203,
      0,
      0,
      0,
      99,
      -60,
      60
    },
    redskill = {
      2010360204,
      12,
      5 + 8 * math.random(),
      0,
      5,
      -60,
      60
    }
  }
  local actMoves = {"Blink"}
  monstBase._init(monster, skills, actMoves, nil)
  monster.states.attack.interval = 3
  
  function monster.states.skill01.moveScale()
    return 1.5
  end
  
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.attack, _ENV.Blink, _ENV.wander)
    _ENV.rangedAtk(_ENV.skill02)
    _ENV.meleeAtk(_ENV.redskill, _ENV.skill01)
    _ENV.freeAtk(_ENV.skill03(_ENV.skill03))
  end
  do
    local Blink = monster.states.Blink
    local Blink_CD = 12
    local wander = monster.states.wander
    
    function wander.tickTrans(wander)
      local states = wander.monster.states
      local skill = monster.tree:chooseChildAction(states.attack)
      if not monster.target then
        return states.noTarget
      end
      if skill then
        return skill
      end
      if get_npc_time(wander.monster.npc) > Blink_CD then
        return states.Blink
      end
    end
    
    function Blink.isReady(Blink)
      if get_npc_time(Blink.monster.npc) < Blink_CD then
        return false
      end
      if Blink.monster.target and not check_npc_distance(Blink.monster.npc, Blink.monster.target, 3, false) then
        return false
      end
      return true
    end
    
    function Blink.start(Blink)
      local self = Blink.monster
      local angle = math.random() * 360
      local distance = 2 + 2 * math.random()
      local pos = get_npc_offset_position(self.target, nil, angle, distance)
      Blink_CD = get_npc_time(self.npc) + 1
      cast_magic(self.npc, self.npc, 20102701009, 1)
      
      local function shadow()
        enable_shadow(self.npc, false)
        set_npc_hp_visible(self.npc, false)
      end
      
      monster:doAfter(shadow, 0.2)
      cast_magic(self.npc, self.npc, 20102701005, 1)
      cast_magic(self.npc, self.npc, 20102701006, 1)
      cast_magic(self.npc, self.npc, 20102701006, 1)
      cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
      cast_magic(self.npc, self.npc, 100104, 1)
      
      local function Flash()
        flash_to_pos(self.npc, pos.x, pos.z)
        cast_magic(self.npc, self.npc, 20102701008, 1)
        enable_shadow(self.npc, true)
        set_npc_hp_visible(self.npc, true)
        set_can_searched(self.npc, true)
      end
      
      monster:doAfter(Flash, 0.9)
    end
    
    function Blink.tickTrans(Blink)
      if get_npc_time(Blink.monster.npc) > Blink_CD then
        Blink_CD = get_npc_time(Blink.monster.npc) + 8 + 5 * math.random()
        return Blink.monster.states.wander
      end
    end
  end
  do
    local skill03 = monster.states.skill03
    skill03.num = 0
    
    function skill03.isReady(skill03)
      if not monster.target then
        return false
      end
      if skill03.num > 3 then
        return false
      end
      return true
    end
    
    function skill03.start(skill03)
      local self = skill03.monster
      local angle = math.random() * 360
      local distance = 4
      local pos = get_npc_offset_position(self.target, nil, angle, distance)
      skill03.num = skill03.num + 1
      lookat_npc(self.npc, self.target)
      
      local function Flash()
        cast_magic(self.npc, self.npc, 20102701009, 1)
        enable_shadow(self.npc, false)
        set_npc_hp_visible(self.npc, false)
        cast_magic(self.npc, self.npc, 20102701005, 1)
        cast_magic(self.npc, self.npc, 20102701006, 1)
        cast_magic(self.npc, self.npc, 20102701006, 1)
        cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
        cast_magic(self.npc, self.npc, 100104, 1)
      end
      
      local function Jump()
        flash_to_pos(self.npc, pos.x, pos.z)
        cast_magic(self.npc, self.npc, 20102701008, 1)
        enable_shadow(self.npc, true)
        set_npc_hp_visible(self.npc, true)
        set_can_searched(self.npc, true)
      end
      
      monster:doAfter(Jump, 2.1)
      monster:doAfter(Flash, 1.7)
      skill03.base.start(skill03)
    end
  end
end

function monster.on_self_magic_end(monster, target, magic_id)
  monster.base.on_self_magic_end(monster, target, magic_id)
  if 20102701009 == magic_id then
    abort_magic_by_id(monster.npc, Const.LOCK_MASK, 1)
    abort_magic_by_id(monster.npc, 100104, 1)
    abort_magic_by_id(monster.npc, 20102701007, 1)
    abort_magic_by_id(monster.npc, 20102701006, 1)
    abort_magic_by_id(monster.npc, 20102701005, 1)
  end
end

return monster
