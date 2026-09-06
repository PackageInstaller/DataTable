local TableFrame = require("framework.ui.frame.table.tableframe")
local AgCoinShop = class("AgCoinShop", Dialog)
local CStringRes = BeanManager.GetTableByName("message.cstringres")
AgCoinShop.AssetBundleName = "ui/layouts.baseshop"
AgCoinShop.AssetName = "CoinShop"

function AgCoinShop:Ctor(...)
  AgCoinShop.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function AgCoinShop:OnCreate()
  self._getCoinAccess = self:GetChild("GetDetailBtn")
  self._endTimeTxt = self:GetChild("Time/Time")
  self._unLockAdCollections = self:GetChild("UnLockBtn")
  self._lockIcon = self:GetChild("High/Lock")
  self._scrollBar = self:GetChild("Scrollbar")
  self._frame = self:GetChild("Frame")
  self._helperFrame = TableFrame.Create(self._frame, self, true, true, true)
  self._getCoinAccess:Subscribe_PointerClickEvent(self.OnGetCoinAccessClick, self)
  self._unLockAdCollections:Subscribe_PointerClickEvent(self.OnUnLockHighCollectionsClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnAgCoinDataRefresh, Common.n_RefreshAgCoinData, nil)
end

function AgCoinShop:OnDestroy()
  self._helperFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function AgCoinShop:RefreshCell()
  local endtime = NekoData.BehaviorManager.BM_Activity:GetEndTime(DataCommon.AgCoinActivityID)
  local timeStr = ServerGameTimer.GetDetailTimeStr(endtime)
  local str = TextManager.GetText(CStringRes:GetRecorder(1183).msgTextID)
  str = string.gsub(str, "%$parameter1%$", timeStr)
  self._endTimeTxt:SetText(str)
  local manager = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  self._collection = manager:GetColltion()
  self._helperFrame:ReloadAllCell()
  self._helperFrame:MoveToTop()
  self._unLockAdCollections:SetActive(manager:IsHighColltionLock())
  self._lockIcon:SetActive(manager:IsHighColltionLock())
end

function AgCoinShop:NumberOfCell(frame)
  if frame == self._helperFrame then
    return #self._collection
  end
end

function AgCoinShop:CellAtIndex(frame)
  if frame == self._helperFrame then
    return "shop.agcoinshopcell"
  end
end

function AgCoinShop:DataAtIndex(frame, index)
  if frame == self._helperFrame then
    return self._collection[index]
  end
end

function AgCoinShop:OnGetCoinAccessClick()
  DialogManager.CreateSingletonDialog("shop.agcoinaccessdialog")
end

function AgCoinShop:OnUnLockHighCollectionsClick()
  DialogManager.CreateSingletonDialog("shop.unlockhighagdialog")
end

function AgCoinShop:OnCurPosChange(frame, proportion)
  if frame == self._helperFrame then
    self._curProportion = proportion
    local width, height = self._frame:GetRectSize()
    local total = self._helperFrame:GetTotalLength()
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollValue(1 - proportion)
    if height < total then
      self._scrollBar:SetScrollSize(height / total)
    else
      self._scrollBar:SetScrollSize(1)
    end
  end
end

function AgCoinShop:OnCloseBtnClick()
  self:Destroy()
end

function AgCoinShop:OnAgCoinDataRefresh()
  local manager = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  self._unLockAdCollections:SetActive(manager:IsHighColltionLock())
  self._lockIcon:SetActive(manager:IsHighColltionLock())
  self._collection = manager:GetColltion()
  local curPos = self._helperFrame:GetCurrentPosition()
  self._helperFrame:ReloadAllCell()
  self._helperFrame:MoveToAssignedPos(curPos)
end

return AgCoinShop
