local LoopHorizontalTableFrameImpl = require("framework.ui.frame.looptable.loophorizontaltableframeimpl")
local LoopTableFrame = class("LoopTableFrame")

function LoopTableFrame:Ctor(window, delegate, isVertical, canSlide, isInverse, autoAlign, loop, useSoftMask)
  if not canSlide and canSlide ~= false then
    canSlide = true
  end
  local viewportName = "Viewport"
  if useSoftMask then
    viewportName = "ViewportSoftMask"
  end
  if isVertical then
    if isInverse then
    else
    end
  elseif isInverse then
  else
    self._impl = LoopHorizontalTableFrameImpl.Create(self, window, delegate, canSlide, autoAlign, loop, viewportName)
  end
end

function LoopTableFrame:Destroy()
  self._impl:Destroy()
end

function LoopTableFrame:ReloadAllCell()
  self._impl:ReloadAllCell()
end

function LoopTableFrame:ReloadCellsAtIndex(indexList, isAnimate)
  if isAnimate then
    self._impl:ReloadCellsAtIndex(indexList, isAnimate)
  else
    self._impl:ReloadCellsAtIndex(indexList, false)
  end
end

function LoopTableFrame:RemoveCellsAtIndex(indexList, isAnimate)
end

function LoopTableFrame:InsertCellsAtIndex(indexList, isAnimate)
end

function LoopTableFrame:MoveToRight(isAnimate)
  if isAnimate then
    self._impl:MoveToRight(isAnimate)
  else
    self._impl:MoveToRight(false)
  end
end

function LoopTableFrame:MoveToLeft(isAnimate)
  if isAnimate then
    self._impl:MoveToLeft(isAnimate)
  else
    self._impl:MoveToLeft(false)
  end
end

function LoopTableFrame:MoveLeftToIndex(desIndex, isAnimate)
  if isAnimate then
    self._impl:MoveLeftToIndex(desIndex, isAnimate)
  else
    self._impl:MoveLeftToIndex(desIndex, false)
  end
end

function LoopTableFrame:MoveRightToIndex(desIndex, isAnimate)
  if isAnimate then
    self._impl:MoveRightToIndex(desIndex, isAnimate)
  else
    self._impl:MoveRightToIndex(desIndex, false)
  end
end

function LoopTableFrame:GetLeftIndex()
  return self._impl:GetLeftIndex()
end

function LoopTableFrame:GetRightIndex()
  return self._impl:GetRightIndex()
end

function LoopTableFrame:GetTotalLength()
  return self._impl:GetTotalLength()
end

function LoopTableFrame:SetMargin(oneValue, twoValue)
  self._impl:SetMargin(oneValue, twoValue)
end

function LoopTableFrame:FireEvent(eventName, ...)
  self._impl:FireEvent(eventName, ...)
end

function LoopTableFrame:SetSlide(slide, showSoftMask)
  self._impl:SetSlide(slide, showSoftMask)
end

function LoopTableFrame:RefreshUIParticleClipper()
  return self._impl:RefreshUIParticleClipper()
end

function LoopTableFrame:SetSoftMaskActive(showSoftMask)
  self._impl:SetSoftMaskActive(showSoftMask)
end

return LoopTableFrame
