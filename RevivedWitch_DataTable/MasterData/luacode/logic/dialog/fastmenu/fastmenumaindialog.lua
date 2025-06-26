-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/fastmenu/fastmenumaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FastMenuMainDialog = class("FastMenuMainDialog", Dialog)
FastMenuMainDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
FastMenuMainDialog.AssetName = "FastMenuMain"
FastMenuMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FastMenuMainDialog
  ((FastMenuMainDialog.super).Ctor)(self, ...)
  self._groupName = "ModalFrame"
  self._dialogs = {}
end

FastMenuMainDialog.OnCreate = function(self)
  -- function num : 0_1
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn = self:GetChild("BackBtn")
  self._backBtnGuideEffect = self:GetChild("BackBtn/Effect")
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnPointerClick, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnPointerClick, self)
end

FastMenuMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  ((DialogManager.GetGroup)("Modal")):CloseAllDialog()
  ;
  (DialogManager.DestroySingletonDialog)("fastmenu.fastmenudialog")
end

FastMenuMainDialog.ChangeBackBtnStatus = function(self, status)
  -- function num : 0_3
  (self._backBtn):SetActive(status)
end

FastMenuMainDialog.OnMenuBtnPointerClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("fastmenu.fastmenudialog")
  if dialog then
    (DialogManager.DestroySingletonDialog)("fastmenu.fastmenudialog")
  else
    ;
    (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
  end
end

FastMenuMainDialog.AddNewDialog = function(self, dialog)
  -- function num : 0_5 , upvalues : _ENV
  (table.insert)(self._dialogs, dialog)
end

FastMenuMainDialog.OnBackBtnPointerClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not ((DialogManager.GetGroup)("Modal")):OnBackPointerClick() then
    self:Destroy()
  end
end

FastMenuMainDialog.DestroyAllDialogs = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((DialogManager.GetGroup)("Modal")):CloseAllDialog()
  self:Destroy()
end

FastMenuMainDialog.AddGuideDialogForReturn = function(self, guideId)
  -- function num : 0_8 , upvalues : _ENV
  local width, height = (self._backBtnGuideEffect):GetRectSize()
  local screenPos = (self._backBtnGuideEffect):GetLocalPointInUiRootPanel()
  local dialog = (DialogManager.CreateSingletonDialog)("guide.guidedialog")
  dialog:SetGuideId(guideId)
  dialog:SetGuidePoint(width, height, screenPos.x, screenPos.y)
  ;
  ((DialogManager.CreateSingletonDialog)("guide.guidenextdialog")):SetTextPoint(width, height, screenPos.x, screenPos.y, "Left")
end

FastMenuMainDialog.RemoveGuideDialogForReturn = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("guide.guidenextdialog")
  ;
  (DialogManager.DestroySingletonDialog)("guide.guidedialog")
end

return FastMenuMainDialog

