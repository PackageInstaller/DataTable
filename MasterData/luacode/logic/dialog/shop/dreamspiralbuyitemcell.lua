local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CSkin = BeanManager.GetTableByName("role.cskin")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local DreamSpiralBuyItemCell = class("DreamSpiralBuyItemCell", Dialog)
DreamSpiralBuyItemCell.AssetBundleName = "ui/layouts.baseshop"
DreamSpiralBuyItemCell.AssetName = "BattlePassBuyItemFrame"

function DreamSpiralBuyItemCell:Ctor(...)
  DreamSpiralBuyItemCell.super.Ctor(self, ...)
end

function DreamSpiralBuyItemCell:OnCreate()
  self._container = self:GetChild("ItemFrame")
  self._frame = GridFrame.Create(self._container, self, true, 4)
end

function DreamSpiralBuyItemCell:OnDestroy()
  self._frame:Destroy()
end

function DreamSpiralBuyItemCell:RefreshCell(data)
  self._data = data
  self._frame:ReloadAllCell()
end

function DreamSpiralBuyItemCell:NumberOfCell(frame)
  return #self._data
end

function DreamSpiralBuyItemCell:CellAtIndex(frame, index)
  return "shop.dreamspiralitemcell"
end

function DreamSpiralBuyItemCell:DataAtIndex(frame, index)
  return self._data[index]
end

return DreamSpiralBuyItemCell
