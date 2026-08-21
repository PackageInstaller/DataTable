local skactBase = import("character.base.base_role_skillAction")
local misLogicBase = import("character.base.base_missileLogic")
local magicBase = import("character.base.base_magic")
local VAR_TYPE = Const.VAR_TYPE
local baseFunList = Util.create_class()

function baseFunList:__call(...)
  local ret1, ret2, ret3
  if self.oriFun then
    ret1, ret2, ret3 = self.oriFun(...)
  else
    local index = rawget(getmetatable(self.obj), "__index")
    local type = type(index)
    if type == VAR_TYPE.TABLE then
      ret1, ret2, ret3 = index[self.funName](...)
    elseif type == VAR_TYPE.FUNCTION then
      ret1, ret2, ret3 = index(self.obj, self.funName)
    end
  end
  for _, fun in ipairs(self) do
    fun(...)
  end
  return ret1, ret2, ret3
end

local baseChooseList = {}
baseChooseList.__index = baseChooseList

function baseChooseList.new(base)
  local ret = setmetatable({}, base)
  return ret
end

function baseChooseList.choose(list, ...)
  for _, obj in ipairs(list) do
    if obj:isReady(...) then
      return obj
    end
  end
end

local toolBase = Util.create_class()

function toolBase.setUp(toolBase)
  local toolBase = toolBase
  toolBase.base = toolBase
  toolBase.roleBase = ComnMgr.RoleBase
  toolBase.baseChooseList = baseChooseList
  toolBase.team = {
    num = 0,
    role = {},
    npc = {}
  }
  toolBase.fight_ui_list = {
    JoystickContent = true,
    Right = true,
    TeamHeads = true,
    Btn_skill2 = true
  }
end

function toolBase.newChooseList(tool)
  return tool.baseChooseList:new()
end

function toolBase.insert(tarObj, funName, newFun, pos)
  local oldFun = tarObj[funName]
  if not oldFun then
    tarObj[funName] = newFun
  else
    local oldFunType = type(oldFun)
    local types = Const.VAR_TYPE
    if oldFunType == types.FUNCTION then
      local list = Util.create_child_mt(baseFunList)
      list.obj = tarObj
      list.funName = funName
      list.oriFun = rawget(tarObj, funName)
      list[1] = newFun
      tarObj[funName] = list
    elseif oldFunType == types.TABLE then
      if type(pos) == types.NUMBER then
        table.insert(oldFun, pos, newFun)
      else
        table.insert(oldFun, newFun)
      end
    end
  end
end

function toolBase.remove(tarObj, funName, newFun)
  local oldFun = rawget(tarObj, funName)
  if not oldFun then
    return
  end
  local type = type(oldFun)
  local types = Const.VAR_TYPE
  if type == types.FUNCTION then
    if oldFun == newFun then
      tarObj[funName] = nil
    end
  elseif type == types.TABLE then
    local list = oldFun
    local pos
    for i = #list, 1, -1 do
      if list[i] == newFun then
        pos = i
        break
      end
    end
    if not pos then
      return
    end
    table.remove(list, pos)
    if 0 == #list then
      tarObj[funName] = list.oriFun
    end
  end
end

function toolBase.genMisLogics(unit, missileIds)
  local misLogics = {}
  for missileName, missileId in pairs(missileIds) do
    if type(missileId) == "number" then
      local missile = misLogicBase:new(unit, missileId, missileName)
      misLogics[missileName] = missile
      misLogics[missileId] = missile
    elseif type(missileId) == "table" then
      local misList = {}
      misLogics[missileName] = misList
      for keyName, _missileId in pairs(missileId) do
        local name = missileName .. "_" .. keyName
        local misLogic = misLogicBase:new(unit, _missileId, name)
        misList[keyName] = misLogic
        misLogics[_missileId] = misLogic
      end
    end
  end
  local unit = unit
  unit.misLogics = misLogics
  unit.misInsts = {}
end

