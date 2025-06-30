-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/caddtheme.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAddTheme = dataclass("CAddTheme", require("framework.net.protocol"))
CAddTheme.ProtocolType = 2361
CAddTheme.MaxSize = 65535
CAddTheme.name = ""
CAddTheme.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAddTheme
  ((CAddTheme.super).Ctor)(self, client)
  self.furniture = {}
end

CAddTheme.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.name) then
    return false
  end
  local length = (table.slen)(self.furniture)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.furniture)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

CAddTheme.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    (self.furniture)[i] = ((require("protocols.bean.protocol.yard.furnitureposition")).Create)()
    if not ((self.furniture)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return CAddTheme

