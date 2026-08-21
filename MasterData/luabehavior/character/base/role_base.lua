local behaviorBase = import("common.base.behavior_base")
local roleBase = Util.create_child_mt(behaviorBase)
local inputorBase = import("character.base.base_role_inputor")
local rebornMgrBase = import("character.base.base_rebornManager")
local iconBase = import("character.base.base_role_icon")
local skillBase = import("character.base.base_role_skill")
local doAfterMgrBase = import("character.base.base_doAfterManager")
local qteMgrBase = import("character.base.base_qteManager")
local searchCfgBase = import("base.role.searchSystem.searchCfg")

function roleBase.setUp(roleBase)
  local roleBase = roleBase
  roleBase.debugSwitch = ComnMgr.DebugConfig.role
  roleBase.commonRole = import("common.role")
  roleBase.ultMgr = ComnMgr.UltMgr
  roleBase.linkMgr = ComnMgr.LinkMgr
  roleBase.rampMgr = ComnMgr.RampMgr
  roleBase.tool = ComnMgr.RoleTool
  roleBase.indiMgr = import("character.base.base_role_indicatorManager")
  roleBase.developMap = {
    trace = {
      [0] = 0,
      [1] = 1,
      [2] = 2,
      [3] = 3,
      [4] = 4,
      [5] = 5
    },
    destiny = {
      [1] = 0,
      [2] = 1,
      [3] = 2,
      [4] = 3,
      [5] = 3,
      [6] = 4,
      [7] = 5
    },
    spWeapon = {
      [1] = 1,
      [2] = 2,
      [3] = 3,
      [4] = 4,
      [5] = 5
    }
  }
  roleBase.ultHideList = {
    JoystickContent = true,
    Right = true,
    TipsFight = true,
    NpcView = true,
    FunctionBtn = true
  }
  roleBase.dash_counter_window_elapse = 0.5
  roleBase.searchCfgBase = searchCfgBase
  roleBase._linkQteEvent = {input_id = 19, isSwitch = false}
  roleBase.needXray = false
  roleBase.is_switch_enable = true
  roleBase.born_magics = {}
  if GAME_DEBUG then
    roleBase._debugEmptyObj = CS.UnityEngine.GameObject.Find("/role_debugEmptyObj")
    roleBase._debugCube = CS.UnityEngine.GameObject.Find("/role_debugCube")
    roleBase._debugCubeLR = CS.UnityEngine.GameObject.Find("/role_debugCubeLR")
    roleBase._debugCubeDensity = CS.UnityEngine.GameObject.Find("/role_debugCubeDensity")
    roleBase._debugCubeTarPos = CS.UnityEngine.GameObject.Find("/role_debugCubeTarPos")
    roleBase._debugBallRandPos = CS.UnityEngine.GameObject.Find("/role_debugBallRandPos")
  end
end

function roleBase.insertFun(role, funName, newFun)
  role.tool.insert(role, funName, newFun)
end

function roleBase.removeFun(role, funName, newFun)
  role.tool.remove(role, funName, newFun)
end

function roleBase.onPdashSlomo(role, dash, atkMis)
end

function roleBase.isPdashSlomo(role)
  local skAct = role.skAct
  return skAct and skAct:isDash() and skAct:isPdashSlomo()
end

function roleBase.canCounter(role)
  local skAct = role.skAct
  return skAct and skAct:isDash() and skAct:canCounter()
end

function roleBase.on_skill_link_start(role, npc)
  local ultMgr = role.ultMgr
  ultMgr:recordCloseUp(npc:get_behavior())
  if npc ~= role.npc then
    return
  end
  ultMgr:startCloseUp()
  ultMgr:popCloseUp()
end

function roleBase.on_before_skill_link_end(role, npc)
  if not role.ultMgr:checkIsOn() then
    return
  end
  local skAct = role.skAct
  if not skAct or not skAct:isUlt() then
    role:debugOutput("onCloseUpEnd is called out of ult act, current role.skAct is " .. tostring(skAct and skAct.name))
  end
  if skAct.onCloseUpEnd then
    return skAct:onCloseUpEnd()
  else
    role:debugOutput("onCloseUpEnd is lost, skAct is " .. skAct.name)
  end
end

function roleBase.onUltEnable(role)
  role.ultMgr:onUltEnable(role)
  if not role:isInControl() then
    role.tool:toggleTeamHeads(true)
  end
end

function roleBase.onUltDisable(role)
  role.ultMgr:onUltDisable(role)
end

function roleBase.isUltReady(role)
  return role.btns.ult.isEnable
end

function roleBase.cacheUlt(role, inputId)
  local ultMgr = role.ultMgr
  if ultMgr:isCached(role) then
    return
  end
  change_ult_effect(role.npc, 2)
  ultMgr:cache(role, inputId)
  ultMgr:tryCloseUp(role)
end

function roleBase.tryLinkQte(role, input_id)
  local linkQtes = role.linkQteActs
  local event = role._linkQteEvent
  local qte = linkQtes:choose(event)
  if not qte then
    return
  end
  qte:start(event)
end

function roleBase.clearCd(role)
  local skills = role.skills
  local typeNum = Const.VAR_TYPE.NUMBER
  for key, skill in pairs(skills) do
    if type(key) == typeNum and not skill:isUlt() then
      skill:clearCd()
    end
  end
end

function roleBase.getLinkStage(role)
  return role.linkMgr.stage
end

function roleBase.isRampage(role)
  return role.rampMgr:isOn()
end

function roleBase.onRampageEffect(role, stage, act)
end

function roleBase.onRampageStart(role, stage, act)
end

function roleBase.onRampageEnd(role, stage)
end

function roleBase.on_skill_link_timer_end(role, stage)
  if role:isInControl() then
    role.linkMgr:finishLink()
  end
end

function roleBase.switchHero(oldRole, inputId)
  if not oldRole.base.is_switch_enable then
    return
  end
  local newHero = get_scene_hero_by_poskey(inputId)
  local newRole = newHero and newHero:get_behavior()
  if not newRole then
    return
  end
  local roleAct = oldRole.skAct
  local tool = newRole.tool
  if not tool then
    Util.debug_output("newRole is found but tool is lost.", oldRole.id, newRole.id, inputId, newHero, newHero:get_behavior())
  end
  if roleAct:isUlt() and not roleAct.isCastOver then
    if newRole:isUltReady() then
      if roleAct.is_link_frame_passed then
        newRole.need_ult = true
        tool:changeRole(inputId, oldRole, newRole)
        newRole.need_ult = false
      else
        return newRole:cacheUlt(inputId)
      end
    end
  elseif newHero.by_ult_change then
    return tool:changeRole(inputId, nil, newRole)
  else
    return tool:changeRole(inputId, oldRole, newRole)
  end
end

function roleBase.chooseQte(newRole, event)
  return newRole.qteMgr:choose(event)
end

function roleBase.updateShowUpEvent(newRole)
  local oldRole = newRole.tool.curRole
  local event = newRole.showUpEvent
  event.isSwitch = true
  event.inputDir, event.faceDir = oldRole:inputDir()
  event.oldRole = oldRole
  return event
end

function roleBase.clearShowUpEvent(role)
  local event = role.showUpEvent
  for key, _ in pairs(event) do
    event[key] = nil
  end
end

function roleBase.toFront(newRole)
  local oldRole = newRole.tool.curRole
  local newRoleNpc = newRole.npc
  local qte = newRole:chooseQte(newRole:updateShowUpEvent())
  newRole.qte = qte
  local showUpPos = qte and qte:showUpPos()
  showUpPos = showUpPos and oldRole:fixPos(showUpPos, 0.1, newRoleNpc.radius)
  local animType = Const.CHANGE_HERO_ANIM_TYPE.IDLE
  if not qte and newRole:isInStay() then
    animType = Const.CHANGE_HERO_ANIM_TYPE.KEEP
  end
  change_hero_state(newRole.npc, Const.HERO_STATE.IN_CONTROL, nil, showUpPos, animType)
  if newRole.debugSwitch.switchHero then
    local target = newRole.target
    local oldRolePos = oldRole.npc:get_pos_vec3()
    local targetPos = target and target:get_pos_vec3()
    local str = ""
    if showUpPos then
      str = str .. "上场角色与前置角色距离为\t" .. (showUpPos - oldRolePos):Magnitude() .. "\n"
    end
    if targetPos then
      str = "前置角色与目标怪物距离为\t" .. (oldRolePos - targetPos):Magnitude() .. "\n"
    end
    if showUpPos and targetPos then
      str = str .. "上场角色与目标怪物距离为\t" .. (showUpPos - targetPos):Magnitude() .. "\n"
    end
    newRole:debugOutput(str)
  end
  return get_npc_pos(newRoleNpc, "Bip001 Chest"), showUpPos
end

function roleBase.toStay(role, inputId)
  if role:isInStay() then
    return
  end
  change_hero_state(role.npc, Const.HERO_STATE.IN_GROUND, inputId, nil, Const.CHANGE_HERO_ANIM_TYPE.KEEP)
end

function roleBase.toMelt(role, inputId)
  local roleNpc = role.npc
  if not role:isInStay() then
    role:toStay(inputId)
  end
  if role:isInMelt() then
    return
  end
  cast_magic(roleNpc, roleNpc, Const.SWITCH_CONFIG.TO_BACK_MELT_OUT_FX)
  cast_magic(roleNpc, roleNpc, Const.IGNORE_OTHER_COLLISION)
  cast_magic(roleNpc, roleNpc, Const.IGNORE_SELF_COLLISION)
end

function roleBase.toBack(role, inputId)
  if role:isInBack() then
    return
  end
  local pos = get_npc_pos(role.npc, "Bip001 Chest")
  change_hero_state(role.npc, Const.HERO_STATE.IN_BACKGROUND, inputId, nil, Const.CHANGE_HERO_ANIM_TYPE.IDLE)
  return role, pos
end

function roleBase.switchBack(oldRole, inputId)
  local canStay, noMelt = oldRole.skAct:canStay()
  if canStay then
    oldRole:toStay(inputId)
  elseif noMelt then
    return oldRole:toBack(inputId)
  else
    oldRole:toMelt(inputId)
  end
end

function roleBase.melt_out_begin(meltOutMagic, caster)
  local role = meltOutMagic.unit
  if role.npc == caster then
    role.in_melt = true
  end
end

function roleBase.melt_out_end(meltOutMagic, caster)
  local role = meltOutMagic.unit
  if role.npc == caster then
    role.in_melt = check_magic(caster, meltOutMagic.id)
    if role:isInStay() then
      role:toBack()
    end
  end
end

function roleBase.isInControl(role)
  return role.in_control
end

function roleBase.isInStay(role)
  return role.in_stay
end

function roleBase.isInMelt(role)
  return role.in_melt
end

function roleBase.isInRealStay(role)
  return role.in_stay and not role.in_melt
end

function roleBase.isInBack(role)
  return role.in_back
end

