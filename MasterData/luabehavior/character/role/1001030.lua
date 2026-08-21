local roleBase = import("character.base.role_base")
local Zhantan = Util.create_child_mt(roleBase)
local magicIds_1 = {
  fan_sign = 1030101,
  stab_count = 1030201,
  backfilp_count = 1030203,
  fishdrop_count = 1030205,
  EnemyYangyu_sign = 1030102,
  EnemyYinyu_sign = 1030103,
  EnemyYinyangyu_sign = 1030104,
  EnemyYinyangyu_sign_pro = 10301041,
  Eyangyu_ReduceDef = 1030500,
  Eyinyu_ReduceSpeed = 1030501,
  Eyinyangyu_bornDamage = 1030502,
  Eyinyangyu_ReduceFireDef = 1030503,
  Eyinyangyu_Confine = 1030504,
  SelfYangyu_sign = 1030105,
  SelfYinyu_sign = 1030106,
  SelfYinyangyu_sign = 1030107,
  yinyangbarrier = 1030108,
  yinyangbarrier_pro = 1030108
}
local misIds_1 = {
  skill2_fan = 10010300701,
  sweep1st_atk = 10010302001,
  sweep2th_atk = 10010302002
}
local keyframe_1 = {
  xiuyouyanji_trans = 10010302104,
  sweep_yangyu_missile = 3002,
  sweep_yinyu_missile = 3003
}
local skillIds_1 = {}

