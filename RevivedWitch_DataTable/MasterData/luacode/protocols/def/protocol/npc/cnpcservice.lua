-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/npc/cnpcservice.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CNpcService = dataclass("CNpcService", require("framework.net.protocol"))
CNpcService.ProtocolType = 2003
CNpcService.MaxSize = 65535
CNpcService.npcId = 0
CNpcService.serviceId = 0
CNpcService.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CNpcService
  ((CNpcService.super).Ctor)(self, client)
end

CNpcService.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.npcId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.serviceId) then
    return false
  end
  return true
end

CNpcService.Unmarshal = function(self, buffer)
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

return CNpcService

