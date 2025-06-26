-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equipchangesecondconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local AttrTypeEnum = (LuaNetManager.GetBeanDef)("protocol.login.attrtype")
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local EquipChangeSecondconfirmDialog = class("EquipChangeSecondconfirmDialog", Dialog)
EquipChangeSecondconfirmDialog.AssetBundleName = "ui/layouts.equip"
EquipChangeSecondconfirmDialog.AssetName = "EquipSetTip"
EquipChangeSecondconfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipChangeSecondconfirmDialog
  ((EquipChangeSecondconfirmDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

EquipChangeSecondconfirmDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (self:GetChild("Tips/Text")):SetText((TextManager.GetText)(701594))
  ;
  (self:GetChild("Tips/Button0/_Text")):SetText((TextManager.GetText)(701595))
  ;
  (self:GetChild("Tips/Button1/_Text")):SetText((TextManager.GetText)(701596))
  self._cancleBtn = self:GetChild("Tips/Button0")
  self._confirmBtn = self:GetChild("Tips/Button1")
  self._tips = self:GetChild("Tips")
  ;
  (self._cancleBtn):Subscribe_PointerClickEvent(self.OnConfirmBtn2Clicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._tips):Subscribe_PointerClickEvent(self.OnConfirmTips, self)
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

EquipChangeSecondconfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_2
  self:Destroy()
end

EquipChangeSecondconfirmDialog.OnConfirmTips = function(self)
  -- function num : 0_3
end

EquipChangeSecondconfirmDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local CharEquipPart = require("logic.dialog.character.newcharequippart")
  ;
  (CharEquipPart.PreSetEquip)()
  self:Destroy()
end

EquipChangeSecondconfirmDialog.OnConfirmBtn2Clicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local CharEquipPart = require("logic.dialog.character.newcharequippart")
  ;
  (CharEquipPart.MaxScoreEquip)()
  self:Destroy()
end

return EquipChangeSecondconfirmDialog

