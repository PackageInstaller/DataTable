-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/birthday/maindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local MainDialog = class("MainDialog", Dialog)
MainDialog.AssetBundleName = "ui/layouts.activitylogin"
MainDialog.AssetName = "ActivityLoginMain"
MainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainDialog
  ((MainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

MainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._panel = self:GetChild("Frame")
  self._frame = (TabFrame.Create)(self._panel, self)
  self._sheetBtn = {}
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

      (self._sheetBtn)[i] = self:GetChild("Cutbtn" .. tostring(i))
      ;
      ((self._sheetBtn)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnSheetBtnClicked(i)
  end
, self)
    end
  end
  self:SetData()
  self:OnSheetBtnClicked(1)
end

MainDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._frame then
    (self._frame):Destroy()
  end
end

MainDialog.SetData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)
end

MainDialog.OnSheetBtnClicked = function(self, index)
  -- function num : 0_4
  if index == 1 then
    (self:ToFramePage(1)):SetData()
  else
    ;
    (self._bm):SendCGetShopInfo()
  end
end

MainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

MainDialog.ToFramePage = function(self, index)
  -- function num : 0_6 , upvalues : _ENV
  for key,value in pairs(self._sheetBtn) do
    value:SetSelected(key == index)
  end
  do return (self._frame):ToPage(index) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

MainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if index == 1 then
    return "activity.birthday.sheet1"
  else
    if index == 2 then
      return "activity.birthday.sheet2"
    end
  end
end

MainDialog.ToTaskDetail = function(self, storyId)
  -- function num : 0_8
  (self:ToFramePage(1)):SetData()
end

MainDialog.OpenShop = function(self, shopID)
  -- function num : 0_9
  (self:ToFramePage(2)):SetData(shopID)
end

return MainDialog

