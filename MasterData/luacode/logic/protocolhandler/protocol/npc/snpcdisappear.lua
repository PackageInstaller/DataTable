local function direct_remove(npcs)
  for _, n in ipairs(npcs) do
    local result = NekoData.DataManager.DM_NPC:DeleteNpcInstanceWithId(n.id)
    
    if not result then
      LogWarning("snpcdisappear", "there is no npc with id " .. n.id .. " in this scene " .. protocol.sceneId)
    end
  end
end

local function p1(protocol)
  LogInfo("snpcdisappear", "receive")
  local controller = SceneManager.GetSceneControllerByID(protocol.sceneId)
  if controller and controller.AddNPC then
    if controller.IsActive then
      if controller:IsActive() then
        direct_remove(protocol.npcs)
      else
        controller:OnSNpcDisappear(protocol.npcs)
      end
    else
      direct_remove(protocol.npcs)
    end
  elseif not controller then
    NekoData.DataManager.DM_SEnterDungeon:OnSNpcDisAppear(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
