local UIBackManager = require("framework.ui.uibackmanager")
local BattleEditorSelectDialog = class("BattleEditorSelectDialog", Dialog)
BattleEditorSelectDialog.AssetBundleName = "ui/layouts.battleeditor"
BattleEditorSelectDialog.AssetName = "BattleEditorSelect"

function BattleEditorSelectDialog:Ctor(...)
  BattleEditorSelectDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function BattleEditorSelectDialog:OnCreate(root)
  self._charatorInfo = self:GetChild("Panel/CharatorInfo")
  self._arrangePVP = self:GetChild("Panel/ArrangePVP")
  self._arrangePVE = self:GetChild("Panel/ArrangePVE")
  self._matching = self:GetChild("Panel/Matching")
  self._exit = self:GetChild("Panel/BackBtn")
  self._charatorInfo:Subscribe_PointerClickEvent(self.OnCharatorInfoClicked, self)
  self._arrangePVP:Subscribe_PointerClickEvent(self.OnArrangePVPClicked, self)
  self._arrangePVE:Subscribe_PointerClickEvent(self.OnArrangePVEClicked, self)
  self._matching:Subscribe_PointerClickEvent(self.OnMatchingClicked, self)
  self._exit:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  UIBackManager.SetUIBackShow(true)
end

function BattleEditorSelectDialog:OnDestroy()
  UIBackManager.SetUIBackShow(false)
end

function BattleEditorSelectDialog:OnCharatorInfoClicked(arg)
  DialogManager.CreateSingletonDialog("battleeditor.charactorinfodialog")
end

function BattleEditorSelectDialog:OnArrangePVPClicked(arg)
  DialogManager.CreateSingletonDialog("battleeditor.pvp.arrangepvpleftdialog")
end

function BattleEditorSelectDialog:OnArrangePVEClicked()
  DialogManager.CreateSingletonDialog("battleeditor.pve.arrangepveleftdialog")
end

function BattleEditorSelectDialog:OnMatchingClicked()
end

function BattleEditorSelectDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("battleeditor.battleeditorselectdialog")
  DialogManager.CreateSingletonDialog("maindialog")
end

return BattleEditorSelectDialog
