-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/ssendassistroles.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendAssistRoles = dataclass("SSendAssistRoles", require("framework.net.protocol"))
SSendAssistRoles.ProtocolType = 1144
SSendAssistRoles.MaxSize = 65535
SSendAssistRoles.supportRole = 0
SSendAssistRoles.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendAssistRoles
  ((SSendAssistRoles.super).Ctor)(self, client)
  self.displayRole = {}
end

SSendAssistRoles.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.supportRole) then
    return false
  end
  local length = (table.slen)(self.displayRole)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.displayRole)[i]) then
      return false
    end
  end
  return true
end

SSendAssistRoles.Unmarshal = function(self, buffer)
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

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SSendAssistRoles

