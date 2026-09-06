local StoryDetailCell = class("StoryDetailCell", Dialog)
StoryDetailCell.AssetBundleName = "ui/layouts.tujian"
StoryDetailCell.AssetName = "CharStoryDetailFrame"

function StoryDetailCell:Ctor(...)
  StoryDetailCell.super.Ctor(self, ...)
end

function StoryDetailCell:OnCreate()
  self._txt = self:GetChild("Detail")
  self._width, self._height = self._rootWindow:GetDeltaSize()
end

function StoryDetailCell:OnDestroy()
end

function StoryDetailCell:RefreshCell(data)
  self._txt:SetText(data)
  local _, textheight = self._txt:GetPreferredSize()
  self._rootWindow:SetDeltaSize(self._width, textheight)
end

return StoryDetailCell
