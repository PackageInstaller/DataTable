local skActBase = import("character.base.base_role_skillAction")
local bornBase = Util.create_child_mt(skActBase)
bornBase._bornBase = bornBase
bornBase.bornBase = bornBase

function bornBase.setClass(customBornBase, actBases)
  local ret = customBornBase or bornBase
  local newParent = actBases.common
  if newParent ~= skActBase and ret == bornBase then
    ret = {}
  end
  if ret ~= bornBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.bornBase = ret.bornBase or ret
    UtilTable.fill_table(bornBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function bornBase.new(customBornBase, role, _cfg)
  local born = setmetatable({}, customBornBase)
  born.base = customBornBase
  born.type = Const.SKILL_ACTION_TYPE.BORN
  customBornBase:_init(born, role, _cfg)
  return born
end

function bornBase._init(customBornBase, born, role, _cfg)
  born.bornBase = customBornBase
  customBornBase.skActBase:_init(born, role, _cfg)
  local cfg = _cfg or {}
  local trans = born.trans
  trans.prio = cfg.TransPrio or 9999
  trans.inertia = cfg.TransInertia or 9999
end

function bornBase.isCommon()
end

function bornBase.isBorn()
  return true
end

function bornBase.isReady()
  return true
end

function bornBase.tarPos(born)
  local x, z = get_scene_map_pos_postion("center")
  if not x or not z then
    return nil
  else
    local tarPos = born.role._tarPos
    tarPos.x, tarPos.z = x, z
    return tarPos
  end
end

function bornBase.onBegin(born)
  set_ui_object_visible("fight", "Main", false, true)
  born.skActBase.onBegin(born)
end

function bornBase.onCastTime(born, retainCache, ignoreIcon)
  set_ui_object_visible("fight", "Main", true)
  born.skActBase.onCastTime(born, retainCache, ignoreIcon)
end

function bornBase.onBreak(born, tarAct)
  if not born.isCastOver then
    set_ui_object_visible("fight", "Main", true)
  end
  born.skActBase.onBreak(born, tarAct)
end

function bornBase.onEnd(born)
  if not born.isCastOver then
    set_ui_object_visible("fight", "Main", true)
  end
  born.skActBase.onEnd(born)
end

return bornBase
