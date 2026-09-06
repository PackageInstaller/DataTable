local function p1(protocol)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  
  local object = controller:GetPathResolver():GetChest(protocol.boxId)
  object:Open(protocol)
  local randomKey = NekoData.BehaviorManager.BM_Team:GetRandomRoleKeyInCurrentTeam()
  local roleID = randomKey
  LuaNotificationCenter.PostNotification(Common.n_OpenOneChestYeah, nil, {
    boxId = protocol.boxId
  })
end

local function p2(protocol, client)
end

return {p1, p2}
