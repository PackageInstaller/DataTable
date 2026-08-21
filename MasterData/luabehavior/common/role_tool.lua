local searchCfgBase = import("base.role.searchSystem.searchCfg")
local toolBase = import("common.tool")
local roleTool = Util.create_child_mt(toolBase)
roleTool.base = toolBase

function roleTool.setUp(roleTool)
  local roleTool = roleTool
  roleTool.ultMgr = ComnMgr.UltMgr
  roleTool.linkMgr = ComnMgr.LinkMgr
  roleTool.rampMgr = ComnMgr.RampMgr
  roleTool.skActBases = {
    atk = import("character.base.skAct_imp.skAct_atk"),
    basic = import("character.base.skAct_imp.skAct_basic"),
    born = import("character.base.skAct_imp.skAct_born"),
    counter = import("character.base.skAct_imp.skAct_counter"),
    common = import("character.base.base_role_skillAction"),
    dashIn = import("character.base.skAct_imp.skAct_dash_dashIn"),
    dashOut = import("character.base.skAct_imp.skAct_dash_dashOut"),
    dash = import("character.base.skAct_imp.skAct_dash"),
    exQte = import("character.base.skAct_imp.skAct_exQte"),
    heavy = import("character.base.skAct_imp.skAct_heavy"),
    linkQte = import("character.base.skAct_imp.skAct_linkQte"),
    qte = import("character.base.skAct_imp.skAct_qte"),
    skill = import("character.base.skAct_imp.skAct_skill"),
    ult = import("character.base.skAct_imp.skAct_ult"),
    ultEmpty = import("character.base.skAct_imp.skAct_ultEmpty"),
    ultFast = import("character.base.skAct_imp.skAct_ultFast")
  }
  roleTool.switchConfig = {
    search = searchCfgBase:create({
      name = "roleBase.switchHero",
      maxDis = 8,
      secRadius = 8,
      secAngle = 60,
      directional = {
        dist = {
          enable = true,
          weight = 8,
          ratio = -2,
          idealDis = 0
        },
        angle = {
          enable = true,
          weight = 5,
          ratio = -0.05
        },
        viscous = {enable = true, weight = 5},
        occlus = {enable = true, weight = -100}
      },
      noInput = {
        dist = {
          enable = true,
          weight = 10,
          ratio = -2,
          idealDis = 0
        },
        angle = {
          enable = true,
          weight = 5,
          ratio = -0.05
        },
        viscous = {enable = true, weight = 5},
        occlus = {enable = true, weight = -100}
      }
    }),
    min_offset_from_role = 3,
    max_offset_from_role = 8,
    min_offset_from_tar = 1
  }
  roleTool.setIconLocks = {
    atk = false,
    dash = false,
    sk1 = false,
    sk2 = false,
    ult = false
  }
  roleTool.lastRole = nil
  roleTool.curRole = nil
  roleTool.to_back_fx_pos = {
    list = {},
    minDisSqr = 2.25,
    add = function(self, role, pos)
      if not role or not pos then
        return
      end
      self.list[role] = pos
    end,
    clear = function(self)
      local list = self.list
      for role, _ in pairs(list) do
        list[role] = nil
      end
    end,
    mask = function(self, posA)
      if not posA then
        return
      end
      local list = self.list
      local x, z = posA.x, posA.z
      local minDisSqr = self.minDisSqr
      for role, posB in pairs(list) do
        if minDisSqr > mathx.square_distance2(x, z, posB.x, posB.z) then
          list[role] = nil
        end
      end
    end,
    spawn = function(self)
      local list = self.list
      local fxName = Const.SWITCH_CONFIG.TO_BACK_FLASH
      for _, pos in pairs(list) do
      end
    end
  }
  roleTool.to_front_fx_pos = nil
end

local btnBase = import("character.base.base_role_button")
local iconBase = import("character.base.base_role_icon")
local skillBase = import("character.base.base_role_skill")
local spBarBase = import("character.base.base_role_spBar")
local magicBase = import("character.base.base_magic").role
local BUTTON_EVT_TYPE = Const.BUTTON_EVT_TYPE

