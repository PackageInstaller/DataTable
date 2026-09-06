local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CAnniversarySpirit = BeanManager.GetTableByName("dungeonselect.canniversaryspirit")
local DailySupplyDialog = class("DailySupplyDialog", Dialog)
DailySupplyDialog.AssetBundleName = "ui/layouts.activity1yearanniversary"
DailySupplyDialog.AssetName = "Activity1YearAnniversaryAccount"

function DailySupplyDialog:Ctor(...)
  DailySupplyDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._list = nil
end

function DailySupplyDialog:OnCreate()
  self:GetChild("BackImage/Reward"):SetActive(false)
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  self._panel = self:GetChild("BackImage/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, false, true)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
  LuaNotificationCenter.AddObserver(self, self.OnSAnniversarySupply, Common.n_RefreshAnniversaryDailySupply, nil)
  self:GetChild("BackImage/Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1998))
  self:GetChild("BackImage/Tips"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2002))
  self:GetChild("BackImage/TimeTxt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2004))
end

function DailySupplyDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
end

function DailySupplyDialog:OnSAnniversarySupply()
  self:Init()
end

function DailySupplyDialog:Init()
  self._list = NekoData.BehaviorManager.BM_Anniversary:GetDailySupplyData()
  for i, v in ipairs(self._list) do
    v.record = CAnniversarySpirit:GetRecorder(v.id)
  end
  table.sort(self._list, function(a, b)
    if a.record.type ~= b.record.type then
      return a.record.type < b.record.type
    else
      return a.id < b.id
    end
  end)
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function DailySupplyDialog:OnBackBtnClicked()
  self:Destroy()
end

function DailySupplyDialog:NumberOfCell(frame)
  return #self._list
end

function DailySupplyDialog:CellAtIndex(frame, index)
  return "activity.anniversary.dailysupplycell"
end

function DailySupplyDialog:DataAtIndex(frame, index)
  return self._list[index]
end

return DailySupplyDialog
