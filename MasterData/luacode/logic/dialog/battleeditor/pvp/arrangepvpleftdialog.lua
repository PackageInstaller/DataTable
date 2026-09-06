local UIManager = CS.PixelNeko.UI.UIManager
local GridFrame = require("framework.ui.frame.grid.gridframe")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CSkillShow_Role = BeanManager.GetTableByName("skill.cskillshow_role")
local ArrangePVPLeftDialog = class("ArrangePVPLeftDialog", Dialog)
ArrangePVPLeftDialog.AssetBundleName = "ui/layouts.battleeditor"
ArrangePVPLeftDialog.AssetName = "ArrangePVP"

function ArrangePVPLeftDialog:Ctor(...)
  ArrangePVPLeftDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._selectedId = 0
  self._dragCell = nil
  self._cells = {}
end

function ArrangePVPLeftDialog:OnCreate(root)
  self._clearBtn = self:GetChild("MainFrame/Enemy/ClearBtn")
  self._selfBtn = self:GetChild("SelfBtn")
  self._exit = self:GetChild("BackBtn")
  self._front1 = self:GetChild("MainFrame/Enemy/ArrangeFrameFront/Pos1")
  self._front2 = self:GetChild("MainFrame/Enemy/ArrangeFrameFront/Pos2")
  self._front3 = self:GetChild("MainFrame/Enemy/ArrangeFrameFront/Pos3")
  self._mid1 = self:GetChild("MainFrame/Enemy/ArrangeFrameMid/Pos1")
  self._mid2 = self:GetChild("MainFrame/Enemy/ArrangeFrameMid/Pos2")
  self._mid3 = self:GetChild("MainFrame/Enemy/ArrangeFrameMid/Pos3")
  self._back1 = self:GetChild("MainFrame/Enemy/ArrangeFrameBack/Pos1")
  self._back2 = self:GetChild("MainFrame/Enemy/ArrangeFrameBack/Pos2")
  self._back3 = self:GetChild("MainFrame/Enemy/ArrangeFrameBack/Pos3")
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
  self._selectFrame = self:GetChild("MainFrame/RightBottom/SelectFrame")
  self._clearBtn:Subscribe_PointerClickEvent(self.OnClearClicked, self)
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
    posCell:Subscribe_DropEvent(self.OnLeftCellDrop, self)
    posCell:Subscribe_PointerClickEvent(self.OnLeftCellClicked, self)
  end
  self._frame = GridFrame.Create(self._selectFrame, self, true, 5)
  self._frame:ReloadAllCell()
  self:ShowAttribute(0)
  self:LoadLocalData()
end

function ArrangePVPLeftDialog:OnDestroy()
  self._frame:Destroy()
  for k, cell in pairs(self._cells) do
    cell:Destroy()
    cell:RootWindowDestroy()
  end
  self._cells = {}
  if self._dragCell then
    self._dragCell:Destroy()
    self._dragCell:RootWindowDestroy()
    self._dragCell = nil
  end
end

function ArrangePVPLeftDialog:LoadLocalData()
  local roleConfigId
  for i = 1, 9 do
    roleConfigId = NekoData.BehaviorManager.BM_BattleEditor:GetPVPLeftData(i)
    if roleConfigId and 0 < roleConfigId then
      self._cells[i] = DialogManager.CreateDialog("battleeditor.pvp.arrangeleftrolecell", self._leftPos[i]._uiObject)
      self._cells[i]:SetRoleConfigId(roleConfigId)
      self._cells[i]._delegate = self
    end
  end
end

function ArrangePVPLeftDialog:ShowAttribute(roleConfigId)
  if roleConfigId == 0 then
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
    local roleConfigRecord = RoleConfigTable:GetRecorder(roleConfigId)
    local skillShowRecord = CSkillShow_Role:GetRecorder(roleConfigRecord.skillid)
    self._rightName:SetText(TextManager.GetText(roleConfigRecord.name))
    self._rightJobName:SetText(roleConfigRecord.vocation)
    self._rightLevel:SetText(90)
    self._rightHP:SetText(roleConfigRecord.hp)
    self._rightSpeed:SetText(roleConfigRecord.speed)
    self._rightADAtk:SetText(roleConfigRecord.attack)
    self._rightADDef:SetText(roleConfigRecord.def)
    self._rightAPAtk:SetText(roleConfigRecord.magic)
    self._rightAPDef:SetText(roleConfigRecord.magicDef)
    self._rightSkillName:SetText(TextManager.GetText(skillShowRecord.nameTextID))
    self._rightSkillDescribe:SetText(NekoData.BehaviorManager.BM_Message:GetRoleSkillDescribe(roleConfigRecord.skillid))
  end
