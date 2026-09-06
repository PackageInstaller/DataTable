local ReportPlayerDialog = class("ReportPlayerDialog", Dialog)
local CReportTypeCfg = BeanManager.GetTableByName("report.creporttypecfg")
ReportPlayerDialog.AssetBundleName = "ui/layouts.report"
ReportPlayerDialog.AssetName = "ReportPlayer"
local WordLimit = 40

function ReportPlayerDialog:Ctor(...)
  ReportPlayerDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._data = {}
  self._nickname = ""
end

function ReportPlayerDialog:OnCreate()
  self._toggles = {}
  for i = 1, 8 do
    self._toggles[i] = self:GetChild("Back/ToggleGroup/Toggle" .. i)
    local str = TextManager.GetText(CReportTypeCfg:GetRecorder(i).TextID)
    self:GetChild("Back/ToggleGroup/Toggle" .. i .. "/Label"):SetText(str)
  end
  self._toggles[1]:SetIsOnType(true)
  self._inputfield = self:GetChild("Back/InputField")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._reportBtn = self:GetChild("Back/ReportBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._reportBtn:Subscribe_PointerClickEvent(self.OnReportButtonClicked, self)
  self._inputfield:Subscribe_ValueChangedEvent(self.OnInputfieldValueChanged, self)
end

function ReportPlayerDialog:OnDestroy()
end

function ReportPlayerDialog:SetData(data)
  self._data = data
end

function ReportPlayerDialog:OnReportButtonClicked()
  local feedbacktype = ""
  local selectId = 1
  for i = 1, 8 do
    if self._toggles[i]:GetIsOnType() then
      selectId = i
      feedbacktype = TextManager.GetText(CReportTypeCfg:GetRecorder(i).TextID)
      break
    end
  end
  if string.utf8len(self._inputfield:GetText()) > WordLimit then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100274)
    return
  end
  if self._inputfield:GetText() == "" and selectId == 8 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100307, nil)
    return
  end
  local packageType = 1
  if CS.PixelNeko.P1.PackageTypeManager.IsTestPack() then
    packageType = 0
  end
  local reportData = {
    userId = NekoData.BehaviorManager.BM_Game:GetUserId(),
    nickname = tostring(self._data.nickname),
    reportId = self._data.reportid,
    reportStr = feedbacktype,
    reportReason = self._inputfield:GetText(),
    reportContent = self._data.content or "",
    time = ServerGameTimer.GetServerTimeForecast() // 1000,
    isTest = packageType,
    type = self._data.type or 0
  }
  if self._data.extra then
    reportData.extra = self._data.extra
  end
  self:DoReport(reportData)
end

function ReportPlayerDialog:DoReport(content)
  local s = JSON.encode(content)
  if not s then
    warn(">> error encode")
    return
  end
  local cmd = LuaNetManager.CreateProtocol("protocol.user.calarm")
  cmd.context = s
  cmd:Send()
  self:Destroy()
end

function ReportPlayerDialog:OnBackBtnClicked()
  self:Destroy()
end

function ReportPlayerDialog:OnInputfieldValueChanged()
  local text = self._inputfield:GetText()
  if string.utf8len(text) > WordLimit then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100274)
  end
end

return ReportPlayerDialog
