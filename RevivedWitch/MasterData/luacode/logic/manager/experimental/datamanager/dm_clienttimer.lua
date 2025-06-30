-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_clienttimer.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_ClientTimer = class("DM_ClientTimer")
DM_ClientTimer.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).clientTimer
  self:Clear()
end

DM_ClientTimer.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._timerDic then
    for _,v in pairs(self._timerDic) do
      (ServerGameTimer.RemoveTask)(v)
    end
  else
    do
      self._timerDic = {}
    end
  end
end

DM_ClientTimer.OnSCLientTimer = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  local timerID = protocol.timeId
  local time = protocol.time
  if (self._timerDic)[timerID] then
    (ServerGameTimer.RemoveTask)((self._timerDic)[timerID])
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._timerDic)[timerID] = (ServerGameTimer.AddTask)(time // 1000, 0, function()
    -- function num : 0_2_0 , upvalues : _ENV, timerID
    local cprotocol = (LuaNetManager.CreateProtocol)("protocol.activity.cclienttimer")
    if cprotocol then
      cprotocol.timeId = timerID
      cprotocol:Send()
    end
  end
, nil)
end

return DM_ClientTimer

