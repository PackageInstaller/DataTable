local function merge(lhs, rhs)
  for _, v in pairs(rhs) do
    if not table.any(lhs, function(npc)
      return npc.id == v.id
    end) then
      lhs[#lhs + 1] = v
    end
  end
  return lhs
end

local function p1(protocol)
  LogInfo("snpcappear", "receive")
  local notShowNpc = NekoData.BehaviorManager.BM_NPC:GetInvalidNpc()
  for _, value in ipairs(protocol.npcs) do
    for _, id in ipairs(notShowNpc) do
      if value.id == id then
        return
      end
    end
  end
  local controller = SceneManager.GetSceneControllerByID(protocol.sceneId)
  if controller and controller.AddNPC then
    if controller.IsActive then
      if controller:IsActive() then
        controller:AddNPC(protocol.npcs)
      else
        local npcs = controller:GetData("npcObjects") or {}
        controller:SetData("npcObjects", merge(npcs, protocol.npcs))
      end
    else
      controller:AddNPC(protocol.npcs)
    end
  elseif not controller then
    NekoData.DataManager.DM_SEnterDungeon:OnSNpcAppear(protocol)
  else
    LogWarning("snpcappear", "this scene dont have AddNPC function")
  end
end

local function p2(protocol, client)
end

return {p1, p2}
