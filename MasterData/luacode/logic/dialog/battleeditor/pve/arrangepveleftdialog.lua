-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battleeditor/pve/arrangepveleftdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local CBattleInfoTable = (BeanManager.GetTableByName)("battle.cbattleinfo")
local CSkillShow_Common = (BeanManager.GetTableByName)("skill.cskillshow_common")
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local ArrangePVELeftDialog = class("ArrangePVELeftDialog", Dialog)
ArrangePVELeftDialog.AssetBundleName = "ui/layouts.battleeditor"
ArrangePVELeftDialog.AssetName = "ArrangePVE"
ArrangePVELeftDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ArrangePVELeftDialog
  ((ArrangePVELeftDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._selectedId = 0
  self._cells = {}
end

ArrangePVELeftDialog.OnCreate = function(self, root)
  -- function num : 0_1 , upvalues : _ENV
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
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._selfBtn):Subscribe_PointerClickEvent(self.OnSelfClicked, self)
  ;
  (self._exit):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._leftPos = {self._front1, self._front2, self._front3, self._mid1, self._mid2, self._mid3, self._back1, self._back2, self._back3}
  for i,posCell in ipairs(self._leftPos) do
    posCell:SetUserData(i)
    posCell:Subscribe_PointerClickEvent(self.OnLeftCellClicked, self)
  end
  self:ShowMonsterAttribute(0)
  self:LoadLocalData()
end

ArrangePVELeftDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for k,cell in pairs(self._cells) do
    cell:Destroy()
  end
  self._cells = {}
end

ArrangePVELeftDialog.ShowMonsterAttribute = function(self, id)
  -- function num : 0_3 , upvalues : CMonsterConfigTable, CSkillShow_Common, _ENV, CstringCfg
  if id == 0 then
    (self._rightName):SetText("")
    ;
    (self._rightJobName):SetText("")
    ;
    (self._rightLevel):SetText(0)
    ;
    (self._rightHP):SetText(0)
    ;
    (self._rightSpeed):SetText(0)
    ;
    (self._rightADAtk):SetText(0)
    ;
    (self._rightADDef):SetText(0)
    ;
    (self._rightAPAtk):SetText(0)
    ;
    (self._rightAPDef):SetText(0)
    ;
    (self._rightSkillName):SetText("")
    ;
    (self._rightSkillDescribe):SetText("")
  else
    local monsterConfigRecord = CMonsterConfigTable:GetRecorder(id)
    local skillShowRecord = CSkillShow_Common:GetRecorder((monsterConfigRecord.skillid)[1])
    ;
    (self._rightName):SetText((TextManager.GetText)(monsterConfigRecord.nameTextID))
    local str = (TextManager.GetText)(((CstringCfg.GetRecorder)(1048)).msgTextID)
    ;
    (self._rightJobName):SetText(str)
    ;
    (self._rightLevel):SetText(90)
    ;
    (self._rightHP):SetText(monsterConfigRecord.hpConstant)
    ;
    (self._rightSpeed):SetText(monsterConfigRecord.speedConstant)
    ;
    (self._rightADAtk):SetText(monsterConfigRecord.attackConstant)
    ;
    (self._rightADDef):SetText(monsterConfigRecord.defConstant)
    ;
    (self._rightAPAtk):SetText(monsterConfigRecord.magicattConstant)
    ;
    (self._rightAPDef):SetText(monsterConfigRecord.magicDefConstant)
    if skillShowRecord then
      (self._rightSkillName):SetText((TextManager.GetText)(skillShowRecord.nameTextID))
      ;
      (self._rightSkillDescribe):SetText((TextManager.GetText)(skillShowRecord.exDiscribeTextID))
    else
      ;
      (self._rightSkillName):SetText("")
      ;
      (self._rightSkillDescribe):SetText("")
    end
  end
end

ArrangePVELeftDialog.SetBattleId = function(self, battleId)
  -- function num : 0_4 , upvalues : _ENV, CBattleInfoTable
  self._selectedId = 0
  for k,cell in pairs(self._cells) do
    cell:Destroy()
  end
  self._cells = {}
  self:ShowMonsterAttribute(0)
  local battleRecord = CBattleInfoTable:GetRecorder(battleId)
  if battleRecord then
    for i,v in ipairs(battleRecord.enemyPositions) do
      if v ~= "0" then
        local monster = (string.split)(v, "@")
        local cell = (DialogManager.CreateDialog)("battleeditor.pve.arrangeleftmonstercell", ((self._leftPos)[i])._uiObject)
        cell._delegate = self
        cell:SetMonsterId(tonumber(monster[1]))
        -- DECOMPILER ERROR at PC45: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self._cells)[i] = cell
      end
    end
    ;
    ((NekoData.DataManager).DM_BattleEditor):SetPVEBattleId(battleId)
  end
end

ArrangePVELeftDialog.LoadLocalData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local battleId = ((NekoData.BehaviorManager).BM_BattleEditor):GetPVEBattleId()
  self:SetBattleId(battleId)
end

ArrangePVELeftDialog.OnLeftCellSelected = function(self, posId)
  -- function num : 0_6 , upvalues : _ENV
  if (self._cells)[posId] then
    self:ShowMonsterAttribute(((self._cells)[posId])._id)
  end
  for k,v in pairs(self._cells) do
    v:Selected(k == posId)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ArrangePVELeftDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local battleId = tonumber((self._inputField):GetText())
  self:SetBattleId(battleId)
end

ArrangePVELeftDialog.OnSelfClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("battleeditor.pve.arrangepveleftdialog")
  ;
  (DialogManager.CreateSingletonDialog)("battleeditor.pve.arrangerightdialog")
end

ArrangePVELeftDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("battleeditor.pve.arrangepveleftdialog")
end

ArrangePVELeftDialog.OnLeftCellClicked = function(self, arg, selfLuaWindow)
  -- function num : 0_10
  local posIndex = selfLuaWindow:GetUserData()
  self:OnLeftCellSelected(posIndex)
end

return ArrangePVELeftDialog