function roleTool.addRole(tool, role)
  local id = role.id
  local team = tool.team
  if team.role[id] then
    role:debugOutput("roleTool.addRole redundant")
    return
  end
  team.role[id] = role
  team.npc[id] = role.npc
  local num = team.num + 1
  if num > 3 then
    role:debugOutput("roleTool.addRole overflow")
    num = 3
  end
  team.num = num
  tool.linkMgr:addRole(role)
end

function roleTool.removeRole(tool, role)
  local id = role.id
  local team = tool.team
  if not team.role[id] then
    role:debugOutput("roleTool.removeRole redundant")
    return
  end
  team.role[id] = nil
  team.npc[id] = nil
  local num = team.num - 1
  if num < 0 then
    role:debugOutput("roleTool.removeRole overflow")
    num = 0
  end
  team.num = num
  tool.ultMgr:onUltDisable(role)
  if tool.curRole == role then
    tool:updateCurRole()
  end
  tool.linkMgr:removeRole(role)
end

function roleTool.isInTeam(tool, npc)
  return tool.team.npc[npc.id] and true or false
end

function roleTool.updateCurRole(tool, role)
  tool.lastRole = tool.curRole
  tool.curRole = role
  if not tool.lastRole then
    Util.debug_output("tool.updateCurRole is called but lastRole is lost")
  end
end

do
  local changeCurRole_id_to_code = {
    Const.INPUT_CODE.QTE1,
    Const.INPUT_CODE.QTE2
  }
  
  function roleTool.changeCurRole(tool, id, forceBack)
    id = id or 1
    local code = changeCurRole_id_to_code[id]
    if not code then
      return Util.debug_output("roleTool.changeCurRole is called with illegal id " .. tostring(id))
    end
    local newRole = get_scene_hero_by_poskey(code)
    if not newRole or check_npc_die(newRole) then
      local QTE1, QTE2 = Const.INPUT_CODE.QTE1, Const.INPUT_CODE.QTE2
      code = code == QTE1 and QTE2 or QTE1
      newRole = get_scene_hero_by_poskey(code)
    end
    if not newRole or check_npc_die(newRole) then
      return
    end
    newRole = newRole:get_behavior()
    return tool:changeRole(code, tool.curRole, newRole, forceBack)
  end
  
  function roleTool.changeRole(tool, inputId, oldRole, newRole, forceBack)
    local INPUT_CODE = Const.INPUT_CODE
    if inputId ~= INPUT_CODE.QTE1 and inputId ~= INPUT_CODE.QTE2 then
      return Util.debug_output("roleTool.changeRole is called with illegal inputId " .. tostring(inputId))
    end
    if not newRole then
      newRole = get_scene_hero_by_poskey(inputId)
      newRole = newRole and newRole:get_behavior()
    end
    local finalRole = newRole or tool.curRole
    if oldRole and oldRole ~= tool.curRole then
      Util.debug_output("change role is called with mismatched oldRole & curRole, oldRole is ", oldRole:getUri(), "curRole is ", tool.curRole:getUri())
    end
    local to_back_fx_pos = tool.to_back_fx_pos
    tool.to_front_fx_pos = nil
    to_back_fx_pos:clear()
    do
      local curRole = tool.curRole
      local target = curRole:searchNpc(tool.switchConfig.search)
      if newRole then
        tool:setTarget(newRole, target, true)
      else
        Util.debug_output("changeRole is called without newRole")
      end
    end
    if oldRole then
      if not inputId then
        oldRole:debugOutput("roltTool.changeRole is called without an input Id")
      end
      local backFun = forceBack and oldRole.toBack or oldRole.switchBack
      to_back_fx_pos:add(backFun(oldRole, inputId))
    else
      local team = tool.team.role
      for _, role in pairs(team) do
        if role == finalRole then
        elseif role:isInBack() then
        else
          if not role.toBack then
            return
          end
          if role:isInControl() then
            if not inputId then
              role:debugOutput("roltTool.changeRole is called without an input Id")
              return
            end
            to_back_fx_pos:add(role:toBack(inputId))
          else
            to_back_fx_pos:add(role:toBack())
          end
        end
      end
    end
    if not newRole then
    else
      local backPos, frontPos = newRole:toFront()
      to_back_fx_pos:add(backPos)
      tool.to_front_fx_pos = frontPos
    end
    to_back_fx_pos:mask(tool.to_front_fx_pos)
    to_back_fx_pos:spawn()
  end
  
  function roleTool.teamClearStay(tool)
    local team = tool.team.role
    for _, role in pairs(team) do
      if role:isInStay() then
        role:toBack()
      end
    end
  end
  
  function roleTool.getSwitchConfig(tool)
    return tool.switchConfig
  end
  
  function roleTool.addQteDist(tool, offset)
    local search = tool.switchConfig.search
    search.maxDis = search.maxDis + offset
  end
