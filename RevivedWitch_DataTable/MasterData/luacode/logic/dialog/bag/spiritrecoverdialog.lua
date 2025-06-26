-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/spiritrecoverdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSpirit = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectstrength")
local Item = require("logic.manager.experimental.types.item")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
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
  Limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  self._num0Icon = self:GetChild("Back/Num0/Icon")
  self._num0Btn = self:GetChild("Back/Num0")
  self._num0Text = self:GetChild("Back/Num0/Text")
  self._time = self:GetChild("Back/Time")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._itemFrame = self:GetChild("Back/Frame")
  self._scrollbar = self:GetChild("Back/Scrollbar")
  self._frame = (GridFrame.Create)(self._itemFrame, self, true, MaxColumnNums, true)
  self._ibtn = self:GetChild("Back/Ibtn")
  ;
  (self._num0Btn):Subscribe_PointerClickEvent(self.OnNum0BtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._ibtn):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
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
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.HandleSpriteEvidence, Common.n_RefreshSpirit, nil)
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
  -- function num : 0_3 , upvalues : Limit, _ENV
  Limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  ;
  (self._num0Text):SetText(tostring((notification.userInfo).spirit) .. "/" .. tostring(Limit))
  self._spirit = (notification.userInfo).spirit
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
  -- function num : 0_6 , upvalues : _ENV, Limit
  while (self._cellInfo)[#self._cellInfo] do
    (table.remove)(self._cellInfo, #self._cellInfo)
  end
  local soulDropData = {}
  soulDropData.item = ((NekoData.BehaviorManager).BM_BagInfo):GetSoulDropCoinItem()
  ;
  (table.insert)(self._cellInfo, soulDropData)
  self._physicItemList = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpiritItemType)
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
  self:HandleSpriteEvidence()
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID)
  ;
  (self._num0Text):SetText(tostring(self._spirit) .. "/" .. tostring(Limit))
  self:CheckSpriteLimte()
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
  -- function num : 0_8 , upvalues : _ENV, Limit, Delay, Rate
  local time = ((NekoData.BehaviorManager).BM_Currency):GetNextSpiritLeftTime() + (math.ceil)(1000 * (Limit - self._spirit - 1) * Delay / Rate)
  ;
  (self._time):SetText((ServerGameTimer.GetTimeStr)(time))
end

SpiritRecoverDialog.NumberOfCell = function(self, frame)
  -- function num : 0_9
  return #self._cellInfo
end

SpiritRecoverDialog.CellAtIndex = function(self, frame)
  -- function num : 0_10
  return "bag.spiritrecovercell"
end

SpiritRecoverDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  return (self._cellInfo)[index]
end

SpiritRecoverDialog.OnNum0BtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(DataCommon.SpiritID)})
    local width, height = (self._num0Btn):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._num0Btn):GetLocalPointInUiRootPanel())
  end
end

SpiritRecoverDialog.OnBackBtnClicked = function(self)
  -- function num : 0_13
  self:Destroy()
end

SpiritRecoverDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_14
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

SpiritRecoverDialog.OnTipBtnClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(10)
end

SpiritRecoverDialog.HandleSpriteEvidence = function(self, userInfo)
  -- function num : 0_16 , upvalues : _ENV, CImagePathTable, CVarconfig, Item
  local haveSpriteEvidence = (((NekoData.BehaviorManager).BM_Currency):GetSpiritRecoverTimes())[DataCommon.SpriteEvidence]
  if haveSpriteEvidence then
    if not CImagePathTable:GetRecorder(tonumber((CVarconfig:GetRecorder(125)).Value)) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._num0Icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      do
        local imageRecord = ((Item.Create)(DataCommon.SpiritID)):GetIcon()
        ;
        (self._num0Icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (self._ibtn):SetActive(haveSpriteEvidence ~= nil)
        if userInfo then
          self:Refresh()
        end
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
end

return SpiritRecoverDialog

