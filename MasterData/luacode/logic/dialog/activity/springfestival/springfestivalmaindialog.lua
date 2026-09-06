local NPCDialogCfg = BeanManager.GetTableByName("activity.csfsmalltalk")
local CTimedActivitySwitch = BeanManager.GetTableByName("activity.ctimedactivityswitch")
local SpringRedpacketUnlockRecord = CTimedActivitySwitch:GetRecorder(26001)
local SpringUnlockRecord = CTimedActivitySwitch:GetRecorder(25001)
local SpringShopUnlockRecord = CTimedActivitySwitch:GetRecorder(30001)
local TabFrame = require("framework.ui.frame.tab.tabframe")
local timeutils = require("logic.utils.timeutils")
local SpringFestivalMainDialog = class("SpringFestivalMainDialog", Dialog)
local ChildDialogs = {
  "activity.springfestival.itembuydialog",
  "activity.springfestival.roleopstiondialog"
}
SpringFestivalMainDialog.AssetBundleName = "ui/layouts.activitynewyear"
SpringFestivalMainDialog.AssetName = "ActivityNewYearMain"

function SpringFestivalMainDialog:Ctor(...)
  SpringFestivalMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function SpringFestivalMainDialog:OnCreate()
  self._talkPanel = self:GetChild("Talk")
  self._talkText = self:GetChild("Talk/Text")
  self._backBtn = self:GetChild("BackBtn")
  self._panel = self:GetChild("Frame")
  self._frame = TabFrame.Create(self._panel, self)
  self._sheetBtn = {}
  self._dot = {}
  for i = 1, 3 do
    self._sheetBtn[i] = self:GetChild("Cutbtn" .. tostring(i))
    self._dot[i] = self:GetChild("Cutbtn" .. tostring(i) .. "/Dot")
    self._sheetBtn[i]:Subscribe_PointerClickEvent(function()
      self:OnSheetBtnClicked(i)
    end, self)
  end
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID)
  self:RefreshRedDot()
  if self._bm:IsRedPacketEnable() then
    self:OnSheetBtnClicked(1)
  else
    self:OnSheetBtnClicked(2)
  end
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_RefreshSpringFestivalRedDot, nil)
end

function SpringFestivalMainDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function SpringFestivalMainDialog:RefreshRedDot()
  for i, v in ipairs(self._dot) do
    v:SetActive(self._bm:ShowRedDotByFunctionIndex(i))
  end
end

function SpringFestivalMainDialog:OnSheetBtnClicked(index)
  if index == 1 then
    self._openTime = timeutils.GetConfigFormatTimeStamp(SpringRedpacketUnlockRecord.openTime)
    self._endTime = timeutils.GetConfigFormatTimeStamp(SpringRedpacketUnlockRecord.closeTime)
    if ServerGameTimer.GetServerTime() < self._openTime then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100443)
      return
    elseif ServerGameTimer.GetServerTime() > self._endTime then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100455)
      return
    end
  elseif index == 3 then
    if not self._bm:IsSpringShopEnable() then
      self._openTime = timeutils.GetConfigFormatTimeStamp(SpringShopUnlockRecord.openTime)
      self._endTime = timeutils.GetConfigFormatTimeStamp(SpringShopUnlockRecord.closeTime)
      if ServerGameTimer.GetServerTime() < self._openTime then
        NekoData.BehaviorManager.BM_Message:SendMessageById(100458)
        return
      elseif ServerGameTimer.GetServerTime() > self._endTime then
        NekoData.BehaviorManager.BM_Message:SendMessageById(100455)
        return
      end
    end
  else
    self._openTime = timeutils.GetConfigFormatTimeStamp(SpringUnlockRecord.openTime)
    self._endTime = timeutils.GetConfigFormatTimeStamp(SpringUnlockRecord.closeTime)
    if ServerGameTimer.GetServerTime() > self._endTime then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100455)
      return
    end
  end
  self:ToFramePage(index):SetData()
end

function SpringFestivalMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function SpringFestivalMainDialog:ToFramePage(index)
  self:OnTalkPanelClicked(index)
  for key, value in pairs(self._sheetBtn) do
    value:SetSelected(key == index)
  end
  return self._frame:ToPage(index)
end

function SpringFestivalMainDialog:OnTalkPanelClicked(index)
  local record = NPCDialogCfg:GetRecorder(index)
  local randomID = math.random(1, #record.textID)
  self._talkText:SetText(TextManager.GetText(record.textID[randomID]))
end

function SpringFestivalMainDialog:CellAtIndex(frame, index)
  if index == 1 then
    return "activity.springfestival.redpackettabcell"
  elseif index == 2 then
    return "activity.springfestival.bossintotabcell"
  elseif index == 3 then
    return "activity.springfestival.gifttabcell"
  end
end

function SpringFestivalMainDialog:AddNewModal(dialog)
  if table.contain(ChildDialogs, dialog._dialogName) then
    self._rootWindow:SetActive(true)
  else
    self._rootWindow:SetActive(false)
  end
end

return SpringFestivalMainDialog
