-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cupdatefogareal.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUpdateFogAreal = dataclass("CUpdateFogAreal", require("framework.net.protocol"))
CUpdateFogAreal.ProtocolType = 1932
CUpdateFogAreal.MaxSize = 65535
CUpdateFogAreal.sceneId = 0
CUpdateFogAreal.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUpdateFogAreal
  ((CUpdateFogAreal.super).Ctor)(self, client)
  self.points = {}
  self.prePoints = {}
end

CUpdateFogAreal.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.sceneId) then
    return false
  end
  local length = (table.slen)(self.points)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, (self.points)[i]) then
      return false
    end
  end
  local length = (table.slen)(self.prePoints)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, (self.prePoints)[i]) then
      return false
    end
  end
  return true
end

CUpdateFogAreal.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R9 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CUpdateFogAreal

