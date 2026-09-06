local BM_NPC = class("BM_NPC")

function BM_NPC:Ctor()
  self._data = NekoData.Data.npc
end

function BM_NPC:GetNpcInstance(sceneId, npcId)
  for _, v in pairs(self._data._npc) do
    if v:GetSceneId() == sceneId and v:GetNpcId() == npcId then
      return v
    end
  end
  return nil
end

function BM_NPC:GetNpcObj(sceneId, npcId)
  for _, v in pairs(self._data._npc) do
    if v:GetSceneId() == sceneId and v:GetNpcId() == npcId then
      return v:GetObj()
    end
  end
  LogInfo("BM_NPC", "this npc " .. npcId .. " is nonexistent in scene " .. sceneId)
  return nil
end

function BM_NPC:GetPosition(sceneId, npcId)
  local x, y = 0, 0
  for _, v in pairs(self._data._npc) do
    if v:GetSceneId() == sceneId and v:GetNpcId() == npcId then
      x, y = v:GetPosition()
      break
    end
  end
  return x, y
end

function BM_NPC:GetInvalidNpc()
  return self._data.invalidNpc or {}
end

return BM_NPC
