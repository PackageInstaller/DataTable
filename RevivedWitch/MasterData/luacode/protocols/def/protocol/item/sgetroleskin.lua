-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/sgetroleskin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetRoleSkin = dataclass("SGetRoleSkin", require("framework.net.protocol"))
SGetRoleSkin.ProtocolType = 1250
SGetRoleSkin.MaxSize = 65535
SGetRoleSkin.roleId = 0
SGetRoleSkin.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetRoleSkin
  ((SGetRoleSkin.super).Ctor)(self, client)
  self.skins = {}
end

SGetRoleSkin.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.skins)) then
    return false
  end
  for key,value in pairs(self.skins) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
    if not value:Marshal(R9_PC26) then
      return false
    end
  end
  return true
end

SGetRoleSkin.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC39: Overwrote pending register: R5 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.skins)[key] = value
  end
  return ret
end

return SGetRoleSkin

