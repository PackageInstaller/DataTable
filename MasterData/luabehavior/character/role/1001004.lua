local roleBase = import("character.base.role_base")
local tool = import("common.tool")
local Xin = Util.create_child_mt(roleBase)
local linkCheck = 0
local link_prick_num = 0

function Xin.onRampageStart(role, stage)
  linkCheck = 1
end

function Xin.onRampageEnd(role, stage)
  linkCheck = 0
end

function Xin._init(role, npc)
  role.npc = npc
  local misIds = {
    mis_thunderSpear1 = 10010042101,
    mis_thunderSpear2 = 10010042201,
    sp_exmissile = {10010046101, 10010046102}
  }
  local magicIds = {
    magic_thunderSprint = 1004010,
    magic_thunderIcon = 1004088,
    magic_coreCamEffect = 1004083,
    magic_coreCam = 1004098,
    magic_endPrick = 1004085,
    magic_ult = {1004018, 1004019},
    magic_ultAtkBuff = 1004175,
    magic_thunderBuff = 1004135,
    magic_teach1 = 40320401,
    magic_teach2 = 40320402,
    magic_teach3 = 40320403,
    magic_spear2check = 1004072,
    magic_sprintcheck = 1004073
  }
  roleBase._init(role, misIds, magicIds)
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local traces = role.traces
  traces[1004170] = 1
  traces[1004171] = 2
  traces[1004172] = 3
  traces[1004173] = 4
  traces[1004174] = 5
  local destinies = role.destinies
  destinies[1004120] = 1
  destinies[1004121] = 2
  destinies[1004122] = 3
  destinies[1004123] = 4
  destinies[1004124] = 5
  local spWeapon = role.spWeapon
  spWeapon.magic = 1004125
  local sp_weaponActive = false
  role.core_skill_limit = false
  role.core_skill_counting = 0
  role.core_skill_switch = false
  local ult_hitcount = 0
  local destinies1 = false
  local destinies5 = false
  do
    local function weaponEffectClose(act, tarAct)
      cast_magic(npc, npc, 1004163, 0)
      
      act.base.onBreak(act, tarAct)
    end
    
    skActs.heavy.onBreak = weaponEffectClose
    skActs.qte.onBreak = weaponEffectClose
  end
  do
    local function thunderSpearOnBreak(thunderSpearOnBreak, casterNpc, hitTarget, hitType, skill, missile)
      cast_magic(role.npc, role.npc, 1004095, 0)
    end
    
    skills.thunderSpear1.onBreak = thunderSpearOnBreak
    skills.thunderSpear2.onBreak = thunderSpearOnBreak
    
    local function thunderIcon(thunderIcon, casterNpc, hitTarget, hitType, skill, missile)
      local target_kind = get_role_kind(hitTarget)
      if 5 ~= target_kind then
        cast_magic(role.npc, hitTarget, 1004088, 0)
      end
    end
    
    skActs.thunderSpear1.onHit = thunderIcon
    skActs.thunderSpear2.onHit = thunderIcon
    skActs.linkQte.onHit = thunderIcon
    
    function skActs.thunderSpear1.onBegin(thunderSprint1)
      cast_magic(role.npc, role.npc, 1004077, 0)
      cast_magic(role.npc, role.npc, 10040771, 0)
      thunderSprint1.base.onBegin(thunderSprint1)
    end
    
    function skActs.thunderSpear2.onBegin(thunderSprint2)
      cast_magic(role.npc, role.npc, 1004077, 0)
      cast_magic(role.npc, role.npc, 10040771, 0)
      thunderSprint2.base.onBegin(thunderSprint2)
    end
  end
  do
    local function nilFun()
    end
    
    skills.thunderSprint1.target = nilFun
    skills.thunderSprint2.target = nilFun
    skills.thunderSprint3.target = nilFun
    
    function magics.magic_sprintcheck.onBegin()
      if role.skAct.name == "thunderSprint1" then
        local sprint = role.btns.sk2
        local sprinticon = role.icons.thunderSprint2
        sprint:setIcon(sprinticon)
      elseif role.skAct.name == "thunderSprint2" then
        local sprint = role.btns.sk2
        local sprinticon = role.icons.thunderSprint3
        sprint:setIcon(sprinticon)
      elseif role.skAct.name == "thunderSprint3" then
        local sprint = role.btns.sk2
        local sprinticon = role.icons.thunderSprint3
        sprint:setIcon(sprinticon)
      end
    end
    
    function magics.magic_sprintcheck.onEnd()
      if role.skAct.name ~= "thunderSprint1" or role.skAct.name ~= "thunderSprint2" or role.skAct.name ~= "thunderSprint3" or role.skAct.name ~= "thunderSpear1" or role.skAct.name ~= "thunderSpear2" then
        local sprint = role.btns.sk2
        local sprinticon = role.icons.thunderSprint1
        sprint:setIcon(sprinticon)
      end
    end
    
    local function passive_logic(role, target, magic_id)
      if 1004010 ~= magic_id then
        return
      end
      if check_magic(target, 1004088) then
        if destinies5 then
          cast_magic(role.npc, target, 1004184, 0)
        end
        if 0 == linkCheck then
          cast_magic(role.npc, target, 1004089, 0)
        end
        cast_magic(role.npc, role.npc, 1004081, 0)
        cast_magic(role.npc, role.npc, 10040811, 0)
        cast_magic(role.npc, role.npc, 10040812, 0)
        if sp_weaponActive and not check_magic(role.npc, 1004185) then
          local pos = get_npc_pos(target)
          cast_missile(role.npc, target, pos.x, pos.z, misLogics.sp_exmissile[1].id, 0)
          cast_missile(role.npc, target, pos.x, pos.z, misLogics.sp_exmissile[2].id, 0)
          cast_magic(role.npc, role.npc, 1004180, 0)
          cast_magic(role.npc, role.npc, 1004185, 0)
          role:doAfter(function(role)
            cast_magic(role.npc, role.npc, 1004179, 0)
          end, 0.35)
        end
        if destinies1 then
          cast_magic(role.npc, role.npc, 1004130, 0)
        end
        if not role.core_skill_limit and role.core_skill_counting < 3 then
          role.core_skill_counting = role.core_skill_counting + 1
          role.core_skill_limit = true
          if 1 == role.core_skill_counting then
            cast_magic(role.npc, role.npc, 1004176, 0)
            role.spBarStatus(true, 1)
          end
          if 2 == role.core_skill_counting then
            cast_magic(role.npc, role.npc, 1004177, 0)
            role.spBarStatus(true, 1)
          end
          if 3 == role.core_skill_counting then
            cast_magic(role.npc, role.npc, 1004178, 0)
            role.spBarStatus(true, 1)
          end
        end
      end
    end
    
    tool.insert(role, "before_damage_target", passive_logic)
    
    function skills.thunderSprint1.onBreak()
      role.core_skill_limit = false
    end
    
    function skills.thunderSprint1.onEnd()
      role.core_skill_limit = false
    end
    
    function skills.thunderSprint2.onBreak()
      role.core_skill_limit = false
    end
    
    function skills.thunderSprint2.onEnd()
      role.core_skill_limit = false
    end
    
    function skills.thunderSprint3.onBreak()
      role.core_skill_limit = false
    end
    
    function skills.thunderSprint3.onEnd()
      role.core_skill_limit = false
    end
    
    function skActs.thunderSprint1.onBegin(thunderSprint1)
      cast_magic(role.npc, role.npc, 1004078, 0)
      cast_magic(role.npc, role.npc, 10040781, 0)
      cast_magic(role.npc, role.npc, 10040782, 0)
      thunderSprint1.base.onBegin(thunderSprint1)
    end
    
    function skActs.thunderSprint2.onBegin(thunderSprint2)
      cast_magic(role.npc, role.npc, 1004078, 0)
      cast_magic(role.npc, role.npc, 10040781, 0)
      cast_magic(role.npc, role.npc, 10040782, 0)
      thunderSprint2.base.onBegin(thunderSprint2)
    end
    
    function skActs.thunderSprint3.onBegin(thunderSprint3)
      cast_magic(role.npc, role.npc, 1004078, 0)
      cast_magic(role.npc, role.npc, 10040781, 0)
      cast_magic(role.npc, role.npc, 10040782, 0)
      thunderSprint3.base.onBegin(thunderSprint3)
    end
  end
  
  function skills.prickLoop.onEnd(prickLoop)
    if 1 == linkCheck then
      if 0 == link_prick_num then
        link_prick_num = link_prick_num + 1
        skills.prickLoop:deriveManual()
      else
        link_prick_num = 0
        role.skills.prickLoop:deriveAuto()
      end
    elseif 0 == linkCheck then
      role.skills.prickLoop:deriveAuto()
    end
  end
  
  function skills.prickLoopPro.onEnd(prickLoopPro)
    if 1 == linkCheck then
      if 0 == link_prick_num then
        link_prick_num = link_prick_num + 1
        prickLoopPro:deriveManual()
      else
        link_prick_num = 0
        prickLoopPro:deriveAuto()
      end
    elseif 0 == linkCheck then
      prickLoopPro:deriveAuto()
    end
  end
  
  function magics.magic_endPrick.onBegin()
    local atk = role.btns.atk
    local atkicon = role.icons.atk
    atk:setIcon(atkicon)
    role.core_skill_counting = 0
    abort_magic_by_id(role.npc, magicIds.magic_coreCamEffect)
    abort_magic_by_id(role.npc, magicIds.magic_coreCam)
    abort_magic_by_id(role.npc, 1004130)
    role.spBar:decrease(3)
  end
  
  do
    local function coreEnd(skill)
      local atk = role.btns.atk
      
      local atkicon = role.icons.atk
      atk:setIcon(atkicon)
      role.core_skill_counting = 0
      abort_magic_by_id(role.npc, magicIds.magic_coreCamEffect)
      abort_magic_by_id(role.npc, magicIds.magic_coreCam)
      abort_magic_by_id(role.npc, 1004130)
      role.spBar:decrease(3)
      skill.base.onBreak(skill)
    end
    
    skills.prickStart.onBreak = coreEnd
    skills.prickLoop.onBreak = coreEnd
    skills.prickLoopPro.onBreak = coreEnd
    skills.prickEnd.onBreak = coreEnd
    skills.prickEndPro.onBreak = coreEnd
  end
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      return 17
    else
      return 0
    end
  end
  
  do
    local function ult_passive(magic, casterNpc, target, damageSign, damageType, targetCamp, changeLv, magicLv)
      if check_magic(target, 1004088) then
        abort_magic_by_id(target, 1004088)
        
        if destinies1 then
          cast_magic(role.npc, role.npc, 1004130, 0)
        end
        if destinies5 then
          cast_magic(role.npc, target, 1004184, 0)
        end
        if role.core_skill_counting < 3 then
          role.core_skill_counting = role.core_skill_counting + 1
          role.spBarStatus(true, 1)
        end
        if ult_hitcount < 3 then
          ult_hitcount = ult_hitcount + 1
        end
        if sp_weaponActive and not check_magic(role.npc, 1004185) then
          local pos = get_npc_pos(target)
          cast_missile(role.npc, target, pos.x, pos.z, misLogics.sp_exmissile[1].id, 0)
          cast_missile(role.npc, target, pos.x, pos.z, misLogics.sp_exmissile[2].id, 0)
          cast_magic(role.npc, role.npc, 1004180, 0)
          cast_magic(role.npc, role.npc, 1004185, 0)
          role:doAfter(function(role)
            cast_magic(role.npc, role.npc, 1004179, 0)
          end, 0.35)
        end
      end
    end
    
    skills.ult.onHit = ult_passive
  end
  
  function Xin.spBarStatus(Status, num)
    if false == Status then
      role.spBar:decrease(10)
      local atk = role.btns.atk
      local atkicon = role.icons.atk
      atk:setIcon(atkicon)
      role.core_skill_counting = 0
      abort_magic_by_id(role.npc, magicIds.magic_coreCamEffect)
      abort_magic_by_id(role.npc, 1004130)
      return
    end
    if 1 == role.core_skill_counting or 2 == role.core_skill_counting or 3 == role.core_skill_counting then
      role.spBar:increase(num)
    end
    if role.spBar.num >= 3 then
      local atk = role.btns.atk
      local atkPro = role.icons.prick
      atk:setIcon(atkPro)
      cast_magic(role.npc, role.npc, magicIds.magic_coreCamEffect, 0)
    end
  end
  
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function tarces1(tarces1, casterNpc, hitTarget, hitType, skill, missile)
      local target_kind = get_role_kind(hitTarget)
      
      if 5 ~= target_kind then
        cast_magic(role.npc, hitTarget, 1004088, 0)
      end
    end
    
    skActs.atk4.onHit = tarces1
    skActs.counter.onHit = tarces1
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function BTbuffAdd()
      cast_magic(role.npc, role.npc, 1004131, 0)
      
      cast_magic(role.npc, role.npc, 1004132, 0)
    end
    
    tool.insert(skActs.prickStart, "onBegin", BTbuffAdd)
    
    local function BTbuffDel()
      abort_magic_by_id(role.npc, 1004131)
      abort_magic_by_id(role.npc, 1004132)
    end
    
    tool.insert(skActs.prickStart, "onEnd", BTbuffDel)
    tool.insert(skActs.prickStart, "onBreak", BTbuffDel)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function atkBuff()
      if 0 ~= ult_hitcount then
        print("destinies5", ult_hitcount)
        
        cast_magic(role.npc, role.npc, magicIds.magic_ultAtkBuff, ult_hitcount)
        ult_hitcount = 0
      end
    end
    
    tool.insert(skActs.ult, "onCastTime", atkBuff)
  end
  destinies[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    destinies1 = true
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function critBuff(role, npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
      if role.npc ~= npc then
        return
      end
      if is_crit and target ~= role.npc then
        cast_magic(role.npc, role.npc, magicIds.magic_thunderBuff, 0)
      end
    end
    
    tool.insert(role, "after_damage", critBuff)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function activeBuff()
      cast_magic(role.npc, role.npc, 1004023, 0)
    end
    
    local function activeBuffDel()
      abort_magic_by_id(role.npc, 1004023)
    end
    
    tool.insert(skActs.ult, "onBegin", activeBuff)
    tool.insert(skActs.ult, "onEnd", activeBuffDel)
    tool.insert(skActs.ult, "onBreak", activeBuffDel)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    skills.prickStart.derives.auto[1] = skills.prickLoopPro
    
    local function des4_buffAdd()
      cast_magic(role.npc, role.npc, 1004024, 0)
    end
    
    local function des4_buffDel()
      abort_magic_by_id(role.npc, 1004024)
    end
    
    tool.insert(skActs.prickStart, "onBegin", des4_buffAdd)
    tool.insert(skills.prickLoopPro, "onBreak", des4_buffDel)
    tool.insert(skills.prickLoopPro, "onEnd", des4_buffDel)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    destinies5 = true
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    sp_weaponActive = true
    
    local function spThunder(role, npc, target, magic_id)
      if 1004012 == magic_id and not check_magic(role.npc, 1004185) then
        local pos = get_npc_pos(target)
        cast_missile(role.npc, target, pos.x, pos.z, misLogics.sp_exmissile[1].id, 0)
        cast_missile(role.npc, target, pos.x, pos.z, misLogics.sp_exmissile[2].id, 0)
        cast_magic(role.npc, role.npc, 1004180, 0)
        cast_magic(role.npc, role.npc, 1004185, 0)
        role:doAfter(function(role)
          cast_magic(role.npc, role.npc, 1004179, 0)
        end, 0.35)
      end
    end
    
    tool.insert(role, "after_damage", spThunder)
  end
end

function Xin.before_damage(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
  role.base.before_damage(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
end

function Xin.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  if npc ~= role.npc then
    return
  end
  if not is_showup then
    abort_magic_by_id(role.npc, 1004083)
    abort_magic_by_id(role.npc, 1004130)
  elseif 3 == role.core_skill_counting and not check_magic(role.npc, 1004083) then
    cast_magic(role.npc, role.npc, 1004083, 0)
  end
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
end

return Xin
