-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/springfestival/spiritrecoverdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSpirit = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectstrength")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CItemTable = (BeanManager.GetTableByName)("item.citemattr")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local SpiritRecoverDialog = class("SpiritRecoverDialog", Dialog)
SpiritRecoverDialog.AssetBundleName = "ui/layouts.spirit"
SpiritRecoverDialog.AssetName = "SpiritRecover"
local Limit = nil
local Delay = (CSpirit:GetRecorder(1)).time
local Rate = (CSpirit:GetRecorder(1)).num
local MaxColumnNums = 1
SpiritRecoverDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SpiritRecoverDialog
  ((SpiritRecoverDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._fastMenuDialogStatus = false
  self._cellInfo = {}
  self._physicItemList = {}
end

SpiritRecoverDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : Limit, _ENV, GridFrame, MaxColumnNums
  Limit = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)):GetSpiritLimit()
  self._num0Btn = self:GetChild("Back/Num0")
  self._num0Text = self:GetChild("Back/Num0/Text")
  self._spiritIcon = self:GetChild("Back/Num0/Icon")
  self._time = self:GetChild("Back/Time")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._itemFrame = self:GetChild("Back/Frame")
  self._scrollbar = self:GetChild("Back/Scrollbar")
  self._frame = (GridFrame.Create)(self._itemFrame, self, true, MaxColumnNums, true)
  self._title = self:GetChild("Back/Title")
  self._explanation = self:GetChild("Back/explanation")
  self._noPower = self:GetChild("NoPower")
  self._noPowerText = self:GetChild("NoPower/Text")
  ;
  (self._num0Btn):Subscribe_PointerClickEvent(self.OnNum0BtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._text = self:GetChild("Back/Text")
  ;
  (self._text):SetActive(true)
  ;
  (self._explanation):SetActive(false)
  self:LoadLocalData()
  ;
  (self._frame):ReloadAllCell()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_ItemAdd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnItemNumModify, Common.n_ItemNumModify, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSpirit, Common.n_RefreshSpringSpirit, nil)
end

SpiritRecoverDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

SpiritRecoverDialog.OnRefreshSpirit = function(self, notification)
  -- function num : 0_3 , upvalues : _ENV, Limit
  (self._num0Text):SetText((((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)):GetSpringSpirit() .. "/" .. tostring(Limit))
  self._spirit = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)):GetSpringSpirit()
  self:CheckSpriteLimte()
end

SpiritRecoverDialog.OnItemNumModify = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
  self:LoadLocalData()
  for index,info in pairs(self._cellInfo) do
    if (info.item):GetKey() == (notification.userInfo).itemKey then
      (self._frame):FireEvent("RefreshCell", info)
      break
    end
  end
end

SpiritRecoverDialog.Refresh = function(self, notification)
  -- function num : 0_5
  self:LoadLocalData()
  ;
  (self._frame):ReloadAllCell()
end

SpiritRecoverDialog.LoadLocalData = function(self)
  -- function num : 0_6 , upvalues : _ENV, Limit, CItemTable, CImagePathTable
  (self._title):SetText((TextManager.GetText)(701696))
  ;
  (self._text):SetText((TextManager.GetText)(1803134))
  while (self._cellInfo)[#self._cellInfo] do
    (table.remove)(self._cellInfo, #self._cellInfo)
  end
  self._physicItemList = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpringSpiritItemType)
  ;
  (table.sort)(self._physicItemList, function(a, b)
    -- function num : 0_6_0
    do return a:GetRank() < b:GetRank() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i,v in ipairs(self._physicItemList) do
    local celldata = {}
    celldata.item = v
    ;
    (table.insert)(self._cellInfo, celldata)
  end
  self._spirit = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)):GetSpringSpirit()
  ;
  (self._num0Text):SetText(tostring(self._spirit) .. "/" .. tostring(Limit))
  local itemRecorder = CItemTable:GetRecorder(DataCommon.SpringFestivalFu)
  do
    if itemRecorder then
      local imageRecord = CImagePathTable:GetRecorder(itemRecorder.icon)
      ;
      (self._spiritIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    self:CheckSpriteLimte()
    ;
    (self._noPower):SetActive(#self._cellInfo == 0)
    if #self._cellInfo == 0 then
      (self._noPowerText):SetText((TextManager.GetText)(701697))
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

SpiritRecoverDialog.CheckSpriteLimte = function(self)
  -- function num : 0_7 , upvalues : _ENV, Limit
  if self._task then
    LogInfo("SpiritRecoverDialog", "CheckSpriteLimte1 self._task " .. tostring(self._task))
    ;
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  if self._spirit < Limit then
    (self._time):SetActive(true)
    self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_7_0 , upvalues : self
    self:SpiritTask()
  end
, nil)
    LogInfo("SpiritRecoverDialog", "CheckSpriteLimte1 self._task " .. tostring(self._task))
  else
    ;
    (self._time):SetActive(false)
  end
end

SpiritRecoverDialog.SpiritTask = function(self)
  -- function num : 0_8 , upvalues : _ENV, Limit
  local time = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)):GetNextSpiritLeftTime() + (math.ceil)(1000 * (Limit - self._spirit - 1) * 480 * 60)
  ;
  (self._time):SetText(self:GetTimeStr(time))
end

SpiritRecoverDialog.GetTimeStr = function(self, ms)
  -- function num : 0_9 , upvalues : _ENV
  if ms then
    local sec1 = ms // 1000
  end
  local str = (TextManager.GetText)(701694)
  str = (string.gsub)(str, "%$parameter1%$", (math.ceil)((os.date)("!%d", sec1) - 1))
  str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%H", sec1))
  str = (string.gsub)(str, "%$parameter3%$", (os.date)("!%M", sec1))
  return str
end

SpiritRecoverDialog.NumberOfCell = function(self, frame)
  -- function num : 0_10
  return #self._cellInfo
end

SpiritRecoverDialog.CellAtIndex = function(self, frame)
  -- function num : 0_11
  return "bag.spiritrecovercell"
end

SpiritRecoverDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_12
  return (self._cellInfo)[index]
end

SpiritRecoverDialog.OnNum0BtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(DataCommon.SpringFestivalFu)})
    local width, height = (self._num0Btn):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._num0Btn):GetLocalPointInUiRootPanel())
  end
end

SpiritRecoverDialog.OnBackBtnClicked = function(self)
  -- function num : 0_14
  self:Destroy()
end

SpiritRecoverDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_15
  local width, height = (self._itemFrame):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollbar):SetScrollSize(height / total)
    ;
    (self._scrollbar):SetScrollValue(proportion)
  else
    ;
    (self._scrollbar):SetScrollSize(1)
    ;
    (self._scrollbar):SetScrollValue(proportion)
  end
end

return SpiritRecoverDialog

