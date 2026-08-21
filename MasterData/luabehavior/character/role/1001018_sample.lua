local roleBase = import("character.base.role_base")
local Enki = Util.create_child_mt(roleBase)
local misIds = {}
local magicIds = {
  camera_pull_magic = 1018961,
  trace1_1_magic = 1018120,
  trace1_2_magic = 1018951,
  destinies1_1 = 1018008,
  destinies1_2 = 1018007,
  destinies1_3 = 1018952,
  destinies2 = 1018953,
  destinies4_1 = 1018954,
  destinies4_2 = 1018955,
  destinies4_3 = 1018132,
  light_magic = 1018127
}

function Enki._init(role, npc)
  role.npc = npc
  local misIds_1 = {
    Skill2_1M = 10010181124,
    Skill3 = 10010181501,
    exQteJudge = 10010183501,
    fly_1 = 10010181105,
    flyback = 10010181139,
    fly_2 = 10010181140,
    flyback_2 = 10010181142,
    boom1 = 10010181126,
    boom2 = 10010181122,
    boomas4 = 10010181144,
    boomas4_ex = 10010181146,
    boom_explosion = 10010181143,
    boom_explosion_fast = 10010181145,
    boom_explosion_ult = 10010182634,
    boom_explosion_ult_fast = 10010182635,
    boom_explosion_enhance = 10010183428,
    boom_explosion_enhance_fast = 10010183429,
    ult_1M = 10010182801,
    ult_2M = 10010182802,
    ult_3M = 10010182803,
    ult_4M = 10010182804,
    ult_5M = 10010182805,
    ult_6M = 10010182812,
    ult_7M = 10010182813,
    ult_8M = 10010182814,
    ult_9M = 10010182815,
    ult_10M = 10010182816,
    ult_MM = 10010182612,
    ult_adsorb = 10010182811,
    spWeapon_extra_mis = 10010182901,
    destiny_extra_mis = 10010182903
  }
  local magicIds_1 = {
    Power_ball = 1018208,
    fly_Power_ball = 1018303,
    streakDamageFix = 1018952,
    adsorb = 1018308,
    tier = 1018962,
    clock_hand_damage = 1018013
  }
  local spBar = {false, false}
  roleBase._init(role, misIds_1, magicIds_1, spBar)
  local traces = role.traces
  traces[1018940] = 1
  traces[1018941] = 2
  traces[1018942] = 3
  traces[1018943] = 4
  traces[1018944] = 5
  local destinies = role.destinies
  destinies[1018945] = 1
  destinies[1018946] = 2
  destinies[1018947] = 3
  destinies[1018948] = 4
  destinies[1018949] = 5
  local spWeapon = role.spWeapon
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local boom_exp = misLogics.boom_explosion
  local tool = role.tool
  role.boom_exp_tag = 10
  
  function misLogics.Skill2_1M.onBegin(Skill2_1M, Skill2_1Inst, owner, posX, posZ)
    if role.missile ~= nil then
      stop_missile(role.missile)
    end
    role.missile = Skill2_1Inst
  end
  
  function magics.Power_ball.onBegin(Power_ball, casterNpc, target, magicId)
    local skill_lv = get_skill_lv(role.npc, 100101809) or 0
    local role_pos = get_npc_offset_position(role.npc, nil, 0, 1.4)
    abort_magic_by_id(role.npc, Power_ball)
    cast_missile(role.npc, nil, role_pos.x, role_pos.z, misLogics.Skill2_1M.id, skill_lv)
  end
  
  do
    local function boom_limit(mis, misInst, owner, posX, posZ)
      local boom_list = {
        misLogics.ult_1M.id,
        
        misLogics.ult_2M.id,
        misLogics.ult_3M.id,
        misLogics.ult_4M.id,
        misLogics.ult_5M.id,
        misLogics.ult_6M.id,
        misLogics.ult_7M.id,
        misLogics.ult_8M.id,
        misLogics.ult_9M.id,
        misLogics.ult_10M.id,
        misLogics.ult_adsorb.id
      }
      for index, value in ipairs(boom_list) do
        remove_missile_by_id(value, role.npc, true)
      end
    end
    
    local function boom_camera_change(mis, misInst, owner, posX, posZ)
      if get_come_on_hero() == role.npc then
        role:change_follow_target(1, misInst, {
          9999,
          0,
          {
            x = 0,
            y = 0,
            z = 100
          },
          1,
          10,
          0.1
        })
        role:doAfter(function()
          change_focus_follow_speed(1.8)
          role:change_follow_target(4)
        end, 1)
      end
    end
    
    function misLogics.boom_explosion.onBegin(mis, misInst, owner, posX, posZ)
      boom_limit()
    end
    
    function misLogics.boom_explosion_fast.onBegin(mis, misInst, owner, posX, posZ)
      boom_limit()
    end
    
    function misLogics.boom_explosion_ult.onBegin(mis, misInst, owner, posX, posZ)
      boom_limit()
    end
    
    function misLogics.boom_explosion_ult_fast.onBegin(mis, misInst, owner, posX, posZ)
      boom_limit()
    end
    
    function misLogics.boom_explosion_enhance.onBegin(mis, misInst, owner, posX, posZ)
      boom_limit()
    end
    
    function misLogics.boom_explosion_enhance_fast.onBegin(mis, misInst, owner, posX, posZ)
      boom_limit()
    end
    
    function misLogics.fly_1.onBegin(mis, misInst, owner, posX, posZ)
      boom_camera_change(mis, misInst, owner, posX, posZ)
    end
    
    function misLogics.fly_2.onBegin(mis, misInst, owner, posX, posZ)
      boom_camera_change(mis, misInst, owner, posX, posZ)
    end
    
    function misLogics.ult_1M.onBegin(mis, misInst, owner, posX, posZ)
      boom_camera_change(mis, misInst, owner, posX, posZ)
    end
    
    function misLogics.ult_6M.onBegin(mis, misInst, owner, posX, posZ)
      boom_camera_change(mis, misInst, owner, posX, posZ)
    end
  end
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      set_keyframe_enable_by_tag(role.npc, 100101826, 1, false, true)
      set_keyframe_enable_by_tag(role.npc, 100101826, 2, true, true)
      return 22
    else
      set_keyframe_enable_by_tag(role.npc, 100101826, 1, true, true)
      set_keyframe_enable_by_tag(role.npc, 100101826, 2, false, true)
      return 0
    end
  end
  
  function skills.qteEnhance.startFrame(qteEnhance)
    local act = qteEnhance.skAct
    local event = act and act.event
    if event and event.isSwitch then
      return 22
    else
      return 0
    end
  end
  
  function misLogics.fly_1.onEnd(fly_1, fly_1Inst, owner, posX, posZ)
    local role = fly_1.unit
    local misPos = get_missile_pos(fly_1Inst)
    cast_magic(role.npc, role.npc, magicIds.camera_pull_magic, 1)
    local rolePos = role.npc:get_pos_vec3()
    cast_missile(role.npc, nil, rolePos.x, rolePos.z, misLogics.flyback.id, 0, rolePos.x, rolePos.z, rolePos.y, rolePos.y, posX, posZ, misPos.y)
  end
  
  function misLogics.fly_2.onEnd(fly_2, fly_2Inst, owner, posX, posZ)
    local role = fly_2.unit
    cast_magic(role.npc, role.npc, magicIds.camera_pull_magic, 1)
    local misPos = get_missile_pos(fly_2Inst)
    local rolePos = role.npc:get_pos_vec3()
    cast_missile(role.npc, nil, rolePos.x, rolePos.z, misLogics.flyback.id, 0, rolePos.x, rolePos.z, rolePos.y, rolePos.y, posX, posZ, misPos.y)
  end
  
  role.missile_pos_list = {}
  role.missile_pos_list1 = {}
  role.missile_pos_list2 = {}
  
  function skActs.skill3_1.onBegin(skill3_1)
    role.missile_pos_list = {}
    role.missile_pos_list1 = {}
    role.missile_pos_list2 = {}
    role.skill3_pos = nil
    skill3_1.base.onBegin(skill3_1)
  end
  
  function misLogics.Skill3.onCollideMis(Skill3, Skill3_Inst, mis2, Skill3_Owner, mis2Owner)
    local m2Cfg = mis2.missile_cfg
    local m2Id = m2Cfg.Id
    local m1Cfg = Skill3_Inst.missile_cfg
    local m1Id = m1Cfg.Id
    if m2Id == misLogics.Skill2_1M.id then
      table.insert(role.missile_pos_list, get_missile_pos(mis2))
      remove_missile(mis2, true)
      remove_missile_by_id(misLogics.Skill3.id, role.npc, true)
    end
    if m2Id == misLogics.flyback.id then
      table.insert(role.missile_pos_list1, get_missile_pos(mis2))
      remove_missile(mis2, true)
      remove_missile_by_id(misLogics.Skill3.id, role.npc, true)
    end
    if m2Id == misLogics.flyback_2.id then
      table.insert(role.missile_pos_list2, get_missile_pos(mis2))
      remove_missile(mis2, true)
      remove_missile_by_id(misLogics.Skill3.id, role.npc, true)
    end
    local skill_lv = get_skill_lv(role.npc, 100101828) or 0
    magics.tier.bar = role.spBar
    local num = get_magic_num(role.npc, magics.tier.id)
    if num >= 1 then
      local skill_lv = get_skill_lv(role.npc, 100101828) or 0
      for _, missile_pos in pairs(role.missile_pos_list2) do
        if role.skill3_pos then
          cast_missile(role.npc, nil, missile_pos.x, missile_pos.z, boom_exp.id, skill_lv, role.skill3_pos.x, role.skill3_pos.z)
        else
          local pos = get_npc_offset_position(role.npc, nil, 0, 1)
          cast_magic(role.npc, role.npc, magicIds.camera_pull_magic, 1)
          abort_magic_by_id(role.npc, magics.tier.id)
          cast_missile(role.npc, nil, missile_pos.x, missile_pos.z, boom_exp.id, skill_lv, pos.x, pos.z)
        end
      end
      for _, missile_pos in pairs(role.missile_pos_list1) do
        if role.skill3_pos then
          cast_missile(role.npc, nil, missile_pos.x, missile_pos.z, boom_exp.id, skill_lv, role.skill3_pos.x, role.skill3_pos.z)
        else
          local pos = get_npc_offset_position(role.npc, nil, 0, 1)
          cast_magic(role.npc, role.npc, magicIds.camera_pull_magic, 1)
          cast_missile(role.npc, nil, missile_pos.x, missile_pos.z, boom_exp.id, skill_lv, pos.x, pos.z)
          abort_magic_by_id(role.npc, magics.tier.id)
        end
      end
      for _, missile_pos in pairs(role.missile_pos_list) do
        if role.skill3_pos then
          cast_missile(role.npc, nil, missile_pos.x, missile_pos.z, boom_exp.id, skill_lv, role.skill3_pos.x, role.skill3_pos.z)
        else
          local pos = get_npc_offset_position(role.npc, nil, 0, 1)
          cast_missile(role.npc, nil, missile_pos.x, missile_pos.z, boom_exp.id, skill_lv, pos.x, pos.z)
          abort_magic_by_id(role.npc, magics.tier.id)
          cast_magic(role.npc, role.npc, magicIds.camera_pull_magic, 1)
        end
      end
    else
      local skill_lv = get_skill_lv(role.npc, 100101828) or 0
      for _, missile_pos in pairs(role.missile_pos_list2) do
        if role.skill3_pos then
          cast_missile(role.npc, nil, missile_pos.x, missile_pos.z, misLogics.fly_2.id, skill_lv, role.skill3_pos.x, role.skill3_pos.z)
        else
          local pos = get_npc_offset_position(role.npc, nil, 0, 1)
          cast_magic(role.npc, role.npc, magicIds.camera_pull_magic, 1)
          cast_magic(role.npc, role.npc, magics.tier.id)
          cast_missile(role.npc, nil, missile_pos.x, missile_pos.z, misLogics.fly_2.id, skill_lv, pos.x, pos.z)
          role.spBar:increase()
        end
      end
      for _, missile_pos in pairs(role.missile_pos_list1) do
        if role.skill3_pos then
          cast_missile(role.npc, nil, missile_pos.x, missile_pos.z, misLogics.fly_2.id, skill_lv, role.skill3_pos.x, role.skill3_pos.z)
        else
          local pos = get_npc_offset_position(role.npc, nil, 0, 1)
          cast_magic(role.npc, role.npc, magicIds.camera_pull_magic, 1)
          cast_magic(role.npc, role.npc, magics.tier.id)
          cast_missile(role.npc, nil, missile_pos.x, missile_pos.z, misLogics.fly_2.id, skill_lv, pos.x, pos.z)
          role.spBar:increase()
        end
      end
      for _, missile_pos in pairs(role.missile_pos_list) do
        if role.skill3_pos then
          cast_missile(role.npc, nil, missile_pos.x, missile_pos.z, misLogics.fly_1.id, skill_lv, role.skill3_pos.x, role.skill3_pos.z)
        else
          local pos = get_npc_offset_position(role.npc, nil, 0, 1)
          cast_magic(role.npc, role.npc, magics.tier.id)
          cast_magic(role.npc, role.npc, magicIds.camera_pull_magic, 1)
          cast_missile(role.npc, nil, missile_pos.x, missile_pos.z, misLogics.fly_1.id, skill_lv, pos.x, pos.z)
          role.spBar:increase()
        end
      end
    end
    role.missile_pos_list = {}
    role.missile_pos_list1 = {}
    role.missile_pos_list2 = {}
    role.skill3_pos = nil
  end
  
  function magics.tier.onEnd(tier, castNpc, target, magicId)
    role.spBar:decrease()
  end
  
  skActs.exQte.tarPos = skActs.exQte.base.tarPos
  
  function misLogics.exQteJudge.onCollideMis(Skill3, Skill3_Inst, mis2, Skill3_Owner, mis2Owner)
    local m2Cfg = mis2.missile_cfg
    local m2Id = m2Cfg.Id
    local m1Cfg = Skill3_Inst.missile_cfg
    local m1Id = m1Cfg.Id
    if m2Id == misLogics.Skill2_1M.id then
      table.insert(role.missile_pos_list, get_missile_pos(mis2))
      remove_missile(mis2, true)
      remove_missile_by_id(misLogics.exQteJudge.id, role.npc, true)
    end
    if m2Id == misLogics.flyback.id then
      table.insert(role.missile_pos_list1, get_missile_pos(mis2))
      remove_missile(mis2, true)
      remove_missile_by_id(misLogics.Skill3.id, role.npc, true)
    end
    if m2Id == misLogics.flyback_2.id then
      table.insert(role.missile_pos_list2, get_missile_pos(mis2))
      remove_missile(mis2, true)
      remove_missile_by_id(misLogics.Skill3.id, role.npc, true)
    end
    magics.tier.bar = role.spBar
    local skill_lv = get_skill_lv(role.npc, 100101828) or 0
    for _, missile_pos in pairs(role.missile_pos_list) do
      print("进来了508")
      if role.skill3_pos then
        cast_missile(role.npc, nil, missile_pos.x, missile_pos.z, boom_exp.id, skill_lv, role.skill3_pos.x, role.skill3_pos.z)
      else
        local pos = get_npc_offset_position(role.npc, nil, 0, 1)
        cast_missile(role.npc, nil, missile_pos.x, missile_pos.z, boom_exp.id, skill_lv, pos.x, pos.z)
        abort_magic_by_id(role.npc, magics.tier.id)
        cast_magic(role.npc, role.npc, magicIds.camera_pull_magic, 1)
      end
    end
    role.missile_pos_list = {}
    role.skill3_pos = nil
  end
  
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if magic_id == magicIds.trace1_1_magic then
        cast_magic(role.npc, role.npc, magicIds.trace1_2_magic, 1)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    function misLogics.boomas4.onBegin(boomas4, boomas4Inst, owner, posX, posZ)
      cast_missile(role.npc, nil, posX, posZ, misLogics.ult_adsorb.id, 0)
    end
    
    function misLogics.boomas4_ex.onBegin(boomas4, boomas4Inst, owner, posX, posZ)
      cast_missile(role.npc, nil, posX, posZ, misLogics.ult_adsorb.id, 0)
    end
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function misTimeChange(mis, misInst, owner, posX, posZ)
      local boom_list = {
        misLogics.ult_1M.id,
        
        misLogics.ult_2M.id,
        misLogics.ult_3M.id,
        misLogics.ult_4M.id,
        misLogics.ult_5M.id,
        misLogics.ult_6M.id,
        misLogics.ult_7M.id,
        misLogics.ult_8M.id,
        misLogics.ult_9M.id,
        misLogics.ult_10M.id,
        misLogics.ult_adsorb.id
      }
      for index, value in ipairs(boom_list) do
        change_missile_config(value, "LiveTime", 5, 1)
      end
    end
    
    role.boom_exp_tag = 11
    tool.insert(misLogics.boom_explosion, "onBegin", misTimeChange)
    tool.insert(misLogics.boom_explosion_fast, "onBegin", misTimeChange)
  end
  destinies[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable_by_tag(role.npc, 0, 10, false, true)
    set_keyframe_enable_by_tag(role.npc, 0, 11, false, true)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    skActs.skill2_1.damageFix = magics.skill2_1DamageFix
    
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if magic_id == magicIds.destinies1_1 then
        cast_magic(role.npc, role.npc, magicIds.destinies1_3, 1)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
    skActs.skill3_1.damageFix = magics.skill3_1DamageFix
    
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if magic_id == magicIds.destinies1_2 then
        cast_magic(role.npc, role.npc, magicIds.destinies1_3, 1)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function boom1DamageFix(boom1, boomInst, casterNpc, hitTagrget, hitTYPE, skill)
      cast_magic(role.npc, hitTagrget, magicIds.destinies2)
    end
    
    tool.insert(misLogics.boom1, "onHit", boom1DamageFix)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    boom_exp = misLogics.boom_explosion_fast
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if magic_id == magicIds.trace1_1_magic then
        cast_magic(role.npc, role.npc, magicIds.destinies4_1, 1)
      end
      if magic_id == magicIds.destinies4_3 then
        cast_magic(role.npc, role.npc, magicIds.destinies4_2, 1)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    function misLogics.ult_1M.onEnd(ult_1M, ult_1MInst, owner, posX, posZ)
      cast_missile(role.npc, nil, posX, posZ, misLogics.destiny_extra_mis.id, 0)
    end
    
    function misLogics.ult_6M.onEnd(ult_6M, ult_6MInst, owner, posX, posZ)
      cast_missile(role.npc, nil, posX, posZ, misLogics.destiny_extra_mis.id, 0)
    end
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      local lv = role.spWeapon.lv
      
      if magic_id == magics.clock_hand_damage.id then
        local pos = get_npc_pos(target)
        cast_missile(role.npc, nil, pos.x, pos.z, misLogics.spWeapon_extra_mis.id, lv)
      end
    end
    
    tool.insert(role, "after_damage", damageFix)
  end
end

function Enki.onRampageStart(role)
  local qteEnhance = role.skills.qteEnhance
  local tool = role.tool
  qteEnhance:ignoreCost()
  local skills = role.skills
  local misLogics = role.misLogics
  local sk2 = role.btns.sk2
  sk2:setIcon(role.icons.exQte)
end

function Enki.onRampageEnd(role, stage)
  local qteEnhance = role.skills.qteEnhance
  local tool = role.tool
  local misLogics = role.misLogics
  qteEnhance:restoreCost()
  local skills = role.skills
  set_keyframe_enable_by_tag(role.npc, 0, role.boom_exp_tag, false, true)
  local sk2 = role.btns.sk2
  sk2:setIcon(role.icons.skill3_1)
end

function Enki.onLinkChange(role, newStage, oldStage)
  if 2 ~= newStage then
    return
  end
  local skills = role.skills
  set_keyframe_enable_by_tag(role.npc, 0, role.boom_exp_tag, true, true)
end

function Enki.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  local misLogics = role.misLogics
  if npc ~= role.npc then
    return
  end
  if not is_showup then
    remove_missile_by_id(misLogics.Skill2_1M.id, role.npc, true)
    abort_magic_by_id(role.npc, magicIds.camera_pull_magic)
  else
    cast_magic(role.npc, role.npc, magicIds.light_magic, 0)
  end
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
end

return Enki
