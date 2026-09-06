local function func(skinID, params)
  local roleId = params[1]
  
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  if not role then
    return
  end
  local fashionList = role:GetSkinIDList()
  for i, v in ipairs(fashionList) do
    if v == skinID then
      return true
    end
  end
end

return func
