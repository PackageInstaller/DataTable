-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/indefinitedaysignactivity/fourteendayssigntab.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local IndefiniteDaysSignTabHelper = require("logic.dialog.welfare.indefinitedaysignactivity.indefinitedayssigntabhelper")
local FourteenDaysSignTab = class("FourteenDaysSignTab", Dialog)
FourteenDaysSignTab.AssetBundleName = "ui/layouts.welfare"
FourteenDaysSignTab.AssetName = "WelfareMain14Day"
FourteenDaysSignTab.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FourteenDaysSignTab
  ((FourteenDaysSignTab.super).Ctor)(self, ...)
end

FourteenDaysSignTab.OnCreate = function(self)
  -- function num : 0_1 , upvalues : IndefiniteDaysSignTabHelper
  self._rootElement = self:GetRootWindow()
  self._indefiniteDaysSignTabHelper = (IndefiniteDaysSignTabHelper.Create)(self, self._rootElement, 5, true)
  self._downArrow = self:GetChild("Image")
  ;
  (self._downArrow):Subscribe_PointerClickEvent(self.OnDownArrowClick, self)
end

FourteenDaysSignTab.OnDestroy = function(self)
  -- function num : 0_2
  if self._indefiniteDaysSignTabHelper then
    (self._indefiniteDaysSignTabHelper):OnDestroy()
  end
end

FourteenDaysSignTab.RefreshTabCell = function(self, activityId, refresh, refreshByProtocol)
  -- function num : 0_3
  if self._indefiniteDaysSignTabHelper then
    (self._indefiniteDaysSignTabHelper):RefreshTabCell(self._delegate, activityId, refresh, refreshByProtocol)
  end
end

FourteenDaysSignTab.CellAtIndex = function(self, frame, index)
  -- function num : 0_4 , upvalues : _ENV
  if (self._indefiniteDaysSignTabHelper)._totalCellShow then
    local extraData = (string.split)((((self._indefiniteDaysSignTabHelper)._totalCellShow).reward)[index], ";")
    local iconKind = tonumber(extraData[2])
    if iconKind == -1 then
      return "welfare.indefinitedaysignactivity.fourteendayssigncell"
    else
      return "welfare.indefinitedaysignactivity.fourteendayssigncell2"
    end
  end
  do
    return "welfare.indefinitedaysignactivity.fourteendayssigncell"
  end
end

FourteenDaysSignTab.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_5
  if proportion <= 0.5 then
    (self._downArrow):SetActive(true)
  else
    ;
    (self._downArrow):SetActive(false)
  end
end

FourteenDaysSignTab.OnDownArrowClick = function(self)
  -- function num : 0_6
  ((self._indefiniteDaysSignTabHelper)._cellFrame):MoveToBottom()
  ;
  (self._downArrow):SetActive(false)
end

return FourteenDaysSignTab

