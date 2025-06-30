-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/children/conversionpage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local CactivityTasks = (LuaNetManager.CreateProtocol)("protocol.task.cactivitytasks")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local SChildrenDayInfo = (LuaNetManager.CreateProtocol)("protocol.activity.childrenday.schildrendayinfo")
local CChildrensDayExtraAward = (BeanManager.GetTableByName)("mission.cchildrensdayextraaward")
local ConversionPage = class("ConversionPage", Dialog)
ConversionPage.AssetBundleName = "ui/layouts.activitychildrensday"
ConversionPage.AssetName = "ActivityChildrensDayItemShop"
local RefreshAwardInfo = function(self)
  -- function num : 0_0 , upvalues : SChildrenDayInfo
  local data = (self._bm):GetAwardsInfo()
  for i = 1, self._awardLength do
    (((self._awardInfo)[i]).icon):SetSprite(((data[i]).item):GetIconAB())
    ;
    (((self._awardInfo)[i]).processNum):SetText((data[i]).neednum)
    ;
    (((self._awardInfo)[i]).frame):SetSprite(((data[i]).item):GetPinJiImageAB())
    ;
    (((self._awardInfo)[i]).count):SetText((data[i]).count)
    ;
    (((self._awardInfo)[i]).grey):SetActive((data[i]).state == SChildrenDayInfo.FETCHED)
    ;
    (((self._awardInfo)[i]).select):SetActive((data[i]).state == SChildrenDayInfo.TO_FETCH)
    ;
    (((self._awardInfo)[i]).mask):SetActive((data[i]).state == SChildrenDayInfo.LOCKED)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

ConversionPage.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : ConversionPage, _ENV, CactivityTasks
  ((ConversionPage.super).Ctor)(self, ...)
  self._ItemInfo = {}
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChildrenActivityManagerID)
  self._activityID = CactivityTasks.CHILDREN_DAY
end

local MoveProcess = function(self, index)
  -- function num : 0_2
  local delta = (index / self._awardLength - 0.5) * self._processFrame_width + 200
  ;
  (self._processFrame):SetPosition(self._processFrame_pos_x, self._processFrame_width_offset_x - delta, self._processFrame_pos_y, self._processFrame_pos_offset_y)
end

local GoCurrentAward = function(self)
  -- function num : 0_3 , upvalues : _ENV, SChildrenDayInfo, MoveProcess
  local data = (self._bm):GetAwardsInfo()
  local haveAvailable = (self._bm):HaveAvailable()
  if haveAvailable then
    for k,v in ipairs(data) do
      if v.state == SChildrenDayInfo.TO_FETCH then
        MoveProcess(self, k)
        return 
      end
    end
  else
    do
      for k,v in ipairs(data) do
        if v.state == SChildrenDayInfo.LOCKED then
          MoveProcess(self, k)
          return 
        end
      end
      do
        MoveProcess(self, #data)
      end
    end
  end
end

ConversionPage.OnCreate = function(self)
  -- function num : 0_4 , upvalues : TableFrame, CChildrensDayExtraAward, _ENV
  self._staticTxt1 = self:GetChild("Txt")
  self._taskPanel = self:GetChild("FrameTask")
  self._currencyIcon = self:GetChild("Item")
  self._currencyNum = self:GetChild("NowNum")
  self._tipsBtn = self:GetChild("Tips")
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  ;
  (self._currencyIcon):Subscribe_PointerClickEvent(self.OnCurrencyIconClicked, self)
  self._processLine = self:GetChild("ItemGroup/Frame/TasklineBack/Taskline")
  self._itemFrame = (TableFrame.Create)(self._taskPanel, self, false, false, false)
  local str = "ItemGroup/Frame/ActivityChildrensDayCellItem"
  self._awardInfo = {}
  self._curScore = self:GetChild("TextNum")
  self._itemgroup = self:GetChild("ItemGroup/Frame")
  local itemgroupob = (self._itemgroup):GetUIObject()
  self._awardLength = (itemgroupob.transform).childCount - 1
  self._maxScore = (CChildrensDayExtraAward:GetRecorder(self._awardLength)).neednum
  for i = 1, self._awardLength do
    -- DECOMPILER ERROR at PC72: Confused about usage of register: R7 in 'UnsetPending'

    (self._awardInfo)[i] = {}
    local parent = str .. i
    do
      -- DECOMPILER ERROR at PC81: Confused about usage of register: R8 in 'UnsetPending'

      ((self._awardInfo)[i]).cell = self:GetChild(parent)
      local a = parent .. "/Panel/ItemCell/_BackGround/Icon"
      -- DECOMPILER ERROR at PC92: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._awardInfo)[i]).icon = self:GetChild(parent .. "/Panel/ItemCell/_BackGround/Icon")
      -- DECOMPILER ERROR at PC100: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._awardInfo)[i]).processNum = self:GetChild(parent .. "/Num1")
      -- DECOMPILER ERROR at PC108: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._awardInfo)[i]).frame = self:GetChild(parent .. "/Panel/ItemCell/_BackGround/Frame")
      -- DECOMPILER ERROR at PC116: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._awardInfo)[i]).count = self:GetChild(parent .. "/Panel/ItemCell/_Count")
      -- DECOMPILER ERROR at PC124: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._awardInfo)[i]).grey = self:GetChild(parent .. "/Grey")
      -- DECOMPILER ERROR at PC132: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._awardInfo)[i]).select = self:GetChild(parent .. "/Select")
      -- DECOMPILER ERROR at PC140: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self._awardInfo)[i]).mask = self:GetChild(parent .. "/Mask")
      local index = i
      ;
      (((self._awardInfo)[i]).icon):Subscribe_PointerClickEvent(function()
    -- function num : 0_4_0 , upvalues : self, index
    self:OnAwardCellClicked(index)
  end
, self)
    end
  end
  self._timeText = self:GetChild("ActiveTime")
  ;
  (self._timeText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1795))
  self._processView = self:GetChild("ItemGroup")
  self._processView_width = (self._processView):GetDeltaSize()
  self._processFrame = self:GetChild("ItemGroup/Frame")
  self._processFrame_width = (self._processFrame):GetDeltaSize()
  self._processFrame_pos_x = (self._processFrame):GetPosition()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_SRefreshChildrenInfo, nil)
  self:SetStaticRes()
