local function func(params, childRedPointId, selfRedPointId)
  local roleId = params[1]
  
  local evolutionStageLevel = params[2]
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  if not role then
    return 0
  end
  local enableEvolve = role:IsShowEvolutionRedDotByLv(evolutionStageLevel)
  if enableEvolve then
    return 1
  else
    return 0
  end
end

return func
