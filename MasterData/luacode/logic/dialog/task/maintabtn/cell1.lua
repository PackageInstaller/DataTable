local Cell1 = class("Cell1", Dialog)
Cell1.AssetBundleName = "ui/layouts.basetasklist"
Cell1.AssetName = "TaskMainGroupBtn5"

function Cell1:Ctor(...)
  Cell1.super.Ctor(self, ...)
end

function Cell1:OnCreate()
  self._btn = self:GetChild("BattlePassBtn")
  self._redDot = self:GetChild("BattlePassBtn/RedDot")
  self._btn:Subscribe_PointerClickEvent(self.OnTabBtnClicked, self)
end

function Cell1:OnDestroy()
end

function Cell1:RefreshCell(data)
end

function Cell1:OnTabBtnClicked()
  self._delegate:ToPage(self._cellData)
end

function Cell1:OnEvent(eventName, arg)
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

return Cell1
