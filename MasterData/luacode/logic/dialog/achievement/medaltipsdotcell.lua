local MedalTipsDotCell = class("MedalTipsDotCell", Dialog)
MedalTipsDotCell.AssetBundleName = "ui/layouts.bag"
MedalTipsDotCell.AssetName = "ItemTipsAchievementMedalDot"

function MedalTipsDotCell:Ctor(...)
  MedalTipsDotCell.super.Ctor(self, ...)
end

function MedalTipsDotCell:OnCreate()
  self._light = self:GetChild("Dot1")
  self._dark = self:GetChild("Dot0")
end

function MedalTipsDotCell:OnDestroy()
end

function MedalTipsDotCell:RefreshCell(data)
  self._light:SetActive(data == self._delegate._curShowIndex)
  self._dark:SetActive(data ~= self._delegate._curShowIndex)
end

function MedalTipsDotCell:OnEvent(eventName, arg)
  if eventName == "Switch" then
    self._light:SetActive(self._cellData == self._delegate._curShowIndex)
    self._dark:SetActive(self._cellData ~= self._delegate._curShowIndex)
  end
end

return MedalTipsDotCell
