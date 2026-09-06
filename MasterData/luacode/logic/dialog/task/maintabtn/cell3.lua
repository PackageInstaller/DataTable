local Cell3 = class("Cell3", Dialog)
Cell3.AssetBundleName = "ui/layouts.basetasklist"
Cell3.AssetName = "TaskMainGroupBtn3"

function Cell3:Ctor(...)
  Cell3.super.Ctor(self, ...)
end

function Cell3:OnCreate()
  self._btn = self:GetChild("CharGroupBtn")
  self._redDot = self:GetChild("CharGroupBtn/RedDot")
  self._btn:Subscribe_PointerClickEvent(self.OnTabBtnClicked, self)
end

function Cell3:OnDestroy()
end

function Cell3:RefreshCell(data)
end

function Cell3:OnTabBtnClicked()
  self._delegate:ToPage(self._cellData)
end

function Cell3:OnEvent(eventName, arg)
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

return Cell3
