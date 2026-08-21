-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_vocation.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Vocation = class("DM_Vocation")
DM_Vocation.Ctor = function(self)
  -- function num : 0_0
  self._supportVocationTable = {}
end

DM_Vocation.Clear = function(self)
  -- function num : 0_1
  self._supportVocationTable = {}
end

DM_Vocation.GetOneSupportVocationTable = function(self, SourceDungeonStageID)
  -- function num : 0_2
  return (self._supportVocationTable)[SourceDungeonStageID]
end

DM_Vocation.SetOneSupportVocationTable = function(self, SourceDungeonStageID, oneSupportVocationTable)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self._supportVocationTable)[SourceDungeonStageID] = oneSupportVocationTable
end

return DM_Vocation

