-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2tipdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2TipDialog = class("TowerV2TipDialog", Dialog)
TowerV2TipDialog.AssetBundleName = "ui/layouts.stair"
TowerV2TipDialog.AssetName = "StairTips"
TowerV2TipDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2TipDialog
  ((TowerV2TipDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

TowerV2TipDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._confirmBtn = self:GetChild("ConfirmBtn")
  self._frame = self:GetChild("Back/Frame")
  self._text = self:GetChild("Back/Frame/Text")
  self._close = self:GetChild("CloseBtn")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._close):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  local date = (os.date)("*t", ((NekoData.BehaviorManager).BM_TowerV2):GetNextTime())
  local text = ((TextManager.GetText)(1900979)):gsub("%$parameter(%d)%$", {["1"] = date.month, ["2"] = date.day})
  ;
  (self._text):SetText(text)
  local _, height = (self._text):GetPreferredSize()
  ;
  (self._text):SetHeight(0, height)
  ;
  (((self._frame):GetUIObject()):GetComponent("ScrollRect")).verticalNormalizedPosition = 1
end

TowerV2TipDialog.OnDestroy = function(self)
  -- function num : 0_2
end

TowerV2TipDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("towerv2.towerv2tipdialog")
end

return TowerV2TipDialog

