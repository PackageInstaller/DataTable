local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CItemPinji = BeanManager.GetTableByName("item.citempinji")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local tm = NekoData.BehaviorManager.BM_Task
local TableFrame = require("framework.ui.frame.table.tableframe")
local AwardDialog = class("AwardDialog", Dialog)
AwardDialog.AssetBundleName = "ui/layouts.activitysummer2"
AwardDialog.AssetName = "ActivitySummer2ChallengeReward"

function AwardDialog:Ctor(...)
  AwardDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
end

function AwardDialog:OnCreate()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.copensummerreward")
  protocol:Send()
  self._titleText = self:GetChild("Back/Title")
  self._titleText:SetText(NekoData.BehaviorManager.BM_Message:GetString(2169))
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._closeBtn = self:GetChild("CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._getAllBtn = self:GetChild("GetAllBtn")
  self._getAllBtn:Subscribe_PointerClickEvent(self.OnGetAllBtnClicked, self)
  self._getAllBtn:SetActive(false)
  self._getAllBtn_Text = self:GetChild("GetAllBtn/_Text")
  self._getAllBtn_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1944))
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_OnSOpensummerReward, nil)
end

function AwardDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._frame then
    self._frame:Destroy()
  end
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function AwardDialog:Refresh()
  self._data = self._bm:GetAwardList()
  self._frame:ReloadAllCell()
  local moveToIdx = 0
  for i, v in ipairs(self._data) do
    if v.status == 1 then
      moveToIdx = i
      break
    end
  end
  if moveToIdx ~= 0 then
    self._frame:MoveTopToIndex(moveToIdx)
  else
    self._frame:MoveToTop()
  end
end

function AwardDialog:OnBackBtnClicked()
  self:Destroy()
end

function AwardDialog:NumberOfCell(frame)
  return #self._data
end

function AwardDialog:CellAtIndex(frame, index)
  return "activity.swimsuitechoes.challenge.awardcell"
end

function AwardDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function AwardDialog:OnCommitClick(index)
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.creceivesummerreward")
  protocol.rewardId = index
  protocol:Send()
end

return AwardDialog
