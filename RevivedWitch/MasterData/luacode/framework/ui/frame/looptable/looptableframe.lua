-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/frame/looptable/looptableframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LoopHorizontalTableFrameImpl = require("framework.ui.frame.looptable.loophorizontaltableframeimpl")
local LoopTableFrame = class("LoopTableFrame")
LoopTableFrame.Ctor = function(self, window, delegate, isVertical, canSlide, isInverse, autoAlign, loop, useSoftMask)
  -- function num : 0_0 , upvalues : LoopHorizontalTableFrameImpl
  if not canSlide and canSlide ~= false then
    canSlide = true
  end
  local viewportName = "Viewport"
  if useSoftMask then
    viewportName = "ViewportSoftMask"
  end
  if isVertical and isInverse then
    if isInverse then
      self._impl = (LoopHorizontalTableFrameImpl.Create)(self, window, delegate, canSlide, autoAlign, loop, viewportName)
    end
  end
end

LoopTableFrame.Destroy = function(self)
  -- function num : 0_1
  (self._impl):Destroy()
end

LoopTableFrame.ReloadAllCell = function(self)
  -- function num : 0_2
  (self._impl):ReloadAllCell()
end

LoopTableFrame.ReloadCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_3
  if isAnimate then
    (self._impl):ReloadCellsAtIndex(indexList, isAnimate)
  else
    ;
    (self._impl):ReloadCellsAtIndex(indexList, false)
  end
end

LoopTableFrame.RemoveCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_4
end

LoopTableFrame.InsertCellsAtIndex = function(self, indexList, isAnimate)
  -- function num : 0_5
end

LoopTableFrame.MoveToRight = function(self, isAnimate)
  -- function num : 0_6
  if isAnimate then
    (self._impl):MoveToRight(isAnimate)
  else
    ;
    (self._impl):MoveToRight(false)
  end
end

LoopTableFrame.MoveToLeft = function(self, isAnimate)
  -- function num : 0_7
  if isAnimate then
    (self._impl):MoveToLeft(isAnimate)
  else
    ;
    (self._impl):MoveToLeft(false)
  end
end

LoopTableFrame.MoveLeftToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_8
  if isAnimate then
    (self._impl):MoveLeftToIndex(desIndex, isAnimate)
  else
    ;
    (self._impl):MoveLeftToIndex(desIndex, false)
  end
end

LoopTableFrame.MoveRightToIndex = function(self, desIndex, isAnimate)
  -- function num : 0_9
  if isAnimate then
    (self._impl):MoveRightToIndex(desIndex, isAnimate)
  else
    ;
    (self._impl):MoveRightToIndex(desIndex, false)
  end
end

LoopTableFrame.GetLeftIndex = function(self)
  -- function num : 0_10
  return (self._impl):GetLeftIndex()
end

LoopTableFrame.GetRightIndex = function(self)
  -- function num : 0_11
  return (self._impl):GetRightIndex()
end

LoopTableFrame.GetTotalLength = function(self)
  -- function num : 0_12
  return (self._impl):GetTotalLength()
end

LoopTableFrame.SetMargin = function(self, oneValue, twoValue)
  -- function num : 0_13
  (self._impl):SetMargin(oneValue, twoValue)
end

LoopTableFrame.FireEvent = function(self, eventName, ...)
  -- function num : 0_14
  (self._impl):FireEvent(eventName, ...)
end

LoopTableFrame.SetSlide = function(self, slide, showSoftMask)
  -- function num : 0_15
  (self._impl):SetSlide(slide, showSoftMask)
end

LoopTableFrame.RefreshUIParticleClipper = function(self)
  -- function num : 0_16
  return (self._impl):RefreshUIParticleClipper()
end

LoopTableFrame.SetSoftMaskActive = function(self, showSoftMask)
  -- function num : 0_17
  (self._impl):SetSoftMaskActive(showSoftMask)
end

return LoopTableFrame

