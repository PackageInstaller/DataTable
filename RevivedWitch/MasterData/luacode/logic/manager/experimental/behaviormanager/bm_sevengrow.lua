-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_sevengrow.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SSevenDaysOpenDef = (LuaNetManager.GetProtocolDef)("protocol.activity.ssevendaysopen")
local BM_SevenGrow = class("BM_SevenGrow")
BM_SevenGrow.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._sevengrow = (NekoData.Data).sevengrow
end

BM_SevenGrow.GetInitialRemainTime = function(self)
  -- function num : 0_1
  return (self._sevengrow).initialRemainTime
end

BM_SevenGrow.GetStartTime = function(self)
  -- function num : 0_2
  return (self._sevengrow).startTime
end

BM_SevenGrow.GetRemainTime = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return self:GetInitialRemainTime() - ((ServerGameTimer.GetServerTimeForecast)() - self:GetStartTime())
end

BM_SevenGrow.GetSevenDaysIsOpen = function(self)
  -- function num : 0_4
  return (self._sevengrow).sevenDaysIsOpen
end

BM_SevenGrow.GetVersion = function(self)
  -- function num : 0_5
  return (self._sevengrow).version
end

BM_SevenGrow.GetVersionIsNew = function(self)
  -- function num : 0_6 , upvalues : SSevenDaysOpenDef
  do return (self._sevengrow).version == SSevenDaysOpenDef.NEW_VERSION end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return BM_SevenGrow

