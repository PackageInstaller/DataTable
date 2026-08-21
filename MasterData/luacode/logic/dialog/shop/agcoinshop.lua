-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/agcoinshop.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local AgCoinShop = class("AgCoinShop", Dialog)
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
AgCoinShop.AssetBundleName = "ui/layouts.baseshop"
AgCoinShop.AssetName = "CoinShop"
AgCoinShop.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AgCoinShop
  ((AgCoinShop.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

AgCoinShop.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._getCoinAccess = self:GetChild("GetDetailBtn")
  self._endTimeTxt = self:GetChild("Time/Time")
  self._unLockAdCollections = self:GetChild("UnLockBtn")
  self._lockIcon = self:GetChild("High/Lock")
  self._scrollBar = self:GetChild("Scrollbar")
  self._frame = self:GetChild("Frame")
  self._helperFrame = (TableFrame.Create)(self._frame, self, true, true, true)
  ;
  (self._getCoinAccess):Subscribe_PointerClickEvent(self.OnGetCoinAccessClick, self)
  ;
  (self._unLockAdCollections):Subscribe_PointerClickEvent(self.OnUnLockHighCollectionsClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAgCoinDataRefresh, Common.n_RefreshAgCoinData, nil)
end

AgCoinShop.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._helperFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

AgCoinShop.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  local endtime = ((NekoData.BehaviorManager).BM_Activity):GetEndTime(DataCommon.AgCoinActivityID)
  local timeStr = (ServerGameTimer.GetDetailTimeStr)(endtime)
  local str = (TextManager.GetText)((CStringRes:GetRecorder(1183)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", timeStr)
  ;
  (self._endTimeTxt):SetText(str)
  local manager = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
  self._collection = manager:GetColltion()
  ;
  (self._helperFrame):ReloadAllCell()
  ;
  (self._helperFrame):MoveToTop()
  ;
  (self._unLockAdCollections):SetActive(manager:IsHighColltionLock())
  ;
  (self._lockIcon):SetActive(manager:IsHighColltionLock())
end

AgCoinShop.NumberOfCell = function(self, frame)
  -- function num : 0_4
  if frame == self._helperFrame then
    return #self._collection
  end
end

AgCoinShop.CellAtIndex = function(self, frame)
  -- function num : 0_5
  if frame == self._helperFrame then
    return "shop.agcoinshopcell"
  end
end

AgCoinShop.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._helperFrame then
    return (self._collection)[index]
  end
end

AgCoinShop.OnGetCoinAccessClick = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("shop.agcoinaccessdialog")
end

AgCoinShop.OnUnLockHighCollectionsClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("shop.unlockhighagdialog")
end

AgCoinShop.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_9
  if frame == self._helperFrame then
    self._curProportion = proportion
    local width, height = (self._frame):GetRectSize()
    local total = (self._helperFrame):GetTotalLength()
    ;
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollValue(1 - proportion)
    if height < total then
      (self._scrollBar):SetScrollSize(height / total)
    else
      ;
      (self._scrollBar):SetScrollSize(1)
    end
  end
end

AgCoinShop.OnCloseBtnClick = function(self)
  -- function num : 0_10
  self:Destroy()
end

AgCoinShop.OnAgCoinDataRefresh = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local manager = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
  ;
  (self._unLockAdCollections):SetActive(manager:IsHighColltionLock())
  ;
  (self._lockIcon):SetActive(manager:IsHighColltionLock())
  self._collection = manager:GetColltion()
  local curPos = (self._helperFrame):GetCurrentPosition()
  ;
  (self._helperFrame):ReloadAllCell()
  ;
  (self._helperFrame):MoveToAssignedPos(curPos)
end

return AgCoinShop

