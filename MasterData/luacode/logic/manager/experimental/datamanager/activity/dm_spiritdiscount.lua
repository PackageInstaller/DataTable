local DM_SpiritDiscount = class("DM_SpiritDiscount")

function DM_SpiritDiscount:Ctor()
  self._data = NekoData.Data.activities.spiritdiscount
end

function DM_SpiritDiscount:Clear()
  NekoData.Data.activities.spiritdiscount = {}
end

function DM_SpiritDiscount:OnSReduceCostActInfo(protocol)
  self._data.discount = protocol.discount
  self._data.range = string.split(protocol.floorList, ",")
  for k, v in pairs(self._data.range) do
    self._data.range[k] = tonumber(v)
  end
end

return DM_SpiritDiscount
