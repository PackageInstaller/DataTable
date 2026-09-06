local function func(params, childRedPointId)
  local roleId = params[1]
  
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  if not role then
    return 0
  end
  local num = 0
  local fashionList = role:GetSkinIDList()
  for i, v in ipairs(fashionList) do
    num = num + NekoData.DataManager.DM_RedPoint:UpdateRedPointNum(childRedPointId, {roleId, v})
  end
  return num
end

return func
