local GuideNextDialog = class("GuideNextDialog", Dialog)
GuideNextDialog.AssetBundleName = "ui/layouts.guide"
GuideNextDialog.AssetName = "GuideNext"

function GuideNextDialog:Ctor(...)
  GuideNextDialog.super.Ctor(self, ...)
  self._groupName = "Guide"
end

function GuideNextDialog:OnCreate()
  self._next = self:GetChild("Next")
  self._nextTxt = self:GetChild("Next/Next")
  self._arrow = {}
  self._arrow.Up = self:GetChild("Next/Arrow2")
  self._arrow.Down = self:GetChild("Next/Arrow")
  self._arrow.Left = self:GetChild("Next/Arrow3")
  self._arrow.Right = self:GetChild("Next/Arrow4")
  for k, v in pairs(self._arrow) do
    self._arrow[k]:SetActive(false)
  end
  self._width, self._height = self._next:GetRectSize()
end

function GuideNextDialog:OnDestroy()
end

function GuideNextDialog:SetGuideId(guideId)
  if guideId == 4 then
    self._nextTxt:SetActive(false)
    self._equipChangeTxt = self:GetChild("Next/EquipGuide")
    self._equipChangeTxt:SetActive(true)
  end
end

function GuideNextDialog:SetTextPoint(width, height, posX, posY, direction)
  for k, v in pairs(self._arrow) do
    if direction == k then
      self._arrow[k]:SetActive(true)
      if direction == "Up" then
        self._next:SetAnchoredPosition(posX, posY - height / 2 - self._height / 2)
      elseif direction == "Down" then
        self._next:SetAnchoredPosition(posX, posY + height / 2 + self._height / 2)
      elseif direction == "Left" then
        self._next:SetAnchoredPosition(posX + width / 2 + self._width / 2, posY)
      elseif direction == "Right" then
        self._next:SetAnchoredPosition(posX - width / 2 - self._width / 2, posY)
      end
    else
      self._arrow[k]:SetActive(false)
    end
  end
end

return GuideNextDialog