function roleBase.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  if npc ~= role.npc then
    return
  end
  if true == is_showup then
    role.tool:updateCurRole(role)
    role.in_control = true
    role.in_stay = false
    role.in_back = false
    do
      local qte = role.qte
      local event = role.showUpEvent
      if qte and qte:try(event, true) then
        role.qte = nil
        role.skAct:showUpFx(event)
      end
    end
    role:set_btn_mq_unique_listener()
    abort_magic_by_id(npc, Const.SWITCH_CONFIG.TO_BACK_MELT_OUT_FX)
    abort_magic_by_id(npc, Const.IGNORE_SELF_COLLISION)
    abort_magic_by_id(npc, Const.IGNORE_OTHER_COLLISION)
    abort_magic_by_id(npc, Const.IGNORE_SELF_COLLISION_TO_FRIEND)
    abort_magic_by_id(npc, Const.IGNORE_OTHER_COLLISION_TO_FRIEND)
    abort_magic_by_id(npc, Const.INVULNERABLE)
    change_follow_target(4)
    change_focus_follow_speed(5)
    set_can_searched(role.npc, true)
    role:updateUi()
    role:clearShowUpEvent()
    role:on_frame()
  else
    local is_control_to_back = role.in_control
    local is_stay_to_back = role.in_stay
    role.in_control = false
    role.in_stay = false
    role.in_back = true
    do
      local roleAct = role.skAct
      if not roleAct.isOver then
        roleAct:onBackground()
      end
    end
    set_can_searched(role.npc, false)
    if is_control_to_back then
      role.commonRole.set_value("共用目标", 20220125, role.target)
      hero_stop_move(npc)
      abort_magic_by_id(npc, 1999127)
      abort_magic_by_id(npc, 1999128)
      abort_magic_by_id(npc, Const.INDICATOR.SLOMO)
      abort_magic_by_id(npc, Const.INDICATOR.DARKEN)
      for _, btn in pairs(role.btns) do
        clear_skill_btn_charging(btn.id)
        local str = "Strengthen_skill_"
        stop_ui_fight_button_effect({
          str,
          btn.id2
        })
      end
    elseif is_stay_to_back then
      abort_magic_by_id(npc, Const.IGNORE_SELF_COLLISION)
      abort_magic_by_id(npc, Const.IGNORE_OTHER_COLLISION)
      abort_magic_by_id(npc, Const.IGNORE_SELF_COLLISION_TO_FRIEND)
      abort_magic_by_id(npc, Const.IGNORE_OTHER_COLLISION_TO_FRIEND)
      abort_magic_by_id(npc, Const.INVULNERABLE)
    end
    role:on_frame_background()
  end
end

function roleBase.on_hero_enter_ground_state(role, npc)
  if role.npc ~= npc then
    return
  end
  role.in_control = false
  role.in_stay = true
  role.in_back = false
  cast_magic(npc, npc, Const.INVULNERABLE)
  cast_magic(npc, npc, Const.IGNORE_OTHER_COLLISION_TO_FRIEND)
  cast_magic(npc, npc, Const.IGNORE_SELF_COLLISION_TO_FRIEND)
  hero_stop_move(npc)
  abort_magic_by_id(npc, 1999127)
  abort_magic_by_id(npc, 1999128)
  abort_magic_by_id(npc, Const.INDICATOR.SLOMO)
  abort_magic_by_id(npc, Const.INDICATOR.DARKEN)
  for _, btn in pairs(role.btns) do
    clear_skill_btn_charging(btn.id)
    local str = "Strengthen_skill_"
    stop_ui_fight_button_effect({
      str,
      btn.id2
    })
  end
  local skAct = role.skAct
  return skAct and skAct:onStay()
end

function roleBase.addToTeam(role)
  return role.tool:addRole(role)
end

function roleBase.removeFromTeam(role)
  return role.tool:removeRole(role)
end

function roleBase.updateUi(role)
  role:initSpecialBar()
  local lastRole = role.tool.lastRole
  local oldInputor = lastRole and lastRole.inputor
  role.inputor:resetUi(oldInputor)
  role:update_dying_fx()
  role.linkMgr:updateQteUi()
end

function roleBase.updateAct(role, act)
  local role = role
  role.preAct = role.skAct
  role.skAct = act
end

function roleBase.doCheck(role)
  local checkFuns = role.checkFuns
  if not checkFuns.checkActs(role) then
    return
  end
end

roleBase.checkFuns = {
  checkActs = function(role)
    do
      local motionCfgs = {}
      local npc = role.npc
      local modelCfg = npc.model_cfg
      
      local function getCfgName(animatorName)
        local cfgName = string.gsub(animatorName, ".overrideController", "")
        return "character.motion." .. cfgName
      end
      
      local cfgNames = {
        getCfgName(modelCfg.ControllerPath)
      }
      local extraPaths = modelCfg.ExtraControllerPath
      local insert = table.insert
      if extraPaths then
        for _, animatorName in pairs(extraPaths) do
          if "" ~= animatorName then
            insert(cfgNames, getCfgName(animatorName))
          end
        end
      end
      local cfg
      for _, cfgName in pairs(cfgNames) do
        cfg = ShareRes.create(cfgName)
        if cfg then
          insert(motionCfgs, cfg)
        else
          role:debugOutputB("动画机对应的位移导出文件丢失，配置名为%s", cfgName)
        end
      end
      role._motionCfgs = motionCfgs
    end
    local acts = role.skActs
    for _, act in pairs(acts) do
      if not act:check() then
        return false
      end
    end
    return true
  end
}

function roleBase.doCopy(role)
  local tool = role.tool
  tool:copySkills(role)
  tool:copyActs(role)
end

function roleBase.consume_reborn_chance(role)
  return role.rebornMgr:consume()
end

function roleBase.update_dying_fx(role, value)
  if value and role.is_low_hp == (value < 0) then
    return
  end
  local npc = role.npc
  local perc = get_npc_attr(npc, 1) / get_npc_attr(npc, 4)
  if perc <= 0.2 then
    return role:enbale_dying_fx()
  else
    return role:disable_dying_fx()
  end
end

function roleBase.enbale_dying_fx(role)
  role.is_low_hp = true
  local npc = role.npc
  local magic = Const.ROLE_DYING_FX
  local _, num = role.tool:checkMagicToTeam(magic)
  if 0 ~= num then
    return
  end
  return cast_magic(npc, npc, Const.ROLE_DYING_FX, 0)
end

function roleBase.disable_dying_fx(role)
  role.is_low_hp = false
  return role:isInControl() and role.tool:abortMagicToTeam(Const.ROLE_DYING_FX)
end

do
  local BEHIT_STATE_TYPE = Const.BEHIT_STATE_TYPE
  roleBase.do_behit_state_change = {
    [BEHIT_STATE_TYPE.ENTER_BEHIT] = function(role)
      return role.baseActs.hurt:try()
    end,
    [BEHIT_STATE_TYPE.BEHIT_CAN_COUNTER] = function(role)
      local types = Const.CHARACTER_STATE_TYPE
      if role:isInStatus(types.BEATTACK) then
        local state = role.npc.state_manager:get_cur_beattack_state()
        if state and state.v_behit2counter_trigger then
          return role.baseActs.hurt:tryDash()
        end
      elseif role:isInStatus(types.MOVE, types.IDLE) then
        role.baseActs.wander:try_pop_by_start()
      else
        return
      end
    end,
    [BEHIT_STATE_TYPE.BEHIT_CAN_CAST] = function(role)
      local types = Const.CHARACTER_STATE_TYPE
      if role:isInStatus(types.BEATTACK) then
        local state = role.npc.state_manager:get_cur_beattack_state()
        if state and state.v_behit2skill_move_trigger then
          return role.baseActs.hurt:trySkill()
        end
      elseif role:isInStatus(types.MOVE, types.IDLE) then
        role.baseActs.wander:try_pop_by_start()
      else
        return
      end
    end,
    [BEHIT_STATE_TYPE.ENTER_BEHITFLY] = function(role)
      return role.baseActs.hurtFly:try()
    end,
    [BEHIT_STATE_TYPE.ENTER_BEHITDOWN] = function(role)
      return role.baseActs.hurtFly:try()
    end,
    [BEHIT_STATE_TYPE.LIE_CAN_TURN_OVER] = function(role)
      local types = Const.CHARACTER_STATE_TYPE
      if role:isInStatus(types.FALL, types.FLY) then
        local baseActs = role.baseActs
        local hurtFly = baseActs.hurtFly
        if role.skAct ~= hurtFly then
          role:debugOutput("lie_can_turn_over is called without enter_beHitFly, curAct is " .. tostring(role.skAct and role.skAct.name))
          hurtFly:try()
        end
        local state = role.npc.state_manager:get_behitfly_state()
        if state and state.v_can_turn_over_trigger then
          return role.baseActs.hurtFly:tryTurnOver()
        end
      else
        return
      end
    end,
    [BEHIT_STATE_TYPE.ENTER_LIE] = function(role)
      return role.baseActs.lie:try()
    end,
    [BEHIT_STATE_TYPE.LIE_CAN_CAST] = function(role)
      local types = Const.CHARACTER_STATE_TYPE
      if role:isInStatus(types.FALL) then
        local state = role.npc.state_manager:get_behitfly_state()
        if state and state.v_cast_skill_event_trigger then
          return role.baseActs.lie:trySkill()
        end
      elseif role:isInStatus(types.MOVE, types.IDLE) then
        role.baseActs.wander:try_pop_by_start()
      else
        return
      end
    end,
    [BEHIT_STATE_TYPE.TURN_OVER_CAN_CAST] = function(role)
      local types = Const.CHARACTER_STATE_TYPE
      if role:isInStatus(types.TURN_OVER) then
        local state = role.npc.state_manager:get_turnover_state()
        if state and state.v_cast_skill_event_trigger then
          return role.baseActs.turnOver:trySkill()
        end
      elseif role:isInStatus(types.MOVE, types.IDLE) then
        role.baseActs.wander:try_pop_by_start()
      else
        return
      end
    end,
    [BEHIT_STATE_TYPE.ENTER_MOVE] = function(role)
      return role.baseActs.wander:try()
    end,
    [BEHIT_STATE_TYPE.ENTER_IDLE] = function(role)
      return role.baseActs.wander:try()
    end
  }
end

function roleBase.clearDashCd(role)
  local dashBase = role.skActBases.dash
  return dashBase:clearCd(role)
end

function roleBase.addQte(role, act, pos)
  if not act:isQte() then
    role:debugOutput("addQte is called, but input act is not a qte")
    return
  end
  local qteActs = role.qteActs
  local oldPos = UtilTable.table_find(qteActs, act)
  if oldPos then
    table.remove(qteActs, oldPos)
  end
  table.insert(qteActs, pos, act)
end

function roleBase.removeQte(role, act)
  local qteActs = role.qteActs
  local pos = UtilTable.table_find(qteActs, act)
  if not pos then
    return
  end
  table.remove(qteActs, pos)
end

function roleBase.inputDir(role)
  local input, face = role._inputDir, role._faceDir
  local _, joystickPos = get_joystick_target_pos(role.npc)
  if 0 == joystickPos.x and 0 == joystickPos.z then
    input = nil
  else
    input.x = joystickPos.x
    input.z = joystickPos.z
  end
  face:SetA(role.npc:get_dir_vec())
  return input and input:SetNormalize(), face
end

function roleBase.add_reborn_chance(role, magicId, prio, getLevel, allowRepeat)
  return role.rebornMgr:add_exclusive_chance(magicId, prio, role, getLevel, allowRepeat)
end

function roleBase.add_shared_reborn_chance(role, magicId, prio, getLevel, allowRepeat)
  return role.rebornMgr:add_shared_chance(magicId, prio, role, getLevel, allowRepeat)
end

function roleBase.isInUlt(role)
  local skAct = role.skAct
  if not skAct then
    return false
  end
  if skAct and skAct:isUlt() and not skAct.isCastOver and not skAct.isOver then
    return true
  else
    return false
  end
end

function roleBase.isInWander(role)
  return role.skAct == role.baseActs.wander
end

function roleBase.baseSearchConfig(role)
  return role.searchCfgBase:getDefaultCfg()
end

function roleBase.setTarget(role, newTarget, force_update_fx)
  role.tool:setTarget(role, newTarget, force_update_fx)
end

