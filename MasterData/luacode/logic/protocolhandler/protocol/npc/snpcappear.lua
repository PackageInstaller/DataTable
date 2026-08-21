-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/npc/snpcappear.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local merge = function(lhs, rhs)
  -- function num : 0_0 , upvalues : _ENV
  for _,v in pairs(rhs) do
    do
      if not (table.any)(lhs, function(npc)
    -- function num : 0_0_0 , upvalues : v
    do return npc.id == v.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
) then
        lhs[#lhs + 1] = v
      end
    end
  end
  return lhs
end

local p1 = function(protocol)
  -- function num : 0_1 , upvalues : _ENV, merge
  LogInfo("snpcappear", "receive")
  local notShowNpc = ((NekoData.BehaviorManager).BM_NPC):GetInvalidNpc()
  for _,value in ipairs(protocol.npcs) do
    for _,id in ipairs(notShowNpc) do
      if value.id == id then
        return 
      end
    end
  end
  local controller = (SceneManager.GetSceneControllerByID)(protocol.sceneId)
  if controller and controller.AddNPC then
    if controller.IsActive then
      if controller:IsActive() then
        controller:AddNPC(protocol.npcs)
      else
        if not controller:GetData("npcObjects") then
          local npcs = {}
        end
        controller:SetData("npcObjects", merge(npcs, protocol.npcs))
      end
    else
      do
        controller:AddNPC(protocol.npcs)
        if not controller then
          ((NekoData.DataManager).DM_SEnterDungeon):OnSNpcAppear(protocol)
        else
          LogWarning("snpcappear", "this scene dont have AddNPC function")
        end
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_2
end

return {p1, p2}

