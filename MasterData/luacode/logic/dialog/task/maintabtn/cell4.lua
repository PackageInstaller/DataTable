local Cell4 = class("Cell4", Dialog)
Cell4.AssetBundleName = "ui/layouts.basetasklist"
Cell4.AssetName = "TaskMainGroupBtn4"

function Cell4:Ctor(...)
  Cell4.super.Ctor(self, ...)
end

function Cell4:OnCreate()
  self._btn = self:GetChild("AchievementBtn")
  self._redDot = self:GetChild("AchievementBtn/RedDot")
  self._btn:Subscribe_PointerClickEvent(self.OnTabBtnClicked, self)
end

function Cell4:OnDestroy()
end

function Cell4:RefreshCell(data)
end

function Cell4:OnTabBtnClicked()
  self._delegate:ToPage(self._cellData)
end

function Cell4:OnEvent(eventName, arg)
  if eventName == "SelectedTab" then
    self._btn:SetSelected(self._cellData == arg)
  elseif eventName == "RefreshRedDot" then
    if self._cellData ~= 5 then
      self._redDot:SetActive(arg:IsIndexTrue(self._cellData))
    else
      self._redDot:SetActive(NekoData.BehaviorManager.BM_Activity:GetManager(2):HasTaskUntakeAward())
    end
  end
end

return Cell4
