local CStringres = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local UnlockMusicCell = class("UnlockMusicCell", Dialog)
UnlockMusicCell.AssetBundleName = "ui/layouts.yard"
UnlockMusicCell.AssetName = "MusicPlayerUnlockMusicCell"

function UnlockMusicCell:Ctor(...)
  UnlockMusicCell.super.Ctor(self, ...)
end

function UnlockMusicCell:OnCreate()
  self._title = self:GetChild("Title")
  self._frame = self:GetChild("Back")
  self._icon = self:GetChild("Image")
  self._count = self:GetChild("Num")
  self._tips = self:GetChild("TipsFrame")
  self._tips:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function UnlockMusicCell:OnDestroy()
end

function UnlockMusicCell:RefreshCell(data)
  self._item = Item.Create(data.id)
  self._title:SetText(self._item:GetName())
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local haveNum = 0
  if string.sub(data.id, 1, 2) == "35" then
    haveNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(data.id)
  else
    haveNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(data.id)
  end
  local str = ""
  if haveNum >= data.num then
    self._enough = true
    str = TextManager.GetText(CStringres:GetRecorder(1146).msgTextID)
    str = string.gsub(str, "%$parameter1%$", haveNum)
  else
    self._enough = false
    str = TextManager.GetText(CStringres:GetRecorder(1147).msgTextID)
    str = string.gsub(str, "%$parameter1%$", haveNum)
  end
  str = string.gsub(str, "%$parameter2%$", data.num)
  self._count:SetText(str)
end

function UnlockMusicCell:OnCellClicked()
  local width, height = self._icon:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

function UnlockMusicCell:OnEvent(eventName, args)
  if eventName == "ShowTips" then
    self._tips:SetActive(not self._enough)
  end
end

return UnlockMusicCell
