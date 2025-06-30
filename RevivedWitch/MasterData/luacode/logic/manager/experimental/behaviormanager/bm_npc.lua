-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_npc.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_NPC = class("BM_NPC")
BM_NPC.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).npc
end

BM_NPC.GetNpcInstance = function(self, sceneId, npcId)
  -- function num : 0_1 , upvalues : _ENV
  for _,v in pairs((self._data)._npc) do
    if v:GetSceneId() == sceneId and v:GetNpcId() == npcId then
      return v
    end
  end
  return nil
end

BM_NPC.GetNpcObj = function(self, sceneId, npcId)
  -- function num : 0_2 , upvalues : _ENV
  for _,v in pairs((self._data)._npc) do
    if v:GetSceneId() == sceneId and v:GetNpcId() == npcId then
      return v:GetObj()
    end
  end
  LogInfo("BM_NPC", "this npc " .. npcId .. " is nonexistent in scene " .. sceneId)
  return nil
end

BM_NPC.GetPosition = function(self, sceneId, npcId)
  -- function num : 0_3 , upvalues : _ENV
  local x, y = 0, 0
  for _,v in pairs((self._data)._npc) do
    if v:GetSceneId() == sceneId and v:GetNpcId() == npcId then
      x = v:GetPosition()
      break
    end
  end
  do
    return x, y
  end
end

BM_NPC.GetInvalidNpc = function(self)
  -- function num : 0_4
  if not (self._data).invalidNpc then
    return {}
  end
end

return BM_NPC

