-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage1package/mainpage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MainPage = class("MainPage", Dialog)
MainPage.AssetBundleName = "ui/layouts.activitystar2"
MainPage.AssetName = "ActivityStar2OtherPoster"
MainPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainPage
  ((MainPage.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

MainPage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (self:GetChild("Back/EndTimeBack/EndTime")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2125))
  ;
  (self:GetChild("Back/Poster/GoBtn/_Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2061))
  self._goBtn = self:GetChild("Back/Poster/GoBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._tipsBtn = self:GetChild("Back/Poster/Tips")
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
end

MainPage.OnDestroy = function(self)
  -- function num : 0_2
end

MainPage.OnGoBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.starmirage1.maindialog")):SetTabType(((NekoData.BehaviorManager).BM_Game):GetLocalCache((DataCommon.LocalCache).StarMirageCopyOpenType))
  ;
  (DialogManager.DestroySingletonDialog)("activity.starmirage1package.maindialog")
end

MainPage.OnTipsBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(12)
end

return MainPage

