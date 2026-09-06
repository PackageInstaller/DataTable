local CMonsterConfig = BeanManager.GetTableByName("npc.cmonsterconfig")
local RoleConfig = BeanManager.GetTableByName("role.roleconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local BattleReportBossCell = class("BattleReportBossCell", Dialog)
BattleReportBossCell.AssetBundleName = "ui/layouts.battlewin"
BattleReportBossCell.AssetName = "BattleReportBossCell"
local ImgIdType = {Monster = 12233, Boss = 12232}

function BattleReportBossCell:Ctor(...)
  BattleReportBossCell.super.Ctor(self, ...)
end

function BattleReportBossCell:OnCreate()
  self._name = self:GetChild("Char/Name")
  self._name2 = self:GetChild("Char/Name2")
  self._name2:SetActive(false)
  self._img = self:GetChild("Char/CharBack/Image")
  self._levelNum = self:GetChild("Char/LevelNum")
  self._damageProgress = self:GetChild("Char/Damage/Progress/BackGround/Progress")
  self._injuryProgress = self:GetChild("Char/Def/Progress/BackGround/Progress")
  self._treatProgress = self:GetChild("Char/Heal/Progress/BackGround/Progress")
  self._damagePercentNum = self:GetChild("Char/Damage/Percent")
  self._injuryPercentNum = self:GetChild("Char/Def/Percent")
  self._treatPercentNum = self:GetChild("Char/Heal/Percent")
  self._damageNum = self:GetChild("Char/Damage/Num")
  self._injuryNum = self:GetChild("Char/Def/Num")
  self._treatNum = self:GetChild("Char/Heal/Num")
  self._maxPercent = self:GetChild("Char/Damage/PercentYellow")
  self._maxNum = self:GetChild("Char/Damage/NumYellow")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function BattleReportBossCell:OnDestroy()
end

function BattleReportBossCell:RefreshCell(data)
  self._injuryPercentNum:SetText(data.injuryPercent .. "%")
  self._injuryProgress:SetFillAmount(data.injuryPercent / 100)
  self._treatPercentNum:SetText(data.treatPercent .. "%")
  self._treatProgress:SetFillAmount(data.treatPercent / 100)
  local damagenum = data.damage
  if damagenum < 0 then
    damagenum = -damagenum
  end
  local injurynum = data.injury
  if injurynum < 0 then
    injurynum = -injurynum
  end
  local treatnum = data.treat
  if treatnum < 0 then
    treatnum = -treatnum
  end
  self._damageProgress:SetFillAmount(data.damagePercent / 100)
  if data.isMax then
    self._maxPercent:SetText(data.damagePercent .. "%")
    self._maxNum:SetText(NumberManager.GetShowNumber(damagenum))
    self._damagePercentNum:SetActive(false)
    self._damageNum:SetActive(false)
    self._maxPercent:SetActive(true)
    self._maxNum:SetActive(true)
  else
    self._damagePercentNum:SetText(data.damagePercent .. "%")
    self._damageNum:SetText(NumberManager.GetShowNumber(damagenum))
    self._damagePercentNum:SetActive(true)
    self._damageNum:SetActive(true)
    self._maxPercent:SetActive(false)
    self._maxNum:SetActive(false)
  end
  self._injuryNum:SetText(NumberManager.GetShowNumber(injurynum))
  self._treatNum:SetText(NumberManager.GetShowNumber(treatnum))
  self._levelNum:SetText(data.level)
  if data.nameTextId and 0 < data.nameTextId then
    self._name:SetText(tostring(TextManager.GetText(data.nameTextId)))
  else
    local recorder = RoleConfig:GetRecorder(data.roleId)
    recorder = recorder or CMonsterConfig:GetRecorder(data.roleId)
    if recorder then
      self._name:SetText(tostring(TextManager.GetText(recorder.nameTextID)))
    else
      LogErrorFormat("BattleReportBossCell", "no role id %s in cmonsterconfig or roleconfig", data.roleId)
    end
  end
  local recorder = CMonsterConfig:GetRecorder(data.roleId)
  if recorder then
    local imageId = ImgIdType.Monster
    if recorder.bossOrNot == 1 then
      imageId = ImgIdType.Boss
    end
    local imageRecord = CImagePathTable:GetRecorder(imageId) or DataCommon.DefaultImageAsset
    self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

function BattleReportBossCell:OnCellClicked()
  if self._delegate._canCheckRoleDetail then
    local battler
    for k, v in pairs(NekoData.BehaviorManager.BM_Battle:GetRightBattlers()) do
      if v:GetEntityId() == self._cellData.entityId then
        battler = v
        break
      end
    end
    if battler then
      local dialog = DialogManager.GetDialog("newbattle.battleroledetaildialog")
      if dialog then
        dialog:SetData(battler)
      else
        DialogManager.CreateSingletonDialog("newbattle.battleroledetaildialog"):SetData(battler)
      end
    else
      LogErrorFormat("BattleReportBossCell", "monster id %s no battler", self._cellData.roleId)
    end
  end
end

return BattleReportBossCell
