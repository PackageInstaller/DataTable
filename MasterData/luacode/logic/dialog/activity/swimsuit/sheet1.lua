local Sheet1 = class("Sheet1", Dialog)
Sheet1.AssetBundleName = "ui/layouts.activitysummer"
Sheet1.AssetName = "ActivitySummerOtherPoster"

function Sheet1:Ctor(...)
  Sheet1.super.Ctor(self, ...)
end

function Sheet1:OnCreate()
  self._goBtn = self:GetChild("Back/Poster/GoBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
end

function Sheet1:OnDestroy()
end

function Sheet1:SetData()
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityManagerID)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityManagerID)
end

function Sheet1:OnGoBtnClick()
  GlobalGameFSM:SetNumber("sceneLoadingId", 30015)
  self._delegate:OnBackBtnClicked()
end

return Sheet1
