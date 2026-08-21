-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/login/buffstate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local BuffState = dataclass("BuffState")
BuffState.BUFF_TOUCH = 0
BuffState.BUFF_UNTOUCH = 1
BuffState.Ctor = function(self)
  -- function num : 0_0
end

BuffState.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

BuffState.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return BuffState

