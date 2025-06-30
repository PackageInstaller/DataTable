-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/yard/furniture.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local Furniture = dataclass("Furniture")
Furniture.key = 0
Furniture.itemId = 0
Furniture.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.point = ((require("protocols.bean.protocol.yard.point")).Create)()
end

Furniture.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.key) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemId) then
    return false
  end
  if not (self.point):Marshal(buffer) then
    return false
  end
  return true
end

Furniture.Unmarshal = function(self, buffer)
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
  if not (self.point):Unmarshal(buffer) then
    return false
  end
  return ret
end

return Furniture

