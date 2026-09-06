local CAlchemyFormulaTypeCfg = BeanManager.GetTableByName("courtyard.calchemyformulatype")
local CAlchemyFormulaCfg = BeanManager.GetTableByName("courtyard.calchemyformula")
local Item = require("logic.manager.experimental.types.item")
local DM_Alchemy = class("DM_Alchemy")

function DM_Alchemy:Ctor()
  self._alchemy = NekoData.Data.alchemy
  self._alchemy.level = 0
  self._alchemy.alchemyLevel = 0
  self._alchemy.alchemyStage = 0
  self._alchemy.alchemyExp = 0
  self._alchemy.roles = {}
  self._alchemy._formulas = {}
end

function DM_Alchemy:Clear()
  self._alchemy.level = 0
  self._alchemy.alchemyLevel = 0
  self._alchemy.alchemyStage = 0
  self._alchemy.alchemyExp = 0
  while self._alchemy.roles[#self._alchemy.roles] do
    table.remove(self._alchemy.roles, #self._alchemy.roles)
  end
  for k, v in pairs(self._alchemy._formulas) do
    self._alchemy._formulas[k] = nil
  end
end

function DM_Alchemy:OnSYardInfo(protocol)
  local alchemyInfo = protocol.alchemy
  self._alchemy.level = alchemyInfo.buildLevel
  self._alchemy.alchemyLevel = alchemyInfo.alchemyLevel
  self._alchemy.alchemyStage = alchemyInfo.alchemyStage
  self._alchemy.alchemyExp = alchemyInfo.alchemyExperience
  while self._alchemy.roles[#self._alchemy.roles] do
    table.remove(self._alchemy.roles, #self._alchemy.roles)
  end
  if alchemyInfo.roleId ~= 0 then
    table.insert(self._alchemy.roles, alchemyInfo.roleId)
  end
  self:SetFormulas()
end

function DM_Alchemy:OnSRefreshAlchemy(protocol)
  local alchemyInfo = protocol.alchemy
  self._alchemy.level = alchemyInfo.buildLevel
  self._alchemy.alchemyLevel = alchemyInfo.alchemyLevel
  self._alchemy.alchemyStage = alchemyInfo.alchemyStage
  self._alchemy.alchemyExp = alchemyInfo.alchemyExperience
  LogInfoFormat("DM_Alchemy", "----- level = %s, alchemyLevel = %s, alchemyStage = %s, alchemyExp = %s, roleKey = %s", alchemyInfo.buildLevel, alchemyInfo.alchemyLevel, alchemyInfo.alchemyStage, alchemyInfo.alchemyExperience, alchemyInfo.roleId)
  while self._alchemy.roles[#self._alchemy.roles] do
    table.remove(self._alchemy.roles, #self._alchemy.roles)
  end
  if alchemyInfo.roleId ~= 0 then
    table.insert(self._alchemy.roles, alchemyInfo.roleId)
  end
  self:SetFormulas()
end

function DM_Alchemy:SetFormulas()
  for k, v in pairs(self._alchemy._formulas) do
    self._alchemy._formulas[k] = nil
  end
  local formulas = self._alchemy._formulas
  local allIds = CAlchemyFormulaCfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CAlchemyFormulaCfg:GetRecorder(allIds[i])
    local type = recorder.type
    if not formulas[recorder.type] then
      formulas[recorder.type] = {}
    end
    local item = Item.Create(recorder.outcome)
    if not formulas[recorder.type][recorder.unlockLv] then
      formulas[recorder.type][recorder.unlockLv] = {
        list = {}
      }
    end
    if recorder.unlockLv <= self._alchemy.level then
      table.insert(formulas[recorder.type][recorder.unlockLv].list, recorder)
    elseif not formulas[recorder.type][recorder.unlockLv].lock then
      formulas[recorder.type][recorder.unlockLv].lock = true
      formulas[recorder.type][recorder.unlockLv].unlockLv = recorder.unlockLv
    end
  end
end

function DM_Alchemy:OnSAlchemyRankLevelUp(protocol)
  self._alchemy.alchemyLevel = protocol.level
  self._alchemy.alchemyStage = protocol.stage
  self._alchemy.alchemyExp = protocol.exp
  LogInfoFormat("DM_Alchemy", "----- alchemyLevel = %s, alchemyStage = %s, alchemyExp = %s", protocol.level, protocol.stage, protocol.exp)
end

return DM_Alchemy