do
  local baseList = {}
  baseList.__index = baseList
  
  function baseList:clear()
    self.num = 0
  end
  
  function baseList:add(obj)
    local num = self.num + 1
    self[num] = obj
    self.num = num
  end
  
  local enemy_in_sector = setmetatable({}, baseList)
  enemy_in_sector.num = 0
  local enemy_in_sector_expand = setmetatable({}, baseList)
  enemy_in_sector_expand.num = 0
  local enemy_in_circle = setmetatable({}, baseList)
  enemy_in_circle.num = 0
  local enemy_angle_distribution = {
    num = 60,
    unit = 6.0,
    iDirIndex = 30.0,
    sectorHit = {
      num = 0,
      min = 60,
      max = 1
    },
    distance = {},
    hitList = {
      head = 1,
      tail = 0,
      midValue = 0,
      clear = function(self)
        self.head = 1
        self.tail = 0
      end,
      add = function(self, num, value)
        local tail = self.tail
        local finPos = tail + num
        for i = tail + 1, finPos do
          self[i] = value
        end
        self.tail = finPos
      end,
      remove = function(self, num)
        self.head = self.head + num
      end,
      updateMid = function(self)
        if self.head > self.tail then
          return
        end
        local sum = self.tail + self.head
        local mid = sum / 2
        if 0 == sum % 2 then
          self.midValue = self[mid]
        else
          mid = math.floor(mid)
          self.midValue = (self[mid] + self[mid + 1]) / 2
        end
      end
    },
    add = function(self, angle, distance)
      local i = math.ceil((angle + 180) / self.unit)
      local oldCount = self[i]
      if not oldCount then
        Log.Error("role_base.enemy_angle_distribution.add() is called with wrong angle ", tostring(angle), tostring(i), debug.traceback())
        return
      end
      self[i] = oldCount + 1
      local sectorHit = self.sectorHit
      if not sectorHit.first then
        sectorHit.first = i
      end
      if not sectorHit[i] then
        sectorHit.num = sectorHit.num + 1
        sectorHit[i] = true
      end
      if i < sectorHit.min then
        sectorHit.min = i
      end
      if i > sectorHit.max then
        sectorHit.max = i
      end
      self.distance[i] = self.distance[i] + distance
    end,
    clear = function(self)
      local sectorHit = self.sectorHit
      sectorHit.min = self.num
      sectorHit.max = 1
      sectorHit.num = 0
      sectorHit.first = nil
      for key, _ in pairs(sectorHit) do
        if type(key) == "number" then
          sectorHit[key] = nil
          self[key] = 0
          self.distance[key] = 0
        end
      end
      self.hitList:clear()
    end,
    fixIndex = function(self, index)
      if index > self.num then
        return index - self.num
      else
        return index
      end
    end,
    cluster = function(self, angle)
      local sectorHit = self.sectorHit
      local distanceList = self.distance
      local hitNum = sectorHit.num
      local unit = self.unit
      local fixIndex = self.fixIndex
      local abs = math.abs
      if 0 == hitNum then
        return nil
      elseif 1 == hitNum then
        return (sectorHit.first + 0.5) * unit - 180
      end
      local unitNum = self.num
      local range = angle / unit
      local deci
      range, deci = math.modf(range)
      if deci >= 0.5 then
        range = range + 1
      end
      local startPos, finPos = sectorHit.min, sectorHit.max
      local result
      if range >= finPos - startPos + 1 then
        result = (startPos - 1 + finPos) / 2
      else
        local maxClusterIndex = startPos
        local clusterMidIndex = range / 2 - 1
        local headClusterMidIndex, curClusterMidIndex
        headClusterMidIndex = fixIndex(self, startPos + clusterMidIndex)
        local maxClusterNum = 0
        local curClusterNum, maxClusterAsymmetry, curClusterAsymmetry
        local hitList = self.hitList
        local maxClusterDist = 0
        local curClusterDist
        local maxClusterAngle, curClusterAngle = unitNum, unitNum
        local iDirIndex = self.iDirIndex
        maxClusterAngle = abs(headClusterMidIndex - iDirIndex)
        local sectorHitNum
        for i = startPos, startPos + range - 1 do
          local j = fixIndex(self, i)
          sectorHitNum = self[j]
          if sectorHitNum > 0 then
            maxClusterNum = maxClusterNum + sectorHitNum
            maxClusterDist = maxClusterDist + distanceList[j]
            hitList:add(sectorHitNum, j)
          end
        end
        hitList:updateMid()
        maxClusterAsymmetry = abs(hitList.midValue - headClusterMidIndex)
        curClusterNum = maxClusterNum
        curClusterDist = maxClusterDist
        local headNum, tailNum, tailIndex
        for i = startPos + 1, finPos do
          headNum = self[i - 1]
          tailIndex = fixIndex(self, i - 1 + range)
          tailNum = self[tailIndex]
          if 0 ~= headNum or 0 ~= tailNum then
            curClusterNum = curClusterNum - headNum + tailNum
            curClusterDist = curClusterDist - distanceList[i - 1] + distanceList[tailIndex]
            hitList:remove(headNum)
            hitList:add(tailNum, tailIndex)
            hitList:updateMid()
          end
          curClusterAngle = false
          curClusterAsymmetry = false
          if maxClusterNum < curClusterNum then
            goto lbl_204
          elseif maxClusterNum > curClusterNum then
            goto lbl_231
          elseif 0 == curClusterNum then
            goto lbl_231
          end
          curClusterMidIndex = fixIndex(self, i + clusterMidIndex)
          curClusterAsymmetry = abs(hitList.midValue - curClusterMidIndex)
          if maxClusterAsymmetry > curClusterAsymmetry then
            goto lbl_204
          elseif maxClusterAsymmetry < curClusterAsymmetry then
            goto lbl_231
          end
          if maxClusterDist > curClusterDist then
            goto lbl_204
          elseif maxClusterDist < curClusterDist then
            goto lbl_231
          end
          curClusterAngle = abs(curClusterMidIndex - iDirIndex)
          if maxClusterAngle <= curClusterAngle then
          else
            ::lbl_204::
            maxClusterNum = curClusterNum
            maxClusterIndex = i
            if curClusterAsymmetry then
              maxClusterAsymmetry = curClusterAsymmetry
            else
              curClusterMidIndex = fixIndex(self, i + clusterMidIndex)
              maxClusterAsymmetry = abs(hitList.midValue - curClusterMidIndex)
            end
            if curClusterAngle then
              maxClusterAngle = curClusterAngle
            else
              maxClusterAngle = abs(curClusterMidIndex - iDirIndex)
            end
          end
          ::lbl_231::
        end
        if maxClusterNum <= 1 then
          return nil
        end
        result = fixIndex(self, maxClusterIndex - 1 + range / 2)
      end
      return result * unit - 180
    end
  }
  for i = 1, enemy_angle_distribution.num do
    enemy_angle_distribution[i] = 0
    enemy_angle_distribution.distance[i] = 0
  end
  local iDir = vec3.New()
  local __oriPos = vec3.New()
  roleBase.defaultSearchCfg = searchCfgBase:getDefaultCfg()
  
  function roleBase.searchNpc(role, config, oriPos, btn, param)
    local debugSwitch = role.debugSwitch.searchTarget
    config = config or role.defaultSearchCfg
    local tarPos = role._tarPos
    local newTarget
    local roleNpc = role.npc
    local rolePos = roleNpc:get_pos_vec3()
    oriPos = oriPos or rolePos
    __oriPos.x, __oriPos.z = oriPos.x, oriPos.z
    oriPos = __oriPos
    local noInput
    if not btn then
      iDir.x = Global.camera_joystick_x
      iDir.z = Global.camera_joystick_y
      if 0 == iDir.x and 0 == iDir.z then
        noInput = true
        tarPos = nil
        iDir:SetA(roleNpc:get_dir_vec())
      else
        iDir.y = 0
        iDir:SetNormalize()
        tarPos.x = rolePos.x + iDir.x * 10
        tarPos.y = rolePos.y
        tarPos.z = rolePos.z + iDir.z * 10
      end
    else
      noInput = not btn:isDrag()
      iDir:SetA(btn:indiPos())
      if 0 == iDir.x and 0 == iDir.z then
        tarPos = nil
        iDir:SetA(roleNpc:get_dir_vec())
      else
        tarPos.x = iDir.x
        tarPos.z = iDir.z
        tarPos.y = rolePos.y
        iDir.x = iDir.x - oriPos.x
        iDir.z = iDir.z - oriPos.z
        iDir.y = 0
        iDir:SetNormalize()
      end
    end
    if not param then
      if btn then
        param = config.indi
      elseif noInput then
        param = config.noInput
      else
        param = config.directional
      end
    end
    local densityConfig = param.density
    local distConfig = param.dist
    local angleConfig = param.angle
    local viscousConfig = param.viscous
    local hpConfig = param.hp
    local dedupConfig = param.dedup
    local occlusConfig = param.occlus
    local customConfig = param.custom
    local secRadius = config.secRadius or -1
    local secAngle = config.secAngle or -1
    local maxDis = config.maxDis or -1
    local enemy_in_sector = enemy_in_sector
    local enemy_in_sector_expand = enemy_in_sector_expand
    local enemy_in_circle = enemy_in_circle
    local enemy_angle_distribution = enemy_angle_distribution
    enemy_in_sector:clear()
    enemy_in_sector_expand:clear()
    enemy_in_circle:clear()
    local sec_range_valid = secRadius > 0 and secAngle > 0
    if sec_range_valid then
      enemy_in_sector:clear()
    end
    local circle_range_valid = maxDis > 0
    if circle_range_valid then
      enemy_in_circle:clear()
    end
    local density_weight_valid = densityConfig and densityConfig.enable
    local hp_weight_valid = hpConfig and hpConfig.enable
    local dist_weight_valid = distConfig and distConfig.enable
    local angle_weight_valid = angleConfig and angleConfig.enable
    local oldTarget = role.target
    local viscous_weight_valid = viscousConfig and viscousConfig.enable and oldTarget
    local dedup_weight_valid = dedupConfig and dedupConfig.enable
    local occlus_weight_valid = occlusConfig and occlusConfig.enable
    local sectorHit = false
    local oRadius = oriPos and 0 or roleNpc.radius
    local expandAngle = densityConfig and densityConfig.halfAngle or 45
    local secAngleExp = sec_range_valid and secAngle + expandAngle
    local ePos
    local maxHpSector = 1
    local maxHpCircle = 1
    local uuid_map = SceneMgr:get_all_char()
    local lock_mask = Const.LOCK_MASK
    local lock_mask_in_fight = Const.LOCK_MASK_IN_FIGHT
    local isInFight = role:isInBattle()
    for _, obj in pairs(uuid_map) do
      if not (not obj:is_destroy() and obj.magic_mgr and not check_magic(obj, lock_mask) and (not isInFight or not check_magic(obj, lock_mask_in_fight)) and obj:can_update() and roleNpc.uuid ~= obj.uuid and roleNpc:get_camp() ~= obj:get_camp() and obj:is_can_searched()) or obj:is_die() then
      else
        ePos = obj:get_pos_vec3()
        if math.abs(ePos.y - rolePos.y) > 10 then
        else
          if debugSwitch then
            local monster = obj.get_behavior and obj:get_behavior()
            if monster.activate_role_target_weight_panel then
              monster:activate_role_target_weight_panel(false)
            end
          end
          obj.d_oeDir = obj.d_oeDir or vec3.New()
          obj.d_oeDir:Set(ePos.x - oriPos.x, 0, ePos.z - oriPos.z)
          obj.d_oeLength = obj.d_oeDir:Magnitude()
          obj.d_radius = obj.radius or 0
          obj.d_oeDis = obj.d_oeLength - oRadius - obj.d_radius
          obj.d_oeDis = math.max(obj.d_oeDis, 0)
          if obj.d_oeDis > 0.01 then
            obj.d_oeDir:Div(obj.d_oeLength)
            obj.d_ieAngle = iDir:AngleRaw(obj.d_oeDir)
          else
            obj.d_oeDir:SetA(iDir)
            obj.d_ieAngle = 0
          end
          obj.d_hp = obj.attr_mgr:get_hp()
          if noInput or not sec_range_valid then
          elseif secRadius >= obj.d_oeDis then
            if density_weight_valid and secAngleExp > obj.d_ieAngle then
              enemy_in_sector_expand:add(obj)
            end
            if secAngle > obj.d_ieAngle then
              enemy_in_sector:add(obj)
              sectorHit = true
              if maxHpSector < obj.d_hp then
                maxHpSector = obj.d_hp
              end
            end
          end
          if sectorHit then
          elseif circle_range_valid and maxDis >= obj.d_oeDis then
            enemy_in_circle:add(obj)
            if maxHpCircle < obj.d_hp then
              maxHpCircle = obj.d_hp
            end
          end
        end
      end
    end
    local tarList, clusterAngle
    if density_weight_valid then
      tarList = sectorHit and enemy_in_sector_expand or enemy_in_circle
      local tool = role.tool
      local densityMaxDis = densityConfig.maxDis
      for i = 1, tarList.num do
        local tar = tarList[i]
        local sign = tool.vectCross(tar.d_oeDir, iDir) >= 0
        tar.d_ieAngleSigned = sign and tar.d_ieAngle or -tar.d_ieAngle
        if densityMaxDis > tar.d_oeDis then
          enemy_angle_distribution:add(tar.d_ieAngleSigned, tar.d_oeDis)
        end
      end
      clusterAngle = enemy_angle_distribution:cluster(densityConfig.maxAngle)
    end
    local maxHp
    if sectorHit then
      tarList = enemy_in_sector
      maxHp = maxHpSector
    else
      tarList = enemy_in_circle
      maxHp = maxHpCircle
    end
    local tarRecord = dedup_weight_valid and config:getTarRecord()
    local isInScreen = occlus_weight_valid and Util.is_obj_in_screen
    local mininteger = math.mininteger
    local maxWeight_total = mininteger
    local maxWeight_custom, maxWeight_custom_npc = mininteger
    local maxWeight_hp, maxWeight_hp_npc = mininteger
    local maxWeight_density, maxWeight_density_npc = mininteger
    local maxWeight_angle, maxWeight_angle_npc = mininteger
    local maxWeight_dist, maxWeight_dist_npc = mininteger
    local maxWeight_dedup, maxWeight_dedup_npc, maxWeight_viscous_npc, weight_total, weight_custom, weight_hp, weight_density, weight_angle, weight_dist, weight_viscous, weight_dedup, weight_occlus, ieAngleSinged, deltaAngle, ieAngle, oeDis = mininteger
    for i = 1, tarList.num do
      local obj = tarList[i]
      weight_total = 0
      if hp_weight_valid then
        weight_hp = hpConfig.weight * obj.d_hp / maxHp
        weight_total = weight_total + weight_hp
        if debugSwitch then
          obj.d_role_target_weight_hp = weight_hp
          if maxWeight_hp < weight_hp then
            maxWeight_hp = weight_hp
            maxWeight_hp_npc = obj
          end
        end
      end
      if density_weight_valid and clusterAngle then
        ieAngleSinged = obj.d_ieAngleSigned
        deltaAngle = math.abs(ieAngleSinged - clusterAngle)
        deltaAngle = deltaAngle <= 180 and deltaAngle or 360 - deltaAngle
        weight_density = densityConfig.weight + densityConfig.ratio * deltaAngle
        weight_total = weight_total + weight_density
        if debugSwitch then
          obj.d_role_target_weight_density = weight_density
          if maxWeight_density < weight_density then
            maxWeight_density = weight_density
            maxWeight_density_npc = obj
          end
        end
      end
      if angle_weight_valid then
        ieAngle = obj.d_ieAngle
        weight_angle = angleConfig.weight + angleConfig.ratio * ieAngle
        weight_total = weight_total + weight_angle
        if debugSwitch then
          obj.d_role_target_weight_angle = weight_angle
          if maxWeight_angle < weight_angle then
            maxWeight_angle = weight_angle
            maxWeight_angle_npc = obj
          end
        end
      end
      if dist_weight_valid then
        oeDis = obj.d_oeDis
        weight_dist = distConfig.weight + distConfig.ratio * math.abs(oeDis - distConfig.idealDis)
        weight_total = weight_total + weight_dist
        if debugSwitch then
          obj.d_role_target_weight_dist = weight_dist
          if maxWeight_dist < weight_dist then
            maxWeight_dist = weight_dist
            maxWeight_dist_npc = obj
          end
        end
      end
      if viscous_weight_valid and obj == role.target then
        weight_viscous = viscousConfig.weight
        weight_total = weight_total + weight_viscous
        if debugSwitch then
          obj.d_role_target_weight_viscous = weight_viscous
          maxWeight_viscous_npc = obj
        end
      end
      if dedup_weight_valid then
        local deltaIdx, deltaTime = tarRecord:getDelta(obj)
        if deltaIdx and deltaTime then
          weight_dedup = dedupConfig.weight + dedupConfig.idxRatio * deltaIdx + dedupConfig.timeRatio * deltaTime
        else
          weight_dedup = 0
        end
        if weight_dedup * dedupConfig.weight < 0 then
          weight_dedup = 0
        end
        weight_total = weight_total + weight_dedup
        if debugSwitch then
          obj.d_role_target_weight_dedup = weight_dedup
          if maxWeight_dedup < weight_dedup then
            maxWeight_dedup = weight_dedup
          end
        end
      end
      if occlus_weight_valid and not isInScreen(obj) then
        weight_occlus = occlusConfig.cullWeight
        weight_total = weight_total + weight_occlus
        if debugSwitch then
          obj.d_role_target_weight_occlus = weight_occlus
        end
      end
      if customConfig then
        weight_custom = customConfig(role, obj) or 0
        weight_total = weight_total + weight_custom
        if debugSwitch then
          obj.d_role_target_weight_custom = weight_custom
          if maxWeight_custom < weight_custom then
            maxWeight_custom = weight_custom
            maxWeight_custom_npc = obj
          end
        end
      end
      obj.d_role_target_weight_total = weight_total
      if maxWeight_total < weight_total then
        maxWeight_total = weight_total
        newTarget = obj
      end
    end
    if newTarget then
      tarPos = role._tarPos
      tarPos:SetA(newTarget:get_pos_vec3())
      if tarRecord then
        tarRecord:add(newTarget)
      end
    end
    if debugSwitch then
      do
        local unity = CS.UnityEngine
        local cube = role._debugCube
        local cubeLR = role._debugCubeLR
        local cubeDensity = role._debugCubeDensity
        local emptyObj = role._debugEmptyObj
        if not cube then
          cube = unity.GameObject.CreatePrimitive(unity.PrimitiveType.Cube)
          cube.name = "role_debugCube"
          cubeLR = unity.GameObject.CreatePrimitive(unity.PrimitiveType.Cube)
          cubeLR.name = "role_debugCubeLR"
          role.base._debugCube = cube
          role.base._debugCubeLR = cubeLR
          cube.transform.localScale = unity.Vector3(0.1, 0.1, 20)
          cubeLR.transform.localScale = unity.Vector3(5, 0.1, 0.1)
          emptyObj = unity.GameObject("role_debugEmptyObj")
          role.base._debugEmptyObj = emptyObj
        end
        if not cubeDensity then
          cubeDensity = unity.GameObject.CreatePrimitive(unity.PrimitiveType.Cube)
          cubeDensity.name = "role_debugCubeDensity"
          role.base._debugCubeDensity = cubeDensity
          cubeDensity.transform.localScale = unity.Vector3(0.1, 0.1, 20)
        end
        cube.transform.position = unity.Vector3(oriPos.x, oriPos.y, oriPos.z)
        cubeLR.transform.position = unity.Vector3(oriPos.x, oriPos.y, oriPos.z)
        cubeDensity.transform.position = unity.Vector3(oriPos.x, oriPos.y, oriPos.z)
        local emptyObjPos = oriPos + iDir * 10
        emptyObj.transform.position = unity.Vector3(emptyObjPos.x, emptyObjPos.y, emptyObjPos.z)
        cube.transform:LookAt(emptyObj.transform)
        cubeLR.transform:LookAt(emptyObj.transform)
        cube.transform.position = emptyObj.transform.position
        if not clusterAngle then
          cubeDensity:SetActive(false)
        else
          local alpha = math.rad(-clusterAngle)
          emptyObjPos.x = iDir.x * math.cos(alpha) - iDir.z * math.sin(alpha)
          emptyObjPos.z = iDir.x * math.sin(alpha) + iDir.z * math.cos(alpha)
          local densityMaxLength = densityConfig.maxDis
          emptyObjPos = oriPos + emptyObjPos * (densityMaxLength / 2)
          emptyObj.transform.position = unity.Vector3(emptyObjPos.x, emptyObjPos.y, emptyObjPos.z)
          cubeDensity.transform:LookAt(emptyObj.transform)
          cubeDensity.transform.position = emptyObj.transform.position
          cubeDensity.transform.localScale = unity.Vector3(0.1, 0.1, densityMaxLength)
          cubeDensity:SetActive(true)
        end
      end
      for i = 1, tarList.num do
        local obj = tarList[i]
        local monster = obj.get_behavior and obj:get_behavior()
        if not monster then
        elseif monster.activate_role_target_weight_panel then
          monster:activate_role_target_weight_panel(true)
          monster:print_role_target_weight_info(maxWeight_custom_npc, maxWeight_hp_npc, maxWeight_density_npc, maxWeight_angle_npc, maxWeight_dist_npc, maxWeight_viscous_npc, dedup_weight_valid, newTarget)
        end
      end
    end
    local debugPause = role.debugSwitch.searchTargetPause
    if debugPause and not Util.is_in_loading() and (2 == debugPause or not config.bIsTick) then
      role:debugOutput("role.searchPause is triggered by :", tostring(config.name))
      CS.UnityEngine.Time.timeScale = 0
      Global.stop_update = true
    end
    if density_weight_valid then
      enemy_angle_distribution:clear()
    end
    return newTarget, tarPos
  end
  
  function roleBase.searchTarget(role, config, oriPos, btn, param)
    local target, tarPos = role:searchNpc(config, oriPos, btn, param)
    role:setTarget(target)
    return tarPos, target
  end
  
  function roleBase.isTeamInBattle(role)
    return role.tool:isInBattle()
  end
  
  function roleBase.isInBattle(role)
    if role:isInBack() or role:isInMelt() then
      return false
    end
    if role.target and not check_magic(role.target, Const.LOCK_MASK_IN_FIGHT) then
      return true
    end
    if not UtilTable.is_empty(role.npc:get_betargetd_map()) then
      return true
    end
    return false
  end
  
  function roleBase.xRay(base)
    if base ~= roleBase then
      Log.Error("roleBase.xRay input is wrong ", debug.traceback())
      return
    end
    if base.needXray then
      return
    end
    base.needXray = true
    base.tool:castMagicToTeam(Const.XRAY.ROLE)
  end
  
  function roleBase.clearXray(base)
    if base ~= roleBase then
      Log.Error("roleBase.clearXray input is wrong ", debug.traceback())
      return
    end
    if not base.needXray then
      return
    end
    base.needXray = false
    base.tool:abortMagicToTeam(Const.XRAY.ROLE)
  end
  
  function roleBase.set_move_scale(role, animName, newScaleZ, newScaleX)
    if not animName then
      Log.Error("anim name is nil, ", debug.traceback())
      return
    end
    local moveScale = role.moveScale
    local animScale = moveScale[animName] or role.moveScaleBackUp[animName] or {}
    moveScale[animName] = animScale
    if newScaleZ then
      local oldScaleZ = animScale.z
      if not oldScaleZ then
        oldScaleZ = {}
        local animCfg = ShareRes.create("character.motion.H" .. role.id)[animName]
        if not animCfg then
          role:debugOutput(animName .. " anim not found, ")
          return
        end
        local length = #animCfg.OffsetZ
        for i = 1, length do
          oldScaleZ[i] = 1
        end
        animScale.z = oldScaleZ
      end
      local length = #oldScaleZ
      if type(newScaleZ) == "table" then
        for i = 1, length do
          oldScaleZ[i] = newScaleZ[i] or 1
        end
        oldScaleZ.scale = nil
      elseif type(newScaleZ) == "number" then
        if oldScaleZ.scale ~= newScaleZ then
          for i = 1, length do
            oldScaleZ[i] = newScaleZ
          end
          oldScaleZ.scale = newScaleZ
        end
      else
        Log.Error("input scaleZ is in wrong type, ", debug.traceback())
      end
    end
    if newScaleX then
      local oldScaleX = animScale.x
      if not oldScaleX then
        oldScaleX = {}
        local animCfg = ShareRes.create("character.motion.H" .. role.id)[animName]
        if not animCfg then
          role:debugOutput(animName .. " anim not found, ")
          return
        end
        local length = #animCfg.OffsetX
        for i = 1, length do
          oldScaleX[i] = 1
        end
        animScale.x = oldScaleX
      end
      local length = #oldScaleX
      if type(newScaleX) == "table" then
        for i = 1, length do
          oldScaleX[i] = newScaleX[i] or 1
        end
        oldScaleX.scale = nil
      elseif type(newScaleX) == "number" then
        if oldScaleX.scale ~= newScaleX then
          for i = 1, length do
            oldScaleX[i] = newScaleX
          end
          oldScaleX.scale = newScaleX
        end
      else
        Log.Error("input scaleX is in wrong type, ", debug.traceback())
      end
    end
    set_move_offsets_multi_map(role.npc, role.moveScale)
  end
  
  function roleBase.clear_move_scale(role, animName)
    local moveScale = role.moveScale
    local moveScaleBackUp = role.moveScaleBackUp
    if not animName then
      for animName, scaleCfg in pairs(moveScale) do
        moveScale[animName] = nil
        moveScaleBackUp[animName] = scaleCfg
      end
      set_move_offsets_multi_map(role.npc)
      return
    end
    local animScale = moveScale[animName]
    if not animScale then
      return
    end
    moveScaleBackUp[animName] = animScale
    moveScale[animName] = nil
    set_move_offsets_multi_map(role.npc, moveScale)
  end
  
  function roleBase.initSpecialBar(role)
    local spBar = role.spBar
    if not spBar then
      set_ui_object_visible("fight", "SpecialBar", false)
    elseif "bar" == spBar then
      init_special_fight_ui(1, nil, nil, role.npc.uuid)
      set_ui_object_visible("fight", "SpecialBar", true)
    else
      spBar:init()
    end
  end
  
  function roleBase.hideSpBar(role, needClear)
    local spBar = role.spBar
    if not spBar then
      return
    end
    if "bar" == spBar then
      if needClear then
        cast_magic(role.npc, role.npc, Const.ATTR.CLEAR74)
      end
      if not role:isInControl() then
        return
      end
      set_ui_object_visible("fight", "SpecialBar", false)
    else
      spBar:hide(needClear)
    end
  end
  
  function roleBase.showSpBar(role)
    local spBar = role.spBar
    if not spBar then
      return
    end
    if "bar" == spBar then
      if not role:isInControl() then
        return
      end
      init_special_fight_ui(1, nil, nil, role.npc.uuid)
      set_ui_object_visible("fight", "SpecialBar", true)
    else
      spBar:show()
    end
  end
  
  function roleBase.updateAttr(role)
    role.attr[2] = get_npc_attr(role.npc, 2)
    role.attr[74] = get_npc_attr(role.npc, 74)
    role.attr[108] = get_npc_attr(role.npc, 108)
  end
  
  function roleBase.doAfter(role, func, delay, isUpdateBackground, ...)
    role.doAfterMgr:add(func, delay, isUpdateBackground, ...)
  end
  
  function roleBase.costAttr2(role, num)
    cast_magic(role.npc, role.npc, Const.ATTR.COST2, num)
  end
  
  function roleBase.faint(role, time, switchMaskTime)
    local act = role.skActs.faint
    if not act then
      Log.Error(role.npc:get_hero_name() .. ".faint is called, but skActs.faint is lost")
      return false
    end
    if check_npc_die(role.npc) then
      return
    end
    act:start(time, switchMaskTime)
  end
  
  function roleBase.faintFinish(role)
    local act = role.skActs.faint
    if not act then
      Log.Error(role.npc:get_hero_name() .. ".faint is called, but skActs.faint is lost")
      return false
    end
    act:finish()
  end
  
  function roleBase.set_switch_hero_enable(base, isEnable)
    roleBase.is_switch_enable = isEnable
  end
  
  function roleBase.enable_input_protect(role, clearCache, type)
    return role.inputor:setIPtype(type or Const.INPUT_PROTECT_TYPE.BLOCK_INPUT, clearCache)
  end
  
  function roleBase.disable_input_protect(role)
    return role.inputor:setIPtype()
  end
  
  function roleBase.enable_move_ip(role)
    return set_ban_skill_to_move(role.npc, true)
  end
  
  function roleBase.disable_move_ip(role)
    return set_ban_skill_to_move(role.npc, false)
  end
  
  function roleBase.disableInput(role)
    role.inputor:disable()
    role.on_input_backup = rawget(role, "on_input")
    role.on_touch_up_backup = rawget(role, "on_touch_up")
    local nilFun = Const.NIL_FUN
    role.on_input = nilFun
    role.on_touch_up = nilFun
  end
  
  function roleBase.enableInput(role)
    role.inputor:enable()
    role.on_input = role.on_input_backup
    role.on_touch_up = role.on_touch_up_backup
  end
  
  function roleBase.set_btn_mq_unique_listener(role)
    local tool = role.tool
    tool.set_btn_mq_unique_listener(tool, role)
  end
  
  function roleBase.change_follow_target(role, follow_target_type, npc, param)
    if not role:isInControl() then
      return
    end
    change_follow_target(follow_target_type, npc, param)
  end
  
  function roleBase.change_follow_target_new(role, follow_target_type, npc, param)
    if not role:isInControl() then
      return
    end
    change_follow_target_new(follow_target_type, npc, param)
  end
  
  function roleBase.keep_focus_pos_by_clear_target(role)
    if not role:isInControl() then
      return
    end
    keep_focus_pos_by_clear_target()
  end
  
  function roleBase.gm_get_skill_actions(role)
    local list = {}
    local skActs = role.skActs
    for key, act in pairs(skActs) do
      if type(key) == "string" then
        table.insert(list, act.name)
      end
    end
    table.sort(list)
    return list
  end
  
  function roleBase.gm_cast_skill_action(role, skActName, arg2, arg3)
    local isReady = skillBase.isReady
    
    function skillBase.isReady()
      return true
    end
    
    local skAct = role.skActs[skActName]
    if not skAct then
      role:debugOutput("roleBase.gm_cast_skill_action is called , but skAct is not found, input skAct name is " .. tostring(skActName))
      skillBase.isReady = isReady
      return
    end
    skAct:start()
    skillBase.isReady = isReady
  end
  
  function roleBase.missile_skill_action_info(role, missileId)
    local skId = math.floor(missileId / 100)
    local skill = role.skills[skId]
    return skill and skill:skInfo()
  end
  
  function roleBase.force_shift_magic_init(role, magicId, target)
  end
