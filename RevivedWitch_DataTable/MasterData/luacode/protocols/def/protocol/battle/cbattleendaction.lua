-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cbattleendaction.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CBattleEndAction = dataclass("CBattleEndAction", require("framework.net.protocol"))
CBattleEndAction.ProtocolType = 1944
CBattleEndAction.MaxSize = 65535
CBattleEndAction.battleid = 0
CBattleEndAction.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBattleEndAction
  ((CBattleEndAction.super).Ctor)(self, client)
end

CBattleEndAction.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battleid) then
    return false
  end
  return true
end

CBattleEndAction.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBattleEndAction

