local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local magicIds = {
  posture_judge = 20103301201,
  posture_block_effect = 20103301501,
  posture_break = 20103301205,
  posture_damage_immune = 20103301204,
  roundslash_ban_change = 20103301207,
  roundslash_time_stop = 20103301206,
  roundslash_plus_damage = 20103301302,
  armor_magic = 20103301213
}
local missileIds = {posture_effect = 201033012402}
local keyframe_id = {
  Break_Four_slash_4 = 201033011805,
  Step_back_warning = 201033012701,
  Step_back_fintrans = 201033012702,
  judgement_cut_damage1 = 201033011309,
  judgement_cut_damage2 = 1302,
  judgement_cut_warning = 201033011312,
  comboA_change_time = 201033010318,
  roundslash_to_plus = 201033010707
}
local camera_id = {
  default_camera = 2010330101,
  break_camera = 2010330102,
  roundslash_camera = 2010330103
}

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 5,
    maxDis = 8,
    minTime = 1.5,
    maxTime = 1.5,
    type = "run"
  }
  monster.search = {minDis = 100, maxDis = 100}
  local t = monster.create_skill_node_cfg
  monster.FourSlash = 0
  local actSkills = {
    dashOutFar = t(2010330108, 20, 3),
    RoundSlash = t(2010330107, 7, 3, 0, 3),
    comboA = t(2010330103, 7, 1, 0, 4),
    comboA_change = t(2010330104, 15, 10, 0, 5, -90, 90),
    comboB = t(2010330110, 20, 4, 0, 8),
    comboC = t(2010330114, 22, 8, 4, 9999),
    comboB_RedSkill = t(2010330123, 20, 20 * math.random()),
    comboC_RedSkill = t(2010330122, 22, 20 * math.random(), 6, 9999),
    Step_back = t(2010330127, 10, 3),
    Four_slash_1 = t(2010330128),
    Four_slash_2 = t(2010330129),
    Four_slash_3 = t(2010330130),
    Four_slash_4 = t(2010330131),
    Break_Four_slash_2 = t(2010330115),
    Break_Four_slash_3 = t(2010330116),
    Break_Four_slash_4 = t(2010330117),
    Break = t(2010330118),
    Posture = t(2010330124),
    Posture_streak = t(2010330112, 0, 0, 0, 8, -60, 60),
    Posture_parry = t(2010330126),
    RoundSlash_plus = t(2010330113, nil, nil, nil, nil, nil, nil, 5),
    RoundSlash_plus2 = t(2010330113, nil, nil, nil, nil, nil, nil, 5, 18),
    Streak_plus = t(2010330109),
    Judgement_cut = t(2010330119, nil, nil, nil, nil, nil, nil, nil, 6)
  }
  local nodes = {
    "nmatk",
    "spatk",
    "Evade",
    "four_slash",
    "posture"
  }
  monstBase._init(monster, actSkills, nil, nodes)
  local states = monster.states
  local skills = monster.skills
  monster.angle = 315
  monster.hurt_time = 0
  monster.hurt_time_max = 15
  states.surMove.maxTime = 2.5
  monster.evade_config.threshold = math.huge
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.attack, _ENV.wander)
    _ENV.evade(_ENV.dashOutFar, _ENV.Step_back)
    _ENV.freeAtk(_ENV.nmatk(_ENV.comboB_RedSkill, _ENV.comboC_RedSkill, _ENV.comboB, _ENV.comboC, _ENV.comboA, _ENV.four_slash, _ENV.RoundSlash(_ENV.RoundSlash_plus2)), _ENV.spatk(_ENV.posture, _ENV.comboA_change))
    _ENV.four_slash(_ENV.Four_slash_1, _ENV.Four_slash_2, _ENV.Four_slash_3, _ENV.Four_slash_4, _ENV.Break_Four_slash_2, _ENV.Break_Four_slash_3, _ENV.Break_Four_slash_4, _ENV.Break)
    _ENV.posture(_ENV.Posture(_ENV.Posture_streak), _ENV.Posture_parry(_ENV.RoundSlash_plus), _ENV.Streak_plus)
  end
  do
    local wanderMove = states.wanderMove
    local forward = states.forward
    local surround = states.surround
    wanderMove(surround)
    
    function states.surround.isReady(surround)
      return true
    end
  end
  states.hit.Evade = states.evade
  
  function states.hit.tickTrans(hit)
    if monster.states.faint:isRunning() then
      return
    end
    local hurt_time = monster.states.hit.hurt_time
    if not hurt_time then
      return
    end
    local now_time = get_npc_time(monster.npc)
    local armor_time = 2
    if now_time > hurt_time + armor_time then
      return monster.states.Step_back
    end
  end
  
  function states.hit.start(hit)
    hit.base.start(hit)
    monster.states.hit.hurt_time = get_npc_time(monster.npc)
  end
  
  function states.Step_back.start(Step_back)
    Step_back.base.start(Step_back)
    monster.hurt_time = monster.hurt_time - 7
    local centerPos = vec3.New(get_area_pos("D1"))
    local now_pos = get_npc_pos(monster.npc)
    local lookat_pos = now_pos - centerPos + now_pos
    lookat_position(monster.npc, lookat_pos.x, lookat_pos.z, false)
  end
  
  function states.Step_back.finTrans(finTrans)
    return monster.states.wander
  end
  
  function states.dashOutFar.start(dashOutFar)
    dashOutFar.base.start(dashOutFar)
    monster.hurt_time = -10
    local centerPos = vec3.New(get_area_pos("D1"))
    local now_pos = get_npc_pos(monster.npc)
    local lookat_pos = now_pos - centerPos + now_pos
    lookat_position(monster.npc, lookat_pos.x, lookat_pos.z, false)
  end
  
  function states.spatk.isReady(spatk)
    return false
  end
  
  function states.Posture.start(Posture)
    Posture.base.start(Posture)
    lookat_npc(monster.npc, get_come_on_hero(), true)
  end
  
  function states.Posture.finish(Posture)
    Posture.base.finish(Posture)
    remove_missile_by_id(missileIds.posture_effect, monster.npc)
  end
  
  function states.Posture_parry.start(Posture_parry)
    Posture_parry.base.start(Posture_parry)
    if monster.parry_npc then
      lookat_npc(monster.npc, monster.parry_npc, true)
    end
  end
  
  function states.four_slash.isReady(four_slash)
    local comboA = states.comboA
    local hp_max = get_npc_attr(monster.npc, 4)
    local hp_cur = get_npc_attr(monster.npc, 1)
    local hp_per = hp_cur / hp_max
    if hp_per > 0.5 then
      return false
    end
    if not comboA.base.isReady(comboA) then
      return false
    else
      return true
    end
  end
  
  function states.four_slash.finish(four_slash)
    cast_magic(monster.npc, monster.npc, 1999261)
    cast_magic(monster.npc, monster.npc, 1999242)
    monster.states.comboA.timer = get_npc_time(monster.npc) + monster.states.comboA.cd
  end
  
  function states.Four_slash_1.start(Four_slash_1)
    Four_slash_1.base.start(Four_slash_1)
    monster.FourSlash = 1
  end
  
  function states.Four_slash_2.start(Four_slash_2)
    Four_slash_2.base.start(Four_slash_2)
    monster.FourSlash = 2
  end
  
  function states.Four_slash_3.start(Four_slash_3)
    Four_slash_3.base.start(Four_slash_3)
    monster.FourSlash = 3
  end
  
  function states.Four_slash_1.finTrans(Four_slash_1)
    return states.Four_slash_2
  end
  
  function states.Four_slash_2.finTrans(Four_slash_2)
    return states.Four_slash_3
  end
  
  function states.Four_slash_3.finTrans(Four_slash_3)
    return states.Four_slash_4
  end
  
  function states.Break.start(Break)
    Break.base.start(Break)
    local cur_camera = get_cur_camera_id()
    if cur_camera ~= camera_id.break_camera then
      monster:set_camera_break(camera_id.break_camera)
      change_follow_target_new(3, monster.npc, {
        6,
        12,
        {
          x = 0,
          y = 0,
          z = 0
        },
        1,
        0.6
      })
      
      local function change_camera()
        monster:set_camera_break(camera_id.default_camera)
        change_follow_target_new(3, monster.npc, {
          6,
          12,
          {
            x = 0,
            y = 0,
            z = 0
          },
          1,
          0.6
        })
      end
      
      monster:doAfter(change_camera, -1)
    end
  end
  
  function states.Break.finTrans(Break)
    if 1 == monster.FourSlash then
      return monster.states.Break_Four_slash_2
    elseif 2 == monster.FourSlash then
      return monster.states.Break_Four_slash_3
    elseif 3 == monster.FourSlash then
      return monster.states.Break_Four_slash_4
    end
  end
  
  function states.Break_Four_slash_2.start(Break_Four_slash_2)
    Break_Four_slash_2.base.start(Break_Four_slash_2)
    monster.FourSlash = 2
  end
  
  function states.Break_Four_slash_3.start(Break_Four_slash_3)
    Break_Four_slash_3.base.start(Break_Four_slash_3)
    monster.FourSlash = 3
  end
  
  function states.Break_Four_slash_4.start(Break_Four_slash_4)
    Break_Four_slash_4.base.start(Break_Four_slash_4)
    monster.FourSlash = 0
  end
  
  function states.Break_Four_slash_2.finTrans(Break_Four_slash_2)
    return states.Four_slash_3
  end
  
  function states.Break_Four_slash_3.finTrans(Break_Four_slash_4)
    return states.Four_slash_4
  end
  
  do
    local dead = monster.states.dead
    dead.delay = {fx = 0.5, remove = 1.5}
  end
  do
    local comboB_RedSkill = monster.states.comboB_RedSkill
    local comboC_RedSkill = monster.states.comboC_RedSkill
    local comboB = monster.states.comboB
    local comboC = monster.states.comboC
    local comboA = monster.states.comboA
    local RoundSlash_plus2 = monster.states.RoundSlash_plus2
    
    function comboB.isReady(comboB)
      local hp_max = get_npc_attr(monster.npc, 4)
      local hp_cur = get_npc_attr(monster.npc, 1)
      local hp_per = hp_cur / hp_max
      return comboB.base.isReady(comboB) and hp_per >= 0.5
    end
    
    function comboB_RedSkill.isReady(comboB_RedSkill)
      local hp_max = get_npc_attr(monster.npc, 4)
      local hp_cur = get_npc_attr(monster.npc, 1)
      local hp_per = hp_cur / hp_max
      return comboB_RedSkill.base.isReady(comboB_RedSkill) and hp_per < 0.5
    end
    
    function comboC.isReady(comboC)
      local hp_max = get_npc_attr(monster.npc, 4)
      local hp_cur = get_npc_attr(monster.npc, 1)
      local hp_per = hp_cur / hp_max
      return comboC.base.isReady(comboC) and hp_per >= 0.5
    end
    
    function comboC_RedSkill.isReady(comboC_RedSkill)
      local hp_max = get_npc_attr(monster.npc, 4)
      local hp_cur = get_npc_attr(monster.npc, 1)
      local hp_per = hp_cur / hp_max
      return comboC_RedSkill.base.isReady(comboC_RedSkill) and hp_per < 0.5
    end
    
    function comboA.isReady(comboA)
      local hp_max = get_npc_attr(monster.npc, 4)
      local hp_cur = get_npc_attr(monster.npc, 1)
      local hp_per = hp_cur / hp_max
      local ran = math.random()
      if not comboA.base.isReady(comboA) then
        return false
      end
      if hp_per >= 0.5 then
        return true
      end
      return ran < 0.5
    end
    
    function RoundSlash_plus2.isReady(RoundSlash_plus2)
      local hp_max = get_npc_attr(monster.npc, 4)
      local hp_cur = get_npc_attr(monster.npc, 1)
      local hp_per = hp_cur / hp_max
      return RoundSlash_plus2.base.isReady(RoundSlash_plus2) and hp_per < 0.5
    end
  end
  
  function states.RoundSlash_plus.start(RoundSlash_plus)
    RoundSlash_plus.base.start(RoundSlash_plus)
    set_keyframe_enable_by_tag(monster.npc, 0, keyframe_id.judgement_cut_damage2, false, true)
    set_keyframe_enable(monster.npc, keyframe_id.judgement_cut_warning, true, true)
  end
  
  function states.RoundSlash_plus.finish(RoundSlash_plus)
    RoundSlash_plus.base.finish(RoundSlash_plus)
    local role = get_come_on_hero():get_behavior()
    if role then
      role:disable_input_protect()
      role:set_switch_hero_enable(true)
      print("打开按钮成功")
    else
      print("打开按钮失败")
    end
  end
  
  function states.RoundSlash_plus.finTrans(RoundSlash_plus)
    return RoundSlash_plus.monster.states.wanderMove
  end
  
  function states.RoundSlash_plus2.start(RoundSlash_plus2)
    RoundSlash_plus2.base.start(RoundSlash_plus2)
    set_keyframe_enable_by_tag(monster.npc, 0, keyframe_id.judgement_cut_damage2, false, true)
    set_keyframe_enable(monster.npc, keyframe_id.judgement_cut_warning, true, true)
  end
  
  function states.RoundSlash_plus2.finish(RoundSlash_plus2)
    RoundSlash_plus2.base.finish(RoundSlash_plus2)
    local role = get_come_on_hero():get_behavior()
    if role then
      role:disable_input_protect()
      role:set_switch_hero_enable(true)
      print("打开按钮成功")
    else
      print("打开按钮失败")
    end
  end
  
  function states.RoundSlash_plus2.finTrans(RoundSlash_plus2)
    return RoundSlash_plus2.monster.states.wanderMove
  end