end

function roleTool.initUltToTeam(tool)
  local team = tool.team.role
  for _, role in pairs(team) do
    if role.btns then
      role.btns.ult.isEnable = false
    elseif role.button_gray_list then
      role.button_gray_list[4] = false
    end
  end
end

function roleTool.setTarget(tool, role, newTarget, force_update_fx)
  local role = role or get_come_on_hero():get_behavior()
  if newTarget ~= role.target then
    role.target = newTarget
    set_npc_target(role.npc, role.target)
  end
  force_update_fx = force_update_fx or role:isInControl()
  if not force_update_fx then
    return
  end
  local oldTarget = tool.target
  if newTarget == oldTarget then
    return
  end
  local lockOn = Const.LOCK_ON_TAG
  if oldTarget then
    abort_magic_by_id(oldTarget, lockOn)
  end
  if newTarget then
    cast_magic(role.npc, newTarget, lockOn)
  end
  tool.target = newTarget
end

function roleTool.tryLevelTimer(tool)
  local roleAct = tool.curRole.skAct
  if roleAct and roleAct:needStopTimer() then
    return
  end
  set_timer_pause(false)
end

function roleTool.set_btn_mq_unique_listener(tool, role)
  for _, npc in pairs(tool.team.npc) do
    unlisten_button_mq(BUTTON_EVT_TYPE.DRAG_STATE_CHANGE, npc, role)
  end
  listen_button_mq(BUTTON_EVT_TYPE.DRAG_STATE_CHANGE, role.npc, role.onBtnDrag, role)
end

function roleTool.genSkills(role)
  local skills = {}
  local role = role
  role.skills = skills
  local skillIdList = ShareRes.get_skill_list(role.npc.id)
  for _, skId in ipairs(skillIdList) do
    local skCfg = get_skill_cfg(skId)
    if skCfg then
      local skill = skills[skId] or skillBase:new(role, skCfg)
      skills[skId] = skill
      skills[skill.name] = skill
    end
  end
  for _, skill in pairs(skills) do
    local cfg = skill.cfg
    if cfg.AutoDeriveSkills then
      for i, deriveName in ipairs(cfg.AutoDeriveSkills) do
        skill.derives.auto[i] = skills[deriveName]
      end
    end
    if cfg.ManualDeriveSkills then
      for i, deriveName in ipairs(cfg.ManualDeriveSkills) do
        skill.derives.manual[i] = skills[deriveName]
      end
    end
    local copyBaseName = cfg.CopyBase
    if copyBaseName then
      local copyBase = skills[copyBaseName]
      if not copyBase then
        role:debugOutput("copyBase not found, skAct is " .. skill.name .. ", copyBase is " .. copyBaseName)
      else
        skill:initCopy(copyBase)
      end
    end
  end
end

