-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/lover/loversendflowersecondconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CSendFlowersDef = (LuaNetManager.GetProtocolDef)("protocol.activity.csendflowers")
local LoverSendFlowerSecondConfirmDialog = class("LoverSendFlowerSecondConfirmDialog", Dialog)
LoverSendFlowerSecondConfirmDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverSendFlowerSecondConfirmDialog.AssetName = "ActivityValentinesCallItemBuy"
LoverSendFlowerSecondConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoverSendFlowerSecondConfirmDialog
  ((LoverSendFlowerSecondConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._sendProtocol = false
end

LoverSendFlowerSecondConfirmDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._numScrollBar = self:GetChild("Num/HandleScrollbar")
  self._numProgress = self:GetChild("Num/HandleScrollbar/__Sliding Area/Progress")
  self._content = self:GetChild("Back/Text1")
  self._willSendNum = self:GetChild("Back/Text2/Num")
  self._totalNum = self:GetChild("Back/Text3/Num")
  self._itemImg = self:GetChild("Back/Text3/Image")
  self._addBtn = self:GetChild("Num/Add")
  self._reduceBtn = self:GetChild("Num/Reduce")
  self._confirmBtn = self:GetChild("ConfirmBtn")
  self._cancelBtn = self:GetChild("CancelBtn")
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  ;
  (self._reduceBtn):Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnCancelBtnClicked, self)
  ;
  (self._numScrollBar):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:OnScrollbarValueChange()
  end
)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSSendFlowers, Common.n_SSendFlowers, nil)
end

LoverSendFlowerSecondConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

LoverSendFlowerSecondConfirmDialog.SetData = function(self, rewardType, isFull)
  -- function num : 0_3 , upvalues : CSendFlowersDef, _ENV, CStringres, Item
  self._isFull = isFull
  self._rewardType = rewardType
  if self._rewardType == CSendFlowersDef.LEFT then
    (self._content):SetText((TextManager.GetText)((CStringres:GetRecorder(1708)).msgTextID))
  else
    if self._rewardType == CSendFlowersDef.RIGTH then
      (self._content):SetText((TextManager.GetText)((CStringres:GetRecorder(1709)).msgTextID))
    end
  end
  self._sendFlowerNum = 1
  ;
  (self._willSendNum):SetText(self._sendFlowerNum)
  self._flowerTotalNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.LoveFlowers)
  local item = (Item.Create)(DataCommon.LoveFlowers)
  local image = item:GetIcon()
  ;
  (self._itemImg):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._totalNum):SetText(self._flowerTotalNum)
end

LoverSendFlowerSecondConfirmDialog.OnAddBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._btnChanging = true
  self._sendFlowerNum = self._sendFlowerNum + 1
  self._sendFlowerNum = (math.min)(self._sendFlowerNum, self._flowerTotalNum)
  self:RefreshSlideState()
  self._btnChanging = false
end

LoverSendFlowerSecondConfirmDialog.OnReduceBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self._btnChanging = true
  self._sendFlowerNum = self._sendFlowerNum - 1
  self._sendFlowerNum = (math.max)(self._sendFlowerNum, 1)
  self:RefreshSlideState()
  self._btnChanging = false
end

LoverSendFlowerSecondConfirmDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._isFull then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(132, nil, function()
    -- function num : 0_6_0 , upvalues : self
    self:SendProtocol()
  end
, {}, nil, {})
  else
    self:SendProtocol()
  end
end

LoverSendFlowerSecondConfirmDialog.SendProtocol = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self._sendFlowerNum > 0 and not self._sendProtocol then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.csendflowers")
    csend.rewardType = self._rewardType
    csend.num = self._sendFlowerNum
    csend:Send()
    self._sendProtocol = true
    local dialog = (DialogManager.GetDialog)("activity.lover.loverflowerlistdialog")
    if dialog then
      dialog:EnterCD()
    end
  end
end

LoverSendFlowerSecondConfirmDialog.OnCancelBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

LoverSendFlowerSecondConfirmDialog.OnScrollbarValueChange = function(self)
  -- function num : 0_9
  if not self._btnChanging then
    self:RefreshSlideState((self._numScrollBar):GetScrollValue())
  end
end

LoverSendFlowerSecondConfirmDialog.RefreshSlideState = function(self, currentRate)
  -- function num : 0_10 , upvalues : _ENV
  if currentRate then
    local changeCount = (math.floor)(self._flowerTotalNum * currentRate) - self._sendFlowerNum
    ;
    (self._numScrollBar):SetScrollValue(currentRate)
    self._sendFlowerNum = self._sendFlowerNum + changeCount
    self._sendFlowerNum = (math.max)(self._sendFlowerNum, 1)
  else
    do
      do
        local rate = 0
        if self._flowerTotalNum ~= 0 then
          rate = self._sendFlowerNum / self._flowerTotalNum
        end
        ;
        (self._numScrollBar):SetScrollValue(rate)
        ;
        (self._numProgress):SetFillAmount((self._numScrollBar):GetScrollValue())
        ;
        (self._willSendNum):SetText(self._sendFlowerNum)
      end
    end
  end
end

LoverSendFlowerSecondConfirmDialog.OnSSendFlowers = function(self)
  -- function num : 0_11 , upvalues : _ENV
  self._flowerTotalNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.LoveFlowers)
  ;
  (self._totalNum):SetText(self._flowerTotalNum)
  self._sendProtocol = false
  self:Destroy()
end

return LoverSendFlowerSecondConfirmDialog

