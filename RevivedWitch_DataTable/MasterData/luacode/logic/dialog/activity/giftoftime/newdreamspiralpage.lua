-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/giftoftime/newdreamspiralpage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local CRole = (BeanManager.GetTableByName)("item.croleitem")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Collection = (LuaNetManager.CreateBean)("protocol.activity.collection")
local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local NewDreamSpiralPage = class("NewDreamSpiralPage", Dialog)
NewDreamSpiralPage.AssetBundleName = "ui/layouts.battlepassnew"
NewDreamSpiralPage.AssetName = "BattlePassNew"
NewDreamSpiralPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewDreamSpiralPage, _ENV
  ((NewDreamSpiralPage.super).Ctor)(self, ...)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)
  self._timerId = 0
end

NewDreamSpiralPage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._back2 = self:GetChild("Back2")
  self._lockTxt = self:GetChild("Show/LockTxt")
  self._leftTime = self:GetChild("EndTime")
  self._normalAward = {quality = self:GetChild("Normal/Back"), image = self:GetChild("Normal/Image"), name = self:GetChild("Normal/Text")}
  self._advancelAward = {quality = self:GetChild("Advance/Back"), image = self:GetChild("Advance/Image"), name = self:GetChild("Advance/Text")}
  self._getExpBtn = self:GetChild("GetExp")
  self._getExpBtn_redDot = self:GetChild("GetExp/Dot")
  self._advanceAwardLock = self:GetChild("Advance/Lock")
  self._expNum = self:GetChild("To/ExpNum")
  self._unlockBtn = self:GetChild("UnLockBtn")
  self._boughtBtn = self:GetChild("Buy")
  self._cellArea = self:GetChild("CellFrame")
  self._cellFrame = (GridFrame.Create)(self._cellArea, self, false, 1)
  self._buyBtnText = self:GetChild("Buy/Text")
  self._getBtnText = self:GetChild("GetBtn/Text")
  self._unlockBtn_Text = self:GetChild("UnLockBtn/Text")
  self._getBtn = self:GetChild("GetBtn")
  self._tipsBtn = self:GetChild("Tips")
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetAllBtnClicked, self)
  ;
  (self._unlockBtn):Subscribe_PointerClickEvent(self.OnUnlockBtnClicked, self)
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  ;
  (self._getExpBtn):Subscribe_PointerClickEvent(self.OnGetExpBtnClicked, self)
  ;
  (self._getExpBtn_redDot):SetActive(false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_NewDreamSpiralRefresh, nil)
  ;
  (self._getExpBtn):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1940))
  ;
  ((self._normalAward).name):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1941))
  ;
  ((self._advancelAward).name):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1942))
  ;
  (self._unlockBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1943))
  ;
  (self._getBtnText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1944))
end

NewDreamSpiralPage.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._cellFrame):Destroy()
  if self._timerId ~= 0 then
    (GameTimer.RemoveTask)(self._timerId)
    self._timerId = 0
  end
end

local GetRemainTimeStr = function(endTime)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  local str = nil
  if endTime and endTime > 0 then
    local time = endTime
    local day = time // 86400
    local hour = (math.ceil)(time / 3600)
    if day > 0 then
      str = (TextManager.GetText)((CStringRes:GetRecorder(1935)).msgTextID, (string.format)("%d", day), (string.format)("%d", hour - day * 24))
    else
      str = (TextManager.GetText)((CStringRes:GetRecorder(1936)).msgTextID, hour)
    end
  else
    do
      str = (TextManager.GetText)((CStringRes:GetRecorder(1936)).msgTextID, 0)
      return str
    end
  end
end

NewDreamSpiralPage.UpdateLeftTime = function(self)
  -- function num : 0_4 , upvalues : _ENV, GetRemainTimeStr
  self._leftTimeData = self._leftTimeData - 1
  if self._leftTimeData < 0 then
    (GameTimer.RemoveTask)(self._timerId)
    self._timerId = 0
    return 
  end
  local str = GetRemainTimeStr(self._leftTimeData)
  ;
  (self._leftTime):SetText(str)
end

NewDreamSpiralPage.Refresh = function(self)
  -- function num : 0_5 , upvalues : _ENV, Collection
  self._info = (self._bm):GetBaseInfo()
  self._data = (self._bm):GetColltion()
  self._leftTimeData = (self._info).leftTime
  self:UpdateLeftTime()
  if self._timerId ~= 0 then
    (GameTimer.RemoveTask)(self._timerId)
    self._timerId = 0
  end
  self._timerId = (GameTimer.AddTask)(1, 1, self.UpdateLeftTime, self)
  local chipInfo = (self._info).chipInfo
  if chipInfo then
    (self._expNum):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1939, {chipInfo.has, chipInfo.max}))
  else
    LogWarning("nil chipinfo")
  end
  local hasUnlock = (self._info).highUnlocked ~= 0
  ;
  (self._advanceAwardLock):SetActive(not hasUnlock)
  ;
  (self._boughtBtn):SetActive(hasUnlock)
  ;
  (self._unlockBtn):SetActive(not hasUnlock)
  local moveToIdx = 0
  for k,v in ipairs(self._data) do
    if (v.common).state == Collection.UN_RECEIVE or (v.high).state == Collection.UN_RECEIVE then
      moveToIdx = k
      break
    end
  end
  if moveToIdx == 0 then
    for k,v in ipairs(self._data) do
      if (v.common).state == Collection.LOCK or hasUnlock and (v.high).state == Collection.LOCK then
        moveToIdx = k
        break
      end
    end
  end
  ;
  (self._cellFrame):ReloadAllCell()
  ;
  (self._cellFrame):MoveLeftToIndex(moveToIdx)
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

NewDreamSpiralPage.NumberOfCell = function(self, frame)
  -- function num : 0_6
  if frame == self._cellFrame then
    return #self._data
  end
end

NewDreamSpiralPage.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._cellFrame then
    return "activity.giftoftime.newdreamspiralcell"
  end
end

NewDreamSpiralPage.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._cellFrame then
    return (self._data)[index]
  end
end

NewDreamSpiralPage.OnUnlockBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.giftoftime.newdreamspiralunlockdialog")):Refresh(((self._info).chargeInfo).chargeMoneyType)
end

NewDreamSpiralPage.OnGetExpBtnClicked = function(self)
  -- function num : 0_10
  (self._delegate):OnCutBtn2Clicked()
end

NewDreamSpiralPage.OnGetAllBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if (self._bm):HasUntakeAward() then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.clittlebattlepassreceiveall")
    protocol:Send()
  end
end

NewDreamSpiralPage.OnTipBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(3)
end

return NewDreamSpiralPage

