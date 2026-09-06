local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 4
local PromptUnlockSkillDialog = class("PromptUnlockSkillDialog", Dialog)
PromptUnlockSkillDialog.AssetBundleName = "ui/layouts.teamedit"
PromptUnlockSkillDialog.AssetName = "TeamEditSkillUnlock"

function PromptUnlockSkillDialog:Ctor(...)
  PromptUnlockSkillDialog.super.Ctor(self, ...)
end

function PromptUnlockSkillDialog:OnCreate()
  self._emptyTxt = self:GetChild("Panel/EmptyTxt")
  self._panel = self:GetChild("Panel/Frame")
  self._closeBtn = self:GetChild("Panel/CloseBtn")
  self._goBtn = self:GetChild("Panel/StartBtn")
  self._scrollBar = self:GetChild("Panel/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._width, self._height = self._panel:GetRectSize()
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnSkillUnlock, Common.n_ImproveSkill, nil)
end

function PromptUnlockSkillDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
end

local function RefreshEmptyTxtShow(self)
  if #self._list > 0 then
    self._emptyTxt:SetActive(false)
    self._panel:SetActive(true)
    self._frame:ReloadAllCell()
    self._frame:MoveToTop()
  else
    self._emptyTxt:SetActive(true)
    self._panel:SetActive(false)
  end
end

function PromptUnlockSkillDialog:OnSkillUnlock()
  local deleteIndex = {}
  for i, role in ipairs(self._list) do
    local skill2Info = role:GetShowSkillDataByIndex(2)
    if skill2Info.unlock then
      table.insert(deleteIndex, i)
    end
  end
  while deleteIndex[#deleteIndex] do
    table.remove(self._list, deleteIndex[#deleteIndex])
    table.remove(deleteIndex, #deleteIndex)
  end
  RefreshEmptyTxtShow(self)
end

function PromptUnlockSkillDialog:SetData(list)
  self._list = list
  RefreshEmptyTxtShow(self)
end

function PromptUnlockSkillDialog:NumberOfCell(frame)
  return #self._list
end

function PromptUnlockSkillDialog:CellAtIndex(frame, index)
  return "teamedit.promptunlockskillcell"
end

function PromptUnlockSkillDialog:DataAtIndex(frame, index)
  return self._list[index]
end

function PromptUnlockSkillDialog:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function PromptUnlockSkillDialog:OnGoBtnClick()
  local dialog = DialogManager.GetDialog("teamedit.teameditprewardialog")
  if dialog then
    dialog:BeginTaskBtnClicked()
  end
  self:Destroy()
end

function PromptUnlockSkillDialog:OnBackBtnClicked()
  self:Destroy()
end

return PromptUnlockSkillDialog
