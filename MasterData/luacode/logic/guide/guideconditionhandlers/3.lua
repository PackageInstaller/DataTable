local function func(conditionInfo)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  
  return controller and controller._responseMouseClick
end

return func