end

function roleBase.on_tp_room_finish(role)
  role:addMagic(Const.ATTR.FILL2)
  if role:isInControl() then
    return role.linkMgr:initUi()
  elseif role:isInStay() then
    return role:toBack()
  end
end

function roleBase.onBtnDrag(role, isDrag, id)
  local indiMgr = role.indiMgr
  local btn = role.btns[id]
  indiMgr:onBtnDrag(isDrag, btn)
end

function roleBase.on_npc_born(role, npc)
  if role.npc ~= get_come_on_hero() then
    return
  end
  return role.linkMgr:on_npc_born(npc)
end

function roleBase.on_start(role)
  role.god_npc = get_god_npc()
  if role.base.needXray then
    cast_magic(role.npc, role.npc, Const.XRAY.ROLE, 1)
  end
  return role.behaviorBase.on_start(role)
end

function roleBase.on_born_behavior(role)
  if role.bFinishBorn then
    return false
  end
  if GAME_DEBUG and Util.is_client_only() then
    role:doCheck()
  end
  role:doCopy()
  do
    local developMap = role.developMap
    local debugSwitch = role.debugSwitch
    role.traceLv = role.npc.d_debug_traceLv or debugSwitch.traceLv or developMap.trace[get_develop_level(role.npc, 5)]
    role.destinyLv = role.npc.d_debug_destinyLv or debugSwitch.destinyLv or developMap.destiny[get_develop_level(role.npc, 2)]
    if role.npc.d_debug_spWeaponLv then
      role.spWeapon.lv = role.npc.d_debug_spWeaponLv
    elseif debugSwitch.spWeaponLv then
      role.spWeapon.lv = debugSwitch.spWeaponLv
    elseif 0 ~= get_develop_level(role.npc, 4) then
      role.spWeapon.lv = get_develop_level(role.npc, 3)
    end
    for i = 0, role.traceLv do
      role.traces[i](role, role.tool, role.skills, role.skActs, role.icons, role.btns, role.misLogics, role.magics)
    end
    for i = 0, role.destinyLv do
      role.destinies[i](role, role.tool, role.skills, role.skActs, role.icons, role.btns, role.misLogics, role.magics)
    end
    if role.spWeapon.lv > 0 then
      role.spWeapon.fun(role, role.tool, role.skills, role.skActs, role.icons, role.btns, role.misLogics, role.magics)
    end
  end
  set_ult_skill_enabled(role.npc, false)
  role:onUltDisable()
  do
    local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
    local BOUND_CATCH_NPC = MISSILE_EVT_TYPE.BOUND_CATCH_NPC
    local BOUND_RELEASE_NPC = MISSILE_EVT_TYPE.BOUND_RELEASE_NPC
    for key, misLogic in pairs(role.misLogics) do
      local id = misLogic.id
      if misLogic.onCollideObs and type(key) == "number" then
        listen_missile_collide_obstacle(role.npc, id, role.on_missile_collide_obstacle, role)
      end
      if misLogic.onEnter and type(key) == "number" then
        listen_missile_evt(BOUND_CATCH_NPC, role.npc, id, role.on_npc_enter_missile, role)
      end
      if misLogic.onLeave and type(key) == "number" then
        listen_missile_evt(BOUND_RELEASE_NPC, role.npc, id, role.on_npc_leave_missile, role)
      end
    end
  end
  if role.debugSwitch.ignoreUltCost then
    local npc = role.npc
    cast_magic(npc, npc, Const.ATTR.FILL108)
    for key, skill in pairs(role.skills) do
      if type(key) == Const.VAR_TYPE.NUMBER and 5 == skill.cfg.SkillType then
        set_skill_ignore_expend_detect(npc, key, true)
      end
    end
  end
  listen_attr_change_mq(role.npc, 1, role.on_hp_change, role)
  local hasAnim
  if get_come_on_hero() == role.npc then
    role.tool.curRole = role
    role.in_control = true
    role.ultMgr:reset()
    role.linkMgr:reset()
    role:set_btn_mq_unique_listener()
    role:initSpecialBar()
    if not cancel_born_skill() and not role.debugSwitch.skipBorn then
      local born = role.bornActs:choose()
      if is_hero_in_ground(role.npc) and born then
        born:start()
        hero_born_finish(born.strSks[1].id)
        role.npc:set_guid_arrow_visible(false)
        hasAnim = true
      end
    end
    set_can_searched(role.npc, true)
  else
    set_can_searched(role.npc, false)
  end
  role.bFinishBorn = true
  return hasAnim
