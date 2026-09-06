local function func(roleId, params)
  return NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
end

return func
