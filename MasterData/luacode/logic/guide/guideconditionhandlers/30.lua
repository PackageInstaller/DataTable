local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local tag = tonumber(params[1])
  local state = tonumber(params[2])
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  if controller and controller._baseMainFSM then
    if tag == -1 then
      return controller._baseMainFSM:GetLastState() == DataCommon.BaseMainFSM[state]
    elseif tag == 0 then
      return controller._baseMainFSM:GetCurrentState() == DataCommon.BaseMainFSM[state]
    end
  else
    return false
  end
end

return func
