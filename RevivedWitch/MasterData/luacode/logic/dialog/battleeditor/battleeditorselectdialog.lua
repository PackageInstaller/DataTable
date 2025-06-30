-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battleeditor/battleeditorselectdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBackManager = require("framework.ui.uibackmanager")
local BattleEditorSelectDialog = class("BattleEditorSelectDialog", Dialog)
BattleEditorSelectDialog.AssetBundleName = "ui/layouts.battleeditor"
BattleEditorSelectDialog.AssetName = "BattleEditorSelect"
BattleEditorSelectDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleEditorSelectDialog
  ((BattleEditorSelectDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

BattleEditorSelectDialog.OnCreate = function(self, root)
  -- function num : 0_1 , upvalues : UIBackManager
  self._charatorInfo = self:GetChild("Panel/CharatorInfo")
  self._arrangePVP = self:GetChild("Panel/ArrangePVP")
  self._arrangePVE = self:GetChild("Panel/ArrangePVE")
  self._matching = self:GetChild("Panel/Matching")
  self._exit = self:GetChild("Panel/BackBtn")
  ;
  (self._charatorInfo):Subscribe_PointerClickEvent(self.OnCharatorInfoClicked, self)
  ;
  (self._arrangePVP):Subscribe_PointerClickEvent(self.OnArrangePVPClicked, self)
  ;
  (self._arrangePVE):Subscribe_PointerClickEvent(self.OnArrangePVEClicked, self)
  ;
  (self._matching):Subscribe_PointerClickEvent(self.OnMatchingClicked, self)
  ;
  (self._exit):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (UIBackManager.SetUIBackShow)(true)
end

BattleEditorSelectDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : UIBackManager
  (UIBackManager.SetUIBackShow)(false)
end

BattleEditorSelectDialog.OnCharatorInfoClicked = function(self, arg)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("battleeditor.charactorinfodialog")
end

BattleEditorSelectDialog.OnArrangePVPClicked = function(self, arg)
  -- function num : 0_4 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("battleeditor.pvp.arrangepvpleftdialog")
end

BattleEditorSelectDialog.OnArrangePVEClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("battleeditor.pve.arrangepveleftdialog")
end

BattleEditorSelectDialog.OnMatchingClicked = function(self)
  -- function num : 0_6
end

BattleEditorSelectDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("battleeditor.battleeditorselectdialog")
  ;
  (DialogManager.CreateSingletonDialog)("maindialog")
end

return BattleEditorSelectDialog

