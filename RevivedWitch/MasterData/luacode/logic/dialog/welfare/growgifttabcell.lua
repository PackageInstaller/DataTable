-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/growgifttabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CLevelReward = (BeanManager.GetTableByName)("welfare.clevelreward")
local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local GrowGiftTabCell = class("GrowGiftTabCell", Dialog)
GrowGiftTabCell.AssetBundleName = "ui/layouts.welfare"
GrowGiftTabCell.AssetName = "GrowGift"
GrowGiftTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GrowGiftTabCell, _ENV
  ((GrowGiftTabCell.super).Ctor)(self, ...)
  self._init = false
  self._giftList = {}
  self.cellStatus = {Lock = -1, CanNotReceive = 0, Available = 1, Received = 2}
  self.boughtGrowGift = ((NekoData.BehaviorManager).BM_Welfare):IsBoughtGrowGift()
  self.userLevel = ((NekoData.BehaviorManager).BM_Game):GetUserLevel()
end

GrowGiftTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._buyBtn = self:GetChild("BackImage/BuyBtn")
  self._buyBtn_price = self:GetChild("BackImage/BuyBtn/Text")
  self._boughtBtn = self:GetChild("BackImage/Bought")
  self._cellPanel = self:GetChild("BackImage/Frame")
  self._cellFrame = (TableFrame.Create)(self._cellPanel, self, false, true, false)
  self.num1Txt = self:GetChild("BackImage/Num1")
  self.num2Txt = self:GetChild("BackImage/Num2")
  ;
  (self.num1Txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1477))
  ;
  (self.num2Txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1478))
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClick, self)
end

GrowGiftTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._cellFrame):Destroy()
end

GrowGiftTabCell.RefreshTabCell = function(self, refresh, notChangeSlidePos)
  -- function num : 0_3 , upvalues : _ENV, CLevelReward, GuidTypes
  if not self._init or refresh then
    local lastPos = (self._cellFrame):GetCurrentPosition()
    self.boughtGrowGift = ((NekoData.BehaviorManager).BM_Welfare):IsBoughtGrowGift()
    self._growGiftInfo = ((NekoData.BehaviorManager).BM_Welfare):GetGrowGiftInfo()
    if not self._init then
      self._init = true
      local receivedList = {}
      local allIds = CLevelReward:GetAllIds()
      local len = #allIds
      for i = 1, len do
        local received = false
        local id = allIds[i]
        local record = CLevelReward:GetRecorder(id)
        local data = {record = record}
        if not self.boughtGrowGift then
          data.status = (self.cellStatus).Lock
        else
          if record.level <= self.userLevel then
            if ((self._growGiftInfo).getMap)[id] then
              data.status = (self.cellStatus).Received
              received = true
            else
              data.status = (self.cellStatus).Available
            end
          else
            data.status = (self.cellStatus).CanNotReceive
          end
        end
        if not received then
          (table.insert)(self._giftList, data)
        else
          ;
          (table.insert)(receivedList, data)
        end
      end
      for i,v in ipairs(receivedList) do
        (table.insert)(self._giftList, v)
      end
    else
      do
        for i,v in ipairs(self._giftList) do
          if not self.boughtGrowGift then
            v.status = (self.cellStatus).Lock
          else
            if (v.record).level <= self.userLevel then
              if ((self._growGiftInfo).getMap)[(v.record).id] then
                v.status = (self.cellStatus).Received
              else
                v.status = (self.cellStatus).Available
              end
            else
              v.status = (self.cellStatus).CanNotReceive
            end
          end
        end
        do
          ;
          (self._cellFrame):ReloadAllCell()
          if notChangeSlidePos and lastPos then
            (self._cellFrame):MoveToAssignedPos(lastPos)
          end
          ;
          (self._cellFrame):MoveToLeft()
          do
            local value = ((NekoData.BehaviorManager).BM_Welfare):IsBoughtGrowGift()
            if value then
              (self._buyBtn):SetActive(false)
              ;
              (self._boughtBtn):SetActive(true)
            else
              ;
              (self._buyBtn):SetActive(true)
              ;
              (self._buyBtn_price):SetText((self._growGiftInfo).chargeNum)
              ;
              (self._boughtBtn):SetActive(false)
            end
            local tag = ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuidTypes.LEVEL_GIFT)
            if not tag or tag == 0 then
              ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuidTypes.LEVEL_GIFT, 1)
              ;
              (LuaNotificationCenter.PostNotification)(Common.n_RefreshGrowGift, nil, nil)
            end
          end
        end
      end
    end
  end
end

GrowGiftTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._giftList
end

GrowGiftTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "welfare.growgiftcell"
end

GrowGiftTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._giftList)[index]
end

GrowGiftTabCell.OnBuyBtnClick = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local cmd = (LuaNetManager.CreateProtocol)("protocol.charge.cbuydiamond")
  cmd.goodId = (self._growGiftInfo).goodId
  cmd:Send()
end

return GrowGiftTabCell

