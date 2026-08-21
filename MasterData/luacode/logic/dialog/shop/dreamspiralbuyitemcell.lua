-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/dreamspiralbuyitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local DreamSpiralBuyItemCell = class("DreamSpiralBuyItemCell", Dialog)
DreamSpiralBuyItemCell.AssetBundleName = "ui/layouts.baseshop"
DreamSpiralBuyItemCell.AssetName = "BattlePassBuyItemFrame"
DreamSpiralBuyItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DreamSpiralBuyItemCell
  ((DreamSpiralBuyItemCell.super).Ctor)(self, ...)
end

DreamSpiralBuyItemCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._container = self:GetChild("ItemFrame")
  self._frame = (GridFrame.Create)(self._container, self, true, 4)
end

DreamSpiralBuyItemCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

DreamSpiralBuyItemCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._data = data
  ;
  (self._frame):ReloadAllCell()
end

DreamSpiralBuyItemCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

DreamSpiralBuyItemCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "shop.dreamspiralitemcell"
end

DreamSpiralBuyItemCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

return DreamSpiralBuyItemCell

