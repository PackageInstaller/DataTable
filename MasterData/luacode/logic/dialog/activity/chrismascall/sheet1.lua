-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/chrismascall/sheet1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CTimedActivitySwitch = (BeanManager.GetTableByName)("activity.ctimedactivityswitch")
local ChristmasUnlockRecord = CTimedActivitySwitch:GetRecorder((DataCommon.Activities).Christmas)
local CDungeonSelectMainLine = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local Sheet1 = class("Sheet1", Dialog)
Sheet1.AssetBundleName = "ui/layouts.activitychristmascall"
Sheet1.AssetName = "ActivityChristmasStart"
Sheet1.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Sheet1
  ((Sheet1.super).Ctor)(self, ...)
end

Sheet1.OnCreate = function(self)
  -- function num : 0_1
  self._goBtn = self:GetChild("GoBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self:SetData()
end

Sheet1.OnDestroy = function(self)
  -- function num : 0_2
end

Sheet1.SetData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._goBtn):SetActive(((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).Christmas))
end

Sheet1.OnGoBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).Christmas) then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cgetchristmasactivityinfo")
    if protocol then
      protocol:Send()
    end
    ;
    (DialogManager.DestroySingletonDialog)("activity.chrismascall.maindialog")
  end
end

return Sheet1

