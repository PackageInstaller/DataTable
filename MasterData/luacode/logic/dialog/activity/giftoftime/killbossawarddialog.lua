local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CItemPinji = BeanManager.GetTableByName("item.citempinji")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local tm = NekoData.BehaviorManager.BM_Task
local TableFrame = require("framework.ui.frame.table.tableframe")
local KillBossAwardDialog = class("KillBossAwardDialog", Dialog)
KillBossAwardDialog.AssetBundleName = "ui/layouts.battlepassnew"
KillBossAwardDialog.AssetName = "BattlePassNewWeeklyReward"

function KillBossAwardDialog:Ctor(...)
  KillBossAwardDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID)
end

function KillBossAwardDialog:OnCreate()
  self._titleText = self:GetChild("Back/Title")
  self._titleText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1949))
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._closeBtn = self:GetChild("CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._getAllBtn = self:GetChild("GetAllBtn")
  self._getAllBtn:Subscribe_PointerClickEvent(self.OnGetAllBtnClicked, self)
  self._getAllBtn_Text = self:GetChild("GetAllBtn/_Text")
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_SReturnAgainstBossInfo, nil)
  self._getAllBtn_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1944))
end

function KillBossAwardDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._frame then
    self._frame:Destroy()
  end
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function KillBossAwardDialog:Refresh()
  self._data = self._bm:GetAwardList()
  self._frame:ReloadAllCell()
  local moveToIdx = 0
  for k, v in ipairs(self._data) do
    if v.awardStatus == 1 then
      moveToIdx = k
      break
    end
  end
  if moveToIdx == 0 then
    for k, v in ipairs(self._data) do
      if v.awardStatus == 0 then
        moveToIdx = k
        break
      end
    end
  end
  if moveToIdx ~= 0 then
    self._frame:MoveTopToIndex(moveToIdx)
  else
    self._frame:MoveToBottom()
  end
  self._getAllBtn:SetInteractable(self._bm:HasWeekAward())
end

function KillBossAwardDialog:OnBackBtnClicked()
  self:Destroy()
end

function KillBossAwardDialog:NumberOfCell(frame)
  return #self._data
end

function KillBossAwardDialog:CellAtIndex(frame, index)
  return "activity.giftoftime.killbossawardcell"
end

function KillBossAwardDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function KillBossAwardDialog:OnCommitClick(index)
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cagainstbossgetweeklyawards")
  protocol.weeklyAwardId = index
  protocol:Send()
end

function KillBossAwardDialog:OnGetAllBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cagainstbossgetweeklyawards")
  protocol.weeklyAwardId = -1
  protocol:Send()
end

return KillBossAwardDialog
