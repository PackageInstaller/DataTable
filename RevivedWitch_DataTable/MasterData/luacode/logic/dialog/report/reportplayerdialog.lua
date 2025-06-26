-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/report/reportplayerdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ReportPlayerDialog = class("ReportPlayerDialog", Dialog)
local CReportTypeCfg = (BeanManager.GetTableByName)("report.creporttypecfg")
ReportPlayerDialog.AssetBundleName = "ui/layouts.report"
ReportPlayerDialog.AssetName = "ReportPlayer"
local WordLimit = 40
ReportPlayerDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReportPlayerDialog
  ((ReportPlayerDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._data = {}
  self._nickname = ""
end

ReportPlayerDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, CReportTypeCfg
  self._toggles = {}
  for i = 1, 8 do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    (self._toggles)[i] = self:GetChild("Back/ToggleGroup/Toggle" .. i)
    local str = (TextManager.GetText)((CReportTypeCfg:GetRecorder(i)).TextID)
    ;
    (self:GetChild("Back/ToggleGroup/Toggle" .. i .. "/Label")):SetText(str)
  end
  ;
  ((self._toggles)[1]):SetIsOnType(true)
  self._inputfield = self:GetChild("Back/InputField")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._reportBtn = self:GetChild("Back/ReportBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._reportBtn):Subscribe_PointerClickEvent(self.OnReportButtonClicked, self)
  ;
  (self._inputfield):Subscribe_ValueChangedEvent(self.OnInputfieldValueChanged, self)
end

ReportPlayerDialog.OnDestroy = function(self)
  -- function num : 0_2
end

ReportPlayerDialog.SetData = function(self, data)
  -- function num : 0_3
  self._data = data
end

ReportPlayerDialog.OnReportButtonClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, CReportTypeCfg, WordLimit
  local feedbacktype = ""
  local selectId = 1
  for i = 1, 8 do
    if ((self._toggles)[i]):GetIsOnType() then
      selectId = i
      feedbacktype = (TextManager.GetText)((CReportTypeCfg:GetRecorder(i)).TextID)
      break
    end
  end
  do
    if WordLimit < (string.utf8len)((self._inputfield):GetText()) then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100274)
      return 
    end
    if (self._inputfield):GetText() == "" and selectId == 8 then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100307, nil)
      return 
    end
    local packageType = 1
    if ((((CS.PixelNeko).P1).PackageTypeManager).IsTestPack)() then
      packageType = 0
    end
    local reportData = {userId = ((NekoData.BehaviorManager).BM_Game):GetUserId(), nickname = tostring((self._data).nickname), reportId = (self._data).reportid, reportStr = feedbacktype, reportReason = (self._inputfield):GetText(), reportContent = (self._data).content or "", time = (ServerGameTimer.GetServerTimeForecast)() // 1000, isTest = packageType, type = (self._data).type or 0}
    if (self._data).extra then
      reportData.extra = (self._data).extra
    end
    self:DoReport(reportData)
  end
end

ReportPlayerDialog.DoReport = function(self, content)
  -- function num : 0_5 , upvalues : _ENV
  local s = (JSON.encode)(content)
  if not s then
    warn(">> error encode")
    return 
  end
  local cmd = (LuaNetManager.CreateProtocol)("protocol.user.calarm")
  cmd.context = s
  cmd:Send()
  self:Destroy()
end

ReportPlayerDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

ReportPlayerDialog.OnInputfieldValueChanged = function(self)
  -- function num : 0_7 , upvalues : _ENV, WordLimit
  local text = (self._inputfield):GetText()
  if WordLimit < (string.utf8len)(text) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100274)
  end
end

return ReportPlayerDialog

