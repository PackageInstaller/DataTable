-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_npc.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_NPC = class("DM_NPC")
DM_NPC.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).npc
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data)._npc = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).invalidNpc = {}
end

DM_NPC.SetNpcInstance = function(self, npcInstance)
  -- function num : 0_1 , upvalues : _ENV
  for _,v in pairs((self._data)._npc) do
    if v:GetSceneId() == npcInstance:GetSceneId() and v:GetNpcId() == npcInstance:GetNpcId() then
      npcInstance:Destroy()
      LogError("DM_NPC", "this npc " .. v:GetNpcId() .. " is already existed in scene " .. v:GetSceneId())
      return false
    end
  end
  ;
  (table.insert)((self._data)._npc, npcInstance)
  npcInstance:OnCreate()
  return true
end

DM_NPC.DeleteNpcInstanceWithId = function(self, npcID)
  -- function num : 0_2 , upvalues : _ENV
  for i,v in pairs((self._data)._npc) do
    if v:GetNpcId() == npcID then
      v:Destroy()
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._data)._npc)[i] = nil
      return true
    end
  end
  ;
  (table.insert)((self._data).invalidNpc, npcID)
  return false
end

DM_NPC.Clear = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for _,v in pairs((self._data)._npc) do
    v:Destroy()
  end
  for k,v in pairs((self._data)._npc) do
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

    ((self._data)._npc)[k] = nil
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).invalidNpc = {}
end

return DM_NPC

