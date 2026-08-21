-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/springfestival/springfestivalmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NPCDialogCfg = (BeanManager.GetTableByName)("activity.csfsmalltalk")
local CTimedActivitySwitch = (BeanManager.GetTableByName)("activity.ctimedactivityswitch")
local SpringRedpacketUnlockRecord = CTimedActivitySwitch:GetRecorder(26001)
local SpringUnlockRecord = CTimedActivitySwitch:GetRecorder(25001)
local SpringShopUnlockRecord = CTimedActivitySwitch:GetRecorder(30001)
local TabFrame = require("framework.ui.frame.tab.tabframe")
local timeutils = require("logic.utils.timeutils")
local SpringFestivalMainDialog = class("SpringFestivalMainDialog", Dialog)
local ChildDialogs = {"activity.springfestival.itembuydialog", "activity.springfestival.roleopstiondialog"}
SpringFestivalMainDialog.AssetBundleName = "ui/layouts.activitynewyear"
SpringFestivalMainDialog.AssetName = "ActivityNewYearMain"
SpringFestivalMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SpringFestivalMainDialog
  ((SpringFestivalMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

SpringFestivalMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV
  self._talkPanel = self:GetChild("Talk")
  self._talkText = self:GetChild("Talk/Text")
  self._backBtn = self:GetChild("BackBtn")
  self._panel = self:GetChild("Frame")
  self._frame = (TabFrame.Create)(self._panel, self)
  self._sheetBtn = {}
  self._dot = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

      (self._sheetBtn)[i] = self:GetChild("Cutbtn" .. tostring(i))
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._dot)[i] = self:GetChild("Cutbtn" .. tostring(i) .. "/Dot")
      ;
      ((self._sheetBtn)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnSheetBtnClicked(i)
  end
, self)
    end
  end
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)
  self:RefreshRedDot()
  if (self._bm):IsRedPacketEnable() then
    self:OnSheetBtnClicked(1)
  else
    self:OnSheetBtnClicked(2)
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_RefreshSpringFestivalRedDot, nil)
end

SpringFestivalMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

SpringFestivalMainDialog.RefreshRedDot = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for i,v in ipairs(self._dot) do
    v:SetActive((self._bm):ShowRedDotByFunctionIndex(i))
  end
end

SpringFestivalMainDialog.OnSheetBtnClicked = function(self, index)
  -- function num : 0_4 , upvalues : timeutils, SpringRedpacketUnlockRecord, _ENV, SpringShopUnlockRecord, SpringUnlockRecord
  if index == 1 then
    self._openTime = (timeutils.GetConfigFormatTimeStamp)(SpringRedpacketUnlockRecord.openTime)
    self._endTime = (timeutils.GetConfigFormatTimeStamp)(SpringRedpacketUnlockRecord.closeTime)
    if (ServerGameTimer.GetServerTime)() < self._openTime then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100443)
      return 
    else
      if self._endTime < (ServerGameTimer.GetServerTime)() then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100455)
        return 
      end
    end
  else
    if index == 3 and not (self._bm):IsSpringShopEnable() then
      self._openTime = (timeutils.GetConfigFormatTimeStamp)(SpringShopUnlockRecord.openTime)
      self._endTime = (timeutils.GetConfigFormatTimeStamp)(SpringShopUnlockRecord.closeTime)
      if (ServerGameTimer.GetServerTime)() < self._openTime then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100458)
        return 
      else
        if self._endTime < (ServerGameTimer.GetServerTime)() then
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100455)
          return 
        end
      end
    end
  end
  self._openTime = (timeutils.GetConfigFormatTimeStamp)(SpringUnlockRecord.openTime)
  self._endTime = (timeutils.GetConfigFormatTimeStamp)(SpringUnlockRecord.closeTime)
  if self._endTime < (ServerGameTimer.GetServerTime)() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100455)
    return 
  end
  ;
  (self:ToFramePage(index)):SetData()
end

SpringFestivalMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

SpringFestivalMainDialog.ToFramePage = function(self, index)
  -- function num : 0_6 , upvalues : _ENV
  self:OnTalkPanelClicked(index)
  for key,value in pairs(self._sheetBtn) do
    value:SetSelected(key == index)
  end
  do return (self._frame):ToPage(index) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

SpringFestivalMainDialog.OnTalkPanelClicked = function(self, index)
  -- function num : 0_7 , upvalues : NPCDialogCfg, _ENV
  local record = NPCDialogCfg:GetRecorder(index)
  local randomID = (math.random)(1, #record.textID)
  ;
  (self._talkText):SetText((TextManager.GetText)((record.textID)[randomID]))
end

SpringFestivalMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  if index == 1 then
    return "activity.springfestival.redpackettabcell"
  else
    if index == 2 then
      return "activity.springfestival.bossintotabcell"
    else
      if index == 3 then
        return "activity.springfestival.gifttabcell"
      end
    end
  end
end

SpringFestivalMainDialog.AddNewModal = function(self, dialog)
  -- function num : 0_9 , upvalues : _ENV, ChildDialogs
  if (table.contain)(ChildDialogs, dialog._dialogName) then
    (self._rootWindow):SetActive(true)
  else
    ;
    (self._rootWindow):SetActive(false)
  end
end

return SpringFestivalMainDialog

