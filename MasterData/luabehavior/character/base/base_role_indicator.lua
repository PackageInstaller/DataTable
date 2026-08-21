local roleIndi = {}
roleIndi.__index = roleIndi
local searchBase = import("base.role.searchSystem.searchCfg")
local COARSETYPE = Const.INDICATOR_AREA_TYPE
local FINETYPE = Const.INDICATOR_INDI_TYPE

function roleIndi.insertFun(indi, funName, newFun)
  indi.tool.insert(indi, funName, newFun)
end

function roleIndi.removeFun(indi, funName, newFun)
  indi.tool.remove(indi, funName, newFun)
end

local function indiTarUpdateNilFun()
  Util.debug_output("请逮捕马一然并勒令他补充对应技能指示器的索敌更新函数")
end

function roleIndi.new(base, role, icon, cfg)
  local result = setmetatable({}, base)
  result.base = base
  result.role = role
  result.tool = role.tool
  result.mgr = role.indiMgr
  if not icon then
  end
  result.icon = icon
  result.btn = icon.btn
  local states = {
    idle = {name = "idle"},
    act = {name = "act"},
    hide = {name = "hide"},
    mask = {name = "mask"},
    preAim = {name = "preAim"},
    castAim = {name = "castAim"},
    aim = {name = "aim"},
    cast = {name = "cast"}
  }
  
  function states.mask.tick(indi)
    if indi.icon:getState() == "holding" then
      if indi:isCastAim() then
        indi:castAim()
      else
        indi:preAim()
      end
    end
  end
  
  function states.aim.tick(indi)
    local role = indi.role
    local skAct = role.skAct
    local aimSet = indi.aimSet
    if indi:isCastReady() then
      indi:cast()
      return
    elseif aimSet[skAct.name] and skAct.hitId == indi.icon.hitId or not indi:isAimReady() then
      indi:hide()
      return
    end
  end
  
  function states.preAim.tick(indi)
    if indi:isCastAim() then
      indi:castAim()
    end
  end
  
  function states.castAim.tick(indi)
    if not indi:isCastAim() then
      indi:preAim()
    end
  end
  
  function states.cast.tick(indi)
    if not indi:isCastReady() then
      indi:hide()
      return
    end
  end
  
  function states.hide.tick(indi)
    if indi:isCastReady() then
      indi:cast()
    end
  end
  
  result.states = states
  result.state = {}
  result.state[1] = states.idle
  result.autoLock = cfg.IndicatorAutoLock
  result.sensi = cfg.IndicatorSensitivity
  result.slomo = cfg.IndicatorSlomo
  result.viscous = cfg.IndicatorViscous
  result.maskType = cfg.IndicatorMaskType
  result.coarse = {
    type = cfg.IndicatorCoarseType,
    res = cfg.IndicatorCoarseRes or "FX_text_kong",
    sizex = cfg.IndicatorCoarseSizeX
  }
  result.fine = {
    type = cfg.IndicatorFineType,
    res = cfg.IndicatorFineRes or "FX_text_kong",
    sizex = cfg.IndicatorFineSizeX,
    sizey = cfg.IndicatorFineSizeY
  }
  local aimSet = {}
  local aimSetInput = cfg.IndicatorAimSet
  local outputs = {
    "hit",
    "hitUp",
    "hold",
    "holdUp"
  }
  if aimSetInput then
    for i, str in ipairs(aimSetInput) do
      local isBatch = false
      for _, outputName in ipairs(outputs) do
        if str == outputName then
          isBatch = true
          for _, skAct in ipairs(icon[outputName].skActs) do
            if not aimSet[skAct.name] then
              table.insert(aimSet, skAct)
              aimSet[skAct.name] = skAct
            end
          end
        end
      end
      if not isBatch then
        local skAct = role.skActs[str]
        local isOutput = false
        for _, outputName in ipairs(outputs) do
          if icon[outputName].skActs[skAct.name] then
            isOutput = true
            break
          end
        end
        if isOutput and not aimSet[skAct.name] then
          table.insert(aimSet, skAct)
          aimSet[skAct.name] = skAct
        end
      end
    end
  end
  result.aimSet = aimSet
  local castSet = {}
  local castSetInput = cfg.IndicatorCastSet
  if castSetInput then
    for _, str in ipairs(castSetInput) do
      if tonumber(str) then
      else
        local finTag, skill
        local pos = str:find(".", 1, true)
        if pos then
          local skillName = str:sub(1, pos - 1)
          finTag = str:sub(pos + 1, -1)
          skill = role.skills[skillName]
        else
          skill = role.skills[str]
        end
        if not skill or finTag and "onBef" ~= finTag and "onCast" ~= finTag then
        else
          castSet[skill] = finTag or "onEnd"
        end
      end
    end
  end
  result.castSet = castSet
  result.validSet = {}
  result.tempSet = {}
  result.search = searchBase:new(cfg, "indis." .. icon.name)
  result.searchTick = searchBase:new(cfg, "indis." .. icon.name .. "_tick")
  result.searchTick.bIsTick = true
  do
    local targetUpdateFuns = result.base.targetUpdate
    local updateFun
    if cfg.IndicatorFineRes then
      updateFun = targetUpdateFuns.fine[cfg.IndicatorFineType]
      if updateFun then
        result.targetUpdate = updateFun
        if cfg.IndicatorFineType == FINETYPE.CIRCLE then
          result.searchTick.secRadius = cfg.IndicatorFineSizeY
          result.searchTick.maxDis = cfg.IndicatorFineSizeY
        end
      else
        role:debugOutput("未知的方向技能指示器类型：", cfg.IndicatorFineType, "icon：", icon.name)
        result.targetUpdate = indiTarUpdateNilFun
      end
    else
      updateFun = targetUpdateFuns.coarse[cfg.IndicatorCoarseType]
      if updateFun then
        result.targetUpdate = updateFun
      else
        role:debugOutput("未知的范围技能指示器类型：", cfg.IndicatorCoarseType, "icon：", icon.name)
        result.targetUpdate = indiTarUpdateNilFun
      end
    end
  end
  return result
