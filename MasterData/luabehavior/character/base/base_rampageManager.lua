local rampMgr = {}

function rampMgr.setUp(rampMgr)
  local rampMgr = rampMgr
  rampMgr.tool = ComnMgr.RoleTool
  rampMgr.isFxOn = false
  rampMgr.isEffectOn = false
  do
    local RAMPAGE_CONFIG = Const.RAMPAGE_CONFIG
    rampMgr.fxRole = RAMPAGE_CONFIG.RAMPAGE_FX_ROLE
    rampMgr.fxCam = RAMPAGE_CONFIG.RAMPAGE_FX_CAM
    rampMgr.speedUp = RAMPAGE_CONFIG.RAMPAGE_SPEED
    rampMgr.fill2 = Const.ATTR.FILL2
    rampMgr.inf2 = RAMPAGE_CONFIG.RAMPAGE_INF2
  end
end

function rampMgr.tryFx(mgr, ...)
  if mgr.isFxOn then
    return
  end
  mgr.isFxOn = true
  local tool = mgr.tool
  local fxRole = mgr.fxRole
  local fxCam = mgr.fxCam
  local team = tool.team.role
  local npc
  local frontNpc = get_come_on_hero()
  cast_magic(frontNpc, frontNpc, fxCam)
  for _, role in pairs(team) do
    npc = role.npc
    cast_magic(npc, npc, fxRole)
    if role.onRampageStart then
      role:onRampageStart(...)
    end
  end
end

function rampMgr.tryEffect(mgr, ...)
  if mgr.isEffectOn then
    return
  end
  local team = mgr.tool.team.role
  local speedUp = mgr.speedUp
  local fill2 = mgr.fill2
  local inf2 = mgr.inf2
  for _, role in pairs(team) do
    role:clearCd()
    local npc = role.npc
    cast_magic(npc, npc, speedUp)
    cast_magic(npc, npc, fill2)
    cast_magic(npc, npc, inf2)
    if role.onRampageEffect then
      role:onRampageEffect(...)
    end
  end
end

function rampMgr.finishRamp(mgr, ...)
  local isFxOn = mgr.isFxOn
  mgr.isFxOn = false
  mgr.isEffectOn = false
  local tool = mgr.tool
  local fxRole = mgr.fxRole
  local fxCam = mgr.fxCam
  local speedUp = mgr.speedUp
  local inf2 = mgr.inf2
  local team = tool.team.role
  local npc
  for _, role in pairs(team) do
    npc = role.npc
    abort_magic_by_id(npc, fxRole)
    abort_magic_by_id(npc, fxCam)
    abort_magic_by_id(npc, speedUp)
    abort_magic_by_id(npc, inf2)
    if isFxOn and role.onRampageEnd then
      role:onRampageEnd(...)
    end
  end
end

function rampMgr.isOn(mgr)
  return mgr.isFxOn
end

return rampMgr
