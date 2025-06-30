-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/accumulaterewarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local ChrisSollect = (BeanManager.GetTableByName)("dungeonselect.cchriscollect")
local Item = require("logic.manager.experimental.types.item")
local AccumulateRewardDialog = class("AccumulateRewardDialog", Dialog)
AccumulateRewardDialog.AssetBundleName = "ui/layouts.activitychristmas"
AccumulateRewardDialog.AssetName = "ActivityChristmasAccount"
AccumulateRewardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AccumulateRewardDialog, _ENV
  ((AccumulateRewardDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._selectType = nil
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)
  self._data = {[DataCommon.ChristmasSing] = (self._bm):GetScoreAwardListByType(DataCommon.ChristmasSing), [DataCommon.ChristmasJump] = (self._bm):GetScoreAwardListByType(DataCommon.ChristmasJump), [DataCommon.ChristmasExpressiveForce] = (self._bm):GetScoreAwardListByType(DataCommon.ChristmasExpressiveForce)}
end

AccumulateRewardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, Item, TableFrame
  self._tabs = {}
  for i = 1, 3 do
    local id = i + DataCommon.ChristmasSing - 1
    do
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

      (self._tabs)[id] = {}
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self._tabs)[id]).btn = self:GetChild("Cutbtn" .. i)
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self._tabs)[id]).btnName = self:GetChild("Cutbtn" .. i .. "/_Text")
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self._tabs)[id]).btnRedDot = self:GetChild("Cutbtn" .. i .. "/Img")
      ;
      (((self._tabs)[id]).btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, id
    self:OnTabBtnClick(id)
  end
)
      local currencyItem = (Item.Create)(id)
      ;
      (((self._tabs)[id]).btnName):SetText(currencyItem:GetName())
      ;
      (((self._tabs)[id]).btnRedDot):SetActive((self._bm):ShowRedDotByType(id))
    end
  end
  self._Tips = self:GetChild("BackImage/Tips")
  self._TimeTxt = self:GetChild("BackImage/TimeTxt")
  ;
  (self._Tips):SetText((TextManager.GetText)(1901397))
  ;
  (self._TimeTxt):SetText((TextManager.GetText)(1901398))
  self._getBtn = self:GetChild("BackImage/GetBtn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  self._cellPanel = self:GetChild("BackImage/Frame")
  self._cellFrame = (TableFrame.Create)(self._cellPanel, self, true, true, true)
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshScorePanel, Common.n_RefreshChristmasScore, nil)
end

AccumulateRewardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._cellFrame):Destroy()
end

local FirstCanGetIndex = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local list = (self._data)[self._selectType]
  if list then
    for i,v in ipairs(list) do
      if v.status == 1 then
        return i
      end
    end
  end
end

AccumulateRewardDialog.RefreshScorePanel = function(self)
  -- function num : 0_4 , upvalues : _ENV, FirstCanGetIndex
  for k,_ in pairs(self._data) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

    (self._data)[k] = (self._bm):GetScoreAwardListByType(k)
    ;
    (((self._tabs)[k]).btnRedDot):SetActive((self._bm):ShowRedDotByType(k))
  end
  local lastPos = (self._cellFrame):GetCurrentPosition()
  local firstCanGetIndex = FirstCanGetIndex(self)
  ;
  (self._getBtn):SetInteractable(firstCanGetIndex ~= nil)
  ;
  (self._cellFrame):ReloadAllCell()
  if lastPos then
    (self._cellFrame):MoveToAssignedPos(lastPos)
  else
    (self._cellFrame):MoveToTop()
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

AccumulateRewardDialog.SetType = function(self, type)
  -- function num : 0_5 , upvalues : _ENV, FirstCanGetIndex
  self._selectType = type
  for k,v in pairs(self._tabs) do
    (v.btn):SetSelected(type == k)
  end
  local firstCanGetIndex = FirstCanGetIndex(self)
  ;
  (self._getBtn):SetInteractable(firstCanGetIndex ~= nil)
  ;
  (self._cellFrame):ReloadAllCell()
  if firstCanGetIndex then
    (self._cellFrame):MoveTopToIndex(firstCanGetIndex)
  else
    (self._cellFrame):MoveToTop()
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

AccumulateRewardDialog.OnTabBtnClick = function(self, typeCurrencyId)
  -- function num : 0_6
  if typeCurrencyId ~= self._selectType then
    self:SetType(typeCurrencyId)
  end
end

AccumulateRewardDialog.OnGetBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceivescorereward")
  protocol.scoreType = self._selectType
  protocol.rewardId = 0
  protocol:Send()
end

AccumulateRewardDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

AccumulateRewardDialog.NumberOfCell = function(self, frame)
  -- function num : 0_9
  return #(self._data)[self._selectType]
end

AccumulateRewardDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_10
  return "activity.christmas.accumulaterewardcell"
end

AccumulateRewardDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  return ((self._data)[self._selectType])[index]
end

return AccumulateRewardDialog

