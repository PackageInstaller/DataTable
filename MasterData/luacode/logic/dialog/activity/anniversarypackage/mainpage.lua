local MainPage = class("MainPage", Dialog)
MainPage.AssetBundleName = "ui/layouts.activity1yearanniversary"
MainPage.AssetName = "Activity1YearOtherPoster"

function MainPage:Ctor(...)
  MainPage.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function MainPage:OnCreate()
  self:GetChild("Back/Poster/GoBtn/_Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2061))
  self._goBtn = self:GetChild("Back/Poster/GoBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
end

function MainPage:OnDestroy()
end

function MainPage:OnGoBtnClicked()
  if NekoData.BehaviorManager.BM_Anniversary:IsDisplayFirstDrama() then
    local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
    if dialog then
      local chatdialogId = tonumber(BeanManager.GetTableByName("dungeonselect.canniversaryspecialcfg"):GetRecorder(4).type)
      dialog:SetDialogLibraryId(chatdialogId, false, dialog.DialogType.MidAutumn)
    end
  else
    DialogManager.CreateSingletonDialog("activity.anniversary.anniversarymaindialog"):SetTabType(NekoData.BehaviorManager.BM_Game:GetLocalCache(DataCommon.LocalCache.AnniversaryOpenType))
  end
  DialogManager.DestroySingletonDialog("activity.anniversarypackage.anniversarypackagemaindialog")
end

return MainPage
