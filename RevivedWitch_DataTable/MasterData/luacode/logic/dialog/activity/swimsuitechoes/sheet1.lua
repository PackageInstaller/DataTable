-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/sheet1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Sheet1 = class("Sheet1", Dialog)
Sheet1.AssetBundleName = "ui/layouts.activitysummer2"
Sheet1.AssetName = "ActivitySummer2OtherPoster"
Sheet1.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Sheet1
  ((Sheet1.super).Ctor)(self, ...)
end

Sheet1.OnCreate = function(self)
  -- function num : 0_1
  self._goBtn = self:GetChild("Back/Poster/GoBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
end

Sheet1.OnDestroy = function(self)
  -- function num : 0_2
end

Sheet1.SetData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
end

Sheet1.OnGoBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  GlobalGameFSM:SetNumber("sceneLoadingId", 30017)
  ;
  (self._delegate):OnBackBtnClicked()
end

return Sheet1

