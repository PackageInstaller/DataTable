local HorizontalTableFrameImpl = require("framework.ui.frame.table.horizontaltableframeimpl")
local HorizontalTableFrameInverseImpl = require("framework.ui.frame.table.horizontaltableframeinverseimpl")
local VerticalTableFrameImpl = require("framework.ui.frame.table.verticaltableframeimpl")
local VerticalTableFrameInverseImpl = require("framework.ui.frame.table.verticaltableframeinverseimpl")
local TableFrame = class("TableFrame")

function TableFrame:Ctor(window, delegate, isVertical, canSlide, isInverse, autoAlign)
  if not canSlide and canSlide ~= false then
    canSlide = true
  end
  local viewportName = "Viewport"
  if canSlide then
    viewportName = "ViewportSoftMask"
  end
  if isVertical then
    if isInverse then
      self._impl = VerticalTableFrameInverseImpl.Create(self, window, delegate, canSlide, autoAlign, viewportName)
    else
      self._impl = VerticalTableFrameImpl.Create(self, window, delegate, canSlide, autoAlign, viewportName)
    end
  elseif isInverse then
    self._impl = HorizontalTableFrameInverseImpl.Create(self, window, delegate, canSlide, autoAlign, viewportName)
  else
    self._impl = HorizontalTableFrameImpl.Create(self, window, delegate, canSlide, autoAlign, viewportName)
  end
end

function TableFrame:Destroy()
  self._impl:Destroy()
end

function TableFrame:ReloadAllCell()
  self._impl:ReloadAllCell()
end

function TableFrame:ReloadCellsAtIndex(indexList, isAnimate)
  if isAnimate then
    self._impl:ReloadCellsAtIndex(indexList, isAnimate)
  else
    self._impl:ReloadCellsAtIndex(indexList, false)
  end
end

function TableFrame:RemoveCellsAtIndex(indexList, isAnimate)
  if isAnimate then
    self._impl:RemoveCellsAtIndex(indexList, isAnimate)
  else
    self._impl:RemoveCellsAtIndex(indexList, false)
  end
end

function TableFrame:InsertCellsAtIndex(indexList, isAnimate, dontMoveCurrentPosition)
  if isAnimate then
    self._impl:InsertCellsAtIndex(indexList, isAnimate, dontMoveCurrentPosition)
  else
    self._impl:InsertCellsAtIndex(indexList, false, dontMoveCurrentPosition)
  end
end

function TableFrame:MoveToBottom(isAnimate)
  if isAnimate then
    self._impl:MoveToBottom(isAnimate)
  else
    self._impl:MoveToBottom(false)
  end
end

function TableFrame:MoveToTop(isAnimate)
  if isAnimate then
    self._impl:MoveToTop(isAnimate)
  else
    self._impl:MoveToTop(false)
  end
end

function TableFrame:MoveToRight(isAnimate)
  if isAnimate then
    self._impl:MoveToRight(isAnimate)
  else
    self._impl:MoveToRight(false)
  end
end

function TableFrame:MoveToLeft(isAnimate)
  if isAnimate then
    self._impl:MoveToLeft(isAnimate)
  else
    self._impl:MoveToLeft(false)
  end
end

function TableFrame:GetLeftIndex()
  return self._impl:GetLeftIndex()
end

function TableFrame:GetRightIndex()
  return self._impl:GetRightIndex()
end

function TableFrame:GetTopIndex()
  return self._impl:GetTopIndex()
end

function TableFrame:GetDownIndex()
  return self._impl:GetDownIndex()
end

function TableFrame:MoveLeftToIndex(desIndex, isAnimate)
  if isAnimate then
    self._impl:MoveLeftToIndex(desIndex, isAnimate)
  else
    self._impl:MoveLeftToIndex(desIndex, false)
  end
end

function TableFrame:MoveRightToIndex(desIndex, isAnimate)
  if isAnimate then
    self._impl:MoveRightToIndex(desIndex, isAnimate)
  else
    self._impl:MoveRightToIndex(desIndex, false)
  end
end

function TableFrame:MoveTopToIndex(desIndex, isAnimate)
  if isAnimate then
    self._impl:MoveTopToIndex(desIndex, isAnimate)
  else
    self._impl:MoveTopToIndex(desIndex, false)
  end
end

function TableFrame:MoveDownToIndex(desIndex, isAnimate)
  if isAnimate then
    self._impl:MoveDownToIndex(desIndex, isAnimate)
  else
    self._impl:MoveDownToIndex(desIndex, false)
  end
end

function TableFrame:FireEvent(eventName, ...)
  self._impl:FireEvent(eventName, ...)
end

function TableFrame:GetTotalLength()
  return self._impl:GetTotalLength()
end

function TableFrame:SetSlide(slide, showSoftMask)
  self._impl:SetSlide(slide, showSoftMask)
end

function TableFrame:SetMargin(oneValue, twoValue)
  self._impl:SetMargin(oneValue, twoValue)
end

function TableFrame:GetLogicCell(i)
  return self._impl._logicCells[i]
end

function TableFrame:GetCellDialog(logicCell)
  self._impl:GetCellDialog(logicCell)
end

function TableFrame:RefreshUIParticleClipper()
  return self._impl:RefreshUIParticleClipper()
end

function TableFrame:MoveToAssignedPos(pos, isAnimate)
  if isAnimate then
    self._impl:MoveToAssignedPos(pos, isAnimate)
  else
    self._impl:MoveToAssignedPos(pos, false)
  end
end

function TableFrame:GetCurrentPosition()
  return self._impl:GetCurrentPosition()
end

function TableFrame:MoveIndexToCentreInTime(desIndex, time)
  return self._impl:MoveIndexToCentreInTime(desIndex, time)
end

function TableFrame:SetSoftMaskActive(showSoftMask)
  self._impl:SetSoftMaskActive(showSoftMask)
end

return TableFrame
