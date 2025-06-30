-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/npc/snpcdisappear.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local direct_remove = function(npcs)
  -- function num : 0_0 , upvalues : _ENV
  for _,n in ipairs(npcs) do
    local result = ((NekoData.DataManager).DM_NPC):DeleteNpcInstanceWithId(n.id)
    if not result then
      LogWarning("snpcdisappear", "there is no npc with id " .. n.id .. " in this scene " .. protocol.sceneId)
    end
  end
end

local p1 = function(protocol)
  -- function num : 0_1 , upvalues : _ENV, direct_remove
  LogInfo("snpcdisappear", "receive")
  local controller = (SceneManager.GetSceneControllerByID)(protocol.sceneId)
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
  else
    if not controller then
      ((NekoData.DataManager).DM_SEnterDungeon):OnSNpcDisAppear(protocol)
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_2
end

return {p1, p2}

