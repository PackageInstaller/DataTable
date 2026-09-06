local VerticalGridFrameImpl = require("framework.ui.frame.grid.verticalgridframeimpl")
local VerticalGridFrameInverseImpl = require("framework.ui.frame.grid.verticalgridframeinverseimpl")
local HorizontalGridFrameImpl = require("framework.ui.frame.grid.horizontalgridframeimpl")
local GridFrame = class("GridFrame")

function GridFrame:Ctor(window, delegate, isVertical, columnOrRowNums, canSlide, isInverse, rightToLeftOrDownToTop)
  if not canSlide and canSlide ~= false then
    canSlide = true
  end
  local viewportName = "Viewport"
  if canSlide then
    viewportName = "ViewportSoftMask"
  end
  if isVertical then
    if isInverse then
      self._impl = VerticalGridFrameInverseImpl.Create(self, window, delegate, columnOrRowNums, canSlide, viewportName, rightToLeftOrDownToTop)
    else
      self._impl = VerticalGridFrameImpl.Create(self, window, delegate, columnOrRowNums, canSlide, viewportName, rightToLeftOrDownToTop)
    end
  elseif isInverse then
  else
    self._impl = HorizontalGridFrameImpl.Create(self, window, delegate, columnOrRowNums, canSlide, viewportName, rightToLeftOrDownToTop)
  end
end

function GridFrame:Destroy()
  self._impl:Destroy()
end

function GridFrame:ReloadAllCell()
  self._impl:ReloadAllCell()
end

function GridFrame:InsertCellsAtIndex(indexList, isAnimate)
  if isAnimate then
    self._impl:InsertCellsAtIndex(indexList, isAnimate)
  else
    self._impl:InsertCellsAtIndex(indexList, false)
  end
end

function GridFrame:RemoveCellsAtIndex(indexList, isAnimate)
  if isAnimate then
    self._impl:RemoveCellsAtIndex(indexList, isAnimate)
  else
    self._impl:RemoveCellsAtIndex(indexList, false)
  end
end

function GridFrame:ReloadCellsAtIndex(indexList, isAnimate)
  if isAnimate then
    self._impl:ReloadCellsAtIndex(indexList, isAnimate)
  else
    self._impl:ReloadCellsAtIndex(indexList, false)
  end
end

function GridFrame:MoveToTop(isAnimate)
  if isAnimate then
    self._impl:MoveToTop(isAnimate)
  else
    self._impl:MoveToTop(false)
  end
end

function GridFrame:MoveToBottom(isAnimate)
  if isAnimate then
    self._impl:MoveToBottom(isAnimate)
  else
    self._impl:MoveToBottom(false)
  end
end

function GridFrame:MoveToLeft(isAnimate)
  if isAnimate then
    self._impl:MoveToLeft(isAnimate)
  else
    self._impl:MoveToLeft(false)
  end
end

function GridFrame:MoveToRight(isAnimate)
  if isAnimate then
    self._impl:MoveToRight(isAnimate)
  else
    self._impl:MoveToRight(false)
  end
end

function GridFrame:MoveTopToIndex(desIndex, isAnimate)
  if isAnimate then
    self._impl:MoveTopToIndex(desIndex, isAnimate)
  else
    self._impl:MoveTopToIndex(desIndex, false)
  end
end

function GridFrame:MoveDownToIndex(desIndex, isAnimate)
  if isAnimate then
    self._impl:MoveDownToIndex(desIndex, isAnimate)
  else
    self._impl:MoveDownToIndex(desIndex, false)
  end
end

function GridFrame:MoveLeftToIndex(desIndex, isAnimate)
  if isAnimate then
    self._impl:MoveLeftToIndex(desIndex, isAnimate)
  else
    self._impl:MoveLeftToIndex(desIndex, false)
  end
end

function GridFrame:MoveRightToIndex(desIndex, isAnimate)
  if isAnimate then
    self._impl:MoveRightToIndex(desIndex, isAnimate)
  else
    self._impl:MoveRightToIndex(desIndex, false)
  end
end

function GridFrame:MoveToAssignedPos(pos, isAnimate)
  if isAnimate then
    self._impl:MoveToAssignedPos(pos, isAnimate)
  else
    self._impl:MoveToAssignedPos(pos, false)
  end
end

function GridFrame:FireEvent(eventName, ...)
  self._impl:FireEvent(eventName, ...)
end

function GridFrame:FireIndexCellEvent(eventName, index, ...)
  self._impl:FireIndexCellEvent(eventName, index, ...)
end

function GridFrame:SetSlide(slide, showSoftMask)
  self._impl:SetSlide(slide, showSoftMask)
end

function GridFrame:SetMargin(oneValue, twoValue)
  self._impl:SetMargin(oneValue, twoValue)
end

function GridFrame:GetTotalLength()
  return self._impl:GetTotalLength()
end

function GridFrame:SendMessageToInstance(name, args)
  self._impl:SendMessageToInstance(name, args)
end

function GridFrame:GetLogicCell(i)
  return self._impl._logicCells[i]
end

function GridFrame:GetCellDialog(logicCell)
  self._impl:GetCellDialog(logicCell)
end

function GridFrame:GetCurrentPosition()
  return self._impl:GetCurrentPosition()
end

function GridFrame:RefreshUIParticleClipper()
  return self._impl:RefreshUIParticleClipper()
end

function GridFrame:SetSoftMaskActive(showSoftMask)
  self._impl:SetSoftMaskActive(showSoftMask)
end

return GridFrame
