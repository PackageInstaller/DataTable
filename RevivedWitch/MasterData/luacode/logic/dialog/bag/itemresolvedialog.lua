-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/itemresolvedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemResolveDialog = class("ItemResolveDialog", Dialog)
ItemResolveDialog.AssetBundleName = "ui/layouts.bag"
ItemResolveDialog.AssetName = "SellItemSecondConfirm"
local Item = require("logic.manager.experimental.types.item")
ItemResolveDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemResolveDialog
  ((ItemResolveDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

ItemResolveDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._selectNumTxt = self:GetChild("Num/Num")
  self._getNumTxt = self:GetChild("Price/Num")
  self._getIcon = self:GetChild("Price/Icon")
  self._slideAdd = self:GetChild("SlidingArea/Add")
  self._slideReduce = self:GetChild("SlidingArea/Reduce")
  self._slideBar = self:GetChild("SlidingArea/HandleScrollbar")
  self._slideBarProgress = self:GetChild("SlidingArea/HandleScrollbar/__Sliding Area/Progress")
  ;
  (self._slideBar):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:OnScrollbarValueChange()
  end
)
  ;
  (self._slideAdd):Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  ;
  (self._slideReduce):Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  ;
  (self._slideAdd):Subscribe_BeginLongPressEvent(self.OnAddBeginLongPress, self)
  ;
  (self._slideAdd):Subscribe_LongPressEvent(self.OnAddLongPress, self)
  ;
  (self._slideAdd):Subscribe_EndLongPressEvent(self.OnAddEndLongPress, self)
  ;
  (self._slideAdd):Subscribe_CancelLongPressEvent(self.OnAddCancelLongPress, self)
  ;
  (self._slideReduce):Subscribe_BeginLongPressEvent(self.OnReduceBeginLongPress, self)
  ;
  (self._slideReduce):Subscribe_LongPressEvent(self.OnReduceLongPress, self)
  ;
  (self._slideReduce):Subscribe_EndLongPressEvent(self.OnReduceEndLongPress, self)
  ;
  (self._slideReduce):Subscribe_CancelLongPressEvent(self.OnReduceCancelLongPress, self)
  ;
  (self._icon):Subscribe_PointerClickEvent(self.OnIconClicked, self)
  self._cancleBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  ;
  (self._cancleBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

ItemResolveDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

ItemResolveDialog.Init = function(self, item)
  -- function num : 0_3
  self._item = item
  self._itemId = item:GetID()
  local attrCfg = item:GetItemAttr()
  self._selectNum = 1
  self._maxSelectNum = item:GetCount()
  self._getItemId = (attrCfg.resolvegetitem)[1]
  self._getNum = (attrCfg.resolvegetitemnum)[1]
  self:RefreseUIInfo(item)
  self:RefreshSlideState()
end

ItemResolveDialog.RefreseUIInfo = function(self, item)
  -- function num : 0_4 , upvalues : Item
  local imageRecord = item:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local getItem = (Item.Create)(self._getItemId)
  local imageRecord = getItem:GetIcon()
  ;
  (self._getIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

ItemResolveDialog.RefreshSlideState = function(self, currentRate)
  -- function num : 0_5 , upvalues : _ENV
  if currentRate then
    self._selectNum = (math.floor)(self._maxSelectNum * (currentRate + 0.001))
    self._selectNum = (math.max)(self._selectNum, 0)
  end
  ;
  (self._selectNumTxt):SetText(self._selectNum)
  if self._selectNum == 0 then
    (self._confirmBtn):SetInteractable(false)
  else
    ;
    (self._confirmBtn):SetInteractable(true)
  end
  ;
  (self._getNumTxt):SetNumber(self._selectNum * self._getNum)
  self._slideChange = true
end

ItemResolveDialog.OnScrollbarValueChange = function(self)
  -- function num : 0_6
  if not self._isAddOrReduceClick then
    self:RefreshSlideState((self._slideBar):GetScrollValue())
  end
end

ItemResolveDialog.ChangeSelectNumAddOrReduce = function(self, bAdd)
  -- function num : 0_7 , upvalues : _ENV
  if bAdd then
    self._selectNum = self._selectNum + 1
    self._selectNum = (math.min)(self._selectNum, self._maxSelectNum)
  else
    self._selectNum = self._selectNum - 1
    self._selectNum = (math.max)(self._selectNum, 0)
  end
  self:RefreshSlideState()
end

ItemResolveDialog.OnAddBtnClicked = function(self)
  -- function num : 0_8
  self._isAddOrReduceClick = true
  self:ChangeSelectNumAddOrReduce(true)
  self._isAddOrReduceClick = false
end

ItemResolveDialog.OnAddBeginLongPress = function(self)
  -- function num : 0_9
  self._isAddOrReduceClick = true
end

ItemResolveDialog.OnAddLongPress = function(self)
  -- function num : 0_10
  self:ChangeSelectNumAddOrReduce(true)
end

ItemResolveDialog.OnAddEndLongPress = function(self)
  -- function num : 0_11
  self._isAddOrReduceClick = false
end

ItemResolveDialog.OnAddCancelLongPress = function(self)
  -- function num : 0_12
  self._isAddOrReduceClick = false
end

ItemResolveDialog.OnReduceBtnClicked = function(self)
  -- function num : 0_13
  self._isAddOrReduceClick = true
  self:ChangeSelectNumAddOrReduce(false)
  self._isAddOrReduceClick = false
end

ItemResolveDialog.OnReduceBeginLongPress = function(self)
  -- function num : 0_14
  self._isAddOrReduceClick = true
end

ItemResolveDialog.OnReduceLongPress = function(self)
  -- function num : 0_15
  self:ChangeSelectNumAddOrReduce(false)
end

ItemResolveDialog.OnReduceEndLongPress = function(self)
  -- function num : 0_16
  self._isAddOrReduceClick = false
end

ItemResolveDialog.OnReduceCancelLongPress = function(self)
  -- function num : 0_17
  self._isAddOrReduceClick = false
end

ItemResolveDialog.OnBackBtnClicked = function(self)
  -- function num : 0_18
  self:Destroy()
end

ItemResolveDialog.ConfirmDecompose = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if self._selectNum > 0 then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.item.cdecomposeitems")
    protocol.itemId = self._itemId
    protocol.ItemNum = self._selectNum
    protocol:Send()
    self:Destroy()
  end
end

ItemResolveDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if (self._item):IsUniqueEquip() then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(135, nil, function()
    -- function num : 0_20_0 , upvalues : self
    self:ConfirmDecompose()
  end
, {}, nil, {})
  else
    self:ConfirmDecompose()
  end
end

ItemResolveDialog.OnUpdate = function(self)
  -- function num : 0_21
  if self._slideChange then
    self._slideChange = false
    local rate = 0
    if self._maxSelectNum ~= 0 then
      rate = self._selectNum / self._maxSelectNum
    end
    ;
    (self._slideBar):SetScrollValue(rate)
    ;
    (self._slideBarProgress):SetFillAmount((self._slideBar):GetScrollValue())
  end
end

ItemResolveDialog.OnIconClicked = function(self)
  -- function num : 0_22 , upvalues : _ENV
  local width, height = (self._icon):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    local temp = {item = self._item}
    tipsDialog:Init(temp)
    tipsDialog:SetTipsPosition(width, height, (self._icon):GetLocalPointInUiRootPanel())
  end
end

return ItemResolveDialog

