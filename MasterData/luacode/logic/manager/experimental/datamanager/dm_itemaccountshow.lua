local DM_ItemAccountShow = class("DM_ItemAccountShow")

function DM_ItemAccountShow:Ctor()
  self._itemAccountData = NekoData.Data.itemAccountData
  self._cacheItemAccountData = NekoData.Data.cacheItemAccountData
end

function DM_ItemAccountShow:Clear()
  while self._itemAccountData[#self._itemAccountData] do
    table.remove(self._itemAccountData, #self._itemAccountData)
  end
  while self._cacheItemAccountData[#self._cacheItemAccountData] do
    table.remove(self._cacheItemAccountData, #self._cacheItemAccountData)
  end
end

function DM_ItemAccountShow:AddShowDialogData(data)
  table.insert(self._itemAccountData, data)
  table.sort(self._itemAccountData, function(v1, v2)
    local x1 = v1.sort or 1
    local x2 = v2.sort or 1
    return x1 < x2
  end)
  NekoData.BehaviorManager.BM_ItemAccountShow:ShowAccountOrReward()
end

function DM_ItemAccountShow:CacheShowDialogData(value)
  table.insert(self._cacheItemAccountData, value)
end

return DM_ItemAccountShow
