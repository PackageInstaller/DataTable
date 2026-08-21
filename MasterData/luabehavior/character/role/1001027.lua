local roleBase = import("character.base.role_base")
local Golden = Util.create_child_mt(roleBase)
local magicIds_1 = {
  skill_2_push = 1027303,
  link_skill_2_push = 1027309,
  atk3_push = 1027311,
  trace4_strengthen_atk3_push = 1027312,
  trace1_maze_slow = 1027308,
  trace2_maze_light_damage_up = 1027415,
  trace4_strengthen_skill_3_push = 1027304,
  trace4_strengthen_skill_2_push = 1027305,
  trace4_strengthen_link_skill_2_push = 1027310,
  destiny1_ult_heal = 1027414,
  destiny2_rampage_start_buff = 1027401,
  destiny5_Maze_damage_up = 1027402,
  spWeapon_golden_sign1 = 1027502,
  spWeapon_golden_sign2 = 1027503,
  spWeapon_link_charge = 1027403,
  mechanism_complete_link = 1027448,
  destiny2_link_energy_up = 1027449,
  destiny2_adddamage = 1027504,
  spcrimp_times = {1027457, 1027458},
  reducecrimp_times = 1027459,
  ultpower = 1027460,
  buff_water = 1027461,
  buff_fire = 1027462,
  buff_storm = 1027463,
  buff_light = 1027464,
  buff_dark = 1027465,
  element_buff = {
    buff_water = 1027461,
    buff_fire = 1027462,
    buff_storm = 1027463,
    buff_light = 1027464,
    buff_dark = 1027465
  },
  power_atk = 1027466,
  power_normal = 1027467,
  power_shutdown = 1027468,
  power_pro = 1027469,
  power_connect = 1027470,
  power_energy = 1027471,
  power_pursuit = 1027472,
  power_other = 1027473,
  type_buff = {
    power_pro = 1027469,
    power_connect = 1027470,
    power_energy = 1027471,
    power_pursuit = 1027472
  },
  crimpaddlink = 1027500,
  crimptreatteam = 1027501,
  ultaddlinkenergy = 1027505
}

