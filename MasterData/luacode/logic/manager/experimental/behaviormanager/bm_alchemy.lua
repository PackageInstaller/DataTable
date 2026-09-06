local CAlchemyLvCfg = BeanManager.GetTableByName("courtyard.calchemylv")
local CAlchemyStageCfg = BeanManager.GetTableByName("courtyard.calchemystage")
local BM_Alchemy = class("BM_Alchemy")

function BM_Alchemy:Ctor()
  self._alchemy = NekoData.Data.alchemy
end

function BM_Alchemy:GetLevel()
  return self._alchemy.level
end

function BM_Alchemy:GetAlchemyLevel()
  return self._alchemy.alchemyLevel
end

function BM_Alchemy:GetMaxAlchemyLevel()
  return #CAlchemyLvCfg:GetAllIds()
end

function BM_Alchemy:GetAlchemyExp()
  return self._alchemy.alchemyExp
end

function BM_Alchemy:GetDispatchRoles()
  local list = {}
  for i, roleKey in ipairs(self._alchemy.roles) do
    table.insert(list, roleKey)
  end
  return list
end

function BM_Alchemy:GetDispatchMaxRoleNum()
  return 1
end

function BM_Alchemy:GetFormulas()
  return self._alchemy._formulas
end

function BM_Alchemy:GetUnlockAlchemyLvByStage(stage)
  local allIds = CAlchemyLvCfg:GetAllIds()
  local length = #allIds
  for i = 1, length do
    local recorder = CAlchemyLvCfg:GetRecorder(allIds[i])
    if recorder.alchemystage == stage then
      return recorder.id
    end
  end
end

function BM_Alchemy:GetAlchemyStage()
  return self._alchemy.alchemyStage
end

function BM_Alchemy:GetMaxAlchemyStage()
  local allIds = CAlchemyStageCfg:GetAllIds()
  return CAlchemyStageCfg:GetRecorder(allIds[#allIds]).id - 1
end

return BM_Alchemy
