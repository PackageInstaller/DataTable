local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local BossRushWeekCultivateSkillCell = class("BossRushWeekCultivateSkillCell", Dialog)
BossRushWeekCultivateSkillCell.AssetBundleName = "ui/layouts.mainline"
BossRushWeekCultivateSkillCell.AssetName = "BossRushWeekSkillCell"
local OneLineSkillCellCount = 3

function BossRushWeekCultivateSkillCell:Ctor(...)
  BossRushWeekCultivateSkillCell.super.Ctor(self, ...)
  self._nodeColumnMap = {}
end

function BossRushWeekCultivateSkillCell:OnCreate()
  self._indexBack_Normal = self:GetChild("NumBack")
  self._indexBack_AllUnlock = self:GetChild("NumBackSelect")
  self._indexTxt_Normal = self:GetChild("Num")
  self._indexTxt_AllUnlock = self:GetChild("NumSelect")
  self._posChilds = {}
  for i = 1, OneLineSkillCellCount do
    self._posChilds[i] = {}
    self._posChilds[i].panel = self:GetChild("Position" .. i)
    self._posChilds[i].panel_redDot = self:GetChild("Position" .. i .. "/RedDot")
    self._posChilds[i].skillPanels = {}
    self._posChilds[i].skillPanels.skillPanel = self:GetChild("Position" .. i .. "/PropSkill")
    self._posChilds[i].skillPanels.select = self:GetChild("Position" .. i .. "/PropSkill/Select")
    self._posChilds[i].skillPanels.icon = self:GetChild("Position" .. i .. "/PropSkill/Skill")
    self._posChilds[i].skillPanels.skillElement = self:GetChild("Position" .. i .. "/PropSkill/Skill/Element")
    self._posChilds[i].skillPanels.grey = self:GetChild("Position" .. i .. "/PropSkill/Grey")
    self._posChilds[i].panel:Subscribe_PointerClickEvent(function()
      self:OnSkillNodeClick(i)
    end)
  end
end

function BossRushWeekCultivateSkillCell:OnDestroy()
end

function BossRushWeekCultivateSkillCell:Init(delegate, index, data)
  self._delegate = delegate
  self._index = index
  if data then
    for i = 1, OneLineSkillCellCount do
      self._posChilds[i].panel:SetActive(data[i])
    end
  else
    for i = 1, OneLineSkillCellCount do
      self._posChilds[i].panel:SetActive(false)
    end
  end
  self._indexTxt_Normal:SetText(index)
  self._indexTxt_AllUnlock:SetText(index)
end

function BossRushWeekCultivateSkillCell:Refresh(nodeRecord)
  local posList = string.split(nodeRecord.nodePosition, ";")
  local column = tonumber(posList[2])
  local nodeChild = self._posChilds[column]
  local map = nodeChild.skillPanels
  local imgRecord = CImagePathTable:GetRecorder(nodeRecord.buffIconID) or DataCommon.DefaultImageAsset
  map.icon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  if nodeRecord.littleIconID == -1 then
    map.skillElement:SetActive(false)
  else
    map.skillElement:SetActive(true)
    imgRecord = CImagePathTable:GetRecorder(nodeRecord.littleIconID) or DataCommon.DefaultImageAsset
    map.skillElement:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  end
  map.select:SetActive(nodeRecord.id == self._delegate._selectNodeId)
  map.grey:SetActive(not self._delegate._unlockSkillNodes[nodeRecord.id])
  nodeChild.panel_redDot:SetActive(NekoData.BehaviorManager.BM_WeekBoss:GetNodeStatus(nodeRecord.id) == NekoData.BehaviorManager.BM_WeekBoss.NodeStatusType.CanBeUnlock)
  if not self._nodeColumnMap[column] then
    self._nodeColumnMap[column] = {nodeRecord = nodeRecord}
  end
end

function BossRushWeekCultivateSkillCell:AllSkillNodesRefreshFinished()
  local showAllUnlock = false
  for k, v in pairs(self._nodeColumnMap) do
    if self._delegate._unlockSkillNodes[v.nodeRecord.id] then
      showAllUnlock = true
      break
    end
  end
  self._indexBack_Normal:SetActive(not showAllUnlock)
  self._indexTxt_Normal:SetActive(not showAllUnlock)
  self._indexBack_AllUnlock:SetActive(showAllUnlock)
  self._indexTxt_AllUnlock:SetActive(showAllUnlock)
end

function BossRushWeekCultivateSkillCell:OnSkillNodeClick(skillNodeIndex)
  self._delegate:SelectSkillNode(self._nodeColumnMap[skillNodeIndex].nodeRecord.id)
end

function BossRushWeekCultivateSkillCell:OnEvent(eventName)
  if eventName == "SetSelected" then
    for k, v in pairs(self._nodeColumnMap) do
      local nodeChild = self._posChilds[k]
      local nodeRecord = v.nodeRecord
      nodeChild.skillPanels.select:SetActive(nodeRecord.id == self._delegate._selectNodeId)
    end
  elseif eventName == "RefreshRedDot" then
    for k, v in pairs(self._nodeColumnMap) do
      local nodeChild = self._posChilds[k]
      local nodeRecord = v.nodeRecord
      nodeChild.panel_redDot:SetActive(NekoData.BehaviorManager.BM_WeekBoss:GetNodeStatus(nodeRecord.id) == NekoData.BehaviorManager.BM_WeekBoss.NodeStatusType.CanBeUnlock)
    end
  end
end

return BossRushWeekCultivateSkillCell