function Golden._init(role, npc)
  role.npc = npc
  local misIds = {
    verticalMazeBegin = 10010270705,
    verticalMaze_Effect = 10010270703,
    locate = {
      verticalMaze_center = 10010270710,
      verticalMaze_front = 10010270711,
      verticalMaze_back = 10010270712,
      verticalMaze_left = 10010270713,
      verticalMaze_right = 10010270714
    },
    verticalMazeExtend1 = {
      10010270802,
      10010270805,
      10010270808
    },
    verticalMazeExtend1_Effect = {
      front = 10010270803,
      left = 10010270806,
      right = 10010270809,
      back = 10010270822
    },
    verticalMazeDamage = 10010270815,
    verticalMazeCrimp = 10010270816,
    verticalMazeCrimpDamage = 10010270818,
    verticalMazeFocus = 10010270819,
    verticalMazeDamage2 = 10010270824,
    front_back_maze = 10010270908,
    front_back_maze_Effect = 10010270909,
    front_back_maze_Effect02 = 10010270916,
    front_back_maze_judge = {10010270910, 10010270911},
    front_back_maze_damage_protrusion = {10010270905, 10010270912},
    front_back_maze_crimp = 10010270906,
    front_back_maze_damage_crimp = 10010270907,
    front_back_maze_damage_crimp2 = 10010270917,
    front_back_maze_focus = 10010270914,
    linkVerticalMazeBegin = 10010272205,
    linkVerticalMaze_Effect = 10010272203,
    linkLocate = {
      linkVerticalMaze_center = 10010272207,
      linkVerticalMaze_front = 10010272208,
      linkVerticalMaze_back = 10010272209,
      linkVerticalMaze_left = 10010272210,
      linkVerticalMaze_right = 10010272211
    },
    linkVerticalMazeExtend1 = {
      10010272215,
      10010272217,
      10010272219
    },
    linkVerticalMazeExtend1_Effect = {
      front = 10010272216,
      left = 10010272218,
      right = 10010272220
    },
    linkVerticalMazeDamage = 10010272221,
    linkVerticalMazeCrimp = 10010272222,
    linkVerticalMazeCrimpDamage = 10010272223,
    link_front_back_maze = 10010272308,
    link_front_back_maze_Effect = 10010272309,
    link_front_back_maze_damage_protrusion = {10010272305, 10010272312},
    link_front_back_maze_crimp = 10010272306,
    link_front_back_maze_damage_crimp = 10010272307,
    atk3_location = 10010270323,
    atk3_maze_crimp = 10010270321,
    ultboom = 10010271212
  }
  local magicIds = {
    verticalMazeExtend1 = 1027015,
    verticalMazeExtend2 = 1027016,
    verticalMazeExtend3 = 1027017,
    verticalMazeExtend4 = 1027018
  }
  roleBase._init(role, misIds, magicIds)
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local traces = role.traces
  local destinies = role.destinies
  local spWeapon = role.spWeapon
  local verticalActiveMissiles = {}
  role.crimp_times = 0
  role.crimp_timesMagic = magicIds_1.spcrimp_times[1]
  role.crimp_timesMax = 4
  role.crimp_timesStaty = false
  role.ReduceCrimp_timesMagic = magicIds_1.reducecrimp_times
  role.HitBooltrace2 = false
  role.HitBooltrace4 = false
  role.HitBooldestinies2 = false
  set_keyframe_enable_by_tag(role.npc, role.skills.atk3.id, 301, false, true)
  set_keyframe_enable_by_tag(role.npc, role.skills.atk3.id, 302, true, true)
  
  function misLogics.atk3_location.onBegin(mis, misInst, owner, posX, posZ)
    mis.locate_pos = get_missile_pos(misInst)
  end
  
  do
    local sk1 = role.btns.sk1
    local skill2_1 = role.icons.skill2_1
    local skill2_2 = role.icons.skill2_2
    local rolePos
    
    function skActs.skill2_1.onBegin(skill2_1)
      skill2_1.base.onBegin(skill2_1)
      rolePos = get_npc_pos(role.npc)
      set_effect_end_anim_idx(role.npc, "Fx_H1001027_skill2_2", 0)
    end
    
    function skActs.skill2_2.onBegin(skill2_2)
      skill2_2.base.onBegin(skill2_2)
      role:calculate_enemy_density()
      local center_pos = role.misLogics.locate.verticalMaze_center.locate_pos
      if center_pos then
        cast_missile3(role.npc, nil, center_pos.x, center_pos.z, misIds.verticalMazeFocus)
      end
    end
    
    function skActs.skill2_2.tarPos()
      if not role.misLogics.locate.verticalMaze_center.locate_pos then
        return
      end
      local lookat_pos = role.misLogics.locate.verticalMaze_center.locate_pos
      return lookat_pos
    end
    
    local misPos_Effect
    
    function role.castMis_sk2_Effect(role, posx, posz, misId)
      local misPos = role.misLogics.locate.verticalMaze_center.locate_pos
      if misPos and misPos_Effect then
        cast_missile3(role.npc, nil, misPos_Effect.x, misPos_Effect.z, misId, nil, misPos.x, misPos.z, nil)
      end
    end
    
    for _, misLogic in pairs(role.misLogics.locate) do
      function misLogic.onBegin(mis, misInst, owner, posX, posZ)
        mis.locate_pos = get_missile_pos(misInst)
      end
    end
    
    function magics.verticalMazeExtend1.onBegin(verticalMazeExtend1, casterNpc, target)
      sk1:setIcon(skill2_1)
      local misPos = role.misLogics.locate.verticalMaze_center.locate_pos
      if misPos then
        role:castMis_sk2_Effect(misPos.x, misPos.z, misIds.verticalMazeExtend1_Effect.left)
      end
    end
    
    function magics.verticalMazeExtend1.onEnd(verticalMazeExtend1, casterNpc, target)
      sk1:setIcon(skill2_1)
      local misPos = role.misLogics.locate.verticalMaze_center.locate_pos
      if 3 == role.crimp_timesMax and misPos then
        role:castMis_sk2_Effect(misPos.x, misPos.z, misIds.verticalMazeExtend1_Effect.left)
      end
    end
    
    function magics.verticalMazeExtend2.onBegin(verticalMazeExtend2, casterNpc, target)
      sk1:setIcon(skill2_1)
      local misPos = role.misLogics.locate.verticalMaze_center.locate_pos
      if misPos then
        role:castMis_sk2_Effect(misPos.x, misPos.z, misIds.verticalMazeExtend1_Effect.front)
      end
    end
    
    function magics.verticalMazeExtend2.onEnd(verticalMazeExtend2, casterNpc, target)
      sk1:setIcon(skill2_1)
      local misPos = role.misLogics.locate.verticalMaze_center.locate_pos
      if 3 == role.crimp_timesMax and misPos then
        role:castMis_sk2_Effect(misPos.x, misPos.z, misIds.verticalMazeExtend1_Effect.front)
        role:castMis_sk2_Effect(misPos.x, misPos.z, misIds.verticalMazeExtend1_Effect.back)
        
        local function delayEnd()
          play_effect_anim(role.npc, "Fx_H1001027_skill2_2", "End2")
          set_effect_end_anim_idx(role.npc, "Fx_H1001027_skill2_2", 2)
        end
        
        role:doAfter(delayEnd, 0.1)
        local back_pos = role.misLogics.locate.verticalMaze_center.locate_pos
        if back_pos then
          cast_missile3(role.npc, nil, back_pos.x, back_pos.z, misIds.verticalMazeDamage2, 0)
        end
      end
    end
    
    function magics.verticalMazeExtend3.onBegin(verticalMazeExtend3, casterNpc, target)
      sk1:setIcon(skill2_1)
      local misPos = role.misLogics.locate.verticalMaze_center.locate_pos
      if misPos then
        role:castMis_sk2_Effect(misPos.x, misPos.z, misIds.verticalMazeExtend1_Effect.right)
      end
    end
    
    function magics.verticalMazeExtend3.onEnd(verticalMazeExtend3, casterNpc, target)
      sk1:setIcon(skill2_1)
      local misPos = role.misLogics.locate.verticalMaze_center.locate_pos
      if 3 == role.crimp_timesMax and misPos then
        role:castMis_sk2_Effect(misPos.x, misPos.z, misIds.verticalMazeExtend1_Effect.right)
      end
    end
    
    function misLogics.verticalMaze_Effect.onBegin(misLogic, misInst, owner, posX, posZ)
      role.verticalMaze_Effect = misInst
      misPos_Effect = get_missile_pos(misInst)
      sk1:setIcon(skill2_2)
      remove_missile_by_id(misIds.front_back_maze_Effect, role.npc, true)
      remove_missile_by_id(misIds.front_back_maze, role.npc, true)
      for _, maze_judge_missile in pairs(misLogics.front_back_maze_judge) do
        remove_missile_by_id(maze_judge_missile.id, role.npc)
      end
    end
    
    function misLogics.verticalMaze_Effect.onEnd(misLogic, misInst, owner, posX, posZ)
      role.verticalMaze_Effect = nil
      sk1:setIcon(skill2_1)
    end
    
    function role.verticalMaze_trigger(role, center_pos)
      if role.verticalMaze_Effect then
        remove_missile_by_id(misIds.verticalMaze_Effect, role.npc, false)
        remove_missile_by_id(misIds.verticalMazeBegin, role.npc, false)
        play_effect_anim(role.npc, "Fx_H1001027_skill2_2", "End2")
        local back_pos = role.misLogics.locate.verticalMaze_back.locate_pos
        if back_pos then
          cast_missile3(role.npc, nil, back_pos.x, back_pos.z, misIds.verticalMazeDamage, nil, center_pos.x, center_pos.z, nil)
        end
        role.verticalMaze_Effect = nil
      end
    end
    
    function misLogics.verticalMazeFocus.onBegin(misLogic, misInst, owner, posX, posZ)
      local center_pos = role.misLogics.locate.verticalMaze_center.locate_pos
      if not center_pos then
        return
      end
      local distance = get_npc_distance(role.npc, 2, center_pos.x, center_pos.z, false)
      if distance > 12 then
        return
      end
      change_follow_target_new(1, misInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        2,
        1
      })
    end
    
    function misLogics.verticalMazeFocus.onEnd(misLogic, misInst, owner, posX, posZ)
      role:reset_camera(5)
    end
    
    function misLogics.verticalMazeExtend1_Effect.front.onEnd(mis, misInst, owner, posX, posZ)
      local front_pos = role.misLogics.locate.verticalMaze_front.locate_pos
      local center_pos = role.misLogics.locate.verticalMaze_center.locate_pos
      cast_missile3(role.npc, nil, front_pos.x, front_pos.z, misIds.verticalMazeDamage, nil, center_pos.x, center_pos.z, nil)
      role:verticalMaze_trigger(center_pos)
    end
    
    function misLogics.verticalMazeExtend1_Effect.left.onEnd(mis, misInst, owner, posX, posZ)
      local left_pos = role.misLogics.locate.verticalMaze_left.locate_pos
      local center_pos = role.misLogics.locate.verticalMaze_center.locate_pos
      cast_missile3(role.npc, nil, left_pos.x, left_pos.z, misIds.verticalMazeDamage, nil, center_pos.x, center_pos.z, nil)
      role:verticalMaze_trigger(center_pos)
    end
    
    function misLogics.verticalMazeExtend1_Effect.right.onEnd(mis, misInst, owner, posX, posZ)
      local right_pos = role.misLogics.locate.verticalMaze_right.locate_pos
      local center_pos = role.misLogics.locate.verticalMaze_center.locate_pos
      cast_missile3(role.npc, nil, right_pos.x, right_pos.z, misIds.verticalMazeDamage, nil, center_pos.x, center_pos.z, nil)
      role:verticalMaze_trigger(center_pos)
    end
  end
  do
    local sk2 = role.btns.sk2
    local skill3_1 = role.icons.skill3_1
    local skill3_2 = role.icons.skill3_2
    local skill3_1_misPos, skill3_1_misDir
    local skill3_1_judgePos = {}
    skActs.skill3_1.rolePos = nil
    
    function skActs.skill3_1.onBegin(skill3_1)
      skill3_1.base.onBegin(skill3_1)
      skActs.skill3_1.rolePos = get_npc_pos(role.npc)
    end
    
    function role.castMis(role, posx, posz, misId)
      local pos = skActs.skill3_2.misPos
      local rolePos = skActs.skill3_1.rolePos
      cast_missile3(role.npc, nil, pos.x, pos.z, misId, nil, rolePos.x, rolePos.z, nil)
    end
    
    misLogics.front_back_maze_Effect.lookPos = nil
    
    function misLogics.front_back_maze_Effect.onBegin(misLogic, misInst, owner, posX, posZ)
      role.front_back_maze_Effect = misInst
      misLogics.front_back_maze_Effect.lookPos = get_npc_offset_position(role.npc, nil, 0, 0.5)
    end
    
    function misLogics.front_back_maze.onBegin(misLogic, misInst, owner, posX, posZ)
      skill3_1_misPos = get_missile_pos(misInst)
      skill3_1_misDir = misInst:get_dir_vec():Clone()
      sk2:setIcon(skill3_2)
      if role.btns.sk1.icon == role.icons.skill2_2 then
        remove_missile_by_id(misIds.verticalMazeBegin, role.npc)
        remove_missile_by_id(misIds.verticalMaze_Effect, role.npc)
      end
    end
    
    function misLogics.front_back_maze.onEnd(mis, misInst, owner, posX, posZ)
      sk2:setIcon(skill3_1)
    end
    
    misLogics.front_back_maze_judge[1].onBegin = function(misLogic, misInst, owner, posX, posZ)
      local pos = get_missile_pos(misInst)
      local rolePos = get_npc_pos(role.npc)
      skill3_1_judgePos.left = pos
    end
    misLogics.front_back_maze_judge[2].onBegin = function(misLogic, misInst, owner, posX, posZ)
      local pos = get_missile_pos(misInst)
      local rolePos = get_npc_pos(role.npc)
      skill3_1_judgePos.right = pos
    end
    
    function misLogics.front_back_maze_focus.onBegin(misLogic, misInst, owner, posX, posZ)
      change_follow_target_new(1, misInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        2,
        1
      })
    end
    
    function misLogics.front_back_maze_focus.onEnd(misLogic, misInst, owner, posX, posZ)
      role:reset_camera(5)
    end
    
    function skActs.skill3_2.onBegin(skill3_2)
      skill3_2.base.onBegin(skill3_2)
      if not skill3_1_judgePos or not skill3_1_misPos then
        return
      end
      local role_pos = get_npc_pos(role.npc)
      local distance_left = get_npc_distance(role.npc, 2, skill3_1_judgePos.left.x, skill3_1_judgePos.left.z, false)
      local distance_right = get_npc_distance(role.npc, 2, skill3_1_judgePos.right.x, skill3_1_judgePos.right.z, false)
      local is_left_walkable = get_nearest_walkable_pos(role_pos, skill3_1_judgePos.left, 1, nil, false)
      local is_right_walkable = get_nearest_walkable_pos(role_pos, skill3_1_judgePos.right, 1, nil, false)
      if not is_left_walkable and is_right_walkable then
        role:tp(skill3_1_judgePos.right, 5, skill3_1_misPos, 0)
        return
      end
      if not is_right_walkable and is_left_walkable then
        role:tp(skill3_1_judgePos.left, 5, skill3_1_misPos, 0)
        return
      end
      if distance_left < distance_right then
        if distance_left <= 12 then
          role:tp(skill3_1_judgePos.left, 12, skill3_1_misPos, 0)
        else
          local posFlash = get_npc_pos(role.npc)
          role:tp(posFlash, 0, skill3_1_misPos, 0)
        end
      elseif distance_right <= 11 then
        role:tp(skill3_1_judgePos.right, 12, skill3_1_misPos, 0)
      else
        role:tp(skill3_1_judgePos.right, 0, skill3_1_misPos, 0)
      end
    end
    
    for _, missile in pairs(misLogics.front_back_maze_judge) do
      function missile.onHit(misId, misInst, casterNpc, hitTarget, hitType, skill)
        local kind = get_role_kind(hitTarget)
        
        if 1 == kind then
          remove_missile_by_id(misIds.front_back_maze_Effect, role.npc, true)
          play_effect_anim(role.npc, "Fx_H1001027_skill3_1_mg_2", "End1")
          remove_missile_by_id(misIds.front_back_maze, role.npc, false)
          for _, maze_judge_missile in pairs(misLogics.front_back_maze_judge) do
            remove_missile_by_id(maze_judge_missile.id, role.npc)
          end
          if not skill3_1_misPos or not skill3_1_misDir then
            return
          end
          cast_missile3(role.npc, nil, skill3_1_misPos.x, skill3_1_misPos.z, misIds.front_back_maze_focus)
          local lookat_pos = skill3_1_misPos + skill3_1_misDir
          cast_missile3(role.npc, nil, skill3_1_misPos.x, skill3_1_misPos.z, misIds.front_back_maze_damage_protrusion[1], 0, lookat_pos.x, lookat_pos.z)
          cast_missile3(role.npc, nil, skill3_1_misPos.x, skill3_1_misPos.z, misIds.front_back_maze_damage_protrusion[2], 0, lookat_pos.x, lookat_pos.z)
          role:doAfter(function()
            cast_missile3(role.npc, nil, skill3_1_misPos.x, skill3_1_misPos.z, misIds.front_back_maze_crimp, 1, lookat_pos.x, lookat_pos.z)
          end, -0.4, true)
        end
      end
    end
  end
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      return 2
    else
      return 0
    end
  end
  
  do
    local sk1 = role.btns.sk1
    local link_skill2_1 = role.icons.link_skill2_1
    local rolePos
    
    function skActs.link_skill2_1.onBegin(link_skill2_1)
      link_skill2_1.base.onBegin(link_skill2_1)
      rolePos = get_npc_pos(role.npc)
      set_effect_end_anim_idx(role.npc, "Fx_H1001027_skill2_2", 2)
    end
    
    local misPos_Effect
    for _, misLogic in pairs(role.misLogics.linkLocate) do
      function misLogic.onBegin(mis, misInst, owner, posX, posZ)
        mis.locate_pos = get_missile_pos(misInst)
      end
    end
    
    function misLogics.linkVerticalMaze_Effect.onBegin(misLogic, misInst, owner, posX, posZ)
      role.linkVerticalMaze_Effect = misInst
      misPos_Effect = get_missile_pos(misInst)
      remove_missile_by_id(misIds.front_back_maze_Effect, role.npc, true)
      remove_missile_by_id(misIds.front_back_maze, role.npc, true)
      for _, maze_judge_missile in pairs(misLogics.front_back_maze_judge) do
        remove_missile_by_id(maze_judge_missile.id, role.npc)
      end
    end
    
    function misLogics.linkVerticalMaze_Effect.onEnd(misLogic, misInst, owner, posX, posZ)
      role.linkVerticalMaze_Effect = nil
    end
    
    function role.linkVerticalMaze_trigger(role, center_pos)
      if role.linkVerticalMaze_Effect then
        remove_missile_by_id(misIds.linkVerticalMaze_Effect, role.npc, false)
        remove_missile_by_id(misIds.linkVerticalMazeBegin, role.npc, false)
        play_effect_anim(role.npc, "Fx_H1001027_skill2_2", "End2")
        local back_pos = role.misLogics.linkLocate.linkVerticalMaze_back.locate_pos
        cast_missile3(role.npc, nil, back_pos.x, back_pos.z, misIds.linkVerticalMazeDamage, nil, center_pos.x, center_pos.z, nil)
        role.linkVerticalMaze_Effect = nil
      end
    end
    
    function misLogics.linkVerticalMazeExtend1_Effect.front.onEnd(mis, misInst, owner, posX, posZ)
      local front_pos = role.misLogics.linkLocate.linkVerticalMaze_front.locate_pos
      local center_pos = role.misLogics.linkLocate.linkVerticalMaze_center.locate_pos
      cast_missile3(role.npc, nil, front_pos.x, front_pos.z, misIds.linkVerticalMazeDamage, nil, center_pos.x, center_pos.z, nil)
      role:linkVerticalMaze_trigger(center_pos)
    end
    
    function misLogics.linkVerticalMazeExtend1_Effect.left.onEnd(mis, misInst, owner, posX, posZ)
      local left_pos = role.misLogics.linkLocate.linkVerticalMaze_left.locate_pos
      local center_pos = role.misLogics.linkLocate.linkVerticalMaze_center.locate_pos
      cast_missile3(role.npc, nil, left_pos.x, left_pos.z, misIds.linkVerticalMazeDamage, nil, center_pos.x, center_pos.z, nil)
      role:linkVerticalMaze_trigger(center_pos)
    end
    
    function misLogics.linkVerticalMazeExtend1_Effect.right.onEnd(mis, misInst, owner, posX, posZ)
      local right_pos = role.misLogics.linkLocate.linkVerticalMaze_right.locate_pos
      local center_pos = role.misLogics.linkLocate.linkVerticalMaze_center.locate_pos
      cast_missile3(role.npc, nil, right_pos.x, right_pos.z, misIds.linkVerticalMazeDamage, nil, center_pos.x, center_pos.z, nil)
      role:linkVerticalMaze_trigger(center_pos)
    end
  end
  do
    local sk2 = role.btns.sk2
    local skill3_1 = role.icons.skill3_1
    local skill3_2 = role.icons.skill3_2
    local skill3_1_misPos, skill3_1_misDir
    local skill3_1_judgePos = {}
    
    function misLogics.link_front_back_maze_Effect.onBegin(misLogic, misInst, owner, posX, posZ)
      role.front_back_maze_Effect = misInst
    end
    
    function misLogics.link_front_back_maze.onBegin(misLogic, misInst, owner, posX, posZ)
      skill3_1_misPos = get_missile_pos(misInst)
      skill3_1_misDir = misInst:get_dir_vec():Clone()
    end
    
    function misLogics.link_front_back_maze.onEnd(mis, misInst, owner, posX, posZ)
      remove_missile_by_id(misIds.link_front_back_maze_Effect, role.npc)
      play_effect_anim(role.npc, "Fx_H1001027_skill3_1_mg_2", "End1")
      if not skill3_1_misPos or not skill3_1_misDir then
        return
      end
      local lookat_pos = skill3_1_misPos + skill3_1_misDir
      cast_missile3(role.npc, nil, skill3_1_misPos.x, skill3_1_misPos.z, misIds.link_front_back_maze_damage_protrusion[1], 0, lookat_pos.x, lookat_pos.z)
      cast_missile3(role.npc, nil, skill3_1_misPos.x, skill3_1_misPos.z, misIds.link_front_back_maze_damage_protrusion[2], 0, lookat_pos.x, lookat_pos.z)
      role:doAfter(function()
        cast_missile3(role.npc, nil, skill3_1_misPos.x, skill3_1_misPos.z, misIds.link_front_back_maze_crimp, 0, lookat_pos.x, lookat_pos.z)
      end, -0.4, true)
    end
    
    function misLogics.link_front_back_maze_damage_crimp.onBegin(misLogic, misInst, owner, posX, posZ)
    end
  end
  do
    local function element_buff()
      for k, v in pairs(magicIds_1.element_buff) do
        role.tool:castMagicToTeam(v)
      end
      role.tool:castMagicToTeam(1027480)
    end
    
    local function type_buff()
      for k, v in pairs(magicIds_1.type_buff) do
        role.tool:castMagicToTeam(v)
      end
      role.tool:castMagicToTeam(1027481)
    end
    
    role.passive = role.passive_default
    misLogics.verticalMazeCrimp.role = role
    misLogics.linkVerticalMazeCrimpDamage.role = role
    misLogics.front_back_maze_crimp.role = role
    misLogics.link_front_back_maze_crimp.role = role
    role.tool.insert(skActs.skill2_2, "onBegin", role.passive)
    role.tool.insert(misLogics.verticalMazeCrimpDamage, "onBegin", element_buff)
    role.tool.insert(misLogics.linkVerticalMazeCrimpDamage, "onBegin", element_buff)
    role.tool.insert(skActs.skill3_2, "onBegin", role.passive)
    role.tool.insert(misLogics.front_back_maze_crimp, "onBegin", type_buff)
    role.tool.insert(misLogics.link_front_back_maze_crimp, "onBegin", type_buff)
  end
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function atk3_slow(castNpc, skillId, hitTarget, hitType, missileCfg, missile, partNpc)
      if not check_magic(hitTarget, magicIds_1.trace1_maze_slow) then
        cast_magic(role.npc, hitTarget, magicIds_1.trace1_maze_slow, 0)
      end
    end
    
    tool.insert(skActs.atk3, "onHit", atk3_slow)
    
    local function linkQte_slow(castNpc, skillId, hitTarget, hitType, missileCfg, missile, partNpc)
      if not check_magic(hitTarget, magicIds_1.trace1_maze_slow) then
        cast_magic(npc, hitTarget, magicIds_1.trace1_maze_slow, 0)
      end
    end
    
    tool.insert(skActs.linkQte, "onHit", linkQte_slow)
    
    local function skill3_1_slow()
      change_missile_config(misIds.front_back_maze, "magic", {
        magicIds_1.trace1_maze_slow
      }, 0)
    end
    
    tool.insert(skActs.skill3_1, "onBegin", skill3_1_slow)
    
    local function link_skill3_1_slow()
      change_missile_config(misIds.link_front_back_maze, "magic", {
        magicIds_1.trace1_maze_slow
      }, 0)
    end
    
    tool.insert(skActs.link_skill3_1, "onBegin", link_skill3_1_slow)
    
    local function skill2_1_slow()
      change_missile_config(misIds.verticalMazeExtend1[1], "magic", {
        magicIds_1.trace1_maze_slow
      }, 0)
      change_missile_config(misIds.verticalMazeExtend1[2], "magic", {
        magicIds_1.trace1_maze_slow
      }, 0)
      change_missile_config(misIds.verticalMazeExtend1[3], "magic", {
        magicIds_1.trace1_maze_slow
      }, 0)
      change_missile_config(misIds.verticalMazeBegin, "magic", {
        magicIds_1.trace1_maze_slow
      }, 0)
    end
    
    tool.insert(skActs.skill2_1, "onBegin", skill2_1_slow)
    
    local function link_skill2_1_slow()
      change_missile_config(misIds.linkVerticalMazeExtend1[1], "magic", {
        magicIds_1.trace1_maze_slow
      }, 0)
      change_missile_config(misIds.linkVerticalMazeExtend1[2], "magic", {
        magicIds_1.trace1_maze_slow
      }, 0)
      change_missile_config(misIds.linkVerticalMazeExtend1[3], "magic", {
        magicIds_1.trace1_maze_slow
      }, 0)
      change_missile_config(misIds.linkVerticalMazeBegin, "magic", {
        magicIds_1.trace1_maze_slow
      }, 0)
    end
    
    tool.insert(skActs.link_skill2_1, "onBegin", link_skill2_1_slow)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function Goldenaddlink(misLogic, misInst, owner, posX, posZ)
      role.HitBooltrace2 = true
    end
    
    tool.insert(misLogics.front_back_maze_damage_crimp, "onHit", Goldenaddlink)
    tool.insert(misLogics.verticalMazeCrimpDamage, "onHit", Goldenaddlink)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function GoldenaddHP(misLogic, misInst, owner, posX, posZ)
      role.HitBooltrace4 = true
    end
    
    tool.insert(misLogics.verticalMazeCrimp, "onBegin", GoldenaddHP)
    tool.insert(misLogics.linkVerticalMazeCrimp, "onBegin", GoldenaddHP)
    tool.insert(misLogics.front_back_maze_crimp, "onBegin", GoldenaddHP)
    tool.insert(misLogics.link_front_back_maze_crimp, "onBegin", GoldenaddHP)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function Rampage_add_buff()
      local is_job_different = role:are_all_jobs_different(role.tool.team.npc)
      
      if is_job_different then
        tool:castMagicToTeam(magicIds_1.destiny2_rampage_start_buff, 2, role.npc, 1)
      else
        tool:castMagicToTeam(magicIds_1.destiny2_rampage_start_buff, 1, role.npc, 1)
      end
    end
    
    tool.insert(role, "onRampageStart", Rampage_add_buff)
    
    local function Rampage_abort_buff()
      tool:abortMagicToTeam(magicIds_1.destiny2_rampage_start_buff)
    end
    
    tool.insert(role, "onRampageEnd", Rampage_abort_buff)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function strengthen_crimp_skill_3()
      change_missile_config(misLogics.front_back_maze_crimp.id, "magic", {
        magicIds_1.trace4_strengthen_skill_3_push
      }, 0)
    end
    
    misLogics.front_back_maze_crimp:insertFun("onBegin", strengthen_crimp_skill_3)
    
    local function strengthen_crimp_link_skill_3()
      change_missile_config(misLogics.link_front_back_maze_crimp.id, "magic", {
        magicIds_1.trace4_strengthen_skill_3_push
      }, 0)
    end
    
    misLogics.front_back_maze_crimp:insertFun("onBegin", strengthen_crimp_link_skill_3)
    
    local function strengthen_crimp_skill_2()
      change_missile_config(misLogics.verticalMazeCrimp.id, "magic", {
        magicIds_1.trace4_strengthen_skill_2_push
      }, 0)
    end
    
    misLogics.verticalMazeCrimp:insertFun("onBegin", strengthen_crimp_skill_2)
    
    local function strengthen_crimp_link_skill_2()
      change_missile_config(misLogics.linkVerticalMazeCrimp.id, "magic", {
        magicIds_1.trace4_strengthen_link_skill_2_push
      }, 0)
    end
    
    misLogics.linkVerticalMazeCrimp:insertFun("onBegin", strengthen_crimp_link_skill_2)
    
    local function strengthen_crimp_atk3()
      change_missile_config(misLogics.atk3_maze_crimp.id, "magic", {
        magicIds_1.trace4_strengthen_atk3_push
      }, 0)
    end
    
    misLogics.atk3_maze_crimp:insertFun("onBegin", strengthen_crimp_atk3)
    
    function role.calculate_enemy_density(role)
      set_keyframe_enable_by_tag(role.npc, role.skills.skill2_2.id, 1, true, true)
      set_keyframe_enable_by_tag(role.npc, role.skills.skill2_2.id, 2, true, true)
      set_keyframe_enable_by_tag(role.npc, role.skills.skill2_2.id, 3, true, true)
    end
    
    local function add_GoldenDamage()
      role.HitBooldestinies2 = true
    end
    
    tool.insert(misLogics.verticalMazeCrimpDamage, "onHit", add_GoldenDamage)
    tool.insert(misLogics.linkVerticalMazeCrimpDamage, "onHit", add_GoldenDamage)
    tool.insert(misLogics.front_back_maze_damage_crimp, "onHit", add_GoldenDamage)
    tool.insert(misLogics.link_front_back_maze_damage_crimp, "onHit", add_GoldenDamage)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function destinise3_addpower()
      local god = get_god_npc()
      
      cast_magic(npc, npc, magicIds_1.ultpower, 1)
      cast_magic(god, god, magicIds_1.ultaddlinkenergy, 1)
    end
    
    local function element_buff()
      for k, v in pairs(magicIds_1.element_buff) do
        role.tool:castMagicToTeam(v)
      end
    end
    
    local function type_buff()
      for k, v in pairs(magicIds_1.type_buff) do
        role.tool:castMagicToTeam(v)
      end
    end
    
    role.tool.insert(skActs.ult, "onBegin", element_buff)
    role.tool.insert(skActs.ult, "onBegin", type_buff)
    role.tool.insert(skActs.ult, "onBegin", destinise3_addpower)
    role.tool.insert(skActs.ult, "onHit", element_buff)
    role.tool.insert(skActs.ult, "onHit", type_buff)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.destiniesMagic = {
      Lv1 = {damageUp = 1027506}
    }
    local skillMagic = {
      [1027203] = true,
      [1027206] = true
    }
    
    local function damageUp(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
      if skillMagic[magic_id] then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv1.damageUp, 0)
      end
    end
    
    tool.insert(role, "before_damage_target", damageUp)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.crimp_timesMax = 3
    role.crimp_timesMagic = magicIds_1.spcrimp_times[2]
    
    local function castMissile(misLogic, misInst, owner, posX, posZ)
      cast_missile3(role.npc, nil, posX, posZ, misLogics.front_back_maze_Effect02.id, 0, misLogics.front_back_maze_Effect.lookPos.x, misLogics.front_back_maze_Effect.lookPos.z, nil)
    end
    
    tool.insert(misLogics.front_back_maze_Effect, "onEnd", castMissile)
  end
  
  function role.spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.weapon_time = get_npc_time(role.npc)
    
    local function golden_sign(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
      if missile.missile_id == misIds.front_back_maze_damage_crimp or missile.missile_id == misIds.verticalMazeCrimpDamage or missile.missile_id == misIds.link_front_back_maze_damage_crimp or missile.missile_id == misIds.linkVerticalMazeCrimpDamage then
        local is_job_different = role:are_all_jobs_different(role.tool.team.npc)
        if is_job_different then
          cast_magic(role.npc, target, magicIds_1.spWeapon_golden_sign2, role.spWeapon.lv)
        else
          cast_magic(role.npc, target, magicIds_1.spWeapon_golden_sign1, role.spWeapon.lv)
        end
      end
    end
    
    tool.insert(role, "before_damage_target", golden_sign)
  end
end

function Golden.force_shift_magic_init(role, magic_id, target)
  if magic_id == magicIds_1.skill_2_push or magic_id == magicIds_1.trace4_strengthen_skill_2_push then
    local target_pos = role.misLogics.locate.verticalMaze_center.locate_pos
    if target_pos then
      return target_pos
    end
  end
  if magic_id == magicIds_1.link_skill_2_push or magic_id == magicIds_1.trace4_strengthen_link_skill_2_push then
    local target_pos = role.misLogics.linkLocate.linkVerticalMaze_center.locate_pos
    if target_pos then
      return target_pos
    end
  end
  if magic_id == magicIds_1.trace4_strengthen_atk3_push or magic_id == magicIds_1.atk3_push then
    local target_pos = role.misLogics.atk3_location.locate_pos
    if target_pos then
      return target_pos
    end
  end
end

function Golden.calculate_enemy_density(role)
  set_keyframe_enable_by_tag(role.npc, role.skills.skill2_2.id, 1, false, true)
  set_keyframe_enable_by_tag(role.npc, role.skills.skill2_2.id, 2, false, true)
  set_keyframe_enable_by_tag(role.npc, role.skills.skill2_2.id, 3, false, true)
  if not role.misLogics.locate.verticalMaze_center.locate_pos then
    set_keyframe_enable_by_tag(role.npc, role.skills.skill2_2.id, 1, true, true)
    return
  end
  local mazeCenter = role.misLogics.locate.verticalMaze_center.locate_pos
  local target_pos = role:searchTarget(role.skActs.skill2_2.search, mazeCenter)
  if not target_pos then
    set_keyframe_enable_by_tag(role.npc, role.skills.skill2_2.id, 1, true, true)
    return
  end
  local maze_to_target = target_pos - mazeCenter
  local left = role.misLogics.locate.verticalMaze_left.locate_pos - mazeCenter
  local front = role.misLogics.locate.verticalMaze_front.locate_pos - mazeCenter
  local right = role.misLogics.locate.verticalMaze_right.locate_pos - mazeCenter
  local left_value = vec3.Dot(maze_to_target, left)
  local front_value = vec3.Dot(maze_to_target, front)
  local right_value = vec3.Dot(maze_to_target, right)
  local max = math.max
  local result = max(max(left_value, front_value), right_value)
  if result == left_value then
    set_keyframe_enable_by_tag(role.npc, role.skills.skill2_2.id, 1, true, true)
  elseif result == front_value then
    set_keyframe_enable_by_tag(role.npc, role.skills.skill2_2.id, 2, true, true)
  elseif result == right_value then
    set_keyframe_enable_by_tag(role.npc, role.skills.skill2_2.id, 3, true, true)
  end
end

function Golden.reset_camera(role, camera_speed)
  change_focus_follow_speed(camera_speed)
  role:change_follow_target_new(4)
  
  local function resetFollow()
    change_focus_follow_speed(4)
  end
  
  role:doAfter(resetFollow, -1)
end

function Golden.onRampageStart(role, stage)
  local misLogics = role.misLogics
  remove_missile_by_id(misLogics.front_back_maze_Effect.id, role.npc, true)
  remove_missile_by_id(misLogics.front_back_maze.id, role.npc, true)
  for _, maze_judge_missile in pairs(misLogics.front_back_maze_judge) do
    remove_missile_by_id(maze_judge_missile.id, role.npc)
  end
  if role.btns.sk1.icon == role.icons.skill2_2 then
    remove_missile_by_id(misLogics.verticalMazeBegin.id, role.npc)
    remove_missile_by_id(misLogics.verticalMaze_Effect.id, role.npc)
  end
  local sk1 = role.btns.sk1
  local sk2 = role.btns.sk2
  local link_skill2_1 = role.icons.link_skill2_1
  local link_skill3_1 = role.icons.link_skill3_1
  sk1:setIcon(link_skill2_1)
  sk2:setIcon(link_skill3_1)
end

function Golden.onRampageEnd(role, stage)
  local sk1 = role.btns.sk1
  local sk2 = role.btns.sk2
  local skill2_1 = role.icons.skill2_1
  local skill3_1 = role.icons.skill3_1
  sk1:setIcon(skill2_1)
  sk2:setIcon(skill3_1)
  if role.crimp_timesStaty and role.destinyLv < 5 then
    change_skill_link_duration(2, -3)
    change_skill_link_duration(1, -3)
    role.crimp_timesStaty = false
  elseif role.crimp_timesStaty and role.destinyLv >= 5 then
    change_skill_link_duration(2, -5)
    change_skill_link_duration(1, -5)
    role.crimp_timesStaty = false
  end
end

function Golden.are_all_jobs_different(role, npcs)
  if not npcs then
    return false
  end
  local jobs = {}
  for _, npc in pairs(npcs) do
    local job = get_role_job(npc)
    if not job then
      return
    end
    if jobs[job] then
      return false
    end
    jobs[job] = true
  end
  return true
end

function Golden.passive_default(obj)
  local role = obj.role
  
  local function passive()
    role.crimp_times = role.crimp_times + 1
    if not role:isRampage() then
      cast_magic(role.npc, role.npc, role.crimp_timesMagic, 1)
    else
      return false
    end
    if role.crimp_times >= role.crimp_timesMax and not role.crimp_timesStaty then
      if role.destinyLv < 5 then
        change_skill_link_duration(2, 3)
        change_skill_link_duration(1, 3)
      elseif role.destinyLv >= 5 then
        change_skill_link_duration(2, 5)
        change_skill_link_duration(1, 5)
      end
      role.crimp_timesStaty = true
      role.crimp_times = 0
    end
  end
  
  if role.skAct == role.skActs.skill2_2 then
    role:doAfter(passive, 1.3)
  else
    role:doAfter(passive, 0.6)
  end
end

function Golden.onRampageEffect(role, stage)
  if 100 == get_npc_attr(role.npc, 74) then
    cast_magic(role.npc, role.npc, role.ReduceCrimp_timesMagic, 1)
  end
end

function Golden.on_self_skill_end(role, skill_id, is_time_out, is_break, behavior_abort)
  if 100102708 == skill_id or 100102710 == skill_id then
    if role.HitBooltrace2 == true then
      local god = get_god_npc()
      cast_magic(god, god, magicIds_1.crimpaddlink, 1)
    end
    role.HitBooltrace2 = false
  end
  if 100102708 == skill_id or 100102710 == skill_id or 100102722 == skill_id or 100102723 == skill_id then
    if true == role.HitBooltrace4 then
      local team_hero_list = {
        get_scene_hero_by_poskey(21),
        get_scene_hero_by_poskey(22),
        get_come_on_hero()
      }
      for k, v in pairs(team_hero_list) do
        if v then
          cast_magic(v, v, magicIds_1.crimptreatteam)
        end
      end
    end
    role.HitBooltrace4 = false
  end
  if 100102708 == skill_id or 100102710 == skill_id or 100102722 == skill_id or 100102723 == skill_id then
    if true == role.HitBooldestinies2 then
      cast_magic(role.npc, role.npc, magicIds_1.destiny2_adddamage, 1)
    end
    role.HitBooldestinies2 = false
  end
end

return Golden
