-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/csendflowers.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CSendFlowers = dataclass("CSendFlowers", require("framework.net.protocol"))
CSendFlowers.ProtocolType = 2600
CSendFlowers.MaxSize = 65535
CSendFlowers.rewardType = 0
CSendFlowers.num = 0
CSendFlowers.LEFT = 1
CSendFlowers.RIGTH = 2
CSendFlowers.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSendFlowers
  ((CSendFlowers.super).Ctor)(self, client)
end

CSendFlowers.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.num) then
    return false
  end
  return true
end

CSendFlowers.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSendFlowers

