-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ssendundecidedstate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendUndecidedState = dataclass("SSendUndecidedState", require("framework.net.protocol"))
SSendUndecidedState.ProtocolType = 2491
SSendUndecidedState.MaxSize = 65535
SSendUndecidedState.state = 0
SSendUndecidedState.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendUndecidedState
  ((SSendUndecidedState.super).Ctor)(self, client)
end

SSendUndecidedState.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.state) then
    return false
  end
  return true
end

SSendUndecidedState.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendUndecidedState

