-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossrushweekcultivateskillcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local BossRushWeekCultivateSkillCell = class("BossRushWeekCultivateSkillCell", Dialog)
BossRushWeekCultivateSkillCell.AssetBundleName = "ui/layouts.mainline"
BossRushWeekCultivateSkillCell.AssetName = "BossRushWeekSkillCell"
local OneLineSkillCellCount = 3
BossRushWeekCultivateSkillCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossRushWeekCultivateSkillCell
  ((BossRushWeekCultivateSkillCell.super).Ctor)(self, ...)
  self._nodeColumnMap = {}
end

BossRushWeekCultivateSkillCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : OneLineSkillCellCount
  self._indexBack_Normal = self:GetChild("NumBack")
  self._indexBack_AllUnlock = self:GetChild("NumBackSelect")
  self._indexTxt_Normal = self:GetChild("Num")
  self._indexTxt_AllUnlock = self:GetChild("NumSelect")
  self._posChilds = {}
  for i = 1, OneLineSkillCellCount do
    do
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

      (self._posChilds)[i] = {}
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._posChilds)[i]).panel = self:GetChild("Position" .. i)
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._posChilds)[i]).panel_redDot = self:GetChild("Position" .. i .. "/RedDot")
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._posChilds)[i]).skillPanels = {}
      -- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (((self._posChilds)[i]).skillPanels).skillPanel = self:GetChild("Position" .. i .. "/PropSkill")
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (((self._posChilds)[i]).skillPanels).select = self:GetChild("Position" .. i .. "/PropSkill/Select")
      -- DECOMPILER ERROR at PC75: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (((self._posChilds)[i]).skillPanels).icon = self:GetChild("Position" .. i .. "/PropSkill/Skill")
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (((self._posChilds)[i]).skillPanels).skillElement = self:GetChild("Position" .. i .. "/PropSkill/Skill/Element")
      -- DECOMPILER ERROR at PC95: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (((self._posChilds)[i]).skillPanels).grey = self:GetChild("Position" .. i .. "/PropSkill/Grey")
      ;
      (((self._posChilds)[i]).panel):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnSkillNodeClick(i)
  end
)
    end
  end
end

BossRushWeekCultivateSkillCell.OnDestroy = function(self)
  -- function num : 0_2
end

BossRushWeekCultivateSkillCell.Init = function(self, delegate, index, data)
  -- function num : 0_3 , upvalues : OneLineSkillCellCount
  self._delegate = delegate
  self._index = index
  if data then
    for i = 1, OneLineSkillCellCount do
      (((self._posChilds)[i]).panel):SetActive(data[i])
    end
  else
    do
      for i = 1, OneLineSkillCellCount do
        (((self._posChilds)[i]).panel):SetActive(false)
      end
      do
        ;
        (self._indexTxt_Normal):SetText(index)
        ;
        (self._indexTxt_AllUnlock):SetText(index)
      end
    end
  end
end

BossRushWeekCultivateSkillCell.Refresh = function(self, nodeRecord)
  -- function num : 0_4 , upvalues : _ENV, CImagePathTable
  local posList = (string.split)(nodeRecord.nodePosition, ";")
  local column = tonumber(posList[2])
  local nodeChild = (self._posChilds)[column]
  local map = nodeChild.skillPanels
  if not CImagePathTable:GetRecorder(nodeRecord.buffIconID) then
    local imgRecord = DataCommon.DefaultImageAsset
  end
  ;
  (map.icon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  if nodeRecord.littleIconID == -1 then
    (map.skillElement):SetActive(false)
  else
    ;
    (map.skillElement):SetActive(true)
    if not CImagePathTable:GetRecorder(nodeRecord.littleIconID) then
      imgRecord = DataCommon.DefaultImageAsset
    end
    ;
    (map.skillElement):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  end
  ;
  (map.select):SetActive(nodeRecord.id == (self._delegate)._selectNodeId)
  ;
  (map.grey):SetActive(not ((self._delegate)._unlockSkillNodes)[nodeRecord.id])
  ;
  (nodeChild.panel_redDot):SetActive(((NekoData.BehaviorManager).BM_WeekBoss):GetNodeStatus(nodeRecord.id) == (((NekoData.BehaviorManager).BM_WeekBoss).NodeStatusType).CanBeUnlock)
  -- DECOMPILER ERROR at PC92: Confused about usage of register: R7 in 'UnsetPending'

  if not (self._nodeColumnMap)[column] then
    (self._nodeColumnMap)[column] = {nodeRecord = nodeRecord}
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

BossRushWeekCultivateSkillCell.AllSkillNodesRefreshFinished = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local showAllUnlock = false
  for k,v in pairs(self._nodeColumnMap) do
    if ((self._delegate)._unlockSkillNodes)[(v.nodeRecord).id] then
      showAllUnlock = true
      break
    end
  end
  do
    ;
    (self._indexBack_Normal):SetActive(not showAllUnlock)
    ;
    (self._indexTxt_Normal):SetActive(not showAllUnlock)
    ;
    (self._indexBack_AllUnlock):SetActive(showAllUnlock)
    ;
    (self._indexTxt_AllUnlock):SetActive(showAllUnlock)
  end
end

BossRushWeekCultivateSkillCell.OnSkillNodeClick = function(self, skillNodeIndex)
  -- function num : 0_6
  (self._delegate):SelectSkillNode((((self._nodeColumnMap)[skillNodeIndex]).nodeRecord).id)
end

BossRushWeekCultivateSkillCell.OnEvent = function(self, eventName)
  -- function num : 0_7 , upvalues : _ENV
  if eventName == "SetSelected" then
    for k,v in pairs(self._nodeColumnMap) do
      local nodeChild = (self._posChilds)[k]
      local nodeRecord = v.nodeRecord
      ;
      ((nodeChild.skillPanels).select):SetActive(nodeRecord.id == (self._delegate)._selectNodeId)
    end
  elseif eventName == "RefreshRedDot" then
    for k,v in pairs(self._nodeColumnMap) do
      local nodeChild = (self._posChilds)[k]
      local nodeRecord = v.nodeRecord
      ;
      (nodeChild.panel_redDot):SetActive(((NekoData.BehaviorManager).BM_WeekBoss):GetNodeStatus(nodeRecord.id) == (((NekoData.BehaviorManager).BM_WeekBoss).NodeStatusType).CanBeUnlock)
    end
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

return BossRushWeekCultivateSkillCell

