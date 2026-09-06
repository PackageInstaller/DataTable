local PathResolver = require("logic.scene.pathresolver")

local function p1(protocol)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller and controller:IsNavMeshReady() then
    local path = string.gsub("[sso $d]", "%$d", protocol.obj.id)
    local object = PathResolver.ResolveObject(path)
    if not object then
      LogError("sceneobject", "no sceneobject " .. path)
      NekoData.DataManager.DM_SEnterDungeon:OnSInteractive(protocol)
    else
      object:ToState(protocol.obj.state - 1):Run()
    end
  else
    NekoData.DataManager.DM_SEnterDungeon:OnSInteractive(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