do
  local skActBaseOrder = {
    "common",
    "dash",
    "dashIn",
    "dashOut",
    "qte",
    "exQte",
    "linkQte",
    "ult",
    "ultFast",
    "atk",
    "basic",
    "born",
    "counter",
    "heavy",
    "skill",
    "ultEmpty"
  }
  
  function roleTool.genSkActs(tool, role)
    local skActs = {}
    local commonActs = {}
    local atkActs = {}
    local bornActs = tool:newChooseList()
    local basicActs = {}
    local counterActs = {}
    local dashInActs = {}
    local dashOutActs = {}
    local heavyActs = {}
    local qteList = tool:newChooseList()
    local qteActs = {}
    local exQteActs = {}
    local linkQteActs = tool:newChooseList()
    local skillActs = {}
    local ultActs = {}
    local ultEmptyActs = {}
    local ultFastActs = {}
    local role = role
    role.skActs = skActs
    role.commonActs = commonActs
    role.atkActs = atkActs
    role.bornActs = bornActs
    role.basicActs = basicActs
    role.counterActs = counterActs
    role.dashInActs = dashInActs
    role.dashOutActs = dashOutActs
    role.heavyActs = heavyActs
    role.qteList = qteList
    role.qteActs = qteActs
    role.exQteActs = exQteActs
    role.linkQteActs = linkQteActs
    role.skillActs = skillActs
    role.ultActs = ultActs
    role.ultFastActs = ultFastActs
    role.ultEmptyActs = ultEmptyActs
    local skActBases = role.skActBases
    local actBase, customBase
    local bases = tool.skActBases
    for _, actBaseName in ipairs(skActBaseOrder) do
      actBase = bases[actBaseName]
      customBase = skActBases[actBaseName]
      skActBases[actBaseName] = actBase.setClass(customBase, skActBases) or actBase
    end
    local skActCfgs = get_unit_skill_action_cfg(role.id)
    for skActName, skActCfg in pairs(skActCfgs) do
      local type = skActCfg.Type
      if not type then
        if skActBases[skActName] then
          type = skActName
        else
          type = "common"
        end
      end
      local actImpBase = skActBases[type]
      local skAct = actImpBase:new(role, skActCfg)
      type = type .. "Acts"
      skActs[skActName] = skAct
      role[type][skActName] = skAct
      table.insert(role[type], skAct)
      if skAct:isQte() then
        qteList[skActName] = skAct
        table.insert(qteList, skAct)
      end
    end
    local sortFun = tool.sortSkAct
    table.sort(qteList, sortFun)
    table.sort(linkQteActs, sortFun)
    for skActName, skActCfg in pairs(skActCfgs) do
      local skAct = skActs[skActName]
      if skActCfg.TransEnable then
        for _, transName in ipairs(skActCfg.TransEnable) do
          skAct.trans.enable[transName] = skActs[transName]
        end
      end
      if skActCfg.TransDisable then
        for _, transName in ipairs(skActCfg.TransDisable) do
          skAct.trans.disable[transName] = skActs[transName]
        end
      end
      local copyBaseName = skActCfg.CopyBase
      if copyBaseName then
        local copyBase = skActs[copyBaseName]
        if not copyBase then
          role:debugOutput("copyBase not found, skAct is " .. skActName .. ", copyBase is " .. copyBaseName)
        else
          skAct:initCopy(copyBase)
        end
      end
    end
  end
  
  function roleTool.sortSkAct(act1, act2)
    return act1.id < act2.id
  end
  
  roleTool._copy_wait_list = {}
  roleTool._copy_done_list = {}
  
  function roleTool.copyActs(tool, role)
    local waitList = tool._copy_wait_list
    local doneList = tool._copy_done_list
    UtilTable.clear_map(waitList)
    UtilTable.clear_map(doneList)
    local skActs = role.skActs
    for _, act in pairs(skActs) do
      if act.copyBase then
        table.insert(waitList, act)
      end
    end
    for i = 1, 5 do
      local hasCopy
      for j, act in pairs(waitList) do
        hasCopy = true
        local copyBase = act.copyBase
        if not copyBase.copyBase or doneList[copyBase] then
          act:doCopy()
          doneList[act] = true
          waitList[j] = nil
        end
      end
      if not hasCopy then
        return
      end
    end
    local info = ""
    for _, act in pairs(waitList) do
      info = info .. act.name .. ": " .. act.copyBase.name .. ", "
    end
    role:debugOutput("act copy more than 5 level, remainning acts are " .. info)
  end
  
  function roleTool.copySkills(tool, role)
    local waitList = tool._copy_wait_list
    local doneList = tool._copy_done_list
    UtilTable.clear_map(waitList)
    UtilTable.clear_map(doneList)
    local skills = role.skills
    for _, skill in pairs(skills) do
      if skill.copyBase then
        table.insert(waitList, skill)
      end
    end
    for i = 1, 5 do
      local hasCopy
      for j, skill in pairs(waitList) do
        hasCopy = true
        local copyBase = skill.copyBase
        if not copyBase.copyBase or doneList[copyBase] then
          skill:doCopy()
          doneList[skill] = true
          waitList[j] = nil
        end
      end
      if not hasCopy then
        return
      end
    end
    local info = ""
    for _, skill in pairs(waitList) do
      info = info .. skill.name .. ": " .. skill.copyBase.name .. ", "
    end
    role:debugOutput("act copy more than 5 level, remainning acts are " .. info)
  end
  
  function roleTool.genIcons(role)
    local icons = {}
    local role = role
    role.icons = icons
    local iconCfgs = get_unit_logic_button_cfg(role.id)
    for iconName, iconCfg in pairs(iconCfgs) do
      local icon = iconBase:new(role, iconCfg)
      icons[iconName] = icon
    end
  end
  
  function roleTool.genBtns(role)
    local btns = {}
    local role = role
    role.btns = btns
    local btnCfgs = get_unit_physical_button_cfg(role.id)
    for btnName, btnCfg in pairs(btnCfgs) do
      local btn = btnBase:new(role, btnCfg)
      btns[btnName] = btn
      btns[btn.id] = btn
      btns[btn.id2] = btn
    end
  end
  
  function roleTool.genSpBar(role, list)
    return spBarBase:new(role, list)
  end
  
  function roleTool.genMagics(tool, role, magicIds)
    local role = role
    role.magics = tool.base.genMagics(role, magicIds, magicBase)
  end
