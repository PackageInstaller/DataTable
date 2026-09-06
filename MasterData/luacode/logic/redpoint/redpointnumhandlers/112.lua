local function SetUnChecked(checked, redPointKey)
  if checked then
    NekoData.BehaviorManager.BM_RedPoint:SetUnCheckedByRedPointKey(redPointKey)
  end
end

local function func(params, childRedPointId, selfRedPointId)
  local redPointKey = selfRedPointId
  if params then
    for _, v in ipairs(params) do
      redPointKey = redPointKey .. "_" .. tostring(v)
    end
  end
  local checked = NekoData.BehaviorManager.BM_RedPoint:IsCheckedByRedPointKey(redPointKey)
  local roleId = params[1]
  local breakStageLevel = params[2]
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  if not role then
    SetUnChecked(checked, redPointKey)
    return 0
  end
  local enableEvolve = role:IsShowBreakRedDotByLv(breakStageLevel)
  if enableEvolve then
    if not checked then
      return 1
    else
      return 0
    end
  else
    SetUnChecked(checked, redPointKey)
    return 0
  end
end

return func
