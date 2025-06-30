-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/handbookdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local HandBookDialog = class("HandBookDialog", Dialog)
HandBookDialog.AssetBundleName = "ui/layouts.tujian"
HandBookDialog.AssetName = "BookMain"
HandBookDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HandBookDialog
  ((HandBookDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._isRoleList = false
  self._uiBackActive = false
end

HandBookDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV
  self._groupBtnInfo = {}
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

      (self._groupBtnInfo)[i] = {}
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._groupBtnInfo)[i]).btn = self:GetChild("GroupBtnArea/Btn" .. i .. "/GroupBtn")
      ;
      (((self._groupBtnInfo)[i]).btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnGroupClick(i)
  end
)
    end
  end
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._roleBookRed = self:GetChild("GroupBtnArea/Btn2/GroupBtn/RedDot")
  ;
  (self._roleBookRed):SetActive(false)
  self._panelWnd = self:GetChild("Frame")
  self._pageHelper = (TabFrame.Create)(self._panelWnd, self)
  ;
  (((self._groupBtnInfo)[1]).btn):SetActive(true)
  ;
  (self._pageHelper):ToPage(1)
  self:RefreshRoleHandBookRedData()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRoleHandBookRedData, Common.n_RefreshRoleFavorRedData, nil)
end

HandBookDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._pageHelper):Destroy()
  if self._uiBackActive then
    (UIBackManager.SetUIBackShow)(false)
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

HandBookDialog.OnGroupClick = function(self, index)
  -- function num : 0_3
  if index == 4 then
    (self._pageHelper):ToPage(5)
    return 
  end
  ;
  (self._pageHelper):ToPage(index)
end

HandBookDialog.DidToPage = function(self, helper, index)
  -- function num : 0_4 , upvalues : _ENV
  if index == 1 then
    (UIBackManager.SetUIBackShow)(false)
    self._uiBackActive = false
  else
    if not self._uiBackActive then
      (UIBackManager.SetUIBackShow)(true)
      self._uiBackActive = true
    end
    ;
    (UIBackManager.SetUIModalBackColor)(2)
  end
  local dlg = (self._pageHelper):GetCellAtIndex(index)
  if dlg.Refresh then
    dlg:Refresh()
  end
  if dlg.OnEnable then
    dlg:OnEnable()
  end
  for i = 1, 3 do
    (((self._groupBtnInfo)[i]).btn):SetSelected(index == i)
  end
  if index == 4 then
    (((self._groupBtnInfo)[1]).btn):SetSelected(true)
  end
  if index == 5 then
    (((self._groupBtnInfo)[4]).btn):SetSelected(true)
  else
    (((self._groupBtnInfo)[4]).btn):SetSelected(false)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

HandBookDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_5
  if index == 1 then
    return "handbook.rolebooknewdialog"
  else
    if index == 2 then
      return "handbook.equipbookdialog"
    else
      if index == 3 then
        return "handbook.monsterbookdialog"
      else
        if index == 4 then
          return "handbook.rolebooklistdialog"
        else
          if index == 5 then
            return "handbook.memorybookdialog"
          end
        end
      end
    end
  end
end

HandBookDialog.RefreshRoleHandBookRedData = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (self._roleBookRed):SetActive(((NekoData.BehaviorManager).BM_HandBook):IsShowRoleFavorAwardRed())
end

HandBookDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

HandBookDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

HandBookDialog.SetRoleList = function(self, isList)
  -- function num : 0_9
  self._isRoleList = isList
end

HandBookDialog.SetPage = function(self, index)
  -- function num : 0_10
  (self._pageHelper):ToPage(index)
end

return HandBookDialog

