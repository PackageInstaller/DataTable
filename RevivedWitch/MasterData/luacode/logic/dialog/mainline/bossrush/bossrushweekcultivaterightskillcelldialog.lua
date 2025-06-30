-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossrushweekcultivaterightskillcelldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local BossRushWeekCultivateRightSkillCellDialog = class("BossRushWeekCultivateRightSkillCellDialog", Dialog)
BossRushWeekCultivateRightSkillCellDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
BossRushWeekCultivateRightSkillCellDialog.AssetName = "SkillCell"
BossRushWeekCultivateRightSkillCellDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossRushWeekCultivateRightSkillCellDialog
  ((BossRushWeekCultivateRightSkillCellDialog.super).Ctor)(self, ...)
end

BossRushWeekCultivateRightSkillCellDialog.OnCreate = function(self)
  -- function num : 0_1
  self._normalFrame = self:GetChild("BackNormal")
  self._lvMaxFrame = self:GetChild("BackFull")
  ;
  (self._lvMaxFrame):SetActive(false)
  self._icon = self:GetChild("Skill")
  self._skillElement = self:GetChild("Skill/Element")
  ;
  (self._skillElement):SetActive(true)
  self._lvPanel = self:GetChild("NumBack")
  ;
  (self._lvPanel):SetActive(false)
  self._lock = self:GetChild("Lock")
  self._chargingPanel = self:GetChild("Energy")
  ;
  (self._chargingPanel):SetActive(false)
  self._select = self:GetChild("Select")
  self._grey = self:GetChild("Grey")
end

BossRushWeekCultivateRightSkillCellDialog.OnDestroy = function(self)
  -- function num : 0_2
end

BossRushWeekCultivateRightSkillCellDialog.SetData = function(self, nodeId, record)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder(record.buffIconID) then
    local imgRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  if record.littleIconID == -1 then
    (self._skillElement):SetActive(false)
  else
    ;
    (self._skillElement):SetActive(true)
    if not CImagePathTable:GetRecorder(record.littleIconID) then
      imgRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._skillElement):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  end
  local locked = ((NekoData.BehaviorManager).BM_WeekBoss):GetNodeStatus(nodeId) & (((NekoData.BehaviorManager).BM_WeekBoss).NodeStatusType).HasBeenUnlocked == 0
  ;
  (self._lock):SetActive(locked)
  ;
  (self._grey):SetActive(locked)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return BossRushWeekCultivateRightSkillCellDialog