end

function roleBase.on_hero_reborn(role, npc)
  if npc ~= role.npc then
    return
  end
  role:enableInput()
  cast_magic(npc, npc, Const.REBORN_INVUL, 0)
  cast_magic(npc, npc, Const.ATTR.FILL74, 0)
  cast_magic(npc, npc, Const.ATTR.FILL108, 0)
  local ultBtn = role.btns.ult
  local ultIcon = ultBtn.icon
  ultIcon.updateEnable = ultIcon.updateEnableBackUp
  if npc == get_come_on_hero() then
    ultIcon:updateEnable()
    ultBtn:drawEnable()
  else
    ultBtn:drawEnableBackGround()
    local index
    if npc == get_scene_hero_by_poskey(21) then
      index = 1
    elseif npc == get_scene_hero_by_poskey(22) then
      index = 2
    end
    if index then
      set_team_head_object_visible(index, "EnergyList", true)
    end
  end
  role.baseActs.wander:start()
end

function roleBase.on_input(role, input_id)
  local INPUT_CODE = Const.INPUT_CODE
  if input_id == INPUT_CODE.QTE1 or input_id == INPUT_CODE.QTE2 then
    return role:switchHero(input_id)
  end
  if input_id == INPUT_CODE.SPECAIL_SKILL then
    return role:tryLinkQte(input_id)
  end
  return role.inputor:onBtnDown(input_id)
end

function roleBase.on_frame(role)
  role.doAfterMgr:update()
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
  role:updateAttr()
  role.skAct:tick()
  role.inputor:tick()
  role.indiMgr:tick()
end

function roleBase.on_frame_ground(role)
  local baseActs = role.baseActs
  for _, act in pairs(baseActs) do
    if role.skAct ~= act and act:isReady() then
      act:start()
    end
  end
  role.doAfterMgr:update()
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
  role:updateAttr()
  role.skAct:tick()
end

