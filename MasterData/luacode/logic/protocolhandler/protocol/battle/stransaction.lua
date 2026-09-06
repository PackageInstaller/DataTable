local function p1(protocol)
  NekoData.DataManager.DM_Dungeon:OnSTransaction()
  
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller then
    controller:OnTransaction(protocol.value, protocol.kind)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
