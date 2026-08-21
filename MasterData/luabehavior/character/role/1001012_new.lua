local roleBase = import("character.base.role_base")
local Qing = Util.create_child_mt(roleBase)
local misIds = {}
local magicIds = {
  trace1_1_magic = 1012956,
  trace1_2_magic = 1012958,
  trace1_3_magic = 1012964,
  trace2_1_magic = 1012965,
  trace4_1_magic = 1012957,
  trace4_2_magic = 1012960,
  trace4_3_magic = 1012513,
  trace4_4_magic = 1012959,
  destinies1_1_magic = 1012294,
  destinies1_2_magic = 1012295,
  destinies2_1_magic = 1012331,
  destinies2_2_magic = 1012332,
  destinies2_3_magic = 1012333,
  destinies4_magic = 1012955
}

function Qing._init(role, npc)
  role.npc = npc
  local misIds_1 = {
    Skill_qte = 10010123322,
    skill2_2_damage = {10010120901, 10010120902},
    skill2_2_effect = {10010121202, 10010121203},
    skill3_2_damage = {10010121101},
    skill3_2_effect = {10010121205}
  }
  local magicIds_1 = {
    Skill2_2State = 1012001,
    Skill3_2State = 1012002,
    intensify = 1012509,
    spAtkDamage1 = 1012506,
    spAtkDamage2 = 1012523,
    spWeaponDamageFix = 1012292,
    spWeaponCritCount = 1012296,
    spWeaponCritFix = 1012297,
    des1_1 = 1012950,
    des1_2 = 1012951,
    des2_1 = 1012961,
    des2_2 = 1012962,
    des6 = 1012954
  }
  roleBase._init(role, misIds_1, magicIds_1)
  local traces = role.traces
  traces[1012940] = 1
  traces[1012941] = 2
  traces[1012942] = 3
  traces[1012943] = 4
  traces[1012944] = 5
  local destinies = role.destinies
  destinies[1012945] = 1
  destinies[1012946] = 2
  destinies[1012947] = 3
  destinies[1012948] = 4
  destinies[1012949] = 5
  local spWeapon = role.spWeapon
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  
  function skills.counter.startFrame(counter)
    return 6
  end
  
  skActs.spAtk.castCount = 0
  skActs.spAtk.atkBtn = btns.atk
  skActs.spAtk.atkIcon = icons.atk
  skActs.spAtk.activeCount = 0
  
  function skActs.spAtk.iconChange_1(spAtk)
    spAtk.atkBtn:setIcon(spAtk.atkIcon, 1)
  end
  
  function skActs.spAtk.iconChange_2(spAtk)
    if check_magic(role.npc, magicIds.trace2_1_magic) then
      if 1 == spAtk.castCount then
        spAtk.castCount = 0
        spAtk.atkBtn:setIcon(spAtk.atkIcon, 1)
        abort_magic_by_id(role.npc, magicIds.trace2_1_magic)
      else
        spAtk.castCount = spAtk.castCount + 1
      end
    else
      spAtk.atkBtn:setIcon(spAtk.atkIcon, 1)
    end
  end
  
  function skActs.spAtk.onBegin(spAtk)
    spAtk.base.onBegin(spAtk)
    local dis = get_npc_distance(role.npc, 1, role.target, false)
    if dis >= 2 and dis <= 6.5 then
      set_keyframe_enable_by_tag(role.npc, 100101213, 101, true, true)
    else
      set_keyframe_enable_by_tag(role.npc, 100101213, 101, false, true)
    end
  end
  
  function skActs.spAtk.onHit(spAtk)
  end
  
  function misLogics.Skill_qte.onBegin(Skill_qte, ultInst, owner, posX, posZ)
    role:change_follow_target(1, ultInst, {
      9999,
      0,
      {
        x = 0,
        y = 0,
        z = 0
      },
      1,
      10,
      0.1
    })
    role:doAfter(function()
      change_focus_follow_speed(1.8)
      role:change_follow_target(0)
    end, 1)
  end
  
  function skActs.skill02_1.onBegin(skill02_1)
    set_keyframe_enable_by_tag(role.npc, 0, 201, true, true)
    set_keyframe_enable_by_tag(role.npc, 0, 202, false, true)
    skill02_1.base.onBegin(skill02_1)
  end
  
  function skActs.skill02_1.onHit(skill02_1, casterNpc, hitTarget, hitType, skill, missile)
    local sk1 = btns.sk1
    local skill02_2 = icons.skill02_2
    cast_magic(role.npc, role.npc, magics.Skill2_2State.id, 1)
    sk1:setIcon(skill02_2)
  end
  
  icons.skill02_2.Skill2_2State = magics.Skill2_2State
  
  function magics.Skill2_2State.onEnd(Skill2_2State)
    local sk1 = btns.sk1
    local skill02_1 = icons.skill02_1
    sk1:setIcon(skill02_1)
  end
  
  function skActs.skill02_2.onBegin(skill02_2)
    local sk1 = btns.sk1
    local skill02_1 = icons.skill02_1
    skActs.skill02_2.firstHit = false
    set_keyframe_enable_by_tag(role.npc, 0, 201, false, true)
    set_keyframe_enable_by_tag(role.npc, 0, 202, true, true)
    sk1:setIcon(skill02_1)
    skill02_2.base.onBegin(skill02_2)
  end
  
  function skActs.skill02_2.onHit(skill02_2, casterNpc, hitTarget, hitType, skill, missile)
    local atk = btns.atk
    local spAtk = icons.spAtk
    atk:setIcon(spAtk)
  end
  
  function skActs.skill03_1.onBegin(skill03_1)
    set_keyframe_enable_by_tag(role.npc, 0, 301, true, true)
    set_keyframe_enable_by_tag(role.npc, 0, 302, false, true)
    set_keyframe_enable_by_tag(role.npc, 0, 402, false, true)
    skill03_1.base.onBegin(skill03_1)
  end
  
  function skActs.skill03_1.onHit(skill03_1, casterNpc, hitTarget, hitType, skill, missile)
    local sk2 = btns.sk2
    local skill03_2 = icons.skill03_2
    cast_magic(role.npc, role.npc, magics.Skill3_2State.id, 1)
    set_keyframe_enable_by_tag(role.npc, 0, 301, true, true)
    set_keyframe_enable_by_tag(role.npc, 0, 302, false, true)
    set_keyframe_enable_by_tag(role.npc, 0, 402, false, true)
    sk2:setIcon(skill03_2)
  end
  
  icons.skill03_2.Skill3_2State = magics.Skill3_2State
  
  function magics.Skill3_2State.onEnd(Skill3_2State)
    local sk2 = btns.sk2
    local skill03_1 = icons.skill03_1
    sk2:setIcon(skill03_1)
  end
  
  function skActs.skill03_2.onBegin(skill03_2)
    local sk2 = btns.sk2
    local skill03_1 = icons.skill03_1
    skActs.skill03_2.hitcount = 0
    skActs.skill03_2.firstHit = false
    set_keyframe_enable_by_tag(role.npc, 0, 301, false, true)
    set_keyframe_enable_by_tag(role.npc, 0, 302, true, false)
    sk2:setIcon(skill03_1)
    skill03_2.base.onBegin(skill03_2)
  end
  
  function skActs.skill03_2.onHit(skill03_2, casterNpc, hitTarget, hitType, skill, missile)
    local atk = btns.atk
    local spAtk = icons.spAtk
    atk:setIcon(spAtk)
    if 0 == skActs.skill03_2.hitcount then
      for k, v in pairs(misIds_1.skill3_2_damage) do
        if missile.missile_id == v then
          cast_missile(role.npc, nil, nil, nil, misIds_1.skill3_2_effect[k], 0)
          skActs.skill03_2.hitcount = skActs.skill03_2.hitcount + 1
        end
      end
    end
  end
  
  function skActs.skill03_2.onEnd(skill03_2)
    skActs.skill03_2.hitcount = 0
    skill03_2.base.onEnd(skill03_2)
  end
  
  function skills.ultStart.startFrame(ultStart)
    local skAct = ultStart.skAct
    if skAct:isUltFast() then
      return 10
    else
      return 0
    end
  end
  
  function skills.ultStart.onBegin(ultStart)
    local skAct = ultStart.skAct
    if skAct:isUltFast() then
      set_keyframe_enable_by_tag(role.npc, 100101233, 1, false, true)
      set_keyframe_enable_by_tag(role.npc, 100101233, 2, true, true)
    else
      set_keyframe_enable_by_tag(role.npc, 100101233, 2, false, true)
      set_keyframe_enable_by_tag(role.npc, 100101233, 1, true, true)
    end
  end
  
  traces[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(spAtk)
      set_keyframe_enable_by_tag(role.npc, 100101213, 1, true, true)
      
      set_keyframe_enable_by_tag(role.npc, 100101213, 2, false, true)
    end
    
    tool.insert(skActs.spAtk, "onBegin", damageFix)
    tool.insert(skActs.spAtk, "onBegin", skActs.spAtk.iconChange_1)
  end
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(spAtk)
      cast_magic(role.npc, role.npc, magicIds.trace1_1_magic, 1)
      
      cast_magic(role.npc, role.npc, magicIds.trace1_2_magic, 1)
      cast_magic(role.npc, role.npc, magicIds.trace1_3_magic, 1)
    end
    
    tool.insert(skActs.spAtk, "onBegin", damageFix)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(spAtk)
      set_keyframe_enable_by_tag(role.npc, 100101213, 1, false, true)
      
      set_keyframe_enable_by_tag(role.npc, 100101213, 2, true, true)
    end
    
    local function skill02_2_hit()
      if not skActs.skill02_2.firstHit then
        if not check_magic(role.npc, magicIds.trace2_1_magic) then
          if skActs.spAtk.activeCount > 0 then
            cast_magic(role.npc, role.npc, magicIds.trace2_1_magic, 0)
            skActs.spAtk.activeCount = 0
          else
            skActs.spAtk.activeCount = skActs.spAtk.activeCount + 1
          end
        end
        skActs.skill02_2.firstHit = true
      end
    end
    
    local function skill03_2_hit()
      if not skActs.skill03_2.firstHit then
        if not check_magic(role.npc, magicIds.trace2_1_magic) then
          if skActs.spAtk.activeCount > 0 then
            cast_magic(role.npc, role.npc, magicIds.trace2_1_magic, 0)
            skActs.spAtk.activeCount = 0
          else
            skActs.spAtk.activeCount = skActs.spAtk.activeCount + 1
          end
        end
        skActs.skill03_2.firstHit = true
      end
    end
    
    tool.insert(skActs.spAtk, "onBegin", damageFix)
    tool.remove(skActs.spAtk, "onBegin", skActs.spAtk.iconChange_1)
    tool.insert(skActs.spAtk, "onBegin", skActs.spAtk.iconChange_2)
    tool.insert(skActs.skill02_2, "onHit", skill02_2_hit)
    tool.insert(skActs.skill03_2, "onHit", skill03_2_hit)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    skActs.skill02_2.damageFix = magics.skill02_2DamageFix
    
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if magic_id == magics.intensify.id then
        cast_magic(role.npc, role.npc, magicIds.trace4_1_magic, 1)
      elseif 1012510 == magic_id then
        cast_magic(role.npc, role.npc, magicIds.trace4_2_magic, 1)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
    skActs.skill03_2.damageFix = magics.skill3_2DamageFix
    
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if magic_id == magicIds.trace4_3_magic then
        cast_magic(role.npc, role.npc, magicIds.trace4_4_magic, 1)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  destinies[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable_by_tag(role.npc, 0, 401, false, true)
    set_keyframe_enable_by_tag(role.npc, 0, 402, false, true)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(spAtk)
      cast_magic(role.npc, role.npc, magics.des1_1.id)
      
      cast_magic(role.npc, role.npc, magics.des1_2.id)
      local num = get_magic_num(role.npc, magics.des1_1.id)
      local effect_id = {
        magicIds.destinies1_1_magic,
        magicIds.destinies1_2_magic
      }
      cast_magic(role.npc, role.npc, effect_id[num], 0)
    end
    
    tool.insert(skActs.spAtk, "onBegin", damageFix)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      local level = get_magic_num(role.npc, magics.des1_1.id)
      
      if 1 == level and (magic_id == magicIds.destinies2_1_magic or magic_id == magicIds.destinies2_2_magic or magic_id == magicIds.destinies2_3_magic) then
        cast_magic(role.npc, role.npc, magics.des2_1.id, 1)
      elseif 2 == level and (magic_id == magicIds.destinies2_1_magic or magic_id == magicIds.destinies2_2_magic or magic_id == magicIds.destinies2_3_magic) then
        cast_magic(role.npc, role.npc, magics.des2_2.id, 1)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(skill02_2)
      set_keyframe_enable_by_tag(role.npc, 0, 401, true, true)
    end
    
    tool.insert(skActs.skill02_2, "onBegin", damageFix)
    
    local function damageFix(skill03_2)
      set_keyframe_enable_by_tag(role.npc, 0, 402, true, true)
    end
    
    tool.insert(skActs.skill03_2, "onBegin", damageFix)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if npc == role.npc and check_element_ab_state(target, 2) and (magic_id == magics.spAtkDamage1.id or magic_id == magics.spAtkDamage2.id) then
        cast_magic(role.npc, role.npc, magicIds.destinies4_magic, 1)
      end
    end
    
    role:insertFun("before_damage", damageFix)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(skill03_1)
      cast_magic(role.npc, role.npc, magics.des6.id, 1)
    end
    
    tool.insert(skActs.skill03_1, "onBegin", damageFix)
    
    local function damageFix(skill02_1)
      cast_magic(role.npc, role.npc, magics.des6.id, 1)
    end
    
    tool.insert(skActs.skill02_1, "onBegin", damageFix)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local MAGIC = {
      spAtk1 = magics.spAtkDamage1.id,
      spAtk2 = magics.spAtkDamage2.id,
      dmgFix = magics.spWeaponDamageFix.id,
      critBuff = magics.spWeaponCritFix.id,
      critStack = magics.spWeaponCritCount.id
    }
    skActs.spAtk.damageFix = magics.spAtk_1DamageFix
    
    local function beforeDamage(_, _, _, magic_id, _, _, _, _, magic_level)
      if magic_id == MAGIC.spAtk1 then
        cast_magic(role.npc, role.npc, MAGIC.dmgFix, spWeapon.lv)
      elseif magic_id == MAGIC.spAtk2 then
        local stack = get_magic_num(role.npc, MAGIC.critStack)
        abort_magic_by_id(role.npc, MAGIC.critStack)
        cast_magic(role.npc, role.npc, MAGIC.dmgFix, spWeapon.lv)
        if stack > 0 then
          cast_magic(role.npc, role.npc, MAGIC.critBuff)
        end
      end
    end
    
    tool.insert(role, "before_damage", beforeDamage)
    
    local function afterDamage(_, _, _, magic_id, _, _, is_crit)
      if magic_id == MAGIC.spAtk1 or magic_id == MAGIC.spAtk2 then
        if is_crit then
          abort_magic_by_id(role.npc, MAGIC.critStack)
        else
          abort_magic_by_id(role.npc, MAGIC.critStack)
          cast_magic(role.npc, role.npc, MAGIC.critStack)
        end
      end
    end
    
    tool.insert(role, "after_damage", afterDamage)
  end
end

function Qing.on_keyframe_action(role, kfId, npcTag, comnTag)
  local skills = role.skills
  if "turn" == npcTag then
    local tarPos, target = role:searchTarget(role.skAct.search)
    set_skill_target(role.npc, role.skAct.curSk.id, target, tarPos)
  end
end

function Qing.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  if npc ~= role.npc then
    return
  end
  if is_showup then
    local magics = role.magics
    local btns = role.btns
    local icons = role.icons
    local skActs = role.skActs
    local magic_list = {
      magics.spWeaponDamageFix,
      magics.spWeaponCritCount,
      magics.spWeaponCritFix,
      magics.des1_1,
      magics.des1_2,
      magics.des2_1,
      magics.des2_2,
      magics.des6
    }
    for key, value in pairs(magic_list) do
      abort_magic_by_id(role.npc, value.id)
    end
    if not role:isRampage() then
      btns.sk1:setIcon(icons.skill02_1)
      btns.sk2:setIcon(icons.skill03_1)
    end
    skActs.spAtk.activeCount = 0
  end
end

function Qing.onRampageStart(role, stage)
  local skill03_2 = role.skills.skill03_2
  local skill02_2_ult = role.icons.skill02_2_ult
  local skill03_2_ult = role.icons.skill03_2_ult
  local icons = role.icons
  local btns = role.btns
  local sk1 = btns.sk1
  local sk2 = btns.sk2
  local magics = role.magics
  local skActs = role.skActs
  local tool = role.tool
  role._originalSpAtkOnBegin = skActs.spAtk.onBegin
  role._originalSkill02_1OnHit = skActs.skill02_1.onHit
  role._originalSkill02_2OnBegin = skActs.skill02_2.onBegin
  role._originalSkill02_2OnHit = skActs.skill02_2.onHit
  role._originalSkill03_1OnHit = skActs.skill03_1.onHit
  role._originalSkill03_2OnBegin = skActs.skill03_2.onBegin
  role._originalSkill03_2OnHit = skActs.skill03_2.onHit
  role._originalSkill2_2StateOnEnd = magics.Skill2_2State.onEnd
  role._originalSkill3_2StateOnEnd = magics.Skill3_2State.onEnd
  skill03_2:ignoreCost()
  sk1:setIcon(skill02_2_ult)
  sk2:setIcon(skill03_2_ult)
  
  function skActs.skill02_1.onHit(skill02_1, casterNpc, hitTarget, hitType, skill, missile)
  end
  
  function skActs.skill02_2.onBegin(skill02_2)
    skill02_2.base.onBegin(skill02_2)
  end
  
  function skActs.skill02_2.onHit(skill02_2, casterNpc, hitTarget, hitType, skill, missile)
    local atk = btns.atk
    local spAtk = icons.spAtk
    cast_magic(role.npc, role.npc, magicIds.trace2_1_magic, 0)
    atk:setIcon(spAtk)
  end
  
  function skActs.skill03_1.onHit(skill03_1, casterNpc, hitTarget, hitType, skill, missile)
  end
  
  function skActs.skill03_2.onBegin(skill03_2)
    skill03_2.base.onBegin(skill03_2)
  end
  
  function skActs.skill03_2.onHit(skill03_2, casterNpc, hitTarget, hitType, skill, missile)
    local atk = btns.atk
    local spAtk = icons.spAtk
    local misIds_1 = {
      Skill_qte = 10010123322,
      skill2_2_damage = {10010120901, 10010120902},
      skill2_2_effect = {10010121202, 10010121203},
      skill3_2_damage = {10010121101},
      skill3_2_effect = {10010121205}
    }
    cast_magic(role.npc, role.npc, magicIds.trace2_1_magic, 0)
    atk:setIcon(spAtk)
    if 0 == skActs.skill03_2.hitcount then
      for k, v in pairs(misIds_1.skill3_2_damage) do
        if missile.missile_id == v then
          cast_missile(role.npc, nil, nil, nil, misIds_1.skill3_2_effect[k], 0)
          skActs.skill03_2.hitcount = skActs.skill03_2.hitcount + 1
        end
      end
    end
  end
  
  function skActs.spAtk.onBegin(spAtk)
    spAtk.base.onBegin(spAtk)
    local dis = get_npc_distance(role.npc, 1, role.target, false)
    if dis >= 2 and dis <= 6.5 then
      set_keyframe_enable_by_tag(role.npc, 100101213, 101, true, true)
    else
      set_keyframe_enable_by_tag(role.npc, 100101213, 101, false, true)
    end
  end
  
  function magics.Skill3_2State.onEnd(Skill3_2State)
  end
  
  function magics.Skill2_2State.onEnd(Skill2_2State)
  end
  
  for i = 0, role.traceLv do
    role.traces[i](role, role.tool, role.skills, role.skActs, role.icons, role.btns, role.misLogics, role.magics)
  end
  tool.remove(skActs.spAtk, "onBegin", skActs.spAtk.iconChange_1)
  tool.remove(skActs.spAtk, "onBegin", skActs.spAtk.iconChange_2)
  tool.insert(skActs.spAtk, "onBegin", skActs.spAtk.iconChange_2)
  for i = 0, role.destinyLv do
    role.destinies[i](role, role.tool, role.skills, role.skActs, role.icons, role.btns, role.misLogics, role.magics)
  end
  if role.spWeapon.lv > 0 then
    role.spWeapon.fun(role, role.tool, role.skills, role.skActs, role.icons, role.btns, role.misLogics, role.magics)
  end
end

function Qing.onRampageEnd(role, stage)
  local btns = role.btns
  local icons = role.icons
  local skActs = role.skActs
  local magics = role.magics
  role.skills.skill03_2:restoreCost()
  btns.sk1:setIcon(icons.skill02_1)
  btns.sk2:setIcon(icons.skill03_1)
  skActs.spAtk.onBegin = role._originalSpAtkOnBegin
  skActs.skill02_1.onHit = role._originalSkill02_1OnHit
  skActs.skill02_2.onBegin = role._originalSkill02_2OnBegin
  skActs.skill02_2.onHit = role._originalSkill02_2OnHit
  skActs.skill03_1.onHit = role._originalSkill03_1OnHit
  skActs.skill03_2.onBegin = role._originalSkill03_2OnBegin
  skActs.skill03_2.onHit = role._originalSkill03_2OnHit
  magics.Skill2_2State.onEnd = role._originalSkill2_2StateOnEnd
  magics.Skill3_2State.onEnd = role._originalSkill3_2StateOnEnd
end

return Qing
