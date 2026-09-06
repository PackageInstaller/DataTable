local DM_Vocation = class("DM_Vocation")

function DM_Vocation:Ctor()
  self._supportVocationTable = {}
end

function DM_Vocation:Clear()
  self._supportVocationTable = {}
end

function DM_Vocation:GetOneSupportVocationTable(SourceDungeonStageID)
  return self._supportVocationTable[SourceDungeonStageID]
end

function DM_Vocation:SetOneSupportVocationTable(SourceDungeonStageID, oneSupportVocationTable)
  self._supportVocationTable[SourceDungeonStageID] = oneSupportVocationTable
end

return DM_Vocation
