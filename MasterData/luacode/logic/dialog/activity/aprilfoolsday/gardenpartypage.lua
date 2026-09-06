local CStringres = BeanManager.GetTableByName("message.cstringres")
local GardenPartyPage = class("GardenPartyPage", Dialog)
GardenPartyPage.AssetBundleName = "ui/layouts.activityaprilfools"
GardenPartyPage.AssetName = "ActivityAprilFoolsInto"

function GardenPartyPage:Ctor(...)
  GardenPartyPage.super.Ctor(self, ...)
end

function GardenPartyPage:OnCreate()
  self._activeTimeTxt = self:GetChild("ActiveTime")
  self._goBtn = self:GetChild("GotoBtn")
  self._goBtnTxt = self:GetChild("GotoBtn/_Text2")
  self._redDot = self:GetChild("GotoBtn/Dot")
  self._redDot:SetActive(false)
  self._tipsBtn = self:GetChild("Tips")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._activeTimeTxt:SetText(TextManager.GetText(CStringres:GetRecorder(1792).msgTextID))
  self._goBtnTxt:SetText(TextManager.GetText(CStringres:GetRecorder(1718).msgTextID))
end

function GardenPartyPage:OnDestroy()
end

function GardenPartyPage:OnGoBtnClicked()
  DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolstowermaindialog")
end

function GardenPartyPage:OnTipsBtnClicked()
  DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolsdaytipsdialog"):SetData(CStringres:GetRecorder(1760).msgTextID)
end

return GardenPartyPage
