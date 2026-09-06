local function func(breakStageLevel, params)
  local roleId = params[1]
  
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  if not role then
    return
  end
  return 0 < breakStageLevel and breakStageLevel <= role:GetMaxBreakLv()
end

return func
