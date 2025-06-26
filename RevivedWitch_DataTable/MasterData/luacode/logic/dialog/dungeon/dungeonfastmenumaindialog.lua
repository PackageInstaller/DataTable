-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonfastmenumaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonFastMenuMainDialog = class("DungeonFastMenuMainDialog", Dialog)
DungeonFastMenuMainDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
DungeonFastMenuMainDialog.AssetName = "FastMenuMain"
DungeonFastMenuMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonFastMenuMainDialog
  ((DungeonFastMenuMainDialog.super).Ctor)(self, ...)
  self._groupName = "ModalFrame"
  self._dialogs = {}
end

DungeonFastMenuMainDialog.OnCreate = function(self)
  -- function num : 0_1
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._menuBtn):SetActive(false)
  self._backBtn = self:GetChild("BackBtn")
  self._backBtnGuideEffect = self:GetChild("BackBtn/Effect")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnPointerClick, self)
end

DungeonFastMenuMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  ((DialogManager.GetGroup)("Modal")):CloseAllDialog()
end

DungeonFastMenuMainDialog.AddNewDialog = function(self, dialog)
  -- function num : 0_3 , upvalues : _ENV
  (table.insert)(self._dialogs, dialog)
end

DungeonFastMenuMainDialog.OnBackBtnPointerClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if not ((DialogManager.GetGroup)("Modal")):OnBackPointerClick() then
    self:Destroy()
  end
end

DungeonFastMenuMainDialog.AddGuideDialogForReturn = function(self, guideId)
  -- function num : 0_5 , upvalues : _ENV
  local width, height = (self._backBtnGuideEffect):GetRectSize()
  local screenPos = (self._backBtnGuideEffect):GetLocalPointInUiRootPanel()
  local dialog = (DialogManager.CreateSingletonDialog)("guide.guidedialog")
  dialog:SetGuideId(guideId)
  dialog:SetGuidePoint(width, height, screenPos.x, screenPos.y)
  dialog = (DialogManager.CreateSingletonDialog)("guide.guidenextdialog")
  dialog:SetGuideId(guideId)
  dialog:SetTextPoint(width, height, screenPos.x, screenPos.y, "Left")
end

DungeonFastMenuMainDialog.RemoveGuideDialogForReturn = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("guide.guidenextdialog")
  ;
  (DialogManager.DestroySingletonDialog)("guide.guidedialog")
end

return DungeonFastMenuMainDialog

