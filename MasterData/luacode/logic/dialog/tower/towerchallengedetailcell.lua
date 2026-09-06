local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local TowerChallengeDetailCell = class("TowerChallengeDetailCell", Dialog)
TowerChallengeDetailCell.AssetBundleName = "ui/layouts.mainline"
TowerChallengeDetailCell.AssetName = "TowerDetailItemCell"

function TowerChallengeDetailCell:Ctor(...)
  TowerChallengeDetailCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function TowerChallengeDetailCell:OnCreate()
  self._itemCell = self:GetChild("ItemCell")
  self._itemFrame = self:GetChild("ItemCell/_BackGround/Frame")
  self._itemImg = self:GetChild("ItemCell/_BackGround/Icon")
  self._itemSelect = self:GetChild("ItemCell/_BackGround/Select")
  self._itemNum = self:GetChild("ItemCell/_Count")
  self._itemNum:SetActive(false)
  self._itemCell:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
end

function TowerChallengeDetailCell:OnDestroy()
end

function TowerChallengeDetailCell:RefreshCell(data)
  self._id = data.id
  local item = Item.Create(data.id)
  local imageRecord = item:GetIcon()
  self._itemImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function TowerChallengeDetailCell:OnItemCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(self._id)
    })
    local width, height = self._itemCell:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._itemCell:GetLocalPointInUiRootPanel())
  end
  if self._delegate.AssetName ~= "TowerEventBattle" then
    self._delegate:OnItemCellClick()
  end
end

function TowerChallengeDetailCell:OnEvent(eventName, arg)
  if eventName == "ChangeSelectItem" then
    if self._id == arg then
      self._itemSelect:SetActive(true)
    else
      self._itemSelect:SetActive(false)
    end
  end
end

return TowerChallengeDetailCell
