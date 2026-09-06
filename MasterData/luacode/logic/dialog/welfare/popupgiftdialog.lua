local CPopUpGift = BeanManager.GetTableByName("topup.cpopupgift")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local timeutils = require("logic.utils.timeutils")
local PopUpGiftDialog = class("PopUpGiftDialog", Dialog)
PopUpGiftDialog.AssetBundleName = "ui/layouts.welfare"
PopUpGiftDialog.AssetName = "Promotions"

function PopUpGiftDialog:Ctor(...)
  PopUpGiftDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function PopUpGiftDialog:OnCreate()
  self._closeBtn = self:GetChild("AnimationKey/CloseBtn")
  self._mainTitle = self:GetChild("AnimationKey/Title1")
  self._subTitle = self:GetChild("AnimationKey/Title2")
  self._saleBtn = self:GetChild("AnimationKey/SaleBtn")
  self._saleBtn_text = self:GetChild("AnimationKey/SaleBtn/Text")
  self._leftTime = self:GetChild("AnimationKey/Frame/TimeTxt")
  self._panel = self:GetChild("AnimationKey/Frame/Back")
  self._frame = self:GetChild("AnimationKey/Frame")
  self._goodsFrame = TableFrame.Create(self._panel, self, false, false, false)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._saleBtn:Subscribe_PointerClickEvent(self.OnSaleBtnClicked, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  self:Init()
  LuaNotificationCenter.AddObserver(self, self.OnRefreshPopUpGift, Common.n_RefreshPopUpGift, nil)
  self:GetChild("AnimationKey/Frame/Back2/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1982))
end

function PopUpGiftDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._timer then
    GameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
  if self._goodsFrame then
    self._goodsFrame:Destroy()
  end
end

function PopUpGiftDialog:OnRefreshPopUpGift()
  if self._record and not NekoData.BehaviorManager.BM_Activity:GetPopUpGift() then
    if self._timer then
      GameTimer.RemoveTask(self._timer)
      self._timer = nil
    end
    self._leftTime:SetActive(false)
  elseif NekoData.BehaviorManager.BM_Activity:GetPopUpGift() then
    self:Init()
  end
end

function PopUpGiftDialog:Init()
  if self._timer then
    GameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
  self._data = NekoData.BehaviorManager.BM_Activity:GetPopUpGift()
  if not self._data or next(self._data) == nil then
    LogError("Data is nil or Data Count Eq 0.")
    return
  end
  self._record = NekoData.BehaviorManager.BM_Activity:GetPopUpGiftRecord()
  if not self._record then
    LogErrorFormat("PopUpGiftDialog", "Can not find record by activityId: %s in cpopupgift", self._data.firstOpenActivityId)
    return
  end
  local imageRecord = CImagePathTable:GetRecorder(self._record.titleID) or DataCommon.DefaultImageAsset
  self._mainTitle:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = CImagePathTable:GetRecorder(self._record.smalltitle1ID) or DataCommon.DefaultImageAsset
  self._subTitle:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._awardData = {}
  self._record = NekoData.BehaviorManager.BM_Activity:GetPopUpGiftRecord()
  for i, v in ipairs(self._record.items) do
    local item = Item.Create(v)
    item:SetCount(self._record.nums[i])
    table.insert(self._awardData, item)
  end
  self._goodsFrame:ReloadAllCell()
  local helfFrame = self._goodsFrame:GetTotalLength() / 2
  local anchor, offset = self._panel:GetWidth()
  local midFrameTarget = offset / 2 - helfFrame
  self._goodsFrame:SetMargin(midFrameTarget, 0)
  self._goodsFrame:ReloadAllCell()
  if self._data.data then
    self._saleBtn_text:SetText(NekoData.BehaviorManager.BM_Message:GetMoneySymbol(self._data.data.moneyType) .. SdkManager.GetPrice(self._data.data.price))
    self._timer = GameTimer.AddTask(0, 1, function()
      local day = self._data.data.leftTime // 1000 // 3600 // 24
      local hour = (self._data.data.leftTime - day * 24 * 3600 * 1000) // 1000 // 3600
      local minute = (self._data.data.leftTime - day * 24 * 3600 * 1000 - hour * 3600 * 1000) // 1000 // 60
      local second = (self._data.data.leftTime - day * 24 * 3600 * 1000 - hour * 3600 * 1000 - minute * 60 * 1000) // 1000
      local str = ""
      if 0 < day then
        str = NekoData.BehaviorManager.BM_Message:GetString(2033, {
          day,
          hour,
          minute,
          second
        })
      elseif 0 < hour then
        str = NekoData.BehaviorManager.BM_Message:GetString(2034, {
          hour,
          minute,
          second
        })
      elseif 0 < minute then
        str = NekoData.BehaviorManager.BM_Message:GetString(2035, {minute, second})
      else
        str = NekoData.BehaviorManager.BM_Message:GetString(2036, {second})
      end
      self._leftTime:SetText(str)
    end)
  elseif not self._sendProtocol then
    local cmd = LuaNetManager.CreateProtocol("protocol.activity.callowpopupgift")
    cmd.activityID = self._data.firstOpenActivityId
    cmd:Send()
    self._sendProtocol = true
  end
end

function PopUpGiftDialog:OnSaleBtnClicked()
  if self._data.data then
    local cmd = LuaNetManager.CreateProtocol("protocol.charge.cbuydiamond")
    cmd.goodId = self._data.data.goodsId
    cmd:Send()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100116)
  end
end

function PopUpGiftDialog:OnAnimationStateExit(handle, stateName, normalizedTime)
  if self._willDestroy and stateName == "Promotions" then
    self:Destroy()
  end
end

function PopUpGiftDialog:OnBackBtnClicked()
  if not self._willDestroy then
    self._willDestroy = true
    self._rootWindow:PlayAnimation("Promotions")
  end
end

function PopUpGiftDialog:NumberOfCell(frame, index)
  if frame == self._goodsFrame then
    return #self._awardData
  end
end

function PopUpGiftDialog:CellAtIndex(frame, index)
  if frame == self._goodsFrame then
    return "welfare.popupgiftcell"
  end
end

function PopUpGiftDialog:DataAtIndex(frame, index)
  if frame == self._goodsFrame then
    return self._awardData[index]
  end
end

return PopUpGiftDialog
