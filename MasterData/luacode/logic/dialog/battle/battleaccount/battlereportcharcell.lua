local CStringres = BeanManager.GetTableByName("message.cstringres")
local BattleReportCharCell = class("BattleReportCharCell", Dialog)
BattleReportCharCell.AssetBundleName = "ui/layouts.battlewin"
BattleReportCharCell.AssetName = "BattleReportCharCell"

function BattleReportCharCell:Ctor(...)
  BattleReportCharCell.super.Ctor(self, ...)
end

function BattleReportCharCell:OnCreate()
  self._img = self:GetChild("Char/CharBack/Image")
  self._name = self:GetChild("Char/Name")
  self._levelNum = self:GetChild("Char/LevelNum")
  self._breakLevelNum = self:GetChild("Char/BreakLevelNum")
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

function BattleReportCharCell:OnDestroy()
end

function BattleReportCharCell:RefreshCell(data)
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
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(data.roleId)
  if role then
    self._levelNum:SetText(role:GetShowLv())
    self._breakLevelNum:SetText(role:GetBreakLv())
    if role:GetIsLeader() then
      local str = TextManager.GetText(CStringres:GetRecorder(1433).msgTextID)
      self._name:SetText(str)
    else
      self._name:SetText(role:GetRoleName())
    end
    local imageRecord = role:GetSkillHeadImageRecord()
    self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("BattleReportCharCell", "wrong role id %s", data.roleId)
  end
end

function BattleReportCharCell:OnCellClicked()
  if self._delegate._canCheckRoleDetail then
    local battler
    for k, v in pairs(NekoData.BehaviorManager.BM_Battle:GetLeftBattlers()) do
      if v:GetConfigId() == self._cellData.roleId then
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
      LogErrorFormat("BattleReportCharCell", "role id %s no battler", self._cellData.roleId)
    end
  end
end

return BattleReportCharCell
