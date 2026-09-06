local ItemResolveDialog = class("ItemResolveDialog", Dialog)
ItemResolveDialog.AssetBundleName = "ui/layouts.bag"
ItemResolveDialog.AssetName = "SellItemSecondConfirm"
local Item = require("logic.manager.experimental.types.item")

function ItemResolveDialog:Ctor(...)
  ItemResolveDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function ItemResolveDialog:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._selectNumTxt = self:GetChild("Num/Num")
  self._getNumTxt = self:GetChild("Price/Num")
  self._getIcon = self:GetChild("Price/Icon")
  self._slideAdd = self:GetChild("SlidingArea/Add")
  self._slideReduce = self:GetChild("SlidingArea/Reduce")
  self._slideBar = self:GetChild("SlidingArea/HandleScrollbar")
  self._slideBarProgress = self:GetChild("SlidingArea/HandleScrollbar/__Sliding Area/Progress")
  self._slideBar:Subscribe_ValueChangedEvent(function()
    self:OnScrollbarValueChange()
  end)
  self._slideAdd:Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  self._slideReduce:Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  self._slideAdd:Subscribe_BeginLongPressEvent(self.OnAddBeginLongPress, self)
  self._slideAdd:Subscribe_LongPressEvent(self.OnAddLongPress, self)
  self._slideAdd:Subscribe_EndLongPressEvent(self.OnAddEndLongPress, self)
  self._slideAdd:Subscribe_CancelLongPressEvent(self.OnAddCancelLongPress, self)
  self._slideReduce:Subscribe_BeginLongPressEvent(self.OnReduceBeginLongPress, self)
  self._slideReduce:Subscribe_LongPressEvent(self.OnReduceLongPress, self)
  self._slideReduce:Subscribe_EndLongPressEvent(self.OnReduceEndLongPress, self)
  self._slideReduce:Subscribe_CancelLongPressEvent(self.OnReduceCancelLongPress, self)
  self._icon:Subscribe_PointerClickEvent(self.OnIconClicked, self)
  self._cancleBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._cancleBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function ItemResolveDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ItemResolveDialog:Init(item)
  self._item = item
  self._itemId = item:GetID()
  local attrCfg = item:GetItemAttr()
  self._selectNum = 1
  self._maxSelectNum = item:GetCount()
  self._getItemId = attrCfg.resolvegetitem[1]
  self._getNum = attrCfg.resolvegetitemnum[1]
  self:RefreseUIInfo(item)
  self:RefreshSlideState()
end

function ItemResolveDialog:RefreseUIInfo(item)
  local imageRecord = item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local getItem = Item.Create(self._getItemId)
  local imageRecord = getItem:GetIcon()
  self._getIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function ItemResolveDialog:RefreshSlideState(currentRate)
  if currentRate then
    self._selectNum = math.floor(self._maxSelectNum * (currentRate + 0.001))
    self._selectNum = math.max(self._selectNum, 0)
  end
  self._selectNumTxt:SetText(self._selectNum)
  if self._selectNum == 0 then
    self._confirmBtn:SetInteractable(false)
  else
    self._confirmBtn:SetInteractable(true)
  end
  self._getNumTxt:SetNumber(self._selectNum * self._getNum)
  self._slideChange = true
end

function ItemResolveDialog:OnScrollbarValueChange()
  if not self._isAddOrReduceClick then
    self:RefreshSlideState(self._slideBar:GetScrollValue())
  end
end

function ItemResolveDialog:ChangeSelectNumAddOrReduce(bAdd)
  if bAdd then
    self._selectNum = self._selectNum + 1
    self._selectNum = math.min(self._selectNum, self._maxSelectNum)
  else
    self._selectNum = self._selectNum - 1
    self._selectNum = math.max(self._selectNum, 0)
  end
  self:RefreshSlideState()
end

function ItemResolveDialog:OnAddBtnClicked()
  self._isAddOrReduceClick = true
  self:ChangeSelectNumAddOrReduce(true)
  self._isAddOrReduceClick = false
end

function ItemResolveDialog:OnAddBeginLongPress()
  self._isAddOrReduceClick = true
end

function ItemResolveDialog:OnAddLongPress()
  self:ChangeSelectNumAddOrReduce(true)
end

function ItemResolveDialog:OnAddEndLongPress()
  self._isAddOrReduceClick = false
end

function ItemResolveDialog:OnAddCancelLongPress()
  self._isAddOrReduceClick = false
end

function ItemResolveDialog:OnReduceBtnClicked()
  self._isAddOrReduceClick = true
  self:ChangeSelectNumAddOrReduce(false)
  self._isAddOrReduceClick = false
end

function ItemResolveDialog:OnReduceBeginLongPress()
  self._isAddOrReduceClick = true
end

function ItemResolveDialog:OnReduceLongPress()
  self:ChangeSelectNumAddOrReduce(false)
end

function ItemResolveDialog:OnReduceEndLongPress()
  self._isAddOrReduceClick = false
end

function ItemResolveDialog:OnReduceCancelLongPress()
  self._isAddOrReduceClick = false
end

function ItemResolveDialog:OnBackBtnClicked()
  self:Destroy()
end

function ItemResolveDialog:ConfirmDecompose()
  if self._selectNum > 0 then
    local protocol = LuaNetManager.CreateProtocol("protocol.item.cdecomposeitems")
    protocol.itemId = self._itemId
    protocol.ItemNum = self._selectNum
    protocol:Send()
    self:Destroy()
  end
end

function ItemResolveDialog:OnConfirmBtnClicked()
  if self._item:IsUniqueEquip() then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(135, nil, function()
      self:ConfirmDecompose()
    end, {}, nil, {})
  else
    self:ConfirmDecompose()
  end
end

function ItemResolveDialog:OnUpdate()
  if self._slideChange then
    self._slideChange = false
    local rate = 0
    if self._maxSelectNum ~= 0 then
      rate = self._selectNum / self._maxSelectNum
    end
    self._slideBar:SetScrollValue(rate)
    self._slideBarProgress:SetFillAmount(self._slideBar:GetScrollValue())
  end
end

function ItemResolveDialog:OnIconClicked()
  local width, height = self._icon:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    local temp = {
      item = self._item
    }
    tipsDialog:Init(temp)
    tipsDialog:SetTipsPosition(width, height, self._icon:GetLocalPointInUiRootPanel())
  end
end

return ItemResolveDialog