function roleBase.on_frame_background(role)
  role:updateAttr()
  role.doAfterMgr:updateBackground()
  role.btns.ult:drawEnableBackGround()
end

function roleBase.on_touch_up(role, output_id, iscancel, input_time)
  if iscancel then
    role.inputor:onBtnCancelUp(output_id)
  else
    role.inputor:onBtnUp(output_id)
  end
end

function roleBase.on_skill_begin(role, npc, skill_id, skill_type)
  if npc ~= role.npc then
    return
  end
  role.skills[skill_id]:onBegin()
end

function roleBase.on_skill_before_time(role, skill_id)
  local skill = role.skills[skill_id]
  if not skill then
    return
  end
  skill:onBefTime()
end

function roleBase.on_skill_cast_time(role, skill_id)
  local skill = role.skills[skill_id]
  if not skill then
    return
  end
  skill:onCastTime()
end

function roleBase.on_missile_begin_pos(role, owner, pos_x, pos_z, missile_cfg, missile)
  local id = missile_cfg.Id
  local misLogics = role.misLogics
  local misLogic = misLogics[id]
  if not misLogic or not misLogic.onBegin then
    return
  end
  misLogic:onBegin(missile, owner, pos_x, pos_z)
end

function roleBase.before_damage(role, caster, target, magicId, damage_sign, damage_type, target_camp, change_level, magic_level, skillId, misInst)
  local magic = role.magics[magicId]
  if magic and magic.befDamage then
    magic:befDamage(caster, target, damage_sign, damage_type, target_camp, change_level, magic_level, skillId, misInst)
  end
  local misLogic = misInst and role.misLogics[misInst.missile_id]
  if misLogic and misLogic.befDamage then
    misLogic:befDamage(misInst, caster, target, damage_sign, damage_type, target_camp, change_level, magic_level, magicId, skillId, misInst)
  end
  local skill = skillId and role.skills[skillId]
  if skill and skill.befDamage then
    skill:befDamage(caster, target, damage_sign, damage_type, target_camp, change_level, magic_level, misInst, magicId)
  end
  local skAct = skill and skill.skAct
  if skAct and skAct.befDamage then
    skAct:befDamage(caster, target, damage_sign, damage_type, target_camp, change_level, magic_level, misInst, magicId)
  end
end

