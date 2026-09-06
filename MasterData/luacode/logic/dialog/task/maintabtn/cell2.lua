local Cell2 = class("Cell2", Dialog)
Cell2.AssetBundleName = "ui/layouts.basetasklist"
Cell2.AssetName = "TaskMainGroupBtn1"

function Cell2:Ctor(...)
  Cell2.super.Ctor(self, ...)
end

function Cell2:OnCreate()
  self._btn = self:GetChild("GroupButton0")
  self._redDot = self:GetChild("GroupButton0/RedDot")
  self._btn:Subscribe_PointerClickEvent(self.OnTabBtnClicked, self)
end

function Cell2:OnDestroy()
end

function Cell2:RefreshCell(data)
end

function Cell2:OnTabBtnClicked()
  self._delegate:ToPage(self._cellData)
end

function Cell2:OnEvent(eventName, arg)
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

return Cell2
