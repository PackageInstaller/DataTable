-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_vocation.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CResourceDungeonStage = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")
local CVocationCfgTable = (BeanManager.GetTableByName)("role.cvocationcfg")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local BM_Vocation = class("BM_Vocation")
BM_Vocation.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._dm = (NekoData.DataManager).DM_Vocation
end

BM_Vocation.GetVocationIDs = function(self, sourceDungeonStageID)
  -- function num : 0_1 , upvalues : CResourceDungeonStage
  local tempRes = CResourceDungeonStage:GetRecorder(sourceDungeonStageID)
  if tempRes ~= nil then
    return (CResourceDungeonStage:GetRecorder(sourceDungeonStageID)).vocationID
  end
  return 
end

BM_Vocation.GetVocationIDTable = function(self, sourceDungeonStageID)
  -- function num : 0_2 , upvalues : _ENV
  local vocationIDs = self:GetVocationIDs(sourceDungeonStageID)
  if vocationIDs ~= nil and vocationIDs ~= "" then
    return (string.split)(vocationIDs, ";")
  end
  return 
end

BM_Vocation.GetOneSupportVocationTable = function(self, sourceDungeonStageID)
  -- function num : 0_3 , upvalues : _ENV, CVocationCfgTable
  local oneSupportVocationTable = (self._dm):GetOneSupportVocationTable(sourceDungeonStageID)
  if oneSupportVocationTable ~= nil then
    return oneSupportVocationTable
  else
    local textArray = self:GetVocationIDTable(sourceDungeonStageID)
    if textArray ~= nil then
      oneSupportVocationTable = {
vid = {}
, 
txt = {}
}
      for _,vid in ipairs(textArray) do
        local vidNum = tonumber(vid)
        ;
        (table.insert)(oneSupportVocationTable.vid, vidNum)
        ;
        (table.insert)(oneSupportVocationTable.txt, (TextManager.GetText)((CVocationCfgTable:GetRecorder(vidNum)).nameTextID))
      end
      ;
      (self._dm):SetOneSupportVocationTable(sourceDungeonStageID, oneSupportVocationTable)
      return oneSupportVocationTable
    end
  end
  do
    return 
  end
end

BM_Vocation.GetOneSupportVocationDescription = function(self, oneSupportVocationTable)
  -- function num : 0_4 , upvalues : _ENV, CStringRes
  if oneSupportVocationTable == nil then
    return ""
  else
    return (string.gsub)((TextManager.GetText)((CStringRes:GetRecorder(1360)).msgTextID), "%$parameter1%$", (table.concat)(oneSupportVocationTable.txt, (TextManager.GetText)((CStringRes:GetRecorder(1361)).msgTextID)))
  end
end

BM_Vocation.GetVocationIsSupport = function(self, role, oneSupportVocationTable)
  -- function num : 0_5 , upvalues : _ENV
  if oneSupportVocationTable == nil then
    return true
  end
  if (table.keyof)(oneSupportVocationTable.vid, role:GetVocationId()) ~= nil then
    return true
  end
  return false
end

return BM_Vocation

