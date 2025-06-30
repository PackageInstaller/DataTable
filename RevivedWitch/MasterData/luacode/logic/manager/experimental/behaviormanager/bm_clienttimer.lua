-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_clienttimer.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_ClientTimer = class("BM_ClientTimer")
BM_ClientTimer.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).clientTimer
end

return BM_ClientTimer

