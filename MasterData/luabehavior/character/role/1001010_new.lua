local roleBase = import("character.base.role_base")
local Asti = Util.create_child_mt(roleBase)
local misIds = {}
local magicIds = {
  trace1_magic = 1010828,
  trace1_max_magic = 1010846,
  trace4_magic = 1010839,
  destinies1_magic = 1010829,
  destinies3_magic = 1010843,
  destinies4_magic = 1010838,
  sp_weapon_damage_magic = 1010026,
  sp_weapon_damage_fix_magic = 1010853
}

function Asti._init(role, npc)
  role.npc = npc
  local misIds_1 = {
    Skill_qte = 10010108219,
    skill03_1 = 10010103109,
    skill03_2 = 10010103208,
    skill02_1 = 10010104114,
    skill02_2 = 10010104118,
    HP_BOOM = 10010103214,
    HP_BOOM_healing = 10010103216,
    skill02_3 = 10010104116,
    skill02_4 = 10010104119,
    rain_region = 10010109520,
    rain_region_fx = 10010109522,
    sp_rain_region = 10010109523,
    sp_rain_region_fx = 10010109524,
    ult_final_mis = 10010108228,
    skill02_5 = 10010104120,
    skill03_2_dmg_mis = 10010103201
  }
  local magicIds_1 = {
    umbrella_up = 1010840,
    skill03_1Derive = 1010817,
    HP_continue = 1010830,
    time_hp = 1010836,
    time_hp1 = 1010837,
    umbrella_BOOM = 1010851,
    power_reset = 1010022,
    region_heal = 1010844,
    sp_region_heal = 1010845,
    umb_castregion = 1010028,
    healing_magic = 1010954,
    healing_magic_ex = 10109541
  }
  roleBase._init(role, misIds_1, magicIds_1)
  local traces = role.traces
  traces[1010818] = 1
  traces[1010819] = 2
  traces[1010820] = 3
  traces[1010821] = 4
  traces[1010822] = 5
  local destinies = role.destinies
  destinies[1010823] = 1
  destinies[1010824] = 2
  destinies[1010825] = 3
  destinies[1010826] = 4
  destinies[1010827] = 5
  local spWeapon = role.spWeapon
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local tool = role.tool
  role.rain_region = misLogics.rain_region
  role.rain_region_fx = misLogics.rain_region_fx
  role.rain_region_mis_list = {}
  role.rain_region_fx_mis_list = {}
  role.region_heal = magics.region_heal
  
  local function add_missile_to_list(missile_list, missile)
    table.insert(missile_list, missile)
    if #missile_list > 2 then
      local oldest_missile = missile_list[1]
      table.remove(missile_list, 1)
      remove_missile(oldest_missile, true)
    end
  end
  
  local function remove_missile_from_list(missile_list, missile)
    for i, m in pairs(missile_list) do
      if m == missile then
        table.remove(missile_list, i)
        break
      end
    end
  end
  
  local function setup_rain_region_logic(rain_region, rain_region_fx)
    function rain_region.onBegin(rain_region, rain_regionInst, casterNpc, target, magicId)
      add_missile_to_list(role.rain_region_mis_list, rain_regionInst)
    end
    
    function rain_region_fx.onBegin(rain_region_fx, rain_region_fxInst, casterNpc, target, magicId)
      add_missile_to_list(role.rain_region_fx_mis_list, rain_region_fxInst)
    end
    
    function rain_region.onEnd(rain_region, rain_regionInst, casterNpc, target, magicId)
      remove_missile_from_list(role.rain_region_mis_list, rain_regionInst)
    end
    
    function rain_region_fx.onEnd(rain_region_fx, rain_region_fxInst, casterNpc, target, magicId)
      remove_missile_from_list(role.rain_region_fx_mis_list, rain_region_fxInst)
    end
  end
  
  setup_rain_region_logic(role.rain_region, role.rain_region_fx)
  
  function misLogics.Skill_qte.onBegin(Skill_qte, ultInst, owner, posX, posZ)
    role:change_follow_target(1, ultInst, {
      9999,
      0,
      {
        x = 0,
        y = 0,
        z = 150
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
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      return 8
    else
      return 0
    end
  end
  
  function misLogics.ult_final_mis.onEnd(ult_final_mis, ult_final_misInst, owner, posX, posZ)
    local stage = role:getLinkStage()
    if stage >= 2 then
      cast_missile(role.npc, nil, posX, posZ, role.rain_region.id, 0)
      cast_missile(role.npc, nil, posX, posZ, role.rain_region_fx.id, 0)
    end
  end
  
  function skills.skill02_1.onBegin(skill02_1)
    local x, z = get_indicator_pos(role.btns.sk1.id)
    local info = role.skills.skill02_1:skInfo()
    cast_missile3(role.npc, nil, x, z, misLogics.skill02_2.id, 0, nil, nil, nil, nil, nil, nil, nil, info)
  end
  
  do
    local function umb_add(mis, misInst, owner, posX, posZ)
      local role = mis.unit
      
      role.umb:add(misInst)
    end
    
    local function umb_remove(mis, misInst, owner, posX, posZ)
      local role = mis.unit
      role.umb:remove(misInst)
    end
    
    local function umb_stop(mis, misInst, mis2, skill02_1_Owner, mis2Owner)
      local m2Cfg = mis2.missile_cfg
      local m2Id = m2Cfg.Id
      local m1Cfg = misInst.missile_cfg
      local m1Id = m1Cfg.Id
      if m2Id == misLogics.skill02_2.id then
        local skact1 = get_missile_skill_action_info(misInst)
        local skact2 = get_missile_skill_action_info(mis2)
        if misInst.isStopped then
        elseif not skact1 or not skact2 then
        elseif skact1.skAct == skact2.skAct and skact1.castId == skact2.castId then
          change_missile_move_params(misInst, {
            0,
            0,
            0,
            0
          }, {0, 0})
          misInst.isStopped = true
          remove_missile(mis2, true)
        end
      end
      if m2Id == misLogics.skill03_1.id or m2Id == misLogics.skill03_2.id then
        cast_magic(role.npc, role.npc, magics.umbrella_BOOM.id, 0)
      end
    end
    
    misLogics.skill02_1.onBegin = umb_add
    misLogics.skill02_5.onBegin = umb_add
    misLogics.skill02_1.onEnd = umb_remove
    misLogics.skill02_5.onEnd = umb_remove
    misLogics.skill02_1.onCollideMis = umb_stop
    misLogics.skill02_5.onCollideMis = umb_stop
  end
  skActs.exQte.tarPos = skActs.exQte.base.tarPos
  
  function skActs.exQte.onHit(exQte, casterNpc, hitTarget, hitType, skill, missile)
    local pos = get_npc_pos(hitTarget)
    if pos then
      cast_missile(role.npc, nil, pos.x, pos.z, role.rain_region.id, 0)
      cast_missile(role.npc, nil, pos.x, pos.z, role.rain_region_fx.id, 0)
    else
      cast_missile(role.npc, role.npc, nil, nil, role.rain_region.id, 0)
      cast_missile(role.npc, role.npc, nil, nil, role.rain_region_fx.id, 0)
    end
  end
  
  do
    local umb = {}
    role.umb = umb
    umb.max = 2
    umb.role = role
    umb.list = {}
    umb.removeList = {}
    
    function umb.add(umb, mis)
      local list = umb.list
      table.insert(list, 1, mis)
      if #list > umb.max then
        for i = #list, umb.max + 1, -1 do
          remove_missile(list[i])
        end
      end
      if not check_magic(role.npc, magics.umb_castregion.id) then
        cast_magic(role.npc, role.npc, magics.umb_castregion.id)
      end
    end
    
    function umb.remove(umb, mis)
      local pos
      for i, usbInst in ipairs(umb.list) do
        if usbInst == mis then
          pos = i
        end
      end
      if not pos then
        Log.Error("Asti.umb.remove is called but nothing is found")
      else
        local target = table.remove(umb.list, pos)
      end
      if 0 == #role.umb.list then
        abort_magic_by_id(role.npc, magics.umb_castregion.id)
      end
    end
    
    function umb.removeAll(umb)
      local removeList = umb.removeList
      for key, mis in pairs(umb.list) do
        removeList[key] = mis
      end
      for key, mis in pairs(removeList) do
        removeList[key] = nil
        remove_missile(mis, true)
      end
      abort_magic_by_id(role.npc, magics.umb_castregion.id)
    end
    
    umb.search = skActs.skill03_1.search
    
    function umb.choose(umb)
      local minDist = 999
      local minAngle = 999
      local minAngleMis, minDistMis
      local role = umb.role
      local rolePos = get_npc_pos(role.npc)
      local inputPos = get_joystick_target_pos(role.npc)
      local search = umb.search
      for _, mis in ipairs(umb.list) do
        local misPos = get_missile_pos(mis)
        local dist = get_npc_distance(role.npc, 2, misPos.x, misPos.z, true)
        local angle = math.abs(tool.getPosAngle(rolePos, inputPos, misPos))
        if minDist > dist then
          minDist = dist
          minDistMis = mis
        end
        if angle < search.secAngle and dist < search.secRadius and minAngle > angle then
          minAngle = angle
          minAngleMis = mis
        end
      end
      return minAngleMis or minDistMis
    end
  end
  icons.skill03_1.umb = role.umb
  icons.skill03_1.maxDis = 6
  
  function icons.skill03_1.updateEnable(skill03_1)
    skill03_1.base.updateEnable(skill03_1)
    if skill03_1.isEnable then
      local umbCheck = false
      local role = skill03_1.role
      local list = skill03_1.umb.list
      local maxDis = skill03_1.maxDis
      for _, mis in pairs(list) do
        local pos = get_missile_pos(mis)
        if maxDis > get_npc_distance(role.npc, 2, pos.x, pos.z, true) and not umbCheck then
          umbCheck = true
          break
        end
      end
      skill03_1.isEnable = umbCheck
    end
  end
  
  skActs.skill03_1.umb = role.umb
  
  function skActs.skill03_1.tarPos(act, event)
    act.tarUmb = act.umb:choose()
    if not act.tarUmb then
    else
      return get_missile_pos(act.tarUmb)
    end
  end
  
  function skills.skill03_1.target(skill03_1)
    return nil
  end
  
  function skills.skill03_1.tarPos(skill03_1)
    return get_missile_pos(skill03_1.skAct.tarUmb)
  end
  
  do
    local function skill03_2_active()
      local sk2 = role.btns.sk2
      
      local skill03_2 = role.icons.skill03_2
      if "skill03_2" ~= sk2.icon.name and get_npc_attr(role.npc, 74) >= 100 then
        sk2:setIcon(skill03_2)
      end
    end
    
    role:insertFun("on_frame", skill03_2_active)
    icons.skill03_2.umb = role.umb
    icons.skill03_2.maxDis = 6
    
    function icons.skill03_2.updateEnable(skill03_2)
      skill03_2.base.updateEnable(skill03_2)
      if skill03_2.isEnable then
        local umbCheck = false
        local role = skill03_2.role
        local list = skill03_2.umb.list
        local maxDis = skill03_2.maxDis
        for _, mis in pairs(list) do
          local pos = get_missile_pos(mis)
          if maxDis > get_npc_distance(role.npc, 2, pos.x, pos.z, true) and not umbCheck then
            umbCheck = true
            break
          end
        end
        skill03_2.isEnable = umbCheck
      end
    end
    
    skActs.skill03_2.umb = role.umb
    
    function skActs.skill03_2.tarPos(act, event)
      local stage = role:getLinkStage()
      if 4 ~= stage then
        act.tarUmb = act.umb:choose()
        if not act.tarUmb then
          Log.Error("Asti.skill03-1 is started but umbrella is lost")
        else
          return get_missile_pos(act.tarUmb)
        end
      else
        return act.base.tarPos(act, event)
      end
    end
    
    function skills.skill03_2.target(skill03_2)
      return nil
    end
    
    function skills.skill03_2.tarPos(skill03_2, skAct)
      local stage = role:getLinkStage()
      if 4 ~= stage then
        return get_missile_pos(skill03_2.skAct.tarUmb)
      else
        return skill03_2.base.tarPos(skill03_2, skAct)
      end
    end
    
    function role.rain_region.onHit(rain_region, rain_regionInst, casterNpc, hitTagrget, hitTYPE, skill)
      cast_magic(role.npc, hitTagrget, role.region_heal.id, 0)
    end
  end
  magics.umbrella_BOOM.umb = role.umb
  
  function magics.umbrella_BOOM.changeIconDefault(umbrella_BOOM)
    local btns, icons = role.btns, role.icons
    btns.sk2:setIcon(icons.skill03_1)
  end
  
  magics.umbrella_BOOM.changeIcon = magics.umbrella_BOOM.changeIconDefault
  
  function magics.umbrella_BOOM.onBegin(umbrella_BOOM, casterNpc, target, magicId)
    local list = umbrella_BOOM.umb.list
    local skill03_1 = role.icons.skill03_1
    local sk2 = role.btns.sk2
    local healing_magic = magics.healing_magic
    for _, mis in pairs(list) do
      local pos = get_missile_pos(mis)
      cast_missile3(role.npc, nil, pos.x, pos.z, misLogics.HP_BOOM.id, 0)
      cast_missile3(role.npc, nil, pos.x, pos.z, misLogics.HP_BOOM_healing.id, 0)
      if role.skAct.name == "skill03_2" then
        cast_missile(role.npc, nil, pos.x, pos.z, role.rain_region.id, 0)
        cast_missile(role.npc, nil, pos.x, pos.z, role.rain_region_fx.id, 0)
        cast_magic(role.npc, role.npc, magics.power_reset.id, 1)
        umbrella_BOOM:changeIcon()
        healing_magic = magics.healing_magic_ex
      else
        healing_magic = magics.healing_magic
      end
      local team = {
        get_scene_hero_by_poskey(21),
        get_scene_hero_by_poskey(22),
        get_come_on_hero()
      }
      for key, value in pairs(team) do
        cast_magic(role.npc, value, healing_magic.id, 0)
      end
    end
    umbrella_BOOM.umb:removeAll()
  end
  
  function magics.umbrella_up.onBegin(umbrella_up, casterNpc, target, magicId)
    abort_magic_by_id(role.npc, umbrella_up)
    local x, z = get_indicator_pos(role.btns.sk2.id)
    cast_missile3(role.npc, nil, x, z, misLogics.skill02_1.id, 0, nil, nil, nil, nil, nil, nil, nil, role.skills.skill02_1:skInfo())
  end
  
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function add_buff(rain_region, rain_regionInst, casterNpc, hitTagrget, hitTYPE, skill)
      local npc = role.npc
      
      local hp_max = get_npc_attr(npc, 4)
      if hp_max / 1000 < 30 then
        role.tool:castMagicToTeam(magicIds.trace1_magic, 0, npc)
      else
        role.tool:castMagicToTeam(magicIds.trace1_max_magic, 0, npc)
      end
    end
    
    tool.insert(role.rain_region, "onHit", add_buff)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.region_heal = magics.sp_region_heal
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function HP_BOOMDamageFix(HP_BOOM, HP_BOOMInst, casterNpc, hitTagrget, hitTYPE, skill)
      cast_magic(role.npc, role.npc, magicIds.trace4_magic, 0)
    end
    
    tool.insert(misLogics.HP_BOOM, "onHit", HP_BOOMDamageFix)
  end
  destinies[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    cast_magic(role.npc, role.npc, magicIds.destinies1_magic, 0)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function HP_BOOMDamageFix(HP_BOOM, HP_BOOMInst, casterNpc, hitTagrget, hitTYPE, skill)
      cast_magic(role.npc, role.npc, magics.time_hp.id, 0)
    end
    
    tool.insert(misLogics.HP_BOOM, "onBegin", HP_BOOMDamageFix)
    
    function magics.time_hp.onBegin(stance, casterNpc, target)
      role.time = get_npc_time(role.npc) + 0.1
    end
    
    function magics.time_hp.tick(time_hp)
      if get_npc_time(role.npc) >= role.time then
        role.time = role.time + 1
        local team = {
          get_scene_hero_by_poskey(21),
          get_scene_hero_by_poskey(22),
          get_come_on_hero()
        }
        for key, value in pairs(team) do
          cast_magic(role.npc, value, magics.HP_continue.id, 0)
        end
      end
    end
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    function magics.time_hp.onBegin(time_hp)
      local team = {
        get_scene_hero_by_poskey(21),
        
        get_scene_hero_by_poskey(22),
        get_come_on_hero()
      }
      for key, value in pairs(team) do
        cast_magic(role.npc, value, magicIds.destinies3_magic, 0)
      end
      role.time = get_npc_time(role.npc) + 0.1
    end
    
    function magics.time_hp.onEnd(time_hp)
      local team = {
        get_scene_hero_by_poskey(21),
        get_scene_hero_by_poskey(22),
        get_come_on_hero()
      }
      for key, value in pairs(team) do
        abort_magic_by_id(value, magicIds.destinies3_magic)
      end
    end
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function HP_BOOMDamageFix(HP_BOOM, HP_BOOMInst, casterNpc, hitTagrget, hitTYPE, skill)
      cast_magic(role.npc, role.npc, magics.time_hp1.id, 0)
    end
    
    tool.insert(misLogics.HP_BOOM, "onBegin", HP_BOOMDamageFix)
    
    function magics.time_hp1.onBegin(time_hp1, casterNpc, target)
      abort_magic_by_id(role.npc, magics.time_hp1.id, 1)
      local team = {
        get_scene_hero_by_poskey(21),
        get_scene_hero_by_poskey(22),
        get_come_on_hero()
      }
      for key, value in pairs(team) do
        abort_magic_by_id(value, magicIds.destinies3_magic, 1)
        cast_magic(role.npc, value, magicIds.destinies4_magic, 0)
      end
      role.time = get_npc_time(role.npc) + 0.1
    end
    
    function magics.time_hp1.tick(time_hp1)
      if get_npc_time(role.npc) >= role.time then
        role.time = role.time + 1
        local team = {
          get_scene_hero_by_poskey(21),
          get_scene_hero_by_poskey(22),
          get_come_on_hero()
        }
        for key, value in pairs(team) do
          cast_magic(role.npc, value, magics.HP_continue.id, 0)
        end
      end
    end
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local stack = role.rain_region.onHit
    role.rain_region = misLogics.sp_rain_region
    role.rain_region_fx = misLogics.sp_rain_region_fx
    role.rain_region.onHit = stack
    setup_rain_region_logic(role.rain_region, role.rain_region_fx)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if magic_id == magicIds.sp_weapon_damage_magic then
        cast_magic(role.npc, role.npc, magicIds.sp_weapon_damage_fix_magic, role.spWeapon.lv)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
    
    local function umbrella_up_add(umbrella_up, casterNpc, target, magicId)
      abort_magic_by_id(role.npc, umbrella_up)
      local tar_list = search_npc(role.npc, 4, 8, nil, false, true)
      local condition = false
      for i = 1, #tar_list do
        if tar_list[i] ~= role.target then
          condition = true
          local pos = get_npc_pos(tar_list[i])
          cast_missile3(role.npc, nil, pos.x, pos.z, misLogics.skill02_3.id, 0, nil, nil, nil, nil, nil, nil, nil, role.skills.skill02_1:skInfo())
          cast_missile3(role.npc, nil, pos.x, pos.z, misLogics.skill02_4.id, 0, nil, nil, nil, nil, nil, nil, nil, role.skills.skill02_1:skInfo())
          break
        end
      end
      if not condition then
        local role_pos = get_npc_pos(role.npc)
        local param = role_pos:Distance(role.btns.sk1:indiPos())
        local pos = get_npc_offset_position(role.npc, role.btns.sk1:indiPos(), math.random(60, 120), param + 0.5)
        cast_missile3(role.npc, nil, pos.x, pos.z, misLogics.skill02_3.id, 0, nil, nil, nil, nil, nil, nil, nil, role.skills.skill02_1:skInfo())
        cast_missile3(role.npc, nil, pos.x, pos.z, misLogics.skill02_4.id, 0, nil, nil, nil, nil, nil, nil, nil, role.skills.skill02_1:skInfo())
      end
    end
    
    tool.insert(magics.umbrella_up, "onBegin", umbrella_up_add)
    
    function misLogics.skill02_3.onBegin(skill02_3, misInst, owner, posX, posZ)
      local role = skill02_3.unit
      role.umb:add(misInst)
    end
    
    function misLogics.skill02_3.onEnd(skill02_3, misInst, owner, posX, posZ)
      local role = skill02_3.unit
      role.umb:remove(misInst)
    end
    
    function misLogics.skill02_3.onCollideMis(skill02_3, skill02_3_Inst, mis2, skill02_1_Owner, mis2Owner)
      local m2Cfg = mis2.missile_cfg
      local m2Id = m2Cfg.Id
      local m1Cfg = skill02_3_Inst.missile_cfg
      local m1Id = m1Cfg.Id
      local role = skill02_3.unit
      if m2Id == misLogics.skill03_1.id or m2Id == misLogics.skill03_2.id then
        cast_magic(role.npc, role.npc, magics.umbrella_BOOM.id, 0)
      end
      if m2Id == misLogics.skill02_4.id then
        local skact1 = get_missile_skill_action_info(skill02_3_Inst)
        local skact2 = get_missile_skill_action_info(mis2)
        if skill02_3_Inst.isStopped then
        elseif not skact1 or not skact2 then
        elseif skact1.skAct == skact2.skAct and skact1.castId == skact2.castId then
          change_missile_move_params(skill02_3_Inst, {
            0,
            0,
            0,
            0
          }, {0, 0})
          skill02_3_Inst.isStopped = true
          remove_missile(mis2, true)
        end
      end
    end
  end
end

function Asti.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  local misLogics = role.misLogics
  if npc ~= role.npc then
    return
  end
  if not is_showup then
    remove_missile_by_id(misLogics.skill02_1.id, role.npc, true)
    remove_missile_by_id(misLogics.skill02_3.id, role.npc, true)
    remove_missile_by_id(misLogics.skill02_4.id, role.npc, true)
  end
end

function Asti.on_frame_background(role)
  role.base.on_frame_background(role)
  local curMagics = role.curMagics
  local removeMagics = role.removeMagics
  for magicName, magic in pairs(curMagics) do
    local tickFun = magic.tick
    if not removeMagics[magicName] and tickFun then
      tickFun(magic)
    end
  end
  for magicName, _ in pairs(role.removeMagics) do
    removeMagics[magicName] = nil
    curMagics[magicName] = nil
  end
end

local function umbrella_boom_add(umbrella_boom_add, casterNpc, target, magicId)
  local role = umbrella_boom_add.unit
  local misLogics = role.misLogics
  local tar_list = search_npc(role.npc, 4, 6, nil, false, true)
  local condition = false
  role:doAfter(function()
    if tar_list then
      for i = 1, #tar_list do
        if tar_list[i] ~= role.target then
          if tar_list[i] then
            condition = true
            local pos = get_npc_pos(tar_list[i]) or get_npc_offset_position(role.npc, nil, math.random(60, 120), 3)
            cast_missile3(role.npc, nil, pos.x, pos.z, misLogics.skill02_5.id, 0, nil, nil, nil, nil, nil, nil, nil, role.skills.skill02_1:skInfo())
          else
            local pos = get_npc_offset_position(role.npc, nil, math.random(60, 120), 3)
            cast_missile3(role.npc, nil, pos.x, pos.z, misLogics.skill02_5.id, 0, nil, nil, nil, nil, nil, nil, nil, role.skills.skill02_1:skInfo())
          end
        end
      end
    end
    if not condition then
      local role_pos = get_npc_pos(role.npc)
      local pos = get_npc_offset_position(role.npc, nil, math.random(60, 120), 3)
      cast_missile3(role.npc, nil, pos.x, pos.z, misLogics.skill02_5.id, 0, nil, nil, nil, nil, nil, nil, nil, role.skills.skill02_1:skInfo())
    end
  end, 0.3)
end

function Asti.onRampageStart(role, stage)
  local misLogics = role.misLogics
  local tool = role.tool
  local magics = role.magics
  local skill03_2 = role.icons.skill03_2
  local sk2 = role.btns.sk2
  sk2:setIcon(skill03_2)
  
  function magics.umbrella_BOOM.changeIcon()
  end
  
  tool.insert(magics.umbrella_BOOM, "onBegin", umbrella_boom_add)
end

function Asti.onRampageEnd(role, stage)
  local magics = role.magics
  local tool = role.tool
  local skill03_1 = role.icons.skill03_1
  local sk2 = role.btns.sk2
  sk2:setIcon(skill03_1)
  magics.umbrella_BOOM.changeIcon = magics.umbrella_BOOM.changeIconDefault
  tool.remove(magics.umbrella_BOOM, "onBegin", umbrella_boom_add)
end

return Asti