function toolBase.genMagics(unit, magicIds, _magicBase)
  _magicBase = _magicBase or magicBase.common
  local magics = unit.magics or {}
  for magicName, magicId in pairs(magicIds) do
    if type(magicId) == "number" then
      local magic = magics[magicId] or _magicBase:new(unit, magicId, magicName)
      magics[magicName] = magic
      magics[magicId] = magic
    elseif type(magicId) == "table" then
      local magicList = {}
      magics[magicName] = magicList
      for keyName, _magicId in pairs(magicId) do
        local name = magicName .. "_" .. keyName
        local magic = magics[_magicId] or _magicBase:new(unit, _magicId, name)
        magicList[keyName] = magic
        if not magics[_magicId] then
          magics[_magicId] = magic
        end
      end
    end
  end
  return magics
end

toolBase._aCenter = vec3:New()
toolBase._bCenter = vec3:New()
toolBase._interSectPos1 = vec3:New()
toolBase._interSectPos2 = vec3:New()
toolBase._ab = vec3:New()
toolBase._ec = vec3:New()
toolBase._E = vec3:New()

function toolBase.circleIntersectTemp(tool, aCenter, aRadius, bCenter, bRadius)
  local y = aCenter.y
  local _aCenter = tool._aCenter
  _aCenter:SetA(aCenter)
  aCenter = _aCenter
  aCenter.y = 0
  local _bCenter = tool._bCenter
  _bCenter:SetA(bCenter)
  bCenter = _bCenter
  bCenter.y = 0
  local ab = tool._ab
  ab:SetB(bCenter):Sub(aCenter)
  local dis = ab:Magnitude()
  local sum = aRadius + bRadius
  if dis > sum then
    return nil
  end
  ab:SetNormalize()
  local interSectPos1, interSectPos2 = tool._interSectPos1, tool._interSectPos2
  if sum - dis <= 1.0E-5 then
    interSectPos1:SetB(ab):Mul(aRadius):Add(aCenter)
    interSectPos1.y = y
    return interSectPos1, nil, interSectPos1
  end
  local delta = math.abs(aRadius - bRadius)
  if dis - delta > 1.0E-5 then
    local aeLength = (aRadius ^ 2 - bRadius ^ 2 + dis ^ 2) / (2 * dis)
    local ecLength = (aRadius ^ 2 - aeLength ^ 2) ^ 0.5
    local E = tool._E
    E:SetB(ab):Mul(aeLength):Add(aCenter)
    local C, D = interSectPos1, interSectPos2
    local ec = tool._ec
    ec:Set(ab.z, 0, -ab.x)
    C:SetB(ec):Mul(ecLength):Add(E)
    D:SetB(ec):Mul(-ecLength):Add(E)
    return C, D, E
  end
  if dis > delta then
    interSectPos1:SetB(ab):Mul(-aRadius):Add(aCenter)
    interSectPos1.y = y
    return interSectPos1, nil, interSectPos1
  end
  if dis < delta then
    return nil
  end
end

function toolBase.circleIntersect(tool, aCenter, aRadius, bCenter, bRadius)
  local ret1, ret2, ret3 = tool:circleIntersectTemp(aCenter, aRadius, bCenter, bRadius)
  ret1 = ret1 and ret1:Clone()
  ret2 = ret2 and ret2:Clone()
  ret3 = ret3 and ret3:Clone()
  return ret1, ret2, ret3
end

toolBase._cp = vec3:New()
toolBase._dir = vec3:New()

function toolBase.isInSectorRing(tool, pos, center, minRadius, maxRadius, dir, cos, angle, height)
  minRadius = minRadius or 0
  height = height or 10
  local cp = tool._cp
  cp:SetB(pos):Sub(center)
  if height < math.abs(cp.y) then
    return false
  end
  cp.y = 0
  local sqrCp = cp:SqrMagnitude()
  local sqrMin = minRadius ^ 2
  if sqrCp < sqrMin then
    return false
  end
  local sqrMax = maxRadius ^ 2
  if sqrCp > sqrMax then
    return false
  end
  if not dir or not cos and not angle then
    return true
  end
  local _dir = tool._dir
  _dir:Set(dir.x, 0, dir.z)
  _dir:SetNormalize()
  dir = _dir
  cos = cos or math.cos(angle)
  local dot = cp:Dot(dir)
  if dot > 0 and cos > 0 then
    return dot ^ 2 > sqrCp * cos ^ 2
  elseif dot < 0 and cos < 0 then
    return dot ^ 2 < sqrCp * cos ^ 2
  else
    return dot >= 0
  end
