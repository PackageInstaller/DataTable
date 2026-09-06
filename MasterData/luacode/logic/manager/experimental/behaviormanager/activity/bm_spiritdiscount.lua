local BM_SpiritDiscount = class("BM_SpiritDiscount")

function BM_SpiritDiscount:Ctor()
  self._data = NekoData.Data.activities.spiritdiscount
end

function BM_SpiritDiscount:Clear()
end

function BM_SpiritDiscount:GetDiscount()
  return self._data.discount
end

function BM_SpiritDiscount:GetRange()
  return self._data.range
end

return BM_SpiritDiscount
