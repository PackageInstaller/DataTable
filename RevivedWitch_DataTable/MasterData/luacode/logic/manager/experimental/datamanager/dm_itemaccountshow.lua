-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_itemaccountshow.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_ItemAccountShow = class("DM_ItemAccountShow")
DM_ItemAccountShow.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._itemAccountData = (NekoData.Data).itemAccountData
  self._cacheItemAccountData = (NekoData.Data).cacheItemAccountData
end

DM_ItemAccountShow.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  while (self._itemAccountData)[#self._itemAccountData] do
    (table.remove)(self._itemAccountData, #self._itemAccountData)
  end
  while (self._cacheItemAccountData)[#self._cacheItemAccountData] do
    (table.remove)(self._cacheItemAccountData, #self._cacheItemAccountData)
  end
end

DM_ItemAccountShow.AddShowDialogData = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  (table.insert)(self._itemAccountData, data)
  ;
  (table.sort)(self._itemAccountData, function(v1, v2)
    -- function num : 0_2_0
    local x1 = v1.sort or 1
    local x2 = v2.sort or 1
    do return x1 < x2 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  ((NekoData.BehaviorManager).BM_ItemAccountShow):ShowAccountOrReward()
end

DM_ItemAccountShow.CacheShowDialogData = function(self, value)
  -- function num : 0_3 , upvalues : _ENV
  (table.insert)(self._cacheItemAccountData, value)
end

return DM_ItemAccountShow

