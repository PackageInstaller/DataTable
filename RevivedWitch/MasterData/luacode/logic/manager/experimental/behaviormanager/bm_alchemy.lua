-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_alchemy.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAlchemyLvCfg = (BeanManager.GetTableByName)("courtyard.calchemylv")
local CAlchemyStageCfg = (BeanManager.GetTableByName)("courtyard.calchemystage")
local BM_Alchemy = class("BM_Alchemy")
BM_Alchemy.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._alchemy = (NekoData.Data).alchemy
end

BM_Alchemy.GetLevel = function(self)
  -- function num : 0_1
  return (self._alchemy).level
end

BM_Alchemy.GetAlchemyLevel = function(self)
  -- function num : 0_2
  return (self._alchemy).alchemyLevel
end

BM_Alchemy.GetMaxAlchemyLevel = function(self)
  -- function num : 0_3 , upvalues : CAlchemyLvCfg
  return #CAlchemyLvCfg:GetAllIds()
end

BM_Alchemy.GetAlchemyExp = function(self)
  -- function num : 0_4
  return (self._alchemy).alchemyExp
end

BM_Alchemy.GetDispatchRoles = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local list = {}
  for i,roleKey in ipairs((self._alchemy).roles) do
    (table.insert)(list, roleKey)
  end
  return list
end

BM_Alchemy.GetDispatchMaxRoleNum = function(self)
  -- function num : 0_6
  return 1
end

BM_Alchemy.GetFormulas = function(self)
  -- function num : 0_7
  return (self._alchemy)._formulas
end

BM_Alchemy.GetUnlockAlchemyLvByStage = function(self, stage)
  -- function num : 0_8 , upvalues : CAlchemyLvCfg
  local allIds = CAlchemyLvCfg:GetAllIds()
  local length = #allIds
  for i = 1, length do
    local recorder = CAlchemyLvCfg:GetRecorder(allIds[i])
    if recorder.alchemystage == stage then
      return recorder.id
    end
  end
end

BM_Alchemy.GetAlchemyStage = function(self)
  -- function num : 0_9
  return (self._alchemy).alchemyStage
end

BM_Alchemy.GetMaxAlchemyStage = function(self)
  -- function num : 0_10 , upvalues : CAlchemyStageCfg
  local allIds = CAlchemyStageCfg:GetAllIds()
  return (CAlchemyStageCfg:GetRecorder(allIds[#allIds])).id - 1
end

return BM_Alchemy

