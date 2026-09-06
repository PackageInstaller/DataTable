local CardCell = class("CardCell", Dialog)
CardCell.AssetBundleName = "ui/layouts.activityeleven"
CardCell.AssetName = "ActivityElevenTicketCellItem"

function CardCell:Ctor(...)
  CardCell.super.Ctor(self, ...)
  self._item = nil
  self._isGoldCard = false
  self._cardBackCanClick = true
end

function CardCell:OnCreate()
  self._cardBack = self:GetChild("Back")
  self._cardTxt = self:GetChild("Txt")
  self._itemCell = self:GetChild("Panel/ItemCell")
  self._itemFrame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._itemCount = self:GetChild("Panel/ItemCell/_Count")
  self._cardBack:Subscribe_PointerClickEvent(self.OnCellBackClicked, self)
  self._itemCell:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

function CardCell:OnDestroy()
end

function CardCell:RefreshCell(data)
  self._data = data
  self._item = data.item
  self._index = data.index
  self._state = data.state
  if self._state == "HaveGoldCard" then
    self._cardBackCanClick = false
    self._data.state = "ToFace"
    self:GetRootWindow():SetAnimatorTrigger("HaveGoldCard")
  elseif self._state == "HaveNormalCard" then
    self._cardBackCanClick = false
    self._data.state = "ToFace"
    self:GetRootWindow():SetAnimatorTrigger("HaveNormalCard")
  elseif self._state == "ToBack" then
    self._cardBackCanClick = true
    self._cardBack:SetActive(true)
  elseif self._state == "ToFace" then
    self._cardBackCanClick = false
    self._cardBack:SetActive(false)
    self._cardTxt:SetText(self._item:GetName())
    self._itemCount:SetText(NumberManager.GetShowNumber(self._item:GetCount()))
    self._itemIcon:SetSprite(self._item:GetIcon().assetBundle, self._item:GetIcon().assetName)
    self._itemFrame:SetSprite(self._item:GetPinJiImage().assetBundle, self._item:GetPinJiImage().assetName)
  end
end

function CardCell:OnAnimationStateExit(handle, stateName, normalizedTime)
  if stateName == "HaveGoldCard" then
    self:RefreshCell(self._data)
    self._delegate:OnOpenCardAnimationEnd()
    self._delegate:OnOneGoldCardToFace()
  elseif stateName == "HaveNormalCard" then
    self:RefreshCell(self._data)
    self._delegate:OnOpenCardAnimationEnd()
  elseif stateName == "ClearCard" then
    self:RefreshCell(self._data)
    self._delegate:OnClearCardAnimationEnd()
  end
end

function CardCell:OnEvent(eventName, arg)
  if eventName == "ClearAllCard" then
    self._cardBackCanClick = false
    self._data.state = "ToBack"
    self._cardBack:SetActive(true)
    self:GetRootWindow():PlayAnimation("ClearCard")
  elseif eventName == "RefreshOneCell" and self._index == arg.index then
    self:RefreshCell(arg.data[arg.index])
  end
end

function CardCell:OnCellBackClicked()
  if not NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DoubleElevenActivityID):GetIsOpen() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100410)
    return
  end
  if self._cardBackCanClick == false then
    return
  end
  LogInfo("CardCell", "The Card " .. self._index .. " Clicked.")
  self._delegate:OnOneCardClicked(self._index)
end

function CardCell:OnItemCellClicked()
  local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if dialog then
    dialog:Init({
      item = self._item
    })
  end
end

return CardCell