end

function roleIndi.tick(indi)
  for _, state in ipairs(indi.state) do
    local tick = state.tick
    if tick then
      tick(indi)
    end
  end
end

function roleIndi.idle(indi)
  indi.state[1] = indi.states.idle
  indi.state[2] = nil
  indi.state[3] = nil
  indi.mgr:indiIdle(indi)
end

function roleIndi.isAimReady(indi)
  if _G.next(indi:validAimSet()) then
    return true
  end
end

function roleIndi.isCastReady(indi)
  local icon = indi.icon
  local role = indi.role
  local skAct = role.skAct
  local set = indi.castSet
  local iconCheck = skAct.icon == icon
  local counterCheck = 0 == #indi.aimSet or skAct.hitId == icon.hitId
  local setCheck = false
  local curSk = skAct.curSk
  for skill, finTag in pairs(set) do
    if curSk == skill then
      if "onEnd" == finTag then
        setCheck = true
        break
      elseif "onBef" == finTag then
        setCheck = not curSk.isBefOver
        break
      else
        if "onCast" == finTag then
          setCheck = not curSk.isCastOver
          break
        else
        end
      end
    end
  end
  return iconCheck and counterCheck and setCheck
end

function roleIndi.act(indi)
  indi.isSlowed = false
  indi.state[1] = indi.states.act
  indi.state[2] = nil
  indi.state[3] = nil
  indi.btn = indi.icon.btn
  indi.mgr:indiAct(indi)
  if indi:isCastReady() then
    indi:cast()
  elseif indi:isAimReady() then
    indi:aim()
  else
    indi:hide()
  end
end

function roleIndi.validAimSet(indi)
  local aimSet = indi.aimSet
  local validSet = indi.validSet
  for i, _ in pairs(validSet) do
    validSet[i] = nil
  end
  local icon = indi.icon
  local tempSet = indi.tempSet
  tempSet[1], tempSet[2], tempSet[3], tempSet[4] = icon:validOutput()
  for i = 1, 4 do
    local output = tempSet[i]
    if output then
      for _, skAct in pairs(output.skActs) do
        if aimSet[skAct.name] and not validSet[skAct.name] then
          table.insert(validSet, skAct)
          validSet[skAct.name] = skAct
        end
      end
    end
  end
  return validSet
end

function roleIndi.isCastAim(indi)
  local set = indi:validAimSet()
  for _, skAct in pairs(set) do
    if skAct:isReady() then
      return skAct
    end
  end
