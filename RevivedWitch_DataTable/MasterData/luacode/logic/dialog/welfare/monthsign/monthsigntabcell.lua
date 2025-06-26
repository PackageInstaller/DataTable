-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/monthsign/monthsigntabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local MonthSignTabCell = class("MonthSignTabCell", Dialog)
MonthSignTabCell.AssetBundleName = "ui/layouts.welfare"
MonthSignTabCell.AssetName = "WelfareSign30Day"
MonthSignTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonthSignTabCell
  ((MonthSignTabCell.super).Ctor)(self, ...)
  self._init = false
  self._cellData = {}
end

MonthSignTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._tipBtn = self:GetChild("BackImage/DetailBtn")
  self._backImage = self:GetChild("BackImage")
  self._gainRoleTxt = self:GetChild("BackImage/ImageTxt1")
  self._gainRoleSkinTxt = self:GetChild("BackImage/ImageTxt2")
  self._totalSignNumTxt = self:GetChild("BackImage/SignTxt")
  self._unlockDaysBtn = self:GetChild("BackImage/UnLockBtn")
  self._cellPanel = self:GetChild("BackImage/Frame")
  self._cellFrame = (TableFrame.Create)(self._cellPanel, self, false, false, false)
  ;
  (self._tipBtn):Subscribe_PointerClickEvent(self.OnTipBtnClick, self)
  ;
  (self._unlockDaysBtn):Subscribe_PointerClickEvent(self.OnUnlockDaysBtnClick, self)
  ;
  (self:GetChild("BackImage/DetailBtn/Txt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1924))
end

MonthSignTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._cellFrame):Destroy()
end

MonthSignTabCell.RefreshTabCell = function(self, refresh)
  -- function num : 0_3 , upvalues : _ENV
  local data = ((NekoData.BehaviorManager).BM_Welfare):GetMonthSignInfo()
  if data and (not self._init or refresh) then
    self._data = data
    if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).MonthSignOpen) then
      ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).MonthSignOpen)
    end
    while (self._cellData)[#self._cellData] do
      (table.remove)(self._cellData, #self._cellData)
    end
    ;
    (self._totalSignNumTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1908, {(self._data).signTotalNum}))
    local haveLock = nil
    for id,record in pairs((self._data).allRecords) do
      if ((self._data).receivedIds)[id] then
        (table.insert)(self._cellData, {record = record, tag = "received"})
      else
        if record.cumulativeDays <= (self._data).signTotalNum then
          (table.insert)(self._cellData, {record = record, tag = "get"})
        else
          haveLock = true
          ;
          (table.insert)(self._cellData, {record = record, tag = "lock"})
        end
      end
    end
    ;
    (table.sort)(self._cellData, function(a, b)
    -- function num : 0_3_0
    do return (a.record).id < (b.record).id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    ;
    (self._cellFrame):ReloadAllCell()
    ;
    (self._unlockDaysBtn):SetActive((not (self._data).getAll and haveLock))
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

MonthSignTabCell.OnTipBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(2)
end

MonthSignTabCell.OnUnlockDaysBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.CreateSingletonChildDialog)("welfare.monthsign.monthsignbuydialog", (self._delegate)._dialogName, (self._delegate):GetRootWindow())
end

MonthSignTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._cellData
end

MonthSignTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "welfare.monthsign.monthsigncell"
end

MonthSignTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._cellData)[index]
end

return MonthSignTabCell

