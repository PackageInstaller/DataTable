local RoleSkinListRewardCell = class("RoleSkinListRewardCell", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
RoleSkinListRewardCell.AssetBundleName = "ui/layouts.baseshop"
RoleSkinListRewardCell.AssetName = "FashionShopListRewardCell"

function RoleSkinListRewardCell:Ctor(...)
  RoleSkinListRewardCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function RoleSkinListRewardCell:OnCreate()
  self._name = self:GetChild("Back/Txt1")
  self._commitBtn = self:GetChild("Back/GetBtn")
  self._commitBtn_text = self:GetChild("Back/GetBtn/_Text")
  self._difficultyTxt = self:GetChild("Back/Difficulty")
  self._itemCell = {}
  for i = 1, 3 do
    self._itemCell[i] = {}
    self._itemCell[i].cell = self:GetChild("Back/ItemFrame/ItemCell" .. i)
    self._itemCell[i].icon = self:GetChild("Back/ItemFrame/ItemCell" .. i .. "/_BackGround/Icon")
    self._itemCell[i].frame = self:GetChild("Back/ItemFrame/ItemCell" .. i .. "/_BackGround/Frame")
    self._itemCell[i].count = self:GetChild("Back/ItemFrame/ItemCell" .. i .. "/_Count")
    self._itemCell[i].cell:Subscribe_PointerClickEvent(function()
      self:OnItemClicked(i)
    end)
  end
  self._itemPanel = self:GetChild("Back/ItemFrame")
  self._commitBtn:Subscribe_PointerClickEvent(self.OnCommitClick, self)
end

function RoleSkinListRewardCell:OnDestroy()
end

function RoleSkinListRewardCell:RefreshCell(data)
  self._name:SetText(TextManager.GetText(data.recorder.bonusnameId))
  self._commitBtn:SetInteractable(data.state == 1)
  if data.state == 2 then
    self._commitBtn_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1900))
  else
    self._commitBtn_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1899))
  end
  self._itemList = data.items
  for i = 1, 3 do
    local item = self._itemList[i].value
    local image = item:GetIcon()
    self._itemCell[i].icon:SetSprite(image.assetBundle, image.assetName)
    image = item:GetPinJiImage()
    self._itemCell[i].frame:SetSprite(image.assetBundle, image.assetName)
    self._itemCell[i].count:SetText(NumberManager.GetShowNumber(item:GetCount()))
    self._itemCell[i].item = item
  end
  local conditions = data.recorder.conditions
  local current = NekoData.BehaviorManager.BM_SkinList:GetCurrentSkinNum()
  if conditions < current then
    current = conditions
  end
  self._difficultyTxt:SetText(tostring(current) .. "/" .. tostring(conditions))
end

function RoleSkinListRewardCell:OnCommitClick()
  if self._cellData.state == 1 then
    self._delegate:OnCommitClick(self._cellData.recorder.id)
  end
end

function RoleSkinListRewardCell:OnItemClicked(index)
  local width, height = self._itemCell[index].cell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._itemCell[index].item
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell[index].cell:GetLocalPointInUiRootPanel())
  end
end

return RoleSkinListRewardCell
