local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller then
    return controller._blockStatus == params[1]
  end
end

return func
