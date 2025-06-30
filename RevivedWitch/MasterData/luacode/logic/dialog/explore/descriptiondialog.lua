-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/explore/descriptiondialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CExploreAreaCfg = (BeanManager.GetTableByName)("courtyard.cexplorearea")
local CExploreLvUpCfg = (BeanManager.GetTableByName)("courtyard.cexplorelvup")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 3
local DescriptionDialog = class("DescriptionDialog", Dialog)
DescriptionDialog.AssetBundleName = "ui/layouts.yard"
DescriptionDialog.AssetName = "YardExploreDetail"
DescriptionDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DescriptionDialog
  ((DescriptionDialog.super).Ctor)(self, ...)
  self._dataList = {}
end

DescriptionDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame, _ENV
  self._refreshTimeTxt = self:GetChild("Panel/Txt")
  self._cellPanel = self:GetChild("Panel/Frame")
  self._scrollBar = self:GetChild("Panel/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._closeBtn = self:GetChild("Panel/CloseBtn")
  self._cellFrame = (TableFrame.Create)(self._cellPanel, self, true, true)
  self._width = (self._cellPanel):GetRectSize()
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
  ;
  (self:GetChild("Panel/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2084))
  ;
  (self:GetChild("Panel/Txt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2085))
end

DescriptionDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._cellFrame):Destroy()
end

DescriptionDialog.Init = function(self)
  -- function num : 0_3 , upvalues : CExploreLvUpCfg, _ENV, CExploreAreaCfg
  local record = CExploreLvUpCfg:GetRecorder(((NekoData.BehaviorManager).BM_Explore):GetLevel())
  local integer, decimal = (math.modf)(record.refreshRate / 60)
  local str = record.refreshRate / 60
  if decimal <= 0 then
    str = integer
  end
  ;
  (self._refreshTimeTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1320, {str, record.refreshTimes}))
  local allIds = CExploreAreaCfg:GetAllIds()
  local length = #allIds
  local map = {}
  for i = 1, length do
    local recorder = CExploreAreaCfg:GetRecorder(allIds[i])
    if not map[recorder.rarity] then
      map[recorder.rarity] = {}
    end
    ;
    (table.insert)(map[recorder.rarity], recorder)
  end
  local tempList = {}
  for k,v in pairs(map) do
    (table.insert)(tempList, {rarity = k, data = v})
  end
  ;
  (table.sort)(tempList, function(a, b)
    -- function num : 0_3_0
    do return b.rarity < a.rarity end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for _,v in ipairs(tempList) do
    for index,recorder in ipairs(v.data) do
      (table.insert)(self._dataList, {data = recorder})
    end
    ;
    (table.insert)(self._dataList, {data = nil})
  end
  ;
  (table.remove)(self._dataList, #self._dataList)
  ;
  (self._cellFrame):ReloadAllCell()
end

DescriptionDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

DescriptionDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_5
  local total = (self._cellFrame):GetTotalLength()
  if self._height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(self._height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

DescriptionDialog.NumberOfCell = function(self)
  -- function num : 0_6
  return #self._dataList
end

DescriptionDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if ((self._dataList)[index]).data then
    return "explore.descriptioncell"
  else
    return "explore.descriptionlinecell"
  end
end

DescriptionDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return ((self._dataList)[index]).data
end

return DescriptionDialog

