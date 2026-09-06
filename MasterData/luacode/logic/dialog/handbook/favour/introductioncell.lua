local IntroductionCell = class("IntroductionCell", Dialog)
IntroductionCell.AssetBundleName = "ui/layouts.tujian"
IntroductionCell.AssetName = "CharStoryCell1"

function IntroductionCell:Ctor(...)
  IntroductionCell.super.Ctor(self, ...)
end

function IntroductionCell:OnCreate()
  self._title = self:GetChild("Text")
  self._detail = self:GetChild("Detail")
  self._back = self:GetChild("Back")
  self._title_width, self._title_height = self._title:GetDeltaSize()
  self._detail_width, self._detail_height = self._detail:GetDeltaSize()
  self._back_width, self._back_height = self._back:GetDeltaSize()
  self._rootWindow_width, self._rootWindow_height = self._rootWindow:GetDeltaSize()
end

function IntroductionCell:OnDestroy()
end

function IntroductionCell:RefreshCell(data)
  self._title:SetText(data.title)
  self._detail:SetText(data.content)
  local _, textheight = self._detail:GetPreferredSize()
  if textheight > self._detail_height then
    local delta = textheight - self._detail_height
    self._title:SetDeltaSize(self._title_width, self._title_height + delta)
    self._detail:SetDeltaSize(self._detail_width, self._detail_height + delta)
    self._back:SetDeltaSize(self._back_width, self._back_height + delta)
    self._rootWindow:SetDeltaSize(self._rootWindow_width, self._rootWindow_height + delta)
  else
    self._title:SetDeltaSize(self._title_width, self._title_height)
    self._detail:SetDeltaSize(self._detail_width, self._detail_height)
    self._back:SetDeltaSize(self._back_width, self._back_height)
    self._rootWindow:SetDeltaSize(self._rootWindow_width, self._rootWindow_height)
  end
end

return IntroductionCell
