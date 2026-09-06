local GridFrame = require("framework.ui.frame.grid.gridframe")
local CMonsterConfigTable = BeanManager.GetTableByName("npc.cmonsterconfig")
local CBattleInfoTable = BeanManager.GetTableByName("battle.cbattleinfo")
local CSkillShow_Common = BeanManager.GetTableByName("skill.cskillshow_common")
local CstringCfg = BeanManager.GetTableByName("message.cstringres")
local ArrangePVELeftDialog = class("ArrangePVELeftDialog", Dialog)
ArrangePVELeftDialog.AssetBundleName = "ui/layouts.battleeditor"
ArrangePVELeftDialog.AssetName = "ArrangePVE"

function ArrangePVELeftDialog:Ctor(...)
  ArrangePVELeftDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._selectedId = 0
  self._cells = {}
end

function ArrangePVELeftDialog:OnCreate(root)
  self._inputField = self:GetChild("MainFrame/Left/InputFieldBattleID")
  self._confirmBtn = self:GetChild("MainFrame/Left/ConfirmBtn")
  self._selfBtn = self:GetChild("SelfBtn")
  self._exit = self:GetChild("BackBtn")
  self._front1 = self:GetChild("MainFrame/Left/ArrangeFrameFront/Pos1")
  self._front2 = self:GetChild("MainFrame/Left/ArrangeFrameFront/Pos2")
  self._front3 = self:GetChild("MainFrame/Left/ArrangeFrameFront/Pos3")
  self._mid1 = self:GetChild("MainFrame/Left/ArrangeFrameMid/Pos1")
  self._mid2 = self:GetChild("MainFrame/Left/ArrangeFrameMid/Pos2")
  self._mid3 = self:GetChild("MainFrame/Left/ArrangeFrameMid/Pos3")
  self._back1 = self:GetChild("MainFrame/Left/ArrangeFrameBack/Pos1")
  self._back2 = self:GetChild("MainFrame/Left/ArrangeFrameBack/Pos2")
  self._back3 = self:GetChild("MainFrame/Left/ArrangeFrameBack/Pos3")
  self._rightName = self:GetChild("MainFrame/RightTop/Name")
  self._rightJobName = self:GetChild("MainFrame/RightTop/Job")
  self._rightLevel = self:GetChild("MainFrame/RightTop/Level")
  self._rightHP = self:GetChild("MainFrame/RightTop/HP")
  self._rightSpeed = self:GetChild("MainFrame/RightTop/SPD")
  self._rightADAtk = self:GetChild("MainFrame/RightTop/AD_Atk")
  self._rightADDef = self:GetChild("MainFrame/RightTop/AD_Def")
  self._rightAPAtk = self:GetChild("MainFrame/RightTop/AP_Atk")
  self._rightAPDef = self:GetChild("MainFrame/RightTop/AP_Def")
  self._rightSkillName = self:GetChild("MainFrame/RightTop/Skillname")
  self._rightSkillDescribe = self:GetChild("MainFrame/RightTop/Skilldescribe")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._selfBtn:Subscribe_PointerClickEvent(self.OnSelfClicked, self)
  self._exit:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._leftPos = {
    self._front1,
    self._front2,
    self._front3,
    self._mid1,
    self._mid2,
    self._mid3,
    self._back1,
    self._back2,
    self._back3
  }
  for i, posCell in ipairs(self._leftPos) do
    posCell:SetUserData(i)
    posCell:Subscribe_PointerClickEvent(self.OnLeftCellClicked, self)
  end
  self:ShowMonsterAttribute(0)
  self:LoadLocalData()
end

function ArrangePVELeftDialog:OnDestroy()
  for k, cell in pairs(self._cells) do
    cell:Destroy()
  end
  self._cells = {}
end

function ArrangePVELeftDialog:ShowMonsterAttribute(id)
  if id == 0 then
    self._rightName:SetText("")
    self._rightJobName:SetText("")
    self._rightLevel:SetText(0)
    self._rightHP:SetText(0)
    self._rightSpeed:SetText(0)
    self._rightADAtk:SetText(0)
    self._rightADDef:SetText(0)
    self._rightAPAtk:SetText(0)
    self._rightAPDef:SetText(0)
    self._rightSkillName:SetText("")
    self._rightSkillDescribe:SetText("")
  else
    local monsterConfigRecord = CMonsterConfigTable:GetRecorder(id)
    local skillShowRecord = CSkillShow_Common:GetRecorder(monsterConfigRecord.skillid[1])
    self._rightName:SetText(TextManager.GetText(monsterConfigRecord.nameTextID))
    local str = TextManager.GetText(CstringCfg.GetRecorder(1048).msgTextID)
    self._rightJobName:SetText(str)
    self._rightLevel:SetText(90)
    self._rightHP:SetText(monsterConfigRecord.hpConstant)
    self._rightSpeed:SetText(monsterConfigRecord.speedConstant)
    self._rightADAtk:SetText(monsterConfigRecord.attackConstant)
    self._rightADDef:SetText(monsterConfigRecord.defConstant)
    self._rightAPAtk:SetText(monsterConfigRecord.magicattConstant)
    self._rightAPDef:SetText(monsterConfigRecord.magicDefConstant)
    if skillShowRecord then
      self._rightSkillName:SetText(TextManager.GetText(skillShowRecord.nameTextID))
      self._rightSkillDescribe:SetText(TextManager.GetText(skillShowRecord.exDiscribeTextID))
    else
      self._rightSkillName:SetText("")
      self._rightSkillDescribe:SetText("")
    end
  end
end

function ArrangePVELeftDialog:SetBattleId(battleId)
  self._selectedId = 0
  for k, cell in pairs(self._cells) do
    cell:Destroy()
  end
  self._cells = {}
  self:ShowMonsterAttribute(0)
  local battleRecord = CBattleInfoTable:GetRecorder(battleId)
  if battleRecord then
    for i, v in ipairs(battleRecord.enemyPositions) do
      if v ~= "0" then
        local monster = string.split(v, "@")
        local cell = DialogManager.CreateDialog("battleeditor.pve.arrangeleftmonstercell", self._leftPos[i]._uiObject)
        cell._delegate = self
        cell:SetMonsterId(tonumber(monster[1]))
        self._cells[i] = cell
      end
    end
    NekoData.DataManager.DM_BattleEditor:SetPVEBattleId(battleId)
  end
end

function ArrangePVELeftDialog:LoadLocalData()
  local battleId = NekoData.BehaviorManager.BM_BattleEditor:GetPVEBattleId()
  self:SetBattleId(battleId)
end

function ArrangePVELeftDialog:OnLeftCellSelected(posId)
  if self._cells[posId] then
    self:ShowMonsterAttribute(self._cells[posId]._id)
  end
  for k, v in pairs(self._cells) do
    v:Selected(k == posId)
  end
end

function ArrangePVELeftDialog:OnConfirmBtnClicked()
  local battleId = tonumber(self._inputField:GetText())
  self:SetBattleId(battleId)
end

function ArrangePVELeftDialog:OnSelfClicked()
  DialogManager.DestroySingletonDialog("battleeditor.pve.arrangepveleftdialog")
  DialogManager.CreateSingletonDialog("battleeditor.pve.arrangerightdialog")
end

function ArrangePVELeftDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("battleeditor.pve.arrangepveleftdialog")
end

function ArrangePVELeftDialog:OnLeftCellClicked(arg, selfLuaWindow)
  local posIndex = selfLuaWindow:GetUserData()
  self:OnLeftCellSelected(posIndex)
end

return ArrangePVELeftDialog
