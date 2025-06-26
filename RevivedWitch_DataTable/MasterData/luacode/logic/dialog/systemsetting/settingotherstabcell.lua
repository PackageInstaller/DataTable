-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/settingotherstabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local SettingOthersTabCell = class("SettingOthersTabCell", Dialog)
SettingOthersTabCell.AssetBundleName = "ui/layouts.setting"
SettingOthersTabCell.AssetName = "SettingOthers"
SettingOthersTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SettingOthersTabCell
  ((SettingOthersTabCell.super).Ctor)(self, ...)
end

SettingOthersTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._scrollbar = self:GetChild("Frame/Scrollbar")
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self:RefreshTabCell()
end

SettingOthersTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

SettingOthersTabCell.RefreshTabCell = function(self)
  -- function num : 0_3
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

SettingOthersTabCell.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_4
  local width, height = (self._panel):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollbar):SetScrollSize(height / total)
    ;
    (self._scrollbar):SetScrollValue(1 - proportion)
  else
    ;
    (self._scrollbar):SetScrollSize(1)
    ;
    (self._scrollbar):SetScrollValue(proportion)
  end
end

SettingOthersTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return 2
end

SettingOthersTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  if index == 1 then
    return "systemsetting.identitycell"
  else
    if index == 2 then
      return "systemsetting.messagecell"
    end
  end
end

SettingOthersTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
end

return SettingOthersTabCell