end

function ArrangePVPLeftDialog:NumberOfCell(frame)
  return #RoleConfigTable:GetAllIds()
end

function ArrangePVPLeftDialog:CellAtIndex(frame)
  return "battleeditor.pvp.arrangepvprightcell"
end

function ArrangePVPLeftDialog:DataAtIndex(frame, index)
  local ids = RoleConfigTable:GetAllIds()
  return RoleConfigTable:GetRecorder(ids[index])
end

function ArrangePVPLeftDialog:SetSelectedID(id)
  self._selectedId = id
  self._frame:FireEvent("SelectIndex", id)
  for k, cell in pairs(self._cells) do
    cell:Selected(false)
  end
  self:ShowAttribute(id)
end

function ArrangePVPLeftDialog:GetSelectedID()
  return self._selectedId
end

function ArrangePVPLeftDialog:OnLeftCellSelected(posId)
  self._selectedId = 0
  self._frame:FireEvent("SelectIndex", 0)
  if self._cells[posId] then
    self:ShowAttribute(self._cells[posId]._id)
  end
  for k, v in pairs(self._cells) do
    v:Selected(k == posId)
  end
end

function ArrangePVPLeftDialog:OnRightCellBeginDrag(screenPosition)
  if self._dragCell then
    self._dragCell:Destroy()
    self._dragCell:RootWindowDestroy()
    self._dragCell = nil
  end
  self._dragCell = DialogManager.CreateDialog("battleeditor.pvp.arrangeleftrolecell", self:GetRootWindow()._uiObject)
  self._dragCell:GetRootWindow():SetAnchoredPosition(UIManager.ScreenPointToLocalPointInRectangle(self:GetRootWindow()._uiObject, screenPosition.x, screenPosition.y))
  self._dragCell:SetRoleConfigId(self._selectedId)
end

function ArrangePVPLeftDialog:OnRightCellDrag(screenPosition)
  if self._dragCell then
    self._dragCell:GetRootWindow():SetAnchoredPosition(UIManager.ScreenPointToLocalPointInRectangle(self:GetRootWindow()._uiObject, screenPosition.x, screenPosition.y))
  end
end

function ArrangePVPLeftDialog:OnRightCellEndDrag(screenPosition)
  if self._dragCell then
    self._dragCell:Destroy()
    self._dragCell:RootWindowDestroy()
    self._dragCell = nil
  end
end

function ArrangePVPLeftDialog:OnClearClicked(arg)
  for k, cell in pairs(self._cells) do
    NekoData.DataManager.DM_BattleEditor:SetPVPLeft(k, 0)
    cell:Destroy()
    cell:RootWindowDestroy()
  end
  self._cells = {}
  self:ShowAttribute(self._selectedId)
end

function ArrangePVPLeftDialog:OnSelfClicked()
  DialogManager.DestroySingletonDialog("battleeditor.pvp.arrangepvpleftdialog")
  DialogManager.CreateSingletonDialog("battleeditor.pvp.arrangerightdialog")
end

function ArrangePVPLeftDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("battleeditor.pvp.arrangepvpleftdialog")
end

function ArrangePVPLeftDialog:OnLeftCellDrop(arg, selfLuaWindow, sourceLuaWindow)
  if sourceLuaWindow and sourceLuaWindow:GetUserData().__cname == "ArrangePVPRightCell" then
    local posIndex = selfLuaWindow:GetUserData()
    if self._cells[posIndex] then
      self._cells[posIndex]:Destroy()
      self._cells[posIndex]:RootWindowDestroy()
    end
    self._cells[posIndex] = DialogManager.CreateDialog("battleeditor.pvp.arrangeleftrolecell", selfLuaWindow._uiObject)
    self._cells[posIndex]:SetRoleConfigId(self._selectedId)
    self._cells[posIndex]._delegate = self
    NekoData.DataManager.DM_BattleEditor:SetPVPLeft(posIndex, self._selectedId)
    self:OnLeftCellSelected(posIndex)
  end
end

function ArrangePVPLeftDialog:OnLeftCellClicked(arg, selfLuaWindow)
  local posIndex = selfLuaWindow:GetUserData()
  self:OnLeftCellSelected(posIndex)
end

return ArrangePVPLeftDialog
