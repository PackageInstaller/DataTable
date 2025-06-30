-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/frame/table/tableframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HorizontalTableFrameImpl = require("framework.ui.frame.table.horizontaltableframeimpl")
local HorizontalTableFrameInverseImpl = require("framework.ui.frame.table.horizontaltableframeinverseimpl")
local VerticalTableFrameImpl = require("framework.ui.frame.table.verticaltableframeimpl")
local VerticalTableFrameInverseImpl = require("framework.ui.frame.table.verticaltableframeinverseimpl")
local TableFrame = class("TableFrame")
TableFrame.Ctor = function(self, window, delegate, isVertical, canSlide, isInverse, autoAlign)
  -- function num : 0_0 , upvalues : VerticalTableFrameInverseImpl, VerticalTableFrameImpl, HorizontalTableFrameInverseImpl, HorizontalTableFrameImpl
  if not canSlide and canSlide ~= false then
    canSlide = true
  end
  local viewportName = "Viewport"
  if canSlide then
    viewportName = "ViewportSoftMask"
  end
  if isVertical then
    if isInverse then
      self._impl = (VerticalTableFrameInverseImpl.Create)(self, window, delegate, canSlide, autoAlign, viewportName)
    else
      self._impl = (VerticalTableFrameImpl.Create)(self, window, delegate, canSlide, autoAlign, viewportName)
    end
  else
    if isInverse then
      self._impl = (HorizontalTableFrameInverseImpl.Create)(self, window, delegate, canSlide, autoAlign, viewportName)
    else
      self._impl = (HorizontalTableFrameImpl.Create)(self, window, delegate, canSlide, autoAlign, viewportName)
    end
  end
end

TableFrame.Destroy = function(self)
  -- function num : 0_1
  (self._impl):Destroy()
end

TableFrame.ReloadAllCell = function(self)
  -- function num : 0_2
  (self._impl):ReloadAllCell()
end

TableFrame.ReloadCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_3
  if isAnimate then
    (self._impl):ReloadCellsAtIndex(indexList, isAnimate)
  else
    ;
    (self._impl):ReloadCellsAtIndex(indexList, false)
  end
end

TableFrame.RemoveCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_4
  if isAnimate then
    (self._impl):RemoveCellsAtIndex(indexList, isAnimate)
  else
    ;
    (self._impl):RemoveCellsAtIndex(indexList, false)
  end
end

TableFrame.InsertCellsAtIndex = function(self, indexList, isAnimate, dontMoveCurrentPosition)
  -- function num : 0_5
  if isAnimate then
    (self._impl):InsertCellsAtIndex(indexList, isAnimate, dontMoveCurrentPosition)
  else
    ;
    (self._impl):InsertCellsAtIndex(indexList, false, dontMoveCurrentPosition)
  end
end

TableFrame.MoveToBottom = function(self, isAnimate)
  -- function num : 0_6
  if isAnimate then
    (self._impl):MoveToBottom(isAnimate)
  else
    ;
    (self._impl):MoveToBottom(false)
  end
end

TableFrame.MoveToTop = function(self, isAnimate)
  -- function num : 0_7
  if isAnimate then
    (self._impl):MoveToTop(isAnimate)
  else
    ;
    (self._impl):MoveToTop(false)
  end
end

TableFrame.MoveToRight = function(self, isAnimate)
  -- function num : 0_8
  if isAnimate then
    (self._impl):MoveToRight(isAnimate)
  else
    ;
    (self._impl):MoveToRight(false)
  end
end

TableFrame.MoveToLeft = function(self, isAnimate)
  -- function num : 0_9
  if isAnimate then
    (self._impl):MoveToLeft(isAnimate)
  else
    ;
    (self._impl):MoveToLeft(false)
  end
end

TableFrame.GetLeftIndex = function(self)
  -- function num : 0_10
  return (self._impl):GetLeftIndex()
end

TableFrame.GetRightIndex = function(self)
  -- function num : 0_11
  return (self._impl):GetRightIndex()
end

TableFrame.GetTopIndex = function(self)
  -- function num : 0_12
  return (self._impl):GetTopIndex()
end

TableFrame.GetDownIndex = function(self)
  -- function num : 0_13
  return (self._impl):GetDownIndex()
end

TableFrame.MoveLeftToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_14
  if isAnimate then
    (self._impl):MoveLeftToIndex(desIndex, isAnimate)
  else
    ;
    (self._impl):MoveLeftToIndex(desIndex, false)
  end
end

TableFrame.MoveRightToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_15
  if isAnimate then
    (self._impl):MoveRightToIndex(desIndex, isAnimate)
  else
    ;
    (self._impl):MoveRightToIndex(desIndex, false)
  end
end

TableFrame.MoveTopToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_16
  if isAnimate then
    (self._impl):MoveTopToIndex(desIndex, isAnimate)
  else
    ;
    (self._impl):MoveTopToIndex(desIndex, false)
  end
end

TableFrame.MoveDownToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_17
  if isAnimate then
    (self._impl):MoveDownToIndex(desIndex, isAnimate)
  else
    ;
    (self._impl):MoveDownToIndex(desIndex, false)
  end
end

TableFrame.FireEvent = function(self, eventName, ...)
  -- function num : 0_18
  (self._impl):FireEvent(eventName, ...)
end

TableFrame.GetTotalLength = function(self)
  -- function num : 0_19
  return (self._impl):GetTotalLength()
end

TableFrame.SetSlide = function(self, slide, showSoftMask)
  -- function num : 0_20
  (self._impl):SetSlide(slide, showSoftMask)
end

TableFrame.SetMargin = function(self, oneValue, twoValue)
  -- function num : 0_21
  (self._impl):SetMargin(oneValue, twoValue)
end

TableFrame.GetLogicCell = function(self, i)
  -- function num : 0_22
  return ((self._impl)._logicCells)[i]
end

TableFrame.GetCellDialog = function(self, logicCell)
  -- function num : 0_23
  (self._impl):GetCellDialog(logicCell)
end

TableFrame.RefreshUIParticleClipper = function(self)
  -- function num : 0_24
  return (self._impl):RefreshUIParticleClipper()
end

TableFrame.MoveToAssignedPos = function(self, pos, isAnimate)
  -- function num : 0_25
  if isAnimate then
    (self._impl):MoveToAssignedPos(pos, isAnimate)
  else
    ;
    (self._impl):MoveToAssignedPos(pos, false)
  end
end

TableFrame.GetCurrentPosition = function(self)
  -- function num : 0_26
  return (self._impl):GetCurrentPosition()
end

TableFrame.MoveIndexToCentreInTime = function(self, desIndex, time)
  -- function num : 0_27
  return (self._impl):MoveIndexToCentreInTime(desIndex, time)
end

TableFrame.SetSoftMaskActive = function(self, showSoftMask)
  -- function num : 0_28
  (self._impl):SetSoftMaskActive(showSoftMask)
end

return TableFrame

