local Cell6 = class("Cell6", Dialog)
Cell6.AssetBundleName = "ui/layouts.basetasklist"
Cell6.AssetName = "TaskMainGroupBtn6"

function Cell6:Ctor(...)
  Cell6.super.Ctor(self, ...)
end

function Cell6:OnCreate()
  self._btn = self:GetChild("BattlePassBtn")
  self._redDot = self:GetChild("BattlePassBtn/RedDot")
  self._btn:Subscribe_PointerClickEvent(self.OnTabBtnClicked, self)
end

function Cell6:OnDestroy()
end

function Cell6:RefreshCell(data)
end

function Cell6:OnTabBtnClicked()
  self._delegate:ToPage(self._cellData)
end

function Cell6:OnEvent(eventName, arg)
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

return Cell6
