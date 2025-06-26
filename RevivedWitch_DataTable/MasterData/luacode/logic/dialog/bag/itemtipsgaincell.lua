-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/itemtipsgaincell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTipsGainCell = class("ItemTipsGainCell", Dialog)
ItemTipsGainCell.AssetBundleName = "ui/layouts.bag"
ItemTipsGainCell.AssetName = "ItemTipsNewGet"
ItemTipsGainCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemTipsGainCell
  ((ItemTipsGainCell.super).Ctor)(self, ...)
  self._dataList = {}
  self._dataMap = {}
  self._init = true
end

ItemTipsGainCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._cellPanel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._cellPanel, self, true, false, true)
  self._cellPanelWidth = (self._cellPanel):GetRectSize()
  self._rootWindwoWidth = (self:GetRootWindow()):GetRectSize()
  self._anchorY = (self:GetRootWindow()):GetHeight()
  self._size_x = (self:GetRootWindow()):GetSize()
  self._posAnchorY = (self:GetRootWindow()):GetYPosition()
end

ItemTipsGainCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

ItemTipsGainCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  if self._init then
    self._init = false
    for i,v in ipairs(data.value) do
      (table.insert)(self._dataList, {data = v, isType = v.type})
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self._dataMap)[v.type] = false
    end
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

    if #self._dataList == 1 and ((self._dataList)[1]).isType ~= (DataCommon.GainTypeEnum).Special and ((self._dataList)[1]).isType ~= (DataCommon.GainTypeEnum).Lover then
      (self._dataMap)[((self._dataList)[1]).isType] = true
      ;
      (table.insert)(self._dataList, {data = ((self._dataList)[1]).data, isWays = true})
    end
  end
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
  local totalLength = (self._frame):GetTotalLength()
  ;
  (self:GetRootWindow()):SetHeight(self._anchorY, self._offsetY + totalLength)
end

ItemTipsGainCell.ShowGainWays = function(self, type)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (self._dataMap)[type] = not (self._dataMap)[type]
  if (self._dataMap)[type] then
    local index = nil
    for i,v in ipairs(self._dataList) do
      if (v.data).type == type then
        index = i
        break
      end
    end
    do
      do
        ;
        (table.insert)(self._dataList, index + 1, {data = ((self._dataList)[index]).data, isWays = true})
        ;
        (self._frame):InsertCellsAtIndex({index + 1})
        local index = nil
        for i,v in ipairs(self._dataList) do
          if (v.data).type == type and v.isWays then
            index = i
            break
          end
        end
        do
          do
            ;
            (table.remove)(self._dataList, index)
            ;
            (self._frame):RemoveCellsAtIndex({index})
            ;
            (self._frame):FireEvent("RefreshOperateBtn")
            local totalLength = (self._frame):GetTotalLength()
            ;
            (self:GetRootWindow()):SetHeight(self._anchorY, self._offsetY + totalLength)
            ;
            (self._delegate):ReloadGainCell((self._cellData).tag)
          end
        end
      end
    end
  end
end

ItemTipsGainCell.ShouldLengthChange = function(self)
  -- function num : 0_5
  return true
end

ItemTipsGainCell.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._dataList
end

ItemTipsGainCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_7 , upvalues : _ENV
  if ((self._dataList)[index]).isType then
    if ((self._dataList)[index]).isType == (DataCommon.GainTypeEnum).Special or ((self._dataList)[index]).isType == (DataCommon.GainTypeEnum).Lover then
      return "bag.itemtipsgaintypespecialcell"
    else
      return "bag.itemtipsgaintypecell"
    end
  else
    return "bag.itemtipsgainwayscell"
  end
end

ItemTipsGainCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return ((self._dataList)[index]).data
end

return ItemTipsGainCell