end

ConversionPage.SetStaticRes = function(self)
  -- function num : 0_5 , upvalues : _ENV, CStringRes, Item
  (self._staticTxt1):SetText((TextManager.GetText)((CStringRes:GetRecorder(1632)).msgTextID))
  self._currencyItem = (Item.Create)(DataCommon.Cicada)
  ;
  (self._currencyIcon):SetSprite(((self._currencyItem):GetIcon()).assetBundle, ((self._currencyItem):GetIcon()).assetName)
end

ConversionPage.OnDestroy = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._itemFrame then
    (self._itemFrame):Destroy()
  end
  ;
  (DialogManager.DestroySingletonDialog)("activity.children.childrentipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

ConversionPage.Refresh = function(self)
  -- function num : 0_7 , upvalues : RefreshAwardInfo, _ENV, CChildrensDayExtraAward, GoCurrentAward
  self:RefreshCurrencyData()
  self:RefreshTaskData()
  RefreshAwardInfo(self)
  ;
  (self._curScore):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1802, {(self._bm):GetScore()}))
  self._curStage = 0
  local curScore = (self._bm):GetScore()
  local gapRatio = 0
  local nextRecord = nil
  for i,v in ipairs(CChildrensDayExtraAward:GetAllIds()) do
    nextRecord = CChildrensDayExtraAward:GetRecorder(R11_PC36)
    if nextRecord.neednum <= curScore then
      self._curStage = self._curStage + 1
    else
      break
    end
  end
  do
    local curRecord = CChildrensDayExtraAward:GetRecorder(self._curStage)
    local curRecordScore = 0
    if curRecord then
      curRecordScore = curRecord.neednum
    end
    local gapRatio = (curScore - curRecordScore) / (nextRecord.neednum - curRecordScore)
    local fillAmount = 0
    if self._maxScore == curScore then
      fillAmount = 1
    else
      if self._curStage == 0 then
        fillAmount = gapRatio * 0.03
      else
        fillAmount = (gapRatio + self._curStage - 1) * 0.064 + 0.03
      end
    end
    ;
    (self._processLine):SetFillAmount(fillAmount)
    GoCurrentAward(self)
  end
end

ConversionPage.RefreshCurrencyData = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local haveCicadaNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.Cicada)
  ;
  (self._currencyNum):SetText((NumberManager.GetShowNumber)(haveCicadaNum))
end

ConversionPage.RefreshTaskData = function(self)
  -- function num : 0_9 , upvalues : _ENV
  for key,_ in pairs(self._ItemInfo) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._ItemInfo)[key] = nil
  end
  local conversionItemInfo = (self._bm):GetConversionItemInfo()
  if conversionItemInfo then
    for _,value in pairs(conversionItemInfo) do
      (table.insert)(self._ItemInfo, value)
    end
  end
  do
    ;
    (self._itemFrame):ReloadAllCell()
  end
end

ConversionPage.CellAtIndex = function(self, frame, index)
  -- function num : 0_10
  if frame == self._itemFrame then
    return "activity.children.conversionpagecell"
  end
end

ConversionPage.NumberOfCell = function(self, frame, index)
  -- function num : 0_11
  if frame == self._itemFrame then
    return #self._ItemInfo
  end
end

ConversionPage.DataAtIndex = function(self, frame, index)
  -- function num : 0_12
  if frame == self._itemFrame then
    return (self._ItemInfo)[index]
  end
end

ConversionPage.OnTipsBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV, CStringRes
  local dialogName = "activity.children.childrentipsdialog"
  local dialog = (DialogManager.CreateSingletonDialog)(dialogName)
  if dialog then
    dialog:SetData((CStringRes:GetRecorder(1794)).msgTextID)
  end
end

ConversionPage.OnCurrencyIconClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = self._currencyItem})
  end
end

ConversionPage.OnAwardCellClicked = function(self, index)
  -- function num : 0_15 , upvalues : SChildrenDayInfo, _ENV
  local data = (self._bm):GetAwardsInfo()
  if (data[index]).state == SChildrenDayInfo.LOCKED or (data[index]).state == SChildrenDayInfo.FETCHED then
    local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({item = (data[index]).item})
    end
  else
    do
      if (data[index]).state == SChildrenDayInfo.TO_FETCH then
        (self._bm):SendReceiveReward(index)
      end
    end
  end
end

return ConversionPage

