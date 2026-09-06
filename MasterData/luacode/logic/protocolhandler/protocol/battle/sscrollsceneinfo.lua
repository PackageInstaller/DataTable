local function p1(protocol)
  local controller = SceneManager.GetSceneControllerByID(protocol.sceneId)
  
  if controller and controller.OnSScrollSceneInfo then
    controller:OnSScrollSceneInfo(protocol.scrollSceneInfo)
  elseif not controller then
    NekoData.DataManager.DM_SEnterDungeon:OnSScrollSceneInfo(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
