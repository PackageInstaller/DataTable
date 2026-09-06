local CExploreAreaCfg = BeanManager.GetTableByName("courtyard.cexplorearea")
local CExploreLvUpCfg = BeanManager.GetTableByName("courtyard.cexplorelvup")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 3
local DescriptionDialog = class("DescriptionDialog", Dialog)
DescriptionDialog.AssetBundleName = "ui/layouts.yard"
DescriptionDialog.AssetName = "YardExploreDetail"

function DescriptionDialog:Ctor(...)
  DescriptionDialog.super.Ctor(self, ...)
  self._dataList = {}
end

function DescriptionDialog:OnCreate()
  self._refreshTimeTxt = self:GetChild("Panel/Txt")
  self._cellPanel = self:GetChild("Panel/Frame")
  self._scrollBar = self:GetChild("Panel/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._closeBtn = self:GetChild("Panel/CloseBtn")
  self._cellFrame = TableFrame.Create(self._cellPanel, self, true, true)
  self._width, self._height = self._cellPanel:GetRectSize()
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
  self:GetChild("Panel/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2084))
  self:GetChild("Panel/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2085))
end

function DescriptionDialog:OnDestroy()
  self._cellFrame:Destroy()
end

function DescriptionDialog:Init()
  local record = CExploreLvUpCfg:GetRecorder(NekoData.BehaviorManager.BM_Explore:GetLevel())
  local integer, decimal = math.modf(record.refreshRate / 60)
  local str = record.refreshRate / 60
  if decimal <= 0.0 then
    str = integer
  end
  self._refreshTimeTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1320, {
    str,
    record.refreshTimes
  }))
  local allIds = CExploreAreaCfg:GetAllIds()
  local length = #allIds
  local map = {}
  for i = 1, length do
    local recorder = CExploreAreaCfg:GetRecorder(allIds[i])
    if not map[recorder.rarity] then
      map[recorder.rarity] = {}
    end
    table.insert(map[recorder.rarity], recorder)
  end
  local tempList = {}
  for k, v in pairs(map) do
    table.insert(tempList, {rarity = k, data = v})
  end
  table.sort(tempList, function(a, b)
    return a.rarity > b.rarity
  end)
  for _, v in ipairs(tempList) do
    for index, recorder in ipairs(v.data) do
      table.insert(self._dataList, {data = recorder})
    end
    table.insert(self._dataList, {data = nil})
  end
  table.remove(self._dataList, #self._dataList)
  self._cellFrame:ReloadAllCell()
end

function DescriptionDialog:OnBackBtnClicked()
  self:Destroy()
end

function DescriptionDialog:OnCurPosChange(frame, proportion)
  local total = self._cellFrame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function DescriptionDialog:NumberOfCell()
  return #self._dataList
end

function DescriptionDialog:CellAtIndex(frame, index)
  if self._dataList[index].data then
    return "explore.descriptioncell"
  else
    return "explore.descriptionlinecell"
  end
end

function DescriptionDialog:DataAtIndex(frame, index)
  return self._dataList[index].data
end

return DescriptionDialog
