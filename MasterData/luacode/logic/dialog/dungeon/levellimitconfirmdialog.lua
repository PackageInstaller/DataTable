local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local LevelLimitConfirmDialog = class("LevelLimitConfirmDialog", Dialog)
LevelLimitConfirmDialog.AssetBundleName = "ui/layouts.secondconfirm"
LevelLimitConfirmDialog.AssetName = "LevelLimitConfirm"

function LevelLimitConfirmDialog:Ctor(...)
  LevelLimitConfirmDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function LevelLimitConfirmDialog:OnCreate()
  self._describeText = self:GetChild("Text2")
  self._gainWayText = self:GetChild("Text5")
  self._endBtn = self:GetChild("FinishBtn")
  self._endBtnTxt = self:GetChild("FinishBtn/_Text")
  self._itemIcon = self:GetChild("ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("ItemCell/_BackGround/Frame")
  self._itemCount = self:GetChild("ItemCell/_Count")
  self._endBtn:Subscribe_PointerClickEvent(self.OnEndClick, self)
  self._itemIcon:Subscribe_PointerClickEvent(self.OnItemClick, self)
end

function LevelLimitConfirmDialog:OnDestroy()
end

function LevelLimitConfirmDialog:Init(lv, fromMainCity)
  self._fromMainCity = fromMainCity
  local str = CStringRes:GetRecorder(1376).msgTextID
  str = TextManager.GetText(str)
  str = string.gsub(str, "%$parameter1%$", tostring(lv))
  self._describeText:SetText(str)
  str = CStringRes:GetRecorder(1377).msgTextID
  str = TextManager.GetText(str)
  self._gainWayText:SetText(str)
  self._itemCount:SetActive(false)
  local item = Item.Create(35020)
  local imageRecord = item:GetIcon()
  self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  self._itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._item = item
  if fromMainCity then
    local str = CStringRes:GetRecorder(1437).msgTextID
    str = TextManager.GetText(str)
    self._endBtnTxt:SetText(str)
  end
end

function LevelLimitConfirmDialog:OnEndClick()
  if self._fromMainCity then
    self:Destroy()
  else
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
    csend:Send()
    DialogManager.DestroySingletonDialog("dungeon.dungeonnextfloordialog")
    self:Destroy()
  end
end

function LevelLimitConfirmDialog:OnItemClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
  end
end

return LevelLimitConfirmDialog
