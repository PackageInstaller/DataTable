-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/crecoverspringspirit.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRecoverSpringSpirit = dataclass("CRecoverSpringSpirit", require("framework.net.protocol"))
CRecoverSpringSpirit.ProtocolType = 2583
CRecoverSpringSpirit.MaxSize = 65535
CRecoverSpringSpirit.itemId = 0
CRecoverSpringSpirit.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRecoverSpringSpirit
  ((CRecoverSpringSpirit.super).Ctor)(self, client)
end

CRecoverSpringSpirit.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemId) then
    return false
  end
  return true
end

CRecoverSpringSpirit.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecoverSpringSpirit

