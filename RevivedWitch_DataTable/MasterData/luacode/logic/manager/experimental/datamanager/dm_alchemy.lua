-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_alchemy.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAlchemyFormulaTypeCfg = (BeanManager.GetTableByName)("courtyard.calchemyformulatype")
local CAlchemyFormulaCfg = (BeanManager.GetTableByName)("courtyard.calchemyformula")
local Item = require("logic.manager.experimental.types.item")
local DM_Alchemy = class("DM_Alchemy")
DM_Alchemy.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._alchemy = (NekoData.Data).alchemy
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._alchemy).level = 0
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._alchemy).alchemyLevel = 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._alchemy).alchemyStage = 0
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._alchemy).alchemyExp = 0
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._alchemy).roles = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._alchemy)._formulas = {}
end

DM_Alchemy.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._alchemy).level = 0
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._alchemy).alchemyLevel = 0
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._alchemy).alchemyStage = 0
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._alchemy).alchemyExp = 0
  while ((self._alchemy).roles)[#(self._alchemy).roles] do
    (table.remove)((self._alchemy).roles, #(self._alchemy).roles)
  end
  for k,v in pairs((self._alchemy)._formulas) do
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

    ((self._alchemy)._formulas)[k] = nil
  end
end

DM_Alchemy.OnSYardInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  local alchemyInfo = protocol.alchemy
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._alchemy).level = alchemyInfo.buildLevel
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._alchemy).alchemyLevel = alchemyInfo.alchemyLevel
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._alchemy).alchemyStage = alchemyInfo.alchemyStage
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._alchemy).alchemyExp = alchemyInfo.alchemyExperience
  while ((self._alchemy).roles)[#(self._alchemy).roles] do
    (table.remove)((self._alchemy).roles, #(self._alchemy).roles)
  end
  if alchemyInfo.roleId ~= 0 then
    (table.insert)((self._alchemy).roles, alchemyInfo.roleId)
  end
  self:SetFormulas()
end

DM_Alchemy.OnSRefreshAlchemy = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  local alchemyInfo = protocol.alchemy
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._alchemy).level = alchemyInfo.buildLevel
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._alchemy).alchemyLevel = alchemyInfo.alchemyLevel
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._alchemy).alchemyStage = alchemyInfo.alchemyStage
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._alchemy).alchemyExp = alchemyInfo.alchemyExperience
  LogInfoFormat("DM_Alchemy", "----- level = %s, alchemyLevel = %s, alchemyStage = %s, alchemyExp = %s, roleKey = %s", alchemyInfo.buildLevel, alchemyInfo.alchemyLevel, alchemyInfo.alchemyStage, alchemyInfo.alchemyExperience, alchemyInfo.roleId)
  while ((self._alchemy).roles)[#(self._alchemy).roles] do
    (table.remove)((self._alchemy).roles, #(self._alchemy).roles)
  end
  if alchemyInfo.roleId ~= 0 then
    (table.insert)((self._alchemy).roles, alchemyInfo.roleId)
  end
  self:SetFormulas()
end

DM_Alchemy.SetFormulas = function(self)
  -- function num : 0_4 , upvalues : _ENV, CAlchemyFormulaCfg, Item
  for k,v in pairs((self._alchemy)._formulas) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ((self._alchemy)._formulas)[k] = nil
  end
  local formulas = (self._alchemy)._formulas
  local allIds = CAlchemyFormulaCfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CAlchemyFormulaCfg:GetRecorder(allIds[i])
    local type = recorder.type
    if not formulas[recorder.type] then
      formulas[recorder.type] = {}
    end
    local item = (Item.Create)(recorder.outcome)
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R10 in 'UnsetPending'

    if not (formulas[recorder.type])[recorder.unlockLv] then
      (formulas[recorder.type])[recorder.unlockLv] = {
list = {}
}
    end
    if recorder.unlockLv <= (self._alchemy).level then
      (table.insert)(((formulas[recorder.type])[recorder.unlockLv]).list, recorder)
    else
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R10 in 'UnsetPending'

      if not ((formulas[recorder.type])[recorder.unlockLv]).lock then
        ((formulas[recorder.type])[recorder.unlockLv]).lock = true
        -- DECOMPILER ERROR at PC79: Confused about usage of register: R10 in 'UnsetPending'

        ;
        ((formulas[recorder.type])[recorder.unlockLv]).unlockLv = recorder.unlockLv
      end
    end
  end
end

DM_Alchemy.OnSAlchemyRankLevelUp = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._alchemy).alchemyLevel = protocol.level
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._alchemy).alchemyStage = protocol.stage
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._alchemy).alchemyExp = protocol.exp
  LogInfoFormat("DM_Alchemy", "----- alchemyLevel = %s, alchemyStage = %s, alchemyExp = %s", protocol.level, protocol.stage, protocol.exp)
end

return DM_Alchemy

