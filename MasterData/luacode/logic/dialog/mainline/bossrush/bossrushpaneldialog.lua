local BossRushPanelDialog = class("BossRushPanelDialog", Dialog)
BossRushPanelDialog.AssetBundleName = "ui/layouts.mainline"
BossRushPanelDialog.AssetName = "BossRushPanel"
local TableFrame = require("framework.ui.frame.table.tableframe")

function BossRushPanelDialog:Ctor(...)
  BossRushPanelDialog.super.Ctor(self, ...)
  self._groupName = "Singleton"
end

function BossRushPanelDialog:OnCreate()
  self._frame = self:GetChild("Frame")
  self._helper = TableFrame.Create(self._frame, self, false, true, false)
  local cbossrush = BeanManager.GetTableByName("dungeonselect.cbossrush")
  self._count = #cbossrush:GetAllIds()
  self:GetChild("RankBtn"):Subscribe_PointerClickEvent(self.OnRankBtnClick, self)
end

function BossRushPanelDialog:OnDestroy()
  self._helper:Destroy()
end

function BossRushPanelDialog:RefreshCell()
  self._data = clone(self._cellData)
  if self._data then
    local lastPos = self._helper:GetCurrentPosition()
    self._helper:ReloadAllCell()
    if lastPos then
      self._helper:MoveToAssignedPos(lastPos)
    end
  end
end

function BossRushPanelDialog:GetFloorDetail()
  return self._current
end

function BossRushPanelDialog:OnCellClick(id)
  self._current = id
  local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditprewardialog")
  if dialog then
    dialog:SetCopyInfo("BossRush", id)
  end
end

function BossRushPanelDialog:NumberOfCell(helper)
  return math.min(#self._data + 1, self._count)
end

function BossRushPanelDialog:CellAtIndex(helper, index)
  if index <= #self._data then
    return "mainline.bossrush.bossrushcell"
  else
    return "mainline.bossrush.bossrushlockcell"
  end
end

function BossRushPanelDialog:DataAtIndex(helper, index)
  return self._data[index]
end

function BossRushPanelDialog:OnRankBtnClick()
  DialogManager.CreateSingletonDialog("mainline.bossrush.bossrushrankdialog")
end

return BossRushPanelDialog
