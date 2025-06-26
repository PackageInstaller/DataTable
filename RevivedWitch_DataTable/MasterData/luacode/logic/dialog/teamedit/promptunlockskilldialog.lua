-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/teamedit/promptunlockskilldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 4
local PromptUnlockSkillDialog = class("PromptUnlockSkillDialog", Dialog)
PromptUnlockSkillDialog.AssetBundleName = "ui/layouts.teamedit"
PromptUnlockSkillDialog.AssetName = "TeamEditSkillUnlock"
PromptUnlockSkillDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PromptUnlockSkillDialog
  ((PromptUnlockSkillDialog.super).Ctor)(self, ...)
end

PromptUnlockSkillDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame, _ENV
  self._emptyTxt = self:GetChild("Panel/EmptyTxt")
  self._panel = self:GetChild("Panel/Frame")
  self._closeBtn = self:GetChild("Panel/CloseBtn")
  self._goBtn = self:GetChild("Panel/StartBtn")
  self._scrollBar = self:GetChild("Panel/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._width = (self._panel):GetRectSize()
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSkillUnlock, Common.n_ImproveSkill, nil)
end

PromptUnlockSkillDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
end

local RefreshEmptyTxtShow = function(self)
  -- function num : 0_3
  if #self._list > 0 then
    (self._emptyTxt):SetActive(false)
    ;
    (self._panel):SetActive(true)
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
  else
    ;
    (self._emptyTxt):SetActive(true)
    ;
    (self._panel):SetActive(false)
  end
end

PromptUnlockSkillDialog.OnSkillUnlock = function(self)
  -- function num : 0_4 , upvalues : _ENV, RefreshEmptyTxtShow
  local deleteIndex = {}
  for i,role in ipairs(self._list) do
    local skill2Info = role:GetShowSkillDataByIndex(2)
    if skill2Info.unlock then
      (table.insert)(deleteIndex, i)
    end
  end
  do
    while deleteIndex[#deleteIndex] do
      (table.remove)(self._list, deleteIndex[#deleteIndex])
      ;
      (table.remove)(deleteIndex, #deleteIndex)
    end
    RefreshEmptyTxtShow(self)
  end
end

PromptUnlockSkillDialog.SetData = function(self, list)
  -- function num : 0_5 , upvalues : RefreshEmptyTxtShow
  self._list = list
  RefreshEmptyTxtShow(self)
end

PromptUnlockSkillDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._list
end

PromptUnlockSkillDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "teamedit.promptunlockskillcell"
end

PromptUnlockSkillDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._list)[index]
end

PromptUnlockSkillDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_9
  local total = (self._frame):GetTotalLength()
  if self._height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(self._height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

PromptUnlockSkillDialog.OnGoBtnClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("teamedit.teameditprewardialog")
  if dialog then
    dialog:BeginTaskBtnClicked()
  end
  self:Destroy()
end

PromptUnlockSkillDialog.OnBackBtnClicked = function(self)
  -- function num : 0_11
  self:Destroy()
end

return PromptUnlockSkillDialog

