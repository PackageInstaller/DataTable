-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/anniversarypackage/mainpage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MainPage = class("MainPage", Dialog)
MainPage.AssetBundleName = "ui/layouts.activity1yearanniversary"
MainPage.AssetName = "Activity1YearOtherPoster"
MainPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainPage
  ((MainPage.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

MainPage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (self:GetChild("Back/Poster/GoBtn/_Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2061))
  self._goBtn = self:GetChild("Back/Poster/GoBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
end

MainPage.OnDestroy = function(self)
  -- function num : 0_2
end

MainPage.OnGoBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Anniversary):IsDisplayFirstDrama() then
    local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
    if dialog then
      local chatdialogId = tonumber((((BeanManager.GetTableByName)("dungeonselect.canniversaryspecialcfg")):GetRecorder(4)).type)
      dialog:SetDialogLibraryId(chatdialogId, false, (dialog.DialogType).MidAutumn)
    end
  else
    do
      ;
      ((DialogManager.CreateSingletonDialog)("activity.anniversary.anniversarymaindialog")):SetTabType(((NekoData.BehaviorManager).BM_Game):GetLocalCache((DataCommon.LocalCache).AnniversaryOpenType))
      ;
      (DialogManager.DestroySingletonDialog)("activity.anniversarypackage.anniversarypackagemaindialog")
    end
  end
end

return MainPage