end

function roleIndi.aim(indi)
  indi.state[1] = indi.states.act
  indi.state[2] = indi.states.aim
  indi.state[3] = nil
  indi:tick()
  if indi.state[2] == indi.states.aim and not indi.state[3] then
    if indi.maskType > 0 then
      indi:mask()
    elseif indi:isCastAim() then
      indi:castAim()
    else
      indi:preAim()
    end
  end
end

function roleIndi.mask(indi)
  indi.state[1] = indi.states.act
  indi.state[2] = indi.states.aim
  indi.state[3] = indi.states.mask
  indi:tick()
end

function roleIndi.preAim(indi)
  local oldState = indi.state[3]
  indi.state[1] = indi.states.act
  indi.state[2] = indi.states.aim
  indi.state[3] = indi.states.preAim
  indi:tick()
  if indi.state[3] == indi.states.preAim then
    local isInit = not oldState or oldState.name == "mask"
    indi.mgr:indiPreAim(indi, isInit)
  end
end

function roleIndi.castAim(indi)
  local oldState = indi.state[3]
  indi.state[1] = indi.states.act
  indi.state[2] = indi.states.aim
  indi.state[3] = indi.states.castAim
  indi:tick()
  if indi.state[3] == indi.states.castAim then
    local isInit = not oldState or oldState.name == "mask"
    indi.mgr:indiCastAim(indi, isInit)
  end
end

function roleIndi.cast(indi)
  local oldState2 = indi.state[2]
  local oldState3 = indi.state[3]
  indi.state[1] = indi.states.act
  indi.state[2] = indi.states.cast
  indi.state[3] = nil
  local isInit = not oldState2 or oldState2.name == "hide" or oldState3.name == "mask"
  indi.mgr:indiCast(indi, isInit)
end

function roleIndi.hide(indi)
  indi.state[1] = indi.states.act
  indi.state[2] = indi.states.hide
  indi.state[3] = nil
  indi:tick()
  if indi.state[2] == indi.states.hide and not indi.state[3] then
    indi.mgr:indiHide(indi)
  end
end

function roleIndi.getState(indi)
  local state = indi.state
  return state[#state].name
end

function roleIndi.isActive(indi)
  local states = indi.state
  local state = states[#states].name
  return "idle" ~= state and "hide" ~= state and "mask" ~= state
end

function roleIndi.tarPosInit(indi)
  return indi.role:searchTarget(indi.search)
end

roleIndi.targetUpdate = {
  coarse = {
    [COARSETYPE.CIRCLE] = indiTarUpdateNilFun,
    [COARSETYPE.SECTOR] = indiTarUpdateNilFun
  },
  fine = {
    [FINETYPE.CIRCLE] = function(indi)
      local curFrame = Global.frame_id
      local role = indi.role
      if curFrame < role.searchFrame then
        return
      end
      role.searchFrame = role.searchFrame + role.searchInterval
      local btn = indi.btn
      if indi.viscous and not btn:isDrag() then
        return
      end
      local range = indi.searchTick
      role:searchTarget(range, btn:indiPos(), nil, range.indi)
    end,
    [FINETYPE.ARROW] = function(indi)
      local curFrame = Global.frame_id
      local role = indi.role
      if curFrame < role.searchFrame then
        return
      end
      role.searchFrame = role.searchFrame + role.searchInterval
      local btn = indi.btn
      if indi.viscous and not btn:isDrag() then
        return
      end
      local range = indi.searchTick
      role:searchTarget(range, nil, btn)
    end,
    [FINETYPE.FIXED_ARROW] = indiTarUpdateNilFun,
    [FINETYPE.SCREEN_CIRCLE] = indiTarUpdateNilFun,
    [FINETYPE.LOCK_TAR_CIRCLE] = indiTarUpdateNilFun,
    [FINETYPE.TARGET_POS_ARROW] = indiTarUpdateNilFun,
    [FINETYPE.SECTOR_ARROW] = indiTarUpdateNilFun
  }
}

function roleIndi.isOn(indi)
  return indi.mgr:isOn(indi)
end

function roleIndi.getPos(indi)
  return indi.icon.btn:indiPos()
end

return roleIndi
