local TableFrame = require("framework.ui.frame.table.tableframe")
local CAlchemyStageCfg = BeanManager.GetTableByName("courtyard.calchemystage")
local BottomToTop = 2
local AlchemyStageDialog = class("AlchemyStageDialog", Dialog)
AlchemyStageDialog.AssetBundleName = "ui/layouts.yard"
AlchemyStageDialog.AssetName = "AlchemyStage"

function AlchemyStageDialog:Ctor(...)
  AlchemyStageDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function AlchemyStageDialog:OnCreate()
  self._title = self:GetChild("Panel/Title")
  self._closeBtn = self:GetChild("Panel/CloseBtn")
  self._scrollBar = self:GetChild("Panel/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("Panel/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._width, self._height = self._panel:GetRectSize()
  self._title:SetText(TextManager.GetText(800111))
  self:Init()
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function AlchemyStageDialog:OnDestroy()
  self._frame:Destroy()
end

function AlchemyStageDialog:Init()
  self._data = {}
  local allIds = CAlchemyStageCfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CAlchemyStageCfg:GetRecorder(allIds[i])
    table.insert(self._data, recorder)
  end
  table.remove(self._data, 1)
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function AlchemyStageDialog:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function AlchemyStageDialog:NumberOfCell(frame)
  return #self._data
end

function AlchemyStageDialog:CellAtIndex(frame, index)
  return "alchemy.alchemystagecell"
end

function AlchemyStageDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function AlchemyStageDialog:OnBackBtnClicked()
  self:Destroy()
end

return AlchemyStageDialog
