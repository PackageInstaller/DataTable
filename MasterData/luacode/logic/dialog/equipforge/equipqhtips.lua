local EquipQHTips = class("EquipQHTips", Dialog)
EquipQHTips.AssetBundleName = "ui/layouts.equip"
EquipQHTips.AssetName = "EquipQHTips"

function EquipQHTips:Ctor(...)
  EquipQHTips.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function EquipQHTips:OnCreate()
  self._text = self:GetChild("BackImage/Txt")
  self._title = self:GetChild("BackImage/TitleBack/Title")
  self._confirmBtn = self:GetChild("BackImage/ConfirmButton")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function EquipQHTips:Init(contentID, titleid)
  self._text:SetText(NekoData.BehaviorManager.BM_Message:GetString(contentID))
  if titleid then
    self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(titleid))
  end
end

function EquipQHTips:OnBackBtnClicked()
  self:Destroy()
end

return EquipQHTips
