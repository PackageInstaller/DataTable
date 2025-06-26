-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossrushpaneldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BossRushPanelDialog = class("BossRushPanelDialog", Dialog)
BossRushPanelDialog.AssetBundleName = "ui/layouts.mainline"
BossRushPanelDialog.AssetName = "BossRushPanel"
local TableFrame = require("framework.ui.frame.table.tableframe")
BossRushPanelDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossRushPanelDialog
  ((BossRushPanelDialog.super).Ctor)(self, ...)
  self._groupName = "Singleton"
end

BossRushPanelDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._frame = self:GetChild("Frame")
  self._helper = (TableFrame.Create)(self._frame, self, false, true, false)
  local cbossrush = (BeanManager.GetTableByName)("dungeonselect.cbossrush")
  self._count = #cbossrush:GetAllIds()
  ;
  (self:GetChild("RankBtn")):Subscribe_PointerClickEvent(self.OnRankBtnClick, self)
end

BossRushPanelDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._helper):Destroy()
end

BossRushPanelDialog.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._data = clone(self._cellData)
  if self._data then
    local lastPos = (self._helper):GetCurrentPosition()
    ;
    (self._helper):ReloadAllCell()
    if lastPos then
      (self._helper):MoveToAssignedPos(lastPos)
    end
  end
end

BossRushPanelDialog.GetFloorDetail = function(self)
  -- function num : 0_4
  return self._current
end

BossRushPanelDialog.OnCellClick = function(self, id)
  -- function num : 0_5 , upvalues : _ENV
  self._current = id
  local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
  if dialog then
    dialog:SetCopyInfo("BossRush", id)
  end
end

BossRushPanelDialog.NumberOfCell = function(self, helper)
  -- function num : 0_6 , upvalues : _ENV
  return (math.min)(#self._data + 1, self._count)
end

BossRushPanelDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_7
  if index <= #self._data then
    return "mainline.bossrush.bossrushcell"
  else
    return "mainline.bossrush.bossrushlockcell"
  end
end

BossRushPanelDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_8
  return (self._data)[index]
end

BossRushPanelDialog.OnRankBtnClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("mainline.bossrush.bossrushrankdialog")
end

return BossRushPanelDialog

