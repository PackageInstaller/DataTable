local function p1(protocol)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  
  if controller then
    controller:LoadModules({
      [protocol.id] = protocol.statue
    })
  end
end

local function p2(protocol, client)
end

return {p1, p2}
