local UIManager = CS.PixelNeko.UI.UIManager
local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")
local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local EquipChangeSecondconfirmDialog = class("EquipChangeSecondconfirmDialog", Dialog)
EquipChangeSecondconfirmDialog.AssetBundleName = "ui/layouts.equip"
EquipChangeSecondconfirmDialog.AssetName = "EquipSetTip"

function EquipChangeSecondconfirmDialog:Ctor(...)
  EquipChangeSecondconfirmDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function EquipChangeSecondconfirmDialog:OnCreate()
  self:GetChild("Tips/Text"):SetText(TextManager.GetText(701594))
  self:GetChild("Tips/Button0/_Text"):SetText(TextManager.GetText(701595))
  self:GetChild("Tips/Button1/_Text"):SetText(TextManager.GetText(701596))
  self._cancleBtn = self:GetChild("Tips/Button0")
  self._confirmBtn = self:GetChild("Tips/Button1")
  self._tips = self:GetChild("Tips")
  self._cancleBtn:Subscribe_PointerClickEvent(self.OnConfirmBtn2Clicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._tips:Subscribe_PointerClickEvent(self.OnConfirmTips, self)
  self._rootWindow:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function EquipChangeSecondconfirmDialog:OnBackBtnClicked()
  self:Destroy()
end

function EquipChangeSecondconfirmDialog:OnConfirmTips()
end

function EquipChangeSecondconfirmDialog:OnConfirmBtnClicked()
  local CharEquipPart = require("logic.dialog.character.newcharequippart")
  CharEquipPart.PreSetEquip()
  self:Destroy()
end

function EquipChangeSecondconfirmDialog:OnConfirmBtn2Clicked()
  local CharEquipPart = require("logic.dialog.character.newcharequippart")
  CharEquipPart.MaxScoreEquip()
  self:Destroy()
end

return EquipChangeSecondconfirmDialog
