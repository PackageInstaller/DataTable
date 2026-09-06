local CSpirit = BeanManager.GetTableByName("dungeonselect.cdungeonselectstrength")
local Item = require("logic.manager.experimental.types.item")
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local SpiritRecoverDialog = class("SpiritRecoverDialog", Dialog)
SpiritRecoverDialog.AssetBundleName = "ui/layouts.spirit"
SpiritRecoverDialog.AssetName = "SpiritRecover"
local Limit
local Delay = CSpirit:GetRecorder(1).time
local Rate = CSpirit:GetRecorder(1).num
local MaxColumnNums = 1

function SpiritRecoverDialog:Ctor(...)
  SpiritRecoverDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._fastMenuDialogStatus = false
  self._cellInfo = {}
  self._physicItemList = {}
end

function SpiritRecoverDialog:OnCreate()
  Limit = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit
  self._num0Icon = self:GetChild("Back/Num0/Icon")
  self._num0Btn = self:GetChild("Back/Num0")
  self._num0Text = self:GetChild("Back/Num0/Text")
  self._time = self:GetChild("Back/Time")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._itemFrame = self:GetChild("Back/Frame")
  self._scrollbar = self:GetChild("Back/Scrollbar")
  self._frame = GridFrame.Create(self._itemFrame, self, true, MaxColumnNums, true)
  self._ibtn = self:GetChild("Back/Ibtn")
  self._num0Btn:Subscribe_PointerClickEvent(self.OnNum0BtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._ibtn:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self:LoadLocalData()
  self._frame:ReloadAllCell()
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_ItemAdd, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.OnItemNumModify, Common.n_ItemNumModify, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.HandleSpriteEvidence, Common.n_RefreshSpirit, nil)
end

function SpiritRecoverDialog:OnDestroy()
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function SpiritRecoverDialog:OnRefreshSpirit(notification)
  Limit = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit
  self._num0Text:SetText(tostring(notification.userInfo.spirit) .. "/" .. tostring(Limit))
  self._spirit = notification.userInfo.spirit
  self:CheckSpriteLimte()
end

function SpiritRecoverDialog:OnItemNumModify(notification)
  self:LoadLocalData()
  for index, info in pairs(self._cellInfo) do
    if info.item:GetKey() == notification.userInfo.itemKey then
      self._frame:FireEvent("RefreshCell", info)
      break
    end
  end
end

function SpiritRecoverDialog:Refresh(notification)
  self:LoadLocalData()
  self._frame:ReloadAllCell()
end

function SpiritRecoverDialog:LoadLocalData()
  while self._cellInfo[#self._cellInfo] do
    table.remove(self._cellInfo, #self._cellInfo)
  end
  local soulDropData = {}
  soulDropData.item = NekoData.BehaviorManager.BM_BagInfo:GetSoulDropCoinItem()
  table.insert(self._cellInfo, soulDropData)
  self._physicItemList = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(DataCommon.SpiritItemType)
  table.sort(self._physicItemList, function(a, b)
    return a:GetRank() < b:GetRank()
  end)
  for i, v in ipairs(self._physicItemList) do
    local celldata = {}
    celldata.item = v
    table.insert(self._cellInfo, celldata)
  end
  self:HandleSpriteEvidence()
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID)
  self._num0Text:SetText(tostring(self._spirit) .. "/" .. tostring(Limit))
  self:CheckSpriteLimte()
end

function SpiritRecoverDialog:CheckSpriteLimte()
  if self._task then
    LogInfo("SpiritRecoverDialog", "CheckSpriteLimte1 self._task " .. tostring(self._task))
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  if self._spirit < Limit then
    self._time:SetActive(true)
    self._task = ServerGameTimer.AddTask(0, 1, function()
      self:SpiritTask()
    end, nil)
    LogInfo("SpiritRecoverDialog", "CheckSpriteLimte1 self._task " .. tostring(self._task))
  else
    self._time:SetActive(false)
  end
end

function SpiritRecoverDialog:SpiritTask()
  local time = NekoData.BehaviorManager.BM_Currency:GetNextSpiritLeftTime() + math.ceil(1000 * (Limit - self._spirit - 1) * Delay / Rate)
  self._time:SetText(ServerGameTimer.GetTimeStr(time))
end

function SpiritRecoverDialog:NumberOfCell(frame)
  return #self._cellInfo
end

function SpiritRecoverDialog:CellAtIndex(frame)
  return "bag.spiritrecovercell"
end

function SpiritRecoverDialog:DataAtIndex(frame, index)
  return self._cellInfo[index]
end

function SpiritRecoverDialog:OnNum0BtnClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.SpiritID)
    })
    local width, height = self._num0Btn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._num0Btn:GetLocalPointInUiRootPanel())
  end
end

function SpiritRecoverDialog:OnBackBtnClicked()
  self:Destroy()
end

function SpiritRecoverDialog:OnCurPosChange(frame, proportion)
  local width, height = self._itemFrame:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollbar:SetScrollSize(height / total)
    self._scrollbar:SetScrollValue(proportion)
  else
    self._scrollbar:SetScrollSize(1)
    self._scrollbar:SetScrollValue(proportion)
  end
end

function SpiritRecoverDialog:OnTipBtnClicked()
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(10)
end

function SpiritRecoverDialog:HandleSpriteEvidence(userInfo)
  local haveSpriteEvidence = NekoData.BehaviorManager.BM_Currency:GetSpiritRecoverTimes()[DataCommon.SpriteEvidence]
  if haveSpriteEvidence then
    local imageRecord = CImagePathTable:GetRecorder(tonumber(CVarconfig:GetRecorder(125).Value)) or DataCommon.DefaultImageAsset
    self._num0Icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    local imageRecord = Item.Create(DataCommon.SpiritID):GetIcon()
    self._num0Icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  self._ibtn:SetActive(haveSpriteEvidence ~= nil)
  if userInfo then
    self:Refresh()
  end
end

return SpiritRecoverDialog