function roleBase.on_self_skill_hit(role, skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  local id = missile_cfg.Id
  local misLogic = role.misLogics[id]
  if misLogic and misLogic.onHit then
    misLogic:onHit(missile, role.npc, hit_target, hit_type, role.skills[skill_id], part_npc)
  end
  local skill = role.skills[skill_id]
  if skill and skill.onHit then
    skill:onHit(role.npc, hit_target, hit_type, missile, part_npc)
  end
  local skAct = skill and skill.skAct
  if skAct and skAct.onHit then
    skAct:onHit(role.npc, hit_target, hit_type, skill, missile, part_npc)
  end
end

function roleBase.on_missile_end_pos(role, owner, pos_x, pos_z, missile_cfg, missile)
  local misLogic = role.misLogics[missile_cfg.Id]
  local onEnd = misLogic and misLogic.onEnd
  if onEnd then
    return onEnd(misLogic, missile, owner, pos_x, pos_z)
  end
end

function roleBase.on_before_skill_end(role, npc, skill_id, is_time_out, is_break)
  if not is_time_out or npc ~= role.npc then
    return
  end
  local skill = role.skills[skill_id]
  if skill then
    skill:onBefEnd()
  end
end

function roleBase.on_skill_end(role, npc, skill_id, is_time_out, is_break, behavior_abort)
  if npc ~= role.npc then
    return
  end
  local skill = role.skills[skill_id]
  local skAct = role.skAct
  if skAct.curSk ~= skill then
  end
  if is_break then
    skill:onBreak()
  else
    skill:onEnd()
  end
end

function roleBase.on_magic_begin(role, npc, target, magic_id)
  local magic = role.magics[magic_id]
  if not magic then
    return
  end
  if target == role.npc then
    role.curMagics[magic.name] = magic
    role.removeMagics[magic.name] = nil
  end
  magic:onBegin(npc, target)
end

function roleBase.after_damage(role, npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
  if target == role.npc and damage_val < 0 then
    local hurtWarnning = Const.HURT_WARNNING
    cast_magic(target, target, hurtWarnning, 0)
  end
  local magic = role.magics[magic_id]
  if not magic then
    return
  end
  magic:afterDamage(npc, target, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
end

function roleBase.on_magic_end(role, npc, target, magic_id)
  local magic = role.magics[magic_id]
  if not magic then
    return
  end
  if target == role.npc and not check_magic(role.npc, magic_id) then
    role.removeMagics[magic.name] = true
  end
  magic:onEnd(npc, target)
end

function roleBase.on_self_missile_collide(role, m2_owner, m1, m2, m1_cfg, m2_cfg)
  local m1Tag, m2Tag = m1_cfg.MissileTypeTag, m2_cfg.MissileTypeTag
  local npc = role.npc
  if (is_dodge_missile(m1) or 3 == m1Tag) and m2_owner ~= role.npc and 7 ~= m2Tag and 6 ~= m2Tag and 8 ~= m2Tag and is_missile_target_camp(npc, m2) and (is_judg_missile(m2) or 0 ~= m2_cfg.Type or missile_has_hurt_magic(m2)) then
    local roleAct = role.skAct
    local magics = role.magics
    if roleAct:isDash() then
      roleAct:onCollideMis(m2)
    elseif roleAct.name == "block" then
      magics.blockFxFrame.target = m2_owner
      magics.blockFxFrame.tick = magics.blockFxFrame.counter
    end
    if role.god_npc and get_config_id(role.god_npc) == 3001039 and get_god_skill_level() >= 4 and get_npc_cd_charge(role.god_npc, 300103905) >= get_skill_cfg(300103905).CdChargePerCost and get_npc_id(m2_owner) ~= 3002013 then
      cast_skill(role.god_npc, m2_owner, 300103905)
    end
  end
end

function roleBase.on_missile_collide(role, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  local id1 = m1_cfg.Id
  local misLogic1 = role.misLogics[id1]
  if misLogic1 then
    misLogic1.onCollideMis(misLogic1, m1, m2, m1_owner, m2_owner)
  end
  local id2 = m2_cfg.Id
  local misLogic2 = role.misLogics[id2]
  if misLogic2 then
    misLogic2.onCollideMis(misLogic2, m2, m1, m2_owner, m1_owner)
  end
end

function roleBase.on_missile_collide_obstacle(role, owner, obstacle_type, missile_cfg, missile)
  local id = missile_cfg.Id
  local misLogic = role.misLogics[id]
  if not misLogic then
    return
  end
  if misLogic.onCollideObs then
    misLogic:onCollideObs(missile, owner, obstacle_type)
  end
end

function roleBase.on_npc_enter_missile(role, caster, npc, misCfg, misInst)
  local id = misCfg.Id
  local misLogics = role.misLogics
  local misLogic = misLogics[id]
  if misLogic and misLogic.onEnter then
    misLogic:onEnter(misInst, caster, npc)
  end
end

function roleBase.on_npc_leave_missile(role, caster, npc, misCfg, misInst)
  local id = misCfg.Id
  local misLogics = role.misLogics
  local misLogic = misLogics[id]
  if misLogic and misLogic.onLeave then
    misLogic:onLeave(misInst, caster, npc)
  end
end

function roleBase.on_npc_hp_zero(role, npc, attacker, magic_id, missile_id, missile)
  local roleNpc = role.npc
  if npc == roleNpc then
    if role:consume_reborn_chance() then
      return false
    end
    role.baseActs.die:start()
  end
  role:doAfter(role.on_npc_hp_zero_doAfter, 0, false, npc, attacker, missile, magic_id)
  return true
end

function roleBase.on_npc_hp_zero_doAfter(role, victim, attacker, missile, magic_id)
  if role:isInControl() and victim == role.atkTarget then
    local skAct = role.skAct
    if skAct and skAct:needTar() then
      skAct:updateAtkTar()
    end
  end
  if attacker == role.npc then
    local skillId = missile and missile.v_skill_id
    if skillId then
      local skill = role.skills[skillId]
      local skInfo = get_missile_skill_action_info(missile)
      local skAct = skInfo and skInfo.skAct
      if skAct then
        skAct:onKill(attacker, victim, skInfo)
      end
      if skill then
        skill:onKill(attacker, victim, skInfo)
      end
    end
    local misLogic = missile and role.misLogics[missile.missile_id]
    if misLogic then
      misLogic:onKill(missile, attacker, victim)
    end
    local magic = magic_id and role.magics[magic_id]
    if magic then
      magic:onKill(attacker, victim)
    end
  end
end

function roleBase.on_floor_start(role, npc1, npc2, npc3, level)
  if role.npc ~= npc1 then
    return
  end
  role.inputor:resetUi()
end

function roleBase.on_remove(role)
  role:removeFromTeam()
  do
    local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
    local BOUND_CATCH_NPC = MISSILE_EVT_TYPE.BOUND_CATCH_NPC
    local BOUND_RELEASE_NPC = MISSILE_EVT_TYPE.BOUND_RELEASE_NPC
    for key, misLogic in pairs(role.misLogics) do
      local id = misLogic.id
      if misLogic.onCollideObs and type(key) == "number" then
        unlisten_missile_collide_obstacle(role.npc, id, role)
      end
      if misLogic.onEnter and type(key) == "number" then
        unlisten_missile_evt(BOUND_CATCH_NPC, role.npc, id, role)
      end
      if misLogic.onLeave and type(key) == "number" then
        unlisten_missile_evt(BOUND_RELEASE_NPC, role.npc, id, role)
      end
    end
  end
  unlisten_attr_change_mq(role.npc, 1, role)
  role.behaviorBase.on_remove(role)
  role.skActs = nil
  role.skills = nil
  role.icons = nil
  role.btns = nil
end

function roleBase.on_red_skill_countered(role, attackerNpc, monsterNpc)
end

function roleBase.on_hp_change(role, npc, attr_type, change_value)
  return role:update_dying_fx(change_value)
end

function roleBase.on_role_behit_state_change(role, state)
  local fun = role.do_behit_state_change[state]
  if not fun then
    role:debugOutput("on_role_behit_state_change with unknown type")
  end
  return fun(role)
end

function roleBase._init(role, missileIds, magicIds)
  local role = role
  role.base = roleBase
  role._tarPos = vec3.New()
  role._showUpPos = vec3.New()
  role._inputDir = vec3.New()
  role._faceDir = vec3.New()
  role.showUpEvent = {}
  local tool = role.tool
  role.skActBases = UtilTable.fill_table(tool.skActBases, rawget(role, "skActBases"), true)
  role.dash_enable_cd_timer = get_npc_time(role.npc)
  role.searchInterval = 10
  role.searchFrame = Global.frame_id
  local id = role.npc.id
  role.id = id
  role.cfg = ShareRes.get_character_cfg(id)
  role:addToTeam()
  role.in_control = role.npc == get_come_on_hero()
  role.in_stay = false
  role.in_back = false
  role.qteMgr = qteMgrBase:new(role)
  local get_attr = get_npc_attr
  local npc = role.npc
  role.attr = {
    [2] = get_attr(npc, 2),
    [74] = get_attr(npc, 74),
    [108] = get_attr(npc, 108),
    [5] = get_attr(npc, 5),
    [75] = get_attr(npc, 75),
    [109] = get_attr(npc, 109)
  }
  role.moveScale = {}
  role.moveScaleBackUp = {}
  role.curMagics = {}
  role.removeMagics = {}
  role.doAfterMgr = doAfterMgrBase:new(role)
  role.rebornMgr = rebornMgrBase:new(role)
  local nilFun = Const.NIL_FUN
  role.destinies = {
    nilFun,
    nilFun,
    nilFun,
    nilFun,
    nilFun
  }
  role.destinies[0] = nilFun
  role.destinyLv = 0
  role.traces = {
    nilFun,
    nilFun,
    nilFun,
    nilFun,
    nilFun
  }
  role.traces[0] = nilFun
  role.traceLv = 0
  role.spWeapon = {
    fun = nilFun,
    magic = nil,
    lv = 0
  }
  magicIds = magicIds or {}
  magicIds.counterSound = role.cfg.CounterSound
  if not magicIds.counterSound then
    Log.Error(role.npc.id .. " 完美闪避语音丢失，请检查单位表初始属性配置", debug.traceback())
  end
  local DASH = Const.DEFEND.DASH
  magicIds.dashCd = magicIds.dashCd or DASH.COMMON.CD
  magicIds.pDashTry = magicIds.pDashTry or DASH.PERFECT.TRY
  magicIds.pDashSlomo = magicIds.pDashSlomo or DASH.PERFECT.SLOMO_OTHERS
  magicIds.pDashIP = magicIds.pDashIP or DASH.PERFECT.INPUT_PROTECT
  magicIds.pDashIPmove = magicIds.pDashIPmove or DASH.PERFECT.INPUT_PROTECT_MOVE
  magicIds.pDash_fixed_counter_win = magicIds.pDash_fixed_counter_win or DASH.PERFECT.FIXED_COUNTER_WINDOW
  magicIds.pDash_extra_counter_win = magicIds.pDash_extra_counter_win or DASH.PERFECT.EXTRA_COUNTER_WINDOW
  magicIds.blink1Timer = magicIds.blink1Timer or Const.SWITCH_CONFIG.BLINK1_TIMER
  magicIds.blink2Timer = magicIds.blink2Timer or Const.SWITCH_CONFIG.BLINK2_TIMER
  magicIds.switchMeltOut = magicIds.switchMeltOut or Const.SWITCH_CONFIG.TO_BACK_MELT_OUT_FX
  magicIds.tryQteLink = magicIds.tryQteLink or Const.LINK_CONFIG.TRY_QTE_LINK
  magicIds.nextUlt = magicIds.nextUlt or Const.ULT_CONFIG.NEXT_ULT
  magicIds.perfectBlockWindow = magicIds.perfectBlockWindow or 1999187
  magicIds.perfectBlockCamPull = magicIds.perfectBlockCamPull or 1999190
  magicIds.perfectBlockSlomoSelf = magicIds.perfectBlockSlomoSelf or 1999127
  magicIds.perfectBlockSlomoOthers = magicIds.perfectBlockSlomoOthers or 1999128
  magicIds.perfectBlockCamShake = magicIds.perfectBlockCamShake or 1999189
  magicIds.commonBlockWindow = magicIds.commonBlockWindow or 1999188
  magicIds.commonBlockSlomoSelf = magicIds.commonBlockSlomoSelf or 1999194
  magicIds.commonBlockSlomoOthers = magicIds.commonBlockSlomoOthers or 1999195
  magicIds.commonBlockCamShake = magicIds.commonBlockCamShake or 1999196
  magicIds.blockFxFrame = magicIds.blockFxFrame or 19991851
  magicIds.blockInvulnerable = magicIds.blockInvulnerable or 1999095
  if missileIds then
    tool.genMisLogics(role, missileIds)
  end
  if magicIds then
    tool:genMagics(role, magicIds)
  end
  do
    local spBarPointNum = role.npc.character_cfg.SpBarPointNum
    local spBar
    if spBarPointNum then
      if 0 == spBarPointNum then
        spBar = "bar"
      else
        local spBarList = {}
        for i = 1, spBarPointNum do
          table.insert(spBarList, false)
        end
        spBar = tool.genSpBar(role, spBarList)
      end
    end
    role.spBar = spBar
    role.inputor = inputorBase:new(role)
    tool.genSkills(role)
    tool:genSkActs(role)
    tool.genIcons(role)
    tool.genBtns(role)
    role.inputor:init()
    if is_hero_in_ground(role.npc) then
      role.inputor:resetUi()
    end
  end
  local basicBase = role.skActBases.basic
  role.baseActs = {
    wander = basicBase:new(role),
    hurt = basicBase:new(role),
    hurtFly = basicBase:new(role),
    lie = basicBase:new(role),
    turnOver = basicBase:new(role),
    die = basicBase:new(role)
  }
  role.qteMgr:init()
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  magics.tryQteLink.onBegin = role.linkMgr.try_link_fx_by_magic
  magics.nextUlt.onBegin = role.ultMgr.tryNextByMagic
  
  function magics.blink1Timer.onEnd(blink1Timer, npc)
    local role = blink1Timer.unit
    if role.npc ~= npc then
      return
    end
    cast_magic(npc, npc, Const.SWITCH_CONFIG.BLINK1_HIDE)
  end
  
  function magics.blink2Timer.onEnd(blink2Timer, npc)
    local role = blink2Timer.unit
    if role.npc ~= npc then
      return
    end
    cast_magic(npc, npc, Const.SWITCH_CONFIG.BLINK2_HIDE)
  end
  
  do
    local baseActs = role.baseActs
    baseActs.wander.name = "wander"
    baseActs.hurt.name = "hurt"
    baseActs.hurtFly.name = "hurtFly"
    baseActs.lie.name = "lie"
    baseActs.turnOver.name = "turnOver"
    baseActs.die.name = "die"
    do
      local wander = baseActs.wander
      wander.trans.prio = 0
      wander.trans.inertia = 0
      
      function wander.transCheck()
        return true
      end
      
      wander.statusIdle = Const.CHARACTER_STATE_TYPE.IDLE
      wander.statusMove = Const.CHARACTER_STATE_TYPE.MOVE
      
      function wander.isReady(wander)
        return wander.role:isInStatus(wander.statusIdle, wander.statusMove)
      end
      
      function wander.try(wander, event, canReEnter)
        if not canReEnter and wander.role:isInWander() then
          return
        else
          return wander.base.try(wander, event)
        end
      end
      
      function wander.try_pop_by_start(wander)
        local role = wander.role
        if role:isInWander() then
          return wander:tryPop()
        elseif wander:try() then
          wander:tryPop()
        end
      end
      
      function wander.canPop(wander)
        return not wander.role:isInBack()
      end
      
      function wander.tarPos(wander, event)
        if not event or not event.isSwitch then
          return
        end
        local inputDir = event.inputDir or event.faceDir
        local tarPos = wander._tarPos
        local rolePos = wander.role.npc:get_pos_vec3()
        tarPos:SetB(inputDir):Mul(10):Add(rolePos)
        return tarPos
      end
      
      function wander.start(wander, event)
        wander.base.start(wander, event)
        local npc = wander.role.npc
        clear_hit_stop(npc)
        local tarPos = wander:tarPos(event)
        if tarPos then
          lookat_position(npc, tarPos.x, tarPos.z, true)
        end
      end
      
      local search = role:baseSearchConfig()
      wander.search = search
      search.bIsTick = true
      search.name = role.npc:get_hero_name() .. ".wander"
      search.directional.dist.weight = 10
      search.noInput.angle.weight = 5
      search.noInput.angle.ratio = -0.05
      search.directional.viscous.weight = 5
      search.noInput.viscous.weight = 5
      search:update()
      
      function wander.tick(wanderAct)
        local role = wanderAct.role
        if not role.indiMgr:isActive() then
          local curFrame = Global.frame_id
          if Global.frame_id >= role.searchFrame then
            role.searchFrame = curFrame + role.searchInterval
            role:searchTarget(wanderAct.search)
          end
        end
      end
      
      wander.showUpPos = role.qteMgr.showUpPos_byRole
      
      function wander.showUpFx(act, event)
        local role = act.role
        local facePos = get_npc_offset_position(role.npc, nil, 0, 10)
        local chestPos = get_npc_pos(role.npc, "Bip001 Chest")
        chestPos.y = chestPos.y - 0.15
        local roleNpc = role.npc
        if not role:isInRealStay() then
          cast_magic(roleNpc, roleNpc, Const.SWITCH_CONFIG.BLINK1_TIMER)
          cast_magic(roleNpc, roleNpc, Const.SWITCH_CONFIG.BLINK2_TIMER)
        end
        cast_magic(roleNpc, roleNpc, Const.SWITCH_CONFIG.BLINK_OUTLINE)
        if event.inputDir then
          create_scene_effect(Const.SWITCH_CONFIG.TO_FRONT_FLASH_QTE, chestPos, 5, nil, facePos)
        else
          create_scene_effect(Const.SWITCH_CONFIG.TO_FRONT_FLASH_IDLE, roleNpc:get_pos_vec3(), 10)
        end
      end
      
      wander.isBefOver = true
      wander.isCastOver = true
      wander.isOver = true
      wander.bIsWander = true
    end
    do
      local hurt = baseActs.hurt
      hurt.status = Const.CHARACTER_STATE_TYPE.BEATTACK
      
      function hurt.isReady(hurt)
        return hurt.role:isInStatus(hurt.status)
      end
      
      function hurt.start(hurt)
        hurt.base.start(hurt)
        hurt.canDash = false
        hurt.canSkill = false
      end
      
      function hurt.tryDash(hurt)
        hurt.canDash = true
        return hurt:tryPop(Const.INPUTOR_POP_TYPE.TRY)
      end
      
      function hurt.trySkill(hurt)
        hurt.canSkill = true
        return hurt:tryPop(Const.INPUTOR_POP_TYPE.TRY)
      end
      
      hurt.trans.prio = 9999
      hurt.trans.inertia = 4
      
      function hurt.transCheck(hurt, tarAct)
        local role = hurt.role
        local roleAct = role.skAct
        if roleAct ~= hurt then
          return false
        end
        if hurt.canSkill then
          return true
        end
        local trans = hurt.trans
        local tarName = tarAct.name
        if trans.disable[tarName] then
          return false
        end
        if trans.enable[tarName] then
          return true
        end
        if tarAct.trans.prio > trans.inertia then
          return true
        end
        if hurt.canDash and tarAct:deemDash() then
          return true
        end
        return false
      end
    end
    do
      local cfg = Const.TURN_OVER_ICON_CONFIG
      local skId = cfg.SKILL_ID
      skills.turnOver = skillBase:new(role, get_skill_cfg(skId))
      skActs.turnOver = baseActs.turnOver
      icons.turnOver = iconBase:new(role, get_unit_logic_button_cfg(cfg.CHAR_ID, cfg.NAME))
      icons.turnOver.updateEnable = Const.NIL_FUN
    end
    do
      local hurtFly = baseActs.hurtFly
      hurtFly.needTurnOver = true
      hurtFly.status = Const.CHARACTER_STATE_TYPE.FLY
      
      function hurtFly.isReady(hurtFly)
        return hurtFly.role:isInStatus(hurtFly.status)
      end
      
      function hurtFly.start(hurtFly)
        hurtFly.base.start(hurtFly)
        hurtFly.btn:set_icon_by_role_base(hurtFly.icon)
        hurtFly.canTurnOver = false
      end
      
      hurtFly.btn = btns.dash
      hurtFly.icon = icons.turnOver
      
      function hurtFly.tryTurnOver(hurtFly)
        hurtFly.canTurnOver = true
        return hurtFly:tryPop(Const.INPUTOR_POP_TYPE.TRY)
      end
      
      hurtFly.trans.prio = 9999
      hurtFly.trans.inertia = 9999
      hurtFly.turnOver = baseActs.turnOver
      
      function hurtFly.transCheck(hurtFly, tarAct)
        local role = hurtFly.role
        local roleAct = role.skAct
        if roleAct ~= hurtFly then
          return false
        end
        if hurtFly.canTurnOver and tarAct == hurtFly.turnOver then
          return true
        end
        return false
      end
      
      function hurtFly.onBreak(hurtFly, tarAct)
        if tarAct == hurtFly then
          return
        end
        if tarAct and tarAct.needTurnOver then
          return
        end
        return hurtFly.btn:recover_custom_icon()
      end
    end
    do
      local lie = baseActs.lie
      lie.needTurnOver = true
      lie.status = Const.CHARACTER_STATE_TYPE.FALL
      
      function lie.isReady(lie)
        return lie.role:isInStatus(lie.status)
      end
      
      function lie.start(lie)
        lie.base.start(lie)
        lie.canSkill = false
      end
      
      lie.btn = btns.dash
      
      function lie.trySkill(lie)
        lie.btn:recover_custom_icon()
        lie.canSkill = true
        lie.inputor:pop(true)
      end
      
      lie.trans.prio = 9999
      lie.trans.inertia = 9999
      lie.turnOver = baseActs.turnOver
      
      function lie.transCheck(lie, tarAct)
        local role = lie.role
        local roleAct = role.skAct
        if roleAct ~= lie then
          return false
        end
        if lie.canSkill then
          return true
        else
          return tarAct == lie.turnOver
        end
      end
      
      function lie.onBreak(lie, tarAct)
        if tarAct == lie then
          return
        end
        if tarAct.needTurnOver then
          return
        end
        return lie.btn:recover_custom_icon()
      end
    end
    do
      local turnOver = baseActs.turnOver
      turnOver.hurtFly = baseActs.hurtFly
      turnOver.lie = baseActs.lie
      
      function turnOver.isReady(turnOver)
        local roleAct = turnOver.role.skAct
        if roleAct == turnOver.hurtFly and roleAct.canTurnOver then
          return true
        elseif roleAct == turnOver.lie and not roleAct.canSkill then
          return true
        end
        return false
      end
      
      turnOver.btn = btns.dash
      
      function turnOver.start(turnOver)
        turnOver.base.start(turnOver)
        turnOver.btn:recover_custom_icon()
        turnOver.canSkill = false
        to_turn_over_state(turnOver.role.npc)
      end
      
      function turnOver.trySkill(turnOver)
        turnOver.canSkill = true
        return turnOver.inputor:pop(Const.INPUTOR_POP_TYPE.TRY)
      end
      
      turnOver.trans.prio = 9999
      turnOver.trans.inertia = 9999
      
      function turnOver.transCheck(turnOver, tarAct)
        local role = turnOver.role
        local roleAct = role.skAct
        if roleAct ~= turnOver then
          return false
        end
        if turnOver.canSkill then
          return true
        end
        return false
      end
    end
    if skills.faint then
      function skills.faint.isReady()
        return true
      end
    end
    do
      local faint = role.skActs.faint
      if faint then
        faint.isBasic = Const.TURE_FUN
        
        function faint.isReady()
          return false
        end
        
        function faint.start(faint, time, switchMaskTime)
          faint._time = get_time()
          time = time or 9999
          if switchMaskTime then
            faint.tool:set_ui_visible("TeamHeads", false)
          end
          switchMaskTime = switchMaskTime or 0
          local now = get_npc_time(faint.role.npc)
          faint.timer = now + time
          faint.switchMaskTimer = now + switchMaskTime
          local role = faint.role
          local strSk = faint:chooseStrSk()
          strSk:start(faint)
          faint.isBefOver = false
          faint.isCastOver = false
          faint.isOver = false
          local roleAct = role.skAct
          role:updateAct(faint)
          if not roleAct.isOver then
            roleAct:onBreak(faint)
          end
          faint:onBegin()
        end
        
        function faint.transCheck()
          return false
        end
        
        function faint.tick(faint)
          local now = get_npc_time(faint.role.npc)
          if now > faint.switchMaskTimer then
            faint.tool:set_ui_visible("TeamHeads", true)
          end
          if now > faint.timer then
            faint:finish()
          end
        end
        
        faint.wander = role.baseActs.wander
        
        function faint.finish(faint)
          local role = faint.role
          if role.skAct ~= faint then
            return
          end
          abort_skill(role.npc, true)
        end
        
        function faint.canStay()
          return false
        end
        
        function faint.onBreak(faint, tarAct)
          faint.tool:set_ui_visible("TeamHeads", true)
          faint.base.onBreak(faint, tarAct)
        end
      end
    end
    baseActs.die.timer = 0
    baseActs.die.elapse = 2.5
    baseActs.die.isBefOver = false
    baseActs.die.isCastOver = false
    baseActs.die.isOver = false
    baseActs.die.burstFx = Const.DEAD_BURST_FX
    
    function baseActs.die.start(die)
      die.base.start(die)
      die.isOver = false
      local role = die.role
      local npc = role.npc
      die.timer = get_npc_time(npc) + die.elapse
      abort_skill(npc)
      create_scene_effect(die.burstFx, npc:get_pos_vec3(), 10)
      set_npc_dead(npc, "die1", false)
      stop_skill_joystick_move(npc)
      role:disableInput()
    end
    
    function baseActs.die.tick(die)
      if die.isOver then
        return
      end
      if get_npc_time(die.role.npc) < die.timer then
        return
      end
      die:onEnd()
    end
    
    baseActs.die.ultBtn = role.btns.ult
    baseActs.die.switchInvual = Const.SWITCH_CONFIG.DIE_INVUL
    
    function baseActs.die.onEnd(die)
      die.isOver = true
      local nextHero, nextHeroCode, nextHeroIndex
      for i = 1, 2 do
        local keyCode = i + 20
        nextHero = get_scene_hero_by_poskey(keyCode)
        if nextHero and not check_npc_die(nextHero) then
          nextHeroIndex = i
          nextHeroCode = keyCode
          break
        end
      end
      if not nextHeroCode then
        return
      end
      local ultBtn = die.ultBtn
      local ultIcon = ultBtn.icon
      ultIcon.updateEnableBackUp = ultIcon.updateEnable
      
      function ultIcon.updateEnable()
      end
      
      ultIcon.isEnable = false
      ultBtn:drawEnable()
      local newRole = nextHero:get_behavior()
      die.tool:changeRole(nextHeroCode, die.role, newRole)
      set_team_head_object_visible(nextHeroIndex, "EnergyList", false)
      cast_magic(nextHero, nextHero, die.switchInvual)
    end
    
    baseActs.die.trans.prio = 9999
    
    function baseActs.die.transCheck(die, tarAct)
      return false
    end
    
    role:updateAct(baseActs.wander)
  end
  magics.switchMeltOut.onBegin = role.melt_out_begin
  magics.switchMeltOut.onEnd = role.melt_out_end
  do
    local atkActs = {}
    for i = 1, 10 do
      local name = "atk" .. tostring(i)
      local actAct = skActs[name]
      if not actAct then
        break
      end
      atkActs[i] = actAct
    end
    local atk1 = atkActs[1]
    if not atk1 then
      Log.Error(tostring(role.id) .. "._init: skacts.atk1 is lost")
    else
      local snapArgs = role.cfg.Atk1Snap
      if not snapArgs then
      else
        atk1.snap = {
          frameId = snapArgs[1],
          minDis = snapArgs[2],
          maxDis = snapArgs[3]
        }
        
        function atk1.start(atk1, event)
          local role = atk1.role
          local target = role.target
          local snapOn = true
          local snap = atk1.snap
          if not target then
            snapOn = false
          else
            local dist = get_npc_distance(role.npc, 1, target, true)
            if dist < snap.minDis or dist > snap.maxDis then
              snapOn = false
            else
            end
          end
          if not snapOn then
            set_keyframe_enable(role.npc, snap.frameId, false, false)
          end
          atk1.base.start(atk1, event)
        end
      end
    end
    for _, atkAct in ipairs(atkActs) do
      atkAct.reset = {timer = 0, delay = 0.2}
      
      function atkAct.onCastTime(skAct)
        skAct.reset.timer = get_npc_time(skAct.role.npc) + skAct.reset.delay
        skAct.base.onCastTime(skAct)
      end
    end
    for i = 2, #atkActs do
      local atk = atkActs[i]
      atk.preAtk = atkActs[i - 1]
      
      function atk.isReady(skAct)
        if not skAct.base.isReady(skAct) then
          return false
        end
        local role = skAct.role
        local roleAct = role.skAct
        if roleAct == skAct.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
          return true
        else
          return false
        end
      end
    end
  end
  do
    local dashBase = role.skActBases.dash
    magics.dashCd.dashOut = skills.dashOut
    magics.dashCd.onBegin = dashBase.onCdMagicBegin
    magics.dashCd.onEnd = dashBase.onCdMagicEnd
    icons.dash.cdMagic = magics.dashCd
    
    function icons.dash.updateEnable(dash)
      dash.isEnable = not check_magic(dash.role.npc, dash.cdMagic.id)
    end
    
    magics.pDashTry.onBegin = dashBase.onTryMagicBegin
    magics.pDashSlomo.onEnd = dashBase.onSlomoMagicEnd
    magics.pDashIP.onEnd = dashBase.onIpMagicEnd
    magics.pDashIPmove.onEnd = dashBase.onMoveIpMagicEnd
    magics.pDash_fixed_counter_win.onEnd = dashBase.onFixCoutWinEnd
    magics.pDash_extra_counter_win.onEnd = dashBase.onExCoutWinEnd
  end
  magics.blockFxFrame.magics = {
    invul = magics.blockInvulnerable,
    window = {
      perfect = magics.perfectBlockWindow,
      common = magics.commonBlockWindow
    },
    perfect = {
      slomoSelf = magics.perfectBlockSlomoSelf,
      slomoOthers = magics.perfectBlockSlomoOthers,
      camPull = magics.perfectBlockCamPull,
      camShake = magics.perfectBlockCamShake
    },
    common = {
      slomoSelf = magics.commonBlockSlomoSelf,
      slomoOthers = magics.commonBlockSlomoOthers,
      camShake = magics.commonBlockCamShake
    }
  }
  magics.blockFxFrame.act = skActs.block
  
  function magics.blockFxFrame.counter(blockFxFrame)
    local role = blockFxFrame.unit
    local allMagics = blockFxFrame.magics
    local performMagics
    if check_magic(role.npc, allMagics.window.perfect.id) then
      performMagics = allMagics.perfect
    elseif check_magic(role.npc, allMagics.window.common.id) then
      performMagics = allMagics.common
    end
    if performMagics then
      for _, magic in pairs(performMagics) do
        if not check_magic(role.npc, magic.id) then
          cast_magic(role.npc, role.npc, magic.id)
        end
      end
    end
    local roleAct = role.skAct
    if role.skAct == blockFxFrame.act then
      local target = blockFxFrame.target
      role:setTarget(target)
      lookat_npc(role.npc, target)
      cast_magic(role.npc, role.npc, allMagics.invul.id)
      roleAct.curSk:derive()
    else
      Log.Error(tostring(role.npc.id) .. ".blockFrame.counter is called, but skActs.block is lost")
    end
    blockFxFrame.tick = nil
  end
  
  function btns.ult.drawEnhance()
  end
  
  do
    local function ultDrawEnable(btn)
      local icon = btn.icon
      
      local newIsEnable = icon.isEnable
      if btn.isEnable == newIsEnable then
        return
      end
      local role = btn.role
      if newIsEnable then
        play_ui_fight_button_effect({
          "gray",
          nil,
          btn.icon.skill.id,
          0,
          0
        })
        set_ult_skill_enabled(role.npc, true)
        role:onUltEnable()
        play_ui_fight_button_effect({
          btn.cdCompleteFx,
          btn.id2
        })
      else
        play_ui_fight_button_effect({
          "gray",
          nil,
          btn.icon.skill.id,
          1,
          0
        })
        set_ult_skill_enabled(btn.role.npc, false)
        role:onUltDisable()
      end
      btn.isEnable = icon.isEnable
    end
    
    btns.ult.drawEnableWithChange = ultDrawEnable
    btns.ult.drawEnableInPlace = ultDrawEnable
    btns.ult.drawEnable = ultDrawEnable
    
    function btns.ult.drawEnableBackGround(btn)
      local icon = btn.icon
      icon:updateEnable()
      local isEnable = icon.isEnable
      if btn.isEnable == isEnable then
        return
      end
      local role = btn.role
      if isEnable then
        role:onUltEnable()
      else
        role:onUltDisable()
      end
      set_ult_skill_enabled(btn.role.npc, icon.isEnable)
      btn.isEnable = icon.isEnable
    end
  end
  role.debugSkActs = {}
  for _, skAct in pairs(skActs) do
    table.insert(role.debugSkActs, skAct.name)
  end
end

function roleBase.on_destroy_mamager()
  roleBase.debugSwitch = nil
  roleBase.commonRole = nil
  roleBase.ultMgr = nil
  roleBase.linkMgr = nil
  roleBase.rampMgr = nil
  roleBase.tool = nil
  roleBase.indiMgr = nil
end

do return roleBase end
do
  local role = {}
  
  function role._init(role, npc, fileId, npcScope, globalScope)
  end
end
