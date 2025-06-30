-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/cskinredpoints.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CSkinRedPoints = dataclass("CSkinRedPoints", require("framework.net.protocol"))
CSkinRedPoints.ProtocolType = 3642
CSkinRedPoints.MaxSize = 65535
CSkinRedPoints.looked = 0
CSkinRedPoints.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSkinRedPoints
  ((CSkinRedPoints.super).Ctor)(self, client)
end

CSkinRedPoints.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.looked) then
    return false
  end
  return true
end

CSkinRedPoints.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSkinRedPoints

