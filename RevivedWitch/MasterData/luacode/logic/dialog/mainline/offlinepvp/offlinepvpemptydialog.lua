-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/offlinepvp/offlinepvpemptydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local OffLinePVPEmptyDialog = class("OffLinePVPEmptyDialog", Dialog)
OffLinePVPEmptyDialog.AssetBundleName = "ui/layouts.offlinepvp"
OffLinePVPEmptyDialog.AssetName = "OffLinePVPEmpty"
OffLinePVPEmptyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OffLinePVPEmptyDialog
  ((OffLinePVPEmptyDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

OffLinePVPEmptyDialog.OnCreate = function(self)
  -- function num : 0_1
  self._describeTxt = self:GetChild("Back/Txt")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
end

OffLinePVPEmptyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_2
  self:Destroy()
end

OffLinePVPEmptyDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

OffLinePVPEmptyDialog.SetWaitDescribe = function(self)
  -- function num : 0_4 , upvalues : CStringRes, _ENV
  local str = (CStringRes:GetRecorder(1375)).msgTextID
  str = (TextManager.GetText)(str)
  ;
  (self._describeTxt):SetText(str)
end

return OffLinePVPEmptyDialog

