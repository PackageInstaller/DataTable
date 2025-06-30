-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/giftoftime/killbossawarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CItemPinji = (BeanManager.GetTableByName)("item.citempinji")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local tm = (NekoData.BehaviorManager).BM_Task
local TableFrame = require("framework.ui.frame.table.tableframe")
local KillBossAwardDialog = class("KillBossAwardDialog", Dialog)
KillBossAwardDialog.AssetBundleName = "ui/layouts.battlepassnew"
KillBossAwardDialog.AssetName = "BattlePassNewWeeklyReward"
KillBossAwardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : KillBossAwardDialog, _ENV
  ((KillBossAwardDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)
end

KillBossAwardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame
  self._titleText = self:GetChild("Back/Title")
  ;
  (self._titleText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1949))
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._closeBtn = self:GetChild("CloseBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._getAllBtn = self:GetChild("GetAllBtn")
  ;
  (self._getAllBtn):Subscribe_PointerClickEvent(self.OnGetAllBtnClicked, self)
  self._getAllBtn_Text = self:GetChild("GetAllBtn/_Text")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_SReturnAgainstBossInfo, nil)
  ;
  (self._getAllBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1944))
end

KillBossAwardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

KillBossAwardDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._data = (self._bm):GetAwardList()
  ;
  (self._frame):ReloadAllCell()
  local moveToIdx = 0
  for k,v in ipairs(self._data) do
    if v.awardStatus == 1 then
      moveToIdx = k
      break
    end
  end
  do
    if moveToIdx == 0 then
      for k,v in ipairs(self._data) do
        if v.awardStatus == 0 then
          moveToIdx = k
          break
        end
      end
    end
    do
      if moveToIdx ~= 0 then
        (self._frame):MoveTopToIndex(moveToIdx)
      else
        ;
        (self._frame):MoveToBottom()
      end
      ;
      (self._getAllBtn):SetInteractable((self._bm):HasWeekAward())
    end
  end
end

KillBossAwardDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

KillBossAwardDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

KillBossAwardDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "activity.giftoftime.killbossawardcell"
end

KillBossAwardDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

KillBossAwardDialog.OnCommitClick = function(self, index)
  -- function num : 0_8 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cagainstbossgetweeklyawards")
  protocol.weeklyAwardId = index
  protocol:Send()
end

KillBossAwardDialog.OnGetAllBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cagainstbossgetweeklyawards")
  protocol.weeklyAwardId = -1
  protocol:Send()
end

return KillBossAwardDialog

