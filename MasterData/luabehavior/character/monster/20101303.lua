local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.5,
    maxDis = 8,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 2010130116
  local skills = {
    Atk1 = {
      2010130101,
      4,
      2,
      0,
      3,
      -45,
      45
    },
    Atk2 = {
      2010130102,
      0,
      0,
      0,
      8
    },
    Shield_Start = {
      2010130103,
      30,
      10,
      0,
      8
    },
    Shield_Loop = {
      2010130104,
      0,
      0,
      0,
      99
    },
    Shield_End = {
      2010130105,
      0,
      0,
      0,
      99
    },
    Call_explode = {
      2010130106,
      8,
      1,
      0,
      99,
      -60,
      60
    },
    Call_Charge = {
      2010130113,
      8,
      1,
      0,
      99,
      -60,
      60
    }
  }
  local nodes = {
    "ATK",
    "Call_son",
    "Shield"
  }
  monstBase._init(monster, skills, nil, nodes)
  monster.son_table = {}
  monster.son_num = 0
  monster.son_table2 = {}
  monster.son_num2 = 0
  monster.shield_npc = 0
  monster.shieldDead = false
  monster.shieldUp = false
  monster.level = monster.npc:get_level()
  monster.states.attack.interval = 3
  
  function monster.states.Atk1.moveScale()
    return 1.5
  end
  
  function monster.states.Atk2.moveScale()
    return 1.5
  end
  
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.Shield, _ENV.attack, _ENV.wander)
    _ENV.freeAtk(_ENV.ATK, _ENV.Call_son)
    _ENV.Call_son(_ENV.Call_Charge, _ENV.Call_explode)
    _ENV.ATK(_ENV.Atk1(_ENV.Atk2))
    _ENV.Shield(_ENV.Shield_Start(_ENV.Shield_Loop(_ENV.Shield_End)))
  end
  do
    local Call_explode = monster.states.Call_explode
    local Call_Charge = monster.states.Call_Charge
    
    function Call_explode.isReady(skill)
      if skill.monster.son_num > 0 then
        return false
      end
      if not skill.base.isReady(Call_explode) then
        return false
      end
      return true
    end
    
    function Call_explode.start(skill)
      local self = skill.monster
      local self_pos = get_npc_pos(self.npc)
      local target_pos = get_npc_pos(self.target)
      local p1 = get_position_offset_position(self_pos, target_pos, 0, 1.5)
      local p2 = get_position_offset_position(self_pos, target_pos, 0, 1.5)
      
      local function CallSon1(self)
        if is_cast_skill_time(monster.npc, 2010130106, 1) then
          add_npc2(2, 20101304, p1.x, p1.z, 0, 0, 2, self.level)
          skill.monster.son_num = skill.monster.son_num + 1
        end
      end
      
      local function CallSon2(self)
        if is_cast_skill_time(monster.npc, 2010130106, 1) then
          add_npc2(2, 20101304, p2.x, p2.z, 0, 0, 2, self.level)
          add_npc2(2, 20101304, p2.x, p2.z, 0, 0, 2, self.level)
          skill.monster.son_num = skill.monster.son_num + 1
        end
        skill.monster.son_table = search_npc(skill.monster.npc, 2, 100, nil, false, true, 20101304, 7)
      end
      
      monster:doAfter(CallSon1, 2)
      monster:doAfter(CallSon2, 3)
      skill.base.start(Call_explode)
    end
    
    function Call_explode.finTrans(skill)
      if math.random() > 0.4 and skill.monster.states.Shield_Start.base.isReady(skill.monster.states.Shield_Start) then
        skill.monster.shieldUp = true
        return skill.monster.states.Shield
      else
        return skill.monster.states.wander
      end
    end
    
    function Call_Charge.isReady(skill)
      if skill.monster.son_num2 > 0 then
        return false
      end
      if not skill.base.isReady(Call_Charge) then
        return false
      end
      return true
    end
    
    function Call_Charge.start(skill)
      local self = skill.monster
      local self_pos = get_npc_pos(self.npc)
      local target_pos = get_npc_pos(self.target)
      local p1 = get_position_offset_position(self_pos, target_pos, 0, 1.5)
      local p2 = get_position_offset_position(self_pos, target_pos, 0, 1.5)
      
      local function CallSon1(self)
        if is_cast_skill_time(monster.npc, 2010130113, 1) then
          skill.monster.son_num2 = skill.monster.son_num2 + 1
          add_npc2(2, 20101305, p1.x, p1.z, 0, 0, 2, self.level)
        end
      end
      
      local function CallSon2(self)
        if is_cast_skill_time(monster.npc, 2010130113, 1) then
          skill.monster.son_num2 = skill.monster.son_num2 + 2
          add_npc2(2, 20101305, p2.x, p2.z, 0, 0, 2, self.level)
          add_npc2(2, 20101305, p1.x, p1.z, 0, 0, 2, self.level)
        end
        skill.monster.son_table2 = search_npc(skill.monster.npc, 2, 100, nil, false, true, 20101305, 7)
      end
      
      monster:doAfter(CallSon1, 2)
      monster:doAfter(CallSon2, 3)
      skill.base.start(Call_Charge)
    end
  end
  do
    local Shield_Start = monster.states.Shield_Start
    local Shield_Loop = monster.states.Shield_Loop
    local Shield_End = monster.states.Shield_End
    local Shield = monster.states.Shield
    
    function Shield.finTrans(Shield)
      return Shield.monster.states.wander
    end
    
    function Shield_Start.start(skill)
      local self = skill.monster
      cast_magic(self.npc, self.npc, 201055002, 1)
      cast_magic(self.npc, self.npc, 201055003, 1)
      cast_magic(self.npc, self.npc, 201055004, 1)
      self.shield_npc = add_npc2(2, 201059, get_npc_pos(self.npc).x, get_npc_pos(self.npc).z, 0, 0, 2, self.level + 10)
      cast_magic(self.npc, self.shield_npc, 201059001, 1)
      skill.base.start(Shield_Start)
    end
    
    function Shield_End.start(skill)
      local self = skill.monster
      abort_magic_by_id(self.npc, 201055002, 1)
      abort_magic_by_id(self.npc, 201055003, 1)
      abort_magic_by_id(self.npc, 201055004, 1)
      abort_magic_by_id(self.npc, 201059002, 1)
      cast_magic(self.npc, self.npc, 201059004, 1)
      remove_npc(self.shield_npc)
      cast_missile(self.npc, nil, get_npc_pos(self.npc).x, get_npc_pos(self.npc).z, 201013011401, 1)
      skill.base.start(Shield_End)
    end
  end
