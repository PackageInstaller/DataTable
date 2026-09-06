local function func(evolutionStageLevel, params)
  local roleId = params[1]
  
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  if not role then
    return
  end
  return 0 < evolutionStageLevel and evolutionStageLevel <= role:GetEvolutionLimit()
end

return func
