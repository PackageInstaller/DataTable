-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/limitedinvestmenttabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CLimitedInvestment = (BeanManager.GetTableByName)("welfare.climitedinvestment")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local LimitedInvestmentTabCell = class("LimitedInvestmentTabCell", Dialog)
LimitedInvestmentTabCell.AssetBundleName = "ui/layouts.welfare"
LimitedInvestmentTabCell.AssetName = "LimitedTimeInvestment"
LimitedInvestmentTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LimitedInvestmentTabCell
  ((LimitedInvestmentTabCell.super).Ctor)(self, ...)
  self._init = false
  self._lastActId = nil
  self._records = {}
  self._task = nil
end

LimitedInvestmentTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._tipBtn = self:GetChild("BackImage/DetailBtn")
  self._leftTime = self:GetChild("BackImage/TxtFrame/Time")
  self._notPurchased_panel = self:GetChild("BackImage/Frame")
  self._cells = {}
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

      (self._cells)[i] = {img = self:GetChild("BackImage/Frame/Buy" .. i .. "/Img"), totalNums = self:GetChild("BackImage/Frame/Buy" .. i .. "/TxtFrame/Txt1"), costAndGivebackTxt = self:GetChild("BackImage/Frame/Buy" .. i .. "/TxtFrame/Txt2"), buyBtn = self:GetChild("BackImage/Frame/Buy" .. i .. "/BuyBtn"), buyBtnTxt = self:GetChild("BackImage/Frame/Buy" .. i .. "/BuyBtn/Text")}
      ;
      (((self._cells)[i]).buyBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnBuyBtnClicked(i)
  end
)
    end
  end
  self._purchased_panel = self:GetChild("BackImage/PurchasedFrame")
  self._purchased_panel_img = self:GetChild("BackImage/PurchasedFrame/Img")
  self._purchased_panel_notend = self:GetChild("BackImage/PurchasedFrame/cell")
  self._purchased_panel_receiveTxt = self:GetChild("BackImage/PurchasedFrame/cell/TxtFrame/Txt1")
  self._purchased_panel_leftTimes = self:GetChild("BackImage/PurchasedFrame/cell/TxtFrame/Txt2")
  self._purchased_panel_getBtn = self:GetChild("BackImage/PurchasedFrame/cell/GetBtn")
  self._purchased_panel_gotTxt = self:GetChild("BackImage/PurchasedFrame/cell/GetText")
  self._purchased_panel_end = self:GetChild("BackImage/PurchasedFrame/EndTxt")
  ;
  (self._tipBtn):Subscribe_PointerClickEvent(self.OnTipBtnClick, self)
  ;
  (self._purchased_panel_getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
  ;
  (self:GetChild("BackImage/DetailBtn/Txt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1897))
  ;
  (self:GetChild("BackImage/PurchasedFrame/cell/GetBtn/_Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1899))
  ;
  (self:GetChild("BackImage/PurchasedFrame/cell/GetText")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1900))
  ;
  (self:GetChild("BackImage/PurchasedFrame/EndTxt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1901))
end

LimitedInvestmentTabCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

LimitedInvestmentTabCell.RefreshTabCell = function(self, refresh)
  -- function num : 0_3 , upvalues : _ENV, CLimitedInvestment, CImagePathTable
  local protocolData = ((NekoData.BehaviorManager).BM_Welfare):GetLimitedInvestmentInfo()
  if protocolData and (not self._init or refresh) then
    self._protocolData = protocolData
    if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).LimitedInvestmentOpen) then
      ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).LimitedInvestmentOpen)
    end
    if not self._task then
      self._task = (GameTimer.AddTask)(0, 1, function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    local strId, par = nil, nil
    local lefttime = (self._protocolData).actLeftTime // 1000
    if lefttime < 86400 then
      strId = 1896
      par = lefttime // 3600
    else
      strId = 1892
      par = lefttime // 86400
    end
    ;
    (self._leftTime):SetText(((NekoData.BehaviorManager).BM_Message):GetString(strId, {par}))
  end
)
    end
    if not self._lastActId or self._lastActId ~= (self._protocolData).actId then
      for k,v in pairs(self._records) do
        -- DECOMPILER ERROR at PC54: Confused about usage of register: R8 in 'UnsetPending'

        (self._records)[k] = nil
      end
      self._lastActId = (self._protocolData).actId
      local allIds = CLimitedInvestment:GetAllIds()
      local len = #allIds
      for i = 1, len do
        local id = allIds[i]
        local record = CLimitedInvestment:GetRecorder(id)
        if record.activeID == self._lastActId then
          if id % 2 == 0 then
            id = 2
          else
            id = 1
          end
          -- DECOMPILER ERROR at PC84: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (self._records)[id] = record
        end
      end
    end
    do
      local currentChannel = (self._protocolData).currentChannel
      if currentChannel == 0 then
        (self._notPurchased_panel):SetActive(true)
        ;
        (self._purchased_panel):SetActive(false)
        for i = 1, 2 do
          local record = (self._records)[i]
          if not record then
            LogErrorFormat("LimitedInvestmentTabCell", "record with id %s is not exist in climitedinvestment", i)
          end
          local nodeMap = (self._cells)[i]
          if not CImagePathTable:GetRecorder(record.picID) then
            local imageRecord = DataCommon.DefaultImageAsset
          end
          ;
          (nodeMap.img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          local getMax = record.nums * record.rItemsNums
          ;
          (nodeMap.totalNums):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1889, {record.nums, getMax}))
          ;
          (nodeMap.costAndGivebackTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1890, {record.pItemsNums, record.rItemsNums}))
          ;
          (nodeMap.buyBtnTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1898, {record.pItemsNums}))
        end
      else
        do
          ;
          (self._notPurchased_panel):SetActive(false)
          ;
          (self._purchased_panel):SetActive(true)
          ;
          (self._purchased_panel_notend):SetActive(true)
          ;
          (self._purchased_panel_end):SetActive(false)
          local id = nil
          if currentChannel % 2 == 0 then
            id = 2
          else
            id = 1
          end
          local record = (self._records)[id]
          if not record then
            LogErrorFormat("LimitedInvestmentTabCell", "record with id %s is not exist in climitedinvestment", currentChannel)
          end
          if not CImagePathTable:GetRecorder(record.picID) then
            local imageRecord = DataCommon.DefaultImageAsset
          end
          ;
          (self._purchased_panel_img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          local receiveItemNum = record.rItemsNums
          local leftTimes = (self._protocolData).leftTimes
          if leftTimes == 1 then
            receiveItemNum = receiveItemNum + record.pItemsNums
          end
          do
            local strId = nil
            if (self._protocolData).todayFetched == 0 then
              strId = 1893
            else
              strId = 1894
            end
            ;
            (self._purchased_panel_receiveTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(strId, {receiveItemNum}))
            ;
            (self._purchased_panel_leftTimes):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1895, {leftTimes}))
            ;
            (self._purchased_panel_getBtn):SetActive((self._protocolData).todayFetched == 0)
            ;
            (self._purchased_panel_getBtn):SetInteractable((self._protocolData).todayFetched == 0)
            ;
            (self._purchased_panel_gotTxt):SetActive((self._protocolData).todayFetched == 1)
            if self._lastActId and not protocolData then
              (self._notPurchased_panel):SetActive(false)
              ;
              (self._purchased_panel):SetActive(true)
              ;
              (self._purchased_panel_notend):SetActive(false)
              ;
              (self._purchased_panel_end):SetActive(true)
              if self._task then
                (GameTimer.RemoveTask)(self._task)
                self._task = nil
              end
            end
            -- DECOMPILER ERROR: 5 unprocessed JMP targets
          end
        end
      end
    end
  end
