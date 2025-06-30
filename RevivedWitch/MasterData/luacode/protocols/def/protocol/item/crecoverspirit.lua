-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/crecoverspirit.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRecoverSpirit = dataclass("CRecoverSpirit", require("framework.net.protocol"))
CRecoverSpirit.ProtocolType = 1235
CRecoverSpirit.MaxSize = 65535
CRecoverSpirit.WaitProtocol = "protocol.notify.scancelloading"
CRecoverSpirit.itemId = 0
CRecoverSpirit.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRecoverSpirit
  ((CRecoverSpirit.super).Ctor)(self, client)
end

CRecoverSpirit.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemId) then
    return false
  end
  return true
end

CRecoverSpirit.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecoverSpirit

