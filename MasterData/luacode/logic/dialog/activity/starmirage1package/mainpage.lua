local MainPage = class("MainPage", Dialog)
MainPage.AssetBundleName = "ui/layouts.activitystar2"
MainPage.AssetName = "ActivityStar2OtherPoster"

function MainPage:Ctor(...)
  MainPage.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function MainPage:OnCreate()
  self:GetChild("Back/EndTimeBack/EndTime"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2125))
  self:GetChild("Back/Poster/GoBtn/_Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2061))
  self._goBtn = self:GetChild("Back/Poster/GoBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._tipsBtn = self:GetChild("Back/Poster/Tips")
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
end

function MainPage:OnDestroy()
end

function MainPage:OnGoBtnClicked()
  DialogManager.CreateSingletonDialog("activity.starmirage1.maindialog"):SetTabType(NekoData.BehaviorManager.BM_Game:GetLocalCache(DataCommon.LocalCache.StarMirageCopyOpenType))
  DialogManager.DestroySingletonDialog("activity.starmirage1package.maindialog")
end

function MainPage:OnTipsBtnClicked()
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(12)
end

return MainPage
