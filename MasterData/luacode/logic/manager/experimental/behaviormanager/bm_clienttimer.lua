local BM_ClientTimer = class("BM_ClientTimer")

function BM_ClientTimer:Ctor()
  self._data = NekoData.Data.clientTimer
end

return BM_ClientTimer
