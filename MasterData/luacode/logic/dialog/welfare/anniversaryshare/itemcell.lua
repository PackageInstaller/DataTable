local Item = require("logic.manager.experimental.types.item")
local ItemCell = class("ItemCell", Dialog)
ItemCell.AssetBundleName = "ui/layouts.welfare"
ItemCell.AssetName = "ActivityShareWelfareCell"

function ItemCell:Ctor(...)
  ItemCell.super.Ctor(self, ...)
end

function ItemCell:OnCreate()
  self._progressBar = self:GetChild("LineGrey/Line")
  self._progressNum = self:GetChild("NumGrey/Num")
  self._dotGrey = self:GetChild("DotGrey")
  self._dot = self:GetChild("Dot")
  self._itemCell = self:GetChild("Award/ItemCell")
  self._itemCellIcon = self:GetChild("Award/ItemCell/_BackGround/Icon")
  self._itemCellCount = self:GetChild("Award/ItemCell/_Count")
  self._itemCellFrame = self:GetChild("Award/ItemCell/_BackGround/Frame")
  self._itemCellLock = self:GetChild("Award/Lock")
  self._itemCellEffect = self:GetChild("Award/Effect")
  self._itemCellGet = self:GetChild("Award/Get")
  self._itemCell:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
end

function ItemCell:OnDestroy()
end

function ItemCell:RefreshCell(data)
  self._dm = NekoData.DataManager.DM_AnniversaryShare
  self._bm = NekoData.BehaviorManager.BM_AnniversaryShare
  self._data = data
  self._item = Item.Create(self._data.itemID)
  local imageRecord = self._item:GetIcon()
  self._itemCellIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetPinJiImage()
  self._itemCellFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemCellCount:SetText(NumberManager.GetShowNumber(self._data.itemNum))
  self._progressBar:SetFillAmount(self._data.progress)
  self._progressNum:SetText(self._data.needNum)
  if self._data.status == self._bm:GetSAnniversaryShareInfoDef().UNLOCKED then
    self._dotGrey:SetActive(false)
    self._dot:SetActive(true)
    self._itemCellLock:SetActive(false)
    self._itemCellEffect:SetActive(true)
    self._itemCellGet:SetActive(false)
  elseif self._data.status == self._bm:GetSAnniversaryShareInfoDef().LOCKED then
    self._dotGrey:SetActive(true)
    self._dot:SetActive(false)
    self._itemCellLock:SetActive(true)
    self._itemCellEffect:SetActive(false)
    self._itemCellGet:SetActive(false)
  elseif self._data.status == self._bm:GetSAnniversaryShareInfoDef().FETCHED then
    self._dotGrey:SetActive(false)
    self._dot:SetActive(true)
    self._itemCellLock:SetActive(false)
    self._itemCellEffect:SetActive(false)
    self._itemCellGet:SetActive(true)
  else
    self._dotGrey:SetActive(true)
    self._dot:SetActive(false)
    self._itemCellLock:SetActive(true)
    self._itemCellEffect:SetActive(false)
    self._itemCellGet:SetActive(false)
    LogError("MainPage:RefreshTabCell", "Status Error!")
  end
end

function ItemCell:OnItemCellClicked()
  if self._data.status == self._bm:GetSAnniversaryShareInfoDef().UNLOCKED then
    if self._bm:GetIsOpen() then
      self._bm:SendCFetchShareAward(self._data.id)
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100490)
    end
  else
    local width, height = self._itemCell:GetRectSize()
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._item
      })
      tipsDialog:SetTipsPosition(width, height, self._itemCell:GetLocalPointInUiRootPanel())
    end
  end
end

return ItemCell
