-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage1/dailysupplydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CAnniversarySpirit = (BeanManager.GetTableByName)("dungeonselect.cmirrorspirit")
local DailySupplyDialog = class("DailySupplyDialog", Dialog)
DailySupplyDialog.AssetBundleName = "ui/layouts.activitystar2"
DailySupplyDialog.AssetName = "ActivityStar2Account"
DailySupplyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DailySupplyDialog
  ((DailySupplyDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._list = nil
end

DailySupplyDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  self._panel = self:GetChild("BackImage/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, false, true)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshActivityDailySupply, Common.n_RefreshActivityDailySupply, nil)
  ;
  (self:GetChild("BackImage/Title")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1998))
  ;
  (self:GetChild("BackImage/Tips")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2002))
  ;
  (self:GetChild("BackImage/TimeTxt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2118))
end

DailySupplyDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
end

DailySupplyDialog.OnRefreshActivityDailySupply = function(self, notification)
  -- function num : 0_3 , upvalues : _ENV
  if (notification.userInfo).activityId == (DataCommon.Activities).StarMirageCopy then
    self:Init()
  end
end

DailySupplyDialog.Init = function(self)
  -- function num : 0_4 , upvalues : _ENV, CAnniversarySpirit
  self._list = ((NekoData.BehaviorManager).BM_StarMirageCopy):GetDailySupplyData()
  for i,v in ipairs(self._list) do
    v.record = CAnniversarySpirit:GetRecorder(v.id)
  end
  ;
  (table.sort)(self._list, function(a, b)
    -- function num : 0_4_0
    if (a.record).type >= (b.record).type then
      do return (a.record).type == (b.record).type end
      do return a.id < b.id end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

DailySupplyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

DailySupplyDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._list
end

DailySupplyDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "activity.starmirage1.dailysupplycell"
end

DailySupplyDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._list)[index]
end

return DailySupplyDialog