end

function toolBase.set_ui_visible(tool, objName, isVisible)
  if isVisible then
    local extraHideList = get_ui_obj_list()
    if extraHideList and extraHideList.fight and extraHideList.fight[objName] then
      return
    end
  end
  if tool.fight_ui_list[objName] then
    if isVisible ~= get_fight_ui_object_visible(objName) then
      set_fight_ui_object_visible(objName, isVisible)
    end
  elseif isVisible ~= get_ui_object_self_active("fight", objName) then
    set_ui_object_visible("fight", objName, isVisible, true)
  end
end

function toolBase.toggleUi(tool, list, listVisible, hpVisible)
  set_all_npc_hp_visible(hpVisible)
  for objName, needHide in pairs(list) do
    if not listVisible and not needHide then
    elseif "JoystickContent" == objName then
      set_joystick_alpha_visible(listVisible)
    else
      tool:set_ui_visible(objName, listVisible)
    end
  end
end

function toolBase.toggleTeamHeads(tool, isVisible)
  return tool:set_ui_visible("TeamHeads", isVisible)
end

function toolBase.castMagicToTeam(tool, magicId, lv, caster, num)
  caster = caster or get_come_on_hero()
  if not caster then
    return
  end
  local team = tool.team.role
  for _, role in pairs(team) do
    role:addMagic(magicId, lv, caster, num)
  end
end

function toolBase.bornMagicToTeam(tool, magicId, lv, caster, num)
  caster = caster or get_come_on_hero()
  if not caster then
    return
  end
  local roleBase = tool.roleBase
  roleBase:addBornLogic(roleBase.addMagic, true, magicId, lv, caster, num)
end

function toolBase.abortMagicToTeam(tool, ...)
  local team = tool.team.npc
  local magic
  for i = 1, select("#", ...) do
    magic = select(i, ...)
    for _, npc in pairs(team) do
      abort_magic_by_id(npc, magic)
    end
  end
end

function toolBase.abortMagicToTeamA(tool, magicId, num)
  num = num or 1
  local team = tool.team.npc
  for _, npc in pairs(team) do
    abort_magic_by_id(npc, magicId, num)
  end
end

function toolBase.checkMagicToTeam(tool, magicId)
  local team = tool.team
  local teamNpc = team.npc
  local num = 0
  for _, npc in pairs(teamNpc) do
    if check_magic(npc, magicId) then
      num = num + 1
    end
  end
  return 0 ~= num and num == team.num, num
end

function toolBase.enable_qte_ux_to_team(tool, ux, prio)
  local team = tool.team.npc
  for _, role in pairs(team) do
    set_qte_effect_active(role, ux, true, prio)
  end
end

function toolBase.disable_qte_ux_to_team(tool, ux, prio)
  local team = tool.team.npc
  for _, role in pairs(team) do
    set_qte_effect_active(role, ux, false, prio)
  end
end

function toolBase.dummySkAct(tool, behavior)
  return skactBase:new(behavior)
end

function toolBase.randByTime(tool, period, possibility)
  period = period or 1
  math.randomseed(math.ceil(get_time() / period))
  local result = math.random()
  local compare = possibility and possibility > result
  return result, compare
end

function toolBase.isActiveStatus(npc)
  local status = get_npc_status(npc)
  if check_npc_status(npc, 14) then
    return false
  end
  return 0 == status or 1 == status or 4 == status or 9 == status
end

function toolBase.on_destroy_mamager()
  toolBase.base = nil
  toolBase.roleBase = nil
  toolBase.team = nil
  toolBase.fight_ui_list = nil
end

return toolBase
