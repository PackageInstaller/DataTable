local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local BossRushWeekCultivateRightSkillCellDialog = class("BossRushWeekCultivateRightSkillCellDialog", Dialog)
BossRushWeekCultivateRightSkillCellDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
BossRushWeekCultivateRightSkillCellDialog.AssetName = "SkillCell"

function BossRushWeekCultivateRightSkillCellDialog:Ctor(...)
  BossRushWeekCultivateRightSkillCellDialog.super.Ctor(self, ...)
end

function BossRushWeekCultivateRightSkillCellDialog:OnCreate()
  self._normalFrame = self:GetChild("BackNormal")
  self._lvMaxFrame = self:GetChild("BackFull")
  self._lvMaxFrame:SetActive(false)
  self._icon = self:GetChild("Skill")
  self._skillElement = self:GetChild("Skill/Element")
  self._skillElement:SetActive(true)
  self._lvPanel = self:GetChild("NumBack")
  self._lvPanel:SetActive(false)
  self._lock = self:GetChild("Lock")
  self._chargingPanel = self:GetChild("Energy")
  self._chargingPanel:SetActive(false)
  self._select = self:GetChild("Select")
  self._grey = self:GetChild("Grey")
end

function BossRushWeekCultivateRightSkillCellDialog:OnDestroy()
end

function BossRushWeekCultivateRightSkillCellDialog:SetData(nodeId, record)
  local imgRecord = CImagePathTable:GetRecorder(record.buffIconID) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  if record.littleIconID == -1 then
    self._skillElement:SetActive(false)
  else
    self._skillElement:SetActive(true)
    imgRecord = CImagePathTable:GetRecorder(record.littleIconID) or DataCommon.DefaultImageAsset
    self._skillElement:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  end
  local locked = NekoData.BehaviorManager.BM_WeekBoss:GetNodeStatus(nodeId) & NekoData.BehaviorManager.BM_WeekBoss.NodeStatusType.HasBeenUnlocked == 0
  self._lock:SetActive(locked)
  self._grey:SetActive(locked)
end

return BossRushWeekCultivateRightSkillCellDialog