end

function monster.on_npc_hp_zero(monster, npc)
  for i, v in pairs(monster.son_table) do
    if npc == v then
      monster.son_num = monster.son_num - 1
    end
  end
  for j, k in pairs(monster.son_table2) do
    if npc == k then
      monster.son_num2 = monster.son_num2 - 1
    end
  end
  if npc == monster.shield_npc then
    cast_magic(monster.npc, monster.npc, 20103101068, 1)
    abort_magic_by_id(monster.npc, 201055002, 1)
    abort_magic_by_id(monster.npc, 201055003, 1)
    abort_magic_by_id(monster.npc, 201055004, 1)
    abort_magic_by_id(monster.npc, 201059002, 1)
    cast_magic(monster.npc, monster.npc, 201059003, 1)
    cast_magic(monster.npc, monster.npc, 20101301002, 1)
  end
end

function monster.on_self_npc_hp_zero(monster)
  monster.base.on_self_npc_hp_zero(monster)
  monster.tree:transState(monster.states.dead)
  for i, v in pairs(monster.son_table) do
    cast_magic(monster.npc, v, 10001001, 1)
  end
  for j, k in pairs(monster.son_table2) do
    cast_magic(monster.npc, k, 10001001, 1)
  end
end

function monster.on_start(monster)
  monster:xRay()
end

function monster.go_mad(monster)
  cast_magic(monster.npc, monster.npc, 500100101, 1)
  cast_magic(monster.npc, monster.npc, 500100102, 1)
  cast_magic(monster.npc, monster.npc, 500100111, 1)
  monster.states.Atk1.cd = 3
  monster.states.Shield_Start.cd = 12
  monster.states.attack.interval = 1
  local _ENV = monster.states
end

return monster
