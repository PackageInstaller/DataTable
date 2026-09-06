local CResourceDungeonStage = BeanManager.GetTableByName("dungeonselect.cresourcedungeonstage")
local CVocationCfgTable = BeanManager.GetTableByName("role.cvocationcfg")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local BM_Vocation = class("BM_Vocation")

function BM_Vocation:Ctor()
  self._dm = NekoData.DataManager.DM_Vocation
end

function BM_Vocation:GetVocationIDs(sourceDungeonStageID)
  local tempRes = CResourceDungeonStage:GetRecorder(sourceDungeonStageID)
  if tempRes ~= nil then
    return CResourceDungeonStage:GetRecorder(sourceDungeonStageID).vocationID
  end
  return
end

function BM_Vocation:GetVocationIDTable(sourceDungeonStageID)
  local vocationIDs = self:GetVocationIDs(sourceDungeonStageID)
  if vocationIDs ~= nil and vocationIDs ~= "" then
    return string.split(vocationIDs, ";")
  end
  return
end

function BM_Vocation:GetOneSupportVocationTable(sourceDungeonStageID)
  local oneSupportVocationTable = self._dm:GetOneSupportVocationTable(sourceDungeonStageID)
  if oneSupportVocationTable ~= nil then
    return oneSupportVocationTable
  else
    local textArray = self:GetVocationIDTable(sourceDungeonStageID)
    if textArray ~= nil then
      oneSupportVocationTable = {
        vid = {},
        txt = {}
      }
      for _, vid in ipairs(textArray) do
        local vidNum = tonumber(vid)
        table.insert(oneSupportVocationTable.vid, vidNum)
        table.insert(oneSupportVocationTable.txt, TextManager.GetText(CVocationCfgTable:GetRecorder(vidNum).nameTextID))
      end
      self._dm:SetOneSupportVocationTable(sourceDungeonStageID, oneSupportVocationTable)
      return oneSupportVocationTable
    end
  end
  return
end

function BM_Vocation:GetOneSupportVocationDescription(oneSupportVocationTable)
  if oneSupportVocationTable == nil then
    return ""
  else
    return string.gsub(TextManager.GetText(CStringRes:GetRecorder(1360).msgTextID), "%$parameter1%$", table.concat(oneSupportVocationTable.txt, TextManager.GetText(CStringRes:GetRecorder(1361).msgTextID)))
  end
end

function BM_Vocation:GetVocationIsSupport(role, oneSupportVocationTable)
  if oneSupportVocationTable == nil then
    return true
  end
  if table.keyof(oneSupportVocationTable.vid, role:GetVocationId()) ~= nil then
    return true
  end
  return false
end

return BM_Vocation
