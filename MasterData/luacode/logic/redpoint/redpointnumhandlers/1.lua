local function func(params, childRedPointId)
  local roleList = NekoData.BehaviorManager.BM_AllRoles:GetRoleList()
  
  local num = 0
  for i, v in ipairs(roleList) do
    num = num + NekoData.DataManager.DM_RedPoint:UpdateRedPointNum(childRedPointId, {
      v:GetId()
    })
  end
  return num
end

return func
