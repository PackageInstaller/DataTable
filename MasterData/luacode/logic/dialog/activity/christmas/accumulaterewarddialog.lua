local TableFrame = require("framework.ui.frame.table.tableframe")
local ChrisSollect = BeanManager.GetTableByName("dungeonselect.cchriscollect")
local Item = require("logic.manager.experimental.types.item")
local AccumulateRewardDialog = class("AccumulateRewardDialog", Dialog)
AccumulateRewardDialog.AssetBundleName = "ui/layouts.activitychristmas"
AccumulateRewardDialog.AssetName = "ActivityChristmasAccount"

function AccumulateRewardDialog:Ctor(...)
  AccumulateRewardDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._selectType = nil
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID)
  self._data = {
    [DataCommon.ChristmasSing] = self._bm:GetScoreAwardListByType(DataCommon.ChristmasSing),
    [DataCommon.ChristmasJump] = self._bm:GetScoreAwardListByType(DataCommon.ChristmasJump),
    [DataCommon.ChristmasExpressiveForce] = self._bm:GetScoreAwardListByType(DataCommon.ChristmasExpressiveForce)
  }
end

function AccumulateRewardDialog:OnCreate()
  self._tabs = {}
  for i = 1, 3 do
    local id = i + DataCommon.ChristmasSing - 1
    self._tabs[id] = {}
    self._tabs[id].btn = self:GetChild("Cutbtn" .. i)
    self._tabs[id].btnName = self:GetChild("Cutbtn" .. i .. "/_Text")
    self._tabs[id].btnRedDot = self:GetChild("Cutbtn" .. i .. "/Img")
    self._tabs[id].btn:Subscribe_PointerClickEvent(function()
      self:OnTabBtnClick(id)
    end)
    local currencyItem = Item.Create(id)
    self._tabs[id].btnName:SetText(currencyItem:GetName())
    self._tabs[id].btnRedDot:SetActive(self._bm:ShowRedDotByType(id))
  end
  self._Tips = self:GetChild("BackImage/Tips")
  self._TimeTxt = self:GetChild("BackImage/TimeTxt")
  self._Tips:SetText(TextManager.GetText(1901397))
  self._TimeTxt:SetText(TextManager.GetText(1901398))
  self._getBtn = self:GetChild("BackImage/GetBtn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  self._cellPanel = self:GetChild("BackImage/Frame")
  self._cellFrame = TableFrame.Create(self._cellPanel, self, true, true, true)
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshScorePanel, Common.n_RefreshChristmasScore, nil)
end

function AccumulateRewardDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._cellFrame:Destroy()
end

local function FirstCanGetIndex(self)
  local list = self._data[self._selectType]
  if list then
    for i, v in ipairs(list) do
      if v.status == 1 then
        return i
      end
    end
  end
end

function AccumulateRewardDialog:RefreshScorePanel()
  for k, _ in pairs(self._data) do
    self._data[k] = self._bm:GetScoreAwardListByType(k)
    self._tabs[k].btnRedDot:SetActive(self._bm:ShowRedDotByType(k))
  end
  local lastPos = self._cellFrame:GetCurrentPosition()
  local firstCanGetIndex = FirstCanGetIndex(self)
  self._getBtn:SetInteractable(firstCanGetIndex ~= nil)
  self._cellFrame:ReloadAllCell()
  if lastPos then
    self._cellFrame:MoveToAssignedPos(lastPos)
  else
    self._cellFrame:MoveToTop()
  end
end

function AccumulateRewardDialog:SetType(type)
  self._selectType = type
  for k, v in pairs(self._tabs) do
    v.btn:SetSelected(type == k)
  end
  local firstCanGetIndex = FirstCanGetIndex(self)
  self._getBtn:SetInteractable(firstCanGetIndex ~= nil)
  self._cellFrame:ReloadAllCell()
  if firstCanGetIndex then
    self._cellFrame:MoveTopToIndex(firstCanGetIndex)
  else
    self._cellFrame:MoveToTop()
  end
end

function AccumulateRewardDialog:OnTabBtnClick(typeCurrencyId)
  if typeCurrencyId ~= self._selectType then
    self:SetType(typeCurrencyId)
  end
end

function AccumulateRewardDialog:OnGetBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.creceivescorereward")
  protocol.scoreType = self._selectType
  protocol.rewardId = 0
  protocol:Send()
end

function AccumulateRewardDialog:OnBackBtnClicked()
  self:Destroy()
end

function AccumulateRewardDialog:NumberOfCell(frame)
  return #self._data[self._selectType]
end

function AccumulateRewardDialog:CellAtIndex(frame, index)
  return "activity.christmas.accumulaterewardcell"
end

function AccumulateRewardDialog:DataAtIndex(frame, index)
  return self._data[self._selectType][index]
end

return AccumulateRewardDialog