function Zhantan._init(role, npc)
  role.npc = npc
  roleBase._init(role, misIds_1, magicIds_1)
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local traces = role.traces
  local destinies = role.destinies
  local spWeapon = role.spWeapon
  skActs.atk2.heavy = skActs.heavy
  skActs.atk2.counter = skActs.counter
  
  function skActs.atk2.isReady(atk2)
    if not atk2.base.isReady(atk2) then
      return false
    end
    local role = atk2.role
    local roleAct = role.skAct
    local atk = role.icons.atk
    if roleAct == atk2.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
      return true
    elseif roleAct == atk2.heavy then
      return true
    else
      return false
    end
  end
  
  skActs.atk4.counter = skActs.counter
  
  function skActs.atk4.isReady(atk4)
    if not atk4.base.isReady(atk4) then
      return false
    end
    local role = atk4.role
    local roleAct = role.skAct
    local atk = role.icons.atk
    if roleAct == atk4.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
      return true
    elseif roleAct == atk4.counter then
      return true
    else
      return false
    end
  end
  
  function Zhantan.check_yangyu_sign(role, target)
    local yangyuE = check_magic(target, magicIds_1.EnemyYangyu_sign)
    local yinyangyuE = check_magic(target, magicIds_1.EnemyYinyangyu_sign)
    if yangyuE or yinyangyuE then
      return true
    else
      return false
    end
  end
  
  function Zhantan.check_yinyu_sign(role, target)
    local yinyuE = check_magic(target, magicIds_1.EnemyYinyu_sign)
    local yinyangyuE = check_magic(target, magicIds_1.EnemyYinyangyu_sign)
    if yinyuE or yinyangyuE then
      return true
    else
      return false
    end
  end
  
  function magics.SelfYangyu_sign.onBegin(yangyu_sign, caster, target)
    if check_magic(role.npc, magicIds_1.SelfYinyu_sign) then
      cast_magic(role.npc, role.npc, magicIds_1.SelfYinyangyu_sign, 1)
    end
    cast_magic(role.npc, role.npc, 1030109, 1)
  end
  
  function magics.SelfYinyu_sign.onBegin(yinyu_sign, caster, target)
    if check_magic(role.npc, magicIds_1.SelfYangyu_sign) then
      cast_magic(role.npc, role.npc, magicIds_1.SelfYinyangyu_sign, 1)
    end
    cast_magic(role.npc, role.npc, 1030110, 1)
  end
  
  function magics.SelfYinyangyu_sign.onBegin(yinyangyu_sign, caster, target)
    cast_magic(role.npc, role.npc, magicIds_1.fishdrop_count)
    if role.traceLv < 4 then
      cast_magic(role.npc, role.npc, magicIds_1.yinyangbarrier)
    else
      cast_magic(role.npc, role.npc, magicIds_1.yinyangbarrier_pro)
    end
  end
  
  do
    local atk = role.btns.atk
    local atk1 = role.icons.atk
    local fish_drop2 = role.icons.fish_drop2
    
    function magics.fishdrop_count.onBegin()
      atk:setIcon(fish_drop2)
    end
    
    function magics.fishdrop_count.onEnd(magic, casterNpc, target)
      atk:setIcon(atk1)
    end
    
    function skActs.fish_drop2.onBegin()
      if not role:isRampage() then
        atk:setIcon(atk1)
      end
    end
  end
  
  function magics.EnemyYangyu_sign.onBegin(yangyu_sign, caster, target)
    cast_magic(npc, target, magicIds_1.Eyangyu_ReduceDef)
    if check_magic(target, magicIds_1.EnemyYinyu_sign) and role.traceLv < 1 then
      cast_magic(role.npc, target, magicIds_1.EnemyYinyangyu_sign, 1)
    elseif check_magic(target, magicIds_1.EnemyYinyu_sign) and role.traceLv >= 1 then
      cast_magic(role.npc, target, magicIds_1.EnemyYinyangyu_sign_pro, 1)
    end
  end
  
  function magics.EnemyYinyu_sign.onBegin(yangyu_sign, caster, target)
    cast_magic(npc, target, magicIds_1.Eyinyu_ReduceSpeed)
    if check_magic(target, magicIds_1.EnemyYangyu_sign) and role.traceLv < 1 then
      cast_magic(role.npc, target, magicIds_1.EnemyYinyangyu_sign, 1)
    elseif check_magic(target, magicIds_1.EnemyYangyu_sign) and role.traceLv >= 1 then
      cast_magic(role.npc, target, magicIds_1.EnemyYinyangyu_sign_pro, 1)
    end
  end
  
  function magics.EnemyYinyangyu_sign.onBegin(yangyu_sign, caster, target)
    cast_magic(npc, target, magicIds_1.Eyinyangyu_bornDamage)
    print("magicIds_1.Eyinyangyu_bornDamage", magicIds_1.Eyinyangyu_bornDamage)
    cast_magic(npc, target, magicIds_1.Eyinyangyu_ReduceFireDef)
  end
  
  function magics.EnemyYinyangyu_sign.onEnd(yangyu_sign, caster, target)
    abort_magic_by_id(target, magicIds_1.Eyinyangyu_ReduceFireDef, 1)
  end
  
  function magics.EnemyYinyangyu_sign_pro.onBegin(yangyu_sign, caster, target)
    cast_magic(npc, target, magicIds_1.Eyinyangyu_bornDamage)
    cast_magic(npc, target, magicIds_1.Eyinyangyu_ReduceFireDef)
  end
  
  function magics.EnemyYinyangyu_sign_pro.onEnd(yangyu_sign, caster, target)
    abort_magic_by_id(target, magicIds_1.Eyinyangyu_ReduceFireDef, 1)
  end
  
  do
    local sk1 = role.btns.sk1
    local throw_fan = role.icons.throw_fan
    local sprint = role.icons.sprint
    local stab = role.icons.stab
    
    function skActs.throw_fan.onHit(throw_fan, casterNpc, hitTarget, hitType, skill, missile)
      cast_magic(npc, npc, magicIds_1.stab_count, 1)
    end
    
    function skActs.sprint.onBegin(sprint)
      sprint.base.onBegin(sprint)
      abort_magic_by_id(role.npc, magicIds_1.stab_count)
    end
    
    function magics.stab_count.onBegin(stab_count, casterNpc, target)
      sk1:setIcon(sprint)
    end
    
    function magics.stab_count.onEnd(stab_count, casterNpc, target)
      sk1:setIcon(throw_fan)
    end
    
    function skActs.sprint.onEnd()
      sk1:setIcon(throw_fan)
    end
    
    function skActs.sprint.onHit(stab, casterNpc, hitTarget, hitType, skill, missile)
      if check_magic(hitTarget, magicIds_1.fan_sign) then
        abort_magic_by_id(hitTarget, magicIds_1.fan_sign)
        cast_magic(role.npc, hitTarget, magicIds_1.EnemyYangyu_sign)
      end
      cast_magic(role.npc, role.npc, magicIds_1.SelfYangyu_sign)
    end
  end
  do
    local sk2 = role.btns.sk2
    local sweep = role.icons.sweep
    local xiuyouyanji = role.icons.xiuyouyanji
    
    function skActs.sweep.onBegin()
      set_keyframe_enable_by_tag(npc, role.skills.sweep.id, keyframe_1.sweep_yangyu_missile, false, true)
    end
    
    function skActs.sweep.onHit(sweep, casterNpc, hitTarget, hitType, skill, missile)
      if missile.missile_id == misIds_1.sweep1st_atk and role:check_yangyu_sign(hitTarget) then
        set_keyframe_enable_by_tag(npc, role.skills.sweep.id, keyframe_1.sweep_yangyu_missile, true, false)
      end
      if missile.missile_id == misIds_1.sweep2th_atk then
        cast_magic(role.npc, role.npc, magicIds_1.backfilp_count)
      end
    end
    
    function skActs.xiuyouyanji.onHit(xiuyouyanji, casterNpc, hitTarget, hitType, skill, missle)
      cast_magic(role.npc, role.npc, magicIds_1.SelfYinyu_sign)
    end
    
    function magics.backfilp_count.onBegin(sweep_count, casterNpc, target)
      sk2:setIcon(xiuyouyanji)
    end
    
    function skActs.xiuyouyanji.onBegin()
      abort_magic_by_id(role.npc, magicIds_1.backfilp_count)
    end
    
    function magics.backfilp_count.onEnd(sweep_count, casterNpc, target)
      sk2:setIcon(sweep)
    end
    
    function skActs.xiuyouyanji.onEnd()
      sk2:setIcon(sweep)
    end
    
    function skills.sweep.startFrame()
      if role.preAct == role.skActs.sprint then
        return 0
      else
        return 2
      end
    end
  end
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      return 1
    else
      return 0
    end
  end
  
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function addBuff(magic, casterNpc, target)
      cast_magic(role.npc, target, 1030289, 1)
    end
    
    tool.insert(magics.EnemyYinyangyu_sign, "onBegin", addBuff)
    tool.insert(magics.EnemyYinyangyu_sign_pro, "onBegin", addBuff)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    magicIds_1.Eyinyangyu_bornDamage = 1030504
    magicIds_1.Eyinyangyu_ReduceFireDef = 1030505
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function addBuff(magic, casterNpc, target)
      tool:castMagicToTeam(10302002, 1, role.npc, 1)
    end
    
    tool.insert(magics.yinyangbarrier, "onBegin", addBuff)
    tool.insert(magics.yinyangbarrier_pro, "onBegin", addBuff)
    
    local function addBuffMoveSpdde(magic, casterNpc, target)
      tool:castMagicToTeam(1030110, 1, role.npc, 1)
    end
    
    tool.insert(magics.SelfYinyu_sign, "onBegin", addBuffMoveSpdde)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 10300121 == magic_id or 10300122 == magic_id or 10300123 == magic_id then
        cast_magic(role.npc, role.npc, 10302003, 0)
      elseif 10300131 == magic_id or 10300132 == magic_id or 10300136 == magic_id then
        cast_magic(role.npc, role.npc, 10302004, 0)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 10300161 == magic_id or 10300162 == magic_id then
        cast_magic(role.npc, role.npc, 10302004, 0)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function addBuff(magic, casterNpc, target)
      tool:castMagicToTeam(10302006, 1, role.npc, 1)
      
      tool:castMagicToTeam(10302007, 1, role.npc, 1)
    end
    
    tool.insert(magics.yinyangbarrier, "onBegin", addBuff)
    tool.insert(magics.yinyangbarrier_pro, "onBegin", addBuff)
  end
  
  function role.spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function addBuff(role, npc)
      if check_magic(npc, 1030104) or check_magic(npc, 10301041) then
        role.tool:castMagicToTeam(10302008, role.spWeapon.lv, role.npc)
      end
    end
    
    tool.insert(role, "on_npc_hp_zero", addBuff)
  end
end

function Zhantan.onRampageStart(role, stage)
  local atkBtn = role.btns.atk
  local fish_drop2 = role.icons.fish_drop2
  atkBtn:setIcon(fish_drop2)
end

function Zhantan.onRampageEnd(role, stage)
  local atkBtn = role.btns.atk
  local fish_drop2 = role.icons.atk
  atkBtn:setIcon(fish_drop2)
end

function Zhantan.on_keyframe_action(role, kfId, npcTag, comnTag)
  if kfId == keyframe_1.xiuyouyanji_trans then
    role.skActs.xiuyouyanji.trans.enable.fish_drop2 = true
  end
  if kfId == keyframe_1.atk4_trans then
    role.skActs.atk4.trans.enable.sprint = true
  end
end

return Zhantan