end

LimitedInvestmentTabCell.OnTipBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(1)
end

LimitedInvestmentTabCell.OnGetBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cfetchinvestaward")
  protocol:Send()
end

local BuyInvest = function(record)
  -- function num : 0_6 , upvalues : _ENV
  local count = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(record.payItems)
  if record.pItemsNums <= count then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cbuyinvestprogram")
    protocol.channelId = record.id
    protocol:Send()
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(15, nil, function()
    -- function num : 0_6_0 , upvalues : _ENV
    ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(4)
  end
, {}, nil, {})
    end
  end
end

LimitedInvestmentTabCell.OnBuyBtnClicked = function(self, index)
  -- function num : 0_7 , upvalues : _ENV, BuyInvest
  local record = (self._records)[index]
  local lefttime = (self._protocolData).actLeftTime // 1000
  local leftDays = lefttime // 86400
  LogInfoFormat("LimitedInvestmentTabCell", "leftDays = %s", leftDays)
  if leftDays < record.nums then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(143, {record.pItemsNums}, function()
    -- function num : 0_7_0 , upvalues : BuyInvest, record
    BuyInvest(record)
  end
, {}, nil, {})
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(141, {record.pItemsNums}, function()
    -- function num : 0_7_1 , upvalues : BuyInvest, record
    BuyInvest(record)
  end
, {}, nil, {})
  end
end

return LimitedInvestmentTabCell

