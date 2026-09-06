local Cell5 = class("Cell5", Dialog)
Cell5.AssetBundleName = "ui/layouts.basetasklist"
Cell5.AssetName = "TaskMainGroupBtn2"

function Cell5:Ctor(...)
  Cell5.super.Ctor(self, ...)
end

function Cell5:OnCreate()
  self._btn = self:GetChild("GroupButton1")
  self._redDot = self:GetChild("GroupButton1/RedDot")
  self._btn:Subscribe_PointerClickEvent(self.OnTabBtnClicked, self)
end

function Cell5:OnDestroy()
end

function Cell5:RefreshCell(data)
end

function Cell5:OnTabBtnClicked()
  self._delegate:ToPage(self._cellData)
end

function Cell5:OnEvent(eventName, arg)
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

return Cell5
