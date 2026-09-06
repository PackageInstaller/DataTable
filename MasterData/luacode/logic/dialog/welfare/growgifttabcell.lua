local TableFrame = require("framework.ui.frame.table.tableframe")
local CLevelReward = BeanManager.GetTableByName("welfare.clevelreward")
local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local GrowGiftTabCell = class("GrowGiftTabCell", Dialog)
GrowGiftTabCell.AssetBundleName = "ui/layouts.welfare"
GrowGiftTabCell.AssetName = "GrowGift"

function GrowGiftTabCell:Ctor(...)
  GrowGiftTabCell.super.Ctor(self, ...)
  self._init = false
  self._giftList = {}
  self.cellStatus = {
    Lock = -1,
    CanNotReceive = 0,
    Available = 1,
    Received = 2
  }
  self.boughtGrowGift = NekoData.BehaviorManager.BM_Welfare:IsBoughtGrowGift()
  self.userLevel = NekoData.BehaviorManager.BM_Game:GetUserLevel()
end

function GrowGiftTabCell:OnCreate()
  self._buyBtn = self:GetChild("BackImage/BuyBtn")
  self._buyBtn_price = self:GetChild("BackImage/BuyBtn/Text")
  self._boughtBtn = self:GetChild("BackImage/Bought")
  self._cellPanel = self:GetChild("BackImage/Frame")
  self._cellFrame = TableFrame.Create(self._cellPanel, self, false, true, false)
  self.num1Txt = self:GetChild("BackImage/Num1")
  self.num2Txt = self:GetChild("BackImage/Num2")
  self.num1Txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1477))
  self.num2Txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1478))
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClick, self)
end

function GrowGiftTabCell:OnDestroy()
  self._cellFrame:Destroy()
end

function GrowGiftTabCell:RefreshTabCell(refresh, notChangeSlidePos)
  if not self._init or refresh then
    local lastPos = self._cellFrame:GetCurrentPosition()
    self.boughtGrowGift = NekoData.BehaviorManager.BM_Welfare:IsBoughtGrowGift()
    self._growGiftInfo = NekoData.BehaviorManager.BM_Welfare:GetGrowGiftInfo()
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
          data.status = self.cellStatus.Lock
        elseif record.level <= self.userLevel then
          if self._growGiftInfo.getMap[id] then
            data.status = self.cellStatus.Received
            received = true
          else
            data.status = self.cellStatus.Available
          end
        else
          data.status = self.cellStatus.CanNotReceive
        end
        if not received then
          table.insert(self._giftList, data)
        else
          table.insert(receivedList, data)
        end
      end
      for i, v in ipairs(receivedList) do
        table.insert(self._giftList, v)
      end
    else
      for i, v in ipairs(self._giftList) do
        if not self.boughtGrowGift then
          v.status = self.cellStatus.Lock
        elseif v.record.level <= self.userLevel then
          if self._growGiftInfo.getMap[v.record.id] then
            v.status = self.cellStatus.Received
          else
            v.status = self.cellStatus.Available
          end
        else
          v.status = self.cellStatus.CanNotReceive
        end
      end
    end
    self._cellFrame:ReloadAllCell()
    if notChangeSlidePos then
      if lastPos then
        self._cellFrame:MoveToAssignedPos(lastPos)
      end
    else
      self._cellFrame:MoveToLeft()
    end
    local value = NekoData.BehaviorManager.BM_Welfare:IsBoughtGrowGift()
    if value then
      self._buyBtn:SetActive(false)
      self._boughtBtn:SetActive(true)
    else
      self._buyBtn:SetActive(true)
      self._buyBtn_price:SetText(self._growGiftInfo.chargeNum)
      self._boughtBtn:SetActive(false)
    end
  end
  local tag = NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuidTypes.LEVEL_GIFT)
  if not tag or tag == 0 then
    NekoData.BehaviorManager.BM_Game:SetGuideTag(GuidTypes.LEVEL_GIFT, 1)
    LuaNotificationCenter.PostNotification(Common.n_RefreshGrowGift, nil, nil)
  end
end

function GrowGiftTabCell:NumberOfCell(frame)
  return #self._giftList
end

function GrowGiftTabCell:CellAtIndex(frame, index)
  return "welfare.growgiftcell"
end

function GrowGiftTabCell:DataAtIndex(frame, index)
  return self._giftList[index]
end

function GrowGiftTabCell:OnBuyBtnClick()
  local cmd = LuaNetManager.CreateProtocol("protocol.charge.cbuydiamond")
  cmd.goodId = self._growGiftInfo.goodId
  cmd:Send()
end

return GrowGiftTabCell
