-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/challenge/awarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CItemPinji = (BeanManager.GetTableByName)("item.citempinji")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local tm = (NekoData.BehaviorManager).BM_Task
local TableFrame = require("framework.ui.frame.table.tableframe")
local AwardDialog = class("AwardDialog", Dialog)
AwardDialog.AssetBundleName = "ui/layouts.activitysummer2"
AwardDialog.AssetName = "ActivitySummer2ChallengeReward"
AwardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AwardDialog, _ENV
  ((AwardDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
end

AwardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.copensummerreward")
  protocol:Send()
  self._titleText = self:GetChild("Back/Title")
  ;
  (self._titleText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2169))
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._closeBtn = self:GetChild("CloseBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._getAllBtn = self:GetChild("GetAllBtn")
  ;
  (self._getAllBtn):Subscribe_PointerClickEvent(self.OnGetAllBtnClicked, self)
  ;
  (self._getAllBtn):SetActive(false)
  self._getAllBtn_Text = self:GetChild("GetAllBtn/_Text")
  ;
  (self._getAllBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1944))
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_OnSOpensummerReward, nil)
end

AwardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

AwardDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._data = (self._bm):GetAwardList()
  ;
  (self._frame):ReloadAllCell()
  local moveToIdx = 0
  for i,v in ipairs(self._data) do
    if v.status == 1 then
      moveToIdx = i
      break
    end
  end
  do
    if moveToIdx ~= 0 then
      (self._frame):MoveTopToIndex(moveToIdx)
    else
      ;
      (self._frame):MoveToTop()
    end
  end
end

AwardDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

AwardDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

AwardDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "activity.swimsuitechoes.challenge.awardcell"
end

AwardDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

AwardDialog.OnCommitClick = function(self, index)
  -- function num : 0_8 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceivesummerreward")
  protocol.rewardId = index
  protocol:Send()
end

return AwardDialog

