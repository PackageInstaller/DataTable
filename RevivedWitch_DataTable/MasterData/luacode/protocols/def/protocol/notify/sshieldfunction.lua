-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/notify/sshieldfunction.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SShieldFunction = dataclass("SShieldFunction", require("framework.net.protocol"))
SShieldFunction.ProtocolType = 1806
SShieldFunction.MaxSize = 65535
SShieldFunction.CHANGENAME = 1
SShieldFunction.NAMING = 2
SShieldFunction.CHANGEINTRODUCE = 3
SShieldFunction.HOLDPARTY = 4
SShieldFunction.CHANGEPARTYNAME = 5
SShieldFunction.CHANGEPARTYINTRODUCE = 6
SShieldFunction.ROLECOMMENT = 7
SShieldFunction.SEND_MESSAGE = 8
SShieldFunction.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SShieldFunction
  ((SShieldFunction.super).Ctor)(self, client)
  self.shieldFunction = {}
end

SShieldFunction.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.shieldFunction)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.shieldFunction)[i]) then
      return false
    end
  end
  return true
end

SShieldFunction.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SShieldFunction

