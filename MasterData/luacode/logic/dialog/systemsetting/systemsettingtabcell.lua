local TableFrame = require("framework.ui.frame.table.tableframe")
local SystemSettingTabCell = class("SystemSettingTabCell", Dialog)
SystemSettingTabCell.AssetBundleName = "ui/layouts.setting"
SystemSettingTabCell.AssetName = "SettingSystemCanvas"
local LIVE2D_RES_NAME = "live2d"

function SystemSettingTabCell:Ctor(...)
  SystemSettingTabCell.super.Ctor(self, ...)
end

function SystemSettingTabCell:OnCreate()
  self._scrollbar = self:GetChild("Frame/Scrollbar")
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  LuaNotificationCenter.AddObserver(self, self.OnNewOverlayFSMounted, Common.n_NewOverlayFSMounted, nil)
  self:RefreshTabCell()
end

function SystemSettingTabCell:OnDestroy()
  self._frame:Destroy()
end

function SystemSettingTabCell:RefreshTabCell()
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function SystemSettingTabCell:OnCurPosChange(frame, proportion)
  local width, height = self._panel:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollbar:SetScrollSize(height / total)
    self._scrollbar:SetScrollValue(1 - proportion)
  else
    self._scrollbar:SetScrollSize(1)
    self._scrollbar:SetScrollValue(proportion)
  end
end

function SystemSettingTabCell:NumberOfCell(frame)
  return 9
end

function SystemSettingTabCell:CellAtIndex(frame, index)
  if index == 1 then
    return "systemsetting.fpscell"
  elseif index == 2 then
    return "systemsetting.uifitslidecell"
  elseif index == 3 then
    return "systemsetting.live2dcell"
  elseif index == 4 then
    return "systemsetting.movetypecell"
  elseif index == 5 then
    return "systemsetting.uishowcell"
  elseif index == 6 then
    return "systemsetting.chestcell"
  elseif index == 7 then
    return "systemsetting.autobattlecell"
  elseif index == 8 then
    return "systemsetting.buffshowcell"
  elseif index == 9 then
    return "systemsetting.rockercell"
  end
end

function SystemSettingTabCell:DataAtIndex(frame, index)
end

function SystemSettingTabCell:OnNewOverlayFSMounted(args)
  if args.userInfo == LIVE2D_RES_NAME then
    Live2DManager.SaveLocalSelected(1)
    self:RefreshTabCell()
    return
  end
end

return SystemSettingTabCell
