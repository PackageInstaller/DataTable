local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CShopTypeConfig = BeanManager.GetTableByName("recharge.cshoptypeconfig")
local CEmojiItem = BeanManager.GetTableByName("item.cemojiitem")
local DM_RedDot = NekoData.DataManager.DM_RedDot
local EmojiBtnCell = class("EmojiBtnCell", Dialog)
EmojiBtnCell.AssetBundleName = "ui/layouts.guild"
EmojiBtnCell.AssetName = "EmojiTab"

function EmojiBtnCell:Ctor(...)
  EmojiBtnCell.super.Ctor(self, ...)
end

function EmojiBtnCell:OnCreate()
  self._btn = self:GetChild("NextBtn")
  self._image = self:GetChild("Image")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function EmojiBtnCell:OnDestroy()
end

function EmojiBtnCell:RefreshCell(record)
  self._groupBtnID = record
  self._barSelected = self._groupBtnID == self._delegate._emojiType
  self._btn:SetSelected(self._barSelected)
  local imageRecord = CImagePathTable:GetRecorder(CEmojiItem:GetRecorder(record).tabImgId) or DataCommon.DefaultImageAsset
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function EmojiBtnCell:OnCellClicked(args)
  self._delegate:OnEmojiTypeBtnClicked(self._groupBtnID)
end

function EmojiBtnCell:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    self._barSelected = self._groupBtnID == arg
    self._btn:SetSelected(self._barSelected)
  end
end

return EmojiBtnCell