end

function roleTool.getVector(startPos, endPos)
  local vector = {}
  vector.x = endPos.x - startPos.x
  vector.z = endPos.z - startPos.z
  return vector
end

function roleTool.vectNorm(vector)
  local norm = {}
  local sqrt = math.sqrt(vector.x * vector.x + vector.z * vector.z)
  norm.x = vector.x / sqrt
  norm.z = vector.z / sqrt
  return norm
end

function roleTool.vectDot(strVec, endVec)
  local result = strVec.x * endVec.x + strVec.z * endVec.z
  return result
end

function roleTool.vectCross(strVec, endVec)
  local result = strVec.x * endVec.z - endVec.x * strVec.z
  return result
end

function roleTool.getVectAngle(strVec, endVec)
  local strNorm = roleTool.vectNorm(strVec)
  local endNorm = roleTool.vectNorm(endVec)
  local dot = roleTool.vectDot(strNorm, endNorm)
  local cross = roleTool.vectCross(strNorm, endNorm)
  local absAngle = math.acos(dot)
  local result = absAngle
  if cross > 0 then
    result = -absAngle
  end
  result = math.deg(result)
  return result
end

function roleTool.getPosAngle(center, start, fin)
  local strVec = roleTool.getVector(center, start)
  local endVec = roleTool.getVector(center, fin)
  return roleTool.getVectAngle(strVec, endVec)
end

function roleTool.isInBattle(tool)
  if tool.target and not check_magic(tool.target, Const.LOCK_MASK_IN_FIGHT) then
    return true
  end
  local curRole = tool.curRole
  return curRole and curRole:isInBattle()
end

function roleTool.randByTime(role, possibility, period)
  period = period or 1
  math.randomseed(math.ceil(get_npc_time(role.npc) / period))
  return possibility > math.random()
end

function roleTool.on_destroy_mamager()
  roleTool.lastRole = nil
  roleTool.curRole = nil
  roleTool.ultMgr = nil
  roleTool.linkMgr = nil
  roleTool.rampMgr = nil
end

return roleTool