end

function monster.on_start(monster)
  monster.base.on_start(monster)
  change_follow_target_new(3, monster.npc, {
    6,
    12,
    {
      x = 0,
      y = 0,
      z = 0
    },
    1,
    0.6
  })
end

function monster.after_damage_self(monster, npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  monster.base.after_damage_self(monster, npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if monster.states.faint:isRunning() then
    return
  end
  if 6 == damage_sign then
    return
  end
  if damage_val > -1 then
    return
  end
  local hp_max = get_npc_attr(monster.npc, 4)
  local damage_per = damage_val / hp_max
  if monster.states.wander:isRunning() then
    if damage_per > 0.01 then
      monster.hurt_time = monster.hurt_time + 1
    else
      monster.hurt_time = monster.hurt_time + 0.8
    end
    if monster.hurt_time > monster.hurt_time_max then
      local ran = math.random()
      monster:transState(monster.states.dashOutFar, false)
    end
  elseif monster.states.hit:isRunning() then
    if damage_per > 0.01 then
      monster.hurt_time = monster.hurt_time + 2
    else
      monster.hurt_time = monster.hurt_time + 1.5
    end
  elseif monster.states.attack:isRunning() then
    if damage_per > 0.01 then
      monster.hurt_time = monster.hurt_time + 0.8
    else
      monster.hurt_time = monster.hurt_time + 0.6
    end
  end
  print("次数=", monster.hurt_time)
end

function monster.before_damage_self(monster, caster, magic_id, damage_sign, damage_type, camp, change_grading, magic_level, skill_id, missile)
  monster.base.before_damage_self(monster, caster, magic_id, damage_sign, damage_type, camp, change_grading, magic_level, skill_id, missile)
  if not check_magic(monster.npc, magicIds.posture_judge) then
    return
  end
  local kind = get_role_kind(caster)
  if 1 ~= kind then
    return
  end
  if 6 == damage_sign then
    return
  end
  local target_pos = get_npc_pos(caster)
  local angle = get_target_angel(monster.npc, caster, true)
  if angle <= 70 and angle >= -70 then
    local enemy_attack_armor = get_armor_atk_level(caster)
    local self_defend_armor = get_armor_def_level(monster.npc)
    if enemy_attack_armor < self_defend_armor then
      remove_missile_by_id(missileIds.posture_effect, monster.npc)
      cast_magic(monster.npc, monster.npc, magicIds.posture_damage_immune)
      play_effect_anim(monster.npc, "Fx_M201033_skill4_1", "End1")
      monster.parry_npc = caster
      local distance = get_npc_distance(monster.npc, 1, caster, false)
      if distance < 5 then
        monster.tree:transState(monster.states.Posture_parry, true)
      else
        monster.tree:transState(monster.states.Streak_plus, true)
      end
    end
  else
    cast_magic(monster.npc, monster.npc, magicIds.posture_break)
  end
end

function monster.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
  if not monster.states.four_slash:isRunning() or 0 == monster.FourSlash then
    cast_magic(monster.npc, attackerNpc, 1999352)
    monster.base.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
    return
  end
  monster.on_red_skill_countered_sp(monster, attackerNpc, missile)
end

function monster.on_red_skill_countered_fx(monster, attackerNpc, missile)
  set_camera(camera_id.break_camera, true)
  
  local function change_camera()
    set_camera(camera_id.default_camera, true)
    change_follow_target_new(3, monster.npc, {
      6,
      12,
      {
        x = 0,
        y = 0,
        z = 0
      },
      1,
      0.6
    })
  end
  
  monster:doAfter(change_camera, -2.5)
  monster.base.on_red_skill_countered_fx(monster, attackerNpc, missile)
end

function monster.on_red_skill_countered_sp(monster, attackerNpc, missile)
  attackerNpc = attackerNpc or get_come_on_hero()
  local npc = monster.npc
  lookat_npc(npc, attackerNpc, true)
  cast_magic(npc, npc, Const.MONSTER_BE_HIT.SOUND_REVERB, 0)
  local monster_kind = get_role_kind(monster.npc)
  if 4 ~= monster_kind then
    cast_magic(attackerNpc, attackerNpc, 1999351)
  else
    cast_magic(attackerNpc, attackerNpc, 1999352)
  end
  set_camera(camera_id.break_camera, true)
  
  local function change_camera()
    set_camera(camera_id.default_camera, true)
    change_follow_target_new(3, monster.npc, {
      6,
      12,
      {
        x = 0,
        y = 0,
        z = 0
      },
      1,
      0.6
    })
  end
  
  monster:doAfter(change_camera, -2.5)
  cast_magic(attackerNpc, npc, 1999219)
  cast_magic(attackerNpc, npc, 1999221)
  abort_skill(monster.npc)
  monster.tree:transState(monster.states.Break)
end

function monster.on_keyframe_action(monster, kfId, npcTag, comnTag)
  if kfId == keyframe_id.Break_Four_slash_4 and 3 == monster.FourSlash then
    monster.tree:transState(monster.states.Break_Four_slash_4)
  end
  if kfId == keyframe_id.comboA_change_time and monster.states.comboA_change:isReady() then
    monster.tree:transState(monster.states.comboA_change)
  end
  if npcTag and "posture" == npcTag and monster.states.posture:isReady() then
    monster.tree:transState(monster.states.posture)
  end
  if kfId == keyframe_id.roundslash_to_plus then
    local hp_max = get_npc_attr(monster.npc, 4)
    local hp_cur = get_npc_attr(monster.npc, 1)
    local hp_per = hp_cur / hp_max
    if hp_per > 0.5 then
      return
    end
    monster.states.RoundSlash:derive()
  end
end

function monster.before_damage_target(monster, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  monster.base.before_damage_target(monster, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if skill_id == monster.states.RoundSlash_plus.skill.id and magic_id == magicIds.roundslash_plus_damage and target == get_come_on_hero() then
    local role = target:get_behavior()
    if role then
      role:enable_input_protect(true, 2)
      role:set_switch_hero_enable(false)
      print("关闭按钮输入")
    else
      print("关闭按钮失败")
    end
    cast_magic(monster.npc, monster.npc, magicIds.roundslash_time_stop)
    set_keyframe_enable(monster.npc, keyframe_id.judgement_cut_warning, false, true)
    monster:set_camera_follow(camera_id.roundslash_camera)
    change_follow_target_new(3, monster.npc, {
      6,
      12,
      {
        x = 0,
        y = 0,
        z = 0
      },
      1,
      0.6
    })
    monster:flash_back(monster.npc, monster.target)
    
    local function change_camera()
      monster:set_camera_break(camera_id.default_camera)
      change_follow_target_new(3, monster.npc, {
        6,
        12,
        {
          x = 0,
          y = 0,
          z = 0
        },
        1,
        0.6
      })
    end
    
    monster:doAfter(change_camera, -3.5)
  end
  if missile.missile_id == keyframe_id.judgement_cut_damage1 then
    set_keyframe_enable_by_tag(monster.npc, 0, keyframe_id.judgement_cut_damage2, true, true)
  end
end

function monster.flash_back(monster, npc, target)
  local kind = get_role_kind(target)
  if 1 ~= kind then
    return
  end
  local distance = get_npc_distance(npc, 1, target, false)
  if distance > 4 then
    return
  end
  local npc_pos = get_npc_pos(npc)
  local target_pos = get_npc_pos(target)
  local npc_to_target = target_pos - npc_pos
  flash_to_pos(npc, target_pos.x, target_pos.z, target_pos.y, true)
end

function monster.set_camera_follow(monster, camera_id)
  local dir = monster.npc:get_dir()
  local angle = dir - 165
  monster.angle = angle
  set_camera(camera_id, true, false, function(camera_cfg)
    camera_cfg.DefaultYAngle = angle
  end)
end

function monster.set_camera_break(monster, camera_id)
  set_camera(camera_id, true)
end

return monster
