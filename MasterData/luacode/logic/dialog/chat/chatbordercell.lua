local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CChatFrameConfig = BeanManager.GetTableByName("headphoto.cchatframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ChatBorderCell = class("ChatBorderCell", Dialog)
ChatBorderCell.AssetBundleName = "ui/layouts.chat"
ChatBorderCell.AssetName = "ChatNewMainFrameCell"

function ChatBorderCell:Ctor(...)
  ChatBorderCell.super.Ctor(self, ...)
end

function ChatBorderCell:OnCreate()
  self._image = self:GetChild("Back/Normal")
  self._current = self:GetChild("Back/Current")
  self._current:SetActive(false)
  self._select = self:GetChild("Back/Select")
  self._select:SetActive(false)
  self._lockImage = self:GetChild("Back/Lock")
  self._lockImage:SetActive(false)
  self._NameText = self:GetChild("Name")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self.data = nil
end

function ChatBorderCell:RefreshCell(data)
  self.data = data
  self._NameText:SetText(TextManager.GetText(self.data.record.nameTextID))
  local imageRecord = CImagePathTable:GetRecorder(self.data.record.photoid)
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if self._delegate._curSelectBorderId == self.data.record.id then
    self._select:SetActive(true)
  else
    self._select:SetActive(false)
  end
  if self.data.isCurrent == 1 then
    self._current:SetActive(true)
  else
    self._current:SetActive(false)
  end
  if self.data.isOwned == 1 then
    self._lockImage:SetActive(false)
  else
    self._lockImage:SetActive(true)
  end
end

function ChatBorderCell:OnCellClicked()
  if self.data ~= nil then
    self._delegate:OnSelectBorder(self.data.record.id)
  end
end

function ChatBorderCell:OnEvent(eventName, arg)
  if self._cellData and eventName == "ChooseBorder" then
    if self.data.record.id == arg then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
  end
end

return ChatBorderCell
