local TableFrame = require("framework.ui.frame.table.tableframe")
local MonthSignTabCell = class("MonthSignTabCell", Dialog)
MonthSignTabCell.AssetBundleName = "ui/layouts.welfare"
MonthSignTabCell.AssetName = "WelfareSign30Day"

function MonthSignTabCell:Ctor(...)
  MonthSignTabCell.super.Ctor(self, ...)
  self._init = false
  self._cellData = {}
end

function MonthSignTabCell:OnCreate()
  self._tipBtn = self:GetChild("BackImage/DetailBtn")
  self._backImage = self:GetChild("BackImage")
  self._gainRoleTxt = self:GetChild("BackImage/ImageTxt1")
  self._gainRoleSkinTxt = self:GetChild("BackImage/ImageTxt2")
  self._totalSignNumTxt = self:GetChild("BackImage/SignTxt")
  self._unlockDaysBtn = self:GetChild("BackImage/UnLockBtn")
  self._cellPanel = self:GetChild("BackImage/Frame")
  self._cellFrame = TableFrame.Create(self._cellPanel, self, false, false, false)
  self._tipBtn:Subscribe_PointerClickEvent(self.OnTipBtnClick, self)
  self._unlockDaysBtn:Subscribe_PointerClickEvent(self.OnUnlockDaysBtnClick, self)
  self:GetChild("BackImage/DetailBtn/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1924))
end

function MonthSignTabCell:OnDestroy()
  self._cellFrame:Destroy()
end

function MonthSignTabCell:RefreshTabCell(refresh)
  local data = NekoData.BehaviorManager.BM_Welfare:GetMonthSignInfo()
  if data and (not self._init or refresh) then
    self._data = data
    if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.MonthSignOpen) then
      NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.MonthSignOpen)
    end
    while self._cellData[#self._cellData] do
      table.remove(self._cellData, #self._cellData)
    end
    self._totalSignNumTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1908, {
      self._data.signTotalNum
    }))
    local haveLock
    for id, record in pairs(self._data.allRecords) do
      if self._data.receivedIds[id] then
        table.insert(self._cellData, {record = record, tag = "received"})
      elseif record.cumulativeDays <= self._data.signTotalNum then
        table.insert(self._cellData, {record = record, tag = "get"})
      else
        haveLock = true
        table.insert(self._cellData, {record = record, tag = "lock"})
      end
    end
    table.sort(self._cellData, function(a, b)
      return a.record.id < b.record.id
    end)
    self._cellFrame:ReloadAllCell()
    self._unlockDaysBtn:SetActive(not self._data.getAll and haveLock)
  end
end

function MonthSignTabCell:OnTipBtnClick()
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(2)
end

function MonthSignTabCell:OnUnlockDaysBtnClick()
  DialogManager.CreateSingletonChildDialog("welfare.monthsign.monthsignbuydialog", self._delegate._dialogName, self._delegate:GetRootWindow())
end

function MonthSignTabCell:NumberOfCell(frame)
  return #self._cellData
end

function MonthSignTabCell:CellAtIndex(frame, index)
  return "welfare.monthsign.monthsigncell"
end

function MonthSignTabCell:DataAtIndex(frame, index)
  return self._cellData[index]
end

return MonthSignTabCell
