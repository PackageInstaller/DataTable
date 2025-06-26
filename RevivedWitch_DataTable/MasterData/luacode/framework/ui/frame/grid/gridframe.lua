-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/frame/grid/gridframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local VerticalGridFrameImpl = require("framework.ui.frame.grid.verticalgridframeimpl")
local VerticalGridFrameInverseImpl = require("framework.ui.frame.grid.verticalgridframeinverseimpl")
local HorizontalGridFrameImpl = require("framework.ui.frame.grid.horizontalgridframeimpl")
local GridFrame = class("GridFrame")
GridFrame.Ctor = function(self, window, delegate, isVertical, columnOrRowNums, canSlide, isInverse, rightToLeftOrDownToTop)
  -- function num : 0_0 , upvalues : VerticalGridFrameInverseImpl, VerticalGridFrameImpl, HorizontalGridFrameImpl
  if not canSlide and canSlide ~= false then
    canSlide = true
  end
  local viewportName = "Viewport"
  if canSlide then
    viewportName = "ViewportSoftMask"
  end
  if isVertical then
    if isInverse then
      self._impl = (VerticalGridFrameInverseImpl.Create)(self, window, delegate, columnOrRowNums, canSlide, viewportName, rightToLeftOrDownToTop)
    else
      self._impl = (VerticalGridFrameImpl.Create)(self, window, delegate, columnOrRowNums, canSlide, viewportName, rightToLeftOrDownToTop)
    end
  else
  end
  if isInverse then
    self._impl = (HorizontalGridFrameImpl.Create)(self, window, delegate, columnOrRowNums, canSlide, viewportName, rightToLeftOrDownToTop)
  end
end

GridFrame.Destroy = function(self)
  -- function num : 0_1
  (self._impl):Destroy()
end

GridFrame.ReloadAllCell = function(self)
  -- function num : 0_2
  (self._impl):ReloadAllCell()
end

GridFrame.InsertCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_3
  if isAnimate then
    (self._impl):InsertCellsAtIndex(indexList, isAnimate)
  else
    ;
    (self._impl):InsertCellsAtIndex(indexList, false)
  end
end

GridFrame.RemoveCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_4
  if isAnimate then
    (self._impl):RemoveCellsAtIndex(indexList, isAnimate)
  else
    ;
    (self._impl):RemoveCellsAtIndex(indexList, false)
  end
end

GridFrame.ReloadCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_5
  if isAnimate then
    (self._impl):ReloadCellsAtIndex(indexList, isAnimate)
  else
    ;
    (self._impl):ReloadCellsAtIndex(indexList, false)
  end
end

GridFrame.MoveToTop = function(self, isAnimate)
  -- function num : 0_6
  if isAnimate then
    (self._impl):MoveToTop(isAnimate)
  else
    ;
    (self._impl):MoveToTop(false)
  end
end

GridFrame.MoveToBottom = function(self, isAnimate)
  -- function num : 0_7
  if isAnimate then
    (self._impl):MoveToBottom(isAnimate)
  else
    ;
    (self._impl):MoveToBottom(false)
  end
end

GridFrame.MoveToLeft = function(self, isAnimate)
  -- function num : 0_8
  if isAnimate then
    (self._impl):MoveToLeft(isAnimate)
  else
    ;
    (self._impl):MoveToLeft(false)
  end
end

GridFrame.MoveToRight = function(self, isAnimate)
  -- function num : 0_9
  if isAnimate then
    (self._impl):MoveToRight(isAnimate)
  else
    ;
    (self._impl):MoveToRight(false)
  end
end

GridFrame.MoveTopToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_10
  if isAnimate then
    (self._impl):MoveTopToIndex(desIndex, isAnimate)
  else
    ;
    (self._impl):MoveTopToIndex(desIndex, false)
  end
end

GridFrame.MoveDownToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_11
  if isAnimate then
    (self._impl):MoveDownToIndex(desIndex, isAnimate)
  else
    ;
    (self._impl):MoveDownToIndex(desIndex, false)
  end
end

GridFrame.MoveLeftToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_12
  if isAnimate then
    (self._impl):MoveLeftToIndex(desIndex, isAnimate)
  else
    ;
    (self._impl):MoveLeftToIndex(desIndex, false)
  end
end

GridFrame.MoveRightToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_13
  if isAnimate then
    (self._impl):MoveRightToIndex(desIndex, isAnimate)
  else
    ;
    (self._impl):MoveRightToIndex(desIndex, false)
  end
end

GridFrame.MoveToAssignedPos = function(self, pos, isAnimate)
  -- function num : 0_14
  if isAnimate then
    (self._impl):MoveToAssignedPos(pos, isAnimate)
  else
    ;
    (self._impl):MoveToAssignedPos(pos, false)
  end
end

GridFrame.FireEvent = function(self, eventName, ...)
  -- function num : 0_15
  (self._impl):FireEvent(eventName, ...)
end

GridFrame.FireIndexCellEvent = function(self, eventName, index, ...)
  -- function num : 0_16
  (self._impl):FireIndexCellEvent(eventName, index, ...)
end

GridFrame.SetSlide = function(self, slide, showSoftMask)
  -- function num : 0_17
  (self._impl):SetSlide(slide, showSoftMask)
end

GridFrame.SetMargin = function(self, oneValue, twoValue)
  -- function num : 0_18
  (self._impl):SetMargin(oneValue, twoValue)
end

GridFrame.GetTotalLength = function(self)
  -- function num : 0_19
  return (self._impl):GetTotalLength()
end

GridFrame.SendMessageToInstance = function(self, name, args)
  -- function num : 0_20
  (self._impl):SendMessageToInstance(name, args)
end

GridFrame.GetLogicCell = function(self, i)
  -- function num : 0_21
  return ((self._impl)._logicCells)[i]
end

GridFrame.GetCellDialog = function(self, logicCell)
  -- function num : 0_22
  (self._impl):GetCellDialog(logicCell)
end

GridFrame.GetCurrentPosition = function(self)
  -- function num : 0_23
  return (self._impl):GetCurrentPosition()
end

GridFrame.RefreshUIParticleClipper = function(self)
  -- function num : 0_24
  return (self._impl):RefreshUIParticleClipper()
end

GridFrame.SetSoftMaskActive = function(self, showSoftMask)
  -- function num : 0_25
  (self._impl):SetSoftMaskActive(showSoftMask)
end

return GridFrame

