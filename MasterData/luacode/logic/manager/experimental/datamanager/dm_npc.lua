local DM_NPC = class("DM_NPC")

function DM_NPC:Ctor()
  self._data = NekoData.Data.npc
  self._data._npc = {}
  self._data.invalidNpc = {}
end

function DM_NPC:SetNpcInstance(npcInstance)
  for _, v in pairs(self._data._npc) do
    if v:GetSceneId() == npcInstance:GetSceneId() and v:GetNpcId() == npcInstance:GetNpcId() then
      npcInstance:Destroy()
      LogError("DM_NPC", "this npc " .. v:GetNpcId() .. " is already existed in scene " .. v:GetSceneId())
      return false
    end
  end
  table.insert(self._data._npc, npcInstance)
  npcInstance:OnCreate()
  return true
end

function DM_NPC:DeleteNpcInstanceWithId(npcID)
  for i, v in pairs(self._data._npc) do
    if v:GetNpcId() == npcID then
      v:Destroy()
      self._data._npc[i] = nil
      return true
    end
  end
  table.insert(self._data.invalidNpc, npcID)
  return false
end

function DM_NPC:Clear()
  for _, v in pairs(self._data._npc) do
    v:Destroy()
  end
  for k, v in pairs(self._data._npc) do
    self._data._npc[k] = nil
  end
  self._data.invalidNpc = {}
end

return DM_NPC
