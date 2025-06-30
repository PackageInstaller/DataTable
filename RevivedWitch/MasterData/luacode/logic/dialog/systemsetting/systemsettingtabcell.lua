-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/systemsettingtabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local SystemSettingTabCell = class("SystemSettingTabCell", Dialog)
SystemSettingTabCell.AssetBundleName = "ui/layouts.setting"
SystemSettingTabCell.AssetName = "SettingSystemCanvas"
local LIVE2D_RES_NAME = "live2d"
SystemSettingTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SystemSettingTabCell
  ((SystemSettingTabCell.super).Ctor)(self, ...)
end

SystemSettingTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._scrollbar = self:GetChild("Frame/Scrollbar")
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNewOverlayFSMounted, Common.n_NewOverlayFSMounted, nil)
  self:RefreshTabCell()
end

SystemSettingTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

SystemSettingTabCell.RefreshTabCell = function(self)
  -- function num : 0_3
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

SystemSettingTabCell.OnCurPosChange = function(self, frame, proportion)
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

SystemSettingTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return 9
end

SystemSettingTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  if index == 1 then
    return "systemsetting.fpscell"
  else
    if index == 2 then
      return "systemsetting.uifitslidecell"
    else
      if index == 3 then
        return "systemsetting.live2dcell"
      else
        if index == 4 then
          return "systemsetting.movetypecell"
        else
          if index == 5 then
            return "systemsetting.uishowcell"
          else
            if index == 6 then
              return "systemsetting.chestcell"
            else
              if index == 7 then
                return "systemsetting.autobattlecell"
              else
                if index == 8 then
                  return "systemsetting.buffshowcell"
                else
                  if index == 9 then
                    return "systemsetting.rockercell"
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

SystemSettingTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
end

SystemSettingTabCell.OnNewOverlayFSMounted = function(self, args)
  -- function num : 0_8 , upvalues : LIVE2D_RES_NAME, _ENV
  if args.userInfo == LIVE2D_RES_NAME then
    (Live2DManager.SaveLocalSelected)(1)
    self:RefreshTabCell()
    return 
  end
end

return SystemSettingTabCell

