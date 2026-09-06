local function func(params, childRedPointId)
  return NekoData.DataManager.DM_RedPoint:UpdateRedPointNum(childRedPointId, clone(params))
end

return func
